# 13 - Movement

Character movement code from the unpacked games: server-side stamina, sprint with FOV, double jump, dashes (client burst and server cooldown gating), vaulting and ledge hops, a custom climbing system, crouch, ground grip / air control, and several ragdoll implementations (simple Motor6D -> BallSocket swap, combat ragdoll with recovery, Roblox's R15 ragdoll builder, and an 'euphoria' active ragdoll). Camera head-bob lives in `05-Camera-Cutscene` (see FirstPersonBobSway). The `_patterns/` folder has clean sprint+stamina, dash, slide and wall-run modules, which were the things the games did not have in a reusable form.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| `StaminaManager__bite-by-night.lua` | bite-by-night | Best stamina reference: server-side, attribute-based, forward-only drain, regen delay, exhaustion. | Self-contained (no requires). Clients ask to run through a remote that sets the 'Running' attribute. |
| `SprintFovRun__the-rake.lua` | the-rake | Sprint key + mobile button + FOV tween, wired to a server stamina value. | Polls with `while wait()`; expects a StaminaBar with RemoteEvents next to it. |
| `DoubleJump__punching-simulator.lua` | punching-simulator | The standard Roblox double-jump recipe (JumpRequest + Freefall/Landed states). | Line 11 has a typo in the original (`local oldPowerlocal TIME_BETWEEN_JUMPS`) that makes oldPower/TIME_BETWEEN_JUMPS globals - still runs, fix it when copying. |
| `DashVaultFootsteps__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Small all-in-one: camera-direction dash, auto vault over low walls, sprint, footsteps by material. | The Raycast call passes a table instead of RaycastParams (bug). BodyVelocity is deprecated; see _patterns/Dash.lua. |
| `SideBackDashGating__jujutsu-shenanigans.lua` | jujutsu-shenanigans | How a fighting game gates dashes on the server with tags, separate cooldowns and ragdoll-cancel. *(excerpt)* | The physical movement happens on clients ('DashCharacter' replicate event). |
| `LedgeVault__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Name-tagged vault parts: ray check + short velocity burst + random animation. | Runs a `while RenderStepped:Wait()` loop; better to check on Heartbeat with RaycastParams. |
| `CustomClimbing__retro-studio.lua` | retro-studio | Hand-made ladder/truss climbing (rung detection + velocity mover + debug rays). | Expects a `Climbing` BoolValue (with a SetValue remote) inside the character. |
| `CrouchToggle__miami-shootout.lua` | miami-shootout | Crouch: animation speed follows movement, slower walk, no jump. | UI-button driven; add a key bind with ContextActionService. |
| `GroundGripAirControl__smash-egg-for-animals.lua` | smash-egg-for-animals | Tight ground control + momentum-preserving air control by writing AssemblyLinearVelocity. | Comments are in French. Great for high-WalkSpeed simulators where default movement feels slippery. |
| `RagdollModule__steal-a-brainrot.lua` | steal-a-brainrot | Simple, readable ragdoll / unragdoll / timed ragdoll on the server. | Fires a `Ragdoll` RemoteEvent child to the client (see RagdollClient). A few comments are in French. |
| `RagdollClient__steal-a-brainrot.lua` | steal-a-brainrot | Client side of a ragdoll: controls off, Physics state, camera on head, safe unlock. | Pairs with RagdollModule__steal-a-brainrot. |
| `CombatRagdoll__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Ragdoll for combat: timed knockdowns, collider parts, air detection, cancel, stacked-timer handling. | Tied to the game's StunHandler / knockback modules and a Motor6D ObjectValue folder in each character. |
| `EuphoriaRagdoll__gore-game.lua` | gore-game | Active ragdoll: hidden animated rig + springs drive the ragdoll limbs (euphoria look). | Needs Assets.Ragdoll.Muscles.Bones and workspace.Ignored.Muscles; animation ids belong to the game. |
| `buildRagdoll__miami-shootout.lua` | miami-shootout | Roblox's R15 ragdoll builder (entry point). | Needs its two child modules below plus getLastWordFromPascalCase (in the same folder of the original game). |
| `buildRagdollConstraints__miami-shootout.lua` | miami-shootout | Why each joint uses BallSocket vs Hinge and which limits (great comments). | Child of buildRagdoll; needs the constraint templates as its children. |
| `buildRagdollCollisionFilters__miami-shootout.lua` | miami-shootout | Which limb pairs need NoCollisionConstraints in a ragdoll. | Child of buildRagdoll. |
| `LeapAbility__bite-by-night.lua` | bite-by-night | Leap / pounce ability as a movement move with a landing hit. | Uses AbilityUtil / HitboxManager from bite-by-night (see 11-Combat). |
| `_patterns/SprintStamina.lua` | pattern (bite-by-night, the-rake, backrooms-exploration) | Hold-to-sprint with stamina drain/regen delay/exhaustion, FOV change, attributes for UI. | Standalone client module; mirror the rules on the server for competitive games. |
| `_patterns/Dash.lua` | pattern (jujutsu-shenanigans, bite-by-night) | Camera-relative dash with LinearVelocity (horizontal only), ease-out, cooldown, 'Dashing' attribute. | Standalone. Hook OnDash for animation / VFX. |
| `_patterns/Slide.lua` | pattern (backrooms-exploration, miami-shootout, smash-egg-for-animals) | Momentum slide with friction decay, camera dip, animation, cancel on jump. | Standalone. |
| `_patterns/WallRun.lua` | pattern (jujutsu-shenanigans, retro-studio, backrooms-exploration) | Side-wall detection while airborne, run along the wall, jump off, camera roll. | Standalone. Optional wallTag to restrict which walls work. |

## Techniques seen across games

- **Keep movement state in attributes** (`Running`, `Stamina`, `Crouching`, `Ragdoll`, `CanRun`) and tags (`CantDash`, `Stunned`) on the character, so server rules, client feel and UI all read the same source (bite-by-night, jujutsu-shenanigans).
- **Sprint only counts when moving forward:** compare the root's LookVector with the flat velocity (dot >= 0.45) so strafing or backing up does not drain stamina or get sprint speed.
- **Short velocity bursts for dashes and vaults:** a BodyVelocity (old) or LinearVelocity (new) for 0.2-0.3 s removed with Debris, usually with `MaxForce` only on X/Z so gravity still works, and the root turned to face the dash direction.
- **Double jump recipe:** listen to `UserInputService.JumpRequest`, allow the second jump only after entering `Freefall`, force `Humanoid:ChangeState(Jumping)`, reset on `Landed`.
- **Ragdoll = swap Motor6Ds for constraints:** add two Attachments at C0/C1, a BallSocketConstraint (Hinge for neck/root, ankles, wrists) with limits, NoCollisionConstraints, disable the motor, set PlatformStand / Physics state; reverse it to stand up. The client must also disable controls and move the camera subject.
- **Writing AssemblyLinearVelocity directly** gives precise control (no ice-skating, momentum in the air) when the default Humanoid feels wrong at high speeds (NoSlideClient).

## Safety note

Everything here was copied as text for study. Nothing was run. Files that were decompiled, obfuscated, loaded remote code (`require(<asset id>)`, `loadstring`, `getfenv`), or called outside web services were skipped. Asset ids inside the copies (sounds, animations) belong to the original games: replace them with your own.
