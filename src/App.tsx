import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import React, { Suspense } from 'react';
import MainLayout from './layout/MainLayout';
import { Loader2 } from 'lucide-react';

// Lazy load pages
const Home = React.lazy(() => import('./pages/Home'));
const Recipes = React.lazy(() => import('./pages/Recipes'));
const UploadRecipe = React.lazy(() => import('./pages/UploadRecipe'));
const Login = React.lazy(() => import('./pages/Login'));

const PageLoader = () => (
  <div className="flex justify-center items-center min-h-[50vh]">
    <Loader2 className="w-10 h-10 text-kawaii-pink-500 animate-spin" />
  </div>
);

function App() {
  return (
    <Router>
      <Suspense fallback={<PageLoader />}>
        <Routes>
          <Route path="/" element={<MainLayout />}>
            <Route index element={<Home />} />
            <Route path="recipes" element={<Recipes />} />
            <Route path="upload" element={<UploadRecipe />} />
            <Route path="search" element={<div className="text-center py-10">搜索功能开发中...</div>} />
            <Route path="login" element={<Login />} />
            <Route path="*" element={<div className="text-center py-10">404 Not Found</div>} />
          </Route>
        </Routes>
      </Suspense>
    </Router>
  );
}

export default App;
