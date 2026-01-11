
-- Add name column to recipe_ingredients to allow denormalized storage
ALTER TABLE recipe_ingredients ADD COLUMN IF NOT EXISTS name text;

-- Change amount to text to support values like "500g", "1 spoon", "少许"
ALTER TABLE recipe_ingredients ALTER COLUMN amount TYPE text USING amount::text;

-- Make unit optional since it might be included in amount text
ALTER TABLE recipe_ingredients ALTER COLUMN unit DROP NOT NULL;

-- Make ingredient_id optional since we might store name directly
ALTER TABLE recipe_ingredients ALTER COLUMN ingredient_id DROP NOT NULL;
