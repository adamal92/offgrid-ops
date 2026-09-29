// apps/edge-server/db.ts
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";

// connection pool
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export const db = drizzle(pool);
