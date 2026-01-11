# 智能食谱平台

基于React + TypeScript + Vite开发的智能食谱管理平台，支持食谱浏览、搜索、上传等功能。

## 项目特性
- 🍳 丰富的食谱库
- 🔍 智能搜索功能  
- 📱 响应式设计，支持移动端
- ➕ 用户可上传自定义食谱
- 🚀 部署在Vercel，全球CDN加速

## 技术栈
- **前端框架**: React 18 + TypeScript 5
- **构建工具**: Vite 6
- **样式框架**: TailwindCSS 3
- **状态管理**: Zustand
- **数据库**: Supabase (PostgreSQL)
- **部署平台**: Vercel

## 快速开始

### 本地开发
```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build
```

### 环境变量
需要在项目根目录创建 `.env` 文件：
```
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 功能模块
- **首页**: 展示热门食谱和分类
- **食谱列表**: 支持搜索、筛选和分页
- **食谱详情**: 详细的制作步骤和食材清单
- **用户上传**: 用户可以上传自己的食谱
- **用户系统**: 注册、登录、个人中心

## 部署
本项目已配置Vercel自动部署，每次推送到main分支都会自动重新部署。

## 访问地址
- **生产环境**: https://smart-recipe-platform-dz5h-1bnfv5i4n-panyingyings-projects.vercel.app/
- **开发环境**: http://localhost:5173

---

如果访问有问题，请检查网络连接或联系维护人员。