/-
Copyright (c) 2026 Adam Livne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Adam Livne
-/

import Mathlib.Data.Set.Basic


/-! Extensionality -/

set_option trace.Meta.synthInstance true

-- axiom Extensionality := { A: Set, B: Set } : a = b ↔ ∀a∈A(a∈B) ∧ ∀b∈B(b∈A)

-- Axiom for extensionality of sets containing elements of type α
axiom set_extensionality {α : Type} (A B : Set α) :
  A = B ↔ (∀ a ∈ A, a ∈ B) ∧ (∀ b ∈ B, b ∈ A)

axiom set_extensionality' {α : Type} (A B : Set α) :
  A = B ↔ ∀ x, x ∈ A ↔ x ∈ B

-- Set.ext_iff

-- Regularity
-- axiom reg { α : Type } (X : Set α) :
--   ∀x ∈ X ,

-- Specification
axiom spec {α β : Type} (A B : Set α) (P : Prop) :
  ∃A ⊆ B, (∀a ∈ A, P)
  -- ∃A ⊆ B, P

-- Pairing
axiom pairing {α : Type} (A B : Set α) :
  ∃(X : Set (Set α)), A ∈ X ∧ B ∈ X

-- Union
-- axiom reg { α : Type } (X : Set Set α) :

-- Replacement
-- Infinity
-- PowerSet
axiom pow {α : Type} (A B : Set α) (P : Set (Set α)) :
  ∃B, A ⊆ B ↔ A ∈ P

-- Choice
