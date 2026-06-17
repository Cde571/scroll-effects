(function(){
  const root = document.documentElement;
  const body = document.body;

  function clamp01(v){ return Math.max(0, Math.min(1, v)); }
  function smoothstep(edge0, edge1, x){
    const t = clamp01((x - edge0) / Math.max(0.00001, edge1 - edge0));
    return t * t * (3 - 2 * t);
  }
  function getProgress(){
    const max = Math.max(1, document.documentElement.scrollHeight - window.innerHeight);
    return clamp01(window.scrollY / max);
  }

  function applyEarlyExit(){
    const p = getProgress();

    /* Antes estaba desapareciendo muy tarde.
       Ahora el título principal empieza a irse casi de inmediato y queda fuera
       antes de entrar visualmente al capítulo de Cámara sobre riel. */
    const split = smoothstep(0.004, 0.075, p);
    const compact = smoothstep(0.010, 0.095, p);
    const fade = 1 - smoothstep(0.020, 0.105, p);
    const gone = p > 0.125;
    const clearRail = p > 0.070;

    const mobile = window.innerWidth < 900;
    const titleX = mobile ? 0 : -compact * 132;
    const titleY = mobile ? -compact * 44 : -compact * 265;
    const titleScale = mobile ? 1 - compact * 0.30 : 1 - compact * 0.72;
    const titleRotate = mobile ? 0 : -compact * 3.8;
    const titleBlur = Math.max(0, (compact - 0.40) * 8.5);

    root.style.setProperty('--title-x', `${titleX.toFixed(2)}px`);
    root.style.setProperty('--title-y', `${titleY.toFixed(2)}px`);
    root.style.setProperty('--title-scale', Math.max(0.20, titleScale).toFixed(3));
    root.style.setProperty('--title-rotate', `${titleRotate.toFixed(2)}deg`);
    root.style.setProperty('--title-opacity', Math.max(0, fade).toFixed(3));
    root.style.setProperty('--title-blur', `${titleBlur.toFixed(2)}px`);
    root.style.setProperty('--title-split', split.toFixed(3));
    root.style.setProperty('--title-letter', `${(-0.07 + split * 0.070).toFixed(3)}em`);
    root.style.setProperty('--title-clear-cut', compact.toFixed(3));

    /* El dock de capítulo aparece después, cuando el hero ya salió.
       Así no queda "Cosmic Nexus" encima de la cámara sobre el riel. */
    const dockOpacity = smoothstep(0.145, 0.230, p) * (1 - smoothstep(0.955, 1.0, p) * 0.35);
    const dockY = 12 - dockOpacity * 12;
    const dockRotate = Math.sin(p * Math.PI * 2.0) * 0.35;
    root.style.setProperty('--chapter-title-opacity', dockOpacity.toFixed(3));
    root.style.setProperty('--chapter-title-y', `${dockY.toFixed(2)}px`);
    root.style.setProperty('--chapter-title-rotate', `${dockRotate.toFixed(2)}deg`);

    body.classList.toggle('title-clear-camera-rail', clearRail);
    body.classList.toggle('title-hero-gone', gone);
    body.classList.toggle('title-compact', p > 0.08);

    requestAnimationFrame(applyEarlyExit);
  }

  window.addEventListener('DOMContentLoaded', () => {
    /* No toca el canvas ni los efectos, solo la cinética del título. */
    applyEarlyExit();
  });
})();
