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
			ws.send("Hello from websocket server");
			console.log("message", message);
		}, // a message is received
		open(ws) {
			console.log("open websocket");
		}, // a socket is opened
		close(ws, code, message) {
			console.log("close websocket");
		}, // a socket is closed
		drain(ws) {
			console.log("drain websocket");
		}, // the socket is ready to receive more data
	  },
  });