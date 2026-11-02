# Driving Empire: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 7 ScreenGuis, 1347 GUI objects, 79 unique images
- Fonts: `GothamSSm Bold`×146 `SourceSansPro Regular`×111 `SourceSansPro SemiBold`×75 `GothamSSm Regular`×55 `SourceSansPro Bold`×41 `GothamSSm Heavy`×31
- Panel colours: `#aa0000`×18 `#aaaaaa`×3 `#969796`×3 `#2a2a2a`×2 `#ffffff`×1 `#000000`×1 `#303030`×1 `#505050`×1 `#343434`×1 `#2b2b2b`×1
- Text colours: `#ffffff`×395 `#ffaa00`×45 `#d1d1d1`×10 `#00bf00`×8 `#ffc903`×8 `#fcfcfc`×5
- Stroke colours: `#323232`×1; thickness `4.0 px`×1
- Corner radius: `{0.4,0}`×1 `{0.0,12}`×1 `{1.0,0}`×1
- Size mode: {'scale': 1229, 'mixed': 33, 'offset': 84, 'zero': 1}; TextScaled share 0.57; text sizes `24`×115 `22`×84 `48`×14 `40`×3 `60`×2 `16`×1
- Per 100 GUI objects: UICorner 0.2, UIStroke 0.1, UIGradient 0.5, UIAspectRatioConstraint 3.6, UIListLayout 1.9, UIGridLayout 1.2, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 0.0, ImageLabel 26.8, ImageButton 8.8, TextButton 0.1

## Map

- 46699 instances, 21814 parts (2895 MeshParts, 400 unions); core extent [3242, 167, 4444] studs (X, Y, Z; 2nd-98th percentile), everything [11798, 487, 10330]
- Lights 665, particle emitters 137, beams/trails 43, textures/decals 3545, SurfaceAppearance 13, world GUIs 153, prompts 0, sounds 418
- Materials: `Concrete`×5958 `SmoothPlastic`×5787 `Metal`×3013 `Grass`×1760 `Plastic`×1587 `Neon`×1085 `Wood`×583 `Marble`×449 `Brick`×296 `Sand`×277
- Part colours: `#a3a2a5`×3684 `#f8f8f8`×1985 `#ffb000`×1555 `#7c9c6b`×1471 `#dfdfde`×1080 `#cdcdcd`×1076 `#111111`×1036 `#635f62`×879 `#464646`×387 `#76797c`×368 `#9fa1ac`×304 `#323232`×268
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Compatibility, Brightness=2.7, TimeOfDay=13:15:52, Ambient=#000000, OutdoorAmbient=#6c6c6b, ColorShift_Top=#ffe2a7, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=0.5, ExposureCompensation=0.45, GlobalShadows=True, ShadowSoftness=0.05, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=40.0
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.009, Contrast=0.1, Enabled=True, Saturation=0.05, TintColor=#ffffff
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=44444.0, Threshold=3.67
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.017, Spread=0.19
- **Atmosphere** `Atmosphere`: Color=#ffffff, Decay=#000000, Density=0.122, Glare=0.0, Haze=2.07, Offset=0.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=5000, SunAngularSize=3.5
