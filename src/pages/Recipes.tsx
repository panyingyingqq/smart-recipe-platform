import React, { useState, useEffect, useMemo } from 'react';
import { supabase } from '../supabase/client';
import { Recipe } from '../types';
import { Search, Loader2, AlertCircle, Clock, Flame } from 'lucide-react';
import { useRecipeStore } from '../stores/recipeStore';
import { pinyin } from 'pinyin-pro';
import { useInView } from 'react-intersection-observer';

const Recipes: React.FC = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [inputValue, setInputValue] = useState(''); // For debounced input
  const [selectedLetter, setSelectedLetter] = useState<string | null>(null);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const { openRecipe } = useRecipeStore();
  
  // Pagination / Infinite Scroll state
  const [visibleCount, setVisibleCount] = useState(12);
  const { ref: loadMoreRef, inView } = useInView({
    threshold: 0.1,
    rootMargin: '100px',
  });

  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  // Debounce search input
  useEffect(() => {
    const timer = setTimeout(() => {
      setSearchQuery(inputValue);
    }, 300);
    return () => clearTimeout(timer);
  }, [inputValue]);

  // Load more when scrolled to bottom
  useEffect(() => {
    if (inView) {
      setVisibleCount(prev => prev + 12);
    }
  }, [inView]);

  // Reset visible count when filters change
  useEffect(() => {
    setVisibleCount(12);
  }, [searchQuery, selectedLetter]);

  // Process recipes to include group letter based on Chinese Pinyin
  const processedRecipes = useMemo(() => {
    const processed = recipes.map(recipe => {
      // Generate Pinyin first letters (e.g., "炸鸡" -> ["z", "j"])
      const pinyinResult = pinyin(recipe.name, { 
        pattern: 'first', 
        toneType: 'none', 
        type: 'array' 
      });
      
      // Get the first letter of the entire name
      const firstChar = pinyinResult?.[0]?.charAt(0).toUpperCase();
      const groupLetter = (firstChar && /^[A-Z]$/.test(firstChar)) ? firstChar : '#';
      
      // Generate full pinyin for sorting (e.g., "炸鸡" -> "zhaji")
      const fullPinyin = pinyin(recipe.name, {
        toneType: 'none',
        separator: '',
        type: 'string'
      });

      return {
        ...recipe,
        groupLetter,
        fullPinyin
      };
    });

    // Sort by Group Letter (A-Z, then #) and then by Full Pinyin
    return processed.sort((a, b) => {
      if (a.groupLetter === b.groupLetter) {
        return a.fullPinyin.localeCompare(b.fullPinyin);
      }
      if (a.groupLetter === '#') return 1;
      if (b.groupLetter === '#') return -1;
      return a.groupLetter.localeCompare(b.groupLetter);
    });
  }, [recipes]);

  // Generate suggestions based on search query
  const suggestions = useMemo(() => {
    if (!inputValue.trim()) return [];
    const query = inputValue.toLowerCase();
    const uniqueSuggestions = new Set<string>();
    
    // Search in recipe names
    for (const recipe of recipes) {
        if (recipe.name.toLowerCase().includes(query)) {
            uniqueSuggestions.add(recipe.name);
        }
        if (uniqueSuggestions.size >= 8) break;
    }
    
    return Array.from(uniqueSuggestions);
  }, [inputValue, recipes]);

  useEffect(() => {
    fetchRecipes();
  }, []);

  const fetchRecipes = async () => {
    try {
      setLoading(true);
      setError(null);
      
      const { data, error: fetchError } = await supabase
        .from('recipes')
        .select(`
          *,
          ingredients:recipe_ingredients(
            amount, unit, notes, hint, name,
            ingredient:ingredients(name, image_url, category)
          ),
          steps:recipe_steps(*)
        `)
        .eq('is_public', true)
        .order('name_en', { ascending: true }); // Default sort A-Z

      if (fetchError) throw fetchError;
      
      setRecipes(data as Recipe[] || []);
    } catch (err: any) {
      console.error('Error fetching recipes:', err);
      setError('无法加载食谱数据，请稍后重试');
    } finally {
      setLoading(false);
    }
  };

  // Filter logic
  const filteredRecipes = useMemo(() => {
    return processedRecipes.filter((recipe) => {
      // 1. A-Z Filter
      if (selectedLetter) {
        if (recipe.groupLetter !== selectedLetter) {
          return false;
        }
      }

      // 2. Search Query Filter
      if (searchQuery) {
        const query = searchQuery.toLowerCase();
        const matchesName = recipe.name.toLowerCase().includes(query);
        const matchesNameEn = recipe.name_en?.toLowerCase().includes(query);
        const matchesIngredient = recipe.ingredients?.some(ri => 
          ri.ingredient?.name.toLowerCase().includes(query)
        );
        
        return matchesName || matchesNameEn || matchesIngredient;
      }
      
      return true;
    });
  }, [processedRecipes, selectedLetter, searchQuery]);

  // Calculate available letters for navigation
  const availableLetters = useMemo(() => {
    const letters = new Set<string>();
    processedRecipes.forEach(recipe => {
      if (alphabet.includes(recipe.groupLetter)) {
        letters.add(recipe.groupLetter);
      }
    });
    return letters;
  }, [processedRecipes, alphabet]);

  const displayedRecipes = filteredRecipes.slice(0, visibleCount);

  return (
    <div className="space-y-8 relative z-10">
      <section className="text-center py-8">
        <h1 className="text-3xl md:text-5xl font-bold text-kawaii-text-main mb-4 font-cute tracking-wide">
          食谱目录
        </h1>
        <p className="text-kawaii-text-sub mb-8 max-w-2xl mx-auto font-cute text-lg">
          按字母索引或关键词搜索，探索我们的美食宝库。
        </p>

        {/* Search Bar */}
        <div className="relative max-w-xl mx-auto mb-10 z-20">
          <input
            type="text"
            placeholder="搜索食谱、食材 (如: 宫保鸡丁, 鸡肉)..."
            value={inputValue}
            onChange={(e) => {
              setInputValue(e.target.value);
              setShowSuggestions(true);
              setSelectedLetter(null); // Clear letter filter on search
            }}
            onFocus={() => setShowSuggestions(true)}
            onBlur={() => setTimeout(() => setShowSuggestions(false), 200)}
            className="w-full pl-12 pr-4 py-4 rounded-full border-2 border-kawaii-pink-200 focus:border-kawaii-pink-500 focus:ring-4 focus:ring-kawaii-pink-100 outline-none transition-all shadow-soft font-cute text-kawaii-text-main bg-white/90 backdrop-blur-sm"
          />
          <Search className="absolute left-4 top-4 w-6 h-6 text-kawaii-pink-400" />
          
          {/* Suggestions Dropdown */}
          {showSuggestions && suggestions.length > 0 && (
            <div className="absolute top-full left-0 right-0 mt-2 bg-white rounded-2xl shadow-sticker border border-kawaii-pink-100 overflow-hidden z-30">
              {suggestions.map((s, idx) => (
                <div
                  key={idx}
                  onClick={() => {
                    setInputValue(s);
                    setShowSuggestions(false);
                  }}
                  className="px-4 py-3 hover:bg-kawaii-pink-50 cursor-pointer text-left text-kawaii-text-main font-cute border-b border-gray-50 last:border-0"
                >
                  {s}
                </div>
              ))}
            </div>
          )}
        </div>

        {/* A-Z Navigation */}
        <div className="flex flex-wrap justify-center gap-3 mb-10 px-2">
          <button
            onClick={() => setSelectedLetter(null)}
            className={`px-4 py-2 rounded-xl text-sm font-bold transition-all font-cute shadow-sm ${
              selectedLetter === null
                ? 'bg-kawaii-pink-500 text-white shadow-sticker transform scale-105 ring-2 ring-white'
                : 'bg-white text-kawaii-text-sub hover:bg-kawaii-pink-100 hover:text-kawaii-pink-700'
            }`}
          >
            全部
          </button>
          {alphabet.map((letter) => {
            const isDisabled = !availableLetters.has(letter);
            return (
                <button
                key={letter}
                disabled={isDisabled}
                onClick={() => {
                    setSelectedLetter(letter);
                    setInputValue(''); // Clear search on letter click
                }}
                className={`w-10 h-10 rounded-xl text-sm font-bold flex items-center justify-center transition-all font-cute ${
                    selectedLetter === letter
                    ? 'bg-kawaii-pink-500 text-white shadow-sticker transform scale-110 ring-2 ring-white z-10'
                    : isDisabled 
                        ? 'bg-gray-50 text-gray-300 cursor-not-allowed'
                        : 'bg-white text-kawaii-text-sub hover:bg-kawaii-pink-100 hover:text-kawaii-pink-700 shadow-sm'
                }`}
                >
                {letter}
                </button>
            );
          })}
        </div>
      </section>

      {/* Error Message */}
      {error && (
        <div className="max-w-md mx-auto bg-red-50 text-red-600 p-4 rounded-2xl flex items-center gap-3 mb-8 shadow-sm font-cute border border-red-100">
          <AlertCircle className="w-5 h-5 flex-shrink-0" />
          <p>{error}</p>
        </div>
      )}

      {/* Recipes Grid */}
      {loading ? (
        <div className="flex justify-center py-20">
          <Loader2 className="w-12 h-12 text-kawaii-pink-500 animate-spin" />
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 px-4 pb-12">
          {displayedRecipes.length > 0 ? (
            <>
              {displayedRecipes.map((recipe) => (
                <div
                  key={recipe.id}
                  onClick={() => openRecipe(recipe)}
                  className="bg-white rounded-3xl shadow-soft overflow-hidden hover:shadow-sticker transition-all cursor-pointer group border-4 border-white hover:border-kawaii-pink-100 hover:-translate-y-1 content-visibility-auto contain-intrinsic-size-[400px]"
                >
                  <div className="h-52 overflow-hidden relative">
                    <img
                      src={recipe.cover_image || 'https://images.unsplash.com/photo-1495521841625-f342588d6e65?auto=format&fit=crop&w=800&q=80'}
                      alt={recipe.name}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700"
                      loading="lazy"
                      decoding="async"
                      width="400"
                      height="208"
                    />
                    <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/50 to-transparent p-4 pt-12">
                      <h3 className="font-bold text-xl text-white mb-1 font-cute drop-shadow-md">
                        {recipe.name}
                      </h3>
                    </div>
                  </div>
                  <div className="p-5">
                    <div className="flex items-center gap-4 text-sm text-kawaii-text-sub mb-3 font-cute">
                      <div className="flex items-center gap-1">
                        <Clock className="w-4 h-4 text-kawaii-pink-400" />
                        <span>{recipe.total_time}分</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Flame className="w-4 h-4 text-kawaii-pink-400" />
                        <span>难度 {recipe.difficulty}</span>
                      </div>
                    </div>
                    <p className="text-kawaii-text-sub text-sm line-clamp-2 font-cute leading-relaxed">
                      {recipe.description}
                    </p>
                  </div>
                </div>
              ))}
              
              {/* Load More Sentinel */}
              {visibleCount < filteredRecipes.length && (
                <div ref={loadMoreRef} className="col-span-full flex justify-center py-8">
                  <Loader2 className="w-8 h-8 animate-spin text-kawaii-pink-300" />
                </div>
              )}
            </>
          ) : (
            <div className="col-span-full text-center py-10 text-kawaii-text-sub flex flex-col items-center gap-4 font-cute">
              <div className="w-20 h-20 bg-kawaii-pink-50 rounded-full flex items-center justify-center">
                <Search className="w-10 h-10 text-kawaii-pink-200" />
              </div>
              <p className="text-lg">没有找到匹配的食谱</p>
              <button 
                onClick={() => setInputValue('')}
                className="text-kawaii-pink-500 text-sm hover:underline hover:text-kawaii-pink-700"
              >
                清除搜索
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Recipes;
