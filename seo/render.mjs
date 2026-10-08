// HTML for the public kebab pages. Pure functions: data in, HTML string out.
import {
  SITE, PLAY_URL, escapeHtml as e, formatRating, displayName, isInBologna,
  hasOpeningHours, isOpenNow, parseHours, DAY_KEYS, romeNow, communityStats,
  headlineRating, cardImagePath, distanceKm, ratingColors,
} from './lib.mjs';

/** Rating disc coloured by score (green to red). */
function disc(rating, small = false, label = '') {
  const c = ratingColors(rating);
  const aria = label ? ` aria-label="${e(label)}"` : '';
  return `<div class="disc${small ? ' sm' : ''}" style="background:${c.fill};color:${c.text}"${aria}>`
    + `${rating > 0 ? formatRating(rating) : '–'}</div>`;
}


const FONTS =
  'https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,700;12..96,800&family=Figtree:wght@400;500;600;700&display=swap';

const CSS = `
:root{--red:#BB0000;--saffron:#FFBA1C;--char:#2B1A12;--muted:#7A6A60;--line:#EDE6DF;--paper:#FAF7F4;--open:#137333;--openbg:#E6F4EA;--gf:#B06000;--gfbg:#FEF7E0;--community:#7B3FA0}
*{box-sizing:border-box}
html{-webkit-text-size-adjust:100%}
body{margin:0;background:var(--paper);color:var(--char);font:16px/1.5 "Figtree",system-ui,sans-serif}
a{color:inherit}
.wrap{max-width:760px;margin:0 auto;padding:0 16px}
header.top{background:var(--saffron)}
header.top .wrap{display:flex;align-items:center;justify-content:space-between;gap:12px;height:60px}
.brand{display:flex;align-items:center;gap:8px;text-decoration:none;font:800 22px "Bricolage Grotesque",sans-serif;letter-spacing:-.02em}
.brand img{width:34px;height:34px}
.btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;border-radius:14px;padding:11px 16px;font:700 15px "Figtree",sans-serif;text-decoration:none;border:0;cursor:pointer}
.btn-red{background:var(--red);color:#fff}
.btn-light{background:#fff;color:var(--char);border:1px solid var(--line)}
.btn-dark{background:var(--char);color:#fff}
.btn:focus-visible,a:focus-visible{outline:3px solid var(--saffron);outline-offset:2px}
.hero{position:relative;height:300px;background:linear-gradient(135deg,#BB0000,#7A0000);overflow:hidden}
.hero img.cover{width:100%;height:100%;object-fit:cover;object-position:center 30%;display:block}
.hero img.logo{position:absolute;inset:0;margin:auto;width:150px;height:150px;opacity:.9}
.hero::after{content:"";position:absolute;inset:0;background:linear-gradient(to bottom,rgba(0,0,0,.25),transparent 40%,rgba(0,0,0,.8))}
.hero .title{position:absolute;left:0;right:0;bottom:18px;z-index:1}
.hero h1{margin:0;color:#fff;font:800 clamp(30px,7vw,44px)/1.05 "Bricolage Grotesque",sans-serif;letter-spacing:-.02em;text-shadow:0 2px 12px rgba(0,0,0,.5)}
.hero .where{color:rgba(255,255,255,.85);font-weight:600;margin-top:4px}
.summary{background:#fff;border-bottom:1px solid var(--line);padding:16px 0}
.chips{display:flex;flex-wrap:wrap;gap:6px}
.chip{display:inline-flex;align-items:center;gap:6px;padding:4px 11px;border-radius:999px;font-size:13px;font-weight:700;background:#F3EEE9}
.chip.open{background:var(--openbg);color:var(--open)}
.chip.open::before{content:"";width:7px;height:7px;border-radius:50%;background:#34A853}
.chip.gf{background:var(--gfbg);color:var(--gf)}
.score-row{display:flex;align-items:center;gap:14px;margin-top:14px}
.disc{flex:none;display:grid;place-items:center;border-radius:50%;font:800 22px/1 "Bricolage Grotesque",sans-serif;letter-spacing:-.03em;width:64px;height:64px;border:3px solid #fff;box-shadow:0 2px 8px rgba(43,26,18,.18)}
.disc.sm{width:44px;height:44px;font-size:16px}
.score-row b{display:block;font-size:16px}
.score-row span{color:var(--muted);font-size:14px}
.actions{display:flex;flex-wrap:wrap;gap:10px;margin-top:16px}
.actions .btn{flex:1 1 160px}
section.card{background:#fff;border-radius:18px;padding:18px;margin-top:14px}
section.card h2{margin:0 0 10px;font:800 21px "Bricolage Grotesque",sans-serif;letter-spacing:-.01em}
.quote{font-style:italic;color:#5b4a40;margin:0}
.bars{display:grid;gap:10px}
.bar{display:grid;grid-template-columns:90px minmax(0,1fr) 36px;align-items:center;gap:10px;font-size:14px;font-weight:600}
.bar .track{height:10px;border-radius:6px;background:#F1E6DC;overflow:hidden}
.bar .fill{height:100%;border-radius:6px;background:var(--red)}
.bar .v{text-align:right;color:var(--red);font-weight:700}
.note{font-size:13px;color:var(--muted);margin:10px 0 0}
table.hours{width:100%;border-collapse:collapse;font-size:15px}
table.hours td{padding:7px 0;border-bottom:1px solid #F3EEE9}
table.hours td:last-child{text-align:right}
table.hours tr.today td{font-weight:700;color:var(--red)}
.reviews{display:grid;gap:12px}
.review{border:1px solid var(--line);border-radius:14px;padding:12px 14px}
.review .meta{display:flex;align-items:center;justify-content:space-between;font-size:13px;color:var(--muted);margin-bottom:4px}
.pill{background:#FFF8E1;border:1px solid #FFD54F;color:var(--char);font-weight:700;border-radius:999px;padding:1px 9px}
.review p{margin:0}
.others{display:grid;gap:10px;grid-template-columns:repeat(auto-fill,minmax(min(100%,220px),1fr))}
.other{display:flex;align-items:center;gap:12px;background:var(--paper);border-radius:14px;padding:10px 12px;text-decoration:none}
.other b{display:block;font-size:15px}
.other span{font-size:13px;color:var(--muted)}
.cta{background:var(--saffron);border-radius:20px;padding:22px;margin-top:14px;display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between;gap:14px}
.cta h2{margin:0;font:800 22px "Bricolage Grotesque",sans-serif}
.cta p{margin:2px 0 0;color:#5b4228}
footer{padding:28px 0 40px;color:var(--muted);font-size:14px}
footer nav{display:flex;flex-wrap:wrap;gap:16px;margin-bottom:8px}
.rank-list{list-style:none;margin:0;padding:0;display:grid;gap:10px}
.rank-list a{display:flex;align-items:center;gap:14px;background:#fff;border-radius:16px;padding:12px 14px;text-decoration:none}
.rank-list .n{width:26px;text-align:center;font:800 18px "Bricolage Grotesque",sans-serif;color:var(--red)}
.rank-list .t{flex:1;min-width:0}
.rank-list b{display:block;font-size:16px}
.rank-list span{font-size:13px;color:var(--muted)}
.page-head{padding:26px 0 8px}
.page-head h1{margin:0 0 6px;font:800 clamp(28px,6vw,40px)/1.1 "Bricolage Grotesque",sans-serif;letter-spacing:-.02em}
.page-head p{margin:0;color:var(--muted);max-width:60ch}
h2.group{font:800 22px "Bricolage Grotesque",sans-serif;margin:26px 0 10px}
`;

