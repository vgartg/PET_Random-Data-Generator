import citiesText from '../../resources/cities.txt?raw';
import streetsText from '../../resources/street_names.txt?raw';
import descriptionsText from '../../resources/descriptions.txt?raw';
import type { GenerateResponse } from './types';

const LETTERS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
const LOWERCASE = 'abcdefghijklmnopqrstuvwxyz'.split('');
const ALPHANUMERIC = (LETTERS.join('') + '0123456789').split('');

const EMAIL_DOMAINS = ['gmail', 'yahoo', 'outlook', 'example'];
const EMAIL_TLDS = ['com', 'net', 'org', 'co.uk'];
const FIRST_NAMES = [
  'John',
  'Jane',
  'Michael',
  'Sarah',
  'James',
  'Emily',
  'Robert',
  'Olivia',
  'William',
  'Sophia',
];
const LAST_NAMES = [
  'Smith',
  'Johnson',
  'Williams',
  'Jones',
  'Brown',
  'Davis',
  'Miller',
  'Wilson',
  'Moore',
  'Taylor',
];
const ANIMALS = [
  'Dog',
  'Cat',
  'Rabbit',
  'Bird',
  'Fish',
  'Elephant',
  'Tiger',
  'Lion',
  'Wolf',
  'Fox',
  'Bear',
  'Otter',
];
const COMPANY_PREFIXES = [
  'ABC',
  'XYZ',
  'Best',
  'First',
  'Global',
  'Smart',
  'Bright',
  'Quantum',
  'Nova',
  'Apex',
];
const COMPANY_SUFFIXES = ['Inc', 'Ltd', 'LLC', 'Corp', 'Ltda', 'SA', 'GmbH', 'BV'];
const URL_SCHEMES = ['http', 'https'];
const URL_TLDS = ['com', 'net', 'org', 'edu', 'gov', 'io', 'dev'];

const CITIES = citiesText.split(/\s+/).filter(Boolean);
const STREETS = streetsText.split(/\s+/).filter(Boolean);
const DESCRIPTIONS = descriptionsText
  .split(/\r?\n/)
  .map((line) => line.trim())
  .filter(Boolean);

const pick = <T>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];
const intInRange = (min: number, max: number): number =>
  Math.floor(Math.random() * (max - min + 1)) + min;

const randomString = (length: number): string =>
  Array.from({ length }, () => pick(LETTERS)).join('');

const randomAlphaNumeric = (length: number): string =>
  Array.from({ length }, () => pick(ALPHANUMERIC)).join('');

const randomLetterString = (length: number): string =>
  Array.from({ length }, () => pick(LOWERCASE)).join('');

const randomEmail = (): string =>
  `${randomString(8).toLowerCase()}@${pick(EMAIL_DOMAINS)}.${pick(EMAIL_TLDS)}`;

const randomIp = (): string => Array.from({ length: 4 }, () => intInRange(0, 255)).join('.');

const randomPhone = (): string =>
  `+1-${intInRange(100, 999)}-${intInRange(100, 999)}-${intInRange(1000, 9999)}`;

const randomPersonName = (): string => `${pick(FIRST_NAMES)} ${pick(LAST_NAMES)}`;
const randomAnimalName = (): string => `${pick(ANIMALS)}-${intInRange(1000, 9999)}`;
const randomCompanyName = (): string => `${pick(COMPANY_PREFIXES)} ${pick(COMPANY_SUFFIXES)}`;
const randomUrl = (): string =>
  `${pick(URL_SCHEMES)}://www.example${intInRange(100, 999)}.${pick(URL_TLDS)}`;

const randomCity = (): string => pick(CITIES);
const randomStreet = (): string => pick(STREETS);
const randomHouseNumber = (): number => intInRange(1, 1000);
const randomAddress = (): string => `${randomHouseNumber()} ${randomStreet()}, ${randomCity()}`;
const randomCoordinates = (): { latitude: number; longitude: number } => ({
  latitude: Math.random() * 180 - 90,
  longitude: Math.random() * 360 - 180,
});

const randomColor = (): string => {
  const value = Math.floor(Math.random() * 0x1000000);
  return `#${value.toString(16).padStart(6, '0').toUpperCase()}`;
};

const randomDate = (from: string, to: string): string => {
  const start = Date.parse(from);
  const end = Date.parse(to);
  if (Number.isNaN(start) || Number.isNaN(end) || start > end) {
    throw new Error('Invalid date range');
  }
  const stamp = start + Math.random() * (end - start);
  return new Date(stamp).toISOString().slice(0, 10);
};

const randomUuid = (): string => {
  const c = globalThis.crypto;
  if (c && typeof c.randomUUID === 'function') return c.randomUUID();
  const hex = '0123456789abcdef';
  let out = '';
  for (let i = 0; i < 36; i++) {
    if (i === 8 || i === 13 || i === 18 || i === 23) out += '-';
    else if (i === 14) out += '4';
    else if (i === 19) out += hex[8 + Math.floor(Math.random() * 4)];
    else out += hex[Math.floor(Math.random() * 16)];
  }
  return out;
};

const parseLength = (raw: unknown, fallback: number): number => {
  if (raw === undefined || raw === null || raw === '') return fallback;
  const n = typeof raw === 'number' ? raw : Number(raw);
  if (!Number.isFinite(n) || n < 1 || n > 1024) {
    throw new Error('length must be between 1 and 1024');
  }
  return Math.floor(n);
};

type Params = Record<string, string | number>;

export function generateLocal(endpoint: string, params: Params = {}): GenerateResponse {
  switch (endpoint) {
    case '/api/string/string':
      return { value: randomString(parseLength(params.length, 10)) };
    case '/api/string/alpha_numeric':
      return { value: randomAlphaNumeric(parseLength(params.length, 12)) };
    case '/api/string/letter':
      return { value: randomLetterString(parseLength(params.length, 16)) };
    case '/api/social/email':
      return { value: randomEmail() };
    case '/api/social/phone_number':
      return { value: randomPhone() };
    case '/api/social/ip_address':
      return { value: randomIp() };
    case '/api/social/person_name':
      return { value: randomPersonName() };
    case '/api/social/animal_name':
      return { value: randomAnimalName() };
    case '/api/social/company_name':
      return { value: randomCompanyName() };
    case '/api/social/url':
      return { value: randomUrl() };
    case '/api/address/city':
      return { value: randomCity() };
    case '/api/address/street_name':
      return { value: randomStreet() };
    case '/api/address/house_number':
      return { value: randomHouseNumber() };
    case '/api/address/address':
      return { value: randomAddress() };
    case '/api/address/coordinates':
      return { value: randomCoordinates() };
    case '/api/other/number': {
      const min = Number(params.min ?? 1);
      const max = Number(params.max ?? 100);
      if (!Number.isFinite(min) || !Number.isFinite(max) || min > max) {
        throw new Error('min must be <= max');
      }
      return { value: intInRange(Math.floor(min), Math.floor(max)), min, max };
    }
    case '/api/other/date': {
      const from = String(params.from ?? '2000-01-01');
      const to = String(params.to ?? new Date().toISOString().slice(0, 10));
      return { value: randomDate(from, to) };
    }
    case '/api/other/color':
      return { value: randomColor() };
    case '/api/other/text_description':
      return { value: pick(DESCRIPTIONS) };
    case '/api/other/boolean':
      return { value: Math.random() < 0.5 };
    case '/api/other/uuid':
      return { value: randomUuid() };
    default:
      throw new Error(`Unknown endpoint: ${endpoint}`);
  }
}
