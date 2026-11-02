# Animal Hospital (modded): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 43 ScreenGuis, 1051 GUI objects, 91 unique images
- Fonts: `GothamSSm ExtraBold`×85 `Noto Serif SC Bold`×78 `SourceSansPro Regular`×46 `Noto Serif SC Regular`×35 `FredokaOne Regular`×26 `ComicNeueAngular Bold`×25
- Panel colours: `#ffffff`×77 `#000000`×74 `#0e8800`×13 `#3c4d93`×11 `#0a0b10`×8 `#00b42a`×8 `#18181e`×8 `#cf1a26`×7 `#005288`×5 `#7c1100`×5
- Text colours: `#ffffff`×302 `#000000`×73 `#ff2600`×26 `#1b2a35`×16 `#ffc637`×9 `#00f900`×8
- Stroke colours: `#000000`×290 `#ffffff`×107 `#121212`×29 `#052700`×19 `#4e5263`×8 `#737684`×8; thickness `2.0 px`×210 `1.0 px`×148 `1.5 px`×31 `0.06 scaled`×29 `1.9 px`×29
- Corner radius: `{0.0,5}`×43 `{0.0,8}`×28 `{0.15,0}`×18 `{0.0,7}`×9 `{0.5,0}`×7 `{0.0,6}`×6
- Size mode: {'scale': 999, 'mixed': 29, 'offset': 23}; TextScaled share 0.9; text sizes `14`×35 `8`×8 `20`×4 `28`×1 `45`×1
- Per 100 GUI objects: UICorner 11.9, UIStroke 51.0, UIGradient 22.6, UIAspectRatioConstraint 21.1, UIListLayout 3.5, UIGridLayout 0.3, UIPadding 12.7, UIScale 4.2, UITextSizeConstraint 5.7, ImageLabel 24.8, ImageButton 6.7, TextButton 7.9

## Map

- 11964 instances, 4261 parts (366 MeshParts, 45 unions); core extent [377, 54, 373] studs (X, Y, Z; 2nd-98th percentile), everything [1000, 89, 1000]
- Lights 61, particle emitters 25, beams/trails 26, textures/decals 243, SurfaceAppearance 38, world GUIs 236, prompts 130, sounds 232
- Materials: `SmoothPlastic`×1583 `Plastic`×967 `Metal`×623 `Concrete`×488 `Brick`×142 `Wood`×113 `Neon`×101 `Glass`×58 `Fabric`×39 `Material2306`×31
- Part colours: `#a3a2a5`×720 `#635f62`×420 `#f8f8f8`×379 `#1b2a35`×355 `#d1d1c1`×261 `#f2f3f3`×196 `#5b5d69`×187 `#cdcdcd`×180 `#9fa1ac`×133 `#111111`×102 `#95a4b3`×96 `#80bbdb`×62
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=3.0, TimeOfDay=10:36:00, Ambient=#91979d, OutdoorAmbient=#000000, ColorShift_Top=#616566, EnvironmentDiffuseScale=0.25, EnvironmentSpecularScale=0.25, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **Atmosphere** `Atmosphere`: Color=#b4b4b4, Decay=#5a6473, Density=0.4, Glare=10.0, Haze=0.01, Offset=0.9
- **Sky** `DreamyOcean`: CelestialBodiesShown=True, StarCount=1000, SunAngularSize=21.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **BlurEffect** `Blur`: Enabled=True, Size=1.0
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.3, Enabled=True, Saturation=1.0, TintColor=#f3f2ff
- **DepthOfFieldEffect** `DepthOfField`: Enabled=True, FarIntensity=0.025, FocusDistance=0.05, InFocusRadius=50.0, NearIntensity=0.044
- **SunRaysEffect** `SunRays`: Enabled=False, Intensity=0.25, Spread=1.0
