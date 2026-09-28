// Effector store
import { createStore, createEvent, createEffect } from "effector";
import { Effect, Console } from "effect";
import { createActor } from "xstate";
import deviceMachine from "./deviceMachine.js"; // XState FSM
 
const fetchAICompletion = async (mock: string): Promise<object> => ({});

// Effector events
export const deviceEvent = createEvent<unknown>();
export const aiResponseFx = createEffect(async (prompt: string) => {
  // Wrap in Effect.js for robust error handling
  const program = Effect.tryPromise({
    try: () => fetchAICompletion(prompt),
    catch: (err) => new Error("AI failed: " + (err as unknown & Error)?.message),
  });
  return await Effect.runPromise(program);
});

// Effector store
export const appState = createStore({ status: "idle", data: null })
  .on(deviceEvent, (state, evt) => ({ ...state, device: evt }))
  .on(aiResponseFx.doneData, (state, data) => ({ ...state, ai: data }));

// XState integration
const actor = createActor(deviceMachine);
actor.subscribe((snapshot) => {
  deviceEvent(snapshot.value); // push FSM state into Effector
});

actor.start();
