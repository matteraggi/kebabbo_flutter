// Turns a request path into a response. Used by the Vercel functions in /api
// and by scripts/serve-local.mjs, so both behave the same.
import { getKebabs, getReviews, getAllReviews } from './data.mjs';
import { renderKebabPage, renderIndexPage, renderNotFound, renderSitemap } from './render.mjs';

const HTML = 'text/html; charset=utf-8';
// Cached at the edge for 10 minutes, then served stale while it refreshes.
const CACHE = 'public, max-age=0, s-maxage=600, stale-while-revalidate=86400';

/** @returns {Promise<{status:number, headers:Record<string,string>, body:string}>} */
export async function handleKebab(slugOrId) {
  const kebabs = await getKebabs();

  if (!slugOrId) {
    const reviews = await getAllReviews();
    return { status: 200, headers: { 'Content-Type': HTML, 'Cache-Control': CACHE }, body: renderIndexPage(kebabs, reviews) };
  }

  const key = decodeURIComponent(slugOrId).toLowerCase();
  let kebab = kebabs.find((k) => k.slug === key);

  // Old/short links use the numeric id: redirect to the readable address.
  if (!kebab && /^\d+$/.test(key)) {
    const byId = kebabs.find((k) => String(k.id) === key);
    if (byId) {
      return { status: 301, headers: { Location: `/kebab/${byId.slug}`, 'Cache-Control': CACHE }, body: '' };
    }
  }

  if (!kebab) {
    return { status: 404, headers: { 'Content-Type': HTML, 'Cache-Control': 'public, max-age=60' }, body: renderNotFound() };
  }

  const reviews = await getReviews(kebab.id);
  return { status: 200, headers: { 'Content-Type': HTML, 'Cache-Control': CACHE }, body: renderKebabPage(kebab, reviews, kebabs) };
}

export async function handleSitemap() {
  const kebabs = await getKebabs();
  return { status: 200, headers: { 'Content-Type': 'application/xml; charset=utf-8', 'Cache-Control': CACHE }, body: renderSitemap(kebabs) };
}
