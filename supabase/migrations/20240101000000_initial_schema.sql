-- 用户配置表（扩展Supabase auth.users）
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users NOT NULL PRIMARY KEY,
  username TEXT UNIQUE,
  avatar_url TEXT,
  updated_at TIMESTAMP WITH TIME ZONE
);

-- 食谱表
CREATE TABLE IF NOT EXISTS recipes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_id UUID REFERENCES auth.users(id) ON DELETE SET NULL, -- 关联用户
    name VARCHAR(100) NOT NULL,
    name_en VARCHAR(100),
    description TEXT,
    difficulty INTEGER CHECK (difficulty >= 1 AND difficulty <= 5),
    prep_time INTEGER NOT NULL, -- 分钟
    cook_time INTEGER NOT NULL, -- 分钟
    total_time INTEGER GENERATED ALWAYS AS (prep_time + cook_time) STORED,
    servings INTEGER NOT NULL DEFAULT 4,
    calories_per_serving INTEGER,
    protein_per_serving FLOAT,
    fat_per_serving FLOAT,
    carbs_per_serving FLOAT,
    category VARCHAR(50),
    cuisine VARCHAR(50),
    rating FLOAT DEFAULT 0,
    view_count INTEGER DEFAULT 0,
    is_public BOOLEAN DEFAULT FALSE, -- 审核状态或私有状态
    tags TEXT[], -- PostgreSQL数组类型
    cover_image TEXT,
    images TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 食材表（初始300+数据）
CREATE TABLE IF NOT EXISTS ingredients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    name_en VARCHAR(100),
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50),
    description TEXT,
    origin VARCHAR(100),
    storage_method TEXT NOT NULL,
    shelf_life INTEGER, -- 天数
    nutrition_per_100g JSONB,
    image_url TEXT NOT NULL,
    thumbnail_url TEXT,
    tags TEXT[],
    season TEXT[],
    allergens TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 食谱食材关联表
CREATE TABLE IF NOT EXISTS recipe_ingredients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipe_id UUID REFERENCES recipes(id) ON DELETE CASCADE,
    ingredient_id UUID REFERENCES ingredients(id) ON DELETE CASCADE,
    amount FLOAT NOT NULL,
    unit VARCHAR(20) NOT NULL,
    notes TEXT,
    order_index INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(recipe_id, ingredient_id, order_index)
);

-- 制作步骤表
CREATE TABLE IF NOT EXISTS recipe_steps (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipe_id UUID REFERENCES recipes(id) ON DELETE CASCADE,
    step_number INTEGER NOT NULL,
    instruction TEXT NOT NULL,
    instruction_en TEXT,
    image_url TEXT,
    duration INTEGER, -- 分钟
    tips TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(recipe_id, step_number)
);

-- 食材搭配表
CREATE TABLE IF NOT EXISTS ingredient_pairings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ingredient_id UUID REFERENCES ingredients(id) ON DELETE CASCADE,
    paired_ingredient_id UUID REFERENCES ingredients(id) ON DELETE CASCADE,
    pairing_type VARCHAR(50), -- 'complementary', 'substitute', etc.
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(ingredient_id, paired_ingredient_id)
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_recipes_name ON recipes(name);
CREATE INDEX IF NOT EXISTS idx_recipes_author ON recipes(author_id);
CREATE INDEX IF NOT EXISTS idx_recipes_category ON recipes(category);
CREATE INDEX IF NOT EXISTS idx_recipes_cuisine ON recipes(cuisine);
CREATE INDEX IF NOT EXISTS idx_recipes_rating ON recipes(rating DESC);
CREATE INDEX IF NOT EXISTS idx_recipes_view_count ON recipes(view_count DESC);

CREATE INDEX IF NOT EXISTS idx_ingredients_name ON ingredients(name);
CREATE INDEX IF NOT EXISTS idx_ingredients_category ON ingredients(category);
CREATE INDEX IF NOT EXISTS idx_ingredients_name_en ON ingredients(name_en);

CREATE INDEX IF NOT EXISTS idx_recipe_ingredients_recipe_id ON recipe_ingredients(recipe_id);
CREATE INDEX IF NOT EXISTS idx_recipe_ingredients_ingredient_id ON recipe_ingredients(ingredient_id);
CREATE INDEX IF NOT EXISTS idx_recipe_steps_recipe_id ON recipe_steps(recipe_id);

-- Supabase RLS策略

-- 1. Profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public profiles are viewable by everyone" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- 2. Recipes
ALTER TABLE recipes ENABLE ROW LEVEL SECURITY;
-- 所有人可见公开食谱
CREATE POLICY "Public recipes are viewable by everyone" ON recipes FOR SELECT USING (is_public = true);
-- 作者可见自己的所有食谱（包括私有）
CREATE POLICY "Authors can view own recipes" ON recipes FOR SELECT USING (auth.uid() = author_id);
-- 注册用户可以创建食谱
CREATE POLICY "Authenticated users can create recipes" ON recipes FOR INSERT WITH CHECK (auth.uid() = author_id);
-- 作者可以更新自己的食谱
CREATE POLICY "Authors can update own recipes" ON recipes FOR UPDATE USING (auth.uid() = author_id);
-- 作者可以删除自己的食谱
CREATE POLICY "Authors can delete own recipes" ON recipes FOR DELETE USING (auth.uid() = author_id);

-- 3. Ingredients (通常由管理员维护，此处简化为全员可读)
ALTER TABLE ingredients ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Ingredients are viewable by everyone" ON ingredients FOR SELECT USING (true);

-- 4. Recipe Ingredients & Steps (跟随食谱权限)
ALTER TABLE recipe_ingredients ENABLE ROW LEVEL SECURITY;
CREATE POLICY "View recipe ingredients" ON recipe_ingredients FOR SELECT USING (
    EXISTS (SELECT 1 FROM recipes WHERE id = recipe_ingredients.recipe_id AND (is_public = true OR author_id = auth.uid()))
);
CREATE POLICY "Authors can manage recipe ingredients" ON recipe_ingredients FOR ALL USING (
    EXISTS (SELECT 1 FROM recipes WHERE id = recipe_ingredients.recipe_id AND author_id = auth.uid())
);

ALTER TABLE recipe_steps ENABLE ROW LEVEL SECURITY;
CREATE POLICY "View recipe steps" ON recipe_steps FOR SELECT USING (
    EXISTS (SELECT 1 FROM recipes WHERE id = recipe_steps.recipe_id AND (is_public = true OR author_id = auth.uid()))
);
CREATE POLICY "Authors can manage recipe steps" ON recipe_steps FOR ALL USING (
    EXISTS (SELECT 1 FROM recipes WHERE id = recipe_steps.recipe_id AND author_id = auth.uid())
);

-- Grant permissions to anon and authenticated roles
GRANT SELECT ON profiles TO anon;
GRANT SELECT ON recipes TO anon;
GRANT SELECT ON ingredients TO anon;
GRANT SELECT ON recipe_ingredients TO anon;
GRANT SELECT ON recipe_steps TO anon;
GRANT SELECT ON ingredient_pairings TO anon;

GRANT ALL ON profiles TO authenticated;
GRANT ALL ON recipes TO authenticated;
GRANT ALL ON ingredients TO authenticated;
GRANT ALL ON recipe_ingredients TO authenticated;
GRANT ALL ON recipe_steps TO authenticated;
GRANT ALL ON ingredient_pairings TO authenticated;