function layout({ title, description, canonical, image, jsonLd, body }) {
  const img = image || `${SITE}/icons/Icon-512.png`;
  return `<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${e(title)}</title>
<meta name="description" content="${e(description)}">
<link rel="canonical" href="${e(canonical)}">
<meta name="theme-color" content="#BB0000">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Kebabbo">
<meta property="og:locale" content="it_IT">
<meta property="og:url" content="${e(canonical)}">
<meta property="og:title" content="${e(title)}">
<meta property="og:description" content="${e(description)}">
<meta property="og:image" content="${e(img)}">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${e(title)}">
<meta name="twitter:description" content="${e(description)}">
<meta name="twitter:image" content="${e(img)}">
<link rel="icon" type="image/png" href="/favicon.png">
<link rel="apple-touch-icon" href="/icons/Icon-192.png">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="${FONTS}" rel="stylesheet">
<style>${CSS}</style>
${jsonLd ? `<script type="application/ld+json">${JSON.stringify(jsonLd).replace(/</g, '\\u003c')}</script>` : ''}
</head>
<body>
<header class="top"><div class="wrap">
  <a class="brand" href="/"><img src="/icons/Icon-192.png" alt="">Kebabbo</a>
  <a class="btn btn-red" href="/">Apri Kebabbo</a>
</div></header>
${body}
<footer><div class="wrap">
  <nav><a href="/kebab">Tutti i kebab</a><a href="${PLAY_URL}">App Android</a><a href="/privacy-policy">Privacy Policy</a></nav>
  Kebabbo, la guida ai migliori kebab di Bologna.
</div></footer>
</body>
</html>`;
}

