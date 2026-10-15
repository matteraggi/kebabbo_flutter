// Generates the Play Store screenshots (1080x1920): headline + real screen in a phone frame.
// Usage: node play-store/screenshots/compose.mjs  -> writes <lang>/<n>.html, then render them to PNG.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const dir = path.dirname(fileURLToPath(import.meta.url));

const SHOTS = {
  it: [
    ['1-home', 'I migliori kebab', 'di Bologna, in classifica'],
    ['2-map', 'La mappa', 'con i voti di ogni locale'],
    ['3-kebab', 'Ogni locale,', 'tutti i dettagli'],
    ['5-review', 'Recensisci', 'in pochi secondi'],
    ['4-share', 'Condividi', 'con gli amici'],
    ['6-profile', 'Colleziona', 'medaglie e carte'],
  ],
  en: [
    ['1-home', 'The best kebabs', 'in Bologna, ranked'],
    ['2-map', 'The map', 'with every rating'],
    ['3-kebab', 'Every place,', 'every detail'],
    ['5-review', 'Review', 'in a few seconds'],
    ['4-share', 'Share', 'with your friends'],
    ['6-profile', 'Collect', 'medals and cards'],
  ],
};

const page = (img, h1, sub) => `<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,800&family=Figtree:wght@700&display=swap" rel="stylesheet">
<style>
  * { box-sizing: border-box; margin: 0; }
  body { width: 1080px; height: 1920px; overflow: hidden; background: #FFBA1C; position: relative; }
  .blob { position: absolute; right: -260px; top: 560px; width: 900px; height: 900px; border-radius: 50%; background: #FFC94D; }
  .copy { position: absolute; left: 0; right: 0; top: 120px; text-align: center; }
  h1 { font: 800 112px/1 "Bricolage Grotesque", sans-serif; letter-spacing: -0.03em; color: #BB0000; }
  p { margin-top: 18px; font: 700 54px/1.1 "Figtree", sans-serif; color: #2B1A12; }
  .phone { position: absolute; left: 50%; top: 440px; width: 812px; transform: translateX(-50%);
    padding: 22px; border-radius: 76px; background: #1C1C1E; box-shadow: 0 40px 80px rgba(90, 40, 0, .35); }
  .phone img { display: block; width: 768px; border-radius: 56px; }
</style></head>
<body>
  <div class="blob"></div>
  <div class="copy"><h1>${h1}</h1><p>${sub}</p></div>
  <div class="phone"><img src="../raw/${img}" alt=""></div>
</body></html>
`;

for (const [lang, shots] of Object.entries(SHOTS)) {
  fs.mkdirSync(path.join(dir, lang), { recursive: true });
  shots.forEach(([name, h1, sub], i) => {
    const file = path.join(dir, lang, `${i + 1}-${name.replace(/^\d-/, '')}.html`);
    fs.writeFileSync(file, page(`${lang}/${name}.png`, h1, sub));
    console.log(file);
  });
}
