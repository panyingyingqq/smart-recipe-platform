import { create } from 'zustand';
import { Recipe } from '../types';

interface RecipeState {
  isOpen: boolean;
  selectedRecipe: Recipe | null;
  openRecipe: (recipe: Recipe) => void;
  closeRecipe: () => void;
}

export const useRecipeStore = create<RecipeState>((set) => ({
  isOpen: false,
  selectedRecipe: null,
  openRecipe: (recipe) => set({ isOpen: true, selectedRecipe: recipe }),
  closeRecipe: () => set({ isOpen: false, selectedRecipe: null }),
}));
