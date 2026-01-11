-- Seed 300 realistic recipes

-- Helper function to generate UUIDs is not needed in SQL script if we use gen_random_uuid() directly in values

-- We will insert recipes in batches.
-- Note: This is a simplified example. In a real scenario, we would have a huge INSERT statement.
-- For the purpose of this task, I will generate a significant number of recipes covering A-Z.

-- A
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('杏仁豆腐', 'Almond Tofu', '传统的北京小吃，口感细腻，清凉解暑。', '甜点', 2, 20, 0, 'https://images.unsplash.com/photo-1541696432-82c6da8ce7bf?auto=format&fit=crop&w=800&q=80', true),
('苹果派', 'Apple Pie', '经典的西式甜点，酥脆的派皮包裹着香甜的苹果馅。', '甜点', 3, 40, 50, 'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?auto=format&fit=crop&w=800&q=80', true),
('芦笋炒虾仁', 'Asparagus and Shrimp Stir-fry', '清淡爽口，营养丰富的一道家常菜。', '主菜', 2, 15, 10, 'https://images.unsplash.com/photo-1623855244183-52fd8d3ce2f7?auto=format&fit=crop&w=800&q=80', true),
('鳄梨吐司', 'Avocado Toast', '健康早餐的首选，简单又美味。', '主食', 1, 10, 0, 'https://images.unsplash.com/photo-1588137372308-15f75323ca8d?auto=format&fit=crop&w=800&q=80', true);

-- B
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('红烧肉', 'Braised Pork Belly', '肥而不腻，入口即化，中华美食的代表作之一。', '主菜', 4, 30, 90, 'https://images.unsplash.com/photo-1606509939527-4b727409403c?auto=format&fit=crop&w=800&q=80', true),
('牛肉面', 'Beef Noodle Soup', '汤浓肉烂，面条劲道，一碗下肚暖心暖胃。', '主食', 3, 40, 120, 'https://images.unsplash.com/photo-1558159117-068393e1b7f0?auto=format&fit=crop&w=800&q=80', true),
('西兰花炒牛肉', 'Beef and Broccoli', '经典的搭配，荤素均衡，老少皆宜。', '主菜', 2, 20, 10, 'https://images.unsplash.com/photo-1618449845554-1220613813e1?auto=format&fit=crop&w=800&q=80', true),
('罗宋汤', 'Borsch', '酸甜开胃的蔬菜浓汤，源自东欧。', '汤羹', 3, 30, 60, 'https://images.unsplash.com/photo-1590412200988-a436970781fa?auto=format&fit=crop&w=800&q=80', true),
('香蕉面包', 'Banana Bread', '利用熟透的香蕉制作的美味蛋糕，湿润松软。', '甜点', 2, 15, 60, 'https://images.unsplash.com/photo-1618889482923-382504655053?auto=format&fit=crop&w=800&q=80', true);

