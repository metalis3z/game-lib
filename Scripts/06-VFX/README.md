# 06 - VFX

Visual-effects code from the unpacked games: helper modules that clone an effect template, fire every ParticleEmitter with `:Emit()` and clean the clone up afterwards, ability effects (charge-up, projectile, explosion), limb trails, a procedural black-hole portal, a distance-culled boss aura, screen effects (flashbang, headshot blur/tint) and celebration bursts. Almost all of them expect effect templates (Parts / Attachments with emitters) built in Studio, so read them for the *code pattern*; the `_patterns/` folder has asset-free versions.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| `EffectUtility__bite-by-night.lua` | bite-by-night | Attribute-driven emit helper + Beam transparency tween (keypoint by keypoint). | Drop-in, no dependencies. The beam tween is rare and useful. |
| `VFXLibrary__steal-a-brainrot-sab-files.lua` | steal-a-brainrot-sab-files | Compact VFX library: copy-to-position, follow, rescale, emit by attributes, tag-driven emit loops. | Needs Observers, Timer packages and SharedEventUtils; everything except emitLoop works without them. |
| `ParticleHelpers__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Highest-lifetime lookup, emit all, toggle, scale lifetime, tween model scale. | Drop-in. |
| `FxController__smash-egg-for-animals.lua` | smash-egg-for-animals | Most complete VFX controller: burst, attach-to-part, full-body aura, growing mesh shockwave, projectile, light flash. | Comments are in French. Depends on its `Kit` module (scene folder + low-graphics check) and a `Vfx` template folder. |
| `LimbTrails__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Attach a trail or particle part to a limb for N seconds, then let it fade in place. | Needs the trail templates as children of the module. Uses legacy `spawn`; swap for task.spawn. |
| `ReversalRedAbility__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Reference ability timeline: charge-up tweens -> projectile -> multi-emitter explosion -> knockback. | Server-side and tied to the game's handlers (HitboxHandler, DamageHandler, VoxBreaker). Study the timing. |
| `BarrageArmsBezier__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Bezier-curve ghost arms + tiny shockwave rings for a barrage / rapid punch. | Needs a `bezierCurve` module and 'Arm Shockwave' template; `createShockwave` is reusable as-is. |
| `BlackHolePortal__smash-egg-for-animals.lua` | smash-egg-for-animals | Procedural layered portal (open / close / flare / suck) animated every frame. | Comments are in French. Needs Spiral / Shockwave meshes from its Vfx folder; the layer system is the reusable idea. |
| `BossAuraCulling__smash-egg-for-animals.lua` | smash-egg-for-animals | Client aura manager: idle/run emitter rates, pulsing glow, flickering arcs, distance culling at 8 Hz. | Good model for any NPC aura. Looks for models named 'Void' - change the filter. |
| `HeadshotScreenFX__street-life.lua` | street-life | Hit-confirm screen punch: blur + color correction + small FOV dip. | Expects `Lighting.GunHSBLUR`, `Lighting.GunHSCC` and `_G.FOV`. |
| `FlashbangScreen__miami-shootout.lua` | miami-shootout | Flashbang: white frame in 0.15 s, hold, fade out 3 s, ear ringing. | Needs a 'Flash' ScreenGui with a Frame and ReplicatedStorage.EarRinging. |
| `BulletImpactAndBloodFX__miami-shootout.lua` | miami-shootout | Per-material bullet impacts oriented to the surface normal, tinted to the hit part, plus blood. *(excerpt)* | Data comes from the gun's settings tables (HitEffectData). The long material if-chain could be a table lookup. |
| `FireworkBurst__drill-and-mine.lua` | drill-and-mine | Ring of firework bursts with staged emits and safe sound cleanup. | Needs ReplicatedStorage.Effects.Fireworks1..4 templates. |
| `ConfettiFX__drill-and-mine.lua` | drill-and-mine | Self-contained UI confetti + world burst for rewards / celebrations. | Mostly self-contained; the world burst needs a ParticleEmitter called ConfettiEmitter in Workspace. |
| `LightningDeathEffect__murder-mystery-2.lua` | murder-mystery-2 | Cosmetic death effect as a function(char) module (how MM2 stores death effects). | Pattern: one ModuleScript per death effect returning function(character). |
| `LightningFade__natural-disaster.lua` | natural-disaster | Tiny classic: fade a bolt model out frame by frame. | Legacy API (`wait`, `className`). See _patterns/Lightning.lua for a full version. |
| `_patterns/EffectPlayer.lua` | pattern (bite-by-night, steal-a-brainrot, smash-egg-for-animals) | Clone any effect template to a position or onto a part, emit by attributes, auto cleanup, Stop() for loops. | Standalone. Use the same attribute names (EmitCount / EmitDelay / EmitDuration / Loop) on your templates. |
| `_patterns/ScreenEffects.lua` | pattern (miami-shootout, street-life, steal-a-brainrot) | Flash, color tint pulse, blur pulse and desaturate, safe to call repeatedly. | Standalone, client only. |
| `_patterns/Lightning.lua` | pattern (natural-disaster, jujutsu-shenanigans, murder-mystery-2) | Procedural jagged lightning bolts with branches, light flash and flicker; crackling arcs between parts. | Standalone, no assets. |
| `_patterns/Shockwave.lua` | pattern (jujutsu-shenanigans, smash-egg-for-animals) | Expanding ground ring, expanding sphere, and a crater of rocks that copy the ground's material. | Standalone, no assets. |

## Techniques seen across games

- **Attributes drive emitters.** Artists put `EmitCount`, `EmitDelay`, `EmitDuration` (and sometimes `Loop`) attributes on each ParticleEmitter; one generic function walks `GetDescendants()` and fires them. Seen in bite-by-night, steal-a-brainrot, jujutsu-shenanigans and smash-egg-for-animals.
- **Clone, never edit the template.** Effects are cloned from ReplicatedStorage, positioned (`Attachment.WorldCFrame` or `PivotTo`), and destroyed with `Debris:AddItem(clone, longestLifetime + margin)` where the margin is the highest `Lifetime.Max` among the emitters.
- **Stop, then wait, then destroy** for continuous effects: set `Enabled = false` on emitters/beams/trails, keep the clone alive for one particle lifetime so particles finish naturally, then remove it (LimbTrail un-welds and anchors the trail so it fades in place).
- **Ability effects follow a timeline:** charge (tween Size, Light.Brightness, emitter Rate), release (tweened projectile part + hitbox), impact (multi-emitter explosion part with tuned counts per emitter, light fade, debris/voxels).
- **Screen effects use Lighting post-processing** (BlurEffect, ColorCorrectionEffect, DepthOfField) plus a full-screen Frame for flashes, always with a running flag or token so overlapping calls do not leave the screen stuck.
- **Performance:** culling by distance and only updating every ~0.1 s (VoidVFXClient), and scaling emit counts down on low graphics (FightFilm `Kit.fast()`).

## Safety note

Everything here was copied as text for study. Nothing was run. Files that were decompiled, obfuscated, loaded remote code (`require(<asset id>)`, `loadstring`, `getfenv`), or called outside web services were skipped. Asset ids inside the copies (sounds, animations) belong to the original games: replace them with your own.
