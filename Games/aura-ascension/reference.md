# Aura Ascension (UPD 3): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 9 ScreenGuis, 761 GUI objects, 84 unique images
- Fonts: `FredokaOne Regular`×202 `GothamSSm Heavy`×20 `FredokaOne Bold`×14 `SourceSansPro Regular`×7 `GothamSSm ExtraBold`×6 `Fondamento Regular`×4
- Panel colours: `#ffffff`×42 `#000000`×23 `#ff2348`×4 `#ff0044`×3 `#121212`×1
- Text colours: `#ffffff`×207 `#000000`×39 `#ffff00`×5 `#ffd014`×5 `#ffd400`×2 `#00ff00`×2
- Stroke colours: `#000000`×283 `#ffffff`×43 `#55aa7f`×2 `#3a3a3a`×2 `#00aaff`×1 `#353535`×1; thickness `0.06 scaled`×99 `0.08 scaled`×55 `0.03 scaled`×52 `0.04 scaled`×25 `0.11 scaled`×18
- Corner radius: `{1.0,0}`×14 `{0.05,0}`×12 `{0.073,0}`×11 `{0.1,0}`×8 `{0.15,0}`×5 `{0.135,0}`×5
- Size mode: {'scale': 761}; TextScaled share 0.97; text sizes `14`×7
- Per 100 GUI objects: UICorner 9.1, UIStroke 44.2, UIGradient 16.7, UIAspectRatioConstraint 7.5, UIListLayout 4.7, UIGridLayout 0.0, UIPadding 24.6, UIScale 1.3, UITextSizeConstraint 0.0, ImageLabel 26.9, ImageButton 9.2, TextButton 0.9

## Map

- 5491 instances, 2449 parts (250 MeshParts, 11 unions); core extent [1906, 217, 1276] studs (X, Y, Z; 2nd-98th percentile), everything [4424, 1533, 6144]
- Lights 14, particle emitters 79, beams/trails 24, textures/decals 267, SurfaceAppearance 1, world GUIs 48, prompts 1, sounds 3
- Materials: `Plastic`×2162 `Neon`×102 `DiamondPlate`×72 `Metal`×42 `SmoothPlastic`×33 `Glass`×13 `WoodPlanks`×6 `Granite`×4 `Cobblestone`×4 `Concrete`×3
- Part colours: `#348126`×375 `#674532`×277 `#4b7d2b`×171 `#589333`×162 `#3f3f3f`×160 `#7e573d`×120 `#a3a2a5`×111 `#4a4a4a`×111 `#414141`×57 `#a1a1a1`×55 `#ff0000`×54 `#5b5d69`×53
- Terrain voxel data: 2 bytes

## Lighting

- Technology=ShadowMap, Brightness=1.5, TimeOfDay=10:00:00, Ambient=#fbc6ff, OutdoorAmbient=#ffdeff, ColorShift_Top=#cad1ff, EnvironmentDiffuseScale=1.0, EnvironmentSpecularScale=1.0, ExposureCompensation=0.0, GlobalShadows=False, ShadowSoftness=0.2, FogEnd=1000000000.0, FogColor=#c0c0c0, GeographicLatitude=33.0
- **Atmosphere** `Normal`: Color=#a9e1ff, Decay=#4e7c8a, Density=0.278, Glare=0.2, Haze=2.0, Offset=0.0
- **Sky** `Normal`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=21.0
- **BlurEffect** `Normal`: Enabled=True, Size=0.0
- **BloomEffect** `Normal`: Enabled=True, Intensity=1.0, Size=24.0, Threshold=3.011
- **BlurEffect** `UI`: Enabled=True, Size=0.0
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=1.0, FocusDistance=0.0, InFocusRadius=7.865, NearIntensity=1.0
- **ColorCorrectionEffect** `Normal`: Brightness=0.0, Contrast=0.2, Enabled=True, Saturation=0.3, TintColor=#ffffff
- **BlurEffect** `PurchaseBlur`: Enabled=True, Size=0.0
- **BlurEffect** `UIBlur`: Enabled=True, Size=0.0
- **DepthOfFieldEffect** `InventoryHudDepthOfField`: Enabled=False, FarIntensity=0.0, FocusDistance=12.0, InFocusRadius=18.0, NearIntensity=0.0
