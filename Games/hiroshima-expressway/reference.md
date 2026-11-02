# Hiroshima Expressway: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 3 ScreenGuis, 42 GUI objects, 6 unique images
- Fonts: `SourceSansPro Regular`×7 `GothamSSm Bold`×7
- Panel colours: `#ffffff`×7 `#323232`×4 `#000000`×2 `#868686`×2 `#ff7f00`×1 `#c80000`×1
- Text colours: `#ffffff`×10 `#000000`×4
- Stroke colours: none; thickness none
- Corner radius: `{0.0,8}`×7
- Size mode: {'offset': 5, 'scale': 20, 'mixed': 17}; TextScaled share 0.29; text sizes `14`×4 `48`×2 `25`×2 `20`×1 `16`×1
- Per 100 GUI objects: UICorner 16.7, UIStroke 0.0, UIGradient 16.7, UIAspectRatioConstraint 9.5, UIListLayout 0.0, UIGridLayout 0.0, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 7.1, ImageLabel 14.3, ImageButton 2.4, TextButton 16.7

## Map

- 345740 instances, 327955 parts (5235 MeshParts, 0 unions); core extent [8932, 134, 11768] studs (X, Y, Z; 2nd-98th percentile), everything [16442, 2088, 17443]
- Lights 3390, particle emitters 0, beams/trails 1819, textures/decals 26, SurfaceAppearance 1890, world GUIs 3328, prompts 0, sounds 7
- Materials: `Ground`×258491 `Concrete`×64190 `Plastic`×5204 `Neon`×37 `ForceField`×24 `Fabric`×6 `Glass`×2 `Metal`×1
- Part colours: `#a3a2a5`×327882 `#404040`×41 `#ffffff`×10 `#ffa220`×8 `#002060`×8 `#635f62`×4 `#a50000`×2
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=0.1, TimeOfDay=12:00:00, Ambient=#4f5261, OutdoorAmbient=#4f5261, ColorShift_Top=#353741, EnvironmentDiffuseScale=0.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=False, ShadowSoftness=0.0, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=25.0
- **Sky** `Zaibatsu_Night`: CelestialBodiesShown=True, StarCount=0, SunAngularSize=7.0
- **Atmosphere** `Atmosphere`: Color=#ffffff, Decay=#5a6571, Density=0.0, Glare=10.0, Haze=1.0, Offset=0.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=555.0, Threshold=1.9
