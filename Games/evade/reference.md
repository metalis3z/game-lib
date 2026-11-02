# "Evade" (brainrot game): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 40 ScreenGuis, 2138 GUI objects, 209 unique images
- Fonts: `GothamSSm ExtraBold`×391 `SourceSansPro Bold`×192 `GothamSSm Bold`×131 `FredokaOne Regular`×97 `GothamSSm Heavy`×73 `HighwayGothic Bold`×16
- Panel colours: `#000000`×93 `#519e56`×30 `#ffffff`×20 `#ffff00`×14 `#363230`×12 `#55707f`×11 `#f0c630`×9 `#334249`×7 `#4f0d0d`×7 `#e94242`×7
- Text colours: `#ffffff`×659 `#9c9c9c`×54 `#caffc9`×54 `#000000`×15 `#d6d6d6`×13 `#fff700`×10
- Stroke colours: `#000000`×884 `#ffffff`×74 `#101d11`×10 `#ffe0e0`×9 `#ce1111`×9 `#004107`×7; thickness `3.0 px`×244 `3.74 px`×159 `1.87 px`×75 `3.83 px`×65 `2.0 px`×56
- Corner radius: `{0.25,0}`×12 `{0.1,0}`×7 `{0.0,8}`×3 `{0.0,50}`×1
- Size mode: {'scale': 2116, 'offset': 9, 'mixed': 13}; TextScaled share 1.0; text sizes `14`×3 `50`×1
- Per 100 GUI objects: UICorner 1.1, UIStroke 48.7, UIGradient 15.4, UIAspectRatioConstraint 6.0, UIListLayout 7.3, UIGridLayout 0.3, UIPadding 9.2, UIScale 0.0, UITextSizeConstraint 1.9, ImageLabel 21.6, ImageButton 8.2, TextButton 0.2

## Map

- 17368 instances, 3324 parts (801 MeshParts, 0 unions); core extent [495, 135256, 475] studs (X, Y, Z; 2nd-98th percentile), everything [633, 135268, 597]
- Lights 34, particle emitters 903, beams/trails 76, textures/decals 5, SurfaceAppearance 4, world GUIs 162, prompts 183, sounds 42
- Materials: `Plastic`×1888 `SmoothPlastic`×1000 `Neon`×433 `Glacier`×3
- Part colours: `#a3a2a5`×395 `#40424a`×368 `#ff0000`×197 `#1b2a35`×163 `#0f1226`×141 `#27d1c3`×141 `#c8ce59`×141 `#e15ada`×141 `#0d69ac`×130 `#635f62`×128 `#454750`×114 `#f8f8f8`×101
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.0, TimeOfDay=14:00:00, Ambient=#f1f1f1, OutdoorAmbient=#d4d4d4, ColorShift_Top=#e2e2e2, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=0.5, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=5.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.071, Spread=0.576
- **ColorCorrectionEffect** `ColorCCorrection`: Brightness=0.1, Contrast=0.1, Enabled=True, Saturation=-0.2, TintColor=#ffe9e9
- **Atmosphere** `AtmosphereMolten`: Color=#c7c7c7, Decay=#6a707d, Density=0.2, Glare=0.0, Haze=0.0, Offset=0.25
- **Sky** `SkyMolten`: CelestialBodiesShown=False, StarCount=0, SunAngularSize=21.0
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.2, Glare=0.0, Haze=0.0, Offset=0.25
- **Sky** `Cartoon`: CelestialBodiesShown=False, StarCount=0, SunAngularSize=21.0
