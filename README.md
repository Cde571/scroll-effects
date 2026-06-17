<img width="1917" height="942" alt="COSMIC NEXUS preview" src="https://github.com/user-attachments/assets/c0e424b7-e1bd-4944-8ca5-759b3f30ca07" />

# COSMIC NEXUS — Immersive Scroll Atlas

**COSMIC NEXUS** is an immersive Three.js / WebGL experience focused on cinematic scroll navigation, dark-space art direction, shader highlights, procedural particles, horizontal pinned sections, kinetic titles and a premium sci-fi HUD.

The project evolved from a visual effects showcase into a complete interactive atlas where the user scrolls through spatial chapters while the camera, post-processing, particles, title system, HUD and scene elements react in real time.

> Current recommended build: **V10 Kinetic Title + V12 Mission Mode Removed + V13 Early Title Exit**

---

## Preview

The interface uses a full-screen fixed WebGL canvas, a dark cinematic background, procedural stars, smoke/nebula layers, a kinetic title system and interactive FX controls.

```text
Scroll ↓
├── Hero title enters and exits early
├── Camera travels through spatial chapters
├── Smoke / nebula density increases
├── Shader highlight moves across the core
├── Horizontal pinned scroll section activates
├── Portal / wormhole effects appear
└── FX Rack allows live post-processing control
```

---

## Main Concept

The goal is not to build a normal landing page.  
The goal is to create an **immersive spatial interface** combining:

- WebGL rendering
- scroll-driven animation
- cinematic motion
- procedural space visuals
- shader-based effects
- premium HUD design
- interactive FX toggles
- Blender-ready asset pipeline

The page works as a **visual atlas of advanced Three.js effects**, but without using heavy static cards as the main interface.

---

## Key Features

### Immersive Scroll System

- Vertical scroll controls camera movement.
- Smooth scroll is handled with Lenis.
- ScrollTrigger connects scroll progress with scene states.
- Horizontal pinned section creates an immersive sideways journey.
- Chapter progress updates the dynamic title.
- The main title exits early to avoid overlapping with the camera-on-rail section.

### Kinetic Title System

The main title no longer stays fixed.

It:

- fragments by lines;
- scales down while scrolling;
- fades before the rail-camera chapter;
- transforms into a compact chapter label;
- updates according to the active section;
- uses a progress bar connected to scroll.

### Dark Full Visual Grade

The V9/V10 visual style reduces excessive brightness while keeping the scene alive.

Includes:

- lower global exposure;
- reduced bloom intensity;
- softer lensflare;
- darker smoke;
- stronger vignette;
- readable HUD contrast;
- visible stars without overexposure.

### Three.js Scene

The scene includes:

- fixed WebGL canvas;
- procedural core object;
- starfield;
- smoke / nebula texture;
- rings and energy arcs;
- portal / wormhole layer;
- instanced asteroid field;
- LOD-ready object;
- raycaster hover/select logic;
- CSS2D labels;
- minimap / radar;
- ruler / distance indicators.

### Post-processing Stack

The project uses a real `EffectComposer` pipeline:

- `RenderPass`
- `OutputPass`
- `UnrealBloomPass`
- `GlitchPass`
- `FilmPass`
- `AfterimagePass`
- `BokehPass`
- `SSAOPass`
- `SMAAPass`
- `ShaderPass`
- `RGBShiftShader`
- `OutlinePass`

Some passes can be activated from the FX Rack depending on performance and visual preference.

### FX Rack

The live FX panel can toggle or adjust:

- Bloom
- Glitch
- RGB Shift
- Film
- Afterimage
- Bokeh / Depth of Field
- SSAO
- Outline
- Scanlines
- Stars
- Smoke
- Portal
- Rings
- Energy Arcs
- Instancing
- Scale Grid
- Labels
- HUD
- Radar
- Cursor
- Lensflare

### Blender / GLB Pipeline

The project is ready for Blender models.

Supported structure:

```text
assets/
└── models/
    └── model.glb
```

When a `model.glb` file is added, it can be loaded into the scene through the GLB loader pipeline.

Prepared technologies:

- `GLTFLoader`
- `DRACOLoader`
- `KTX2Loader`
- `AnimationMixer`
- compressed textures
- animated GLB support

---

## Project Structure

```text
cosmic_nexus_scroll_atlas/
├── index.html
├── README.md
├── effects-list.md
├── run.ps1
├── run.bat
├── src/
│   ├── main.js
│   ├── styles.css
│   ├── title-kinetic-v10.js
│   ├── title-kinetic-v10.css
│   └── optional-patches/
├── assets/
│   ├── models/
│   │   └── model.glb
│   ├── textures/
│   ├── video/
│   └── lottie/
└── docs/
```

