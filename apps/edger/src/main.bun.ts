const server = Bun.serve({
  port: process.env.PORT ? parseInt(process.env.PORT) : 3000,
  fetch(req) {
    const url = new URL(req.url);
    if (url.pathname === '/') {
      return new Response('Hello from Bun Server inside Nx!');
    }
    return new Response('404 Not Found', { status: 404 });
  },
});

console.log(`🚀 Bun server running at http://localhost:${server.port}`);

const messageWorker = () => {
  return new Promise((resolve) => {
    // Instantiate Bun worker natively
    const worker = new Worker(new URL('./workers/rand.worker.ts', import.meta.url).href);

    worker.postMessage({ points: [] });

    worker.onmessage = (event) => {
      worker.terminate(); // Free worker thread
      resolve("");
    };

    worker.onerror = (error) => {
      worker.terminate();
      resolve({ error: error.message });
    };
  });
};