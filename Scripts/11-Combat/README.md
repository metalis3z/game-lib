# 11 - Combat

Combat code from the unpacked games, mostly the fighting games (jujutsu-shenanigans, bite-by-night, rivals-modded) plus classic tools: spatial-query hitbox classes, a damage pipeline with block / counter / stun, tag-based stuns, M1 combo and perfect-block logic, an ability kit with parry and charges, server-simulated projectiles, a throwable with retrieval, FastCast bullets, a hitscan gun, explosion physics, the classic sword, and two styles of damage numbers. Server files decide hits and damage; clients only draw. `_patterns/` has clean cooldown, melee-combo and damage-indicator modules.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| `HitboxHandler__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Reusable hitbox class: box/radius query, per-frame or once, hit-once list, closest-only mode. | Needs a `workspace.Live` folder of characters and the game's Utility loop helper (replace with a plain for loop). |
| `DamageHandler__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Central damage function: block from the front only, counters, finishers, stun + hit animation. | The returned {CouldHit, Blocked, Countered, Finisher} table is a great contract to copy. Stats parts are game-specific. |
| `StunHandler__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Tag-based stun: one call blocks every action via CollectionService tags, restored when stuns expire. | Reads `Player.Commands.NoStun` and asset folders; remove those lines. |
| `M1ComboAndBlock__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Combo counter with timeout + block with a perfect-block window. *(excerpt)* | The full original is 1,500 lines; only these two sections were copied. |
| `HitboxManager__bite-by-night.lua` | bite-by-night | Configurable hitbox with Box/Radius/Ray modes, 'continue until found' polling and debug drawing. | Uses `@game/...` string requires (new Luau require-by-path) for Hitbox Settings and ToolKit. |
| `AbilityKitFighter__bite-by-night.lua` | bite-by-night | How an ability framework declares a kit: keybind, cooldown, uses, server callback. | Pairs with Swing / Parry below; AbilityManager (not copied) reads these tables. |
| `SwingAbility__bite-by-night.lua` | bite-by-night | Charge-scaled attack: dash + polling hitbox + stun + stacking debuffs. | Needs AbilityUtil / HitboxManager / ServerUtil from the same game. |
| `ParryAbility__bite-by-night.lua` | bite-by-night | Parry window as an attribute + punishment on a whiff. | Damage code checks the ParryWindow attribute on the target. |
| `AxeThrowAbility__bite-by-night.lua` | bite-by-night | Full throwable: aim, projectile, stick in the world, ProximityPrompt to retrieve, timeout return. | Large and tied to the game's managers; read the state flow (ThrowStart -> ThrowAxe -> ReleaseThrow -> FinishThrow -> RetrieveAxe). |
| `ServerProjectiles__rivals-modded.lua` | rivals-modded | Server projectile simulation: spherecast sweeps, crits, pierce limit, explode on stop, afterburn. | Well commented. Needs GameplayUtility.GetRaycastWhitelist and an ItemService context for damage/explode callbacks. |
| `DamageNumbersToss__rivals-modded.lua` | rivals-modded | Damage numbers that accumulate in place and get tossed away spinning (Rivals look). | Needs a DamageGui template under PlayerScripts.UserInterface and a settings controller. |
| `DamageNumbersTopple__rivals-modded.lua` | rivals-modded | Per-hit numbers that topple over + combo total after a pause. | Same template requirements as the toss version. |
| `FastCastRedux__street-life.lua` | street-life | FastCast Redux API (projectile raycasting library) as shipped inside a game. | Needs its children (ActiveCast, Signal, Table, TypeDefinitions). Get the full library from its official GitHub instead of copying from games. |
| `FastCastBulletTracer__miami-shootout.lua` | miami-shootout | Using FastCast for cosmetic bullets: fire, update the bullet on LengthChanged, handle hits. *(excerpt)* | The impact half of this file is in 06-VFX/BulletImpactAndBloodFX__miami-shootout.lua. |
| `HitscanGunServer__murderers-vs-sheriffs.lua` | murderers-vs-sheriffs | Server hitscan with fire-rate lock and pass-through for invisible parts. | Trusts the client's origin/direction - add distance and angle checks before using it. |
| `ClassicExplosionPhysics__retro-studio.lua` | retro-studio | How the original Roblox explosion worked, ported to Lua with the engine code in comments. | Good for custom explosions that need knockback; swap BodyVelocity for ApplyImpulse in new code. |
| `ClassicSword__retro-studio.lua` | retro-studio | The classic Linked Sword: slash vs lunge damage, Touched hitbox, creator tag. | Uses Touched hits (unreliable for fast swings) and legacy APIs; good to understand the creator-tag convention. |
| `_patterns/Cooldowns.lua` | pattern (jujutsu-shenanigans, bite-by-night) | Timestamp-based cooldowns per owner/action, with charges, extend and reset. | Standalone, server or client. |
| `_patterns/MeleeCombo.lua` | pattern (jujutsu-shenanigans, bite-by-night) | Server M1 combo: combo steps with timeout, box hitbox, front-only block, parry window, stun, finisher knockback. | Standalone server module; clients read ComboStep / Blocking / StunnedUntil attributes for animations. |
| `_patterns/DamageIndicator.lua` | pattern (rivals-modded) | Floating damage numbers that stack per target, crit color, pop and fade - no UI template. | Standalone client module; fire it from a server-confirmed hit remote. |

## Techniques seen across games

- **Spatial queries instead of .Touched.** Hitboxes are `GetPartBoundsInBox` / `GetPartBoundsInRadius` (or ray / spherecast for projectiles) with an OverlapParams include-list of character folders, run once or every Heartbeat for a short window, plus a list of already-hit characters (jujutsu-shenanigans, bite-by-night, rivals-modded). Only the classic sword still uses Touched.
- **One damage function returns what happened** (`{CouldHit, Blocked, Countered, Finisher}`) so the caller decides sounds, VFX and knockback. Blocking is checked with a 'is the attacker in front of me' dot product.
- **States are tags / attributes:** `Stunned`, `Blocking`, `CantPunch`, `CantDash`, `ParryWindow`, `PerfectBlock`, `Ragdolled`. Abilities check them before running, and a stun is just 'add tags, remove them later'.
- **Combo = counter + timestamp:** increment on each swing, reset to 1 if more than ~1.5 s passed or the max was reached; the last hit is the finisher (knockback / ragdoll / different animation).
- **Perfect block / parry are short windows:** an attribute set for 0.25-0.8 s; if a hit lands inside it the defender wins, if the window closes empty the defender is punished (weakness / self-stun).
- **Projectiles:** cosmetic bullets on clients (FastCast LengthChanged), authority on the server (hitscan raycast or server-moved parts with spherecast sweeps), and damage numbers only after the server confirms the hit.

## Safety note

Everything here was copied as text for study. Nothing was run. Files that were decompiled, obfuscated, loaded remote code (`require(<asset id>)`, `loadstring`, `getfenv`), or called outside web services were skipped. Asset ids inside the copies (sounds, animations) belong to the original games: replace them with your own.
