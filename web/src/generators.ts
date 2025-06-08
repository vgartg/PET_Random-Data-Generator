import type { GeneratorSpec } from './types';

const today = (): string => new Date().toISOString().slice(0, 10);

export const GENERATORS: GeneratorSpec[] = [
  {
    id: 'string-random',
    category: 'string',
    label: 'Random String',
    description: 'A mixed-case alphabetic string of the requested length.',
    endpoint: '/api/string/string',
    inputs: [{ kind: 'number', name: 'length', label: 'Length', default: 10, min: 1, max: 1024 }],
  },
  {
    id: 'string-alpha-numeric',
    category: 'string',
    label: 'Alpha-Numeric String',
    description: 'Letters and digits combined.',
    endpoint: '/api/string/alpha_numeric',
    inputs: [{ kind: 'number', name: 'length', label: 'Length', default: 12, min: 1, max: 1024 }],
  },
  {
    id: 'string-letter',
    category: 'string',
    label: 'Letter String',
    description: 'Lowercase ASCII letters only.',
    endpoint: '/api/string/letter',
    inputs: [{ kind: 'number', name: 'length', label: 'Length', default: 16, min: 1, max: 1024 }],
  },
  {
    id: 'social-email',
    category: 'social',
    label: 'Email Address',
    description: 'A plausible-looking email with a random local part.',
    endpoint: '/api/social/email',
  },
  {
    id: 'social-phone',
    category: 'social',
    label: 'Phone Number',
    description: 'A US-style phone number with country code.',
    endpoint: '/api/social/phone_number',
  },
  {
    id: 'social-ip',
    category: 'social',
    label: 'IP Address',
    description: 'IPv4 address with random octets.',
    endpoint: '/api/social/ip_address',
  },
  {
    id: 'social-person',
    category: 'social',
    label: 'Person Name',
    description: 'First and last name pair.',
    endpoint: '/api/social/person_name',
  },
  {
    id: 'social-animal',
    category: 'social',
    label: 'Animal Tag',
    description: 'Animal name with a numeric suffix — handy for codenames.',
    endpoint: '/api/social/animal_name',
  },
  {
    id: 'social-company',
    category: 'social',
    label: 'Company Name',
    description: 'A made-up company name with a legal suffix.',
    endpoint: '/api/social/company_name',
  },
  {
    id: 'social-url',
    category: 'social',
    label: 'URL',
    description: 'Random URL on the example.com domain space.',
    endpoint: '/api/social/url',
  },
  {
    id: 'address-city',
    category: 'address',
    label: 'City',
    description: 'A city picked from a curated list.',
    endpoint: '/api/address/city',
  },
  {
    id: 'address-street',
    category: 'address',
    label: 'Street Name',
    description: 'A real-sounding street name.',
    endpoint: '/api/address/street_name',
  },
  {
    id: 'address-address',
    category: 'address',
    label: 'Full Address',
    description: 'Number, street, city — composed end-to-end.',
    endpoint: '/api/address/address',
  },
  {
    id: 'address-coordinates',
    category: 'address',
    label: 'Coordinates',
    description: 'Latitude and longitude anywhere on Earth.',
    endpoint: '/api/address/coordinates',
    format: (value) => {
      if (typeof value === 'object' && value && 'latitude' in value && 'longitude' in value) {
        const v = value as { latitude: number; longitude: number };
        return `${v.latitude.toFixed(5)}, ${v.longitude.toFixed(5)}`;
      }
      return String(value);
    },
  },
  {
    id: 'other-number',
    category: 'other',
    label: 'Number',
    description: 'Integer in a custom inclusive range.',
    endpoint: '/api/other/number',
    inputs: [
      { kind: 'number', name: 'min', label: 'Min', default: 1 },
      { kind: 'number', name: 'max', label: 'Max', default: 100 },
    ],
  },
  {
    id: 'other-date',
    category: 'other',
    label: 'Date',
    description: 'A date inside the chosen ISO range.',
    endpoint: '/api/other/date',
    inputs: [
      { kind: 'date', name: 'from', label: 'From', default: '2000-01-01' },
      { kind: 'date', name: 'to', label: 'To', default: today() },
    ],
  },
  {
    id: 'other-color',
    category: 'other',
    label: 'Hex Color',
    description: 'A random RGB color in #RRGGBB.',
    endpoint: '/api/other/color',
  },
  {
    id: 'other-text',
    category: 'other',
    label: 'Text Description',
    description: 'A short prose snippet from a curated list.',
    endpoint: '/api/other/text_description',
  },
  {
    id: 'other-boolean',
    category: 'other',
    label: 'Boolean',
    description: 'Coin flip — true or false.',
    endpoint: '/api/other/boolean',
  },
  {
    id: 'other-uuid',
    category: 'other',
    label: 'UUID v4',
    description: 'RFC 4122 v4 identifier.',
    endpoint: '/api/other/uuid',
  },
];

export const CATEGORY_META: Record<
  GeneratorSpec['category'],
  { label: string; icon: string; description: string }
> = {
  string: { label: 'Strings', icon: 'Aa', description: 'Letters, digits, alphabets.' },
  social: { label: 'Social', icon: '@', description: 'People, contacts, web identity.' },
  address: { label: 'Address', icon: '⌖', description: 'Locations and geo data.' },
  other: { label: 'Other', icon: '★', description: 'Numbers, dates, primitives.' },
};
