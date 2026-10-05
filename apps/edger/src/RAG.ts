import { Database } from "bun:sqlite";
import * as sqliteVec from "sqlite-vec";
import { pipeline } from "@huggingface/transformers";
import { readdirSync } from "fs";
import { join } from "path";

// 1. Setup Database
const db = new Database("sop_knowledge.db");
sqliteVec.load(db);
db.run("CREATE TABLE IF NOT EXISTS chunks (id TEXT PRIMARY KEY, filepath TEXT, content TEXT)");
db.run("CREATE VIRTUAL TABLE IF NOT EXISTS vec_chunks USING vec0(id TEXT PRIMARY KEY, embedding float)");

// 2. Load Local Embedding Model (~90MB)
console.log("Loading embedding extractor...");
const extractor = await pipeline("feature-extraction", "Xenova/all-MiniLM-L6-v2");

async function getEmbedding(text: string): Promise<Float32Array> {
  const output = await extractor(text, { pooling: 'mean', normalize: true });
  return new Float32Array(output.data);
}

// 3. Scan & Ingest a Local Directory of Markdown SOPs
async function ingestMarkdownDirectory(dirPath: string) {
  const files = readdirSync(dirPath).filter(f => f.endsWith('.md'));
  
  for (const file of files) {
    const filePath = join(dirPath, file);
    const text = await Bun.file(filePath).text();
    
    // Simple Chunker: Split by sections or paragraphs (e.g., double newlines)
    const paragraphs = text.split("\n\n").filter(p => p.trim().length > 20);
    
    for (let i = 0; i < paragraphs.length; i++) {
      const chunkId = `${file}_chunk_${i}`;
      const chunkText = paragraphs[i].trim();
      const embedding = await getEmbedding(chunkText);
      
      db.prepare("INSERT OR REPLACE INTO chunks (id, filepath, content) VALUES (?, ?, ?)").run(chunkId, filePath, chunkText);
      db.prepare("INSERT OR REPLACE INTO vec_chunks (id, embedding) VALUES (?, vec_f32(?))").run(chunkId, embedding);
    }
  }
  console.log("Ingestion of SOPs complete.");
}

// 4. Retrieve Context & Query the Local LLM (Ollama)
async function askLocalLLM(question: string) {
  // A. Get query embedding
  const queryVector = await getEmbedding(question);
  
  // B. Query SQLite for top matching context chunks
  const matches = db.prepare(`
    SELECT c.content FROM vec_chunks v
    JOIN chunks c ON v.id = c.id
    WHERE v.embedding MATCH ? AND k = 2
    ORDER BY distance ASC
  `).all(queryVector) as { content: string }[];
  
  const contextText = matches.map(m => m.content).join("\n\n");
  
  // C. Build Prompt Grounded in Medical/SOP Data
  const systemPrompt = `You are a medical assistant running offline on a secure field kit. 
Answer the user's question using ONLY the provided verified context. If the answer cannot be found in the context, say "Information not found in local SOPs."

Context:
${contextText}`;

  console.log("\nSending prompt to local Ollama instance...");
  
  // D. Call local Ollama API
  const response = await fetch("http://localhost:11434/api/generate", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      model: "llama3.2:3b", // Or "qwen2.5:3b"
      prompt: question,
      system: systemPrompt,
      stream: false
    })
  });
  
  const result = await response.json();
  return result.response;
}

// Execution flow
const sopsFolder = "./my-sops"; // Put your medical/SOP markdown files here
await ingestMarkdownDirectory(sopsFolder);

const answer = await askLocalLLM("What is the protocol for emergency wound treatment?");
console.log("\n--- ANSWER --- \n", answer);
