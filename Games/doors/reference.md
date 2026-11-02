# Doors (fully scripted): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 6 ScreenGuis, 1628 GUI objects, 146 unique images
- Fonts: `LegacyArial Regular`×268 `Oswald Regular`×242 `GothamSSm Regular`×25 `Oswald Medium`×14 `GothamSSm Heavy`×10 `GothamSSm Bold`×7
- Panel colours: `#261919`×116 `#ffdebd`×79 `#665247`×45 `#2a0c07`×44 `#013b06`×43 `#5e2a2b`×43 `#ffffff`×39 `#000000`×28 `#7c5249`×17 `#1e1815`×13
- Text colours: `#ffdebd`×143 `#ffffff`×87 `#d2ffb9`×40 `#ffc9b3`×29 `#1b2a35`×18 `#cfc7b0`×14
- Stroke colours: `#ffdebd`×153 `#ff4b2b`×44 `#d2ffb9`×43 `#ffabab`×43 `#d8e1ef`×25 `#ffffff`×23; thickness `5.0 px`×134 `3.0 px`×122 `4.0 px`×107 `2.0 px`×53 `1.7 px`×13
- Corner radius: `{1.0,0}`×316 `{0.0,8}`×166 `{0.15,0}`×75 `{0.5,0}`×47 `{0.2,0}`×37 `{0.0,3}`×26
- Size mode: {'scale': 1331, 'offset': 34, 'mixed': 261, 'zero': 2}; TextScaled share 0.92; text sizes `8`×18 `24`×11 `50`×8 `30`×4 `14`×3 `38`×2
- Per 100 GUI objects: UICorner 43.9, UIStroke 28.3, UIGradient 14.9, UIAspectRatioConstraint 1.8, UIListLayout 3.3, UIGridLayout 3.4, UIPadding 22.9, UIScale 1.2, UITextSizeConstraint 0.0, ImageLabel 39.2, ImageButton 1.7, TextButton 8.2

## Map

- 2000 instances, 980 parts (457 MeshParts, 3 unions); core extent [517, 930, 384] studs (X, Y, Z; 2nd-98th percentile), everything [1941, 1231, 673]
- Lights 59, particle emitters 28, beams/trails 4, textures/decals 85, SurfaceAppearance 0, world GUIs 26, prompts 14, sounds 77
- Materials: `Wood`×422 `Metal`×182 `Concrete`×65 `Sand`×54 `WoodPlanks`×52 `DiamondPlate`×31 `Plastic`×31 `Glass`×29 `Neon`×28 `ForceField`×19
- Part colours: `#5a4b48`×75 `#635351`×70 `#6c5a56`×46 `#4d4343`×46 `#75625e`×27 `#5f544d`×24 `#8b6c5f`×22 `#6b5a56`×22 `#ff0000`×21 `#464241`×20 `#514441`×18 `#574946`×18
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Future, Brightness=0.0, TimeOfDay=11:00:00, Ambient=#000000, OutdoorAmbient=#000000, ColorShift_Top=#000000, EnvironmentDiffuseScale=0.0, EnvironmentSpecularScale=0.0, ExposureCompensation=0.4, GlobalShadows=True, ShadowSoftness=0.61, FogEnd=100000.0, FogColor=#000000, GeographicLatitude=120.0
- **ColorCorrectionEffect** `CinematicDoor`: Brightness=-1.0, Contrast=1.0, Enabled=False, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `TempLookmanCC`: Brightness=-4.0, Contrast=3.0, Enabled=False, Saturation=-0.8, TintColor=#ffffff
- **Sky** `Sky`: CelestialBodiesShown=False, StarCount=0, SunAngularSize=21.0
