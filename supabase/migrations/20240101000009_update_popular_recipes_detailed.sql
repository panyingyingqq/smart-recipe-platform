-- Update popular recipes with ULTRA detailed tutorial

-- 1. Kung Pao Chicken (宫保鸡丁)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '宫保鸡丁';
  IF target_recipe_id IS NOT NULL THEN
    -- Clear existing steps
    DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
    -- Clear existing ingredients to re-insert categorized ones (simplified for this script: we assume ingredients might be messy, but let's focus on steps first. 
    -- Actually, to do it right, we should probably update ingredients too, but that requires mapping IDs. 
    -- For now, let's focus on the STEPS as requested "按这个标准...制作教程". 
    -- If ingredients are missing, the modal handles it gracefully. But let's try to add steps first.)

    -- Insert Recipe Steps
    INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
    (target_recipe_id, 1, '第一步：腌制鸡肉
1. 切丁：将鸡胸肉洗净，切成 1.5cm 见方的小丁。
2. 腌制：在碗中加入鸡丁、1勺料酒、1勺生抽、半勺老抽、少许白胡椒粉和 1勺淀粉。
3. 抓匀：用手抓匀，让鸡肉吸满酱汁，最后淋入 1勺食用油锁住水分，腌制 15 分钟。', '最后封油是关键，防止滑炒时粘连，也能保持肉质嫩滑。', 15),
    
    (target_recipe_id, 2, '第二步：调制碗芡（灵魂酱汁）
1. 配比：碗中加入 2勺香醋、1勺白糖、1勺生抽、少许盐、1勺淀粉和 2勺清水。
2. 搅匀：搅拌均匀备用。宫保口味的关键是“小荔枝口”，即酸甜适中，略带咸鲜。', '糖醋比例约为 1:1 或 2:2，根据个人喜好微调，但醋要稍多一点点以突出锅气。', 5),

    (target_recipe_id, 3, '第三步：滑炒鸡丁
1. 热锅凉油：锅烧热，倒入比平时稍多的油。
2. 滑熟：油温 4 成热时倒入腌好的鸡丁，快速滑散。
3. 盛出：待鸡丁变色发白（约 30-45 秒）迅速捞出沥油备用。', '鸡丁不要炒太久，变色即熟，久了就老了。', 3),

    (target_recipe_id, 4, '第四步：爆香与混合
1. 爆香：锅底留少许底油，放入干辣椒段和花椒，小火炸出香味（注意不要炸糊）。加入葱姜蒜片爆香。
2. 炒酱：倒入调好的碗芡，大火烧开至汤汁浓稠。
3. 裹汁：迅速倒入滑好的鸡丁和炸好的花生米。
4. 出锅：快速翻炒 10 秒，让芡汁均匀包裹所有食材，淋入少许红油（可选）提亮色泽，即可出锅。', '最后一步要“快”，花生米要最后放，保持酥脆。', 3);
  END IF;
END $$;

-- 2. Braised Pork Belly (红烧肉)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '红烧肉';
  IF target_recipe_id IS NOT NULL THEN
    DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
    INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
    (target_recipe_id, 1, '第一步：处理五花肉
1. 清洗：五花肉洗净，刮去皮上的杂质。
2. 切块：切成 2-3cm 见方的正方体块。
3. 焯水：冷水下锅，加入姜片和料酒，大火煮开后撇去浮沫，煮 2 分钟捞出，用温水冲洗干净沥干。', '焯水一定要冷水下锅，才能煮出血水；洗肉要用温水，冷水会让肉质收缩变硬。', 10),

    (target_recipe_id, 2, '第二步：煸炒出油
1. 煸炒：锅中不放油（或少许底油），倒入五花肉块，中小火慢煸。
2. 煎黄：煎至两面金黄，逼出多余油脂（这样吃起来不腻）。盛出肉，倒出多余的猪油。', '这一步是红烧肉肥而不腻的关键。', 10),

    (target_recipe_id, 3, '第三步：炒糖色（可选，可用老抽代替）
1. 融糖：锅中留少许底油，加入冰糖，小火慢炒。
2. 枣红：炒至冰糖完全融化，变成枣红色且冒小泡。
3. 上色：迅速倒入五花肉翻炒，使每块肉均匀裹上糖色。', '炒糖色火候难掌握，新手可用老抽上色，跳过此步直接炒香料。', 5),

    (target_recipe_id, 4, '第四步：炖煮
1. 调味：加入八角、桂皮、香叶、姜片、葱段炒香。沿锅边淋入料酒、生抽、老抽。
2. 加水：倒入没过肉的开水（一定要开水！）。
3. 慢炖：大火烧开后转小火，盖盖焖煮 40-60 分钟。', '水要一次加足，中途加水会冲淡味道并影响肉质。', 60),

    (target_recipe_id, 5, '第五步：收汁
1. 挑料：捡出葱姜八角等香料。
2. 收汁：加少许盐调味（如果酱油够咸可不加），转大火收汁。
3. 亮油：不停翻炒防止糊锅，待汤汁浓稠红亮，包裹在肉上时即可出锅。', '收汁时要人要在旁边看着，最后阶段很容易糊。', 10);
  END IF;
END $$;

-- 3. Mapo Tofu (麻婆豆腐)
DO $$
DECLARE
  target_recipe_id UUID;
BEGIN
  SELECT id INTO target_recipe_id FROM recipes WHERE name = '麻婆豆腐';
  IF target_recipe_id IS NOT NULL THEN
    DELETE FROM recipe_steps WHERE recipe_id = target_recipe_id;
    INSERT INTO recipe_steps (recipe_id, step_number, instruction, tips, duration) VALUES
    (target_recipe_id, 1, '第一步：处理豆腐
1. 切块：嫩豆腐切成 2cm 左右的方块。
2. 焯水：锅中烧水，加一勺盐，水开后放入豆腐焯烫 1-2 分钟。
3. 沥干：捞出放入冷水中过凉，沥干水分备用。', '盐水焯烫能让豆腐更紧致，炒的时候不易碎，还能去除豆腥味。', 5),

    (target_recipe_id, 2, '第二步：炒肉末
1. 煸酥：热锅凉油，下入牛肉末（或猪肉末），中小火煸炒。
2. 吐油：炒至肉末酥香，颜色变深，吐出油脂。', '肉末要炒干一点才香，这就是“麻婆豆腐”中的“酥”。', 5),

    (target_recipe_id, 3, '第三步：炒红油底料
1. 下料：加入郫县豆瓣酱（剁碎），炒出红油。
2. 增香：加入姜末、蒜末、豆豉翻炒出香味。
3. 调色：加入少许辣椒面（可选）增加色泽。', '豆瓣酱一定要炒出红油，菜色才好看。', 3),

    (target_recipe_id, 4, '第四步：烧制
1. 加汤：倒入适量高汤或清水（没过豆腐即可）。
2. 调味：加入少许白糖、生抽。
3. 煮制：滑入豆腐，中小火煮 3-5 分钟，让豆腐入味。', '不要用铲子乱翻，用推勺的方式推动豆腐，防止碎烂。', 5),

    (target_recipe_id, 5, '第五步：勾芡与出锅
1. 勾芡：分三次淋入水淀粉（勾芡要薄且均匀）。第一次勾芡让汤汁略浓；第二次让味道吸附；第三次收亮油。
2. 撒粉：出锅装盘，撒上大量的花椒粉和青蒜苗（或葱花）。', '花椒粉一定要出锅后再撒，才能激发出麻味。', 3);
  END IF;
END $$;
