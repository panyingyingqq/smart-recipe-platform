export interface User {
  id: string;
  email: string;
  username: string;
  avatar_url?: string;
  created_at: string;
}

export interface Recipe {
  id: string;
  author_id: string;
  name: string;
  name_en: string;
  description: string;
  difficulty: string | number; // Changed to support text like "简单" or numbers
  prep_time: number; // minutes
  cook_time: number | string; // minutes or string description
  total_time: number; // minutes
  servings: number;
  calories_per_serving: number | string; // Changed to support text
  protein_per_serving: number;
  fat_per_serving: number;
  carbs_per_serving: number;
  ingredients: RecipeIngredient[];
  steps: RecipeStep[];
  images: string[];
  cover_image: string;
  tags: string[];
  category: string;
  cuisine: string;
  rating: number;
  view_count: number;
  is_public: boolean;
  created_at: string;
  updated_at: string;
}

export interface RecipeIngredient {
  ingredient_id?: string; // Made optional
  name?: string; // Added for denormalized name
  ingredient?: Ingredient; // Joined data
  amount: number | string; // Changed to support text
  unit?: string; // Made optional
  notes?: string;
  hint?: string; // Added hint
  order?: number; // order index
}

export interface RecipeStep {
  step_number: number;
  instruction: string;
  instruction_en?: string;
  image_url?: string;
  duration?: number;
  tips?: string;
}

export interface Ingredient {
  id: string;
  name: string;
  name_en: string;
  category: string;
  subcategory?: string;
  description: string;
  origin?: string;
  storage_method: string;
  shelf_life?: number;
  nutrition_per_100g: {
    calories: number;
    protein: number;
    fat: number;
    carbs: number;
    fiber?: number;
    vitamins?: Record<string, number>;
  };
  image_url: string;
  thumbnail_url: string;
  related_recipes: string[]; // recipe_ids
  pairings: string[];
  tags: string[];
  season?: string[];
  allergens?: string[];
  created_at: string;
  updated_at: string;
}
