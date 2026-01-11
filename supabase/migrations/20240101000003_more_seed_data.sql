-- Insert More Ingredients
INSERT INTO ingredients (id, name, name_en, category, storage_method, image_url) VALUES
(gen_random_uuid(), '土豆', 'Potato', '蔬菜', '阴凉避光', 'https://images.unsplash.com/photo-1518977676605-615747132643?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '胡萝卜', 'Carrot', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '牛肉', 'Beef', '肉禽类', '冷冻/冷藏', 'https://images.unsplash.com/photo-1603048297172-c92544798d5e?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '洋葱', 'Onion', '蔬菜', '阴凉干燥', 'https://images.unsplash.com/photo-1508747703703-c331150c202d?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '西兰花', 'Broccoli', '蔬菜', '冷藏', 'https://images.unsplash.com/photo-1459411621453-7b03977f9bfc?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '三文鱼', 'Salmon', '海鲜水产', '冷冻/冷藏', 'https://images.unsplash.com/photo-1599084993091-1cb5c0721cc6?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '柠檬', 'Lemon', '水果/调味', '冷藏', 'https://images.unsplash.com/photo-1590502593747-42a996133562?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '大蒜', 'Garlic', '调味品', '阴凉干燥', 'https://images.unsplash.com/photo-1615477999742-e87e1a628886?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '生姜', 'Ginger', '调味品', '阴凉干燥', 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?auto=format&fit=crop&w=300&q=80'),
(gen_random_uuid(), '米饭', 'Rice', '主食', '常温干燥', 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=300&q=80');

-- Add a new recipe: 土豆炖牛肉 (Potato Beef Stew)
DO $$
DECLARE
    recipe_id UUID;
    beef_id UUID;
    potato_id UUID;
    carrot_id UUID;
    onion_id UUID;
BEGIN
    INSERT INTO recipes (name, name_en, description, difficulty, prep_time, cook_time, servings, category, cuisine, is_public, cover_image)
    VALUES ('土豆炖牛肉', 'Potato Beef Stew', '软烂入味，营养丰富的家常硬菜。', 4, 30, 90, 4, '主菜', '家常菜', true, 'https://images.unsplash.com/photo-1534939561126-855b8675edd7?auto=format&fit=crop&w=800&q=80')
    RETURNING id INTO recipe_id;

    SELECT id INTO beef_id FROM ingredients WHERE name = '牛肉' LIMIT 1;
    SELECT id INTO potato_id FROM ingredients WHERE name = '土豆' LIMIT 1;
    SELECT id INTO carrot_id FROM ingredients WHERE name = '胡萝卜' LIMIT 1;
    SELECT id INTO onion_id FROM ingredients WHERE name = '洋葱' LIMIT 1;

    INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount, unit, order_index) VALUES
    (recipe_id, beef_id, 500, 'g', 1),
    (recipe_id, potato_id, 2, '个', 2),
    (recipe_id, carrot_id, 1, '根', 3),
    (recipe_id, onion_id, 1, '个', 4);

    INSERT INTO recipe_steps (recipe_id, step_number, instruction, duration) VALUES
    (recipe_id, 1, '牛肉切块冷水下锅焯水，捞出洗净。', 15),
    (recipe_id, 2, '土豆胡萝卜切滚刀块，洋葱切片。', 10),
    (recipe_id, 3, '锅中油热后炒香洋葱，下牛肉翻炒。', 5),
    (recipe_id, 4, '加入开水没过食材，小火炖煮60分钟。', 60),
    (recipe_id, 5, '加入土豆和胡萝卜，继续炖煮20分钟至软烂。', 20),
    (recipe_id, 6, '加盐调味，大火收汁即可。', 5);
END $$;