---

## How to Run

### Option 1 — PowerShell

```powershell
cd .\cosmic_nexus_scroll_atlas
py -m http.server 5500
```

Open:

```text
http://localhost:5500
```

### Option 2 — Included script

```powershell
.\run.ps1
```

### Option 3 — Batch file

```bat
run.bat
```

---

## Recommended Browser

Use a modern Chromium-based browser:

- Google Chrome
- Microsoft Edge
- Brave

Recommended hardware:

```text
GPU: dedicated or modern integrated GPU
RAM: 8 GB minimum
Browser WebGL2 support: required
```

---

## JavaScript Architecture

The experience is built around four main loops:

```js
initScene();
initScrollExperience();
initPostProcessing();
animate();
```

### Scene Initialization

```js
const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(
  55,
  window.innerWidth / window.innerHeight,
  0.1,
  2000
);

const renderer = new THREE.WebGLRenderer({
  antialias: true,
  powerPreference: "high-performance",
  alpha: false
});

renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.outputColorSpace = THREE.SRGBColorSpace;
renderer.toneMapping = THREE.ACESFilmicToneMapping;
renderer.toneMappingExposure = 0.72;

document.body.appendChild(renderer.domElement);
```

### Post-processing Composer

```js
const composer = new EffectComposer(renderer);

const renderPass = new RenderPass(scene, camera);
const bloomPass = new UnrealBloomPass(
  new THREE.Vector2(window.innerWidth, window.innerHeight),
  0.32,
  0.42,
  0.82
);

const outputPass = new OutputPass();

composer.addPass(renderPass);
composer.addPass(bloomPass);
composer.addPass(outputPass);
```

### Scroll Progress

```js
function getScrollProgress() {
  const maxScroll =
    document.documentElement.scrollHeight - window.innerHeight;

  return maxScroll > 0
    ? THREE.MathUtils.clamp(window.scrollY / maxScroll, 0, 1)
    : 0;
}
```

### Scroll-driven Camera

```js
function updateCameraFromScroll(progress) {
  camera.position.x = THREE.MathUtils.lerp(0, -6, progress);
  camera.position.y = THREE.MathUtils.lerp(1.8, 3.2, progress);
  camera.position.z = THREE.MathUtils.lerp(9, 3.5, progress);

  camera.lookAt(0, 0, 0);
}
```

### Shader Uniform Controlled by Scroll

```js
coreMaterial.uniforms.uScroll.value = progress;
coreMaterial.uniforms.uReveal.value = smoothstep(0.18, 0.62, progress);
coreMaterial.uniforms.uPortal.value = smoothstep(0.68, 0.92, progress);
```

### Horizontal Pinned Scroll

```js
const panels = gsap.utils.toArray(".horizontal-panel");
const track = document.querySelector(".horizontal-track");

gsap.to(track, {
  xPercent: -100 * (panels.length - 1),
  ease: "none",
  scrollTrigger: {
    trigger: ".horizontal-section",
    start: "top top",
    end: () => "+=" + window.innerWidth * (panels.length - 1),
    scrub: 1,
    pin: true,
    anticipatePin: 1
  }
});
```

### Kinetic Title Early Exit

```js
function updateKineticTitle(progress) {
  const heroExit = THREE.MathUtils.clamp(progress / 0.18, 0, 1);

  titleElement.style.opacity = String(1 - heroExit);
  titleElement.style.transform = `
    translate3d(0, ${-heroExit * 90}px, 0)
    scale(${1 - heroExit * 0.22})
  `;

  compactTitle.classList.toggle("active", progress > 0.16);
}
```

---

## Main Effects List

| # | Effect | Status |
|---|---|---|
| 01 | Fixed WebGL Canvas | Implemented |
| 02 | Dark Space Background | Implemented |
| 03 | Procedural Starfield | Implemented |
| 04 | Smoke / Nebula Layer | Implemented |
| 05 | Scroll-driven Camera | Implemented |
| 06 | Kinetic Title | Implemented |
| 07 | Early Title Exit | Implemented |
| 08 | Chapter Label | Implemented |
| 09 | Horizontal Pinned Scroll | Implemented |
| 10 | Shader Highlight | Implemented |
| 11 | Portal / Wormhole | Implemented |
| 12 | Bloom | Implemented |
| 13 | Glitch | Implemented |
| 14 | Film Grain | Implemented |
| 15 | RGB Shift | Implemented |
| 16 | Bokeh / DOF | Implemented |
| 17 | SSAO | Implemented |
| 18 | SMAA | Implemented |
| 19 | Outline Highlight | Implemented |
| 20 | Raycaster | Implemented |
| 21 | Material Swatches | Implemented |
| 22 | Lensflare | Implemented |
| 23 | Instanced Asteroids | Implemented |
| 24 | LOD Object | Implemented |
| 25 | CSS2D Labels | Implemented |
| 26 | Radar / Minimap | Implemented |
| 27 | Distance Ruler | Implemented |
| 28 | Fullscreen API | Implemented |
| 29 | AudioContext Base | Implemented |
| 30 | GLB Loader Pipeline | Prepared |
| 31 | DRACO Loader | Prepared |
| 32 | KTX2 Loader | Prepared |
| 33 | AnimationMixer | Prepared |
| 34 | WebXR Button | Prepared |
| 35 | Asset Check | Implemented |
| 36 | Dark / Soft / Max FX Modes | Implemented |
| 37 | FX Rack | Implemented |
| 38 | Reduced Brightness Grade | Implemented |
| 39 | Responsive Layout | Implemented |
| 40 | PowerShell Patches | Implemented |

