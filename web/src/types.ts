export type GeneratorCategory = 'string' | 'social' | 'address' | 'other';

export interface NumberInputSpec {
  kind: 'number';
  name: string;
  label: string;
  default: number;
  min?: number;
  max?: number;
}

export interface DateInputSpec {
  kind: 'date';
  name: string;
  label: string;
  default: string;
}

export type InputSpec = NumberInputSpec | DateInputSpec;

export interface GeneratorSpec {
  id: string;
  category: GeneratorCategory;
  label: string;
  description: string;
  endpoint: string;
  inputs?: InputSpec[];
  format?: (value: unknown) => string;
}

export interface GenerateResponse {
  value: unknown;
  [key: string]: unknown;
}
