
-- Add calories and cooking_time columns
ALTER TABLE recipes ADD COLUMN IF NOT EXISTS calories text;
ALTER TABLE recipes ADD COLUMN IF NOT EXISTS cooking_time text;

-- Modify difficulty to text
-- First drop the check constraint if it exists
DO $$ 
BEGIN 
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'recipes_difficulty_check') THEN 
        ALTER TABLE recipes DROP CONSTRAINT recipes_difficulty_check; 
    END IF; 
END $$;

-- Then change the type
ALTER TABLE recipes ALTER COLUMN difficulty TYPE text USING difficulty::text;
