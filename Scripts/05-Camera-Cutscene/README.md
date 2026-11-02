# 05 - Camera & Cutscenes

Camera code pulled from the unpacked games: screen shake (the open-source RbxCameraShaker used by half the games, plus lighter home-made shakes), scripted cutscenes driven by frame tables or by animating a camera rig, lock-on and spectate cameras, first-person head bob / sway, FOV kicks, and jumpscares. Most of these are client-side (LocalScripts or modules required from one). Files ending in `__<game>.lua` are unchanged copies with a short header; `_patterns/` holds clean modules written for this library from the ideas below.

| File | From game | What it does | Reuse notes |
|---|---|---|---|
| `CameraShaker__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Open-source camera shake engine: ShakeOnce, sustained shakes, presets, fade in/out. | Drop-in. Needs the two child modules below (CameraShakeInstance, CameraShakePresets) as children named exactly that. |
| `CameraShakeInstance__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Single shake instance used by CameraShaker (Perlin noise, fade states). | Child of CameraShaker. Read it to understand magnitude vs roughness. |
| `CameraShakePresets__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Ready-made shake presets (Explosion, Earthquake, Bump, Handheld...). | Child of CameraShaker. Add your own presets here. |
| `ShakeCameraWrapper__jujutsu-shenanigans.lua` | jujutsu-shenanigans | How a game wraps CameraShaker into one shared module (one instance, simple API). | Good template: copy the idea, point the require at your CameraShaker. |
| `HumanoidOffsetShake__big-paintball.lua` | big-paintball | Shake without touching Camera.CFrame (uses Humanoid.CameraOffset) + controller vibration. | Depends on their `_L` framework library; replace `_L.Player.Get(...)` with your humanoid/camera. |
| `CombatCameraClient__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Additive decaying shake + head-follow CameraOffset + 'dead cam' offset in one LocalScript. | Uses `shared.loop` and game attributes; the shake math (multiply by 0.85 each step, random sign) is the reusable part. |
| `FrameTableCameraCutscene__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Data-driven cutscenes: per-frame CFrame + FOV tables played at 60 fps relative to a part. | Needs child ModuleScripts that return { [frame] = {cframe=CFrame, fov=number} }. Note the `1 - x ^ dt` smoothing trick. |
| `CameraRigCutscene__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Animate a camera rig with normal animations; camera follows the rig's Cam part; smooth hand-back. | Needs a CameraRig model with AnimationController and a `Cam` part. CameraSmoothOut() is a great reusable function. |
| `CutsceneLock__smash-egg-for-animals.lua` | smash-egg-for-animals | One-cutscene-at-a-time lock + StreamingEnabled support (load what the camera sees). | Comments are in French. Needs a `CutsceneFocus` RemoteEvent and a server script that sets player.ReplicationFocus. |
| `CutsceneDefinitions__bite-by-night.lua` | bite-by-night | Data-driven kill cams / intros / outros (rig + animation + FOV curve per cutscene). | Pure data. Pair it with a player like CameraRigCutscene to get the same setup. |
| `LockOnCamera__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Target lock-on with crosshair picking, left/right switching, line-of-sight break, shoulder offset. | Fairly self-contained (based on a public tutorial). Tune `LockOnInfo` at the top. |
| `HeadFollowCameraOffset__jujutsu-shenanigans.lua` | jujutsu-shenanigans | Camera follows the head during animations (CameraOffset = head relative to root). | Drop-in for R6. Creates a tween per frame; a direct lerp is cheaper. |
| `FirstPersonBobSway__backrooms-exploration.lua` | backrooms-exploration | Best head-bob/sway reference: layered sine + noise offsets with every constant exposed at the top. | Self-contained. Remove the viewmodel / sound parts if you only want the camera feel. |
| `RealismBobAndBodyLook__the-rake.lua` | the-rake | Old but famous: body follows camera pitch + walk bobble via CameraOffset (R6). | Uses globals and deprecated `:connect`; R6 only. Read for the idea, rewrite for production. |
| `JumpscareController__steal-a-brainrot-sab-files.lua` | steal-a-brainrot-sab-files | Full jumpscare: model flies at the camera, shake, flash, color/DOF effects, auto cleanup. | Needs Trove and Net packages and their asset folders; the timing code in the RenderStepped is the reusable part. |
| `DeathJumpscareCam__the-rake.lua` | the-rake | Simplest death cam: Scriptable camera at a fixed part + FOV kick (120 -> 50). | Connects Died inside Changed (a bug: it reconnects many times). Use the idea, not the wiring. |
| `SpectateFollowCam__needoh-escape.lua` | needoh-escape | Clean spectate: freeze input, lerp-follow target, survive respawns, full restore. | Well commented and strict-typed. Needs the 5 RemoteEvents listed at the top. |
| `SpectateCycle__evade.lua` | evade | The simplest spectate: cycle Camera.CameraSubject through a player list. *(excerpt)* | The rest of the original file (troll purchases) was left out. Uses the game's InterfaceController / AnimatedButton. |
| `FovBlurHelper__steal-a-brainrot-sab-files.lua` | steal-a-brainrot-sab-files | Two-function helper to tween FOV and blur. | Drop-in. |
| `OrbitPanCamera__work-at-a-pizza-place.lua` | work-at-a-pizza-place | Orbiting showcase camera with simple wall collision (repeated raycasts ignoring see-through parts). | Old API (FindPartOnRayWithIgnoreList). SetCameraAngle has undefined variables (`zoom`, `foucsPos`) - it is broken, use TweenPan only. |
| `_patterns/CinematicCutscene.lua` | pattern (jujutsu-shenanigans, smash-egg-for-animals) | Plays a list of camera shots with letterbox bars, input freeze, skip button and a smooth hand-back. | Standalone. Shots can be CFrames or functions (look at a moving boss). |
| `_patterns/FovController.lua` | pattern (the-rake, street-life, steal-a-brainrot) | Single owner of FieldOfView: base FOV (sprint), named offsets (aim), and spring FOV punches. | Standalone. Use it instead of many scripts tweening FOV at once. |
| `_patterns/DeathCam.lua` | pattern (bite-by-night, the-rake, needoh-escape) | On death, orbit the body or frame the killer, desaturate, and restore on respawn. | Standalone. Pass getKiller or call Show(body, killer) from a remote. |

## Techniques seen across games

- **Shake = extra CFrame applied after the camera updates.** RbxCameraShaker binds at `Enum.RenderPriority.Camera.Value` and multiplies `camera.CFrame` by a noise-based offset; lighter games write the shake into `Humanoid.CameraOffset` instead, which never fights other camera code.
- **Frame-rate independent smoothing** with `alpha = 1 - k ^ dt` (jujutsu-shenanigans uses `1 - 9e-5 ^ deltaTime`) instead of a fixed lerp factor, so cutscenes look the same at 30 and 240 fps.
- **Two ways to author cutscenes:** export per-frame `{cframe, fov}` tables and play them relative to a part (CameraTableAnims), or animate an invisible camera rig with normal Animations and copy its `Cam` part to the camera (CameraHandler, bite-by-night kill cams).
- **Always hand control back smoothly:** set `CameraType = Custom`, then for ~0.6 s lerp from the last cutscene CFrame to the default camera's CFrame in a RenderStep bound after the camera (`CameraSmoothOut`), and tween FOV back to 70.
- **Guard cutscenes globally:** a lock so two cutscenes never overlap, a timeout that releases it if a script errors, and (with StreamingEnabled) streaming in the area the camera films (CutsceneLock).
- **First-person feel is layers of small offsets:** bob (sine on step phase), breathing (slow sine), sway/tremor (`math.noise`), landing dip, strafe roll and mouse-look lag, each with its own amplitude and smoothing (backrooms-exploration).

## Safety note

Everything here was copied as text for study. Nothing was run. Files that were decompiled, obfuscated, loaded remote code (`require(<asset id>)`, `loadstring`, `getfenv`), or called outside web services were skipped. Asset ids inside the copies (sounds, animations) belong to the original games: replace them with your own.
