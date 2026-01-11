-- Allow authenticated users to create new ingredients
CREATE POLICY "Authenticated users can create ingredients" ON ingredients FOR INSERT WITH CHECK (true);
