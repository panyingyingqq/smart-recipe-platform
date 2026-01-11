import React, { useState } from 'react';
import { supabase } from '../supabase/client';
import { useNavigate } from 'react-router-dom';
import { ChefHat, Mail, Lock, Loader2 } from 'lucide-react';

const Login: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [isSignUp, setIsSignUp] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  const handleEmailAuth = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      if (isSignUp) {
        const { error: signUpError } = await supabase.auth.signUp({
          email,
          password,
        });
        if (signUpError) throw signUpError;
        alert('注册成功！请检查您的邮箱以确认账号。');
      } else {
        const { error: signInError } = await supabase.auth.signInWithPassword({
          email,
          password,
        });
        if (signInError) throw signInError;
        navigate('/');
      }
    } catch (err: any) {
      setError(err.message || 'An unexpected error occurred');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-md mx-auto py-12 px-4 relative z-10">
      <div className="bg-white rounded-3xl shadow-sticker p-8 border-4 border-white">
        <div className="text-center mb-8">
          <div className="flex justify-center mb-4">
            <div className="w-20 h-20 bg-kawaii-pink-100 rounded-full flex items-center justify-center text-kawaii-pink-500 shadow-soft ring-4 ring-white">
              <ChefHat className="w-10 h-10" />
            </div>
          </div>
          <h1 className="text-3xl font-bold text-kawaii-text-main font-cute">
            {isSignUp ? '创建账号' : '欢迎回来'}
          </h1>
          <p className="text-kawaii-text-sub mt-2 font-cute">
            {isSignUp ? '开始您的美食之旅' : '登录以管理您的食谱和收藏'}
          </p>
        </div>

        <form onSubmit={handleEmailAuth} className="space-y-6">
          <div>
            <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">
              电子邮箱
            </label>
            <div className="relative">
              <input
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full pl-10 pr-4 py-3 rounded-2xl border-2 border-kawaii-pink-200 focus:border-kawaii-pink-500 focus:ring-4 focus:ring-kawaii-pink-100 outline-none transition-all bg-kawaii-pink-50 font-cute text-kawaii-text-main"
                placeholder="your@email.com"
              />
              <Mail className="absolute left-3 top-3.5 w-5 h-5 text-kawaii-pink-300" />
            </div>
          </div>

          <div>
            <label className="block text-sm font-bold text-kawaii-text-main mb-2 font-cute">
              密码
            </label>
            <div className="relative">
              <input
                type="password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full pl-10 pr-4 py-3 rounded-2xl border-2 border-kawaii-pink-200 focus:border-kawaii-pink-500 focus:ring-4 focus:ring-kawaii-pink-100 outline-none transition-all bg-kawaii-pink-50 font-cute text-kawaii-text-main"
                placeholder="••••••••"
              />
              <Lock className="absolute left-3 top-3.5 w-5 h-5 text-kawaii-pink-300" />
            </div>
          </div>

          {error && (
            <div className="bg-red-50 text-red-500 text-sm p-4 rounded-xl border border-red-100 font-cute">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-kawaii-pink-500 text-white py-3.5 rounded-2xl font-bold shadow-sticker hover:shadow-xl hover:scale-[1.02] active:scale-95 transition-all disabled:opacity-70 flex justify-center items-center gap-2 font-cute text-lg"
          >
            {loading && <Loader2 className="w-5 h-5 animate-spin" />}
            {isSignUp ? '注册' : '登录'}
          </button>
        </form>

        <div className="mt-8 text-center text-sm text-kawaii-text-sub font-cute">
          {isSignUp ? '已有账号？' : '还没有账号？'}
          <button
            onClick={() => setIsSignUp(!isSignUp)}
            className="text-kawaii-pink-500 font-bold ml-1 hover:underline hover:text-kawaii-pink-700"
          >
            {isSignUp ? '立即登录' : '立即注册'}
          </button>
        </div>
      </div>
    </div>
  );
};

export default Login;
