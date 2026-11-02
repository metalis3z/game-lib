# Scooter Obby: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 15 ScreenGuis, 1696 GUI objects, 107 unique images
- Fonts: `FredokaOne Regular`×292 `SourceSansPro Regular`×134 `GothamSSm Bold`×22 `LegacyArial Regular`×5 `GothamSSm Heavy`×4 `FredokaOne Bold`×2
- Panel colours: `#ffffff`×181 `#36af23`×37 `#4fff34`×37 `#000000`×34 `#9d9d00`×23 `#ffff00`×23 `#ff3333`×13 `#3fbc00`×13 `#55ff00`×13 `#912121`×12
- Text colours: `#ffffff`×288 `#000000`×132 `#ffda0b`×5 `#9d00ff`×5 `#1b2a35`×5 `#a2a2a2`×4
- Stroke colours: `#000000`×118 `#36af23`×42 `#ffffff`×42 `#00aaff`×29 `#39ab00`×28 `#232323`×25; thickness `2.0 px`×215 `3.0 px`×91 `1.0 px`×61 `3.5 px`×48 `1.75 px`×44
- Corner radius: `{0.0,8}`×301 `{0.02,0}`×62 `{0.05,0}`×60 `{0.2,0}`×53 `{555.0,0}`×47 `{0.1,0}`×32
- Size mode: {'scale': 1663, 'offset': 31, 'zero': 1, 'mixed': 1}; TextScaled share 0.7; text sizes `14`×131 `8`×5 `44`×1 `39`×1 `17`×1
- Per 100 GUI objects: UICorner 37.0, UIStroke 30.6, UIGradient 15.9, UIAspectRatioConstraint 16.3, UIListLayout 1.2, UIGridLayout 0.2, UIPadding 0.4, UIScale 0.0, UITextSizeConstraint 0.2, ImageLabel 18.2, ImageButton 1.2, TextButton 8.2

## Map

- 20673 instances, 1309 parts (82 MeshParts, 28 unions); core extent [1291, 229, 20510] studs (X, Y, Z; 2nd-98th percentile), everything [1425, 305, 20583]
- Lights 4, particle emitters 420, beams/trails 3, textures/decals 937, SurfaceAppearance 3, world GUIs 4489, prompts 0, sounds 1
- Materials: `SmoothPlastic`×872 `Plastic`×313 `Neon`×53 `Concrete`×37 `Metal`×30 `DiamondPlate`×4
- Part colours: `#a3a2a5`×181 `#c1b34c`×173 `#635f62`×142 `#48a240`×124 `#c55252`×121 `#c57953`×116 `#428caf`×113 `#7a5da3`×98 `#7f7a7e`×59 `#0c0c0c`×24 `#a54a4a`×23 `#111111`×18
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Voxel, Brightness=1.5, TimeOfDay=14:47:20, Ambient=#b883ec, OutdoorAmbient=#dadada, ColorShift_Top=#ffffff, EnvironmentDiffuseScale=0.2, EnvironmentSpecularScale=0.5, ExposureCompensation=0.0, GlobalShadows=False, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=3.0, Size=24.0, Threshold=2.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
- **ColorCorrectionEffect** `Red`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **BloomEffect** `NukeBloom`: Enabled=True, Intensity=0.0, Size=0.0, Threshold=5.0
- **Atmosphere** `Atmosphere`: Color=#87dbff, Decay=#cfcfcf, Density=0.34, Glare=0.0, Haze=0.0, Offset=0.0
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.2, Contrast=0.3, Enabled=True, Saturation=0.3, TintColor=#ffffff
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.013, Spread=0.352
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=0, SunAngularSize=5.0
