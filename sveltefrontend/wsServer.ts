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
		const success = server.upgrade(req, { data: { group : "sdc" } });
		return success
		  ? undefined
		  : new Response("WebSocket upgrade error", { status: 400 });
	  }
  
	  return new Response("Hello world");
	},
	websocket: {
		message(ws, message) {
			const group = ws.data.group;
			redis.set(`state:${group}`, message);
		},
		open(ws) {
			const group = ws.data.group;
			ws.subscribe(`state:${group}`);
			redis.subscribe(`__keyspace@0__:state:${group}`, (err, count) => {
				if (err) {
					console.error("Error subscribing to keyspace event", err);
				} else {
					console.log(`Subscribed to ${count} channels`);
				}
			});
			redis.on("message", (channel, message) => {
				console.log("message in redis: channel", channel, "message", message);
				redis.get(`state:${group}`, (err, reply) => {
					if (err) {
						console.error("Error getting progress state", err);
					} else {
						ws.send(reply);
					}
				});
			});
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