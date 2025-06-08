import type { GenerateResponse } from './types';

const API_BASE = (import.meta.env.VITE_API_BASE as string | undefined) ?? '';

export class ApiError extends Error {
  status: number;
  body: unknown;

  constructor(message: string, status: number, body: unknown) {
    super(message);
    this.name = 'ApiError';
    this.status = status;
    this.body = body;
  }
}

export async function generate(
  endpoint: string,
  params: Record<string, string | number> = {},
): Promise<GenerateResponse> {
  const url = new URL(`${API_BASE}${endpoint}`, window.location.origin);
  for (const [key, value] of Object.entries(params)) {
    if (value !== '' && value !== undefined && value !== null) {
      url.searchParams.set(key, String(value));
    }
  }

  const res = await fetch(url.toString(), {
    headers: { Accept: 'application/json' },
  });

  const text = await res.text();
  let body: unknown = text;
  try {
    body = text ? JSON.parse(text) : null;
  } catch {
    body = text;
  }

  if (!res.ok) {
    const message =
      typeof body === 'object' && body && 'message' in body
        ? String((body as { message: unknown }).message)
        : `Request failed with status ${res.status}`;
    throw new ApiError(message, res.status, body);
  }

  return body as GenerateResponse;
}

export async function health(): Promise<{ status: string; version: string }> {
  const res = await fetch(`${API_BASE}/api/health`);
  if (!res.ok) throw new ApiError('Health check failed', res.status, null);
  return res.json();
}
