# The Rake (kill test): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 19 ScreenGuis, 70 GUI objects, 5 unique images
- Fonts: none
- Panel colours: `#000000`×23 `#323232`×2 `#959595`×2 `#313135`×2 `#444444`×1 `#242427`×1
- Text colours: `#ffffff`×27 `#00ff00`×3 `#ff0000`×2 `#000000`×2 `#0f0000`×1 `#1b2a35`×1
- Stroke colours: none; thickness none
- Corner radius: none
- Size mode: {'scale': 64, 'offset': 5, 'zero': 1}; TextScaled share 0.95; text sizes `14`×1 `54`×1
- Per 100 GUI objects: UICorner 0.0, UIStroke 0.0, UIGradient 0.0, UIAspectRatioConstraint 50.0, UIListLayout 0.0, UIGridLayout 1.4, UIPadding 0.0, UIScale 0.0, UITextSizeConstraint 0.0, ImageLabel 10.0, ImageButton 2.9, TextButton 28.6

## Map

- 55238 instances, 2809 parts (199 MeshParts, 238 unions); core extent [418, 66, 371] studs (X, Y, Z; 2nd-98th percentile), everything [1048, 341, 910]
- Lights 20, particle emitters 20, beams/trails 0, textures/decals 487, SurfaceAppearance 0, world GUIs 1, prompts 5, sounds 164
- Materials: `CorrodedMetal`×1071 `SmoothPlastic`×562 `Plastic`×315 `WoodPlanks`×235 `Metal`×158 `Wood`×156 `Grass`×118 `Granite`×67 `DiamondPlate`×38 `Neon`×29
- Part colours: `#a3a2a5`×797 `#111111`×702 `#957977`×156 `#a05f35`×148 `#7c5c46`×142 `#73844a`×115 `#6a5444`×115 `#d7c59a`×94 `#1b2a35`×85 `#636264`×48 `#6d6e6c`×46 `#a34b4b`×40
- Terrain voxel data: 214179 bytes

## Lighting

- Technology=ShadowMap, Brightness=2.0, TimeOfDay=14:00:00, Ambient=#4b4b4b, OutdoorAmbient=#4b4b4b, ColorShift_Top=#111111, EnvironmentDiffuseScale=0.0, EnvironmentSpecularScale=0.0, ExposureCompensation=0.23, GlobalShadows=True, ShadowSoftness=0.1, FogEnd=250.0, FogColor=#8d8d8d, GeographicLatitude=41.7333
- **ColorCorrectionEffect** `PwerOut`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **Sky** `Sky`: CelestialBodiesShown=False, StarCount=3000, SunAngularSize=21.0
- **ColorCorrectionEffect** `MikeHourColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `ShadowHourColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `ColorCorrection2`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `ColorCorrection3`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `ColorCorrection4`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `DeadEffect`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `Heartbeat`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=4.0, Spread=1.0
- **ColorCorrectionEffect** `BloodHourColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `NightmareHourColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=-0.8, TintColor=#ffffff
- **ColorCorrectionEffect** `Nightmare`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **ColorCorrectionEffect** `SeerHourColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
