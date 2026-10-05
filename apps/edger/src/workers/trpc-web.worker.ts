/// <reference lib="webworker" />
// Copyright (c) TaktiKIT. All rights reserved.

import { createTRPCUntypedClient, httpBatchLink } from "@trpc/client";

type WorkerRequest = {
	id: string | number;
	url: string;
	path: string;
	type: "query" | "mutation";
	input?: unknown;
};

type WorkerResponse =
	| { id: string | number; data: unknown }
	| { id: string | number; error: string };

self.onmessage = async (event: MessageEvent<WorkerRequest>) => {
	const request = event.data;

	try {
		const client = createTRPCUntypedClient({
			links: [httpBatchLink({ url: request.url })],
		});

		const data =
			request.type === "query"
				? await client.query(request.path, request.input)
				: await client.mutation(request.path, request.input);

		self.postMessage({ id: request.id, data } satisfies WorkerResponse);
	} catch (error) {
		self.postMessage({
			id: request.id,
			error: error instanceof Error ? error.message : String(error),
		} satisfies WorkerResponse);
	}
};
