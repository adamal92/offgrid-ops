/// <reference lib="webworker" />
// 
// Workers receive messages via self.onmessage
(<DedicatedWorkerGlobalScope>globalThis).onmessage = (event: MessageEvent<{ points: Array<[number, number]> }>) => {
  const { points } = event.data;

  // Heavy computation (e.g., spatial index build / pathfinding)
  const result = points.map(([x, y]) => x * y + Math.sqrt(x ** 2 + y ** 2));

  // Send result back to the main thread
  globalThis.postMessage({ status: 'complete', result });
};