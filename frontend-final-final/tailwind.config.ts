import type { Config } from 'tailwindcss';
export default { 
  content: [
    './app/**/*.{ts,tsx,js,jsx}', 
    './components/**/*.{ts,tsx,js,jsx}', 
    './hooks/**/*.{ts,tsx,js,jsx}',
    './src/**/*.{ts,tsx,js,jsx}'
  ], 
  theme: {
    extend: {
      colors: { ink: '#06141B', brand: '#0E7490', mint: '#DDFCF3', cream: '#F7F4EA' }, 
      boxShadow: { soft: '0 24px 80px rgba(15,23,42,.10)' }
    }
  }, 
  plugins: [] 
} satisfies Config;
