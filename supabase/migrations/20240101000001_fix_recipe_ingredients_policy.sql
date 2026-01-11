
-- Enable RLS
ALTER TABLE recipe_ingredients ENABLE ROW LEVEL SECURITY;

-- Grant access to anon and authenticated
GRANT SELECT ON recipe_ingredients TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON recipe_ingredients TO anon, authenticated;

-- Create policy for reading
CREATE POLICY "Enable read access for all users" ON recipe_ingredients
    FOR SELECT USING (true);

-- Create policy for inserting/updating (since we are using anon key for scripts)
CREATE POLICY "Enable insert for all users" ON recipe_ingredients
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update for all users" ON recipe_ingredients
    FOR UPDATE USING (true);
