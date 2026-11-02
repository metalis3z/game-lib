# Animal Hospital (horror, modded): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 35 ScreenGuis, 833 GUI objects, 81 unique images
- Fonts: `GothamSSm ExtraBold`×74 `Noto Serif SC Bold`×63 `Noto Serif SC Regular`×35 `SourceSansPro Regular`×34 `SpecialElite Bold`×24 `GothamSSm Bold`×21
- Panel colours: `#000000`×75 `#ffffff`×43 `#3c4d93`×12 `#0e8800`×12 `#cf1a26`×8 `#00f900`×5 `#005288`×5 `#7c1100`×5 `#2e2e2f`×4 `#fffb00`×3
- Text colours: `#ffffff`×229 `#000000`×57 `#ff2600`×26 `#00f900`×10 `#1b2a35`×10 `#ffc637`×9
- Stroke colours: `#000000`×241 `#ffffff`×72 `#121212`×25 `#052700`×17 `#ff0e00`×7 `#0f2d0a`×5; thickness `2.0 px`×193 `1.0 px`×115 `0.06 scaled`×25 `1.9 px`×25 `3.0 px`×15
- Corner radius: `{0.5,0}`×7 `{0.0,5}`×7 `{0.0,8}`×6 `{1.0,0}`×4 `{0.1,0}`×3 `{0.15,0}`×3
- Size mode: {'scale': 798, 'mixed': 24, 'offset': 11}; TextScaled share 0.9; text sizes `14`×29 `8`×6 `20`×3 `45`×1
- Per 100 GUI objects: UICorner 4.4, UIStroke 47.1, UIGradient 18.4, UIAspectRatioConstraint 19.2, UIListLayout 3.0, UIGridLayout 0.4, UIPadding 14.4, UIScale 4.7, UITextSizeConstraint 6.5, ImageLabel 25.6, ImageButton 4.9, TextButton 7.4

## Map

- 7122 instances, 3831 parts (232 MeshParts, 33 unions); core extent [184, 18, 374] studs (X, Y, Z; 2nd-98th percentile), everything [1000, 67, 1000]
- Lights 59, particle emitters 20, beams/trails 4, textures/decals 189, SurfaceAppearance 4, world GUIs 220, prompts 119, sounds 226
- Materials: `SmoothPlastic`×1477 `Plastic`×875 `Metal`×494 `Concrete`×484 `Brick`×142 `Wood`×113 `Neon`×78 `Fabric`×39 `Material2306`×31 `WoodPlanks`×28
- Part colours: `#a3a2a5`×632 `#f8f8f8`×362 `#635f62`×345 `#1b2a35`×339 `#d1d1c1`×261 `#f2f3f3`×196 `#5b5d69`×176 `#cdcdcd`×167 `#9fa1ac`×132 `#95a4b3`×96 `#111111`×75 `#80bbdb`×60
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=3.0, TimeOfDay=00:00:00, Ambient=#91979d, OutdoorAmbient=#000000, ColorShift_Top=#616566, EnvironmentDiffuseScale=0.25, EnvironmentSpecularScale=0.25, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **Atmosphere** `Atmosphere`: Color=#b4b4b4, Decay=#5a6473, Density=0.4, Glare=10.0, Haze=0.01, Offset=0.9
- **Sky** `DreamyOcean`: CelestialBodiesShown=True, StarCount=1000, SunAngularSize=21.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **BlurEffect** `Blur`: Enabled=True, Size=1.0
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.3, Enabled=True, Saturation=1.0, TintColor=#f3f2ff
- **DepthOfFieldEffect** `DepthOfField`: Enabled=True, FarIntensity=0.025, FocusDistance=0.05, InFocusRadius=50.0, NearIntensity=0.044
- **SunRaysEffect** `SunRays`: Enabled=False, Intensity=0.25, Spread=1.0
