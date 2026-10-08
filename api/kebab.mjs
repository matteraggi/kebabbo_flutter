// Vercel function: /kebab and /kebab/<slug> (see rewrites in vercel.json).
// Needs SUPABASE_URL and SUPABASE_ANON_KEY in the Vercel project environment.
import { handleKebab } from '../seo/handler.mjs';

export default async function handler(req, res) {
  try {
    const slug = typeof req.query.slug === 'string' ? req.query.slug : '';
    const out = await handleKebab(slug);
    for (const [k, v] of Object.entries(out.headers)) res.setHeader(k, v);
    res.status(out.status).send(out.body);
  } catch (err) {
    console.error(err);
    res.status(500).send('Errore nel caricamento della pagina');
  }
}
