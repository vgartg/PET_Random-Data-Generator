import './style.css';
import { GENERATORS, CATEGORY_META } from './generators';
import { createGeneratorCard } from './components/generator-card';
import { health } from './api';
import type { GeneratorCategory } from './types';

const root = document.querySelector<HTMLDivElement>('#app');
if (!root) throw new Error('Missing #app root element');

const CATEGORIES: GeneratorCategory[] = ['string', 'social', 'address', 'other'];
let activeCategory: GeneratorCategory | 'all' = 'all';
let query = '';

root.innerHTML = `
  <div class="mx-auto flex min-h-screen max-w-6xl flex-col gap-10 px-6 py-10">
    <header class="flex flex-col gap-6">
      <div class="flex items-center justify-between gap-4">
        <div class="flex items-center gap-3">
          <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-ruby-600 text-white shadow-glow">
            <span class="font-mono text-lg font-bold">R</span>
          </div>
          <div>
            <h1 class="text-xl font-semibold tracking-tight">Random Data Generator</h1>
            <p class="text-sm text-slate-500" data-role="health">checking API…</p>
          </div>
        </div>
        <a
          href="https://github.com/vgartg/PET_Random-Data-Generator"
          class="btn btn-ghost"
          target="_blank"
          rel="noreferrer noopener"
        >GitHub</a>
      </div>
      <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
        <h2 class="text-2xl font-semibold leading-snug">
          Generate believable test data in one click
        </h2>
        <p class="mt-2 max-w-2xl text-slate-500">
          A small Ruby toolkit wrapped in a Sinatra API and a tiny TypeScript frontend
        </p>
        <div class="mt-5 flex flex-wrap items-center gap-3">
          <input
            id="search"
            class="input max-w-sm"
            type="search"
            placeholder="Search generators (e.g. email, color, uuid)…"
            autocomplete="off"
          />
          <div id="filters" class="flex flex-wrap gap-2"></div>
        </div>
      </div>
    </header>
    <main id="grid" class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3"></main>
    <footer class="border-t border-slate-200 pt-6 text-sm text-slate-500">
      <p>
        Built with Ruby, Sinatra and TypeScript &middot;
        <a class="text-ruby-600 hover:underline" href="/api/generators">browse the API</a>
      </p>
    </footer>
  </div>
`;

const grid = root.querySelector<HTMLDivElement>('#grid')!;
const filters = root.querySelector<HTMLDivElement>('#filters')!;
const search = root.querySelector<HTMLInputElement>('#search')!;
const healthEl = root.querySelector<HTMLElement>('[data-role="health"]')!;

function renderFilters(): void {
  filters.innerHTML = '';
  const buttons: Array<{ id: GeneratorCategory | 'all'; label: string }> = [
    { id: 'all', label: 'All' },
    ...CATEGORIES.map((id) => ({ id, label: CATEGORY_META[id].label })),
  ];
  for (const b of buttons) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.dataset.id = b.id;
    btn.className = 'btn ' + (activeCategory === b.id ? 'btn-primary' : 'btn-ghost');
    btn.textContent = b.label;
    btn.addEventListener('click', () => {
      activeCategory = b.id;
      renderFilters();
      renderGrid();
    });
    filters.appendChild(btn);
  }
}

function renderGrid(): void {
  const q = query.trim().toLowerCase();
  const cards = GENERATORS.filter((g) => {
    if (activeCategory !== 'all' && g.category !== activeCategory) return false;
    if (!q) return true;
    return (
      g.label.toLowerCase().includes(q) ||
      g.description.toLowerCase().includes(q) ||
      g.category.toLowerCase().includes(q)
    );
  });

  grid.innerHTML = '';
  if (cards.length === 0) {
    const empty = document.createElement('div');
    empty.className = 'col-span-full rounded-xl border border-dashed border-slate-300 p-10 text-center text-slate-500';
    empty.textContent = 'No generators match your filters';
    grid.appendChild(empty);
    return;
  }
  for (const spec of cards) {
    grid.appendChild(createGeneratorCard(spec));
  }
}

search.addEventListener('input', (event) => {
  query = (event.target as HTMLInputElement).value;
  renderGrid();
});

renderFilters();
renderGrid();

health()
  .then((h) => {
    healthEl.textContent = `API ${h.status} · v${h.version}`;
  })
  .catch(() => {
    healthEl.textContent = 'API offline — start it with `bundle exec rackup`';
    healthEl.classList.add('text-ruby-600');
  });
