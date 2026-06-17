
param(
  [string]$ProjectRoot = (Get-Location).Path
)

$index = Join-Path $ProjectRoot "index.html"
$css = Join-Path $ProjectRoot "src\styles.css"
$js = Join-Path $ProjectRoot "src\main.js"

if (!(Test-Path $index) -or !(Test-Path $css) -or !(Test-Path $js)) {
  Write-Host "No encontré index.html, src/styles.css o src/main.js. Ejecuta este script dentro de la carpeta del proyecto." -ForegroundColor Red
  exit 1
}

Copy-Item $index "$index.bak_v10_title" -Force
Copy-Item $css "$css.bak_v10_title" -Force
Copy-Item $js "$js.bak_v10_title" -Force

$html = Get-Content $index -Raw -Encoding UTF8
$html = $html -replace 'COSMIC NEXUS — Immersive Scroll Atlas V9 Dark Full', 'COSMIC NEXUS — Kinetic Scroll Atlas V10'
$html = $html -replace 'SCROLL ATLAS V9', 'KINETIC ATLAS V10'
$html = $html -replace 'Versión V9 Dark Full: conserva los efectos anteriores, baja el brillo, restaura el índice completo de FX y mantiene scroll vertical \+ horizontal inmersivo conectado al canvas\.', 'Versión V10 Kinetic Title: conserva todos los efectos, mantiene el look oscuro y convierte el título en un elemento vivo que se desplaza, se fragmenta, se reduce y cambia por capítulo con el scroll.'
Set-Content $index $html -Encoding UTF8

$cssText = Get-Content $css -Raw -Encoding UTF8
if ($cssText -notmatch 'V10 Kinetic Title System') {
$cssText += @'

/* V10 Kinetic Title System: el título ya no queda estático */
:root{
  --title-x: 0px;
  --title-y: 0px;
  --title-scale: 1;
  --title-rotate: 0deg;
  --title-opacity: 1;
  --title-blur: 0px;
  --title-split: 0;
  --title-letter: -0.07em;
  --chapter-title-opacity: 0;
  --chapter-title-y: 18px;
  --chapter-title-rotate: 0deg;
  --chapter-progress: 0%;
}
.hero-copy{
  transform: translate3d(var(--title-x), var(--title-y), 0) scale(var(--title-scale)) rotate(var(--title-rotate));
  transform-origin: left top;
  opacity: var(--title-opacity);
  filter: blur(var(--title-blur));
  will-change: transform, opacity, filter;
}
.hero-copy h1{letter-spacing: var(--title-letter);will-change: letter-spacing;}
.hero-copy h1 span{transition:none;will-change:transform,opacity,filter;}
.hero-copy h1 span:nth-child(1){transform:translate3d(calc(var(--title-split) * -74px), calc(var(--title-split) * -12px), 0) rotate(calc(var(--title-split) * -2.5deg));}
.hero-copy h1 span:nth-child(2){transform:translate3d(calc(var(--title-split) * 62px), calc(var(--title-split) * 5px), 0) rotate(calc(var(--title-split) * 1.8deg));}
.hero-copy h1 span:nth-child(3){transform:translate3d(calc(var(--title-split) * -28px), calc(var(--title-split) * 18px), 0) rotate(calc(var(--title-split) * .9deg));}
.kinetic-title-dock{position:fixed;z-index:58;top:86px;left:50%;transform:translate3d(-50%, var(--chapter-title-y), 0) rotate(var(--chapter-title-rotate));opacity:var(--chapter-title-opacity);pointer-events:none;width:min(720px, calc(100vw - 52px));text-align:center;will-change:transform,opacity;filter:drop-shadow(0 18px 45px rgba(0,0,0,.55));}
.kinetic-title-dock::before{content:"";position:absolute;left:50%;top:-16px;transform:translateX(-50%);width:min(420px,60vw);height:1px;background:linear-gradient(90deg,transparent,rgba(143,232,255,.55),transparent);}
.kinetic-title-kicker{display:block;margin-bottom:8px;color:rgba(143,232,255,.76);font-size:10px;letter-spacing:.32em;text-transform:uppercase;font-weight:900;}
.kinetic-title-main{display:block;font-size:clamp(24px,4.8vw,72px);line-height:.86;letter-spacing:-.055em;text-transform:uppercase;font-weight:900;color:rgba(246,250,255,.92);}
.kinetic-title-main b{color:var(--cyan);font-weight:900;text-shadow:0 0 18px rgba(143,232,255,.18);}
.kinetic-title-dock .chapter-meter{display:block;width:min(360px,54vw);height:2px;margin:14px auto 0;background:rgba(143,232,255,.10);overflow:hidden;border-radius:999px;}
.kinetic-title-dock .chapter-meter i{display:block;width:var(--chapter-progress);height:100%;background:linear-gradient(90deg,rgba(122,247,212,.35),rgba(143,232,255,.85));box-shadow:0 0 18px rgba(143,232,255,.34);}
.kinetic-orbit-word{position:fixed;z-index:57;right:clamp(22px,5vw,72px);top:28vh;pointer-events:none;transform:translate3d(0, calc(var(--title-split) * 120px), 0) rotate(90deg);transform-origin:right center;opacity:calc(var(--chapter-title-opacity) * .62);color:rgba(226,238,255,.48);font-size:10px;letter-spacing:.38em;text-transform:uppercase;font-weight:900;}
.title-motion-hint{position:fixed;z-index:58;left:clamp(22px,5vw,84px);top:clamp(72px,9vh,110px);pointer-events:none;opacity:calc(1 - min(var(--title-split), 1));color:rgba(226,238,255,.45);font-size:10px;letter-spacing:.24em;text-transform:uppercase;}
.title-motion-hint::before{content:"";display:inline-block;width:34px;height:1px;margin-right:10px;vertical-align:middle;background:rgba(143,232,255,.42);}
body.title-compact .brand span:last-of-type{color:var(--cyan);}
body.title-compact .topbar{box-shadow:0 0 46px rgba(0,0,0,.72),0 0 24px rgba(143,232,255,.04);}
@media(max-width:900px){.kinetic-title-dock{top:74px;width:calc(100vw - 36px)}.kinetic-title-main{font-size:clamp(22px,9vw,48px)}.kinetic-orbit-word,.title-motion-hint{display:none}.hero-copy h1 span:nth-child(1),.hero-copy h1 span:nth-child(2),.hero-copy h1 span:nth-child(3){transform:none}}
'@
Set-Content $css $cssText -Encoding UTF8
}

