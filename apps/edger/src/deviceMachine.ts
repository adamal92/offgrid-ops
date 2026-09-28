// deviceMachine.ts
import { createMachine } from "xstate";

const deviceMachine = createMachine({
  id: "device",
  initial: "idle",
  states: {
    idle: {
      on: {
        CONNECT: "connecting"
      }
    },
    connecting: {
      entry: "startConnection",
      on: {
        SUCCESS: "connected",
        FAILURE: "error"
      }
    },
    connected: {
      entry: "onConnected",
      on: {
        DISCONNECT: "disconnecting",
        ERROR: "error"
      }
    },
    disconnecting: {
      entry: "stopConnection",
      on: {
        SUCCESS: "idle",
        FAILURE: "error"
      }
    },
    error: {
      entry: "handleError",
      on: {
        RETRY: "connecting",
        RESET: "idle"
      }
    }
  }
}, {
  actions: {
    startConnection: (ctx, evt) => {
      console.log("Attempting to connect device...");
    },
    onConnected: (ctx, evt) => {
      console.log("Device connected successfully.");
    },
    stopConnection: (ctx, evt) => {
      console.log("Disconnecting device...");
    },
    handleError: (ctx, evt) => {
      console.error("Device error:", evt);
    }
  }
});

export default deviceMachine;