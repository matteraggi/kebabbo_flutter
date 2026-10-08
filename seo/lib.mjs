// Shared helpers for the public kebab pages (no dependencies).

export const SITE = 'https://kebabbo.top';
export const PLAY_URL =
  'https://play.google.com/store/apps/details?id=com.canny.kebabbologna';

const BOLOGNA = { lat: 44.4949, lng: 11.3426 };

/** "I Panini di Mirò" -> "i-panini-di-miro". Must match `kebabSlug` in the app. */
const SPECIAL = { 'ı': 'i', 'ß': 'ss', 'ø': 'o', 'ł': 'l', 'æ': 'ae', 'œ': 'oe', 'đ': 'd' };

export function slugify(name) {
  return String(name || '')
    .toLowerCase()
    .replace(/[ıßøłæœđ]/g, (c) => SPECIAL[c])
    .replace(/['’]/g, '')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/&/g, ' e ')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

/** Slug for each kebab; duplicates get the id appended so every URL is unique. */
export function withSlugs(kebabs) {
  const counts = {};
  for (const k of kebabs) {
    const s = slugify(k.name);
    counts[s] = (counts[s] || 0) + 1;
  }
  return kebabs.map((k) => {
    const s = slugify(k.name) || String(k.id);
    return { ...k, slug: counts[s] > 1 ? `${s}-${k.id}` : s };
  });
}

export function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

const ratingFormat = new Intl.NumberFormat('it-IT', {
  minimumFractionDigits: 1,
  maximumFractionDigits: 1,
});

export const formatRating = (n) => ratingFormat.format(n);

export function distanceKm(aLat, aLng, bLat, bLng) {
  const R = 6371;
  const toRad = (d) => (d * Math.PI) / 180;
  const dLat = toRad(bLat - aLat);
  const dLng = toRad(bLng - aLng);
  const h =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(aLat)) * Math.cos(toRad(bLat)) * Math.sin(dLng / 2) ** 2;
  return 2 * R * Math.asin(Math.sqrt(h));
}

/** True for places within 25 km of Bologna's centre. */
export function isInBologna(k) {
  if (typeof k.lat !== 'number' || typeof k.lng !== 'number') return false;
  return distanceKm(BOLOGNA.lat, BOLOGNA.lng, k.lat, k.lng) <= 25;
}

/** Names often end with a city code, e.g. "Mundis Kebap (BER)": drop it for headings. */
export function displayName(name) {
  return String(name || '').replace(/\s*\([A-Z]{2,}\)\s*$/, '').trim() || name;
}

// ---------------- opening hours (same rules as isKebabOpen in the app) ----------------

export const DAY_KEYS = [
  'lunedì', 'martedì', 'mercoledì', 'giovedì', 'venerdì', 'sabato', 'domenica',
];

export function parseHours(raw) {
  if (!raw) return null;
  if (typeof raw === 'object') return raw;
  try {
    const v = JSON.parse(raw);
    return v && typeof v === 'object' ? v : null;
  } catch {
    return null;
  }
}

export function hasOpeningHours(raw) {
  const h = parseHours(raw);
  if (!h) return false;
  return Object.values(h).some((v) => {
    const s = String(v ?? '').trim().toLowerCase();
    return s && s !== 'null';
  });
}

/** Current weekday index (0 = Monday) and minutes since midnight, in Italian time. */
export function romeNow(date = new Date()) {
  const parts = new Intl.DateTimeFormat('en-GB', {
    timeZone: 'Europe/Rome',
    weekday: 'short',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
  }).formatToParts(date);
  const get = (t) => parts.find((p) => p.type === t)?.value;
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const hour = Number(get('hour')) % 24;
  return { day: days.indexOf(get('weekday')), minutes: hour * 60 + Number(get('minute')) };
}

function toMinutes(s) {
  const [h, m] = s.trim().replace(/\s/g, '').split(':');
  const hh = parseInt(h, 10);
  if (Number.isNaN(hh)) return null;
  if (hh === 24) return 24 * 60;
  return hh * 60 + (parseInt(m, 10) || 0);
}

export function isOpenNow(raw, now = romeNow()) {
  const hours = parseHours(raw);
  if (!hours || now.day < 0) return false;
  const check = (schedule, yesterday) => {
    if (schedule == null) return false;
    const lower = String(schedule).trim().toLowerCase();
    if (!lower || lower === 'chiuso') return false;
    if (lower.includes('24h') || lower.includes('aperto 24') ||
        lower === '00:00-24:00' || lower === '00:00-00:00') return true;
    for (const interval of lower.split(',')) {
      const parts = interval.split('-');
      if (parts.length !== 2) continue;
      const start = toMinutes(parts[0]);
      const end = toMinutes(parts[1]);
      if (start == null || end == null) continue;
      if (end <= start) {
        if (!yesterday && now.minutes >= start) return true;
        if (yesterday && end > 0 && now.minutes < end) return true;
      } else if (!yesterday && now.minutes >= start && now.minutes < end) {
        return true;
      }
    }
    return false;
  };
  return check(hours[DAY_KEYS[now.day]], false) ||
    check(hours[DAY_KEYS[(now.day + 6) % 7]], true);
}

// ---------------- ratings ----------------

/** Community averages from reviews, using the same formula as the app (4 criteria). */
export function communityStats(reviews) {
  if (!reviews.length) return null;
  const avg = (key) =>
    reviews.reduce((sum, r) => sum + (Number(r[key]) || 0), 0) / reviews.length;
  const quality = avg('quality');
  const quantity = avg('quantity');
  const price = avg('price');
  const menu = avg('menu');
  return {
    count: reviews.length,
    quality, quantity, price, menu,
    overall: (quality + quantity + price + menu) / 4,
  };
}

/** Rating shown for a place: staff rating for staff places, otherwise the community one. */
export function headlineRating(kebab, stats) {
  if (kebab.is_staff && Number(kebab.rating) > 0) return Number(kebab.rating);
  if (stats) return stats.overall;
  return Number(kebab.rating) || 0;
}

// Card images that exist in assets/kebab-card (named like the app does).
export const CARD_FILES = new Set([
  'agra', 'ali-baba-food-house', 'baba-turkish', 'beirut-snack', 'bella-istanbul-3',
  'bologna-barbecue', 'ciao-kebab', 'delizioso-food', 'dr-jimmy', 'ekopollo',
  'gli-scugnizzi', 'i-panini-di-mirò', 'nemrut-doner', 'nosadella-pizza-kebab',
  'pamcial', 'parsit', 'pizza-n-pizza', 'pizzeria-chicco', 'pizzeria-girasole',
  'sham-cibo-siriano', 'taj-mahal', 'to-steki',
]);

/** Path of the kebab's card image in the Flutter web build, or null. */
export function cardImagePath(name) {
  const file = String(name || '').toLowerCase().replace(/ /g, '-');
  if (!CARD_FILES.has(file)) return null;
  return `/assets/assets/kebab-card/${encodeURIComponent(file)}.webp`;
}

/** Rating colours, green (great) to red (poor). Same values as _pinBands in map_page.dart. */
const RATING_BANDS = [
  // Generous bands: Kebabbo's ratings are strict (almost nothing above 4).
  { min: 4.0, fill: '#1B5E20', text: '#FFFFFF' },
  { min: 3.5, fill: '#2E7D32', text: '#FFFFFF' },
  { min: 3.0, fill: '#8BC34A', text: '#2B1A12' },
  { min: 2.5, fill: '#F2A900', text: '#2B1A12' },
  { min: 0.01, fill: '#C62828', text: '#FFFFFF' },
];

export function ratingColors(rating) {
  const band = RATING_BANDS.find((b) => rating >= b.min);
  return band || { fill: '#D9D2CC', text: '#2B1A12' };
}
