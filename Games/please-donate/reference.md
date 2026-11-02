# PLS DONATE (fully scripted): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 4 ScreenGuis, 409 GUI objects, 24 unique images
- Fonts: `GothamSSm Heavy`×75 `GothamSSm Bold`×40 `LegacyArial Regular`×23 `SourceSansPro Regular`×9 `GothamSSm Medium`×9 `GothamSSm ExtraBold`×6
- Panel colours: `#ffffff`×72 `#000000`×10 `#fdfbff`×6 `#f800a1`×5 `#e2e2e2`×5 `#4586ff`×4 `#ff4fd9`×2 `#06a8ff`×2 `#0d0d0d`×2 `#116f00`×2
- Text colours: `#ffffff`×80 `#000000`×53 `#1b2a35`×6 `#323232`×3 `#909090`×3 `#ff2684`×2
- Stroke colours: `#000000`×64 `#ffffff`×10 `#c8c8c8`×3 `#0099ff`×3 `#ff2386`×1 `#06a8ff`×1; thickness `1.0 px`×32 `2.5 px`×20 `2.0 px`×9 `5.0 px`×8 `15.0 px`×6
- Corner radius: `{0.25,0}`×29 `{1.0,0}`×27 `{0.04,0}`×12 `{0.45,0}`×10 `{0.35,0}`×8 `{0.2,0}`×8
- Size mode: {'mixed': 33, 'scale': 323, 'zero': 23, 'offset': 30}; TextScaled share 0.59; text sizes `14`×26 `12`×11 `8`×6 `65`×6 `25`×4 `16`×3
- Per 100 GUI objects: UICorner 30.6, UIStroke 20.3, UIGradient 3.9, UIAspectRatioConstraint 19.6, UIListLayout 20.8, UIGridLayout 0.5, UIPadding 26.2, UIScale 1.7, UITextSizeConstraint 0.0, ImageLabel 19.1, ImageButton 5.9, TextButton 10.0

## Map

- 2941 instances, 1657 parts (1201 MeshParts, 4 unions); core extent [1431, 332, 35711] studs (X, Y, Z; 2nd-98th percentile), everything [1804, 378, 38428]
- Lights 78, particle emitters 16, beams/trails 64, textures/decals 22, SurfaceAppearance 0, world GUIs 54, prompts 14, sounds 17
- Materials: `SmoothPlastic`×713 `Plastic`×699 `Neon`×150 `Metal`×53 `Slate`×13 `DiamondPlate`×8 `WoodPlanks`×6 `Glass`×6 `Wood`×6 `Concrete`×2
- Part colours: `#a3a2a5`×199 `#1b2a35`×174 `#5b5d69`×124 `#71655b`×62 `#3c9352`×62 `#44a55d`×62 `#37845a`×52 `#2e485b`×50 `#483958`×50 `#393a59`×45 `#484a53`×36 `#515569`×34
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Future, Brightness=2.66, TimeOfDay=10:00:00, Ambient=#e2b0e1, OutdoorAmbient=#301c47, ColorShift_Top=#ffe3b4, EnvironmentDiffuseScale=0.688, EnvironmentSpecularScale=0.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=1000000.0, FogColor=#90e4f8, GeographicLatitude=0.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=45.0, Threshold=3.5
- **BlurEffect** `Blur`: Enabled=True, Size=0.0
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.05, Contrast=0.2, Enabled=True, Saturation=0.25, TintColor=#ffffff
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **Atmosphere** `Atmosphere`: Color=#ffffff, Decay=#ffffff, Density=0.0, Glare=0.0, Haze=0.0, Offset=0.0
- **Sky** `Sky`: CelestialBodiesShown=False, StarCount=3000, SunAngularSize=21.0