---

## Version History

### V8 — Immersive Scroll Atlas

Added:

- full-screen immersive scroll;
- horizontal pinned scroll;
- post-processing stack;
- stars, smoke, portal and shader core;
- Blender-ready asset folders.

### V9 — Dark Full

Fixed excessive brightness.

Added:

- darker exposure;
- reduced bloom;
- stronger contrast;
- FX Rack expansion;
- complete effect atlas;
- dark / soft / max FX modes.

### V10 — Kinetic Title

Fixed static title issue.

Added:

- title fragmentation;
- scroll-based title motion;
- chapter title system;
- compact dynamic title;
- progress bar;
- better visual hierarchy.

### V12 — Mission Mode Removed

Removed the mission overlay and mission-specific logic.

Kept:

- cinematic scroll;
- FX Rack;
- dark mode;
- kinetic title;
- post-processing;
- immersive horizontal section.

### V13 — Early Title Exit

Fixed title overlap with the camera-on-rail chapter.

Changed:

- title exits earlier;
- center hero text fades faster;
- compact chapter title moves to a safer location;
- camera rail section is visually cleaner.

---

## Optional Assets

### Blender Model

Place your model here:

```text
assets/models/model.glb
```

Then use the **Load GLB** button.

### HDR / Environment

Optional:

```text
assets/textures/studio.hdr
```

### Video Texture

Optional:

```text
assets/video/demo.mp4
```

### Lottie Animation

Optional:

```text
assets/lottie/animation.json
```

---

## Development Notes

The project uses native browser APIs and CDN-based modules.  
For production, it is recommended to migrate to Vite:

```powershell
npm create vite@latest cosmic-nexus -- --template vanilla
cd cosmic-nexus
npm install three gsap @studio-freight/lenis
npm run dev
```

Recommended production improvements:

- bundle all modules locally;
- compress textures with KTX2;
- compress GLB with Draco or Meshopt;
- add lazy loading;
- add mobile reduced-FX mode;
- add asset preloader;
- add GitHub Pages deployment;
- add fallback when WebGL2 is unavailable.

---

## Performance Tips

If the scene is too heavy:

1. Disable `Max FX`.
2. Lower the Glow slider.
3. Disable SSAO and Bokeh.
4. Reduce pixel ratio to `1`.
5. Disable smoke and portal.
6. Use compressed textures.
7. Use low-poly GLB models.
8. Use the dark preset as default.

Recommended default visual grade:

```js
renderer.toneMappingExposure = 0.72;
bloomPass.strength = 0.32;
bloomPass.radius = 0.42;
bloomPass.threshold = 0.82;
```

---

## Controls

| Control | Action |
|---|---|
| Scroll | Move through immersive experience |
| Drag | Rotate / inspect the core |
| Hover | Activate cursor feedback |
| Click FX Button | Toggle visual effect |
| Load GLB | Load Blender model |
| Fullscreen | Enter immersive fullscreen |
| Dark | Apply dark visual grade |
| Soft Bloom | Apply subtle glow |
| Max FX | Activate all visual effects |
| Reset FX | Restore default grade |

---

## Current Recommended State

The clean recommended experience is:

```text
V10 Kinetic Title
+ V12 Mission Mode Removed
+ V13 Early Title Exit
```

This keeps the project focused as a premium **scroll atlas**, not a mission-game interface.

---

## Author / Project

**COSMIC NEXUS — Immersive Scroll Atlas**  
A cinematic WebGL scroll experience built with Three.js, GSAP, Lenis and modern browser APIs.

Designed as an advanced interactive showcase for:

- WebGL visual effects;
- scroll-driven storytelling;
- procedural space environments;
- futuristic interface design;
- Blender-to-web 3D workflow.

