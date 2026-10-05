/-
Copyright (c) 2026 Adam Livne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Adam Livne
-/

import Mathlib.Data.Set.Basic

set_option trace.Meta.synthInstance true

/-! Set Theory Basic Definitions -/

open Set

-- variable {α : Type}

-- theorem set_union_m {α : Type} (A B : Set α) :
--   (A ∪ B ↔ (∀x ∈ A, x ∈ B ∨ ∀b ∈ B, b ∈ A)) := by decide

-- Using correct binder syntax before the colon
theorem set_union_m {α : Type} (A B : Set α) :
  (A ∪ B = {x | x ∈ A ∨ x ∈ B}) := by
  rfl

theorem set_union_mem_iff {α : Type} (A B : Set α) (x : α) :
  (x ∈ A ∪ B ↔ x ∈ A ∨ x ∈ B) := by
  rfl

theorem set_sub_m {α : Type} (A B : Set α) :
  (A ⊆ B ↔ ∀ x : α, x ∈ A → x ∈ B) := by
  rfl

theorem set_sub_m_set {α : Type} (A B : Set α) (x : α) :
  (x ∈ {y : α | y ∈ A → y ∈ B} ↔ (x ∈ A → x ∈ B)) := by
  rfl

-- theorem set_sub_m {α : Type} (A B : Set α) :
--   (A ⊆ B = {x | x ∈ A → x ∈ B}) := by decide

-- theorem set_sub_m {α : Type} (A B : Set α) :
--   (A ⊆ B ↔ ∀x ∈ A, x ∈ B) := by decide