const tagLabel = (tag) => (tag === 'kebab' ? 'Kebab' : 'Paninoteca');

function mapsUrl(k) {
  if (k.map && /^https?:\/\//.test(k.map)) return k.map;
  if (typeof k.lat === 'number' && typeof k.lng === 'number') {
    return `https://www.google.com/maps/search/?api=1&query=${k.lat},${k.lng}`;
  }
  return null;
}

const DAY_LABELS = ['Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato', 'Domenica'];
const SCHEMA_DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

function openingHoursSchema(raw) {
  const hours = parseHours(raw);
  if (!hours) return undefined;
  const specs = [];
  DAY_KEYS.forEach((key, i) => {
    const value = String(hours[key] ?? '').toLowerCase();
    for (const interval of value.split(',')) {
      const m = interval.trim().match(/^(\d{1,2}):(\d{2})\s*-\s*(\d{1,2}):(\d{2})$/);
      if (!m) continue;
      specs.push({
        '@type': 'OpeningHoursSpecification',
        dayOfWeek: SCHEMA_DAYS[i],
        opens: `${m[1].padStart(2, '0')}:${m[2]}`,
        closes: `${m[3].padStart(2, '0')}:${m[4]}`,
      });
    }
  });
  return specs.length ? specs : undefined;
}

const dateFormat = new Intl.DateTimeFormat('it-IT', { day: 'numeric', month: 'long', year: 'numeric' });

function reviewScore(r) {
  const vals = ['quality', 'quantity', 'price', 'menu'].map((k) => Number(r[k]) || 0);
  return vals.reduce((a, b) => a + b, 0) / 4;
}

/** Page for one kebab. `others` = other kebabs (with slug), used for "nearby" links. */
export function renderKebabPage(kebab, reviews, others) {
  const name = displayName(kebab.name);
  const stats = communityStats(reviews);
  const rating = headlineRating(kebab, stats);
  const isStaff = kebab.is_staff === true;
  const inBologna = isInBologna(kebab);
  const canonical = `${SITE}/kebab/${kebab.slug}`;
  const card = cardImagePath(kebab.name);
  const image = card ? `${SITE}${card}` : null;
  const showHours = hasOpeningHours(kebab.orari_apertura);
  const open = showHours && isOpenNow(kebab.orari_apertura);
  const maps = mapsUrl(kebab);

  const where = inBologna ? 'Bologna' : '';
  const title = `${name}${where ? ` – kebab a ${where}` : ''}: voto ${formatRating(rating)} | Kebabbo`;
  const descParts = [
    `${name}${where ? `, ${where}` : ''}: voto ${formatRating(rating)} su 5${isStaff ? ' dallo staff di Kebabbo' : ''}`,
    stats ? `${stats.count} ${stats.count === 1 ? 'recensione' : 'recensioni'} della community` : null,
    kebab.description ? String(kebab.description).slice(0, 110) : null,
  ].filter(Boolean);
  const description = descParts.join('. ').replace(/\.\./g, '.');

  // Bars: staff values for staff places, otherwise community averages.
  const source = isStaff || !stats
    ? { quality: kebab.quality, price: kebab.price, quantity: kebab.dimension, menu: kebab.menu }
    : { quality: stats.quality, price: stats.price, quantity: stats.quantity, menu: stats.menu };
  const bars = [
    ['Qualità', source.quality], ['Prezzo', source.price],
    ['Quantità', source.quantity], ['Menu', source.menu],
  ].filter(([, v]) => Number(v) > 0);

  const today = romeNow().day;
  const hours = parseHours(kebab.orari_apertura) || {};

  const nearby = others
    .filter((o) => o.id !== kebab.id && typeof o.lat === 'number' && typeof kebab.lat === 'number')
    .map((o) => ({ ...o, d: distanceKm(kebab.lat, kebab.lng, o.lat, o.lng) }))
    .filter((o) => o.d <= 30)
    .sort((a, b) => a.d - b.d)
    .slice(0, 6);

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Restaurant',
    name,
    url: canonical,
    servesCuisine: tagLabel(kebab.tag),
    ...(image ? { image } : {}),
    ...(typeof kebab.lat === 'number'
      ? { geo: { '@type': 'GeoCoordinates', latitude: kebab.lat, longitude: kebab.lng } }
      : {}),
    ...(where ? { address: { '@type': 'PostalAddress', addressLocality: where, addressCountry: 'IT' } } : {}),
    ...(maps ? { hasMap: maps } : {}),
    openingHoursSpecification: openingHoursSchema(kebab.orari_apertura),
    ...(stats
      ? { aggregateRating: { '@type': 'AggregateRating', ratingValue: Number(stats.overall.toFixed(2)), bestRating: 5, worstRating: 1, reviewCount: stats.count } }
      : {}),
  };

  const body = `
<div class="hero">
  ${card ? `<img class="cover" src="${e(card)}" alt="${e(name)}">` : '<img class="logo" src="/icons/Icon-512.png" alt="">'}
  <div class="title"><div class="wrap">
    <h1>${e(name)}</h1>
    ${where ? `<div class="where">${tagLabel(kebab.tag)} a ${where}</div>` : `<div class="where">${tagLabel(kebab.tag)}</div>`}
  </div></div>
</div>

<div class="summary"><div class="wrap">
  <div class="chips">
    ${showHours ? `<span class="chip${open ? ' open' : ''}">${open ? 'Aperto ora' : 'Chiuso ora'}</span>` : ''}
    ${kebab.gluten_free ? '<span class="chip gf">Senza glutine</span>' : ''}
    ${isStaff ? '<span class="chip">Verificato dallo staff Kebabbo</span>' : '<span class="chip">Aggiunto dalla community</span>'}
  </div>
  <div class="score-row">
    ${disc(rating, false, `Voto ${formatRating(rating)} su 5`)}
    <div>
      <b>${isStaff ? 'Voto dello staff Kebabbo' : 'Voto della community'}</b>
      <span>${stats ? `Community: ${formatRating(stats.overall)} da ${stats.count} ${stats.count === 1 ? 'recensione' : 'recensioni'}` : 'Nessuna recensione della community, per ora'}</span>
    </div>
  </div>
  <div class="actions">
    <a class="btn btn-red" href="/?kebab=${kebab.id}">Apri in Kebabbo</a>
    ${maps ? `<a class="btn btn-light" href="${e(maps)}" rel="noopener">Indicazioni</a>` : ''}
  </div>
</div></div>

<main class="wrap">
  ${kebab.description ? `<section class="card"><h2>${isStaff ? 'La recensione di Kebabbo' : 'Descrizione'}</h2><p class="quote">${e(kebab.description)}</p></section>` : ''}

  ${bars.length ? `<section class="card"><h2>Valutazione</h2><div class="bars">
    ${bars.map(([label, v]) => `<div class="bar"><span>${label}</span><div class="track"><div class="fill" style="width:${Math.min(100, (Number(v) / 5) * 100).toFixed(0)}%"></div></div><span class="v">${formatRating(Number(v))}</span></div>`).join('')}
  </div>${isStaff ? '' : '<p class="note">Media delle recensioni della community.</p>'}</section>` : ''}

  ${showHours ? `<section class="card"><h2>Orari di apertura</h2><table class="hours"><tbody>
    ${DAY_KEYS.map((key, i) => `<tr${i === today ? ' class="today"' : ''}><td>${DAY_LABELS[i]}</td><td>${e(hours[key] || 'Chiuso')}</td></tr>`).join('')}
  </tbody></table></section>` : ''}

  <section class="card"><h2>Recensioni della community</h2>
  ${reviews.length ? `<div class="reviews">${reviews.slice(0, 6).map((r) => `
    <article class="review">
      <div class="meta"><span>${r.created_at ? dateFormat.format(new Date(r.created_at)) : ''}</span><span class="pill">${formatRating(reviewScore(r))}</span></div>
      ${r.description ? `<p>${e(r.description)}</p>` : ''}
    </article>`).join('')}</div>
    ${reviews.length > 6 ? `<p class="note">Altre ${reviews.length - 6} recensioni nell'app.</p>` : ''}`
    : '<p class="quote" style="font-style:normal">Ancora nessuna recensione. Sii il primo a scriverla dall\'app.</p>'}
  </section>

  ${nearby.length ? `<section class="card"><h2>Altri kebab nella zona</h2><div class="others">
    ${nearby.map((o) => `<a class="other" href="/kebab/${e(o.slug)}">${disc(Number(o.rating) || 0, true)}<div><b>${e(displayName(o.name))}</b><span>a ${o.d < 1 ? `${Math.round(o.d * 1000)} m` : `${formatRating(o.d)} km`}</span></div></a>`).join('')}
  </div></section>` : ''}

  <div class="cta">
    <div><h2>Recensisci ${e(name)}</h2><p>Scarica Kebabbo, vota il tuo kebab e colleziona medaglie e carte.</p></div>
    <a class="btn btn-dark" href="${PLAY_URL}">Scarica l'app</a>
  </div>
</main>`;

  return layout({ title, description, canonical, image, jsonLd, body });
}

