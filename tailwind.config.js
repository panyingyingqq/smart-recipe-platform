/** @type {import('tailwindcss').Config} */

export default {
  darkMode: "class",
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    container: {
      center: true,
    },
    extend: {
      colors: {
        // Hello Kitty / Kawaii Palette
        kawaii: {
          base: '#FFF0F5', // Lavender Blush - Main background
          card: '#FFFFFF', // White - Cards
          pink: {
            100: '#FFE4E1', // Misty Rose - Light accents
            300: '#FFB7C5', // Cherry Blossom Pink - Secondary accents
            500: '#FF69B4', // Hot Pink - Primary buttons/highlights
            700: '#DB7093', // Pale Violet Red - Hover states
          },
          text: {
            main: '#4A4A4A', // Dark Grey/Brown - Primary text (softer than black)
            sub: '#8B7D7B', // Rosy Brown - Secondary text
          },
          accent: '#FF1493', // Deep Pink - Strong emphasis
        }
      },
      borderRadius: {
        'xl': '1rem',
        '2xl': '1.5rem',
        '3xl': '2rem', // Super rounded for Kawaii look
      },
      boxShadow: {
        'soft': '0 4px 20px -2px rgba(255, 182, 193, 0.25)', // Pinkish soft shadow
        'sticker': '0 8px 30px -4px rgba(255, 105, 180, 0.3)', // Stronger sticker shadow
      },
      fontFamily: {
        'cute': ['"Nunito"', '"Quicksand"', '"Varela Round"', 'sans-serif'], // Rounded fonts
      }
    },
  },
  plugins: [],
};
