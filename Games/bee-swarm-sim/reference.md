# Bee Swarm Simulator (remake): quality reference

Numbers measured from the place file. Use them as targets when building something in this genre.

## UI

- 5 ScreenGuis, 622 GUI objects, 61 unique images
- Fonts: `FredokaOne Regular`×280 `SourceSansPro Regular`×18 `ComicNeueAngular Regular`×12 `ComicNeueAngular Bold`×11 `Poppins Bold`×3 `PressStart2P Regular`×2
- Panel colours: `#ffffff`×22 `#000000`×18 `#1e1e1e`×14 `#2f2f2f`×7 `#e25252`×6 `#5ae258`×6 `#ff3c3c`×6 `#96ff7e`×5 `#a7c6ff`×5 `#151515`×5
- Text colours: `#ffffff`×148 `#393939`×52 `#000000`×24 `#141414`×16 `#f9f9f9`×16 `#424242`×15
- Stroke colours: `#1e1e1e`×104 `#141414`×32 `#424242`×28 `#000000`×21 `#363636`×19 `#242424`×9; thickness `2.0 px`×106 `4.0 px`×72 `2.2 px`×43 `3.0 px`×28 `1.0 px`×20
- Corner radius: `{1.0,0}`×45 `{0.0,16}`×21 `{0.2,0}`×17 `{0.1,0}`×13 `{0.3,0}`×10 `{0.999,0}`×10
- Size mode: {'offset': 76, 'zero': 17, 'scale': 490, 'mixed': 39}; TextScaled share 0.94; text sizes `14`×18 `1`×2
- Per 100 GUI objects: UICorner 28.6, UIStroke 49.5, UIGradient 20.6, UIAspectRatioConstraint 0.3, UIListLayout 2.4, UIGridLayout 1.1, UIPadding 0.2, UIScale 0.5, UITextSizeConstraint 0.0, ImageLabel 22.3, ImageButton 9.2, TextButton 7.4

## Map

- 11127 instances, 7285 parts (6531 MeshParts, 74 unions); core extent [7277, 2036, 4758] studs (X, Y, Z; 2nd-98th percentile), everything [12186, 3672, 8250]
- Lights 68, particle emitters 36, beams/trails 2, textures/decals 801, SurfaceAppearance 0, world GUIs 137, prompts 0, sounds 1
- Materials: `SmoothPlastic`×3780 `Plastic`×3094 `Neon`×277 `Glass`×94 `Metal`×14 `ForceField`×10 `Sand`×8 `Wood`×7 `Concrete`×1
- Part colours: `#4b974b`×1332 `#564236`×1298 `#5b5d69`×441 `#348e40`×199 `#a3a2a5`×185 `#1b2a35`×142 `#c4281c`×139 `#da8541`×121 `#ffb000`×119 `#f5cd30`×103 `#000000`×100 `#24622c`×96
- Terrain voxel data: 2 bytes

## Lighting

- Technology=Voxel, Brightness=3.0, TimeOfDay=14:00:00, Ambient=#0c3282, OutdoorAmbient=#0c3282, ColorShift_Top=#000000, EnvironmentDiffuseScale=0.5, EnvironmentSpecularScale=0.5, ExposureCompensation=0.0, GlobalShadows=True, ShadowSoftness=0.2, FogEnd=2800.0, FogColor=#6795ff, GeographicLatitude=0.0
- **BloomEffect** `Bloom`: Enabled=True, Intensity=0.15, Size=56.0, Threshold=0.95
- **ColorCorrectionEffect** `ColorCorrection`: Brightness=0.08, Contrast=0.02, Enabled=True, Saturation=0.4, TintColor=#ffffff
- **DepthOfFieldEffect** `DepthOfField`: Enabled=False, FarIntensity=0.2, FocusDistance=0.0, InFocusRadius=50.0, NearIntensity=0.0
- **BlurEffect** `NpcsUI`: Enabled=False, Size=24.0
- **ColorCorrectionEffect** `NpcsUI`: Brightness=-0.1, Contrast=-0.5, Enabled=False, Saturation=-0.6, TintColor=#ffffff
- **SunRaysEffect** `SunRays`: Enabled=True, Intensity=0.25, Spread=1.0
- **Sky** `Sky`: CelestialBodiesShown=True, StarCount=3000, SunAngularSize=11.0
- **BlurEffect** `Blur`: Enabled=False, Size=15.0
