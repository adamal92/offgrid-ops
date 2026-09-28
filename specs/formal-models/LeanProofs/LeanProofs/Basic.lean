/-
Copyright (c) 2026 Adam Livne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Adam Livne
-/

import Mathlib

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
  linarith [h5]

example {a b : ℝ} (h1 : a ^ 2 = b ^ 2 + 1) (h2 : a ≥ 0) : a ≥ 1 := by
  have h3 :=
  calc
    a ^ 2 = b ^ 2 + 1 := by rw [h1]
    _ ≥ 1 := by nlinarith
    _ = 1 ^ 2 := by ring
  nlinarith
