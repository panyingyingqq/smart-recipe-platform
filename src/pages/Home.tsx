import React, { useState } from 'react';
import { supabase } from '../supabase/client';
import { Recipe } from '../types';
import { Dices } from 'lucide-react';
import { motion } from 'framer-motion';
import { useRecipeStore } from '../stores/recipeStore';

const Home: React.FC = () => {
  const [loading, setLoading] = useState(false);
  const [recipeIds, setRecipeIds] = useState<string[]>([]);
  const { openRecipe } = useRecipeStore();

  React.useEffect(() => {
    const fetchIds = async () => {
      const { data } = await supabase
        .from('recipes')
        .select('id')
        .eq('is_public', true);
      if (data) {
        setRecipeIds(data.map(d => d.id));
      }
    };
    fetchIds();
  }, []);

  const handleRandomize = async () => {
    setLoading(true);
    try {
      let currentIds = recipeIds;
      
      // If IDs haven't loaded yet, fetch them
      if (currentIds.length === 0) {
        const { data, error } = await supabase
          .from('recipes')
          .select('id')
          .eq('is_public', true);
          
        if (error) throw error;
        if (data) {
          currentIds = data.map(d => d.id);
          setRecipeIds(currentIds);
        }
      }

      if (currentIds.length === 0) {
        alert('暂无食谱数据');
        return;
      }

      const randomIndex = Math.floor(Math.random() * currentIds.length);
      const randomId = currentIds[randomIndex];

      const { data: recipeData, error: recipeError } = await supabase
        .from('recipes')
        .select(`
          *,
          ingredients:recipe_ingredients(
            amount, unit, notes, name, hint,
            ingredient:ingredients(name, image_url, category)
          ),
          steps:recipe_steps(*)
        `)
        .eq('id', randomId)
        .single();

      if (recipeError) throw recipeError;

      openRecipe(recipeData as Recipe);
    } catch (error) {
      console.error('Error fetching random recipe:', error);
      alert('获取食谱失败，请稍后重试');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="space-y-8">
      <section className="text-center py-12 md:py-20 relative z-10">
        <h1 className="text-4xl md:text-6xl font-bold text-kawaii-text-main mb-6 font-cute drop-shadow-sm tracking-wide">
          今天吃什么？
        </h1>
        <p className="text-xl text-kawaii-text-sub mb-10 max-w-2xl mx-auto font-cute">
          不知道做什么菜？让我们的智能食谱决策器帮你决定！
        </p>
        <button
          onClick={handleRandomize}
          disabled={loading}
          className="bg-kawaii-pink-500 text-white px-10 py-5 rounded-full text-2xl font-bold shadow-sticker hover:shadow-xl hover:scale-105 active:scale-95 transition-all transform flex items-center gap-4 mx-auto disabled:opacity-70 disabled:cursor-not-allowed font-cute border-4 border-white ring-4 ring-kawaii-pink-100"
        >
          <motion.div
            animate={loading ? { rotate: 360 } : {}}
            transition={loading ? { repeat: Infinity, duration: 0.3, ease: "linear" } : {}}
          >
            <Dices className="w-10 h-10" />
          </motion.div>
          {loading ? '正在挑选...' : '摇一摇'}
        </button>
      </section>
    </div>
  );
};

export default Home;
