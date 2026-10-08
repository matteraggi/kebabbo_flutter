// Vercel function: /sitemap.xml, generated from the database.
import { handleSitemap } from '../seo/handler.mjs';

export default async function handler(req, res) {
  try {
    const out = await handleSitemap();
    for (const [k, v] of Object.entries(out.headers)) res.setHeader(k, v);
    res.status(out.status).send(out.body);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error');
  }
}
