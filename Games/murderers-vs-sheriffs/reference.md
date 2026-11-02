# Murderers vs Sheriffs (summer update): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 35 ScreenGuis, 18006 GUI objects, 358 unique images
- Fonts: `SourceSansPro Bold`×3973 `SourceSansPro Regular`×2000 `Builder Sans Bold`×118 `GothamSSm Medium`×109 `FredokaOne Regular`×36 `ComicNeueAngular Regular`×31
- Panel colours: `#ffffff`×1219 `#000000`×552 `#393939`×433 `#00d5ff`×206 `#111111`×158 `#1e1e1e`×141 `#202020`×105 `#1a1a1a`×96 `#6a6a6a`×78 `#444444`×75
- Text colours: `#ffffff`×4564 `#1b2a35`×498 `#d5d5d5`×369 `#000000`×280 `#3bff00`×97 `#ff0000`×90
- Stroke colours: `#000000`×356 `#1b2328`×31 `#2b1e18`×31 `#3b3b3b`×28 `#2d2d2d`×28 `#232323`×22; thickness `1.0 px`×228 `2.0 px`×182 `3.0 px`×161 `4.0 px`×33 `5.0 px`×5
- Corner radius: `{0.0,8}`×137 `{1.0,0}`×66 `{0.0,12}`×63 `{0.0,6}`×50 `{0.0,3}`×27 `{0.0,9}`×20
- Size mode: {'scale': 12579, 'offset': 696, 'mixed': 4703, 'zero': 28}; TextScaled share 0.71; text sizes `14`×821 `18`×281 `24`×272 `32`×102 `28`×102 `36`×63
- Per 100 GUI objects: UICorner 2.1, UIStroke 3.4, UIGradient 1.7, UIAspectRatioConstraint 2.8, UIListLayout 4.5, UIGridLayout 1.0, UIPadding 3.2, UIScale 0.1, UITextSizeConstraint 0.0, ImageLabel 23.8, ImageButton 0.7, TextButton 7.3

## Map

- 9501 instances, 5680 parts (2206 MeshParts, 0 unions); core extent [317, 106, 258] studs (X, Y, Z; 2nd-98th percentile), everything [39202, 544, 42415]
- Lights 6, particle emitters 12, beams/trails 13, textures/decals 34, SurfaceAppearance 8, world GUIs 40, prompts 13, sounds 2
- Materials: `Wood`×1128 `Metal`×994 `Marble`×872 `Fabric`×429 `SmoothPlastic`×372 `Plastic`×297 `Granite`×290 `Concrete`×249 `Sand`×242 `Grass`×172
- Part colours: `#b3b0af`×616 `#cfcfcf`×329 `#595959`×291 `#909090`×226 `#a09fa2`×225 `#c43c3c`×221 `#b4d2e4`×212 `#ffc67f`×192 `#d6d5d9`×172 `#b4a39e`×141 `#a3a2a5`×116 `#262d35`×112
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Voxel, Brightness=3.133, TimeOfDay=14:00:00, Ambient=#9d9d9d, OutdoorAmbient=#9d9d9d, ColorShift_Top=#000000, EnvironmentDiffuseScale=0.0, EnvironmentSpecularScale=0.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.02, FogEnd=1000000000.0, FogColor=#000000, GeographicLatitude=41.733
- **BloomEffect** `Bloom`: Enabled=True, Intensity=0.0, Size=24.0, Threshold=0.95
- **ColorGradingEffect** `ColorGrading`: Enabled=True
- **BlurEffect** `MenuBlur`: Enabled=False, Size=14.0
- **BlurEffect** `NewItemBlur`: Enabled=False, Size=8.0
- **BlurEffect** `PurchasePendingBlur`: Enabled=True, Size=0.0
