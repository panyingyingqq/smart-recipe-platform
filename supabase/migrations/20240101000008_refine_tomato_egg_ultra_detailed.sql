-- Update Tomato Scrambled Eggs with ULTRA detailed tutorial

DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  -- Get Recipe ID
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '西红柿炒鸡蛋';

  -- Clear existing steps (we will re-insert them)
  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;

  -- Insert Recipe Steps with Ultra Detail
  -- Step 1
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：处理食材
1. 打蛋：将 3 个鸡蛋打入碗中，加入 1g 食盐和少许清水（约 1 汤匙，使蛋更嫩），用筷子顺时针快速搅打，直到蛋液表面出现丰富泡沫，蛋清蛋黄完全融合。
2. 切西红柿：西红柿洗净，顶部划十字。烧一锅开水，将西红柿放入烫 30 秒，取出撕去外皮（去皮口感更好）。将去皮后的西红柿切成橘子瓣大小的块。
3. 切葱：将小葱切成葱花备用。', '打蛋时加水是鸡蛋嫩滑的关键；西红柿去皮能让口感更绵密，不出皮渣。', 5);

  -- Step 2
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 2, '第二步：炒鸡蛋
1. 热锅：开大火将炒锅烧热，直至锅底微微冒烟。
2. 倒油：倒入 20ml 食用油（比平时炒菜稍多），晃动锅身润锅。
3. 下蛋液：保持大火，油热后迅速倒入蛋液。蛋液入锅应立即膨胀鼓起。
4. 翻炒：用铲子快速划散蛋液，翻炒约 30 秒。待蛋液大部分凝固但仍保持嫩黄色时，立刻关火盛出备用。', '这一步火候必须是大火，油温要高，这样炒出的鸡蛋才蓬松鲜嫩。切记不要炒老了，刚凝固即可。', 2);

  -- Step 3
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 3, '第三步：炒西红柿出汁
1. 再次热锅：锅中无需洗，再加入 10ml 食用油，开中火加热。
2. 下西红柿：倒入切好的西红柿块，中火翻炒。
3. 调味促汁：一边翻炒一边用铲子按压西红柿，同时加入 2g 食盐和 3g 白糖。盐能杀出水分，糖能中和酸味提鲜。
4. 焖煮：如果西红柿较硬不出汁，可加入少许清水，转小火焖煮 1-2 分钟，直到炒出浓郁的红汤。', '这一步的重点是“出汁”，西红柿要炒得软烂，汤汁浓郁才能挂在鸡蛋上。', 4);

  -- Step 4
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 4, '第四步：混合与出锅
1. 混合：保持中小火，将之前炒好的鸡蛋倒回锅中。
2. 翻炒：快速翻炒均匀，让每一块鸡蛋都吸满西红柿的汤汁，约需 30-60 秒。
3. 调味：尝一下咸淡，根据口味决定是否补盐（通常之前加的盐已足够）。
4. 出锅：撒上葱花点缀，关火装盘。', '鸡蛋倒回锅中后不要久煮，否则口感会变老。只需裹上酱汁即可出锅。', 2);

END $$;
