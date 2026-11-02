# Pet RNG: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 4 ScreenGuis, 430 GUI objects, 65 unique images
- Fonts: `FredokaOne Regular`×183
- Panel colours: `#ffffff`×10 `#b5b5b5`×7 `#424242`×1 `#ff0000`×1 `#000000`×1 `#5f5f5f`×1 `#282828`×1 `#2b2b2b`×1 `#1f1f1f`×1 `#545454`×1
- Text colours: `#ffffff`×143 `#000000`×27 `#ffaa7f`×2 `#a2a2a2`×2 `#737373`×1 `#00aaff`×1
- Stroke colours: `#000000`×164 `#181818`×24; thickness `3.0 px`×88 `4.0 px`×54 `2.0 px`×26 `3.4 px`×8 `2.5 px`×3
- Corner radius: `{1.0,0}`×6 `{0.1,0}`×6 `{0.05,0}`×4 `{0.0,15}`×2 `{0.2,0}`×1
- Size mode: {'scale': 417, 'zero': 1, 'offset': 12}; TextScaled share 1.0; text sizes none
- Per 100 GUI objects: UICorner 4.4, UIStroke 43.7, UIGradient 1.2, UIAspectRatioConstraint 29.1, UIListLayout 1.2, UIGridLayout 2.6, UIPadding 5.3, UIScale 7.7, UITextSizeConstraint 0.5, ImageLabel 25.3, ImageButton 18.8, TextButton 0.0

## Map

- 43381 instances, 22494 parts (16882 MeshParts, 129 unions); core extent [2334, 841, 3471] studs (X, Y, Z; 2nd-98th percentile), everything [8455, 4835, 8753]
- Lights 172, particle emitters 93, beams/trails 21, textures/decals 13342, SurfaceAppearance 16, world GUIs 36, prompts 0, sounds 0
- Materials: `Plastic`×15445 `SmoothPlastic`×2895 `Neon`×2585 `Glass`×1363 `Metal`×188 `Slate`×8 `Sand`×7 `ForceField`×3
- Part colours: `#27462d`×3096 `#a3a2a5`×1954 `#408c29`×1719 `#f8f8f8`×1303 `#635f62`×1045 `#a58a2a`×960 `#5b5d69`×714 `#ff9494`×602 `#845e29`×595 `#0989cf`×572 `#348e40`×558 `#c4281c`×551
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.0, TimeOfDay=13:00:00, Ambient=#a91eff, OutdoorAmbient=#9b99b1, ColorShift_Top=#ad936c, EnvironmentDiffuseScale=0.2, EnvironmentSpecularScale=0.25, ExposureCompensation=0.1, GlobalShadows=True, ShadowSoftness=1.0, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **Atmosphere** `Atmosphere`: Color=#2ffcff, Decay=#e4f6ff, Density=0.263, Glare=0.45, Haze=1.0, Offset=0.3
- **Sky** `Sunny`: CelestialBodiesShown=False, StarCount=3000, SunAngularSize=21.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=0.95, Size=35.0, Threshold=2.064
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.2, Contrast=0.2, Enabled=True, Saturation=0.7, TintColor=#fff3eb
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.04, Spread=1.0
