# Random Data Generator

[![CI](https://github.com/vgartg/PET_Random-Data-Generator/actions/workflows/ci.yml/badge.svg)](https://github.com/vgartg/PET_Random-Data-Generator/actions/workflows/ci.yml)
[![Deploy](https://github.com/vgartg/PET_Random-Data-Generator/actions/workflows/deploy.yml/badge.svg)](https://github.com/vgartg/Random-Data-Generator/actions/workflows/deploy.yml)
[![Live Demo](https://img.shields.io/badge/demo-live-22C55E?logo=githubpages&logoColor=white)](https://vgartg.github.io/PET_Random-Data-Generator/)
[![Ruby](https://img.shields.io/badge/ruby-3.3-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![TypeScript](https://img.shields.io/badge/typescript-5.5-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Vite](https://img.shields.io/badge/vite-5-646CFF?logo=vite&logoColor=white)](https://vitejs.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.txt)

**Live demo:** <https://vgartg.github.io/Random-Data-Generator> — the SPA bundled with a TypeScript port of the generators, so the published build runs entirely in the browser without the Sinatra backend

> A small Ruby library, a Sinatra JSON API and a TypeScript single-page UI for producing believable fake data on demand — built as a pet project to practice end-to-end Ruby + web tooling

![Random Data Generator UI](https://img.shields.io/badge/UI-Vite_%2B_Tailwind-0F172A?style=for-the-badge)

## What it does

The project exposes a catalog of generators — strings, numbers, dates, addresses, social data, URLs, UUIDs, colors — and lets you call them from three places: a Ruby library, an HTTP API, or a clickable web UI

A typical use case: you need a couple of plausible emails, a city, a UUID and a hex color while wiring up a demo, and you do not want to bring in Faker or write yet another helper script

---

<img width="1080" height="780" alt="image" src="https://github.com/user-attachments/assets/b6c5f337-0109-4853-9e54-4ea8f4c79a87" />

---

## Architecture

```
.
├── lib/random_data_generator/   # pure-Ruby generators (the core library)
├── api/                         # Sinatra app — wraps the library as JSON HTTP
├── web/                         # Vite + TypeScript + Tailwind single-page UI
├── resources/                   # plain-text dictionaries (cities, streets, prose)
├── spec/                        # RSpec — library and API specs
├── bin/                         # `demo` CLI and `server` launcher
└── .github/workflows/ci.yml     # lint, typecheck, tests, build for Ruby and Node
```

The library has no third-party runtime dependencies — pure standard library Ruby
The API is a thin Sinatra layer that validates query params and serializes responses as JSON
The frontend talks to the API over `fetch`, with Vite proxying `/api/*` to Sinatra in development

## Quickstart

### 1. Run the library

```bash
bundle install
bundle exec ruby bin/demo
```

### 2. Run the API

```bash
bundle exec rackup -p 3000
# → http://localhost:3000
curl http://localhost:3000/api/health
curl 'http://localhost:3000/api/string/string?length=12'
```

### 3. Run the web UI

```bash
cd web
npm install
npm run dev
# → http://localhost:8080 (proxies /api to the Sinatra server on :3000)
```

For a production build, run `npm run build` inside `web/` — the Sinatra app will serve the resulting `web/dist/` automatically at `/`

## Using the library directly

```ruby
require 'random_data_generator'

RandomDataGenerator::StringGenerator.random_alpha_numeric_string(16)
RandomDataGenerator::SocialGenerator.random_email
RandomDataGenerator::AddressGenerator.random_address
RandomDataGenerator::OtherGenerator.random_date(Date.new(2020, 1, 1), Date.today)
RandomDataGenerator::OtherGenerator.random_uuid
```

## HTTP API

| Endpoint                          | Params                | Example response                          |
|-----------------------------------|-----------------------|-------------------------------------------|
| `GET /api/health`                 | —                     | `{ "status": "ok", "version": "1.0.0" }`  |
| `GET /api/generators`             | —                     | `{ "generators": [...] }`                 |
| `GET /api/string/string`          | `length` (1..1024)    | `{ "value": "JtKfQwertyAb" }`             |
| `GET /api/string/alpha_numeric`   | `length`              | `{ "value": "a7Kf9Q" }`                   |
| `GET /api/string/letter`          | `length`              | `{ "value": "asdfqwer" }`                 |
| `GET /api/social/email`           | —                     | `{ "value": "asdfasdf@gmail.com" }`       |
| `GET /api/social/phone_number`    | —                     | `{ "value": "+1-415-555-0142" }`          |
| `GET /api/social/ip_address`      | —                     | `{ "value": "192.168.0.42" }`             |
| `GET /api/social/person_name`     | —                     | `{ "value": "Sarah Johnson" }`            |
| `GET /api/social/animal_name`     | —                     | `{ "value": "Otter-4231" }`               |
| `GET /api/social/company_name`    | —                     | `{ "value": "Nova LLC" }`                 |
| `GET /api/social/url`             | —                     | `{ "value": "https://www.example421.io" }`|
| `GET /api/address/city`           | —                     | `{ "value": "Berlin" }`                   |
| `GET /api/address/street_name`    | —                     | `{ "value": "Sunset Boulevard" }`         |
| `GET /api/address/house_number`   | —                     | `{ "value": 742 }`                        |
| `GET /api/address/address`        | —                     | `{ "value": "742 Sunset Blvd, Berlin" }`  |
| `GET /api/address/coordinates`    | —                     | `{ "value": { "latitude": ..., "longitude": ... } }` |
| `GET /api/other/number`           | `min`, `max`          | `{ "value": 73, "min": 1, "max": 100 }`   |
| `GET /api/other/date`             | `from`, `to` (ISO)    | `{ "value": "2023-04-12" }`               |
| `GET /api/other/color`            | —                     | `{ "value": "#3A8FCB" }`                  |
| `GET /api/other/text_description` | —                     | `{ "value": "A quiet afternoon..." }`     |
| `GET /api/other/boolean`          | —                     | `{ "value": true }`                       |
| `GET /api/other/uuid`             | —                     | `{ "value": "f8e1...8b9d" }`              |

Errors are returned as JSON — `400` for invalid params, `404` for unknown routes, `500` with an `error` code otherwise

## Tooling

| Concern         | Tool                                  |
|-----------------|----------------------------------------|
| Library tests   | RSpec, Rack::Test                      |
| Ruby lint       | RuboCop with the `rubocop-rspec` ext   |
| Frontend tests  | Vitest with jsdom                      |
| Frontend lint   | ESLint with `@typescript-eslint`       |
| Formatting      | Prettier                               |
| Bundler         | Vite 5                                 |
| Styling         | Tailwind CSS 3.4                       |
| CI              | GitHub Actions (`.github/workflows/ci.yml`) |

The CI matrix runs Ruby 3.2 and 3.3 plus Node 20 and 22 — every push and pull request runs lint, typecheck, tests and the production build for both halves of the codebase

## Project layout in detail

```
lib/random_data_generator.rb               # public entry point
lib/random_data_generator/version.rb       # VERSION constant
lib/random_data_generator/string_generator.rb
lib/random_data_generator/social_generator.rb
lib/random_data_generator/address_generator.rb
lib/random_data_generator/other_generator.rb

api/app.rb                                 # Sinatra::Base subclass
api/config.ru                              # Rack entry for the api/ directory

config.ru                                  # root-level Rack entry — what `rackup` picks up

bin/demo                                   # prints one sample from every generator
bin/server                                 # boots the API without rackup

web/src/main.ts                            # SPA shell — filter, search, grid
web/src/components/generator-card.ts       # interactive card for one generator
web/src/components/toast.ts                # ephemeral feedback toasts
web/src/api.ts                             # typed fetch wrapper
web/src/generators.ts                      # catalog of generators surfaced in the UI
web/tests/api.test.ts                      # Vitest coverage for the API client

resources/cities.txt                       # ~500 city names
resources/street_names.txt                 # ~6000 street names
resources/descriptions.txt                 # ~50 prose snippets
```

## Roadmap

- Open API / Swagger document generated from the route table
- Optional CSV / NDJSON bulk export (`?count=100`)
- Locale-aware names and addresses (`?locale=ru`)
- Dockerfile + `docker-compose.yml` for one-line setup
