# UI Design System (MUI)

Visual and interaction standards for React + [MUI (Material UI)](https://mui.com/) projects. This document is the **source of truth** for UI work in this repo.

**All new UI work must follow this system.**

When you fork this template for a real app, put theme code under `src/theme/` (or `ui/src/theme/`) and update the file paths in §10.

---

## 1. Design principles

| Principle | Description |
|-----------|-------------|
| **MUI-first** | Use MUI components and theme APIs; avoid one-off global CSS |
| **Theme-driven** | Colors, typography, spacing, and shape come from the theme — not hardcoded in components |
| **Consistent density** | Pick a spacing rhythm and stick to it (`theme.spacing` / MUI `sx` shorthand) |
| **Accessible by default** | Semantic HTML, labels, focus states, and MUI `color` props for contrast |
| **Composable surfaces** | Prefer `Box`, `Stack`, `Paper`, and layout primitives over custom div soup |

---

## 2. Theme structure

Organize theme code in a dedicated folder:

```
src/theme/
├── tokens.ts      # Raw design tokens (hex, px, font stacks)
├── theme.ts       # createTheme() options + component overrides
└── index.ts       # export theme, tokens, ThemeProvider wrapper
```

Wrap the app once at the root:

```tsx
import { ThemeProvider, CssBaseline } from '@mui/material'
import theme from './theme'

export function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      {/* routes */}
    </ThemeProvider>
  )
}
```

Extend the theme with TypeScript module augmentation when using custom keys:

```tsx
declare module '@mui/material/styles' {
  interface Theme {
    custom: {
      layout: { maxContentWidth: number }
    }
  }
  interface ThemeOptions {
    custom?: {
      layout?: { maxContentWidth?: number }
    }
  }
}
```

---

## 3. Color

### Rule

**Use `theme.palette.*` or palette string shortcuts in components** — never hardcode hex/rgb in `sx`, `style`, or styled components.

Hex values belong in `tokens.ts` and `theme.ts` only.

```tsx
// ✅ Good
<Box sx={{ bgcolor: 'background.default', color: 'text.primary', borderColor: 'divider' }} />
<Button color="primary" />
<Typography color="text.secondary" />

// ❌ Bad
<Box sx={{ bgcolor: '#f5f5f5', color: '#333333' }} />
```

Use `useTheme()` when you need the resolved value:

```tsx
const theme = useTheme()
sx={{ borderColor: theme.palette.divider }}
```

### Standard palette usage

| Token | Usage |
|-------|-------|
| `palette.primary.main` | Primary actions, links, active states |
| `palette.primary.dark` / `light` | Hover, pressed, subtle accents |
| `palette.secondary.main` | Secondary actions, brand accent |
| `palette.error.main` | Destructive actions, validation errors |
| `palette.warning.main` | Caution states |
| `palette.info.main` | Informational banners |
| `palette.success.main` | Positive feedback |
| `palette.text.primary` | Headings, labels, main text |
| `palette.text.secondary` | Body, captions, helper text |
| `palette.text.disabled` | Disabled labels |
| `palette.divider` | Borders, separators |
| `palette.background.paper` | Cards, dialogs, elevated surfaces |
| `palette.background.default` | Page / app shell background |
| `palette.action.hover` | Row hover, subtle interactive fills |

### Extended tokens

When the palette is not enough, add named tokens in `tokens.ts` and expose via `theme.custom` or a typed `tokens` export. Document every extended token in this file.

---

## 4. Typography

Use MUI `Typography` variants — do not invent ad-hoc font sizes in components.

| Variant | Typical usage |
|---------|---------------|
| `h1`–`h6` | Page and section headings (use one level per page hierarchy) |
| `subtitle1` / `subtitle2` | Subheadings, list group labels |
| `body1` | Default body copy |
| `body2` | Secondary body, dense UI |
| `caption` | Timestamps, footnotes |
| `overline` | Eyebrow labels (use sparingly) |
| `button` | Button label styling (usually via `Button`, not raw `Typography`) |

### Conventions

- Set `fontFamily` once in `theme.typography`
- Prefer `textTransform: 'none'` on buttons unless the brand requires all-caps
- Use `fontWeight` theme keys (`theme.typography.fontWeightMedium`) over raw numbers when possible
- Pair heading + context line:

```tsx
<Typography variant="body2" color="text.secondary" sx={{ mb: 0.5 }}>
  {breadcrumbOrContext}
</Typography>
<Typography variant="h4" component="h1" sx={{ mb: 2 }}>
  {pageTitle}
</Typography>
```

---

## 5. Shape & spacing

### Spacing

Use the 8px grid via `theme.spacing(n)` or `sx` shorthand:

```tsx
<Stack spacing={2} sx={{ p: 3, mb: 2 }} />
```

| `sx` key | Meaning |
|----------|---------|
| `p: 2` | padding 16px (2 × 8) |
| `px: 3` | horizontal padding 24px |
| `gap: 1.5` | 12px gap in flex/grid |

### Shape

Define border radii in the theme, not per component:

| Token | Suggested usage |
|-------|-----------------|
| `shape.borderRadius` | Default (inputs, buttons, small surfaces) |
| Custom `borderRadiusSm` | Chips, badges |
| Custom `borderRadiusLg` | Cards, modals, hero panels |

### Elevation

Prefer explicit borders for flat designs; use `elevation` intentionally:

```tsx
<Paper elevation={0} sx={{ border: '1px solid', borderColor: 'divider' }} />
```

---

## 6. Layout

### Preferred primitives

| Component | Use for |
|-----------|---------|
| `Stack` | Vertical/horizontal stacks with consistent `spacing` |
| `Box` | One-off layout, flex child, wrapper with `sx` |
| `Grid` / `Grid2` | Responsive column layouts |
| `Container` | Max-width page content |
| `Toolbar` | App bar content alignment |

### App shell pattern

```
┌──────────┬──────────────────────────────┐
│ Drawer   │ Main (flex: 1, minWidth: 0)  │
│ / AppBar │ Pages, forms, data views     │
└──────────┴──────────────────────────────┘
```

- Main content: `flex: 1`, `minWidth: 0` (prevents flex overflow bugs)
- Page padding: `p: { xs: 2, md: 3 }`
- Sticky panels: `position: 'sticky', top: theme.spacing(3), alignSelf: 'flex-start'`

---

## 7. Component patterns

### Buttons

| Variant | Usage |
|---------|-------|
| `contained` + `color="primary"` | Primary action (one per view when possible) |
| `outlined` | Secondary actions |
| `text` | Tertiary / inline actions |
| `color="error"` | Destructive confirm |

```tsx
<Button variant="contained" color="primary">Save</Button>
<Button variant="outlined">Cancel</Button>
```

### Form fields

- Default to `TextField` with `variant="outlined"` (set in theme defaults)
- Always wire `label`, `error`, `helperText`, and `id` / `htmlFor` for accessibility
- Group related fields with `Stack spacing={2}`

```tsx
<TextField
  fullWidth
  label="Email"
  type="email"
  error={Boolean(error)}
  helperText={error?.message}
/>
```

### Cards / surfaces

```tsx
<Paper
  elevation={0}
  sx={{
    border: '1px solid',
    borderColor: 'divider',
    borderRadius: 2,
    p: 3,
    bgcolor: 'background.paper',
  }}
>
```

### Data display

- `Table` / `DataGrid` for tabular data — align header typography with `subtitle2`
- `Chip` for filters and status; map status → `color` prop consistently
- `Skeleton` for loading states matching final layout dimensions

### Feedback

- `Alert` for inline page messages
- `Snackbar` + `Alert` for transient success/error toasts
- `Dialog` for confirmations; destructive actions use `color="error"` on the confirm button

### Icons

- Import from `@mui/icons-material` with a consistent style (Outlined **or** Filled — pick one per app)
- Size icons with `fontSize="small" | "medium"` or `sx={{ fontSize: 20 }}`

---

## 8. Styling rules (`sx` vs CSS)

### Prefer `sx` and theme

```tsx
<Box sx={{ display: 'flex', gap: 2, color: 'text.secondary' }} />
```

### Use `styled()` for repeated complex components

```tsx
const StatusChip = styled(Chip)(({ theme }) => ({
  fontWeight: theme.typography.fontWeightMedium,
}))
```

### CSS files (`.css`)

- Reserve for animations or third-party overrides MUI cannot express cleanly
- Never duplicate theme tokens as raw values in CSS — use CSS variables wired from the theme if needed
- Scope global CSS minimally; prefer co-located `sx` / `styled`

```css
/* ✅ OK — global animation not covered by MUI */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* ❌ Bad — duplicates theme palette */
.card { background: #ffffff; border: 1px solid #e0e0e0; }
```

---

## 9. Do's and Don'ts

### Do

- Use `palette.*` and typography variants in components
- Centralize new colors and radii in `tokens.ts` / `theme.ts`
- Reuse patterns from existing components before inventing new ones
- Test responsive behavior with `sx` breakpoints: `{ xs: ..., md: ... }`
- Use MUI `Link` with `component={RouterLink}` for in-app navigation

### Don't

- Hardcode hex, rgb, or px font sizes in TSX/CSS
- Override MUI with `!important` in CSS unless unavoidable
- Mix Outlined and Filled icon sets in the same view
- Add global CSS for styles achievable via theme component overrides
- Use inline `style={{}}` when `sx` or theme overrides would work
- Create custom button markup when `Button` / `IconButton` / `LoadingButton` suffices

---

## 10. File references (customize per project)

| File | Purpose |
|------|---------|
| `src/theme/tokens.ts` | Hex values, spacing extras, custom shadows |
| `src/theme/theme.ts` | `createTheme({ ... })` + `components` overrides |
| `src/theme/index.ts` | Public exports |
| `src/App.tsx` | `ThemeProvider` + `CssBaseline` |

### Import pattern

```tsx
import theme, { tokens } from '@/theme'

// Preferred — palette shortcuts
sx={{ bgcolor: 'background.default', color: 'text.primary' }}

// Extended tokens when documented above
sx={{ maxWidth: theme.custom.layout.maxContentWidth }}
```

---

## 11. Updating the design system

1. Change values in `src/theme/tokens.ts`
2. Wire into `src/theme/theme.ts` (palette, typography, `components` overrides)
3. Update **this document**
4. Refactor affected components — do not patch colors in isolation
