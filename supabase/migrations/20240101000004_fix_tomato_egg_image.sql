-- Update the image for Tomato and Egg Stir-fry
UPDATE recipes
SET cover_image = 'https://images.unsplash.com/photo-1598511726623-d219904a53e8?auto=format&fit=crop&w=800&q=80'
WHERE name = '西红柿炒鸡蛋';

-- Also update the static placeholder in Home.tsx (This is code change, not SQL, but good to note)
