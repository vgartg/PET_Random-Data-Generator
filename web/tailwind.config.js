/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{ts,html}'],
  theme: {
    extend: {
      colors: {
        ruby: {
          50: '#fef2f3',
          100: '#fde3e5',
          200: '#fbcbd0',
          300: '#f7a4ac',
          400: '#f17280',
          500: '#e54158',
          600: '#cc342d',
          700: '#a82a25',
          800: '#8b2722',
          900: '#742622',
          950: '#400f0d',
        },
      },
      fontFamily: {
        sans: ['"Inter"', 'system-ui', 'sans-serif'],
        mono: ['"JetBrains Mono"', 'ui-monospace', 'monospace'],
      },
      boxShadow: {
        glow: '0 0 0 1px rgba(204, 52, 45, 0.12), 0 10px 30px -10px rgba(204, 52, 45, 0.25)',
      },
    },
  },
  plugins: [],
};
