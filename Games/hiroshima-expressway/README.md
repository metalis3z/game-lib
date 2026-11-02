# Hiroshima Expressway

> 🚗 **Driving** · map / driving (Japanese expressway) · source file `Hiroshima-Expressway.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_AC6_Controls_Module__Window.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 3 ScreenGuis, 42 GUI objects → **6 screenshots** |
| Models (.rbxm) | 133 models, 6 model sets, 0 VFX sets |
| Lua builders (.lua) | 5 UI screens, 0 animation packs, 3 audio packs |
| Code | 2042 scripts, 489,347 lines |
| Asset ids | 4 animations, 1303 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Regular`×7, `GothamSSm Bold`×7

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_SpawnerGui__Window.jpg"><img src="screenshots/thumbs/01_SpawnerGui__Window.jpg" width="100%"></a><br><sub><b>SpawnerGui</b> › Window</sub></td>
<td width="33%" valign="top"><a href="screenshots/02_AC6_Controls_Module__Window.jpg"><img src="screenshots/thumbs/02_AC6_Controls_Module__Window.jpg" width="100%"></a><br><sub><b>AC6_Controls_Module</b> › Window</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Corsa_Gauges.jpg"><img src="screenshots/thumbs/03_Corsa_Gauges.jpg" width="100%"></a><br><sub><b>Corsa Gauges</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_CORSA_Tire_System.jpg"><img src="screenshots/thumbs/04_CORSA_Tire_System.jpg" width="100%"></a><br><sub><b>CORSA Tire System</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_Corsa_Gauges.jpg"><img src="screenshots/thumbs/06_Corsa_Gauges.jpg" width="100%"></a><br><sub><b>Corsa Gauges</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_CORSA_Tire_System.jpg"><img src="screenshots/thumbs/07_CORSA_Tire_System.jpg" width="100%"></a><br><sub><b>CORSA Tire System</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Takumi%29%20%28Spec%20I%29.rbxm"><img src="screenshots/thumbs/models/01_AE86_Takumi_Spec_I_.jpg" width="100%"></a><br><sub><b>AE86 (Takumi) (Spec I)</b><br><code>models/ServerStorage/Vehicles/AE86 (Takumi) (Spec I).rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Takumi%29%20%28Spec%20II%29.rbxm"><img src="screenshots/thumbs/models/04_AE86_Takumi_Spec_II_.jpg" width="100%"></a><br><sub><b>AE86 (Takumi) (Spec II)</b><br><code>models/ServerStorage/Vehicles/AE86 (Takumi) (Spec II).rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Wataru%29%20%28Spec%20I%29.rbxm"><img src="screenshots/thumbs/models/07_AE86_Wataru_Spec_I_.jpg" width="100%"></a><br><sub><b>AE86 (Wataru) (Spec I)</b><br><code>models/ServerStorage/Vehicles/AE86 (Wataru) (Spec I).rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Wataru%29%20%28Spec%20II%29.rbxm"><img src="screenshots/thumbs/models/09_AE86_Wataru_Spec_II_.jpg" width="100%"></a><br><sub><b>AE86 (Wataru) (Spec II)</b><br><code>models/ServerStorage/Vehicles/AE86 (Wataru) (Spec II).rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Rally%29.rbxm"><img src="screenshots/thumbs/models/11_AE86_Rally_.jpg" width="100%"></a><br><sub><b>AE86 (Rally)</b><br><code>models/ServerStorage/Vehicles/AE86 (Rally).rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Vehicles/AE86%20%28Shinji%29.rbxm"><img src="screenshots/thumbs/models/13_AE86_Shinji_.jpg" width="100%"></a><br><sub><b>AE86 (Shinji)</b><br><code>models/ServerStorage/Vehicles/AE86 (Shinji).rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`SpawnerClient`](source/scripts/StarterGui/SpawnerGui/SpawnerClient.client.lua) <sub>490 lines</sub><br>[`EpicLights`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub><br>[`EpicLights`](source/scripts/ServerStorage/Vehicles/Amemiya%20%C2%B5%20Boost%20up%207/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub> |
| UI controllers / window managers / menus | [`SpawnerClient`](source/scripts/StarterGui/SpawnerGui/SpawnerClient.client.lua) <sub>490 lines</sub><br>[`Controls_AC6`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/AC6_Controls_Module/Controls_AC6.client.lua) <sub>159 lines</sub><br>[`Icon`](source/scripts/ReplicatedStorage/Icon.lua) <sub>1092 lines</sub><br>[`Drive`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/A-Chassis%20Interface/Drive.client.lua) <sub>1179 lines</sub> |
| Notifications, toasts, popups, prompts | [`EpicLights`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub><br>[`EpicLights`](source/scripts/ServerStorage/Vehicles/Amemiya%20%C2%B5%20Boost%20up%207/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub> |
| Camera, cutscenes, screen shake | [`SpawnerClient`](source/scripts/StarterGui/SpawnerGui/SpawnerClient.client.lua) <sub>490 lines</sub> |
| VFX, particles, beams, hit effects | [`EpicLights`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub><br>[`EpicLights`](source/scripts/ServerStorage/Vehicles/Amemiya%20%C2%B5%20Boost%20up%207/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/EpicLights.client.lua) <sub>507 lines</sub><br>[`Handler`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/LightEvent/Handler.server.lua) <sub>1920 lines</sub><br>[`Handler`](source/scripts/ServerStorage/Vehicles/AE86%20%28Takumi%29%20%28Spec%20I%29/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/LightEvent/Handler.server.lua) <sub>1920 lines</sub><br>[`Handler`](source/scripts/ServerStorage/Vehicles/Amemiya%20%C2%B5%20Boost%20up%207/A-Chassis%20Tune/Plugins/EpicLights_V3BETA/LightEvent/Handler.server.lua) <sub>1920 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`SoftWheels`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/SoftWheels.client.lua) <sub>128 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Initialize.server.lua) <sub>695 lines</sub><br>[`Simulated`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/CORSA%20Tire%20System/Simulated.client.lua) <sub>750 lines</sub><br>[`statreaderscript`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/CORSA%20Tire%20System/STATREMOTE/STATREADER/statreaderscript.client.lua) <sub>154 lines</sub><br>[`A-Chassis Tune`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune.lua) <sub>402 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Controls_AC6`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/AC6_Controls_Module/Controls_AC6.client.lua) <sub>159 lines</sub> |
| Tycoon / plots / bases / building | [`Drive`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/A-Chassis%20Interface/Drive.client.lua) <sub>1179 lines</sub> |
| Sound & music | [`TurboSounds_Simple`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/TurboSounds_Simple.client.lua) <sub>67 lines</sub><br>[`Engine_Sounds`](source/scripts/ServerStorage/Vehicles/Saleen%20S7%20%28xxxakioxxx%29/A-Chassis%20Tune/Plugins/Engine_Sounds.client.lua) <sub>229 lines</sub><br>[`AC6_Sounds`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/AC6_Sounds.client.lua) <sub>137 lines</sub><br>[`Shift_Sound`](source/scripts/ServerStorage/Vehicles/25GT%20Turbo%20%28Atsuro%29/A-Chassis%20Tune/Plugins/Shift_Sound.client.lua) <sub>17 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Themes`](source/scripts/ReplicatedStorage/Icon/Features/Themes.lua) <sub>352 lines</sub><br>[`Icon`](source/scripts/ReplicatedStorage/Icon.lua) <sub>1092 lines</sub> |

### In the curated script library

- [Reverb zones (AmbientReverb)](../../Scripts/17-Sound-Music/ReverbZones__hiroshima-expressway.lua) — Turns on SoundService.AmbientReverb (ConcertHall) while the player is inside any invisible TunnelArea part, using a cheap box check on Heartbeat and only changing the property when the state flips.
- [RPM-driven engine sound layers](../../Scripts/17-Sound-Music/EngineSoundsRPM__hiroshima-expressway.lua) — A-Chassis engine sound plugin: four looping layers (exhaust, engine, idle, redline) whose volume, pitch, distortion and EQ are computed from RPM and throttle each time RPM changes.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
