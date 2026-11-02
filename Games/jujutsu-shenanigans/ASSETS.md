# Jujutsu Shenanigans

- Genre: anime battlegrounds (fighting)
- Source file: `JJS paid 10k, by slbr devloppement team.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 2240 files, 22436 KB (328 duplicates skipped, 127 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 114 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 2105 models, 26 part sets, 53 vfx sets | mirrors the source tree |
| `animations/` | 142 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 914 Animation ids |
| `audio/` | 108 | `Sounds.lua` lists 427 Sound ids |

## Model tags

ability (1145), vfx (1011), character (88), tool (65), nature (29), weapon (27), map (24), backup (17), portal (15), accessory (13), hud (7), cutscene (7), sign (3), decoration (3), vehicle (2), egg (1), building (1), collectible (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/Map/Map.rbxm` | 11827 | 10395 | 1 | 704x217x973 | map |
| `models/ServerStorage/Modules/Emotes/EnternalSeal/PrisonRealmRig.rbxm` | 9188 | 7 | 6 | 10x10x4 | ability, character |
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 7182 | 0 | 0 |  |  |
| `models/ReplicatedStorage/Resources/Dragon/Dragon.rbxm` | 5154 | 10 | 9 | 48x29x41 | ability, character |
| `models/ReplicatedStorage/Modules/CameraHandler/Cam.rbxm` | 4928 | 3 | 0 | 4x1x2 | character |
| `models/ServerStorage/Modules/Emotes/EnternalSeal/Attacker.rbxm` | 4195 | 7 | 0 | 4x5x1 | ability, character |
| `models/ServerStorage/Modules/Emotes/EnternalSeal/Strings/String2.rbxm` | 3917 | 3 | 2 | 8x2x2 | ability, character |
| `models/ReplicatedStorage/Resources/Fang/CameraRig.rbxm` | 1988 | 2 | 0 | 1x1x1 | ability, character |
| `models/ServerStorage/Assets/Models/Shadow Monarch/DragonHead.rbxm` | 1773 | 11 | 9 | 8x11x9 | character |
| `models/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Okarun/WolfHeadRoblox.rbxm` | 1493 | 1 | 1 | 19x20x34 | character |
| `models/ReplicatedStorage/Resources/Fang/Rack.rbxm` | 1162 | 6 | 4 | 19x3x18 | ability, character |
| `models/ReplicatedStorage/Modules/CameraHandler/CamRigWithLetterBox.rbxm` | 634 | 4 | 3 | 3x5x1 | character |
| `models/ServerStorage/Modules/Emotes/EnternalSeal/F.rbxm` | 606 | 2 | 1 | 3x4x3 | ability, character |
| `models/ReplicatedStorage/Resources/UFW/Rig.rbxm` | 357 | 66 | 0 | 2x5x4 | ability, character |
| `models/ReplicatedStorage/Resources/Meteor/Meteorite.rbxm` | 253 | 21 | 2 | 57x62x56 | ability |
| `models/ReplicatedStorage/Resources/TerribleTornado/Flips.rbxm` | 241 | 8 | 0 | 33x13x18 | ability |
| `models/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Okarun/hdkEffect.rbxm` | 233 | 16 | 3 | 51x42x41 | vfx |
| `models/ReplicatedStorage/Resources/UFW/vfx/PunchFX/FinalCrack.rbxm` | 229 | 12 | 12 | 163x1x488 | ability, vfx |
| `models/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Heian/Shrine.rbxm` | 228 | 226 | 0 | 48x54x54 |  |
| `models/ReplicatedStorage/Resources/UFW/vfx/Pillar.rbxm` | 205 | 3 | 0 | 36x379x582 | ability, vfx |
| `models/ReplicatedStorage/Resources/AtomicFX.rbxm` | 203 | 24 | 10 | 351x452x359 | ability, vfx |
| `models/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Okarun/Emit/Claw.rbxm` | 196 | 1 | 0 | 2x2x2 | vfx |
| `models/ReplicatedStorage/Resources/UFW/vfx/FinalCrack.rbxm` | 191 | 10 | 10 | 4x77x77 | ability, vfx |
| `models/ServerStorage/Model/Serious Cam/Serious Cam.rbxm` | 188 | 2 | 0 | 1x1x1 | character |
| `models/ReplicatedStorage/Modules/CameraHandler/CameraRig2.rbxm` | 172 | 3 | 0 | 2x3x4 | character |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/Menus.lua` | 244 | 10 |
| `ui/StarterGui/iFrames.lua` | 238 | 229 |
| `ui/StarterGui/Menus2.lua` | 146 | 14 |
| `ui/StarterGui/Emotes/init.lua` | 120 | 15 |
| `ui/StarterGui/Hotbar.lua` | 93 | 1 |
| `ui/ReplicatedStorage/Resources/FiveSeasonsFX/FXUi.lua` | 47 | 44 |
| `ui/StarterGui/ShiftLock.lua` | 36 | 12 |
| `ui/StarterGui/Cosmetics.lua` | 33 | 5 |
| `ui/ReplicatedStorage/Resources/UFW/ImpactFrames.lua` | 27 | 26 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Okarun/ImpactFrame.lua` | 25 | 24 |
| `ui/ReplicatedStorage/Resources/UFW/Impact2.lua` | 25 | 23 |
| `ui/StarterGui/Gifting.lua` | 21 | 4 |
| `ui/ReplicatedStorage/Resources/KJEffects/Text.lua` | 17 | 16 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Domain/SukunaDomain_Template.lua` | 15 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Domain/GojoDomain_Template.lua` | 15 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Domain/YutaDomain_Template.lua` | 15 | 5 |
| `ui/ReplicatedStorage/Resources/Sunrise/ImpactFrame.lua` | 13 | 12 |
| `ui/StarterGui/AwakeningBar.lua` | 11 | 2 |
| `ui/ReplicatedStorage/Resources/Fang/Impact.lua` | 11 | 10 |
| `ui/StarterGui/Awakening Outfit.lua` | 10 | 10 |
| `ui/ReplicatedStorage/Resources/KJEffects/ImpactFrames.lua` | 9 | 8 |
| `ui/StarterGui/DomainGUI.lua` | 8 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/DomainWarn.lua` | 8 | 2 |
| `ui/ReplicatedStorage/Resources/UFW/Flash.lua` | 8 | 1 |
| `ui/ReplicatedStorage/Utils/DomainWarn.lua` | 8 | 2 |
| `ui/StarterGui/Donations.lua` | 7 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Hakari/IdleDeath/DomainInfo.lua` | 7 | 0 |
| `ui/ReplicatedStorage/GuiAnimatorPlugin/Modules/JointEditModule/RotatingToolUIOLD.lua` | 7 | 0 |
| `ui/ReplicatedStorage/Resources/OmniImpact.lua` | 6 | 5 |
| `ui/ReplicatedStorage/Resources/TerribleTornado/ImpactFrame.lua` | 6 | 3 |
| `ui/ReplicatedStorage/Resources/BossHP.lua` | 6 | 3 |
| `ui/ServerStorage/Assets/Models/Killstreak/KillstreakGui.lua` | 6 | 2 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Misc/SyncEmote.lua` | 5 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Mahito/Worms/Dialogue2.lua` | 5 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Mahoraga/Adapt.lua` | 5 | 2 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Mahoraga/Adaptation.lua` | 5 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Dialogue.lua` | 5 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Hakari/Dialogue.lua` | 5 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Itadori/Switch/Switch.lua` | 5 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Gojo/Dialogue.lua` | 5 | 0 |
