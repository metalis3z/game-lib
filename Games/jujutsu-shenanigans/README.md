# Jujutsu Shenanigans

> 🥊 **Fighting** · anime battlegrounds (fighting) · source file `JJS paid 10k, by slbr devloppement team.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/15_Menus__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 57 ScreenGuis, 1366 GUI objects → **34 screenshots** |
| Models (.rbxm) | 2105 models, 11 model sets, 53 VFX sets |
| Lua builders (.lua) | 114 UI screens, 142 animation packs, 108 audio packs |
| Code | 299 scripts, 131,776 lines |
| Asset ids | 914 animations, 427 sounds |
| Safety scan | 3 HIGH / 5 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Finger Paint Regular`×212, `SourceSansPro Bold`×93, `SourceSansPro Regular`×71, `Finger Paint Bold`×33, `Arial Regular`×10

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_Menus__Shop.jpg"><img src="screenshots/thumbs/15_Menus__Shop.jpg" width="100%"></a><br><sub><b>Menus</b> › Shop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_Menus2__Inventory.jpg"><img src="screenshots/thumbs/18_Menus2__Inventory.jpg" width="100%"></a><br><sub><b>Menus2</b> › Group.Inventory</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_Gifting.jpg"><img src="screenshots/thumbs/24_Gifting.jpg" width="100%"></a><br><sub><b>Gifting</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Gifting__Frame.jpg"><img src="screenshots/thumbs/25_Gifting__Frame.jpg" width="100%"></a><br><sub><b>Gifting</b> › Frame</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_Menus__Private.jpg"><img src="screenshots/thumbs/14_Menus__Private.jpg" width="100%"></a><br><sub><b>Menus</b> › Private</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_Menus__Settings.jpg"><img src="screenshots/thumbs/16_Menus__Settings.jpg" width="100%"></a><br><sub><b>Menus</b> › Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_Menus2__Logs.jpg"><img src="screenshots/thumbs/19_Menus2__Logs.jpg" width="100%"></a><br><sub><b>Menus2</b> › Group.Logs</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Menus2__Ranked.jpg"><img src="screenshots/thumbs/20_Menus2__Ranked.jpg" width="100%"></a><br><sub><b>Menus2</b> › Group.Ranked</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Menus2__Tutorial_Info.jpg"><img src="screenshots/thumbs/21_Menus2__Tutorial_Info.jpg" width="100%"></a><br><sub><b>Menus2</b> › Group.Tutorial_Info</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Menus2__Settings.jpg"><img src="screenshots/thumbs/22_Menus2__Settings.jpg" width="100%"></a><br><sub><b>Menus2</b> › Group.Settings</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_Death__TitlesSF.jpg"><img src="screenshots/thumbs/29_Death__TitlesSF.jpg" width="100%"></a><br><sub><b>Death</b> › Image.TitlesSF</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_Black__TitlesSF.jpg"><img src="screenshots/thumbs/32_Black__TitlesSF.jpg" width="100%"></a><br><sub><b>Black</b> › Image.TitlesSF</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Menus2__Warning.jpg"><img src="screenshots/thumbs/23_Menus2__Warning.jpg" width="100%"></a><br><sub><b>Menus2</b> › Warning</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_KJDialogue.jpg"><img src="screenshots/thumbs/33_KJDialogue.jpg" width="100%"></a><br><sub><b>KJDialogue</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_DomainFade.jpg"><img src="screenshots/thumbs/07_DomainFade.jpg" width="100%"></a><br><sub><b>DomainFade</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_SukunaDomain_Template.jpg"><img src="screenshots/thumbs/01_SukunaDomain_Template.jpg" width="100%"></a><br><sub><b>SukunaDomain_Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_GojoDomain_Template.jpg"><img src="screenshots/thumbs/02_GojoDomain_Template.jpg" width="100%"></a><br><sub><b>GojoDomain_Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_YutaDomain_Template.jpg"><img src="screenshots/thumbs/03_YutaDomain_Template.jpg" width="100%"></a><br><sub><b>YutaDomain_Template</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_DomainWarn.jpg"><img src="screenshots/thumbs/05_DomainWarn.jpg" width="100%"></a><br><sub><b>DomainWarn</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_DomainInfo.jpg"><img src="screenshots/thumbs/06_DomainInfo.jpg" width="100%"></a><br><sub><b>DomainInfo</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_AwakeningBar.jpg"><img src="screenshots/thumbs/26_AwakeningBar.jpg" width="100%"></a><br><sub><b>AwakeningBar</b></sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Emotes__ImageLabel.jpg"><img src="screenshots/thumbs/08_Emotes__ImageLabel.jpg" width="100%"></a><br><sub><b>Emotes</b> › ImageLabel</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_Emotes__ScrollingFrame.jpg"><img src="screenshots/thumbs/09_Emotes__ScrollingFrame.jpg" width="100%"></a><br><sub><b>Emotes</b> › ScrollingFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_Awakening_Outfit.jpg"><img src="screenshots/thumbs/13_Awakening_Outfit.jpg" width="100%"></a><br><sub><b>Awakening Outfit</b></sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_Vote.jpg"><img src="screenshots/thumbs/31_Vote.jpg" width="100%"></a><br><sub><b>Vote</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Adapt.jpg"><img src="screenshots/thumbs/04_Adapt.jpg" width="100%"></a><br><sub><b>Adapt</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Cosmetics.jpg"><img src="screenshots/thumbs/10_Cosmetics.jpg" width="100%"></a><br><sub><b>Cosmetics</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Cosmetics__AurasSF.jpg"><img src="screenshots/thumbs/11_Cosmetics__AurasSF.jpg" width="100%"></a><br><sub><b>Cosmetics</b> › Frame.AurasSF</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_ShiftLock.jpg"><img src="screenshots/thumbs/12_ShiftLock.jpg" width="100%"></a><br><sub><b>ShiftLock</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_BossHP.jpg"><img src="screenshots/thumbs/28_BossHP.jpg" width="100%"></a><br><sub><b>BossHP</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_HeavyVi.jpg"><img src="screenshots/thumbs/30_HeavyVi.jpg" width="100%"></a><br><sub><b>HeavyVi</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_Impact3.jpg"><img src="screenshots/thumbs/34_Impact3.jpg" width="100%"></a><br><sub><b>Impact3</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_Adapt.jpg"><img src="screenshots/thumbs/36_Adapt.jpg" width="100%"></a><br><sub><b>Adapt</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_RotatingToolUIOLD.jpg"><img src="screenshots/thumbs/39_RotatingToolUIOLD.jpg" width="100%"></a><br><sub><b>RotatingToolUIOLD</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Modules/Emotes/chaosemralds.rbxm"><img src="screenshots/thumbs/models/01_chaosemralds.jpg" width="100%"></a><br><sub><b>chaosemralds</b><br><code>models/ServerStorage/Modules/Emotes/chaosemralds.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Modules/Emotes/Sword.rbxm"><img src="screenshots/thumbs/models/02_Sword.jpg" width="100%"></a><br><sub><b>Sword</b><br><code>models/ServerStorage/Modules/Emotes/Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Utils/Mahito/Whip.rbxm"><img src="screenshots/thumbs/models/05_Whip.jpg" width="100%"></a><br><sub><b>Whip</b><br><code>models/ReplicatedStorage/Utils/Mahito/Whip.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resources/StoneGrave/Beamed.rbxm"><img src="screenshots/thumbs/models/06_Beamed.jpg" width="100%"></a><br><sub><b>Beamed</b><br><code>models/ReplicatedStorage/Resources/StoneGrave/Beamed.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resources/TerribleTornado/JetBack.rbxm"><img src="screenshots/thumbs/models/07_JetBack.jpg" width="100%"></a><br><sub><b>JetBack</b><br><code>models/ReplicatedStorage/Resources/TerribleTornado/JetBack.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resources/Rocks.rbxm"><img src="screenshots/thumbs/models/08_Rocks.jpg" width="100%"></a><br><sub><b>Rocks</b><br><code>models/ReplicatedStorage/Resources/Rocks.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Modules/Emotes/sign.rbxm"><img src="screenshots/thumbs/models/09_sign.jpg" width="100%"></a><br><sub><b>sign</b><br><code>models/ServerStorage/Modules/Emotes/sign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Modules/Emotes/Prop.rbxm"><img src="screenshots/thumbs/models/10_Prop.jpg" width="100%"></a><br><sub><b>Prop</b><br><code>models/ServerStorage/Modules/Emotes/Prop.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resources/Bossfight/RocketLauncher.rbxm"><img src="screenshots/thumbs/models/11_RocketLauncher.jpg" width="100%"></a><br><sub><b>RocketLauncher</b><br><code>models/ReplicatedStorage/Resources/Bossfight/RocketLauncher.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resources/UFW/RB.rbxm"><img src="screenshots/thumbs/models/13_RB.jpg" width="100%"></a><br><sub><b>RB</b><br><code>models/ReplicatedStorage/Resources/UFW/RB.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`LocalScript`](source/scripts/StarterGui/DomainGUI/LocalScript.client.lua) <sub>256 lines</sub><br>[`Icon228`](source/scripts/ReplicatedStorage/Modules/Icon228.lua) <sub>2173 lines</sub><br>[`NewIcon`](source/scripts/ReplicatedStorage/Modules/NewIcon.lua) <sub>2162 lines</sub><br>[`idk`](source/scripts/ReplicatedStorage/Modules/idk.lua) <sub>20951 lines</sub><br>[`BlueGradient`](source/scripts/ReplicatedStorage/Modules/Icon228/Themes/BlueGradient.lua) <sub>42 lines</sub> |
| UI controllers / window managers / menus | [`Icon228`](source/scripts/ReplicatedStorage/Modules/Icon228.lua) <sub>2173 lines</sub><br>[`NewIcon`](source/scripts/ReplicatedStorage/Modules/NewIcon.lua) <sub>2162 lines</sub><br>[`IconController`](source/scripts/ReplicatedStorage/Modules/Icon228/IconController.lua) <sub>1188 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/Cosmetics/Frame/LocalScript.client.lua) <sub>54 lines</sub><br>[`CameraTableAnims`](source/scripts/ReplicatedStorage/Modules/CameraTableAnims.lua) <sub>342 lines</sub> |
| Notifications, toasts, popups, prompts | [`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/Main.client.lua) <sub>1189 lines</sub><br>[`Handler`](source/scripts/StarterGui/Emotes/Handler.client.lua) <sub>346 lines</sub><br>[`Icon228`](source/scripts/ReplicatedStorage/Modules/Icon228.lua) <sub>2173 lines</sub><br>[`NewIcon`](source/scripts/ReplicatedStorage/Modules/NewIcon.lua) <sub>2162 lines</sub> |
| Loading / intro screens | [`Preload`](source/scripts/ReplicatedFirst/Preload.client.lua) <sub>943 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraTableAnims`](source/scripts/ReplicatedStorage/Modules/CameraTableAnims.lua) <sub>342 lines</sub><br>[`WindShake`](source/scripts/ReplicatedStorage/Modules/WindShake.lua) <sub>407 lines</sub><br>[`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker.lua) <sub>193 lines</sub><br>[`CameraHandler`](source/scripts/ReplicatedStorage/Modules/CameraHandler.lua) <sub>147 lines</sub><br>[`ShakeCamera`](source/scripts/ReplicatedFirst/ShakeCamera.lua) <sub>44 lines</sub> |
| VFX, particles, beams, hit effects | [`FXController`](source/scripts/ReplicatedStorage/Modules/FXController.lua) <sub>248 lines</sub><br>[`Rapid Punch`](source/scripts/ServerScriptService/Main/Abilities/Rapid%20Punch.lua) <sub>229 lines</sub><br>[`Hollow Purple`](source/scripts/ServerScriptService/Main/Abilities/Hollow%20Purple.lua) <sub>224 lines</sub><br>[`Reversal Red`](source/scripts/ServerScriptService/Main/Abilities/Reversal%20Red.lua) <sub>230 lines</sub><br>[`TwofoldKick`](source/scripts/ServerScriptService/Main/Abilities/TwofoldKick.lua) <sub>252 lines</sub> |
| DataStore / player data | [`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub><br>[`Handler`](source/scripts/StarterGui/Emotes/Handler.client.lua) <sub>346 lines</sub><br>[`ShopClient`](source/scripts/StarterGui/Menus/Shop/ShopClient.client.lua) <sub>206 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/Main.client.lua) <sub>1189 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Emotes`](source/scripts/ServerStorage/Modules/Emotes.lua) <sub>2352 lines</sub><br>[`SmartBone`](source/scripts/ReplicatedStorage/Modules/SmartBone.lua) <sub>671 lines</sub><br>[`Info`](source/scripts/ReplicatedStorage/Info.lua) <sub>1420 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Combat`](source/scripts/ServerScriptService/Main/Combat.server.lua) <sub>1503 lines</sub><br>[`Rapid Punch`](source/scripts/ServerScriptService/Main/Abilities/Rapid%20Punch.lua) <sub>229 lines</sub><br>[`AttackScript`](source/scripts/ServerScriptService/QOL/Dummy/Scripts/AttackScript.server.lua) <sub>85 lines</sub><br>[`Rapid PunchDef`](source/scripts/ServerScriptService/Main/Abilities/Rapid%20PunchDef.lua) <sub>200 lines</sub><br>[`Idk`](source/scripts/ServerScriptService/Main/Abilities/Idk.lua) <sub>140 lines</sub> |
| NPC / AI / monsters | [`SUKARABOTAI`](source/scripts/StarterPlayer/StarterCharacterScripts/SUKARABOTAI.client.lua) <sub>63 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`ParkourV2`](source/scripts/StarterPlayer/StarterCharacterScripts/ParkourV2.client.lua) <sub>246 lines</sub><br>[`Combat`](source/scripts/ServerScriptService/Main/Combat.server.lua) <sub>1503 lines</sub><br>[`MovementController`](source/scripts/StarterPlayer/StarterCharacterScripts/MovementController.lua) <sub>215 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/Main.client.lua) <sub>1189 lines</sub><br>[`ParkourV2.0`](source/scripts/StarterPlayer/StarterCharacterScripts/ParkourV2.0.client.lua) <sub>217 lines</sub> |
| Tycoon / plots / bases / building | [`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub><br>[`PrivateClient`](source/scripts/StarterGui/Menus/Private/PrivateClient.client.lua) <sub>184 lines</sub><br>[`idk`](source/scripts/ReplicatedStorage/Modules/idk.lua) <sub>20951 lines</sub><br>[`BuildScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BuildScript.client.lua) <sub>112 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/Main.client.lua) <sub>1189 lines</sub> |
| Leaderboards & stats | [`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub> |
| Admin panels & commands | [`Commands`](source/scripts/ServerScriptService/QOL/Commands.server.lua) <sub>493 lines</sub><br>[`Init`](source/scripts/ServerScriptService/Main/Init.server.lua) <sub>1503 lines</sub> |
| Sound & music | [`TriggerAwkMusic`](source/scripts/ReplicatedStorage/Modules/Utility/TriggerAwkMusic.lua) <sub>26 lines</sub><br>[`SoundsModule`](source/scripts/ServerStorage/Modules/SoundsModule.lua) <sub>51 lines</sub><br>[`Footsteps`](source/scripts/StarterPlayer/StarterPlayerScripts/Footsteps.client.lua) <sub>182 lines</sub><br>[`NewIcon`](source/scripts/ReplicatedStorage/Modules/NewIcon.lua) <sub>2162 lines</sub><br>[`Icon228`](source/scripts/ReplicatedStorage/Modules/Icon228.lua) <sub>2173 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`MovesetHandler`](source/scripts/ServerStorage/Modules/MovesetHandler.lua) <sub>127 lines</sub><br>[`Maid`](source/scripts/ReplicatedStorage/Modules/Icon228/Maid.lua) <sub>154 lines</sub><br>[`PartCache`](source/scripts/ReplicatedStorage/Modules/VoxBreaker/PartCache.lua) <sub>192 lines</sub><br>[`Icon228`](source/scripts/ReplicatedStorage/Modules/Icon228.lua) <sub>2173 lines</sub><br>[`NewIcon`](source/scripts/ReplicatedStorage/Modules/NewIcon.lua) <sub>2162 lines</sub> |

### In the curated script library

- [CameraShaker (RbxCameraShaker)](../../Scripts/05-Camera-Cutscene/CameraShaker__jujutsu-shenanigans.lua) — Open-source camera shake engine: ShakeOnce, sustained shakes, presets, fade in/out.
- [CameraShakeInstance](../../Scripts/05-Camera-Cutscene/CameraShakeInstance__jujutsu-shenanigans.lua) — Single shake instance used by CameraShaker (Perlin noise, fade states).
- [CameraShakePresets](../../Scripts/05-Camera-Cutscene/CameraShakePresets__jujutsu-shenanigans.lua) — Ready-made shake presets (Explosion, Earthquake, Bump, Handheld...).
- [ShakeCamera wrapper](../../Scripts/05-Camera-Cutscene/ShakeCameraWrapper__jujutsu-shenanigans.lua) — How a game wraps CameraShaker into one shared module (one instance, simple API).
- [Combat client camera](../../Scripts/05-Camera-Cutscene/CombatCameraClient__jujutsu-shenanigans.lua) — Additive decaying shake + head-follow CameraOffset + 'dead cam' offset in one LocalScript.
- [Frame-table camera cutscenes](../../Scripts/05-Camera-Cutscene/FrameTableCameraCutscene__jujutsu-shenanigans.lua) — Data-driven cutscenes: per-frame CFrame + FOV tables played at 60 fps relative to a part.
- [Animated camera rig cutscenes](../../Scripts/05-Camera-Cutscene/CameraRigCutscene__jujutsu-shenanigans.lua) — Animate a camera rig with normal animations; camera follows the rig's Cam part; smooth hand-back.
- [Lock-on camera](../../Scripts/05-Camera-Cutscene/LockOnCamera__jujutsu-shenanigans.lua) — Target lock-on with crosshair picking, left/right switching, line-of-sight break, shoulder offset.
- [Head-follow camera offset](../../Scripts/05-Camera-Cutscene/HeadFollowCameraOffset__jujutsu-shenanigans.lua) — Camera follows the head during animations (CameraOffset = head relative to root).
- [Hitbox class (spatial query)](../../Scripts/11-Combat/HitboxHandler__jujutsu-shenanigans.lua) — Reusable hitbox class: box/radius query, per-frame or once, hit-once list, closest-only mode.
- [Damage pipeline](../../Scripts/11-Combat/DamageHandler__jujutsu-shenanigans.lua) — Central damage function: block from the front only, counters, finishers, stun + hit animation.
- [Stun handler](../../Scripts/11-Combat/StunHandler__jujutsu-shenanigans.lua) — Tag-based stun: one call blocks every action via CollectionService tags, restored when stuns expire.
- [M1 combo + perfect block](../../Scripts/11-Combat/M1ComboAndBlock__jujutsu-shenanigans.lua) — Combo counter with timeout + block with a perfect-block window.
- [Dash, vault and footsteps](../../Scripts/13-Movement/DashVaultFootsteps__jujutsu-shenanigans.lua) — Small all-in-one: camera-direction dash, auto vault over low walls, sprint, footsteps by material.
- [Side / back dash rules (server)](../../Scripts/13-Movement/SideBackDashGating__jujutsu-shenanigans.lua) — How a fighting game gates dashes on the server with tags, separate cooldowns and ragdoll-cancel.
- [Ledge vault](../../Scripts/13-Movement/LedgeVault__jujutsu-shenanigans.lua) — Name-tagged vault parts: ray check + short velocity burst + random animation.
- [Combat ragdoll handler](../../Scripts/13-Movement/CombatRagdoll__jujutsu-shenanigans.lua) — Ragdoll for combat: timed knockdowns, collider parts, air detection, cancel, stacked-timer handling.
- [Positional one-shot sound helper](../../Scripts/17-Sound-Music/SoundsModule__jujutsu-shenanigans.lua) — Tiny helper: clone a Sound, put it on a part or at a world position (via a Terrain attachment), route it to a SoundGroup, set speed and start time, optionally fade it out after a delay, and auto-clean with Debris.
- [Material-based footsteps](../../Scripts/17-Sound-Music/MaterialFootsteps__jujutsu-shenanigans.lua) — Footstep sounds chosen by Humanoid.FloorMaterial (3 random variations per material, with aliases), fired from an animation marker (runfootstep) with a rate limit; also jump and land sounds from StateChanged.
- [Fade sound group in/out](../../Scripts/17-Sound-Music/AwakeningMusicToggle__jujutsu-shenanigans.lua) — Fades a group of sounds under an attachment in or out (1 s linear tween), remembering each original volume in an attribute; honors a per-player Awakening Music setting.
- [Particle helpers](../../Scripts/06-VFX/ParticleHelpers__jujutsu-shenanigans.lua) — Highest-lifetime lookup, emit all, toggle, scale lifetime, tween model scale.
- [Limb trails](../../Scripts/06-VFX/LimbTrails__jujutsu-shenanigans.lua) — Attach a trail or particle part to a limb for N seconds, then let it fade in place.
- [Ability: charge, projectile, explosion](../../Scripts/06-VFX/ReversalRedAbility__jujutsu-shenanigans.lua) — Reference ability timeline: charge-up tweens -> projectile -> multi-emitter explosion -> knockback.
- [Barrage arms + shockwaves](../../Scripts/06-VFX/BarrageArmsBezier__jujutsu-shenanigans.lua) — Bezier-curve ghost arms + tiny shockwave rings for a barrage / rapid punch.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/QOL/Cosmetics.server.lua`
- `scripts/ServerScriptService/QOL/Cosmetics.server.lua`
- `scripts/Workspace/Map/Map/Destructible/Model/StationControl/Handle.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
