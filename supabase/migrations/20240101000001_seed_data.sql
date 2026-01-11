-- Insert Ingredients
INSERT INTO ingredients (id, name, name_en, category, storage_method, image_url) VALUES
('11111111-1111-1111-1111-111111111111', '鸡胸肉', 'Chicken Breast', '肉禽类', '冷冻/冷藏', 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?auto=format&fit=crop&w=300&q=80'),
('22222222-2222-2222-2222-222222222222', '花生米', 'Peanuts', '干货', '常温干燥', 'https://images.unsplash.com/photo-1563532733-a3d8b4c74991?auto=format&fit=crop&w=300&q=80'),
('33333333-3333-3333-3333-333333333333', '干辣椒', 'Dried Chili', '调味品', '常温干燥', 'https://images.unsplash.com/photo-1599347898863-7c706c99c857?auto=format&fit=crop&w=300&q=80'),
('44444444-4444-4444-4444-444444444444', '黄瓜', 'Cucumber', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1449300079323-02e209d9d3a6?auto=format&fit=crop&w=300&q=80'),
('55555555-5555-5555-5555-555555555555', '鸡蛋', 'Egg', '蛋奶', '冷藏', 'https://images.unsplash.com/photo-1506976785307-8732e854ad03?auto=format&fit=crop&w=300&q=80'),
('66666666-6666-6666-6666-666666666666', '西红柿', 'Tomato', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=300&q=80');

-- Insert Recipes
INSERT INTO recipes (id, name, name_en, description, difficulty, prep_time, cook_time, servings, category, cuisine, is_public, cover_image) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '宫保鸡丁', 'Kung Pao Chicken', '经典川菜，麻辣鲜香，鸡肉滑嫩，花生酥脆。', 3, 20, 15, 4, '主菜', '川菜', true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '西红柿炒鸡蛋', 'Tomato and Egg Stir-fry', '国民家常菜，酸甜可口，营养丰富。', 1, 5, 10, 2, '家常菜', '中式', true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80');

-- Insert Recipe Ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount, unit, order_index) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 300, 'g', 1), -- Chicken
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 50, 'g', 2), -- Peanuts
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 10, 'g', 3), -- Chili
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', 50, 'g', 4), -- Cucumber
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', 4, '个', 1), -- Egg
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '66666666-6666-6666-6666-666666666666', 2, '个', 2); -- Tomato

-- Insert Steps
INSERT INTO recipe_steps (recipe_id, step_number, instruction, duration) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, '鸡胸肉切丁，加入料酒、生抽、淀粉腌制15分钟。', 15),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 2, '黄瓜切丁，干辣椒剪段。', 5),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 3, '热锅凉油，下入鸡丁滑炒至变色盛出。', 5),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 4, '锅底留油，爆香干辣椒和花椒，下入鸡丁、黄瓜丁翻炒。', 3),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 5, '加入调味汁和花生米，快速翻炒均匀出锅。', 2),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 1, '鸡蛋打散，西红柿切块。', 3),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 2, '热锅加油，倒入蛋液炒熟盛出。', 3),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 3, '锅中再加少许油，炒软西红柿，加入糖和盐。', 4),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 4, '倒入鸡蛋合炒均匀，撒葱花出锅。', 2);
