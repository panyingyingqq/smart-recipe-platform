
-- Enable RLS on all core tables (just to be safe)
ALTER TABLE recipes ENABLE ROW LEVEL SECURITY;
ALTER TABLE ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_steps ENABLE ROW LEVEL SECURITY;

-- Grant SELECT access to anon and authenticated roles
GRANT SELECT ON recipes TO anon, authenticated;
GRANT SELECT ON ingredients TO anon, authenticated;
GRANT SELECT ON recipe_ingredients TO anon, authenticated;
GRANT SELECT ON recipe_steps TO anon, authenticated;

-- Create (or replace) permissive SELECT policies
-- Note: We use DO blocks to avoid errors if policies already exist, or we can just drop and recreate.
-- For simplicity in this environment, we'll use "CREATE POLICY IF NOT EXISTS" logic via simple SQL or just drop first.

DROP POLICY IF EXISTS "Allow public read access" ON recipes;
CREATE POLICY "Allow public read access" ON recipes FOR SELECT USING (true);

DROP POLICY IF EXISTS "Allow public read access" ON ingredients;
CREATE POLICY "Allow public read access" ON ingredients FOR SELECT USING (true);

DROP POLICY IF EXISTS "Allow public read access" ON recipe_ingredients;
CREATE POLICY "Allow public read access" ON recipe_ingredients FOR SELECT USING (true);

DROP POLICY IF EXISTS "Allow public read access" ON recipe_steps;
CREATE POLICY "Allow public read access" ON recipe_steps FOR SELECT USING (true);
