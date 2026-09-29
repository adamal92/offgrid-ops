import * as tf from "@tensorflow/tfjs";
import * as dfd from "danfojs-node";

// Danfo DataFrame
const df = new dfd.DataFrame([[1, 2], [3, 4]], { columns: ["A", "B"] });

// Convert to TensorFlow.js tensor
const tensor = df.tensor;

// Run GPU-accelerated op
const squared = tf.square(tensor);
squared.print();
