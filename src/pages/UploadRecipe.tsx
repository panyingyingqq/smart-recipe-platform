import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../supabase/client';
import { Plus, Minus, Upload, Loader2, Save } from 'lucide-react';
import { User } from '@supabase/supabase-js';

const UploadRecipe: React.FC = () => {
  const navigate = useNavigate();
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Form State
  const [name, setName] = useState('');
  const [description, setDescription] = useState('');
  const [category, setCategory] = useState('主菜');
  const [difficulty, setDifficulty] = useState(3);
  const [prepTime, setPrepTime] = useState(15);
  const [cookTime, setCookTime] = useState(15);
  const [coverImage, setCoverImage] = useState('');
  const [ingredients, setIngredients] = useState<{ name: string; amount: number; unit: string }[]>([
    { name: '', amount: 0, unit: 'g' }
  ]);
  const [steps, setSteps] = useState<string[]>(['']);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate('/login');
      } else {
        setUser(session.user);
      }
    });
  }, [navigate]);

  const handleAddIngredient = () => {
    setIngredients([...ingredients, { name: '', amount: 0, unit: 'g' }]);
  };

  const handleRemoveIngredient = (index: number) => {
    const newIngredients = [...ingredients];
    newIngredients.splice(index, 1);
    setIngredients(newIngredients);
  };

  const handleIngredientChange = (index: number, field: string, value: any) => {
    const newIngredients = [...ingredients];
    // @ts-ignore
    newIngredients[index][field] = value;
    setIngredients(newIngredients);
  };

  const handleAddStep = () => {
    setSteps([...steps, '']);
  };

  const handleRemoveStep = (index: number) => {
    const newSteps = [...steps];
    newSteps.splice(index, 1);
    setSteps(newSteps);
  };

  const handleStepChange = (index: number, value: string) => {
    const newSteps = [...steps];
    newSteps[index] = value;
    setSteps(newSteps);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    setLoading(true);
    setError(null);

    try {
      // 1. Create Recipe
      const { data: recipeData, error: recipeError } = await supabase
        .from('recipes')
        .insert({
          author_id: user.id,
          name,
          description,
          category,
          difficulty,
          prep_time: prepTime,
          cook_time: cookTime,
          cover_image: coverImage || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80', // Default placeholder
          is_public: true, // Default to public for now
          servings: 4
        })
        .select()
        .single();

      if (recipeError) throw recipeError;
      const recipeId = recipeData.id;

      // 2. Process Ingredients
      const recipeIngredientsToInsert = [];
      for (let i = 0; i < ingredients.length; i++) {
        const item = ingredients[i];
        if (!item.name.trim()) continue;

        // Check if ingredient exists
        const { data: existingIng } = await supabase
          .from('ingredients')
          .select('id')
          .eq('name', item.name.trim())
          .maybeSingle();

        let ingredientId;
        if (existingIng) {
          ingredientId = existingIng.id;
        } else {
          // Create new ingredient
          const { data: newIng, error: ingError } = await supabase
            .from('ingredients')
            .insert({
              name: item.name.trim(),
              category: '其他', // Default category
              storage_method: '常温',
              image_url: 'https://images.unsplash.com/photo-1606914469725-e39c3ebc8d89?auto=format&fit=crop&w=200&q=80' // Placeholder
            })
            .select()
            .single();
          
          if (ingError) throw ingError;
          ingredientId = newIng.id;
        }

        recipeIngredientsToInsert.push({
          recipe_id: recipeId,
          ingredient_id: ingredientId,
          amount: item.amount,
          unit: item.unit,
          order_index: i + 1
        });
      }

      if (recipeIngredientsToInsert.length > 0) {
        const { error: riError } = await supabase
          .from('recipe_ingredients')
          .insert(recipeIngredientsToInsert);
        if (riError) throw riError;
      }

      // 3. Process Steps
      const stepsToInsert = steps
        .map((instruction, index) => {
            if (!instruction.trim()) return null;
            return {
                recipe_id: recipeId,
                step_number: index + 1,
                instruction: instruction.trim()
            };
        })
        .filter(Boolean);

      if (stepsToInsert.length > 0) {
        const { error: stepError } = await supabase
            // @ts-ignore
          .from('recipe_steps')
          .insert(stepsToInsert);
        if (stepError) throw stepError;
      }

      alert('食谱发布成功！');
      navigate('/recipes');

    } catch (err: any) {
      console.error('Error uploading recipe:', err);
      setError(err.message || '发布失败，请稍后重试');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto bg-white rounded-3xl shadow-sticker border-4 border-white p-6 md:p-10 my-8 relative z-10">
      <h1 className="text-3xl font-bold text-kawaii-text-main mb-8 flex items-center gap-3 font-cute">
        <div className="bg-kawaii-pink-100 p-3 rounded-full shadow-soft">
          <Upload className="w-8 h-8 text-kawaii-pink-500" />
        </div>
        发布新食谱
      </h1>

      {error && (
        <div className="bg-red-50 text-red-500 p-4 rounded-2xl mb-6 border border-red-100 font-cute shadow-sm">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-8">
        {/* Basic Info */}
        <div className="space-y-5">
          <h2 className="text-xl font-bold text-kawaii-text-main border-l-4 border-kawaii-pink-500 pl-3 font-cute">基本信息</h2>
          
          <div>
            <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">食谱名称 *</label>
            <input
              type="text"
              required
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              placeholder="例如：红烧肉"
            />
          </div>

          <div>
            <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">描述</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              rows={3}
              placeholder="简要介绍这道菜..."
            />
          </div>

          <div className="grid grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">分类</label>
              <select
                value={category}
                onChange={(e) => setCategory(e.target.value)}
                className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              >
                <option>主菜</option>
                <option>凉菜</option>
                <option>汤羹</option>
                <option>主食</option>
                <option>甜点</option>
                <option>饮品</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">难度 (1-5)</label>
              <input
                type="number"
                min="1"
                max="5"
                value={difficulty}
                onChange={(e) => setDifficulty(parseInt(e.target.value))}
                className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">准备时间 (分钟)</label>
              <input
                type="number"
                value={prepTime}
                onChange={(e) => setPrepTime(parseInt(e.target.value))}
                className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              />
            </div>
            <div>
              <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">烹饪时间 (分钟)</label>
              <input
                type="number"
                value={cookTime}
                onChange={(e) => setCookTime(parseInt(e.target.value))}
                className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">封面图片 URL</label>
            <input
              type="url"
              value={coverImage}
              onChange={(e) => setCoverImage(e.target.value)}
              className="w-full px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
              placeholder="https://example.com/image.jpg"
            />
          </div>
        </div>

        {/* Ingredients */}
        <div className="space-y-5">
          <div className="flex justify-between items-center border-l-4 border-kawaii-pink-500 pl-3">
            <h2 className="text-xl font-bold text-kawaii-text-main font-cute">食材清单</h2>
            <button
              type="button"
              onClick={handleAddIngredient}
              className="text-kawaii-pink-500 flex items-center gap-1 hover:text-kawaii-pink-700 font-bold font-cute bg-kawaii-pink-50 px-3 py-1 rounded-full transition-colors"
            >
              <Plus className="w-4 h-4" /> 添加食材
            </button>
          </div>
          
          <div className="space-y-3">
            {ingredients.map((ing, idx) => (
              <div key={idx} className="flex gap-3 items-center">
                <input
                  type="text"
                  placeholder="食材名称"
                  value={ing.name}
                  onChange={(e) => handleIngredientChange(idx, 'name', e.target.value)}
                  className="flex-1 px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
                  required
                />
                <input
                  type="number"
                  placeholder="数量"
                  value={ing.amount}
                  onChange={(e) => handleIngredientChange(idx, 'amount', parseFloat(e.target.value))}
                  className="w-24 px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
                />
                <input
                  type="text"
                  placeholder="单位"
                  value={ing.unit}
                  onChange={(e) => handleIngredientChange(idx, 'unit', e.target.value)}
                  className="w-24 px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
                />
                {ingredients.length > 1 && (
                  <button
                    type="button"
                    onClick={() => handleRemoveIngredient(idx)}
                    className="p-2 text-kawaii-pink-300 hover:text-red-500 transition-colors"
                  >
                    <Minus className="w-6 h-6" />
                  </button>
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Steps */}
        <div className="space-y-5">
          <div className="flex justify-between items-center border-l-4 border-kawaii-pink-500 pl-3">
            <h2 className="text-xl font-bold text-kawaii-text-main font-cute">制作步骤</h2>
            <button
              type="button"
              onClick={handleAddStep}
              className="text-kawaii-pink-500 flex items-center gap-1 hover:text-kawaii-pink-700 font-bold font-cute bg-kawaii-pink-50 px-3 py-1 rounded-full transition-colors"
            >
              <Plus className="w-4 h-4" /> 添加步骤
            </button>
          </div>
          
          <div className="space-y-4">
            {steps.map((step, idx) => (
              <div key={idx} className="flex gap-4 items-start">
                <span className="mt-2 w-8 h-8 rounded-full bg-kawaii-pink-500 text-white flex items-center justify-center font-bold flex-shrink-0 shadow-soft ring-2 ring-kawaii-pink-100 font-cute">
                  {idx + 1}
                </span>
                <textarea
                  value={step}
                  onChange={(e) => handleStepChange(idx, e.target.value)}
                  placeholder={`步骤 ${idx + 1} 说明...`}
                  className="flex-1 px-4 py-3 rounded-xl border-2 border-kawaii-pink-200 focus:ring-4 focus:ring-kawaii-pink-100 focus:border-kawaii-pink-500 outline-none bg-kawaii-pink-50 font-cute text-kawaii-text-main transition-all"
                  rows={2}
                  required
                />
                {steps.length > 1 && (
                  <button
                    type="button"
                    onClick={() => handleRemoveStep(idx)}
                    className="p-2 text-kawaii-pink-300 hover:text-red-500 mt-2 transition-colors"
                  >
                    <Minus className="w-6 h-6" />
                  </button>
                )}
              </div>
            ))}
          </div>
        </div>

        <div className="pt-8 border-t-2 border-kawaii-pink-100 flex justify-end">
          <button
            type="submit"
            disabled={loading}
            className="bg-kawaii-pink-500 text-white px-10 py-4 rounded-full font-bold shadow-sticker hover:shadow-xl hover:scale-105 active:scale-95 transition-all flex items-center gap-3 disabled:opacity-70 disabled:cursor-not-allowed font-cute text-lg"
          >
            {loading ? (
              <>
                <Loader2 className="w-6 h-6 animate-spin" />
                发布中...
              </>
            ) : (
              <>
                <Save className="w-6 h-6" />
                发布食谱
              </>
            )}
          </button>
        </div>
      </form>
    </div>
  );
};

export default UploadRecipe;
