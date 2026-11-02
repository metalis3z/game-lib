# Smash Egg For Animals: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 19 ScreenGuis, 447 GUI objects, 18 unique images
- Fonts: `Montserrat Heavy`×79 `RobotoMono Regular`×41 `SourceSansPro Regular`×31 `SourceSansPro Bold`×16 `ComicNeueAngular Regular`×11 `LegacyArial Regular`×7
- Panel colours: `#ffffff`×74 `#000000`×22 `#c81e28`×16 `#ffc832`×5 `#2a2a2a`×4 `#050508`×4 `#ff8214`×4 `#5a3c1e`×4 `#fffac8`×3 `#73c7ff`×3
- Text colours: `#ffffff`×64 `#cdcdcd`×24 `#1b2a35`×15 `#bebebe`×12 `#6e6e6e`×12 `#d4d4d4`×12
- Stroke colours: `#000000`×130 `#282f39`×13 `#ffffff`×10 `#161a21`×2 `#0a0a0c`×1 `#00a2ff`×1; thickness `3.0 px`×51 `2.0 px`×34 `2.5 px`×28 `1.5 px`×20 `3.5 px`×12
- Corner radius: `{0.4,0}`×4 `{0.28,0}`×3 `{0.0,30}`×2 `{0.045,0}`×1 `{0.22,0}`×1 `{0.5,0}`×1
- Size mode: {'offset': 99, 'mixed': 91, 'scale': 255, 'zero': 2}; TextScaled share 0.79; text sizes `8`×16 `11`×12 `25`×2 `23`×2 `17`×2 `22`×1
- Per 100 GUI objects: UICorner 3.4, UIStroke 35.3, UIGradient 15.4, UIAspectRatioConstraint 1.3, UIListLayout 1.6, UIGridLayout 0.4, UIPadding 3.4, UIScale 2.0, UITextSizeConstraint 0.4, ImageLabel 11.2, ImageButton 0.7, TextButton 5.6

## Map

- 66979 instances, 43586 parts (598 MeshParts, 0 unions); core extent [4662, 468, 4287] studs (X, Y, Z; 2nd-98th percentile), everything [5760, 50906, 4924]
- Lights 401, particle emitters 820, beams/trails 125, textures/decals 979, SurfaceAppearance 125, world GUIs 184, prompts 2, sounds 1
- Materials: `Plastic`×37707 `Neon`×5192 `Glass`×177 `Basalt`×132 `Metal`×109 `Slate`×104 `Wood`×82 `SmoothPlastic`×51 `Grass`×24 `WoodPlanks`×6
- Part colours: `#3c1808`×1554 `#ffa01e`×1139 `#242630`×970 `#fffafa`×896 `#5affe1`×848 `#eee6cc`×671 `#5fb946`×581 `#ffffff`×571 `#3c8730`×548 `#cec2a0`×508 `#a3a2a5`×461 `#40a046`×455
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.7, TimeOfDay=14:36:00, Ambient=#646473, OutdoorAmbient=#878796, ColorShift_Top=#ffeccd, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=0.8, ExposureCompensation=0.05, GlobalShadows=True, ShadowSoftness=0.12, FogEnd=6000.0, FogColor=#bed7f5, GeographicLatitude=23.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.07, Spread=0.7
- **BloomEffect** `Bloom`: Enabled=True, Intensity=0.45, Size=30.0, Threshold=2.2
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.02, Contrast=0.1, Enabled=True, Saturation=0.06, TintColor=#fffcf8
- **Sky** `DaySky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=14.0
