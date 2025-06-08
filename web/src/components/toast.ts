export function showToast(message: string, variant: 'success' | 'error' = 'success'): void {
  const container = ensureContainer();
  const toast = document.createElement('div');
  toast.className = [
    'pointer-events-auto translate-y-2 opacity-0 transition-all duration-200',
    'rounded-lg px-4 py-2 text-sm font-medium shadow-lg',
    variant === 'success'
      ? 'bg-slate-900 text-white'
      : 'bg-ruby-600 text-white',
  ].join(' ');
  toast.textContent = message;
  container.appendChild(toast);

  requestAnimationFrame(() => {
    toast.classList.remove('translate-y-2', 'opacity-0');
  });

  setTimeout(() => {
    toast.classList.add('translate-y-2', 'opacity-0');
    setTimeout(() => toast.remove(), 250);
  }, 2000);
}

function ensureContainer(): HTMLElement {
  let container = document.getElementById('toast-container');
  if (!container) {
    container = document.createElement('div');
    container.id = 'toast-container';
    container.className =
      'pointer-events-none fixed bottom-6 left-1/2 z-50 flex -translate-x-1/2 flex-col items-center gap-2';
    document.body.appendChild(container);
  }
  return container;
}
