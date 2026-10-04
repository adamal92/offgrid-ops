/-
Copyright (c) 2026 Adam Livne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Adam Livne
-/

import Mathlib
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Sym.Sym2

-- import tactic

-- def hello := "world"

/-! ...jjjjjjjjjjjjjjjjjj -/

example {m n : ℤ} (h1 : m + 3 ≤ 2 * n - 1) (h2 : n ≤ 5) : m ≤ 6 := by
  have h3 :=
  calc
    m + 3 ≤ 2 * n - 1 := by rel [h1]
    _ ≤ 2 * 5 - 1 := by rel [h2]
    _ = 9 := by ring
  linarith [h3]

example {t : ℝ} (h1 : t ^ 2 = 3 * t) (h2 : t ≥ 1) : t ≥ 2 := by
  have h3 :=
  calc t * t = t ^ 2 := by ring
    _ = 3 * t := by rw [h1]
  have h4 : t ≠ 0 := by linarith
  have h5 : t = 3 := by
    field_simp [h4] at h3
    linarith [h3]
  -- apply?
  linarith [h5]

example {a b : ℝ} (h1 : a ^ 2 = b ^ 2 + 1) (h2 : a ≥ 0) : a ≥ 1 := by
  have h3 :=
  calc
    a ^ 2 = b ^ 2 + 1 := by rw [h1]
    _ ≥ 1 := by nlinarith
    _ = 1 ^ 2 := by ring
  nlinarith

-- -------------------------

-- def Σ := { x: $α$ | False }
-- def s_{0} := ∅
-- def S :=
-- def FSM := { Σ, S, s0, δ, F } -- {\displaystyle (\Sigma ,S,s_{0},\delta ,F)}

-- A formal definition of a deterministic finite state machine (FSM)
-- structure FSM (State Symbol : Type) :=
-- (states        : finset State)                -- finite set of states
-- (alphabet      : finset Symbol)               -- finite set of input symbols
-- (initial       : State)                       -- initial state
-- (finals        : finset State)                -- set of accepting states
-- (transition    : State → Symbol → State)      -- transition function
-- (initial_in    : initial ∈ states)            -- well-formedness: initial ∈ states
-- (finals_in     : finals ⊆ states)             -- well-formedness: finals ⊆ states

-- import Mathlib.Data.Finset.Basic

-- -- Formal definition of a deterministic finite state machine (FSM)
-- structure FSM (State Symbol : Type) where
--   states     : Finset State                -- finite set of states
--   alphabet   : Finset Symbol               -- finite set of input symbols
--   initial    : State                       -- initial state
--   finals     : Finset State                -- set of accepting states
--   transition : State → Symbol → State      -- transition function
--   initial_in : initial ∈ states            -- well-formedness: initial ∈ states
--   finals_in  : finals ⊆ states             -- well-formedness: finals ⊆ states

-- inductive MyState | q0 | q1
-- open MyState

-- inductive Symbol | a | b
-- open Symbol

-- def myFSM : FSM MyState Symbol :=
-- { states     := {q0, q1},
--   alphabet   := {a, b},
--   initial    := q0,
--   finals     := {q1},
--   transition := λ s sym,
--     match s, sym with
--     | q0, a := q1
--     | q0, b := q0
--     | q1, a := q1
--     | q1, b := q0
--     end,
--   initial_in := by simp,
--   finals_in  := by simp }

-- -- import Mathlib.Data.Finset.Basic

-- -- Formal definition of a graph
-- structure Graph (Vertex : Type) where
--   vertices : Finset Vertex                     -- finite set of vertices
--   edges    : Finset (Vertex × Vertex)          -- finite set of edges
--   edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices

-- -- Formal definition of a directed graph
-- -- structure Digraph (Vertex : Type) where
-- --   vertices : Finset Vertex                     -- finite set of vertices
-- --   edges    : Finset (Vertex × Vertex)          -- finite set of directed edges
-- --   edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices

-- -- import Mathlib.Data.Finset.Basic

-- -- Formal definition of a unidirected graph (directed graph)
-- -- structure UnidirectedGraph (Vertex : Type) where
-- --   vertices : Finset Vertex                     -- finite set of vertices
-- --   edges    : Finset (Vertex × Vertex)          -- finite set of ordered edges
-- --   edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices

-- structure UnidirectedGraph = Graph

-- inductive V | A | B
-- open V

-- def exampleGraph : Digraph V where
--   vertices := {A, B}
--   edges    := {(A, B)}
--   edges_valid := by
--     intros u v h
--     simp at h
--     cases h
--     simp

-- inductive V | A | B | C
-- open V

-- def exampleUnidirected : UnidirectedGraph V where
--   vertices := {A, B, C}
--   edges    := {(A, B), (B, C)}   -- A → B, B → C
--   edges_valid := by
--     intros u v h
--     simp at h
--     cases h <;> simp

-- import Mathlib.Data.Finset.Basic

-- Directed (unidirected) graph: edges are ordered pairs
-- structure DirectedGraph (Vertex : Type) where
--   vertices : Finset Vertex
--   edges    : Finset (Vertex × Vertex)          -- ordered pairs
--   edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices

-- -- Undirected graph: edges are unordered pairs, enforced by symmetry
-- structure UndirectedGraph (Vertex : Type) where
--   vertices : Finset Vertex
--   edges    : Finset (Vertex × Vertex)          -- still stored as pairs
--   edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices
--   symmetric   : ∀ {u v : Vertex}, (u, v) ∈ edges → (v, u) ∈ edges

-- inductive V | A | B | C
-- open V

