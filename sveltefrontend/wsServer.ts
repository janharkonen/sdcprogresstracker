import { Redis } from "ioredis";
import type { ServerWebSocket } from "bun";

interface WebSocketData {
	group: string;
	subscriber?: Redis;
}

const redis = new Redis({
	host: "rediscontainer",
	port: 6379,
});

Bun.serve({
	port: 3001,
	fetch(req, server) {
	  const url = new URL(req.url);
	  if (url.pathname === "/ws") {
		const success = server.upgrade(req, { data: { group : "sdc" } });
		return success
		  ? undefined
		  : new Response("WebSocket upgrade error", { status: 400 });
	  }

	  return new Response("Hello world");
	},
	websocket: {
		message(ws: ServerWebSocket<WebSocketData>, message) {
			const group = ws.data.group;
			try {
				redis.set(`state:${group}`, message);
			} catch (error) {
				console.error("From wsServer.ts / message(ws, message): Error setting progress state to redis", error);
			}
		},
		open(ws: ServerWebSocket<WebSocketData>) {
			const group = ws.data.group;
			
			// Create a separate Redis client for pub/sub
			const subscriber = new Redis({
				host: "rediscontainer",
				port: 6379,
			});
			
			// Enable keyspace notifications if not already enabled
			redis.config("SET", "notify-keyspace-events", "KEA").catch(err => {
				console.error("Failed to set keyspace notifications:", err);
			});
			
			// Subscribe to keyspace events for the specific key
			subscriber.subscribe(`__keyspace@0__:state:${group}`, (err, count) => {
				if (err) {
					console.error("From wsServer.ts / open(ws): Error subscribing to keyspace event", err);
				} else {
					console.log(`From wsServer.ts / open(ws): Subscribed to ${count} channels`);
				}
			});
			
			// Store the subscriber in ws.data for cleanup later
			ws.data.subscriber = subscriber;
			
			// Handle messages from Redis pub/sub
			subscriber.on("message", (channel, message) => {
				// Only fetch and send if the message indicates a SET operation
				if (message === "set") {
					redis.get(`state:${group}`).then((reply) => {
						if (reply !== null) {
							ws.send(reply);
						}
					}).catch(err => {
						console.error("Error getting updated state:", err);
					});
				}
			});
		},
		close(ws: ServerWebSocket<WebSocketData>, code, message) {
			if (ws.data.subscriber) {
				ws.data.subscriber.unsubscribe();
				ws.data.subscriber.quit();
			}
		},
	}
});