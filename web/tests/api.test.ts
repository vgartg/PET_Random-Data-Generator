import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { ApiError, generate } from '../src/api';

describe('generate()', () => {
  const originalFetch = globalThis.fetch;

  beforeEach(() => {
    // jsdom doesn't expose fetch; provide a stub the tests can override.
    globalThis.fetch = vi.fn() as unknown as typeof fetch;
  });

  afterEach(() => {
    globalThis.fetch = originalFetch;
  });

  it('returns the parsed JSON body on success', async () => {
    (globalThis.fetch as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: 'abc' }),
    });

    const result = await generate('/api/string/string', { length: 3 });
    expect(result.value).toBe('abc');

    const [calledUrl] = (globalThis.fetch as ReturnType<typeof vi.fn>).mock.calls[0];
    expect(String(calledUrl)).toContain('length=3');
  });

  it('throws ApiError on a non-ok response', async () => {
    (globalThis.fetch as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: false,
      status: 400,
      text: async () => JSON.stringify({ message: 'bad input' }),
    });

    await expect(generate('/api/other/number', { min: 9, max: 1 })).rejects.toBeInstanceOf(
      ApiError,
    );
  });

  it('skips empty params', async () => {
    (globalThis.fetch as ReturnType<typeof vi.fn>).mockResolvedValueOnce({
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: 'x' }),
    });

    await generate('/api/social/email', { foo: '' });
    const [calledUrl] = (globalThis.fetch as ReturnType<typeof vi.fn>).mock.calls[0];
    expect(String(calledUrl)).not.toContain('foo=');
  });
});
