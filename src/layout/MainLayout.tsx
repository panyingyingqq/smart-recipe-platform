import React from 'react';
import { Outlet, Link } from 'react-router-dom';
import { ChefHat, Search, BookOpen, User, Heart } from 'lucide-react';
import RecipeModal from '../components/RecipeModal';

const MainLayout: React.FC = () => {
  return (
    <div className="min-h-screen bg-kawaii-base text-kawaii-text-main font-cute relative overflow-x-hidden selection:bg-kawaii-pink-300 selection:text-white">
      
      {/* Decorative Background Elements - Soft Blobs */}
      <div className="fixed top-0 left-0 w-64 h-64 bg-kawaii-pink-100 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob -z-10"></div>
      <div className="fixed top-0 right-0 w-64 h-64 bg-yellow-100 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob animation-delay-2000 -z-10"></div>
      <div className="fixed -bottom-32 left-20 w-64 h-64 bg-pink-100 rounded-full mix-blend-multiply filter blur-3xl opacity-70 animate-blob animation-delay-4000 -z-10"></div>

      <header className="sticky top-4 z-40 mx-4 md:mx-8">
        <div className="bg-white/90 backdrop-blur-md shadow-sticker rounded-full px-6 py-3 flex items-center justify-between border-2 border-white">
          <Link to="/" className="flex items-center gap-2 text-kawaii-pink-500 hover:text-kawaii-pink-700 transition-transform hover:scale-105 duration-300">
            <div className="bg-kawaii-pink-100 p-2 rounded-full">
                <ChefHat className="w-6 h-6" />
            </div>
            <span className="text-xl font-bold tracking-tight text-kawaii-pink-500">SmartCook</span>
          </Link>
          
          <nav className="hidden md:flex items-center gap-8">
            <Link to="/" className="text-kawaii-text-main hover:text-kawaii-pink-500 font-bold transition-colors">首页</Link>
            <Link to="/recipes" className="text-kawaii-text-main hover:text-kawaii-pink-500 font-bold transition-colors">食谱库</Link>
            <Link to="/upload" className="text-kawaii-text-main hover:text-kawaii-pink-500 font-bold transition-colors">发布食谱</Link>
          </nav>

          <div className="flex items-center gap-2">
            <Link to="/recipes" className="p-2 text-kawaii-pink-300 hover:text-kawaii-pink-500 transition-colors md:hidden">
              <Search className="w-6 h-6" />
            </Link>
            <Link to="/recipes" className="p-2 text-kawaii-pink-300 hover:text-kawaii-pink-500 transition-colors md:hidden">
              <BookOpen className="w-6 h-6" />
            </Link>
            <Link to="/login" className="p-2 bg-kawaii-pink-100 text-kawaii-pink-500 rounded-full hover:bg-kawaii-pink-500 hover:text-white transition-all shadow-sm">
              <User className="w-5 h-5" />
            </Link>
          </div>
        </div>
      </header>

      <main className="container mx-auto px-4 py-8 min-h-[calc(100vh-100px)]">
        <Outlet />
      </main>

      <footer className="bg-white/60 border-t-2 border-dashed border-kawaii-pink-100 py-8 mt-12">
        <div className="container mx-auto px-4 text-center text-kawaii-text-sub">
          <div className="flex items-center justify-center gap-2 mb-4 text-kawaii-pink-300">
            <Heart className="w-5 h-5 fill-current animate-pulse" />
            <span className="font-bold text-lg">SmartCook</span>
          </div>
          <p className="mb-2 text-sm font-medium">用爱与美食治愈每一天</p>
          <p className="text-xs opacity-70">© 2024 SmartCook Platform. All rights reserved.</p>
        </div>
      </footer>

      {/* Global Recipe Modal */}
      <RecipeModal />
    </div>
  );
};

export default MainLayout;
