# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Vue 3 + TypeScript landing page for AccessDevOps "DevOps & Infrastructure Success as a Service" offering. The site showcases their managed infrastructure services (WDI and WIU offerings), technology stack, and global presence across Europe, Americas, and Asia.

## Technology Stack

- **Framework**: Vue 3 (Composition API)
- **Build Tool**: Vite 7
- **Language**: TypeScript 5.9
- **Styling**: Tailwind CSS 4.1 (PostCSS)
- **State Management**: Pinia
- **Routing**: Vue Router 4
- **Package Manager**: pnpm
- **Node Version**: 20.19.0+ or 22.12.0+

## Development Commands

```bash
# Start development server
pnpm dev

# Build for production (runs type-check + build)
pnpm build

# Type check only
pnpm type-check

# Build without type checking
pnpm build-only

# Preview production build
pnpm preview

# Format code with Prettier
pnpm format
```

## Project Structure

```
src/
  ├── App.vue           # Root component
  ├── main.ts           # Application entry point
  ├── main.css          # Global styles (Tailwind imports)
  ├── router/           # Vue Router configuration
  ├── stores/           # Pinia stores
  ├── components/       # Reusable Vue components
  ├── views/            # Page-level components
  └── assets/           # Static assets
```

## Key Configuration

- **Path Alias**: `@` maps to `./src` directory (configured in [vite.config.ts:14-16](vite.config.ts#L14-L16))
- **Prettier**: Uses single quotes, no semicolons, 100 character line width
- **Vue DevTools**: Enabled in development via vite-plugin-vue-devtools
- **Router**: Uses web history mode (not hash mode)

## Architecture Notes

- The router is currently initialized with an empty routes array - routes should be added to [src/router/index.ts](src/router/index.ts) as pages are created
- State management uses Pinia - stores are in the `stores/` directory
- Tailwind content scanning includes all Vue/TS/JS files in src and index.html
- The project uses TypeScript strict mode via Vue TSC for type checking

## Styling Approach

- Tailwind CSS 4.1 with PostCSS integration
- Global styles imported via [src/main.css](src/main.css)
- Tailwind classes can be used directly in Vue component templates
- Custom theme extensions can be added in [tailwind.config.js](tailwind.config.js)
