# Catalogue Avatar Creator: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 35 ScreenGuis, 2489 GUI objects, 68 unique images
- Fonts: `SourceSansPro Regular`×336 `Builder Sans SemiBold`×212 `Builder Sans Regular`×158 `Builder Sans Medium`×132 `Builder Sans Bold`×101 `LegacyArial Regular`×38
- Panel colours: `#212227`×121 `#2b2d33`×89 `#ffffff`×70 `#121215`×59 `#fdfdff`×52 `#6f7075`×26 `#000000`×21 `#335fff`×18 `#ff5f5c`×16 `#1d1d1f`×16
- Text colours: `#000000`×343 `#ffffff`×286 `#f7f7f8`×164 `#edeeee`×69 `#1b2a35`×40 `#f4f4f4`×30
- Stroke colours: `#46444d`×55 `#f7f5ff`×47 `#ffffff`×40 `#212227`×38 `#121215`×33 `#1dceff`×27; thickness `1.5 px`×82 `0.03 scaled`×43 `0.05 scaled`×31 `1.0 px`×22 `3.0 px`×21
- Corner radius: `{1.0,0}`×143 `{0.3,0}`×82 `{0.0,8}`×80 `{0.25,0}`×48 `{0.075,0}`×48 `{0.2,0}`×35
- Size mode: {'scale': 2302, 'mixed': 130, 'offset': 57}; TextScaled share 0.6; text sizes `14`×340 `8`×40 `22`×8 `28`×8 `21`×7 `36`×5
- Per 100 GUI objects: UICorner 25.2, UIStroke 12.1, UIGradient 1.7, UIAspectRatioConstraint 12.5, UIListLayout 7.7, UIGridLayout 0.7, UIPadding 15.7, UIScale 0.2, UITextSizeConstraint 0.0, ImageLabel 14.1, ImageButton 0.4, TextButton 17.2

## Map

- 14 instances, 5 parts (1 MeshParts, 0 unions); core extent None studs (X, Y, Z; 2nd-98th percentile), everything [2048, 29, 2048]
- Lights 0, particle emitters 0, beams/trails 0, textures/decals 1, SurfaceAppearance 1, world GUIs 0, prompts 0, sounds 0
- Materials: `Plastic`×5
- Part colours: `#a3a2a5`×3 `#518a2d`×2
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=3.0, TimeOfDay=14:30:00, Ambient=#464646, OutdoorAmbient=#464646, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.75, FocusDistance=16.0, InFocusRadius=30.0, NearIntensity=0.75
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=11.0
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.3, Glare=0.0, Haze=0.0, Offset=0.25