-- def exampleDirected : DirectedGraph V where
--   vertices := {A, B, C}
--   edges    := {(A, B), (B, C)}   -- A → B, B → C
--   edges_valid := by
--     intros u v h
--     simp at h
--     cases h <;> simp

-- def exampleUndirected : UndirectedGraph V where
--   vertices := {A, B}
--   edges    := {(A, B), (B, A)}   -- A—B (symmetric)
--   edges_valid := by
--     intros u v h
--     simp at h
--     cases h <;> simp
--   symmetric := by
--     intros u v h
--     simp at h
--     cases h <;> simp

-- import Mathlib.Data.Finset.Basic

-- Directed graph: edges are ordered pairs
structure DirectedGraph (Vertex : Type) where
  vertices : Finset Vertex
  edges    : Finset (Vertex × Vertex)
  edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices

-- Undirected graph: edges are unordered pairs, enforced by symmetry
structure UndirectedGraph (Vertex : Type) where
  vertices : Finset Vertex
  edges    : Finset (Vertex × Vertex)
  edges_valid : ∀ (u v : Vertex), (u, v) ∈ edges → u ∈ vertices ∧ v ∈ vertices
  symmetric   : ∀ {u v : Vertex}, (u, v) ∈ edges → (v, u) ∈ edges

-- Example vertex type
inductive V | A | B | C
deriving DecidableEq   -- Lean needs this to compare vertices

open V

-- Example directed graph
def exampleDirected : DirectedGraph V where
  vertices := {A, B, C}      -- works because of `deriving DecidableEq`
  edges    := {(A, B), (B, C)}
  edges_valid := by
    intros u v h
    simp only [Finset.mem_insert, Finset.mem_singleton] at h
    -- h is now either (u,v) = (A,B) or (u,v) = (B,C)
    rcases h with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · constructor
      · exact Finset.mem_insert_self A {B, C}
      · exact Finset.mem_insert_of_mem (Finset.mem_insert_self B {C})
    · constructor
      · exact Finset.mem_insert_of_mem (Finset.mem_insert_self B {C})
      · exact Finset.mem_insert_of_mem (Finset.mem_insert_of_mem (Finset.mem_insert_self C ∅))

-- Example undirected graph
-- def exampleUndirected : UndirectedGraph V where
--   vertices := {A, B}
--   edges    := {(A, B), (B, A)}
--   edges_valid := by
--     intros u v h
--     simp at h
--     cases h <;> simp
--   symmetric := by
--     intros u v h
--     simp at h
--     cases h <;> simp


-- Example: triangle graph A—B—C—A
-- def triangleGraph : UndirectedGraph V where
--   vertices := {A, B, C}
--   edges    := {Sym2.mk A B, Sym2.mk B C, Sym2.mk C A}
--   edges_valid := by
--     intros e h v hv
--     simp only [Finset.mem_insert, Finset.mem_singleton] at h
--     rcases h with rfl | rfl | rfl
--     · -- edge A—B
--       simp [Sym2.mem_mk] at hv
--       rcases hv with rfl | rfl <;> simp
--     · -- edge B—C
--       simp [Sym2.mem_mk] at hv
--       rcases hv with rfl | rfl <;> simp
--     · -- edge C—A
--       simp [Sym2.mem_mk] at hv
--       rcases hv with rfl | rfl <;> simp

-- ---------------------

-- import Mathlib.Data.Finset.Basic

open scoped Finset

-- Define a simple Directed Graph structure
structure FiniteGraph (VType : Type) [DecidableEq VType] where
  vertices : Finset VType
  edges    : Finset (VType × VType)
  -- A safety constraint: every edge's start and end point must be in the vertices set
  edges_valid : edges ⊆ vertices ×ˢ vertices

-- Example Instantiation:
def myVertices : Finset Nat := {1, 2, 3}
def myEdges : Finset (Nat × Nat) := {(1, 2), (2, 3)}

-- We must prove that myEdges ⊆ myVertices ×ˢ myVertices to build the graph
lemma myEdges_are_valid : myEdges ⊆ myVertices ×ˢ myVertices := by
  -- Lean can solve this finite check automatically using the 'decide' tactic
  decide

-- Assemble the graph
def myGraph : FiniteGraph Nat := {
  vertices := myVertices
  edges := myEdges
  edges_valid := myEdges_are_valid
}

def exampleTriangleGraph : FiniteGraph Nat := {
  vertices := {1, 2, 3}
  edges := {(1, 2), (2, 3), (3, 1)}
  edges_valid := by decide
}

#check (1, 2) ∈ exampleTriangleGraph.edges
#eval (1, 2) ∈ exampleTriangleGraph.edges
#check (1, 2) ∉ exampleTriangleGraph.edges
#eval (1, 2) ∉ exampleTriangleGraph.edges
#check (4, 2) ∈ exampleTriangleGraph.edges
#eval (4, 2) ∈ exampleTriangleGraph.edges
#check 1 = 1
#eval 1 = 1
-- Check if (1, 2) is a valid edge in our graph
def isEdgeElement : Bool := (1, 2) ∈ myGraph.edges -- Returns true
#eval isEdgeElement

variable (a b c : Finset ℕ)
variable (n : ℕ)

#check a ∩ b
#check a ∪ b
#check a \ b
-- #check (∅ : Finset ℕ)

#eval 2 ∈ exampleTriangleGraph.vertices
#eval exampleTriangleGraph.vertices.card
#eval exampleTriangleGraph.vertices.powerset.card
#eval exampleTriangleGraph.vertices.powerset
#eval ((∅ : Finset Nat), ({∅} : Finset (Finset Nat)))
#eval ()

#eval exampleTriangleGraph.edges.powerset.card

