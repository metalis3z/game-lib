# +1 Escape Kitty Keyboard: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 18 ScreenGuis, 2574 GUI objects, 99 unique images
- Fonts: `Roboto Regular`×299 `Zekton Regular`×272 `GothamSSm Bold`×170 `Roboto Light`×118 `SourceSansPro Regular`×96 `Nunito Regular`×76
- Panel colours: `#000000`×201 `#ffffff`×174 `#5e56d5`×124 `#1c1f25`×122 `#4b4b4b`×26 `#505050`×18 `#23272f`×16 `#464646`×16 `#aa4646`×16 `#cb0000`×15
- Text colours: `#ffffff`×675 `#000000`×309 `#c8c8c8`×83 `#dcdcdc`×42 `#969696`×40 `#e1e1e1`×34
- Stroke colours: `#000000`×334 `#540000`×12 `#361400`×11 `#00163a`×10 `#ffffff`×9 `#ffaaff`×7; thickness `0.06 scaled`×140 `0.04 scaled`×77 `0.03 scaled`×64 `0.05 scaled`×21 `1.0 px`×21
- Corner radius: `{0.0,4}`×274 `{0.1,0}`×117 `{0.0,6}`×80 `{0.2,0}`×54 `{0.0,8}`×36 `{0.0,5}`×22
- Size mode: {'scale': 2465, 'offset': 54, 'mixed': 55}; TextScaled share 0.73; text sizes `16`×272 `14`×37 `18`×18 `20`×6 `25`×6 `28`×5
- Per 100 GUI objects: UICorner 24.3, UIStroke 16.3, UIGradient 2.4, UIAspectRatioConstraint 19.7, UIListLayout 4.5, UIGridLayout 0.2, UIPadding 6.4, UIScale 0.2, UITextSizeConstraint 0.7, ImageLabel 11.6, ImageButton 4.3, TextButton 14.1

## Map

- 21308 instances, 17838 parts (16986 MeshParts, 6 unions); core extent [179, 92, 2265] studs (X, Y, Z; 2nd-98th percentile), everything [2255, 101055, 3694]
- Lights 1, particle emitters 2, beams/trails 18, textures/decals 15, SurfaceAppearance 0, world GUIs 65, prompts 3, sounds 21
- Materials: `Plastic`×17727 `SmoothPlastic`×42 `Neon`×24 `Sand`×16 `Mud`×10 `Ice`×9 `Concrete`×4 `Rock`×3 `Foil`×2 `Glass`×1
- Part colours: `#ffb6c1`×8683 `#ffffff`×8646 `#a3a2a5`×99 `#ff98dc`×59 `#f8f8f8`×59 `#f48ec3`×32 `#ffb000`×29 `#111111`×26 `#ffff00`×24 `#835032`×16 `#00ffff`×14 `#5b5d69`×13
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.06, TimeOfDay=14:00:00, Ambient=#7d7d7d, OutdoorAmbient=#464646, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=0.0
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.01, Spread=0.1
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=1500, SunAngularSize=5.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=0.5, Size=24.0, Threshold=2.0
- **Atmosphere** `Atmosphere`: Color=#c7c7c7, Decay=#6a707d, Density=0.252, Glare=0.0, Haze=0.0, Offset=0.245
- **BlurEffect** `MenuBlur`: Enabled=True, Size=0.0
