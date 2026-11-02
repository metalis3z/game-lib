# SCP Tycoon: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 4 ScreenGuis, 312 GUI objects, 41 unique images
- Fonts: `SourceSansPro Regular`×70 `FredokaOne Regular`×19 `Fondamento Regular`×12 `Fondamento Bold`×8 `Arial Bold`×8 `Inconsolata Regular`×7
- Panel colours: `#000000`×35 `#ffffff`×30 `#313131`×4 `#303030`×2 `#383838`×2 `#393939`×1 `#343434`×1 `#222222`×1 `#636363`×1 `#414141`×1
- Text colours: `#ffffff`×117 `#000000`×6 `#1b2a35`×2 `#c8c8c8`×2 `#ff0000`×1
- Stroke colours: `#212121`×10 `#6f6f6f`×4 `#6f2022`×2 `#136a30`×1 `#191919`×1; thickness `5.0 px`×12 `2.0 px`×4 `7.8 px`×1 `7.0 px`×1
- Corner radius: `{0.0,25}`×12 `{0.0,8}`×8 `{0.0,15}`×2 `{0.0,33333}`×2
- Size mode: {'scale': 234, 'mixed': 9, 'zero': 5, 'offset': 64}; TextScaled share 0.68; text sizes `24`×23 `18`×8 `14`×7 `36`×2 `10`×1
- Per 100 GUI objects: UICorner 7.7, UIStroke 5.8, UIGradient 2.6, UIAspectRatioConstraint 0.0, UIListLayout 1.3, UIGridLayout 0.6, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 0.0, ImageLabel 29.8, ImageButton 0.3, TextButton 23.1

## Map

- 2802 instances, 1512 parts (77 MeshParts, 86 unions); core extent [364, 220, 8130] studs (X, Y, Z; 2nd-98th percentile), everything [604, 384, 8443]
- Lights 7, particle emitters 99, beams/trails 0, textures/decals 134, SurfaceAppearance 0, world GUIs 19, prompts 1, sounds 2
- Materials: `Wood`×964 `Plastic`×128 `Metal`×115 `Concrete`×79 `SmoothPlastic`×71 `Neon`×48 `Glass`×29 `Brick`×24 `Fabric`×16 `CorrodedMetal`×8
- Part colours: `#c7ac78`×720 `#a3a2a5`×194 `#bc9b5d`×192 `#1b2a35`×53 `#f8f8f8`×51 `#635f62`×37 `#a0844f`×24 `#6c584b`×23 `#111111`×20 `#7e683f`×20 `#5d5c5e`×18 `#555456`×16
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.0, TimeOfDay=14:00:00, Ambient=#8a8a8a, OutdoorAmbient=#808080, ColorShift_Top=#000000, EnvironmentDiffuseScale=0.0, EnvironmentSpecularScale=0.0, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=100000.0, FogColor=#c0c0c0, GeographicLatitude=41.7333
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=21.0
