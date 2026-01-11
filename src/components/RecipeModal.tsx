import React, { useState, useEffect } from 'react';
import { RecipeIngredient, RecipeStep } from '../types';
import { Clock, Flame, ChefHat, X, Heart, Lightbulb, Edit, Save, Check } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { supabase } from '../supabase/client';
import { useNavigate } from 'react-router-dom';
import { User } from '@supabase/supabase-js';
import { useRecipeStore } from '../stores/recipeStore';

const RecipeModal: React.FC = () => {
  const { isOpen, selectedRecipe: recipe, closeRecipe, openRecipe } = useRecipeStore();
  const [user, setUser] = useState<User | null>(null);
  const [isFavorite, setIsFavorite] = useState(false);
  const [isEditingImage, setIsEditingImage] = useState(false);
  const [newImageUrl, setNewImageUrl] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
    });
  }, []);

  useEffect(() => {
    if (user && recipe) {
      checkFavoriteStatus();
      setNewImageUrl(recipe.cover_image || '');
    } else {
      setIsFavorite(false);
    }
  }, [user, recipe]);

  // Handle ESC key
  useEffect(() => {
    const handleEsc = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (isEditingImage) {
            setIsEditingImage(false);
        } else {
            closeRecipe();
        }
      }
    };
    if (isOpen) {
      window.addEventListener('keydown', handleEsc);
    }
    return () => {
      window.removeEventListener('keydown', handleEsc);
    };
  }, [isOpen, closeRecipe, isEditingImage]);

  const checkFavoriteStatus = async () => {
    if (!user || !recipe) return;
    const { data } = await supabase
      .from('favorites')
      .select('id')
      .eq('user_id', user.id)
      .eq('recipe_id', recipe.id)
      .maybeSingle();
    setIsFavorite(!!data);
  };

  const toggleFavorite = async () => {
    if (!user) {
      closeRecipe();
      navigate('/login');
      return;
    }
    if (!recipe) return;

    if (isFavorite) {
      const { error } = await supabase
        .from('favorites')
        .delete()
        .eq('user_id', user.id)
        .eq('recipe_id', recipe.id);
      if (!error) setIsFavorite(false);
    } else {
      const { error } = await supabase
        .from('favorites')
        .insert({ user_id: user.id, recipe_id: recipe.id });
      if (!error) setIsFavorite(true);
    }
  };

  const handleSaveImage = async () => {
    if (!recipe || !newImageUrl.trim()) return;

    try {
      const { error } = await supabase
        .from('recipes')
        .update({ cover_image: newImageUrl.trim() })
        .eq('id', recipe.id);

      if (error) throw error;

      // Update local state via store
      openRecipe({ ...recipe, cover_image: newImageUrl.trim() });
      setIsEditingImage(false);
    } catch (error) {
      console.error('Error updating image:', error);
      alert('更新图片失败，请重试');
    }
  };

  return (
    <AnimatePresence>
      {isOpen && recipe && (
        <div className="fixed inset-0 z-50 flex items-end md:items-center justify-center sm:p-4">
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={closeRecipe}
            className="absolute inset-0 bg-black/60 backdrop-blur-sm"
          />

          {/* Modal Content */}
          <motion.div
            initial={{ y: '100%' }}
            animate={{ y: 0 }}
            exit={{ y: '100%' }}
            transition={{ type: 'spring', damping: 25, stiffness: 200 }}
            className="bg-kawaii-card rounded-t-3xl md:rounded-3xl shadow-sticker w-full max-w-5xl h-[90vh] md:h-[85vh] overflow-hidden relative z-10 flex flex-col md:flex-row border-4 border-white"
          >
            {/* Close & Favorite Buttons (Floating) */}
            <div className="absolute top-4 right-4 flex gap-2 z-20">
              <button
                onClick={toggleFavorite}
                className="p-2 bg-white/90 rounded-full hover:bg-kawaii-pink-100 transition-colors shadow-soft"
              >
                <Heart className={`w-6 h-6 ${isFavorite ? 'fill-kawaii-pink-500 text-kawaii-pink-500' : 'text-gray-400'}`} />
              </button>
              <button
                onClick={closeRecipe}
                className="p-2 bg-white/90 rounded-full hover:bg-kawaii-pink-100 transition-colors shadow-soft"
              >
                <X className="w-6 h-6 text-gray-500" />
              </button>
            </div>

            {/* Left: Image (Mobile: Top) */}
            <div className="h-64 md:h-full md:w-5/12 relative flex-shrink-0 group/image">
              <img
                src={recipe.cover_image || 'https://images.unsplash.com/photo-1495521841625-f342588d6e65?auto=format&fit=crop&w=800&q=80'}
                alt={recipe.name}
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-transparent md:hidden"></div>
              
              {/* Edit Image Button (Visible on Hover or Editing) */}
              {(isEditingImage || user) && (
                <div className={`absolute bottom-4 right-4 z-20 transition-opacity duration-200 ${isEditingImage ? 'opacity-100' : 'opacity-0 group-hover/image:opacity-100'}`}>
                    {isEditingImage ? (
                        <div className="bg-white p-3 rounded-2xl shadow-sticker flex flex-col gap-2 w-64 absolute bottom-full right-0 mb-2">
                            <label className="text-xs font-bold text-gray-500 uppercase font-cute">修改图片链接</label>
                            <input 
                                type="text" 
                                value={newImageUrl}
                                onChange={(e) => setNewImageUrl(e.target.value)}
                                className="text-sm border border-kawaii-pink-200 rounded-xl px-3 py-2 w-full focus:outline-none focus:border-kawaii-pink-500 bg-kawaii-pink-50"
                                placeholder="https://..."
                            />
                            <div className="flex gap-2 justify-end mt-1">
                                <button 
                                    onClick={() => setIsEditingImage(false)}
                                    className="text-xs text-gray-500 hover:text-gray-700 px-2 py-1 font-cute"
                                >
                                    取消
                                </button>
                                <button 
                                    onClick={handleSaveImage}
                                    className="text-xs bg-kawaii-pink-500 text-white px-3 py-1 rounded-full hover:bg-kawaii-pink-700 flex items-center gap-1 font-cute shadow-sm"
                                >
                                    <Check className="w-3 h-3" /> 保存
                                </button>
                            </div>
                        </div>
                    ) : (
                        <button
                            onClick={() => {
                                setNewImageUrl(recipe.cover_image || '');
                                setIsEditingImage(true);
                            }}
                            className="p-2 bg-white/90 rounded-full hover:bg-kawaii-pink-50 transition-colors shadow-soft flex items-center gap-2 px-3 text-sm font-medium text-gray-700 font-cute"
                        >
                            <Edit className="w-4 h-4" />
                            <span>更换图片</span>
                        </button>
                    )}
                </div>
              )}

              <div className="absolute bottom-4 left-4 text-white md:hidden pr-12">
                <h2 className="text-2xl font-bold leading-tight font-cute drop-shadow-md">{recipe.name}</h2>
                <p className="opacity-90 text-sm font-cute">{recipe.name_en}</p>
              </div>
            </div>

            {/* Right: Content (Scrollable) */}
            <div className="flex-1 overflow-y-auto p-6 md:p-8 bg-kawaii-card scrollbar-thin scrollbar-thumb-kawaii-pink-200 scrollbar-track-transparent">
              <div className="hidden md:block mb-6">
                <h2 className="text-3xl font-bold text-kawaii-text-main mb-1 font-cute">{recipe.name}</h2>
                <p className="text-kawaii-text-sub text-lg font-cute">{recipe.name_en}</p>
              </div>

              {/* Meta Info */}
              <div className="flex flex-wrap items-center gap-3 text-sm text-kawaii-text-main mb-6 font-cute">
                <div className="flex items-center gap-1.5 bg-kawaii-pink-100 px-4 py-2 rounded-full text-kawaii-pink-700 font-bold shadow-sm">
                  <Clock className="w-4 h-4" />
                  <span>{recipe.total_time} 分钟</span>
                </div>
                <div className="flex items-center gap-1.5 bg-kawaii-pink-100 px-4 py-2 rounded-full text-kawaii-pink-700 font-bold shadow-sm">
                  <Flame className="w-4 h-4" />
                  <span>难度 {recipe.difficulty}/5</span>
                </div>
                <div className="flex items-center gap-1.5 bg-kawaii-pink-100 px-4 py-2 rounded-full text-kawaii-pink-700 font-bold shadow-sm">
                  <ChefHat className="w-4 h-4" />
                  <span>{recipe.category}</span>
                </div>
              </div>

              <p className="text-kawaii-text-sub italic mb-8 border-l-4 border-kawaii-pink-300 pl-4 py-2 bg-white/50 rounded-r-xl font-cute">
                "{recipe.description}"
              </p>

              <div className="grid lg:grid-cols-2 gap-8">
                {/* Ingredients & Seasonings */}
                <div>
                  <h3 className="font-bold text-kawaii-text-main mb-4 text-lg flex items-center gap-2 font-cute">
                    <span className="w-2 h-6 bg-kawaii-pink-500 rounded-full"></span>
                    食材准备
                  </h3>
                  
                  {/* Unified Ingredients List */}
                  {(() => {
                    const ingredients = recipe.ingredients || [];
                    const seasonings = ingredients.filter(i => i.ingredient?.category === '调味品');
                    const mainIngredients = ingredients.filter(i => i.ingredient?.category !== '调味品');
                    const hasSeasonings = seasonings.length > 0;
                    
                    if (hasSeasonings) {
                        return (
                            <>
                                {/* Main Ingredients */}
                                <div className="mb-6 bg-white p-4 rounded-2xl shadow-soft border border-kawaii-pink-100">
                                    <h4 className="text-sm font-bold text-kawaii-pink-500 uppercase tracking-wider mb-3 font-cute border-b border-kawaii-pink-100 pb-2">主料</h4>
                                    <ul className="space-y-3">
                                    {mainIngredients.map((item: RecipeIngredient, idx: number) => (
                                        <li key={idx} className="flex justify-between items-center">
                                        <div className="flex flex-col">
                                            <span className="text-kawaii-text-main font-medium font-cute">{item.name || item.ingredient?.name || '未知食材'}</span>
                                            {item.hint && <span className="text-xs text-gray-400 font-cute">{item.hint}</span>}
                                        </div>
                                        <span className="text-kawaii-pink-700 text-sm bg-kawaii-pink-50 px-2 py-1 rounded-lg font-cute border border-kawaii-pink-100 whitespace-nowrap ml-2">
                                            {item.amount} {item.unit}
                                        </span>
                                        </li>
                                    ))}
                                    </ul>
                                </div>

                                {/* Seasonings */}
                                <div className="bg-white p-4 rounded-2xl shadow-soft border border-kawaii-pink-100">
                                    <h4 className="text-sm font-bold text-kawaii-pink-500 uppercase tracking-wider mb-3 font-cute border-b border-kawaii-pink-100 pb-2">调料</h4>
                                    <ul className="space-y-3">
                                    {seasonings.map((item: RecipeIngredient, idx: number) => (
                                        <li key={idx} className="flex justify-between items-center">
                                        <div className="flex flex-col">
                                            <span className="text-kawaii-text-main font-medium font-cute">{item.name || item.ingredient?.name || '未知食材'}</span>
                                            {item.hint && <span className="text-xs text-gray-400 font-cute">{item.hint}</span>}
                                        </div>
                                        <span className="text-kawaii-pink-700 text-sm bg-kawaii-pink-50 px-2 py-1 rounded-lg font-cute border border-kawaii-pink-100 whitespace-nowrap ml-2">
                                            {item.amount} {item.unit}
                                        </span>
                                        </li>
                                    ))}
                                    </ul>
                                </div>
                            </>
                        );
                    } else {
                        // Fallback: Show all ingredients in one list
                         return (
                            <div className="mb-6 bg-white p-4 rounded-2xl shadow-soft border border-kawaii-pink-100">
                                <h4 className="text-sm font-bold text-kawaii-pink-500 uppercase tracking-wider mb-3 font-cute border-b border-kawaii-pink-100 pb-2">食材清单</h4>
                                <ul className="space-y-3">
                                {ingredients.map((item: RecipeIngredient, idx: number) => (
                                    <li key={idx} className="flex justify-between items-center">
                                    <div className="flex flex-col">
                                        <span className="text-kawaii-text-main font-medium font-cute">{item.name || item.ingredient?.name || '未知食材'}</span>
                                        {item.hint && <span className="text-xs text-gray-400 font-cute">{item.hint}</span>}
                                    </div>
                                    <span className="text-kawaii-pink-700 text-sm bg-kawaii-pink-50 px-2 py-1 rounded-lg font-cute border border-kawaii-pink-100 whitespace-nowrap ml-2">
                                        {item.amount} {item.unit}
                                    </span>
                                    </li>
                                ))}
                                </ul>
                            </div>
                        );
                    }
                  })()}
                </div>

                {/* Steps */}
                <div className="lg:col-span-2">
                  <h3 className="font-bold text-kawaii-text-main mb-4 text-lg flex items-center gap-2 font-cute">
                    <span className="w-2 h-6 bg-kawaii-pink-500 rounded-full"></span>
                    详细制作教程
                  </h3>
                  <div className="space-y-8">
                    {recipe.steps?.sort((a: RecipeStep, b: RecipeStep) => a.step_number - b.step_number).map((step: RecipeStep) => (
                      <div key={step.step_number} className="flex gap-4 group">
                        <div className="flex-shrink-0 w-10 h-10 rounded-full bg-kawaii-pink-500 text-white flex items-center justify-center font-bold shadow-soft text-lg mt-1 font-cute ring-4 ring-kawaii-pink-100">
                          {step.step_number}
                        </div>
                        <div className="flex-1 space-y-3">
                          {/* Instruction Text */}
                          <div className="text-kawaii-text-main leading-relaxed text-lg font-medium whitespace-pre-line font-cute bg-white p-4 rounded-2xl shadow-soft border border-kawaii-pink-100 relative">
                             {/* Decorative corner */}
                             <div className="absolute top-0 left-0 w-4 h-4 border-t-4 border-l-4 border-kawaii-pink-200 rounded-tl-xl -mt-1 -ml-1"></div>
                            {step.instruction}
                          </div>
                          
                          {/* Step Image */}
                          {step.image_url && (
                            <div className="rounded-2xl overflow-hidden shadow-sticker max-w-md border-4 border-white">
                              <img 
                                src={step.image_url} 
                                alt={`步骤 ${step.step_number}`} 
                                className="w-full h-auto object-cover hover:scale-105 transition-transform duration-500"
                                loading="lazy"
                              />
                            </div>
                          )}

                          {/* Tips */}
                          {step.tips && (
                            <div className="bg-orange-50 border-l-4 border-orange-300 p-4 rounded-r-2xl text-sm flex gap-3 items-start shadow-sm">
                              <Lightbulb className="w-5 h-5 text-orange-500 flex-shrink-0 mt-0.5" />
                              <div>
                                <span className="font-bold text-orange-800 block mb-1 font-cute">小贴士</span>
                                <p className="text-orange-800 leading-relaxed font-cute">{step.tips}</p>
                              </div>
                            </div>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
};

export default RecipeModal;
