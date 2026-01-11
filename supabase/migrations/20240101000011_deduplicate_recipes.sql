-- Deduplicate recipes based on name, keeping the one with the most steps

DO $$
DECLARE
  dup_rec RECORD;
  best_id UUID;
BEGIN
  -- Iterate over recipe names that appear more than once
  FOR dup_rec IN 
    SELECT name
    FROM recipes 
    GROUP BY name 
    HAVING COUNT(*) > 1
  LOOP
    -- Find the ID of the recipe with the most steps for this name
    -- We use an alias 'inner_r' for the inner query to avoid confusion
    SELECT inner_r.id INTO best_id
    FROM recipes inner_r
    LEFT JOIN recipe_steps rs ON inner_r.id = rs.recipe_id
    WHERE inner_r.name = dup_rec.name
    GROUP BY inner_r.id
    ORDER BY COUNT(rs.id) DESC, inner_r.created_at DESC -- Tie-breaker: most recent
    LIMIT 1;

    -- Delete all OTHER recipes with this name
    DELETE FROM recipes 
    WHERE name = dup_rec.name 
    AND id != best_id;
    
    RAISE NOTICE 'Deduplicated %: Kept %', dup_rec.name, best_id;
  END LOOP;
END $$;
