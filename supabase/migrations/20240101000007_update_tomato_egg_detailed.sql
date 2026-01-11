-- Update Tomato Scrambled Eggs with detailed tutorial

DO $$
DECLARE
  recipe_id UUID;
  egg_id UUID;
  tomato_id UUID;
  oil_id UUID;
  salt_id UUID;
  sugar_id UUID;
  scallion_id UUID;
BEGIN
  -- Get Recipe ID
  SELECT id INTO recipe_id FROM recipes WHERE name = '西红柿炒鸡蛋';

  -- Ensure Ingredients Exist and Get IDs
  -- Egg
  SELECT id INTO egg_id FROM ingredients WHERE name = '鸡蛋';
  IF egg_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('鸡蛋', 'Egg', '蛋类', '冷藏', 'https://images.unsplash.com/photo-1587486913049-53fc88980cfc?auto=format&fit=crop&w=200&q=80') RETURNING id INTO egg_id;
  END IF;

  -- Tomato
  SELECT id INTO tomato_id FROM ingredients WHERE name = '西红柿';
  IF tomato_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('西红柿', 'Tomato', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=200&q=80') RETURNING id INTO tomato_id;
  END IF;

  -- Oil
  SELECT id INTO oil_id FROM ingredients WHERE name = '食用油';
  IF oil_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('食用油', 'Cooking Oil', '调味品', '常温', 'https://images.unsplash.com/photo-1474979266404-7cadd259c308?auto=format&fit=crop&w=200&q=80') RETURNING id INTO oil_id;
  END IF;

  -- Salt
  SELECT id INTO salt_id FROM ingredients WHERE name = '食盐';
  IF salt_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('食盐', 'Salt', '调味品', '常温', 'https://images.unsplash.com/photo-1518110925495-5fe265fb2054?auto=format&fit=crop&w=200&q=80') RETURNING id INTO salt_id;
  END IF;

  -- Sugar
  SELECT id INTO sugar_id FROM ingredients WHERE name = '白糖';
  IF sugar_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('白糖', 'Sugar', '调味品', '常温', 'https://images.unsplash.com/photo-1581441363689-1f3c3c414635?auto=format&fit=crop&w=200&q=80') RETURNING id INTO sugar_id;
  END IF;
  
  -- Scallion (Optional garnish)
  SELECT id INTO scallion_id FROM ingredients WHERE name = '葱花';
  IF scallion_id IS NULL THEN
    INSERT INTO ingredients (name, name_en, category, storage_method, image_url) VALUES ('葱花', 'Scallion', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1615485925600-97237c4fc1ec?auto=format&fit=crop&w=200&q=80') RETURNING id INTO scallion_id;
  END IF;

  -- Clear existing relationships
  DELETE FROM recipe_ingredients WHERE recipe_id = recipe_id;
  DELETE FROM recipe_steps WHERE recipe_id = recipe_id;

  -- Insert Recipe Ingredients
  INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount, unit, order_index) VALUES
  (recipe_id, egg_id, 3, '个', 1),
  (recipe_id, tomato_id, 2, '个', 2),
  (recipe_id, oil_id, 15, 'ml', 3),
  (recipe_id, salt_id, 2, 'g', 4),
  (recipe_id, sugar_id, 3, 'g', 5),
  (recipe_id, scallion_id, 5, 'g', 6);

  -- Insert Recipe Steps
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (recipe_id, 1, '第一步：处理食材。将鸡蛋打入碗中，加入 1g 盐，搅打均匀备用。西红柿顶部划十字，用热水烫 30 秒后去皮，切成小块。', '去皮后的西红柿口感更好，如果不介意皮也可以省略去皮步骤。', 5),
  (recipe_id, 2, '第二步：炒鸡蛋。热锅倒入 10ml 食用油，中火加热至 6 成热，倒入蛋液，待蛋液刚凝固时迅速翻炒至松散，盛出备用。', '鸡蛋不要炒太久，刚凝固即可盛出，保持嫩滑。', 3),
  (recipe_id, 3, '第三步：炒西红柿。锅中再加入 5ml 食用油，中火加热，倒入西红柿翻炒 1–2 分钟，炒至出汁后加入白糖调味。', '炒出汁是关键，如果西红柿较硬可以加少许水。', 3),
  (recipe_id, 4, '第四步：混合与出锅。将鸡蛋倒回锅中，与西红柿翻炒均匀，加入剩余食盐调味，翻炒 30 秒后撒上葱花即可出锅。', '最后混合时间不宜过长，以免鸡蛋变老。', 2);

END $$;
