# Street Life: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 46 ScreenGuis, 759 GUI objects, 31 unique images
- Fonts: `Oswald Bold`×335 `SourceSansPro Regular`×54 `font asset 12187370747 Bold`×35 `DenkOne Bold`×32 `Inconsolata Bold`×12 `Oswald Regular`×10
- Panel colours: `#323232`×71 `#ffffff`×45 `#000000`×33 `#2d2d2d`×24 `#00ff00`×21 `#646464`×21 `#00aa00`×18 `#00c800`×10 `#757575`×10 `#ff0004`×9
- Text colours: `#ffffff`×338 `#000000`×65 `#ff0004`×29 `#00ff00`×18 `#00aa00`×11 `#ff0000`×10
- Stroke colours: `#000000`×407 `#ffffff`×91 `#969696`×16 `#00ff00`×10 `#646464`×8 `#02d1ff`×7; thickness `2.0 px`×313 `1.0 px`×193 `1.5 px`×28 `3.0 px`×26 `8.0 px`×1
- Corner radius: `{0.0,8}`×115 `{0.3,0}`×46 `{0.0,15}`×35 `{0.2,0}`×30 `{0.1,0}`×30 `{0.025,8}`×22
- Size mode: {'scale': 756, 'offset': 3}; TextScaled share 0.96; text sizes `1`×16 `14`×3
- Per 100 GUI objects: UICorner 45.3, UIStroke 74.0, UIGradient 0.3, UIAspectRatioConstraint 0.3, UIListLayout 2.2, UIGridLayout 0.7, UIPadding 0.5, UIScale 0.1, UITextSizeConstraint 13.4, ImageLabel 5.7, ImageButton 2.9, TextButton 27.3

## Map

- 198655 instances, 121885 parts (8958 MeshParts, 5300 unions); core extent [1257, 508, 2040] studs (X, Y, Z; 2nd-98th percentile), everything [1666, 643, 2199]
- Lights 1830, particle emitters 232, beams/trails 28, textures/decals 11300, SurfaceAppearance 699, world GUIs 899, prompts 842, sounds 4220
- Materials: `Plastic`×40711 `Metal`×22276 `SmoothPlastic`×22272 `Neon`×9014 `Concrete`×8427 `Wood`×4830 `Brick`×3503 `DiamondPlate`×1879 `WoodPlanks`×1869 `Grass`×1687
- Part colours: `#a3a2a5`×14032 `#111111`×13885 `#635f62`×7811 `#ffffff`×7591 `#1b2a35`×6801 `#000000`×6637 `#f8f8f8`×6166 `#ff0000`×5580 `#694028`×2526 `#7c5c46`×2224 `#cacbd1`×2186 `#dfdfde`×2028
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=1.0, TimeOfDay=00:00:00, Ambient=#303030, OutdoorAmbient=#505050, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.18, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **Atmosphere** `Atmosphere`: Color=#c8aa6c, Decay=#5c3c0e, Density=0.368, Glare=0.0, Haze=0.0, Offset=0.662
- **BlurEffect** `IntroBlur`: Enabled=False, Size=0.0
- **ColorCorrectionEffect** `GunHSCC`: Brightness=-0.01, Contrast=0.1, Enabled=False, Saturation=-0.1, TintColor=#e2e2e2
- **BlurEffect** `GunHSBLUR`: Enabled=False, Size=0.0
- **BlurEffect** `EffectBLUR`: Enabled=False, Size=0.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=True, FarIntensity=0.093, FocusDistance=0.0, InFocusRadius=21.785, NearIntensity=0.75
- **ColorCorrectionEffect** `Dead`: Brightness=0.0, Contrast=1.0, Enabled=False, Saturation=0.9, TintColor=#212121
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **BloomEffect** `Bloom`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=2.0
- **Sky** `Cloudy Sky`: CelestialBodiesShown=False, StarCount=3000, SunAngularSize=0.0
