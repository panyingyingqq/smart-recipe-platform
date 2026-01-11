-- Update 2nd batch of popular recipes with ULTRA detailed tutorial

-- 1. Fish-Flavored Shredded Pork (鱼香肉丝)
-- Note: Check if recipe exists or insert placeholder first if missing in seed. 
-- Based on previous seed, 'Fish-Flavored Shredded Pork' might not be there explicitly or named differently.
-- Let's check 'Yu Xiang Eggplant' was there. 'Fish-Flavored Shredded Pork' (鱼香肉丝) is a must.
-- I will INSERT it if it doesn't exist, or UPDATE it.
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '鱼香肉丝';
  
  -- If not exists, create it
  IF target_recipe_id IS NULL THEN
    INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) 
    VALUES ('鱼香肉丝', 'Fish-Flavored Shredded Pork', '经典的川菜，酸甜辣咸鲜兼备，肉丝滑嫩，配饭神器。', '主菜', 3, 20, 10, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80', true)
    RETURNING id INTO target_recipe_id;
  END IF;

  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：准备肉丝
1. 切丝：里脊肉顺着纹路切成均匀的细丝。
2. 腌制：肉丝碗中加入 1g 盐、1勺料酒、1勺生抽、半个蛋清和 1勺淀粉，抓匀上浆。最后封入 1勺食用油。
3. 静置：腌制 10-15 分钟入味。', '顺纹切肉丝炒出来不碎；封油防止粘连。', 15),

  (target_recipe_id, 2, '第二步：准备配菜与鱼香汁
1. 切配：黑木耳泡发切丝，笋（或胡萝卜、青椒）切丝。
2. 调汁：碗中放 4勺醋、3勺糖、2勺生抽、1勺淀粉、少许盐和清水，搅匀备用。鱼香汁比例“4321”是关键。', '鱼香肉丝没有鱼，香味来自泡椒和糖醋葱蒜的配合。', 10),

  (target_recipe_id, 3, '第三步：滑炒肉丝
1. 热锅温油：油温 3-4 成热时下入肉丝。
2. 滑散：用筷子快速划散，见肉丝变白立刻盛出。', '油温太高肉会老，太低会脱浆。', 3),

  (target_recipe_id, 4, '第四步：爆炒出锅
1. 炒底料：锅底留油，下入一勺剁碎的郫县豆瓣酱和泡椒末，炒出红油。
2. 爆香：加入姜蒜末炒香。
3. 合炒：倒入配菜（木耳、笋丝）快速翻炒至断生。
4. 烹汁：倒入肉丝，淋入鱼香汁，撒上一把葱花，大火快速翻匀出锅。', '最后撒葱花是点睛之笔，利用余热激发出葱香味。', 3);
END $$;

-- 2. Steamed Fish (清蒸鱼 - Generic/Bass)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '清蒸鱼';
  IF target_recipe_id IS NULL THEN
    INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) 
    VALUES ('清蒸鱼', 'Steamed Fish', '最大程度保留鱼肉的鲜美，口感嫩滑，营养丰富。', '主菜', 2, 10, 8, 'https://images.unsplash.com/photo-1598511726623-d219904a53e8?auto=format&fit=crop&w=800&q=80', true)
    RETURNING id INTO target_recipe_id;
  END IF;

  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：处理鱼
1. 改刀：鲈鱼（或其他鱼）洗净擦干，背部肉厚处划两刀，方便成熟。
2. 铺底：盘底铺上姜片和葱段，将鱼架在上面（让蒸汽流通）。
3. 腌制：鱼身抹少许料酒，不建议抹盐（会流失水分变老）。', '盘底架空鱼身是关键，能让鱼熟得均匀且不腥。', 5),

  (target_recipe_id, 2, '第二步：蒸制
1. 烧水：蒸锅水烧开，一定要水开后再上锅！
2. 蒸鱼：大火蒸 6-8 分钟（根据鱼大小，一斤左右的鱼 7 分钟足够）。
3. 虚蒸：关火后不要马上揭盖，焖 2 分钟。', '宁可蒸嫩，不可蒸老。眼珠突出、肉易脱骨即熟。', 8),

  (target_recipe_id, 3, '第三步：泼油
1. 倒水：倒掉盘中蒸出的腥水（必须倒掉）。
2. 铺料：在鱼身上铺上切好的葱丝、姜丝、红椒丝。
3. 激香：烧两勺热油，烧至冒烟，淋在葱姜丝上，激发出香味。
4. 调味：沿盘边淋入蒸鱼豉油即可。', '不要把酱油直接淋在鱼身上，影响色泽。热油激葱丝是灵魂。', 2);
END $$;

-- 3. Cola Chicken Wings (可乐鸡翅)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '可乐鸡翅';
  IF target_recipe_id IS NULL THEN
    INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) 
    VALUES ('可乐鸡翅', 'Cola Chicken Wings', '小朋友的最爱，鸡翅嫩滑，可乐的甜味恰到好处。', '主菜', 1, 10, 20, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=800&q=80', true)
    RETURNING id INTO target_recipe_id;
  END IF;

  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：处理鸡翅
1. 改刀：鸡翅洗净，正反面划两刀方便入味。
2. 焯水：冷水入锅，加姜片料酒，煮出血沫后捞出洗净沥干。', '焯水去腥，沥干防止煎的时候溅油。', 10),

  (target_recipe_id, 2, '第二步：煎至金黄
1. 煎制：平底锅刷少许油，放入鸡翅中小火慢煎。
2. 翻面：煎至两面金黄焦香。', '不用放太多油，鸡皮本身会出油。', 8),

  (target_recipe_id, 3, '第三步：焖煮
1. 调味：加入姜片、葱段，倒入可乐没过鸡翅。
2. 增色：加一勺生抽提鲜，半勺老抽上色。
3. 焖煮：大火烧开转中小火焖煮 15 分钟。', '可乐含糖量高，无需另外加糖。', 15),

  (target_recipe_id, 4, '第四步：收汁
1. 大火收汁：汤汁变少后转大火，快速翻炒。
2. 挂汁：待汤汁浓稠包裹在鸡翅上时，撒上白芝麻出锅。', '收汁时要盯着，可乐糖分高极易糊锅。', 5);
END $$;

-- 4. Twice Cooked Pork (回锅肉)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '回锅肉';
  IF target_recipe_id IS NULL THEN
    INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) 
    VALUES ('回锅肉', 'Twice-Cooked Pork', '川菜之首，肥而不腻，蒜苗飘香。', '主菜', 3, 30, 15, 'https://images.unsplash.com/photo-1606509939527-4b727409403c?auto=format&fit=crop&w=800&q=80', true)
    RETURNING id INTO target_recipe_id;
  END IF;

  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：煮肉（第一回）
1. 煮制：五花肉（二刀肉最佳）冷水下锅，加姜葱、花椒、料酒，煮至八分熟（筷子能扎透但无血水）。
2. 切片：捞出晾凉（或冷藏），切成硬币厚度的薄片。', '肉要切得薄且均匀，冷藏后更好切。', 20),

  (target_recipe_id, 2, '第二步：煸炒（第二回）
1. 煸油：锅中放少许油，下入肉片中火煸炒。
2. 灯盏窝：炒至肉片卷曲成“灯盏窝”状，吐出油脂，盛出多余的油。', '必须炒出灯盏窝，肉才香糯不腻。', 5),

  (target_recipe_id, 3, '第三步：调味与配菜
1. 下料：将肉拨到一边，用底油炒香郫县豆瓣酱（炒出红油）和豆豉。
2. 翻炒：加入少许甜面酱（增香中和辣味），与肉片翻炒均匀。
3. 配菜：下入蒜苗段（青蒜），先下白色蒜头部分炒生，再下叶子部分。
4. 出锅：大火断生即可，加少许糖提鲜。', '蒜苗是回锅肉的灵魂，不可炒太死。', 5);
END $$;

-- 5. Egg Fried Rice (蛋炒饭)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '蛋炒饭';
  IF target_recipe_id IS NULL THEN
    INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) 
    VALUES ('蛋炒饭', 'Egg Fried Rice', '最简单的美味，粒粒金黄，葱香扑鼻。', '主食', 2, 5, 5, 'https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=800&q=80', true)
    RETURNING id INTO target_recipe_id;
  END IF;

  DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
  INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
  (target_recipe_id, 1, '第一步：准备米饭
1. 抓松：使用隔夜米饭最佳，水分少。戴手套将米饭抓松，避免结块。
2. 润油：在米饭中拌入一勺食用油，更容易炒散。', '热米饭水分多，炒出来容易粘糊。', 2),

  (target_recipe_id, 2, '第二步：炒蛋
1. 炒蛋：热锅凉油，倒入打散的蛋液。
2. 划散：用筷子快速划散成小块，盛出备用（金包银做法可直接倒入米饭）。', '鸡蛋要嫩，不要炒老。', 2),

  (target_recipe_id, 3, '第三步：合炒
1. 炒饭：锅中留底油，倒入米饭大火翻炒。用铲子背按压米饭，使其跳动。
2. 混合：倒入鸡蛋碎，加入盐、少许白胡椒粉。
3. 撒葱：出锅前撒入大量葱花，翻炒均匀即可。', '大火快炒是关键，必须炒出“锅气”。', 3);
END $$;
