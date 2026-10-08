// Local preview of the website, routed like vercel.json:
//   /kebab, /kebab/<slug>, /sitemap.xml -> generated pages (seo/)
//   any file in build/web               -> served as is
//   everything else                     -> build/web/index.html (Flutter app)
//
// Usage:  flutter build web --release --dart-define=...   (once)
//         node scripts/serve-local.mjs [port]
import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const webDir = path.join(root, 'build', 'web');
const port = Number(process.argv[2] || process.env.PORT || 8080);

// Read SUPABASE_URL / SUPABASE_ANON_KEY from .env if not already set.
const envFile = path.join(root, '.env');
if (fs.existsSync(envFile)) {
  for (const line of fs.readFileSync(envFile, 'utf8').split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z_]+)\s*=\s*"?([^"]*)"?\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2];
  }
}

const { handleKebab, handleSitemap } = await import('../seo/handler.mjs');

if (!fs.existsSync(path.join(webDir, 'index.html'))) {
  console.error('build/web not found: run "flutter build web" first.');
  process.exit(1);
}

const TYPES = {
  '.html': 'text/html; charset=utf-8', '.js': 'text/javascript', '.mjs': 'text/javascript',
  '.json': 'application/json', '.css': 'text/css', '.png': 'image/png', '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg', '.webp': 'image/webp', '.svg': 'image/svg+xml', '.ico': 'image/x-icon',
  '.wasm': 'application/wasm', '.otf': 'font/otf', '.ttf': 'font/ttf', '.txt': 'text/plain',
  '.xml': 'application/xml', '.frag': 'text/plain', '.bin': 'application/octet-stream',
};

function send(res, out) {
  res.writeHead(out.status, out.headers);
  res.end(out.body);
}

function serveFile(res, file) {
  res.writeHead(200, { 'Content-Type': TYPES[path.extname(file).toLowerCase()] || 'application/octet-stream' });
  fs.createReadStream(file).pipe(res);
}

const server = http.createServer(async (req, res) => {
  const url = new URL(req.url, `http://localhost:${port}`);
  const pathname = decodeURIComponent(url.pathname);
  try {
    let m;
    if (pathname === '/kebab' || pathname === '/kebab/') {
      return send(res, await handleKebab(''));
    }
    if ((m = pathname.match(/^\/kebab\/([^/]+)\/?$/))) {
      return send(res, await handleKebab(m[1]));
    }
    if (pathname === '/sitemap.xml') {
      return send(res, await handleSitemap());
    }
    const file = path.join(webDir, pathname);
    if (file.startsWith(webDir) && fs.existsSync(file) && fs.statSync(file).isFile()) {
      return serveFile(res, file);
    }
    return serveFile(res, path.join(webDir, 'index.html'));
  } catch (err) {
    console.error(err);
    res.writeHead(500, { 'Content-Type': 'text/plain' });
    res.end(String(err));
  }
});

server.listen(port, () => {
  console.log(`Kebabbo locale: http://localhost:${port}`);
  console.log(`  App:               http://localhost:${port}/`);
  console.log(`  Classifica kebab:  http://localhost:${port}/kebab`);
  console.log(`  Sitemap:           http://localhost:${port}/sitemap.xml`);
});
