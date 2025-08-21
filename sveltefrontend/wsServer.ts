import { Redis } from "ioredis";
const redis = new Redis({
	host: "rediscontainer",
	port: 6379,
});

console.log("before bun serve");
Bun.serve({
	port: 3001,
	fetch(req, server) {
	  // upgrade the request to a WebSocket
	  //if (server.upgrade(req)) {
		//return; // do not return a Response
	  //}
	  //return new Response("Upgrade failed", { status: 500 });
	  console.log("req.url", req.url);
	  const url = new URL(req.url);
	  if (url.pathname === "/ws") {
		console.log(`upgrade!`);
		const success = server.upgrade(req);
		return success
		  ? undefined
		  : new Response("WebSocket upgrade error", { status: 400 });
	  }
  
	  return new Response("Hello world");
	},
	websocket: {
		message(ws, message) {
			console.log("message", message);
			ws.send("Hello from websocket server");
		},
		open(ws) {
			console.log("open websocket");
			ws.send("From wsServer.ts: open websocket");
		},
		close(ws, code, message) {
			console.log("close websocket");
			ws.send("From wsServer.ts: close websocket");
		},
		drain(ws) {
			console.log("drain websocket");
			ws.send("From wsServer.ts: drain websocket");
		}
	}
});