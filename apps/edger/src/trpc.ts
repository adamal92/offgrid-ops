// server.ts (Bun + Hono + tRPC + Zod)
import { Hono } from "hono";
import { initTRPC } from "@trpc/server";
import { z } from "zod";
import { trpcServer } from "@hono/trpc-server";
// Effector store
import { appState, fetchAICompletion, setAppState } from "./store.bun.js";
import { Effect } from "effect";

// Initialize tRPC
const t = initTRPC.create();

// Define procedures
const appRouter = t.router({
  getState: t.procedure.query(() => appState.getState()),
  setState: t.procedure
    .input(z.object({ status: z.string() }))
    .mutation(({ input }) => {
      setAppState(input.status);
      return { ok: true };
    }),
  fetchAI: t.procedure
    .input(z.object({ prompt: z.string() }))
    .mutation(async ({ input }) => {
      // Wrap in Effect.js for robust error handling
      const program = Effect.tryPromise({
        try: () => fetchAICompletion(input.prompt),
        catch: (err) => new Error("AI failed: " + (err as unknown & Error)?.message),
      });
      return await Effect.runPromise(program);
    }),
});

// Hono app
const app = new Hono();

// Mount tRPC router
app.use("/trpc/*", async (c, next) => {
  // tRPC adapter for Hono
  return await trpcServer({ router: appRouter });
});

export default app;
export type AppRouter = typeof appRouter;