/** Ranking of all kebabs, Bologna first. `reviews` = all reviews (for counts). */
export function renderIndexPage(kebabs, reviews) {
  const byKebab = {};
  for (const r of reviews) (byKebab[r.kebabber_id] ||= []).push(r);
  const rows = kebabs.map((k) => {
    const stats = communityStats(byKebab[k.id] || []);
    return { ...k, score: headlineRating(k, stats), count: stats?.count || 0 };
  });
  const sortByScore = (a, b) => b.score - a.score;
  const bologna = rows.filter(isInBologna).sort(sortByScore);
  const world = rows.filter((k) => !isInBologna(k)).sort(sortByScore);

  const item = (k, i) => `<li><a href="/kebab/${e(k.slug)}">
    ${i != null ? `<span class="n">${i + 1}</span>` : ''}
    <span class="t"><b>${e(displayName(k.name))}</b><span>${tagLabel(k.tag)}${k.is_staff ? ', staff Kebabbo' : ', community'}${k.count ? `, ${k.count} ${k.count === 1 ? 'recensione' : 'recensioni'}` : ''}</span></span>
    ${disc(k.score, true)}
  </a></li>`;

  const body = `<main class="wrap">
  <div class="page-head">
    <h1>I migliori kebab di Bologna</h1>
    <p>La classifica di Kebabbo: voti dello staff e della community su qualità, prezzo, quantità e menu. Tocca un locale per orari, recensioni e indicazioni.</p>
  </div>
  <ol class="rank-list">${bologna.map((k, i) => item(k, i)).join('')}</ol>
  ${world.length ? `<h2 class="group">Kebab provati in giro per il mondo</h2><ul class="rank-list">${world.map((k) => item(k, null)).join('')}</ul>` : ''}
  <div class="cta">
    <div><h2>Manca il tuo kebabbaro?</h2><p>Aggiungilo dall'app e lascia la prima recensione.</p></div>
    <a class="btn btn-dark" href="${PLAY_URL}">Scarica l'app</a>
  </div>
</main>`;

  return layout({
    title: 'Classifica dei migliori kebab di Bologna | Kebabbo',
    description: `La classifica dei kebab di Bologna di Kebabbo: ${bologna.length} locali votati dallo staff e dalla community, con orari, recensioni e indicazioni.`,
    canonical: `${SITE}/kebab`,
    jsonLd: {
      '@context': 'https://schema.org',
      '@type': 'ItemList',
      name: 'I migliori kebab di Bologna',
      itemListElement: bologna.map((k, i) => ({
        '@type': 'ListItem', position: i + 1, url: `${SITE}/kebab/${k.slug}`, name: displayName(k.name),
      })),
    },
    body,
  });
}

export function renderNotFound() {
  return layout({
    title: 'Kebab non trovato | Kebabbo',
    description: 'Questo kebabbaro non esiste o è stato rimosso.',
    canonical: `${SITE}/kebab`,
    body: `<main class="wrap"><div class="page-head"><h1>Kebab non trovato</h1>
      <p>Questo locale non esiste o è stato rimosso. Guarda la classifica completa.</p></div>
      <p><a class="btn btn-red" href="/kebab">Tutti i kebab</a></p></main>`,
  });
}

export function renderSitemap(kebabs) {
  const urls = [
    { loc: `${SITE}/`, priority: '1.0', freq: 'weekly' },
    { loc: `${SITE}/kebab`, priority: '0.9', freq: 'daily' },
    ...kebabs.map((k) => ({ loc: `${SITE}/kebab/${k.slug}`, priority: isInBologna(k) ? '0.8' : '0.5', freq: 'weekly' })),
    { loc: `${SITE}/privacy-policy`, priority: '0.2', freq: 'yearly' },
  ];
  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map((u) => `  <url><loc>${e(u.loc)}</loc><changefreq>${u.freq}</changefreq><priority>${u.priority}</priority></url>`).join('\n')}
</urlset>
`;
}
