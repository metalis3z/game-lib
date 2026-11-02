# Backrooms Exploration: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 5 ScreenGuis, 32 GUI objects, 7 unique images
- Fonts: `LuckiestGuy Regular`×7 `IndieFlower Regular`×3 `PressStart2P Regular`×3
- Panel colours: `#ffffff`×1 `#fcff37`×1
- Text colours: `#f9d11b`×7 `#000000`×3 `#ffffff`×3
- Stroke colours: `#602401`×7 `#000000`×5; thickness `4.0 px`×8 `3.0 px`×4
- Corner radius: `{0.0,8}`×1
- Size mode: {'offset': 24, 'scale': 8}; TextScaled share 0.0; text sizes `80`×3 `70`×2 `44`×2 `40`×1 `88`×1 `81`×1
- Per 100 GUI objects: UICorner 3.1, UIStroke 37.5, UIGradient 0.0, UIAspectRatioConstraint 0.0, UIListLayout 9.4, UIGridLayout 0.0, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 0.0, ImageLabel 43.8, ImageButton 0.0, TextButton 3.1

## Map

- 277 instances, 113 parts (1 MeshParts, 16 unions); core extent [45, 10, 43] studs (X, Y, Z; 2nd-98th percentile), everything [92, 11, 60]
- Lights 16, particle emitters 0, beams/trails 0, textures/decals 37, SurfaceAppearance 1, world GUIs 9, prompts 0, sounds 18
- Materials: `Metal`×46 `SmoothPlastic`×30 `Neon`×18 `Plastic`×8 `Fabric`×8 `WoodPlanks`×2 `Glass`×1
- Part colours: `#6c584b`×30 `#ffffff`×16 `#a3a2a5`×15 `#111111`×8 `#3a534e`×7 `#263335`×6 `#fff1ce`×5 `#858487`×4 `#b0b0b0`×4 `#1a1a1a`×4 `#c7bc90`×3 `#ffffcc`×2
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=0.0, TimeOfDay=14:30:00, Ambient=#464646, OutdoorAmbient=#464646, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=11.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.3, Glare=0.0, Haze=0.0, Offset=0.25
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.1, FocusDistance=0.05, InFocusRadius=30.0, NearIntensity=0.75
