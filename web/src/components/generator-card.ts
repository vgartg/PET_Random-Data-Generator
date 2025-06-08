import { generate, ApiError } from '../api';
import { showToast } from './toast';
import type { GeneratorSpec, InputSpec } from '../types';

export function createGeneratorCard(spec: GeneratorSpec): HTMLElement {
  const card = document.createElement('article');
  card.className = 'card flex flex-col gap-4';
  card.dataset.category = spec.category;
  card.dataset.id = spec.id;

  card.innerHTML = `
    <header class="flex items-start justify-between gap-3">
      <div>
        <h3 class="text-base font-semibold text-slate-900">${spec.label}</h3>
        <p class="mt-1 text-sm text-slate-500">${spec.description}</p>
      </div>
      <span class="pill capitalize">${spec.category}</span>
    </header>
    <div data-role="inputs" class="flex flex-wrap gap-2"></div>
    <div
      data-role="output"
      class="mono min-h-[3rem] break-all rounded-lg bg-slate-50 px-3 py-2 text-slate-700"
    >
      <span class="text-slate-400">Click Generate to produce a value.</span>
    </div>
    <div class="flex flex-wrap items-center gap-2">
      <button data-role="generate" class="btn btn-primary" type="button">Generate</button>
      <button data-role="copy" class="btn btn-ghost" type="button" disabled>Copy</button>
      <span data-role="status" class="ml-auto text-xs text-slate-400"></span>
    </div>
  `;

  const inputsHost = card.querySelector<HTMLElement>('[data-role="inputs"]')!;
  const output = card.querySelector<HTMLElement>('[data-role="output"]')!;
  const generateBtn = card.querySelector<HTMLButtonElement>('[data-role="generate"]')!;
  const copyBtn = card.querySelector<HTMLButtonElement>('[data-role="copy"]')!;
  const status = card.querySelector<HTMLElement>('[data-role="status"]')!;

  const inputElements = new Map<string, HTMLInputElement>();
  for (const input of spec.inputs ?? []) {
    const wrapper = renderInput(input);
    inputsHost.appendChild(wrapper.label);
    inputElements.set(input.name, wrapper.input);
  }
  if (!spec.inputs?.length) {
    inputsHost.classList.add('hidden');
  }

  let currentValue: string | null = null;

  const setOutput = (value: string, ok: boolean): void => {
    output.textContent = value;
    output.classList.toggle('text-ruby-700', !ok);
    output.classList.toggle('text-slate-700', ok);
    copyBtn.disabled = !ok;
    currentValue = ok ? value : null;
  };

  const collectParams = (): Record<string, string | number> => {
    const params: Record<string, string | number> = {};
    for (const [name, el] of inputElements) {
      const raw = el.value.trim();
      if (raw === '') continue;
      params[name] = el.type === 'number' ? Number(raw) : raw;
    }
    return params;
  };

  generateBtn.addEventListener('click', async () => {
    generateBtn.disabled = true;
    status.textContent = 'Generating…';
    try {
      const start = performance.now();
      const result = await generate(spec.endpoint, collectParams());
      const ms = Math.round(performance.now() - start);
      const rendered = spec.format ? spec.format(result.value) : formatValue(result.value);
      setOutput(rendered, true);
      status.textContent = `${ms} ms`;
    } catch (err) {
      const message = err instanceof ApiError ? err.message : 'Network error';
      setOutput(message, false);
      status.textContent = err instanceof ApiError ? `HTTP ${err.status}` : 'error';
    } finally {
      generateBtn.disabled = false;
    }
  });

  copyBtn.addEventListener('click', async () => {
    if (!currentValue) return;
    try {
      await navigator.clipboard.writeText(currentValue);
      showToast('Copied to clipboard');
    } catch {
      showToast('Clipboard unavailable', 'error');
    }
  });

  return card;
}

function renderInput(input: InputSpec): { label: HTMLLabelElement; input: HTMLInputElement } {
  const label = document.createElement('label');
  label.className = 'flex min-w-[6rem] flex-1 flex-col gap-1';
  const title = document.createElement('span');
  title.className = 'text-xs font-medium uppercase tracking-wide text-slate-500';
  title.textContent = input.label;

  const field = document.createElement('input');
  field.className = 'input';
  field.name = input.name;
  if (input.kind === 'number') {
    field.type = 'number';
    field.value = String(input.default);
    if (input.min !== undefined) field.min = String(input.min);
    if (input.max !== undefined) field.max = String(input.max);
  } else {
    field.type = 'date';
    field.value = input.default;
  }

  label.appendChild(title);
  label.appendChild(field);
  return { label, input: field };
}

function formatValue(value: unknown): string {
  if (value === null || value === undefined) return '';
  if (typeof value === 'string' || typeof value === 'number' || typeof value === 'boolean') {
    return String(value);
  }
  return JSON.stringify(value);
}
