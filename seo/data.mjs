// Reads public data from Supabase's REST API with the anon key (read-only).
import { withSlugs } from './lib.mjs';

function config() {
  const url = process.env.SUPABASE_URL;
  const key = process.env.SUPABASE_ANON_KEY;
  if (!url || !key) {
    throw new Error('SUPABASE_URL and SUPABASE_ANON_KEY must be set');
  }
  return { url: url.replace(/\/$/, ''), key };
}

async function rest(path) {
  const { url, key } = config();
  const res = await fetch(`${url}/rest/v1/${path}`, {
    headers: { apikey: key, Authorization: `Bearer ${key}` },
  });
  if (!res.ok) {
    throw new Error(`Supabase ${res.status}: ${await res.text()}`);
  }
  return res.json();
}

// The kebab list is small (dozens of rows): cache it briefly per server instance.
let cache = { at: 0, data: null };
const TTL_MS = 5 * 60 * 1000;

const KEBAB_FIELDS = [
  'id', 'name', 'description', 'tag', 'lat', 'lng', 'rating', 'quality', 'price',
  'dimension', 'menu', 'fun', 'meat', 'yogurt', 'spicy', 'onion', 'vegetables',
  'gluten_free', 'orari_apertura', 'map', 'is_staff', 'approved', 'added_by',
].join(',');

/** All visible kebabs, each with a `slug`. */
export async function getKebabs() {
  if (cache.data && Date.now() - cache.at < TTL_MS) return cache.data;
  const rows = await rest(`kebab?select=${KEBAB_FIELDS}&order=name.asc`);
  const visible = rows.filter((k) => k.approved !== false);
  cache = { at: Date.now(), data: withSlugs(visible) };
  return cache.data;
}

/** Community reviews of one kebab, newest first. */
export async function getReviews(kebabId) {
  return rest(
    `reviews?select=description,quality,quantity,price,menu,fun,created_at` +
      `&kebabber_id=eq.${encodeURIComponent(kebabId)}&order=created_at.desc`,
  );
}

/** Review counts and averages for every kebab (for the ranking page). */
export async function getAllReviews() {
  return rest('reviews?select=kebabber_id,quality,quantity,price,menu');
}
