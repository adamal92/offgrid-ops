-- Zermelo–Fraenkel Set Theory with the Axiom of Choice (ZFC) in Lean 4
-- This file provides a formalization skeleton of the ZFC axioms.

opaque Set : Type

-- Membership relation
opaque mem : Set → Set → Prop
local infix:50 " ∈ " => mem

-- Subset relation definition
def Subset (A B : Set) : Prop := ∀ x, x ∈ A → x ∈ B
local infix:50 " ⊆ " => Subset

-- Equality of sets via Extensionality
axiom extensionality (A B : Set) : (A ⊆ B ∧ B ⊆ A) → A = B

-- Empty set existence
axiom empty_set_exists : ∃ E : Set, ∀ x, ¬(x ∈ E)

-- Pairing Axiom
axiom pairing (a b : Set) : ∃ P : Set, ∀ x, x ∈ P ↔ (x = a ∨ x = b)

-- Union Axiom
axiom union (F : Set) : ∃ U : Set, ∀ x, x ∈ U ↔ (∃ Y, Y ∈ F ∧ x ∈ Y)

-- Power Set Axiom
axiom power_set (A : Set) : ∃ P : Set, ∀ x, x ∈ P ↔ (x ⊆ A)

-- Separation (Specification) Schema
-- For every predicate P, we can separate elements
axiom separation (A : Set) (P : Set → Prop) : ∃ S : Set, ∀ x, x ∈ S ↔ (x ∈ A ∧ P x)

-- Infinity Axiom
-- There exists a set containing the empty set and closed under successor
def successor (x : Set) : Set := sorry -- Formally constructed via union and pairing
axiom infinity : ∃ I : Set, (∃ E : Set, E ∈ I ∧ (∀ x, ¬(x ∈ E))) ∧ (∀ x, x ∈ I → successor x ∈ I)

-- Replacement Schema
-- If F is a functional relation, the image of a set is a set
axiom replacement (A : Set) (F : Set → Set → Prop) (h : ∀ x ∈ A, ∀ y₁ y₂, F x y₁ → F x y₂ → y₁ = y₂) :
  ∃ B : Set, ∀ y, y ∈ B ↔ (∃ x ∈ A, F x y)

-- Regularity (Foundation) Axiom
axiom regularity (A : Set) : (∃ x, x ∈ A) → ∃ y ∈ A, ∀ z ∈ A, ¬(z ∈ y)

-- Axiom of Choice
axiom choice (C : Set) : (∀ x ∈ C, ∃ y, y ∈ x) → ∃ f : Set → Set, ∀ x ∈ C, f x ∈ x
