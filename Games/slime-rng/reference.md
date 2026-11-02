# Slime RNG: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 1 ScreenGuis, 20 GUI objects, 4 unique images
- Fonts: `GothamSSm ExtraBold`×5 `BuilderSans ExtraBold`×4 `Builder Sans ExtraBold`×1
- Panel colours: none
- Text colours: `#ffffff`×8 `#000000`×2
- Stroke colours: `#000000`×8; thickness `0.08 scaled`×5 `2.0 px`×2 `0.15 scaled`×1
- Corner radius: none
- Size mode: {'scale': 20}; TextScaled share 1.0; text sizes none
- Per 100 GUI objects: UICorner 0.0, UIStroke 40.0, UIGradient 5.0, UIAspectRatioConstraint 5.0, UIListLayout 15.0, UIGridLayout 0.0, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 25.0, ImageLabel 20.0, ImageButton 0.0, TextButton 0.0

## Map

- 1270 instances, 467 parts (295 MeshParts, 0 unions); core extent [5618, 38, 192] studs (X, Y, Z; 2nd-98th percentile), everything [6094, 200, 367]
- Lights 4, particle emitters 0, beams/trails 3, textures/decals 1, SurfaceAppearance 0, world GUIs 0, prompts 0, sounds 0
- Materials: `Basalt`×95 `Plastic`×88 `Neon`×66 `Asphalt`×54 `Grass`×53 `Sandstone`×27 `Wood`×24 `Mud`×20 `Slate`×17 `Ground`×9
- Part colours: `#a3a2a5`×88 `#73430d`×65 `#1b2238`×50 `#a2ff5a`×47 `#579d3e`×32 `#734131`×19 `#5c9d48`×19 `#656466`×18 `#786844`×13 `#46311f`×9 `#2b871d`×9 `#71b33f`×8
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.5, TimeOfDay=14:00:00, Ambient=#c8a0e1, OutdoorAmbient=#7d6496, ColorShift_Top=#d7be87, EnvironmentDiffuseScale=0.4, EnvironmentSpecularScale=0.5, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=21.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=21.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.05, Contrast=0.1, Enabled=True, Saturation=0.15, TintColor=#ffffff
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.3, Glare=0.0, Haze=0.0, Offset=0.25
