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