# COSMIC NEXUS — Immersive Scroll Atlas V9 Dark Full

Esta versión corrige la V8 con dos objetivos:

1. **Bajar el brillo** sin apagar el espacio ni las estrellas.
2. **Restaurar los efectos anteriores** mediante un FX Rack expandido y un Atlas completo de efectos, sin volver a una interfaz de tarjetas pesadas.

## Cómo correr

```powershell
cd .\cosmic_nexus_scroll_atlas_v9_dark_full
py -m http.server 5500
```

Abrir:

```text
http://localhost:5500
```

## Qué cambió en V9

- Exposición reducida.
- Bloom ajustado a modo oscuro.
- Luces principales suavizadas.
- Lensflare reducido.
- Estrellas más visibles pero menos quemadas.
- Humo/nebulosa más oscuro.
- Shader del núcleo menos sobreexpuesto.
- Nuevo control **Glow** arriba a la derecha.
- Nuevo botón **Dark**.
- Nuevo botón **Soft Bloom**.
- Nuevo botón **Max FX**.
- Nuevo botón **Reset FX**.
- FX Rack expandido con toggles para estrellas, humo, portal, rings, arcs, asteroides, grid, labels, HUD, radar, cursor y lensflare.
- Nueva sección **Atlas completo de efectos** con 60 efectos enumerados.

## Assets opcionales

Para probar Blender:

```text
assets/models/model.glb
```

Luego pulsa **Load GLB**.


## V10 Kinetic Title

El título ya no queda estático: se fragmenta, se desplaza, se reduce y se convierte en un rótulo dinámico por capítulos conectado al progreso del scroll.

## V11 Mission Mode

Parche agregado sobre V10:

- Intro portal cinematogr�fica.
- Cap�tulos narrativos por scroll.
- Black Hole Gate con disco de acreci�n y t�nel.
- Scanner interactivo del n�cleo.
- Audio reactivo al scroll.
- Mapa gal�ctico de navegaci�n.
- Modo misi�n con objetivos.
- Secuencia final de lanzamiento.

Atajos:

- `M`: abrir mapa gal�ctico.
- `S`: activar scanner.
- `P`: activar lanzamiento.
