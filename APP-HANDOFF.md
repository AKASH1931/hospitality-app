# Luxero Website → App Build — Complete Handoff

> Everything needed to rebuild this website as a mobile app. Source of truth:
> live site https://luxerohospitalitysolutions.com + this repo (`D:\Private\Satyam Website`).

## 1. What this is

Luxury hospitality brand site for **Luxero Hospitality Solutions** (Lucknow, India).
Marketing + lead capture: 8 content pages, 3-step enquiry quiz → email, event
reservations → email, quote calculator, gallery, films. No login, no accounts,
no backend server (static site + FormSubmit email API).

## 2. Tech stack (web)

- Next.js 16 App Router + React 19 + TypeScript (strict) + Tailwind CSS v4
- Lenis smooth scroll · static export (`output: "export"`) on Hostinger shared
- Fonts (self-hosted via next/font): **Bodoni Moda 600/900** (display), **Inter 400/500/700** (UI)
- Deploys: `scripts/deploy-hostinger.ps1` over FTP (creds in env, never in repo)

## 3. Design tokens (reuse in app theme)

| Token | Value | Usage |
|---|---|---|
| Gold (brand) | `#A7853B` | Headlines, CTAs, accents |
| Espresso (ink) | `#251A13` | Body text, dark surfaces |
| Ivory (canvas) | `#F5F1E7` | Page background |
| Champagne | `#EDE5D3` | Soft surfaces, chips |
| Light gold | `#D4B978` | Secondary accents |
| Mid gold | `#C19A3F` | Elevated cards |
| Radii | 10 / 20 / 25 px | buttons / cards / elevated |
| Display style | UPPERCASE, tight leading (0.9), Bodoni | Hero + section titles |
| Body | Inter 16–20px, 1.5–1.6 line-height | Reading text |

Rules: no emojis anywhere · max 2 font families · gold CTA = single primary action per screen.

## 4. Sitemap & page content

### `/` Home
1. Navbar (sticky): MENU pill (overlay) · center links (xl+) · WhatsApp pill · logo
2. Hero: giant “LUXERO” backdrop + 3 tilted photo tiles (hover lift) + “Gold-standard hospitality” + H1 “Elevating Experiences.” / “Delivering Excellence.” + intro + pills + Enquire/WhatsApp CTAs + logo row
3. Marquee strip (services ticker)
4. About teaser → `/expertise`
5. Who-we-serve: 6 image cards → `/contact`
6. **Showcase (pinned CSS-3D coverflow, all screens)**: 6 head cards — Operations, F&B Management, Artists, Catering, Vendors, Training (each: photo + 2 tag pills) → `/services#heads`
7. Approach: 5 expanding cards (Discover, Diagnose, Design, Deliver, Drive)
8. Value band (dark): Efficiency↑ Revenue↑ Costs↓ Experience★ + party film
9. Pricing teaser: “20K / 50K” → `/pricing`
10. Difference checklist (5) · CTA band · Footer (aurora bg)

### `/services` — PageHero + services depth rail (6 espresso 3D cards with photos) + Six Heads list + Engagement Models
### `/expertise` — Pre-opening 6 steps, F&B framework (4), People checklist, Specialist (artist/catering/vendor)
### `/pricing` — Individual ₹20,000/head/mo vs Combo ₹50,000 (any 4, save ₹30,000) + **quote calculator** (`lib/content.ts: quoteFor()` — combo auto-applies at 4+ heads)
### `/events` — Upcoming (Crystal Eve 2026 NYE @Taj; Block Party @MOB) → Gallery (12 photos, lightbox) → Films strip → Archive (Bananas, CIO Horizon, Sufi Night, Skyline Romance, Santa's Wonderland)
### `/about` — Owner Satyam Tandon: film (sticky) + bio + photo carousel + 13-yr timeline (Vivanta Taj 2012 → … → OGM Kiora Jun24–Nov25 → Luxero Dec25, Taj Christmas + NYE)
### `/contact` — 3-step quiz (needs → details → message) → email; FAQ accordion below
- Quiz fields: needs[] (chips), first, last, business, email, phone, message, privacy✓ — ALL mandatory except message
- `/thank-you` success page · custom 404 · `/privacy` + `/terms` (from company NDA/Service Agreement)

## 5. Data models

```ts
// lib/content.ts
HEADS: [{ id, index, title, text }] ×6 (operations, fb, artist, catering, vendor, training)
PRICING = { perHead: 20000, combo: 50000, comboHeads: 4 }
quoteFor(selected: HeadId[]) → { total, plan, savings }

// lib/events.ts
LuxeroEvent = { id, title, date, venue, city, blurb, poster?, posterAlt?, film? }
UPCOMING_EVENTS[2] (crystal-eve-2026, block-party)
PAST_EVENTS[5] newest-first (bananas, cio, sufi, skyline, santa)

// quiz payload → email
{ name, business, phone, email, interest, message, _subject, _template: "table" }
// reserve payload → email
{ name, phone, event: "Title — date · venue, city", _subject, _template: "table" }
```

## 6. Integrations (reuse as-is in app)

| What | How |
|---|---|
| Enquiry/Reserve email | `POST https://formsubmit.co/ajax/info@luxerohospitalitysolutions.com` JSON + `Accept: application/json` (activated ✅) |
| WhatsApp deep link | `https://wa.me/919305608569?text=<urlencoded>` — default text: “Hello Luxero, I would like to discuss about my plan.” |
| Instagram | `https://www.instagram.com/luxerohospitality/` |
| Phone / Email | `tel:+919305608569` · `info@luxerohospitalitysolutions.com` |
| llms.txt / sitemap / robots / JSON-LD | already live for AI-search; mirror the facts |

## 7. Media assets (`public/`)

- `logo.png` (512) + `favicon.ico` · `img/*.webp` (14 site photos, 1280px, q75) · `events/ev-*.webp` posters + `ev-*.mp4` films · `owner/satyam.{1,2}.webp` + `satyam.mp4` (720p) · `party.mp4` · `hero.mp4` slot (drop-in enables video hero)
- Credits/sources: `public/img/CREDITS.txt` (all Unsplash/Mixkit, free licenses)
- No AI-generated imagery (owner decision pending); stock = placeholders for real shoots

## 8. App-build recommendations

- Screens map 1:1 to routes above; bottom-tab bar: Home · Services · Events · Contact (+ More: About/Pricing/Expertise)
- Native feel: keep Bodoni/Inter (Google Fonts), gold-on-ivory theme, reuse copy verbatim (already proofread, typo-free)
- Replace web-only patterns: coverflows → native horizontal pagers; quiz → native 3-step form (same validation rules); lightbox → native viewer; Lenis/marquee/aurora → subtle native animations
- Keep email payloads byte-identical so inbox parsing never breaks
- Push notifications later: enquiry auto-reply + event reminders (needs backend — currently none)
- Accessibility baseline to keep: labels on all inputs, inline errors, focus states, 44px targets, reduced-motion respect

## 9. Open items / do-not-invent

- Physical office address (missing — ask owner)
- Real photo/video shoots replace stock (marked in CREDITS + code comments)
- New event dates → append to `lib/events.ts`
- Analytics + cookie banner: deliberately skipped (zero cookies today)
- Secrets live outside repo: FTP password + old Netlify token (revoke it in Netlify UI)