$jsText = Get-Content $js -Raw -Encoding UTF8
if ($jsText -notmatch 'kineticTitleDock') {
$jsText = $jsText -replace "const assetStatus = document.querySelector\('#assetStatus'\);", @"
const assetStatus = document.querySelector('#assetStatus');
const heroCopy = document.querySelector('#heroCopy');
const kineticTitle = heroCopy?.querySelector('h1');
const kineticTitleDock = document.createElement('div');
kineticTitleDock.className = 'kinetic-title-dock';
kineticTitleDock.innerHTML = `<span class="kinetic-title-kicker">00 / opening transmission</span><span class="kinetic-title-main">Cosmic <b>Nexus</b></span><span class="chapter-meter"><i></i></span>`;
document.body.appendChild(kineticTitleDock);
const kineticOrbitWord = document.createElement('div');
kineticOrbitWord.className = 'kinetic-orbit-word';
kineticOrbitWord.textContent = 'scroll controlled title';
document.body.appendChild(kineticOrbitWord);
const titleMotionHint = document.createElement('div');
titleMotionHint.className = 'title-motion-hint';
titleMotionHint.textContent = 'el título responde al scroll';
document.body.appendChild(titleMotionHint);
"@
$jsText = $jsText -replace "const chapterNames = \['Hero', 'Orbit', 'Shader', 'Portal', 'Horizontal', 'Lab'\];", @"
const chapterNames = ['Hero', 'Orbit', 'Shader', 'Portal', 'Horizontal', 'Lab'];
const kineticChapterMeta = [
  { code: '00 / opening transmission', title: 'Cosmic <b>Nexus</b>' },
  { code: '01 / camera rail', title: 'Orbital <b>Drift</b>' },
  { code: '02 / shader reveal', title: 'Core <b>Highlight</b>' },
  { code: '03 / wormhole', title: 'Portal <b>Awakening</b>' },
  { code: '04 / horizontal journey', title: 'Immersive <b>Traverse</b>' },
  { code: '05 / fx laboratory', title: 'Effects <b>Atlas</b>' },
  { code: '06 / launch', title: 'Final <b>Sequence</b>' }
];
"@
$kineticFunc = @'
function updateKineticTitle(progress, chapter) {
  const p = THREE.MathUtils.clamp(progress, 0, 1);
  const split = THREE.MathUtils.smoothstep(p, 0.015, 0.24);
  const compact = THREE.MathUtils.smoothstep(p, 0.06, 0.30);
  const fade = 1 - THREE.MathUtils.smoothstep(p, 0.11, 0.34);
  const mobile = innerWidth < 900;
  const titleX = mobile ? 0 : -compact * 92;
  const titleY = mobile ? -compact * 32 : -compact * 178;
  const titleScale = mobile ? 1 - compact * .22 : 1 - compact * .58;
  const titleRotate = mobile ? 0 : -compact * 2.8;
  const titleBlur = Math.max(0, (compact - .62) * 4.2);
  document.documentElement.style.setProperty('--title-x', `${titleX.toFixed(2)}px`);
  document.documentElement.style.setProperty('--title-y', `${titleY.toFixed(2)}px`);
  document.documentElement.style.setProperty('--title-scale', titleScale.toFixed(3));
  document.documentElement.style.setProperty('--title-rotate', `${titleRotate.toFixed(2)}deg`);
  document.documentElement.style.setProperty('--title-opacity', Math.max(0, fade).toFixed(3));
  document.documentElement.style.setProperty('--title-blur', `${titleBlur.toFixed(2)}px`);
  document.documentElement.style.setProperty('--title-split', split.toFixed(3));
  document.documentElement.style.setProperty('--title-letter', `${(-0.07 + split * 0.045).toFixed(3)}em`);
  const dockOpacity = THREE.MathUtils.smoothstep(p, 0.075, 0.22) * (1 - THREE.MathUtils.smoothstep(p, 0.92, 1.0) * .28);
  const dockY = 22 - dockOpacity * 22 + Math.sin(p * Math.PI * 5.0) * 5.0;
  const dockRotate = Math.sin(p * Math.PI * 2.0) * .85;
  document.documentElement.style.setProperty('--chapter-title-opacity', dockOpacity.toFixed(3));
  document.documentElement.style.setProperty('--chapter-title-y', `${dockY.toFixed(2)}px`);
  document.documentElement.style.setProperty('--chapter-title-rotate', `${dockRotate.toFixed(2)}deg`);
  document.documentElement.style.setProperty('--chapter-progress', `${Math.round(p * 100)}%`);
  document.body.classList.toggle('title-compact', compact > .28);
  const meta = kineticChapterMeta[chapter] || kineticChapterMeta[kineticChapterMeta.length - 1];
  const nextMeta = kineticChapterMeta[Math.min(kineticChapterMeta.length - 1, chapter + 1)] || meta;
  const local = Math.min(1, Math.max(0, (p * 6) - chapter));
  const phase = local < .5 ? meta : nextMeta;
  kineticTitleDock.querySelector('.kinetic-title-kicker').textContent = phase.code;
  kineticTitleDock.querySelector('.kinetic-title-main').innerHTML = phase.title;
  kineticOrbitWord.textContent = `${phase.code.replace(' / ', ' // ')} // ${Math.round(p * 100)}%`;
}
'@
$jsText = $jsText -replace "function syncScroll\(progress\) \{", "$kineticFunc`nfunction syncScroll(progress) {"
$jsText = $jsText -replace "  updateChapterRail\(chapter\);", "  updateChapterRail(chapter);`n  updateKineticTitle(progress, chapter);"
$jsText = $jsText -replace "initScroll\(\);\s*checkAssets\(\);", "initScroll();`nsyncScroll(getPageProgress());`ncheckAssets();"
Set-Content $js $jsText -Encoding UTF8
}

Write-Host "V10 aplicado: título cinético activado." -ForegroundColor Green
Write-Host "Backups creados con sufijo .bak_v10_title" -ForegroundColor Yellow
Write-Host "Ejecuta: py -m http.server 5500" -ForegroundColor Cyan