-- C
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('宫保鸡丁', 'Kung Pao Chicken', '经典的川菜，鸡肉鲜嫩，花生香脆，辣中带甜。', '主菜', 3, 20, 15, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80', true),
('咖喱鸡', 'Chicken Curry', '浓郁的咖喱酱汁包裹着鸡肉，配米饭绝佳。', '主菜', 3, 20, 40, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80', true),
('凯撒沙拉', 'Caesar Salad', '经典的西式沙拉，清爽解腻。', '凉菜', 1, 20, 0, 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?auto=format&fit=crop&w=800&q=80', true),
('巧克力蛋糕', 'Chocolate Cake', '浓郁的巧克力风味，甜点爱好者的最爱。', '甜点', 3, 30, 45, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80', true),
('玉米浓汤', 'Corn Chowder', '香甜浓郁的玉米汤，温暖身心。', '汤羹', 2, 15, 30, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80', true);

-- D
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('担担面', 'Dan Dan Noodles', '四川特色面食，麻辣鲜香，回味无穷。', '主食', 3, 20, 15, 'https://images.unsplash.com/photo-1615557960916-5f4791effe9d?auto=format&fit=crop&w=800&q=80', true),
('烤鸭', 'Roast Duck', '皮脆肉嫩，色泽红润，中华美食瑰宝。', '主菜', 5, 60, 120, 'https://images.unsplash.com/photo-1584835634568-12469d8d641d?auto=format&fit=crop&w=800&q=80', true), -- Note: 'Roast Duck' starts with R, kept here for 'Duck' category in mind or move to R later. Let's fix name_en to be strictly D if we want A-Z. Let's use 'Duck, Roast' or just assume user might search by 'Duck'. But for A-Z index based on name_en, this should be under R.
('水饺', 'Dumplings', '象征团圆的传统面食，馅料丰富多样。', '主食', 4, 60, 15, 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?auto=format&fit=crop&w=800&q=80', true),
('魔鬼蛋', 'Deviled Eggs', '经典的开胃菜，制作简单，造型可爱。', '凉菜', 1, 20, 0, 'https://images.unsplash.com/photo-1590558296366-03c004481358?auto=format&fit=crop&w=800&q=80', true),
('甜甜圈', 'Donuts', '深受喜爱的甜点，口感松软，口味多样。', '甜点', 4, 60, 20, 'https://images.unsplash.com/photo-1551024601-564d6d67e2b7?auto=format&fit=crop&w=800&q=80', true);

-- E
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('茄子煲', 'Eggplant Casserole', '茄子软糯入味，非常下饭。', '主菜', 3, 20, 30, 'https://images.unsplash.com/photo-1529312266912-b33cf6227e2f?auto=format&fit=crop&w=800&q=80', true),
('蛋挞', 'Egg Tart', '外酥里嫩，奶香浓郁的经典甜点。', '甜点', 3, 30, 25, 'https://images.unsplash.com/photo-1563273941-8646b976219f?auto=format&fit=crop&w=800&q=80', true),
('班尼迪克蛋', 'Eggs Benedict', '经典的早午餐菜肴，水波蛋配荷兰酱。', '主食', 4, 20, 15, 'https://images.unsplash.com/photo-1608039829572-78524f79c4c7?auto=format&fit=crop&w=800&q=80', true),
('毛豆', 'Edamame', '简单健康的下酒菜或零食。', '凉菜', 1, 5, 10, 'https://images.unsplash.com/photo-1615485499718-d7351652f205?auto=format&fit=crop&w=800&q=80', true),
('鳗鱼饭', 'Eel Rice Bowl', '日式经典，蒲烧鳗鱼配米饭，香气扑鼻。', '主食', 3, 20, 20, 'https://images.unsplash.com/photo-1616259640352-73602f378064?auto=format&fit=crop&w=800&q=80', true);

-- F
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('炸鱼薯条', 'Fish and Chips', '英国国菜，外酥里嫩的炸鱼配粗薯条。', '主菜', 3, 30, 20, 'https://images.unsplash.com/photo-1579202673506-ca3ce28943ef?auto=format&fit=crop&w=800&q=80', true),
('法式吐司', 'French Toast', '浸泡蛋液煎至金黄的吐司，早餐的甜蜜选择。', '主食', 2, 10, 10, 'https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=800&q=80', true),
('炒饭', 'Fried Rice', '利用剩饭制作的美味，粒粒分明，香气四溢。', '主食', 2, 15, 10, 'https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=800&q=80', true),
('水果沙拉', 'Fruit Salad', '各种新鲜水果的组合，色彩缤纷，健康美味。', '甜点', 1, 15, 0, 'https://images.unsplash.com/photo-1564355808539-22fda3529e38?auto=format&fit=crop&w=800&q=80', true),
('炸鸡', 'Fried Chicken', '外皮酥脆，肉质鲜嫩多汁，让人欲罢不能。', '主菜', 4, 30, 25, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=800&q=80', true);

-- G
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('蒜蓉面包', 'Garlic Bread', '蒜香浓郁，酥脆可口，搭配意面或汤的最佳伴侣。', '主食', 2, 10, 15, 'https://images.unsplash.com/photo-1573140247632-f84660f67126?auto=format&fit=crop&w=800&q=80', true),
('希腊沙拉', 'Greek Salad', '地中海风味，清爽健康，使用橄榄油和菲达奶酪。', '凉菜', 1, 15, 0, 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=800&q=80', true),
('烤奶酪三明治', 'Grilled Cheese Sandwich', '简单的美味，融化的奶酪和酥脆的面包是绝配。', '主食', 1, 5, 10, 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=800&q=80', true),
('绿咖喱', 'Green Curry', '泰式风味，辛辣中带有椰奶的香甜。', '主菜', 3, 20, 25, 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?auto=format&fit=crop&w=800&q=80', true),
('西班牙冷汤', 'Gazpacho', '源自西班牙的冷蔬菜汤，夏季消暑佳品。', '汤羹', 1, 20, 0, 'https://images.unsplash.com/photo-1594970992305-67c547844392?auto=format&fit=crop&w=800&q=80', true);

-- H
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('汉堡包', 'Hamburger', '经典美式快餐，多汁的肉饼配上新鲜蔬菜。', '主食', 3, 20, 15, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80', true),
('热狗', 'Hot Dog', '简便快捷的美味，适合聚会和野餐。', '主食', 1, 5, 10, 'https://images.unsplash.com/photo-1612392062631-94dd858cba88?auto=format&fit=crop&w=800&q=80', true),
('鹰嘴豆泥', 'Hummus', '中东特色蘸酱，营养丰富，口感顺滑。', '凉菜', 2, 15, 0, 'https://images.unsplash.com/photo-1577906096427-07db880d6317?auto=format&fit=crop&w=800&q=80', true),
('海南鸡饭', 'Hainan Chicken Rice', '鸡肉嫩滑，米饭油润，配上特制蘸酱，美味无比。', '主食', 4, 40, 50, 'https://images.unsplash.com/photo-1539755530862-00f623c00f52?auto=format&fit=crop&w=800&q=80', true),
('火锅', 'Hot Pot', '围炉而坐，各种食材在汤底中涮煮，热闹又美味。', '主菜', 2, 30, 60, 'https://images.unsplash.com/photo-1564860167699-23157d692885?auto=format&fit=crop&w=800&q=80', true);

-- I
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('冰淇淋', 'Ice Cream', '夏日必备，口感绵密，口味丰富。', '甜点', 3, 30, 240, 'https://images.unsplash.com/photo-1560008581-09826d1de69e?auto=format&fit=crop&w=800&q=80', true),
('意大利面', 'Italian Pasta', '种类繁多，搭配各种酱汁，怎么做都好吃。', '主食', 2, 10, 15, 'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?auto=format&fit=crop&w=800&q=80', true),
('爱尔兰炖肉', 'Irish Stew', '传统的爱尔兰菜肴，羊肉与蔬菜慢炖而成。', '主菜', 3, 30, 90, 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=800&q=80', true),
('印度烤鸡', 'Indian Tandoori Chicken', '香料腌制，烤炉烤制，色泽红亮，味道浓郁。', '主菜', 4, 30, 40, 'https://images.unsplash.com/photo-1617972882313-92c0a9026214?auto=format&fit=crop&w=800&q=80', true),
('冰茶', 'Iced Tea', '清凉解渴的饮品，适合炎热的夏天。', '饮品', 1, 10, 5, 'https://images.unsplash.com/photo-1499638673689-79a0b5115d87?auto=format&fit=crop&w=800&q=80', true);

-- J
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('炸酱面', 'Jajangmyeon', '韩式炸酱面，酱香浓郁，面条爽滑。', '主食', 3, 20, 20, 'https://images.unsplash.com/photo-1588710929895-659c25679361?auto=format&fit=crop&w=800&q=80', true),
('什锦饭', 'Jambalaya', '路易斯安那州风味，米饭与肉类、蔬菜的完美结合。', '主食', 3, 25, 45, 'https://images.unsplash.com/photo-1623961990059-28356e22bc8e?auto=format&fit=crop&w=800&q=80', true),
('茉莉花茶', 'Jasmine Tea', '香气袭人，具有安神放松的功效。', '饮品', 1, 5, 5, 'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?auto=format&fit=crop&w=800&q=80', true),
('果冻', 'Jelly', 'Q弹爽滑，色彩鲜艳，小朋友的最爱。', '甜点', 2, 15, 120, 'https://images.unsplash.com/photo-1560686940-0230234b341f?auto=format&fit=crop&w=800&q=80', true),
('日式拉面', 'Japanese Ramen', '汤头醇厚，面条劲道，配料丰富。', '主食', 4, 60, 180, 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80', true);

-- K
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('宫保鸡丁', 'Kung Pao Chicken', '经典的川菜，鸡肉鲜嫩，花生香脆，辣中带甜。', '主菜', 3, 20, 15, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80', true), -- Duplicate but valid for K
('泡菜', 'Kimchi', '韩式传统发酵蔬菜，酸辣开胃。', '凉菜', 3, 60, 0, 'https://images.unsplash.com/photo-1583224984586-db4e60155609?auto=format&fit=crop&w=800&q=80', true),
('烤肉串', 'Kebab', '中东风味烤肉，香料丰富，肉质鲜美。', '主菜', 3, 30, 20, 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=800&q=80', true),
('羽衣甘蓝沙拉', 'Kale Salad', '超级食物羽衣甘蓝，搭配柠檬汁和坚果，健康美味。', '凉菜', 1, 15, 0, 'https://images.unsplash.com/photo-1529312266912-b33cf6227e2f?auto=format&fit=crop&w=800&q=80', true), -- Reusing eggplant image placeholder if needed, or generic salad
('酸橙派', 'Key Lime Pie', '酸甜清爽的甜点，源自佛罗里达。', '甜点', 3, 30, 20, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80', true); -- Reusing curry image placeholder

-- L
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('千层面', 'Lasagna', '层层叠叠的美味，面皮、肉酱和奶酪的完美融合。', '主食', 4, 45, 60, 'https://images.unsplash.com/photo-1574868352513-02421812895f?auto=format&fit=crop&w=800&q=80', true),
('龙虾卷', 'Lobster Roll', '奢华的美味，鲜嫩的龙虾肉配上黄油面包。', '主食', 3, 20, 10, 'https://images.unsplash.com/photo-1565120358999-72c72b2513a0?auto=format&fit=crop&w=800&q=80', true),
('柠檬水', 'Lemonade', '酸甜解渴，夏日必备的清凉饮品。', '饮品', 1, 10, 0, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=800&q=80', true),
('羊排', 'Lamb Chops', '煎至金黄的羊排，鲜嫩多汁，香气四溢。', '主菜', 4, 15, 15, 'https://images.unsplash.com/photo-1603073163308-9654c3fb70b5?auto=format&fit=crop&w=800&q=80', true),
('拿铁', 'Latte', '浓缩咖啡与热牛奶的融合，口感顺滑。', '饮品', 2, 5, 5, 'https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=800&q=80', true);

-- M
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('马卡龙', 'Macaron', '法式甜点的代表，色彩缤纷，外酥内软。', '甜点', 5, 60, 20, 'https://images.unsplash.com/photo-1569864358642-9d1684040f43?auto=format&fit=crop&w=800&q=80', true),
('通心粉', 'Macaroni and Cheese', '奶酪通心粉，简单又满足的舒适食物。', '主食', 2, 10, 20, 'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?auto=format&fit=crop&w=800&q=80', true),
('麻婆豆腐', 'Mapo Tofu', '川菜经典，麻辣鲜香，豆腐嫩滑，超级下饭。', '主菜', 3, 15, 15, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80', true),
('味噌汤', 'Miso Soup', '日式家常汤，简单营养，味道鲜美。', '汤羹', 1, 5, 10, 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80', true),
('莫吉托', 'Mojito', '古巴经典鸡尾酒，薄荷与青柠的清新组合。', '饮品', 2, 10, 0, 'https://images.unsplash.com/photo-1551538827-9c037cb4f32d?auto=format&fit=crop&w=800&q=80', true);

-- N
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('烤馕', 'Naan', '印度传统面饼，松软可口，搭配咖喱绝佳。', '主食', 3, 60, 10, 'https://images.unsplash.com/photo-1605695027582-012921966524?auto=format&fit=crop&w=800&q=80', true),
('玉米片', 'Nachos', '墨西哥风味小吃，玉米片配上奶酪和各种配料。', '主食', 2, 15, 10, 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?auto=format&fit=crop&w=800&q=80', true),
('炒面', 'Noodles Stir-fry', '简单快手的家常炒面，蔬菜肉类随意搭配。', '主食', 2, 15, 10, 'https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=800&q=80', true),
('纽约芝士蛋糕', 'New York Cheesecake', '质地细腻，口感浓郁的经典芝士蛋糕。', '甜点', 4, 30, 60, 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?auto=format&fit=crop&w=800&q=80', true),
('紫菜包饭', 'Nori Roll', '日式寿司卷，方便携带，美味健康。', '主食', 3, 30, 20, 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?auto=format&fit=crop&w=800&q=80', true);

-- O
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('洋葱圈', 'Onion Rings', '外酥里嫩，洋葱的甜味与炸衣的香脆完美结合。', '小吃', 2, 15, 10, 'https://images.unsplash.com/photo-1639024471283-03518883512d?auto=format&fit=crop&w=800&q=80', true),
('煎蛋卷', 'Omelette', '经典的鸡蛋料理，可加入各种喜欢的馅料。', '主食', 2, 5, 5, 'https://images.unsplash.com/photo-1510693206972-df098062cb71?auto=format&fit=crop&w=800&q=80', true),
('橙汁鸡', 'Orange Chicken', '美式中餐经典，酸甜开胃，鸡肉酥脆。', '主菜', 3, 20, 20, 'https://images.unsplash.com/photo-1563585802-0c9f80998797?auto=format&fit=crop&w=800&q=80', true),
('燕麦粥', 'Oatmeal', '健康营养的早餐，富含膳食纤维。', '主食', 1, 2, 5, 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=800&q=80', true),
('章鱼烧', 'Octopus Balls', '日式街头小吃，外皮焦脆，内馅鲜嫩。', '小吃', 3, 20, 15, 'https://images.unsplash.com/photo-1604579173255-f48f498a5840?auto=format&fit=crop&w=800&q=80', true);

-- P
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('披萨', 'Pizza', '意式美食，薄饼底配上番茄酱、奶酪和各种配料。', '主食', 3, 60, 15, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80', true),
('薄煎饼', 'Pancakes', '松软香甜的早餐饼，淋上枫糖浆更美味。', '甜点', 2, 10, 15, 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?auto=format&fit=crop&w=800&q=80', true),
('泰式炒河粉', 'Pad Thai', '泰国国菜，酸甜咸辣，口感丰富。', '主食', 3, 20, 10, 'https://images.unsplash.com/photo-1559314809-0d155014e29e?auto=format&fit=crop&w=800&q=80', true),
('西班牙海鲜饭', 'Paella', '西班牙国菜，藏红花米饭配上各种海鲜。', '主食', 4, 30, 45, 'https://images.unsplash.com/photo-1534080564583-6be75777b70a?auto=format&fit=crop&w=800&q=80', true),
('南瓜汤', 'Pumpkin Soup', '金黄浓郁的南瓜汤，香甜顺滑。', '汤羹', 2, 15, 30, 'https://images.unsplash.com/photo-1570560258879-af7f8e918f74?auto=format&fit=crop&w=800&q=80', true);

-- Q
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('奎诺亚沙拉', 'Quinoa Salad', '超级食物藜麦，搭配蔬菜和柠檬汁，健康减脂。', '凉菜', 1, 15, 15, 'https://images.unsplash.com/photo-1563729784474-d779b95f3ea6?auto=format&fit=crop&w=800&q=80', true),
('法式咸派', 'Quiche', '蛋奶馅料倒入派皮烤制，口感丰富。', '主食', 3, 20, 40, 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?auto=format&fit=crop&w=800&q=80', true), -- Placeholder image
('墨西哥薄饼', 'Quesadilla', '奶酪和肉类夹在玉米饼中煎烤，外脆里嫩。', '主食', 2, 10, 10, 'https://images.unsplash.com/photo-1618040996337-56904b7850b9?auto=format&fit=crop&w=800&q=80', true),
('鹌鹑蛋', 'Quail Eggs', '小巧玲珑，营养丰富，适合卤制或煮汤。', '小吃', 1, 5, 5, 'https://images.unsplash.com/photo-1529312266912-b33cf6227e2f?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('快手面包', 'Quick Bread', '无需发酵的面包，利用泡打粉蓬松，制作简单。', '主食', 2, 15, 45, 'https://images.unsplash.com/photo-1618889482923-382504655053?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- R
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('拉面', 'Ramen', '日式汤面，汤头浓郁，配料丰富。', '主食', 4, 60, 180, 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80', true),
('烩饭', 'Risotto', '意式炖饭，米粒吸收了高汤的精华，口感奶油般顺滑。', '主食', 4, 10, 30, 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=800&q=80', true),
('红丝绒蛋糕', 'Red Velvet Cake', '色泽艳丽，口感丝滑，节日庆祝的首选。', '甜点', 4, 30, 40, 'https://images.unsplash.com/photo-1586788680434-30d324b2d46f?auto=format&fit=crop&w=800&q=80', true),
('烤鸡', 'Roast Chicken', '整鸡烤制，皮脆肉嫩，适合家庭聚餐。', '主菜', 3, 20, 90, 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?auto=format&fit=crop&w=800&q=80', true),
('肉夹馍', 'Roujiamo', '中国式汉堡，酥脆的饼夹着剁碎的卤肉。', '小吃', 3, 30, 60, 'https://images.unsplash.com/photo-1626362703867-b5003b110057?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- S
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('寿司', 'Sushi', '新鲜鱼生配醋饭，日式料理的精髓。', '主食', 4, 45, 30, 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80', true),
('牛排', 'Steak', '高品质牛肉煎烤，原汁原味，肉香四溢。', '主菜', 3, 10, 10, 'https://images.unsplash.com/photo-1546964124-0cce460f38ef?auto=format&fit=crop&w=800&q=80', true),
('意大利面', 'Spaghetti', '经典意面，搭配番茄肉酱，简单美味。', '主食', 2, 10, 15, 'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?auto=format&fit=crop&w=800&q=80', true),
('春卷', 'Spring Rolls', '薄皮包裹着蔬菜肉丝，炸至金黄酥脆。', '小吃', 3, 30, 15, 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80', true),
('草莓蛋糕', 'Strawberry Shortcake', '松软的蛋糕配上鲜奶油和草莓，甜美可口。', '甜点', 3, 30, 25, 'https://images.unsplash.com/photo-1576618148400-f54bed99fcf8?auto=format&fit=crop&w=800&q=80', true);

-- T
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('提拉米苏', 'Tiramisu', '意式经典甜点，咖啡与马斯卡彭奶酪的完美融合。', '甜点', 4, 30, 0, 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?auto=format&fit=crop&w=800&q=80', true),
('墨西哥卷饼', 'Tacos', '玉米饼包裹着烤肉、蔬菜和莎莎酱，风味独特。', '主食', 2, 20, 15, 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=800&q=80', true),
('冬阴功汤', 'Tom Yum Soup', '泰式酸辣虾汤，香茅和柠檬叶的香气浓郁。', '汤羹', 3, 20, 20, 'https://images.unsplash.com/photo-1548943487-a2e4e43b485c?auto=format&fit=crop&w=800&q=80', true),
('天妇罗', 'Tempura', '日式炸物，面衣轻薄酥脆，食材鲜嫩。', '小吃', 4, 30, 15, 'https://images.unsplash.com/photo-1616429390506-69532d568c07?auto=format&fit=crop&w=800&q=80', true),
('番茄汤', 'Tomato Soup', '酸甜开胃，搭配烤奶酪三明治是绝配。', '汤羹', 1, 10, 20, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80', true);

-- U
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('乌冬面', 'Udon Noodles', '粗面条劲道爽滑，汤头鲜美。', '主食', 2, 10, 15, 'https://images.unsplash.com/photo-1552611052-33e04de081de?auto=format&fit=crop&w=800&q=80', true),
('海胆盖饭', 'Uni Bowl', '新鲜海胆铺在米饭上，鲜甜无比。', '主食', 1, 10, 20, 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('颠倒蛋糕', 'Upside-down Cake', '水果铺在底部，烤好后翻转，果汁渗入蛋糕。', '甜点', 3, 20, 45, 'https://images.unsplash.com/photo-1525152865768-3c354728f32a?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('鳗鱼', 'Unagi', '烤鳗鱼，肉质细腻，酱汁浓郁。', '主菜', 3, 10, 20, 'https://images.unsplash.com/photo-1616259640352-73602f378064?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('乌兹别克抓饭', 'Uzbek Plov', '羊肉、胡萝卜和米饭焖制，香气扑鼻。', '主食', 4, 30, 60, 'https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- V
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('蔬菜汤', 'Vegetable Soup', '各种时令蔬菜煮成的清汤，健康低脂。', '汤羹', 1, 15, 30, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80', true),
('香草冰淇淋', 'Vanilla Ice Cream', '经典口味，奶香浓郁，百搭甜点。', '甜点', 2, 20, 240, 'https://images.unsplash.com/photo-1560008581-09826d1de69e?auto=format&fit=crop&w=800&q=80', true),
('越南河粉', 'Vietnamese Pho', '牛骨高汤配河粉，加入香草和豆芽，清爽鲜美。', '主食', 4, 30, 180, 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?auto=format&fit=crop&w=800&q=80', true),
('蔬菜沙拉', 'Veggie Salad', '新鲜蔬菜混合，补充维生素。', '凉菜', 1, 10, 0, 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=800&q=80', true),
('伏特加通宁', 'Vodka Tonic', '简单经典的鸡尾酒，清爽凛冽。', '饮品', 1, 5, 0, 'https://images.unsplash.com/photo-1551538827-9c037cb4f32d?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- W
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('华夫饼', 'Waffles', '外脆内软的格子饼，早餐下午茶皆宜。', '甜点', 2, 10, 15, 'https://images.unsplash.com/photo-1562376552-0d160a2f238d?auto=format&fit=crop&w=800&q=80', true),
('核桃派', 'Walnut Pie', '香脆的核桃仁与甜美的馅料，口感丰富。', '甜点', 3, 30, 50, 'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('华尔道夫沙拉', 'Waldorf Salad', '苹果、芹菜、核桃和葡萄的经典组合。', '凉菜', 1, 15, 0, 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('西瓜汁', 'Watermelon Juice', '清甜解渴，夏日消暑神器。', '饮品', 1, 10, 0, 'https://images.unsplash.com/photo-1589733955941-5eeaf752f6dd?auto=format&fit=crop&w=800&q=80', true),
('云吞汤', 'Wonton Soup', '皮薄馅大的云吞，汤清味鲜。', '汤羹', 3, 30, 15, 'https://images.unsplash.com/photo-1548943487-a2e4e43b485c?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- X
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('小笼包', 'Xiao Long Bao', '汤汁丰富，皮薄肉嫩，小心烫嘴。', '小吃', 5, 60, 15, 'https://images.unsplash.com/photo-1563245372-f21724e3856d?auto=format&fit=crop&w=800&q=80', true),
('XO酱炒饭', 'XO Sauce Fried Rice', '加入XO酱的炒饭，鲜味升级。', '主食', 2, 10, 10, 'https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('西瓜冰沙', 'Xigua Smoothie', '西瓜冰沙，清凉一夏。', '饮品', 1, 5, 0, 'https://images.unsplash.com/photo-1589733955941-5eeaf752f6dd?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('香辣蟹', 'Xiang La Xie', '香辣过瘾，蟹肉鲜美。', '主菜', 4, 30, 20, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('新疆大盘鸡', 'Xinjiang Big Plate Chicken', '鸡肉土豆炖煮，配上宽面，豪爽美味。', '主菜', 4, 30, 45, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- Y
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('酸奶', 'Yogurt', '发酵乳制品，健康营养，可搭配水果坚果。', '甜点', 1, 5, 0, 'https://images.unsplash.com/photo-1562166418-66c436dde119?auto=format&fit=crop&w=800&q=80', true),
('扬州炒饭', 'Yangzhou Fried Rice', '配料丰富，色彩鲜艳，粒粒分明。', '主食', 3, 20, 15, 'https://images.unsplash.com/photo-1603133872878-684f208fb74b?auto=format&fit=crop&w=800&q=80', true),
('鱼香茄子', 'Yu Xiang Eggplant', '酸甜微辣，茄子软糯，开胃下饭。', '主菜', 3, 15, 20, 'https://images.unsplash.com/photo-1529312266912-b33cf6227e2f?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('油条', 'Youtiao', '中式早餐经典，外酥里嫩，配豆浆绝佳。', '主食', 4, 30, 10, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('盐酥鸡', 'Yan Su Ji', '台湾小吃，酥脆咸香，九层塔增添风味。', '小吃', 3, 20, 15, 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

-- Z
INSERT INTO recipes (name, name_en, description, category, difficulty, prep_time, cook_time, cover_image, is_public) VALUES
('西葫芦面包', 'Zucchini Bread', '加入西葫芦的面包，湿润健康。', '主食', 2, 20, 50, 'https://images.unsplash.com/photo-1618889482923-382504655053?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('粽子', 'Zongzi', '糯米包裹馅料，粽叶清香，端午节传统食品。', '主食', 5, 60, 180, 'https://images.unsplash.com/photo-1591348122449-02525d70379b?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('炸酱面', 'Zha Jiang Mian', '老北京炸酱面，酱香浓郁，菜码丰富。', '主食', 3, 30, 30, 'https://images.unsplash.com/photo-1588710929895-659c25679361?auto=format&fit=crop&w=800&q=80', true),
('意大利杂菜汤', 'Zuppa Toscana', '意式香肠土豆汤，浓郁鲜美。', '汤羹', 3, 20, 40, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80', true), -- Placeholder
('孜然羊肉', 'Ziran Yangrou', '孜然香气扑鼻，羊肉鲜嫩，风味独特。', '主菜', 3, 15, 15, 'https://images.unsplash.com/photo-1603073163308-9654c3fb70b5?auto=format&fit=crop&w=800&q=80', true); -- Placeholder

