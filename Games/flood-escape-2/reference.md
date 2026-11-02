# Flood Escape 2: quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 14 ScreenGuis, 964 GUI objects, 49 unique images
- Fonts: `Ubuntu Regular`×120 `LegacyArial Regular`×100 `Roboto Regular`×17 `Ubuntu Bold`×10 `RobotoMono Regular`×2 `Roboto Medium`×1
- Panel colours: `#000000`×93 `#161f28`×38 `#2c3e50`×25 `#3f3f3f`×8 `#9b59b6`×8 `#2980b9`×8 `#f1db80`×8 `#3498db`×7 `#ffffff`×7 `#e74c3c`×6
- Text colours: `#ffffff`×179 `#000000`×27 `#f1db80`×8 `#00cc71`×7 `#606060`×6 `#efefef`×6
- Stroke colours: `#000000`×1 `#ffffff`×1; thickness `2.0 px`×2
- Corner radius: `{0.0,3}`×94 `{0.0,8}`×28 `{0.25,0}`×10 `{0.125,0}`×8 `{1.0,0}`×6 `{0.0,50}`×4
- Size mode: {'scale': 883, 'mixed': 53, 'offset': 9, 'zero': 19}; TextScaled share 0.89; text sizes `16`×12 `14`×9 `12`×3 `25`×2 `24`×1
- Per 100 GUI objects: UICorner 16.3, UIStroke 0.2, UIGradient 26.5, UIAspectRatioConstraint 0.1, UIListLayout 3.8, UIGridLayout 1.2, UIPadding 4.0, UIScale 1.5, UITextSizeConstraint 0.0, ImageLabel 29.4, ImageButton 2.3, TextButton 5.8

## Map

- 2425 instances, 815 parts (0 MeshParts, 11 unions); core extent [99, 103, 200] studs (X, Y, Z; 2nd-98th percentile), everything [148, 188, 236]
- Lights 11, particle emitters 4, beams/trails 55, textures/decals 202, SurfaceAppearance 0, world GUIs 28, prompts 0, sounds 1
- Materials: `Neon`×225 `Cobblestone`×116 `DiamondPlate`×98 `Plastic`×70 `WoodPlanks`×61 `SmoothPlastic`×52 `Metal`×49 `Grass`×32 `Marble`×25 `Brick`×25
- Part colours: `#aba89e`×100 `#1b2a35`×80 `#04afec`×60 `#a3a2a5`×58 `#ffd27e`×46 `#5b5d69`×41 `#f8f8f8`×39 `#000000`×37 `#6e99ca`×37 `#00ffff`×35 `#6c584b`×34 `#111111`×30
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=1.0, TimeOfDay=14:00:00, Ambient=#7f7f7f, OutdoorAmbient=#7f7f7f, ColorShift_Top=#000000, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=0.0, ExposureCompensation=0.25, GlobalShadows=True, ShadowSoftness=0.5, FogEnd=100000.0, FogColor=#bfbfbf, GeographicLatitude=41.733
- **BlurEffect** `Fade_Blur`: Enabled=False, Size=56.0
- **ColorCorrectionEffect** `Fade_ColorCorrection`: Brightness=-1.0, Contrast=0.0, Enabled=False, Saturation=0.0, TintColor=#ffffff
- **BlurEffect** `Notification_Blur`: Enabled=False, Size=56.0
- **BlurEffect** `Water_Blur`: Enabled=False, Size=4.0
- **ColorCorrectionEffect** `Water_ColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=False, Saturation=0.0, TintColor=#00aaff
- **DepthOfFieldEffect** `Water_DepthOfField`: Enabled=False, FarIntensity=1.0, FocusDistance=16.0, InFocusRadius=0.0, NearIntensity=0.0
- **BloomEffect** `Water_Bloom`: Enabled=False, Intensity=0.2, Size=56.0, Threshold=0.4
- **BlurEffect** `Standard_Blur`: Enabled=True, Size=1.5
- **ColorCorrectionEffect** `Standard_ColorCorrection`: Brightness=0.0, Contrast=0.0, Enabled=True, Saturation=0.0, TintColor=#ffffff
- **BloomEffect** `Standard_Bloom`: Enabled=True, Intensity=0.2, Size=16.0, Threshold=0.8
