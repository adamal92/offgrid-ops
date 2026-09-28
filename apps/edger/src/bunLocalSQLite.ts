import { Database } from "bun:sqlite";
const db = new Database("edge_state.sqlite");
db.run("CREATE TABLE IF NOT EXISTS active_nodes (id TEXT PRIMARY KEY, last_ping INTEGER)");