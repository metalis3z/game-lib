-- Cinématique "Samouraï contre la horde" : appel téléphonique dans la forêt, vampire, zombie, phantom, pouvoir de feu,
-- puis le boss Headless. Tout est joué côté client par FightFilm.Kit (acteurs, caméra) et FightFilm.Fx (effets de ALL VFX).
-- Les repères de temps sont dans le déroulé (Kit.at(secondes)) : on les change à un seul endroit.
-- Décor : clairière au centre, sentier et lune du côté +X. Positions écrites g(x, z) dans le repère du décor.
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = script.Parent
local Kit = require(film:WaitForChild("Kit"))
local Fx = require(film:WaitForChild("Fx"))
local Cast = require(film:WaitForChild("Cast"))

local M = {}
local V, rgb = Vector3.new, Color3.fromRGB
local rad, sin, cos, clamp = math.rad, math.sin, math.cos, math.clamp
local ORIGIN = V(6000, 300, -7000)
local function g(x, z, y) return ORIGIN + V(x, y or 0, z) end

local MUSIC_CALM, MUSIC_FIGHT = 1848159364, 1838626086
local S = {
	Swing = "rbxasset://sounds/swordslash.wav", Lunge = "rbxasset://sounds/swordlunge.wav", Unsheath = "rbxasset://sounds/unsheath.wav",
	Clang = 9119747138, Thud = "rbxasset://sounds/collide.wav", Ghost = "rbxasset://sounds/HalloweenGhost.wav", Thunder = "rbxasset://sounds/HalloweenThunder.wav",
	Snap = "rbxasset://sounds/snap.wav", Ping = "rbxasset://sounds/electronicpingshort.wav", Fire = 9079463756, Spark = 9116279560,
}
local ORANGE, CYAN, VIOLET, RED, WHITE = rgb(255, 140, 40), rgb(120, 220, 255), rgb(190, 90, 255), rgb(255, 50, 60), rgb(255, 255, 255)

local function merge(a, b)
	local out = {}
	for k, v in a do out[k] = v end
	for k, v in b or {} do out[k] = v end
	return out
end

---------------------------------------------------------------- poses du héros (R15, katana dans la main droite)
-- repère pour la lame : sa pente au-dessus de l'horizontale vaut à peu près RightShoulder.x + RightElbow.x + Grip.x
local H = {}
H.GUARD = {RightShoulder = {45, 0, -10}, RightElbow = {50}, Grip = {-60}, LeftShoulder = {50, 0, 25}, LeftElbow = {60},
	LeftHip = {30, 0, -8}, LeftKnee = {-40}, RightHip = {-16, 0, 10}, RightKnee = {-28}, Waist = {-8, -20, 0}, Root = {0, 20, 0}, Neck = {4}}
H.RUNARM = {RightShoulder = {-25, 0, 22}, RightElbow = {55}, Grip = {-190}}
H.HW = {Root = {0, -25, 0}, Waist = {-6, -45, 4}, RightShoulder = {70, 0, 60}, RightElbow = {80}, Grip = {-80}, LeftShoulder = {40, 0, 10}, LeftElbow = {70},
	RightHip = {20, 0, 6}, RightKnee = {-35}, LeftHip = {-10, 0, -6}, LeftKnee = {-20}, Neck = {4, 30, 0}}
H.HS = {Root = {0, 30, 0}, Waist = {-12, 50, -4}, RightShoulder = {75, 0, -45}, RightElbow = {15}, Grip = {-75}, LeftShoulder = {-25, 0, -30}, LeftElbow = {40},
	LeftHip = {40, 0, -8}, LeftKnee = {-50}, RightHip = {-28, 0, 8}, RightKnee = {-18}, Neck = {6, -35, 0}}
H.VW = {RightShoulder = {165, 0, -5}, RightElbow = {60}, Grip = {-100}, LeftShoulder = {160, 0, 5}, LeftElbow = {70}, Waist = {10}, Neck = {-5},
	LeftHip = {15, 0, -6}, LeftKnee = {-25}, RightHip = {-10, 0, 6}, RightKnee = {-20}}
H.VS = {RightShoulder = {35, 0, -12}, RightElbow = {20}, Grip = {-65}, LeftShoulder = {40, 0, 14}, LeftElbow = {30}, Waist = {-28}, Neck = {18},
	LeftHip = {48, 0, -6}, LeftKnee = {-60}, RightHip = {-30, 0, 6}, RightKnee = {-15}}
H.RW = {Root = {0, 35, 0}, Waist = {-18, 40, 0}, RightShoulder = {20, 0, -50}, RightElbow = {30}, Grip = {-110}, LeftShoulder = {10, 0, -10}, LeftElbow = {50},
	LeftHip = {45, 0, -8}, LeftKnee = {-70}, RightHip = {-20, 0, 8}, RightKnee = {-40}, Neck = {12, -30, 0}}
H.RS = {Root = {0, -20, 0}, Waist = {6, -40, 0}, RightShoulder = {150, 0, 40}, RightElbow = {20}, Grip = {-70}, LeftShoulder = {-20, 0, -30}, LeftElbow = {30},
	LeftHip = {20, 0, -8}, LeftKnee = {-20}, RightHip = {-25, 0, 8}, RightKnee = {-10}, Neck = {-6, 30, 0}}
H.BLOCK = {RightShoulder = {95, 0, -25}, RightElbow = {60}, Grip = {-85, 50, 0}, LeftShoulder = {100, 0, 30}, LeftElbow = {70}, Waist = {-6},
	LeftHip = {35, 0, -8}, LeftKnee = {-50}, RightHip = {-22, 0, 8}, RightKnee = {-35}, Neck = {6}}
H.BLOCKHI = {RightShoulder = {150, 0, -30}, RightElbow = {70}, Grip = {-130, 70, 0}, LeftShoulder = {150, 0, 30}, LeftElbow = {75}, Waist = {8},
	LeftHip = {40, 0, -8}, LeftKnee = {-65}, RightHip = {-25, 0, 8}, RightKnee = {-50}, Neck = {-12}}
H.DUCK = {RightHip = {95, 0, 8}, RightKnee = {-125}, LeftHip = {100, 0, -8}, LeftKnee = {-130}, Waist = {-25}, Neck = {20},
	RightShoulder = {20, 0, 45}, RightElbow = {40}, Grip = {-100}, LeftShoulder = {30, 0, -30}, LeftElbow = {50}}
H.SLIDE = {RightHip = {70}, RightKnee = {-10}, LeftHip = {60, 0, -10}, LeftKnee = {-140}, Waist = {10, 20, 0}, Neck = {10},
	LeftShoulder = {-50, 0, -30}, LeftElbow = {20}, RightShoulder = {30, 0, 40}, RightElbow = {50}, Grip = {-120}}
H.LAND = {RightHip = {85, 0, 10}, RightKnee = {-110}, LeftHip = {30, 0, -10}, LeftKnee = {-120}, Waist = {-20}, Neck = {15},
	LeftShoulder = {20, 0, -40}, LeftElbow = {30}, RightShoulder = {10, 0, 60}, RightElbow = {15}, Grip = {-90}}
H.SKID = {LeftHip = {55, 0, -8}, LeftKnee = {-70}, RightHip = {-35, 0, 8}, RightKnee = {-25}, Waist = {-25, -15, 0}, Neck = {18},
	LeftShoulder = {40, 0, -30}, LeftElbow = {40}, RightShoulder = {30, 0, 30}, RightElbow = {60}, Grip = {-110}}
H.FATIGUE = {Waist = {-22}, Neck = {-10}, RightShoulder = {15, 0, 12}, RightElbow = {20}, Grip = {-60}, LeftShoulder = {10, 0, -10}, LeftElbow = {15},
	LeftHip = {12, 0, -6}, LeftKnee = {-25}, RightHip = {-8, 0, 6}, RightKnee = {-18}}
H.ZANSHIN = {RightShoulder = {40, 0, 75}, RightElbow = {5}, Grip = {-60}, LeftShoulder = {0, 0, -15}, LeftElbow = {25}, Waist = {-4, -25, 0}, Root = {0, 25, 0},
	LeftHip = {22, 0, -10}, LeftKnee = {-30}, RightHip = {-18, 0, 10}, RightKnee = {-12}, Neck = {0, 10, 0}}
H.CHARGE = {RightShoulder = {75, 0, -25}, RightElbow = {95}, Grip = {-80}, LeftShoulder = {70, 0, 28}, LeftElbow = {100}, Waist = {-4}, Neck = {4},
	LeftHip = {22, 0, -8}, LeftKnee = {-30}, RightHip = {-14, 0, 8}, RightKnee = {-22}}
H.IAI = {Root = {0, 35, 0}, Waist = {-30, 30, 0}, RightShoulder = {30, 0, -55}, RightElbow = {70}, Grip = {-200}, LeftShoulder = {10, 0, -5}, LeftElbow = {70},
	LeftHip = {60, 0, -8}, LeftKnee = {-80}, RightHip = {-30, 0, 8}, RightKnee = {-40}, Neck = {25}}
H.IAI_END = {Root = {0, -30, 0}, Waist = {-15, -35, 0}, RightShoulder = {85, 0, 70}, RightElbow = {5}, Grip = {-80}, LeftShoulder = {-20, 0, -20}, LeftElbow = {30},
	LeftHip = {50, 0, -8}, LeftKnee = {-65}, RightHip = {-35, 0, 8}, RightKnee = {-30}, Neck = {10}}
H.AIR_WIND = {RightShoulder = {170, 0, -10}, RightElbow = {50}, Grip = {-90}, LeftShoulder = {165, 0, 10}, LeftElbow = {55}, Waist = {18},
	RightHip = {40}, RightKnee = {-100}, LeftHip = {10}, LeftKnee = {-110}, Neck = {-10}}
H.AIR_STRIKE = {RightShoulder = {30, 0, -10}, RightElbow = {25}, Grip = {-70}, LeftShoulder = {35, 0, 12}, LeftElbow = {30}, Waist = {-35},
	RightHip = {60}, RightKnee = {-60}, LeftHip = {-20}, LeftKnee = {-70}, Neck = {20}}
H.CROUCH = {RightHip = {60, 0, 8}, RightKnee = {-95}, LeftHip = {65, 0, -8}, LeftKnee = {-100}, Waist = {-28}, Neck = {22},
	RightShoulder = {-30, 0, 30}, RightElbow = {40}, Grip = {-150}, LeftShoulder = {-30, 0, -25}, LeftElbow = {40}}

---------------------------------------------------------------- poses des monstres (R6)
local E = {}
E.V_CROUCH = {Root = {-28}, RightHip = {45}, LeftHip = {10}, RightShoulder = {-20, 0, 50}, LeftShoulder = {-20, 0, -50}, Neck = {25}, Cape = {20}}
E.V_WIND = {Root = {-10, -40, 0}, RightShoulder = {-50, 0, 70}, LeftShoulder = {40, 0, -20}, RightHip = {30}, LeftHip = {-15}, Neck = {10, 30, 0}, Cape = {35}}
E.V_CLAW = {Root = {-25, 45, 0}, RightShoulder = {110, 0, -45}, LeftShoulder = {-30, 0, -30}, RightHip = {-20}, LeftHip = {40}, Neck = {20, -30, 0}, Cape = {45}}
E.RECOIL = {Root = {28}, RightShoulder = {-40, 0, 60}, LeftShoulder = {-40, 0, -60}, RightHip = {30}, LeftHip = {-10}, Neck = {-20}, Cape = {-30}}
E.V_BLOCK = {Root = {-5}, RightShoulder = {120, 0, -50}, LeftShoulder = {120, 0, 50}, RightHip = {20}, LeftHip = {-20}, Cape = {10}}
E.V_LEAP = {Root = {-40}, RightShoulder = {160, 0, 20}, LeftShoulder = {160, 0, -20}, RightHip = {-30}, LeftHip = {50}, Neck = {30}, Cape = {60}}
E.Z_RAISE = {RightShoulder = {175, 0, -10}, LeftShoulder = {170, 0, 10}, Root = {14}, Neck = {-10}, RightHip = {10}, LeftHip = {-8}}
E.Z_SLAM = {RightShoulder = {40}, LeftShoulder = {35}, Root = {-40}, Neck = {25}, RightHip = {45}, LeftHip = {-10}}
E.Z_STAGGER = {Root = {-30, 20, 10}, RightShoulder = {50, 0, 60}, LeftShoulder = {-30, 0, -50}, RightHip = {40}, LeftHip = {-15}, Neck = {25, 0, 15}}
E.P_CAST = {RightShoulder = {90, 0, -25}, LeftShoulder = {90, 0, 25}, Root = {-6}, Neck = {8}, Tail1 = {20}, Tail2 = {15}, Tail3 = {10}, Tail4 = {10}}
E.P_WIND = {Root = {-10, -40, 0}, RightShoulder = {-40, 0, 70}, LeftShoulder = {60, 0, -20}, Tail1 = {30}, Tail2 = {20}, Tail3 = {15}, Tail4 = {10}}
E.P_CLAW = {Root = {-28, 45, 0}, RightShoulder = {115, 0, -40}, LeftShoulder = {-20, 0, -40}, Tail1 = {45}, Tail2 = {25}, Tail3 = {15}, Tail4 = {10}}
E.P_RECOIL = {Root = {30}, RightShoulder = {-30, 0, 70}, LeftShoulder = {-30, 0, -70}, Neck = {-20}, Tail1 = {-30}, Tail2 = {-20}, Tail3 = {-10}}
-- Headless (espadon dans la main droite) : pente de la lame = RightShoulder.x + Grip.x
local B = {}
B.IDLE = {RightShoulder = {20, 0, 15}, Grip = {-50}, LeftShoulder = {-5, 0, -12}, Root = {-3}, Cape = {8}}
B.GUARD = {RightShoulder = {70, 0, -10}, Grip = {-30}, LeftShoulder = {60, 0, 25}, Root = {-8, -15, 0}, LeftHip = {25}, RightHip = {-20}, Cape = {14}, Coat = {-10}}
B.HWIND = {Root = {0, -50, 0}, RightShoulder = {60, 0, 70}, Grip = {-60}, LeftShoulder = {40, 0, -20}, RightHip = {20}, LeftHip = {-15}, Cape = {20}}
B.HSTRIKE = {Root = {-10, 60, 0}, RightShoulder = {62, 0, -50}, Grip = {-62}, LeftShoulder = {-30, 0, -40}, LeftHip = {30}, RightHip = {-25}, Cape = {30}, Coat = {-20}}
B.VWIND = {RightShoulder = {170}, LeftShoulder = {165}, Grip = {-60}, Root = {12}, RightHip = {10}, LeftHip = {-10}, Cape = {-10}}
B.VSTRIKE = {RightShoulder = {50, 0, -8}, LeftShoulder = {55, 0, 10}, Grip = {-70}, Root = {-30}, LeftHip = {40}, RightHip = {-25}, Cape = {40}, Coat = {-25}}
B.BLOCK = {RightShoulder = {100, 0, -30}, Grip = {-70, 60, 0}, LeftShoulder = {95, 0, 30}, Root = {6}, LeftHip = {15}, RightHip = {-18}, Cape = {5}}
B.BLOCKHI = {RightShoulder = {150, 0, -35}, LeftShoulder = {150, 0, 35}, Grip = {-150, 70, 0}, Root = {8}, LeftHip = {12}, RightHip = {-12}}
B.RECOIL = {Root = {18, 20, 0}, RightShoulder = {-20, 0, 40}, Grip = {-40}, LeftShoulder = {-30, 0, -40}, RightHip = {25}, LeftHip = {-15}, Cape = {-25}}
B.DASHWIND = {Root = {-25}, RightShoulder = {-30, 0, 30}, Grip = {-150}, LeftShoulder = {40, 0, -10}, RightHip = {45}, LeftHip = {20}, Cape = {25}}
B.THRUST = {Root = {-32}, RightShoulder = {95, 0, -5}, Grip = {-95}, LeftShoulder = {-40, 0, -20}, LeftHip = {50}, RightHip = {-35}, Cape = {65}, Coat = {-30}}
B.DODGE = {Root = {30, -15, 0}, RightShoulder = {30, 0, 40}, Grip = {-40}, LeftShoulder = {-20, 0, -40}, RightHip = {30}, LeftHip = {10}, Cape = {-20}}
B.ROAR = {Root = {18}, RightShoulder = {30, 0, 80}, Grip = {-20}, LeftShoulder = {20, 0, -80}, RightHip = {12}, LeftHip = {-12}, Cape = {-20}}
B.KNEEL = {Root = {-22}, RightHip = {85}, LeftHip = {-75}, RightShoulder = {10, 0, 20}, LeftShoulder = {20, 0, -15}, Cape = {20}}

---------------------------------------------------------------- déroulé
M.Poses = H -- partagées avec les autres films (ReaperFilm)
-- éclairage du film (réglable à un seul endroit)
M.LIGHT = {
	GeographicLatitude = 23, ClockTime = 7.75, Brightness = 1.4,
	Ambient = rgb(58, 68, 118), OutdoorAmbient = rgb(78, 86, 150),
	ColorShift_Top = rgb(120, 160, 255), ColorShift_Bottom = rgb(60, 50, 120),
	ExposureCompensation = 0.15, FogColor = rgb(36, 40, 84), FogStart = 60, FogEnd = 520,
}
function M.play(o)
	o = o or {}
	local scene = film:WaitForChild("Set"):Clone()
	scene.Name = "FightFilmScene"
	scene:PivotTo(CFrame.new(ORIGIN))
	scene.Parent = workspace
	local blockers = {}
	for _, d in scene:GetDescendants() do
		if d:IsA("BasePart") and d:GetAttribute("Blocker") then table.insert(blockers, d) end
	end

	-- éclairage : la « lune » du ciel est basse dans l'axe du sentier, lumière froide, brume bleue
	-- le serveur (cycle jour/nuit) réplique ses propres valeurs pendant le film : on réimpose les nôtres à chaque image
	-- et on retient la dernière valeur reçue, pour la rendre à la fin
	local FILM_LIGHTING = M.LIGHT
	local savedLighting = {}
	for prop in FILM_LIGHTING do savedLighting[prop] = Lighting[prop] end
	local function sameValue(a, b)
		if typeof(a) == "Color3" then return math.abs(a.R - b.R) + math.abs(a.G - b.G) + math.abs(a.B - b.B) < 0.01 end
		return math.abs(a - b) < 0.01
	end
	local function applyLighting()
		for prop, value in FILM_LIGHTING do
			local current = Lighting[prop]
			if not sameValue(current, value) then
				savedLighting[prop] = current
				Lighting[prop] = value
			end
		end
	end
	applyLighting()
	-- les rayons du soleil voilent toute la scène dès que la caméra regarde vers la lune : coupés pendant le film
	local sunRays = Lighting:FindFirstChildOfClass("SunRaysEffect")
	local sunRaysWere = sunRays and sunRays.Enabled
	if sunRays then sunRays.Enabled = false end
	local grade = Instance.new("ColorCorrectionEffect")
	grade.Name = "FightFilmGrade"
	grade.Contrast, grade.Saturation, grade.TintColor = 0.14, 0.12, rgb(236, 240, 255)
	grade.Parent = Lighting
	local gameMusic = SoundService:FindFirstChild("Days")
	local musicWasPlaying = gameMusic and gameMusic.IsPlaying
	if gameMusic then gameMusic:Pause() end

	Kit.begin(scene, blockers)
	if o.ffTo then Kit.ffTo = o.ffTo end
	local loops = {}
	local function loop(id, volume, speed) local s = Kit.snd(id, volume, speed, true) table.insert(loops, s) return s end
	local assets = ReplicatedStorage:FindFirstChild("CutsceneAssets")
	local function asset(name, fallback) return assets and assets:FindFirstChild(name) or fallback end
	local SLASH_HIT, BOOM = asset("SlashSound", S.Swing), asset("BoomSound", S.Thunder)

	local ok, err = pcall(function()
		------------------------------------------------ distribution
		local rigs = ReplicatedStorage:WaitForChild("ReaperCutscene"):WaitForChild("Rigs")
		local rig = rigs:WaitForChild("Rex", 20):Clone()
		-- la peau blanche de l avatar sature sous les lumières du décor (mains comme du néon) : un ton plus bas, le temps du film
		for _, p in rig:GetChildren() do
			if p:IsA("MeshPart") and p.Name ~= "Head" and p.Color.R > 0.9 and p.Color.G > 0.9 and p.Color.B > 0.9 then p.Color = rgb(176, 172, 186) end
		end
		rig.Parent = scene
		local hrp0 = rig.HumanoidRootPart
		local function rel(part, att) return hrp0.CFrame:PointToObjectSpace(rig[part][att].WorldPosition) end
		local SH, EL = rel("RightUpperArm", "RightShoulderRigAttachment"), rel("RightLowerArm", "RightElbowRigAttachment")
		local HAND = hrp0.CFrame:PointToObjectSpace(rig.RightHand.Position)
		local hero = Kit.actor(rig, "Hero")
		local hand = rig.RightHand
		-- où arrive la main droite pour des angles donnés (repère du buste), et recherche des angles pour atteindre un point
		local function handAt(sx, sy, sz, ex)
			return SH + CFrame.Angles(rad(sx), rad(sy), rad(sz)):VectorToWorldSpace((EL - SH) + CFrame.Angles(rad(ex), 0, 0):VectorToWorldSpace(HAND - EL))
		end
		local function reach(target)
			local best, bestD = {0, 0, 0, 0}, math.huge
			for sx = -60, 190, 10 do for sz = -120, 110, 10 do for sy = -60, 60, 20 do for ex = 0, 140, 10 do
				local d = (handAt(sx, sy, sz, ex) - target).Magnitude + math.abs(sy) * 0.002
				if d < bestD then best, bestD = {sx, sy, sz, ex}, d end
			end end end end
			return {RightShoulder = {best[1], best[2], best[3]}, RightElbow = {best[4]}}, bestD
		end

		-- fourreau à la hanche gauche, poignée vers l'avant ; katana rangé dedans
		local scab, scabRoot = Cast.scabbard()
		scab.Parent = scene
		local sw = Instance.new("Weld")
		sw.Part0, sw.Part1 = rig.LowerTorso, scabRoot
		sw.C0 = CFrame.new(-0.8, 0.12, -0.3) * CFrame.Angles(0, rad(155), 0) * CFrame.Angles(rad(-18), 0, 0)
		sw.Parent = scabRoot
		local katana, kRoot, blade = Cast.katana()
		katana.Parent = scene
		local kw = Instance.new("Weld")
		kw.Part0, kw.Part1 = scabRoot, kRoot
		kw.Parent = kRoot
		local gripAtt = hand:FindFirstChild("RightGripAttachment")
		local gripBase, gripTail = CFrame.new(gripAtt and gripAtt.Position or V(0, -0.1, -0.1)), CFrame.new(-Cast.KATANA_GRIP)
		local held, blend, aim = false, nil, nil
		hero.joints.Grip = function(cf)
			if not held then return end
			local target = gripBase * cf * gripTail
			if aim then -- lames croisées : la lame vise un point du monde au lieu de suivre la pose
				local from = (hand.CFrame * gripBase).Position
				target = target:Lerp(hand.CFrame:ToObjectSpace(CFrame.lookAt(from, aim.point(), aim.up) * gripTail), aim.w)
			end
			if blend then
				local u = clamp((Kit.time - blend.t0) / blend.dur, 0, 1)
				target = blend.from:Lerp(target, u * u * (3 - 2 * u))
				if u >= 1 then blend = nil end
			end
			kw.C0 = target
		end
		hero.val.Grip = {0, 0, 0}
		local function grab(dur) -- le katana passe du fourreau à la main sans saut
			local world = kRoot.CFrame
			kw.Part0 = hand
			blend = {from = hand.CFrame:ToObjectSpace(world), t0 = Kit.time, dur = dur or 0.25}
			kw.C0 = blend.from
			held = true
		end
		local function sheath(dur) -- et retourne dans le fourreau
			local from = scabRoot.CFrame:ToObjectSpace(kRoot.CFrame)
			held = false
			kw.Part0 = scabRoot
			kw.C0 = from
			Kit.tween(dur or 0.4, function(e) kw.C0 = from:Lerp(CFrame.new(), e) end, "inOut")
		end
		local function aimKatana(point, up, dur)
			if point then
				local a = {point = point, up = up or V(0, 1, 0), w = 0}
				aim = a
				Kit.tween(dur or 0.1, function(e) a.w = e end, "outQuad")
			elseif aim then
				local a = aim
				Kit.tween(dur or 0.15, function(e) a.w = 1 - e end, "inOut", function() if aim == a then aim = nil end end)
			end
		end
		local trail = Fx.bladeTrail(blade, V(0, 0, 1.6), V(0, 0, -2.1), rgb(210, 240, 255))
		local function tip(back) return (blade.CFrame * CFrame.new(0, 0, -(back or 1.2))).Position end

		-- téléphone
		local phone, phoneRoot = Cast.phone()
		phone.Parent = scene
		local pw = Instance.new("Weld")
		pw.Part0, pw.Part1 = hand, phoneRoot
		pw.Parent = phoneRoot

		local function spawn(kind, pos, facing, seed)
			local model, welds, extra = Cast[kind]()
			model.Parent = scene
			local a = Kit.actor(model, kind)
			for name, weld in welds or {} do a:addWeldJoint(name, weld) end
			a:place(pos, facing)
			a.seed = seed or 0
			a.extra = extra
			return a
		end

		------------------------------------------------ petits outils de mise en scène
		local X = {} -- outils et repères ajoutés au fil du film, sous un seul nom local
		local function dust(pos, scale) Fx.burst("Smoke-01", pos + V(0, 0.4, 0), {scale = scale or 0.6}) end
		local function leaves(pos, n) -- quelques feuilles mortes soulevées
			if Kit.fast() then return end
			for i = 1, n or 4 do
				local p = Instance.new("Part")
				p.Size = V(0.5, 0.05, 0.4)
				p.Color = ({rgb(190, 86, 20), rgb(140, 60, 16), rgb(214, 130, 30)})[i % 3 + 1]
				p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
				p.Parent = scene
				local a = math.random() * 6.283
				local to = pos + V(cos(a) * (1.5 + math.random() * 2), 0.1, sin(a) * (1.5 + math.random() * 2))
				local spin = CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
				local h = 1.2 + math.random() * 1.6
				Kit.tween(0.7 + math.random() * 0.4, function(e, u)
					p.CFrame = CFrame.new(pos:Lerp(to, e) + V(0, h * 4 * u * (1 - u), 0)) * spin * CFrame.Angles(u * 9, u * 7, 0)
				end, "outQuad", function() p:Destroy() end)
			end
		end
		-- anneau qui s'ouvre dans le plan du coup (le « swoosh » d'un sabre)
		local function swoosh(pos, normal, color, size, time)
			local cf = CFrame.lookAt(pos, pos + normal) * CFrame.Angles(rad(90), 0, 0)
			Fx.mesh("Shock", cf, {color = color or WHITE, size0 = 0.25 * (size or 1), size1 = 1.5 * (size or 1), time = time or 0.22, transp0 = 0.15})
		end
		local function ring(pos, color, size, time)
			Fx.mesh("Shockwave", CFrame.new(pos + V(0, 0.4, 0)), {color = color or WHITE, size0 = 0.2, size1 = size or 3, time = time or 0.5, transp0 = 0.2})
		end
		-- contact de deux lames : étincelles, éclair, son, secousse, arrêt sur image
		local function clash(pos, power, color)
			power = power or 1
			Fx.burst("Slash-Impact-01", pos, {scale = 0.8 * power, color = color})
			Fx.burst("Punch-01", pos, {scale = 1.4 * power})
			Fx.light(pos, color or rgb(255, 230, 170), 18 * power, 6, 0.3)
			Kit.snd(S.Clang, 0.55 + 0.2 * power, 0.9 + math.random() * 0.25)
			Kit.shake(0.35 * power)
			Kit.hitstop(0.05 + 0.03 * power)
		end
		-- coup qui touche un monstre
		local function wound(target, pos, power, color)
			power = power or 1
			Fx.burst("Slash-Impact-01", pos, {scale = 1.1 * power, color = color})
			Fx.burst("Slashes-01", pos, {scale = 0.9 * power})
			Fx.light(pos, color or WHITE, 16 * power, 5, 0.3)
			Kit.snd(SLASH_HIT, 0.7, 0.95 + math.random() * 0.2)
			target:hit(1.2 * power)
			Kit.shake(0.45 * power)
			Kit.punch(-5 * power)
			Kit.hitstop(0.06 + 0.04 * power)
		end
		-- un coup de katana : élan, coupe, puis `hit` au moment où la lame passe
		local function slash(windup, strike, opts)
			opts = opts or {}
			if windup then
				hero:to(windup, opts.wind or 0.13, "outCubic")
				Kit.wait(opts.wind or 0.13)
			end
			trail.Enabled = true
			Kit.snd(S.Swing, 0.5, 1 + math.random() * 0.25)
			hero:to(strike, opts.cut or 0.09, "outQuart", {lag = false})
			Kit.wait((opts.cut or 0.09) * 0.55)
			swoosh(hero:center(0.6) + (CFrame.Angles(0, hero.yaw, 0) * V(0, 0, -2.2)), opts.normal or V(0.15, 1, 0), opts.color, opts.size)
			if opts.hit then opts.hit() end
			Kit.wait((opts.cut or 0.09) * 0.45)
			Kit.delay(0.14, function() trail.Enabled = false end)
		end
		-- course du héros, sabre traînant derrière lui
		local function run(to, dur, ease)
			hero.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, RightWrist = true}
			hero:to(H.RUNARM, 0.12, "outQuad", {only = true})
			hero:gait("heroRun", 0.1, function() leaves(hero.pos, 2) end)
			hero:move(to, dur, ease or "inOut", {face = true, faceTime = 0.12})
			Kit.wait(dur)
			hero:gait(nil, 0.1)
		end
		-- dash : silhouettes fantômes, vent, traits de vitesse
		local function dash(actor, to, dur, color, lines)
			Kit.snd(S.Lunge, 0.5, 1.1)
			if lines then Kit.speedLines(dur + 0.2, 0.5) end
			Fx.burst("Wind-02", actor:center(-1), {scale = 1.2 * actor.scale})
			actor:move(to, dur, "outCubic")
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				Kit.ghost(actor, color, 0.3, 0.5)
				Kit.wait(math.min(dur / 4, math.max(dur - (Kit.time - t0), 0.001)))
			end
			dust(to, 0.7 * actor.scale)
		end
		-- repoussé par un choc : il glisse en arrière sur `dist` studs, les pieds labourent le sol
		function X.skid(actor, from, dist, dur, pose)
			local away = (actor.pos - from) * V(1, 0, 1)
			away = away.Magnitude > 0.05 and away.Unit or V(-1, 0, 0)
			local to = actor.pos + away * dist
			dur = dur or 0.45
			if pose then actor:to(pose, 0.12, "outQuad") end
			actor:move(to, dur, "outCubic")
			Kit.fork(function()
				for _ = 1, math.max(3, math.floor(dur / 0.07)) do
					Kit.wait(0.07)
					dust(actor.pos, 0.55 * actor.scale)
					leaves(actor.pos, 1)
				end
			end)
			return to
		end
		-- ruée du héros : bien plus vite qu'une course, avec silhouettes, vent et traits de vitesse
		function X.rush(to, dur, color)
			hero.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, RightWrist = true}
			hero:to(H.RUNARM, 0.08, "outQuad", {only = true})
			hero:gait("heroRun", 0.06, function() dust(hero.pos, 0.5) leaves(hero.pos, 2) end)
			Kit.speedLines(dur + 0.15, 0.6)
			Kit.snd(S.Lunge, 0.5, 1.2)
			Fx.burst("Wind-02", hero:center(-1), {scale = 1.2})
			hero:move(to, dur, "inOut", {face = true, faceTime = 0.08})
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				Kit.ghost(hero, color or CYAN, 0.28, 0.55)
				Kit.wait(math.min(0.045, math.max(dur - (Kit.time - t0), 0.001)))
			end
			hero:gait(nil, 0.08)
		end
		-- rend peu à peu une articulation à l'allure (pas de saut quand un geste se termine pendant la marche)
		function X.release(actor, names, dur)
			local mask = actor.gaitMask
			if not mask then return end
			Kit.tween(dur or 0.3, function(e)
				for _, name in names do if mask[name] then mask[name] = 1 - e end end
			end, "inOut", function()
				for _, name in names do mask[name] = nil end
			end)
		end
		-- coup qui touche sans arrêt sur image : pour les enchaînements qui ne doivent pas marquer de pause
		function X.cut(target, pos, power, color)
			power = power or 1
			Fx.burst("Slash-Impact-01", pos, {scale = 1.1 * power, color = color})
			Fx.burst("Slashes-01", pos, {scale = 0.9 * power})
			Fx.light(pos, color or WHITE, 16 * power, 5, 0.3)
			Kit.snd(SLASH_HIT, 0.7, 0.95 + math.random() * 0.2)
			target:hit(1.2 * power)
			Kit.shake(0.3 * power)
		end
		-- plan large en plongée : cadre tous les acteurs donnés, de haut et d'assez loin pour lire qui frappe qui
		-- angle = côté d'où l'on regarde (degrés), height = hauteur de la caméra, drift = lente rotation
		function X.wide(actors, angle, height, extra, drift)
			return function(t)
				local sum, count = Vector3.zero, 0
				for _, a in actors do if a.alive then sum += a.pos count += 1 end end
				local mid = count > 0 and sum / count or hero.pos
				local reach = 0
				for _, a in actors do if a.alive then reach = math.max(reach, ((a.pos - mid) * V(1, 0, 1)).Magnitude) end end
				local ang = rad(angle) + (drift or 0) * t
				local dist = math.min(9 + reach * 1.5 + (extra or 0), 24)
				return Kit.look(V(mid.X + cos(ang) * dist, ORIGIN.Y + (height or 7), mid.Z + sin(ang) * dist), V(mid.X, ORIGIN.Y + 1.6, mid.Z), 50)
			end
		end
		-- la suite du film est décalée de la durée de la deuxième vague
		X.WAVE2 = 20
		function X.at(t) Kit.at(t + X.WAVE2) end
		-- projection d'un monstre : il vole, tombe à plat et se dissout
		local function vanish(actor, color, wait)
			Kit.delay(wait or 0.5, function()
				Fx.burst("Smoke-01", actor:center(), {scale = 1.4 * actor.scale})
				Fx.burst("Stars-01", actor:center(), {scale = 1.2, color = color})
				actor:fade(0, 0.45)
				Kit.delay(0.5, function() actor:destroy() end)
			end)
		end
		local function launch(actor, to, dur, arc, back, color)
			actor:gait(nil, 0.05)
			actor.idle = 0
			actor:to(E.RECOIL, 0.1, "outQuad")
			actor:body({air = 1}, 0.05)
			actor:move(to, dur, "outQuad", {arc = arc})
			actor:body({pitch = back and 1.45 or -1.45, lift = -(actor.stand - 0.6 * actor.scale)}, dur, "inQuad")
			Kit.delay(dur, function()
				dust(to, 1.1 * actor.scale)
				leaves(to, 5)
				Kit.snd(S.Thud, 0.5, 0.7)
				Kit.shake(0.25)
			end)
			vanish(actor, color, dur + 0.45)
		end
		-- plan sur deux personnages, caméra sur le côté qui tourne lentement
		local function twoShot(a, b, side, dist, height, fov, drift, aim)
			return function(t)
				local pa, pb = a:center(0.4), b:center(0.4)
				local mid = (pa + pb) / 2
				local dir = (pb - pa) * V(1, 0, 1)
				local d = dir.Magnitude
				dir = d > 0.1 and dir.Unit or V(1, 0, 0)
				local perp = V(-dir.Z, 0, dir.X) * side
				local ang = (drift or 0) * t
				local off = (perp * cos(ang) + dir * sin(ang)) * ((dist or 6) + 6 + d * 0.75)
				return Kit.look(V(mid.X, ORIGIN.Y + (height or 2.5), mid.Z) + off, mid + V(0, aim or 0.2, 0), fov or 50)
			end
		end
		Kit.camSubject = function() return hero:center(1) end

		------------------------------------------------ ambiance : chauves-souris, citrouilles qui vacillent, feux follets
		local flickerAmp, flickers, bats, wisps = 1, {}, {}, {}
		local grassBlades = {}
		for _, d in scene:GetDescendants() do
			if d:IsA("PointLight") and d.Name == "Flicker" then table.insert(flickers, {d, d.Brightness, math.random() * 50})
			elseif d:IsA("Model") and d.Name == "Bat" then table.insert(bats, d)
			elseif d:IsA("BasePart") and d.Name == "Wisp" then table.insert(wisps, {d, d.Position})
			elseif d:IsA("BasePart") and d.Name == "Blade" and d.Parent.Name == "Grass" then table.insert(grassBlades, d) end
		end
		-- lumière d'appoint froide, placée près de la caméra : on voit les visages même à contre-jour
		local fill = Instance.new("Part")
		fill.Name = "FillLight"
		fill.Size = V(1, 1, 1)
		fill.Transparency = 1
		fill.Anchored, fill.CanCollide, fill.CanQuery, fill.CanTouch = true, false, false, false
		fill.Parent = scene
		local fillLight = Instance.new("PointLight")
		fillLight.Color, fillLight.Range, fillLight.Brightness, fillLight.Shadows = rgb(200, 215, 255), 46, 0.9, false
		fillLight.Parent = fill
		Kit.fork(function()
			while Kit.running do
				local t = Kit.time
				applyLighting()
				local camCF = workspace.CurrentCamera.CFrame
				fill.CFrame = camCF * CFrame.new(0, 1.5, 2)
				-- un brin d herbe collé à l objectif masque toute l image : on efface ceux qui sont trop près
				for _, b in grassBlades do
					local near = (b.Position - camCF.Position).Magnitude < 5
					if near ~= (b.LocalTransparencyModifier == 1) then b.LocalTransparencyModifier = near and 1 or 0 end
				end
				for _, f in flickers do f[1].Brightness = f[2] * (0.8 + 0.2 * math.noise(t * 4, f[3])) * (1 + (flickerAmp - 1) * (0.5 + 0.5 * sin(t * 23 + f[3]))) end
				for _, bat in bats do
					local r, h, sp, ph = bat:GetAttribute("Radius"), bat:GetAttribute("Height"), bat:GetAttribute("Speed"), bat:GetAttribute("Phase")
					local a = ph + t * sp
					local pos = g(cos(a) * r, sin(a) * r, h + sin(t * 1.3 + ph) * 3)
					local cf = CFrame.lookAt(pos, pos + V(-sin(a) * sp, 0, cos(a) * sp))
					local flap = sin(t * 16 + ph) * 0.9
					bat.Body.CFrame = cf
					bat.WingR.CFrame = cf * CFrame.new(0.3, 0, 0) * CFrame.Angles(0, 0, flap) * CFrame.new(0.85, 0, 0)
					bat.WingL.CFrame = cf * CFrame.new(-0.3, 0, 0) * CFrame.Angles(0, 0, -flap) * CFrame.new(-0.85, 0, 0)
				end
				for i, w in wisps do w[1].CFrame = CFrame.new(w[2] + V(sin(t * 0.6 + i) * 2, sin(t * 1.1 + i * 2) * 1.2, cos(t * 0.5 + i) * 2)) * CFrame.Angles(t, t * 1.3, 0) end
				task.wait()
			end
		end)

		------------------------------------------------ deuxième vague (20 s), jouée entre la première horde et le Headless
		-- deux vampires sur les flancs, trois zombies de front, un phantom au fond ; tourbillon de vent, puis lame d'eau
		function X.wave2()
			local T = 38.0
			local function at(dt) Kit.at(T + dt) end
			local GREEN, BLUE = rgb(140, 255, 90), rgb(90, 170, 255)
			local SPIN = {RightShoulder = {88, 0, 55}, RightElbow = {6}, Grip = {-85}, LeftShoulder = {50, 0, -60}, LeftElbow = {20}, Waist = {-10},
				LeftHip = {40, 0, -10}, LeftKnee = {-70}, RightHip = {-20, 0, 12}, RightKnee = {-35}, Neck = {8}}
			-- un zombie renversé, qui se relèvera
			local function knockdown(z, to, dur, arc)
				z:gait(nil, 0.05)
				z.idle = 0
				z:to(E.RECOIL, 0.1, "outQuad")
				z:body({air = 1}, 0.05)
				z:move(to, dur, "outQuad", {arc = arc})
				z:body({pitch = 1.45, lift = -(z.stand - 0.6 * z.scale)}, dur, "inQuad")
				Kit.delay(dur, function() dust(to, 1.1) leaves(to, 5) Kit.snd(S.Thud, 0.5, 0.7) Kit.shake(0.25) end)
			end
			local function getUp(z, dur)
				z:body({pitch = 0, lift = 0}, dur, "inOut")
				z:to(E.Z_STAGGER, dur * 0.7, "inOut")
				Kit.delay(dur, function() z:body({air = 0}, 0.1) z.idle = 1 end)
			end

			-- 0 s : un bruit, puis ils sortent de tous les côtés
			at(0)
			hero:watch(nil)
			flickerAmp = 2.4
			Kit.snd(S.Snap, 0.7, 0.6) Kit.snd(S.Ghost, 0.6, 0.6)
			Kit.cam(function(t) return Kit.look(hero:point(5.2, 1.8, 3.5), hero:center(1.0), 36) end, 0.4)
			hero:to(merge(H.GUARD, {Neck = {4, 35, 0}}), 0.35, "outBack")
			local z3, z4, z5 = spawn("zombie", g(-17, -6), g(4, -4), 21), spawn("zombie", g(-19, 1), g(2.5, 0.5), 23), spawn("zombie", g(-16, 8), g(4, 5), 25)
			local v3, v4 = spawn("vampire", g(3, -27), g(11, -11), 27), spawn("vampire", g(6, 27), g(13, 11), 29)
			local p2 = spawn("phantom", g(-14, -1), g(12, 0), 31)
			p2.lift = 5.5
			p2:gait("phantomFloat", 0)
			for _, a in {z3, z4, z5, v3, v4, p2} do a:setVisible(0) a:fade(1, 0.6) a:watch(hero) end
			z3:gait("zombieShamble", 0.1, function() dust(z3.pos, 0.3) end) z3:move(g(4, -4), 6.9, "linear")
			z4:gait("zombieShamble", 0.1, function() dust(z4.pos, 0.3) end) z4:move(g(2.5, 0.5), 6.9, "linear")
			z5:gait("zombieShamble", 0.1, function() dust(z5.pos, 0.3) end) z5:move(g(4, 5), 6.9, "linear")
			v3:gait("vampireSprint", 0.1) v3:move(g(11, -11), 1.2, "outQuad")
			v4:gait("vampireSprint", 0.1) v4:move(g(13, 11), 1.4, "outQuad")
			at(0.55) -- il revient au centre de la clairière d'un trait : dix-huit studs
			Kit.cam(function(t) return Kit.look(g(25 - 0.5 * t, -17, 9), g(4, 0, 1), 54) end, 0.4)
			X.rush(g(12, 0), 0.42, CYAN)
			hero:face(g(0, 0), 0.15)
			hero:to(H.GUARD, 0.3, "outBack")
			dust(hero.pos, 0.8)
			at(1.25)
			v3:gait(nil, 0.1) v3:to(E.V_CROUCH, 0.25, "outBack") Kit.snd(S.Ghost, 0.4, 2.2)
			Kit.cam(function(t) local a = -2.2 + 0.4 * t return Kit.look(hero.pos + V(cos(a) * 12.5, 3.4, sin(a) * 12.5), hero:center(0.4), 52) end, 0.4)
			hero:watch(v3)
			at(1.45) v4:gait(nil, 0.1) v4:to(E.V_CROUCH, 0.25, "outBack") Kit.snd(S.Ghost, 0.4, 2.4)
			at(1.75) hero:watch(v4)

			-- 2,2 s : les deux vampires, l'un après l'autre
			at(2.2)
			hero:watch(v3) hero:face(v3, 0.15)
			hero:to(H.BLOCK, 0.2, "outQuad")
			Kit.cam(twoShot(hero, v3, -1, 5, 2.2, 50, 0.12), 0.2)
			v3:gait("vampireSprint", 0.06, function() leaves(v3.pos, 2) end)
			v3:move(g(11.8, -2.6), 0.4, "inQuad")
			Kit.snd(S.Lunge, 0.5, 0.8)
			Kit.fork(function() for _ = 1, 4 do Kit.wait(0.09) Kit.ghost(v3, RED, 0.28, 0.6) end end)
			at(2.56) v3:gait(nil, 0.05) v3:to(E.V_CLAW, 0.08, "outQuart", {lag = false})
			at(2.64) -- griffes contre lame : le vampire repart en glissade sur dix studs
			clash(tip(0.8), 1.3, RED)
			hero:hit(0.5)
			X.skid(v3, hero.pos, 10, 0.5, E.RECOIL)
			at(2.8) -- le second arrive dans son dos
			v4:gait("vampireSprint", 0.06, function() leaves(v4.pos, 2) end)
			v4:move(g(12.2, 3.2), 0.36, "inQuad")
			Kit.snd(S.Ghost, 0.45, 2.5)
			Kit.fork(function() for _ = 1, 4 do Kit.wait(0.08) Kit.ghost(v4, RED, 0.28, 0.6) end end)
			Kit.cam(twoShot(hero, v4, 1, 6, 2.0, 52, -0.15), 0.2)
			at(3.06) -- il s'efface d'un pas chassé, déjà armé
			hero:watch(nil)
			hero:to(H.HW, 0.12, "outQuad")
			hero:move(g(8.2, 1.6), 0.16, "outCubic")
			hero:face(g(12.2, 3.2), 0.12)
			Kit.ghost(hero, CYAN, 0.25, 0.6)
			at(3.16) v4:gait(nil, 0.05) v4:to(E.V_CLAW, 0.08, "outQuart", {lag = false}) swoosh(v4:point(2, 0, 1.2), V(0.3, 1, 0), RED, 0.8) Kit.snd(S.Swing, 0.4, 1.5)
			at(3.26)
			slash(nil, H.HS, {hit = function()
				wound(v4, v4:center(0.8), 1.1)
				v4:to(E.RECOIL, 0.1, "outQuad")
				v4:body({air = 1}, 0.05)
				v4:move(g(20.5, 2.6), 0.55, "outCubic", {arc = 2.2}) -- projeté à dix studs
				Kit.delay(0.55, function() v4:body({air = 0}, 0.06) v4:to(E.V_CROUCH, 0.3, "outBack") dust(v4.pos, 0.9) Kit.snd(S.Thud, 0.4, 0.9) end)
			end})
			v3:to(E.V_CROUCH, 0.3, "outBack")
			at(3.75) -- il fond sur le premier avant qu'il se relève
			Kit.cam(twoShot(hero, v3, -1, 6, 1.6, 52, 0.1), 0.2)
			X.rush(v3.pos + (hero.pos - v3.pos).Unit * V(1, 0, 1) * 2.6, 0.2, CYAN)
			v3:to(E.V_BLOCK, 0.08, "outQuad")
			slash(H.HW, H.HS, {wind = 0.08, size = 1.4, hit = function()
				wound(v3, v3:center(0.8), 1.6)
				ring(v3.pos, WHITE, 2.4, 0.4)
				Kit.flash(0.15, WHITE, 0.4)
				launch(v3, g(3, -19), 0.6, 2.4, false, RED)
			end})
			at(4.45) hero:to(H.ZANSHIN, 0.25, "outBack")
			at(4.6) -- l'autre s'est relevé : ils se jettent l'un sur l'autre
			Kit.snd(S.Ghost, 0.5, 2.6)
			hero:watch(v4) hero:face(v4, 0.2)
			hero:to(H.IAI, 0.32, "inOut")
			v4:to(merge(E.V_CROUCH, {Root = {-36}, RightShoulder = {-30, 0, 70}, LeftShoulder = {-30, 0, -70}, Cape = {35}}), 0.3, "inOut")
			Kit.cam(twoShot(hero, v4, 1, 4, 3.4, 52, 0), 0.25)
			at(5.02)
			X.a, X.b = hero.pos, v4.pos
			v4:gait("vampireSprint", 0.05)
			v4:move(X.a + (X.b - X.a).Unit * 1.2, 0.2, "inQuad")
			Kit.fork(function() for _ = 1, 4 do Kit.ghost(v4, RED, 0.3, 0.55) Kit.wait(0.05) end end)
			at(5.08)
			Kit.speedLines(0.3, 0.7) Kit.flash(0.2, WHITE, 0.7)
			Kit.snd(S.Lunge, 0.8, 1.2) Kit.snd(SLASH_HIT, 0.8, 0.9)
			trail.Enabled = true
			hero:to(H.IAI_END, 0.1, "outQuart", {lag = false})
			hero:move(X.b - (X.b - X.a).Unit * 1.2, 0.14, "outCubic")
			for _ = 1, 4 do Kit.ghost(hero, CYAN, 0.35, 0.45) Kit.wait(0.035) end
			do
				local mid = (X.a + X.b) / 2 + V(0, 2.6, 0)
				Fx.mesh("Shock", CFrame.lookAt(mid, mid + (X.b - X.a).Unit) * CFrame.Angles(0, 0, rad(-20)) * CFrame.Angles(rad(90), 0, 0), {color = WHITE, size0 = 0.5, size1 = 3.6, time = 0.35, transp0 = 0})
			end
			Kit.hitstop(0.1)
			at(5.3) -- dos à dos
			trail.Enabled = false
			v4:gait(nil, 0.05) v4:to(E.V_CLAW, 0.1) v4.idle = 0
			hero:watch(nil)
			Kit.cam(function(t) local d = (X.b - X.a).Unit return Kit.look(hero.pos + d * 10 + V(-d.Z, 0, d.X) * 4.5 + V(0, 3.2, 0), hero:center(0.5):Lerp(v4:center(0.5), 0.6), 44) end, 0.2) -- lui devant, le vampire figé derrière
			at(5.85)
			wound(v4, v4:center(0.6), 1.2, RED)
			Kit.delay(0.09, function() wound(v4, v4:center(1.3), 1.4, RED) v4:to(E.RECOIL, 0.12) end)
			vanish(v4, RED, 0.35)
			at(6.15) hero:to(merge(H.ZANSHIN, {RightShoulder = {20, 0, 60}, Grip = {-95}}), 0.12, "outQuart") Kit.snd(S.Swing, 0.3, 1.6)

			-- 6,4 s : les trois zombies ; il plonge au milieu et tourne sur lui-même, la lame à l'horizontale
			at(6.4)
			Kit.cam(function(t) return Kit.look(g(25.5 + 0.3 * t, 5.4, 3.6), g(2, 0.5, 2.0), 40) end, 0.3)
			hero:face(g(3, 0), 0.3)
			hero:to(H.GUARD, 0.3, "outBack")
			hero:watch(z4)
			Kit.snd(S.Ghost, 0.55, 0.45)
			at(6.95)
			for _, z in {z3, z4, z5} do z:gait(nil, 0.2) z:face(hero, 0.3) z:to(E.Z_RAISE, 0.55, "inOut") end
			at(7.2)
			Kit.cam(function(t) return Kit.look(g(12, -15.5, 6.5), g(8, 0, 1.4), 56) end, 0.25)
			X.rush(g(8.4, 0.5), 0.3, CYAN)
			at(7.5) -- il passe sous leurs bras
			hero:watch(nil)
			hero:to(H.DUCK, 0.08, "outQuad", {lag = false})
			hero:move(g(5.2, 0.5), 0.14, "outCubic")
			Kit.ghost(hero, CYAN, 0.25, 0.6)
			for i, z in {z3, z4, z5} do Kit.delay(0.02 * i, function() z:to(E.Z_SLAM, 0.11, "inQuad", {lag = false}) end) end
			Kit.delay(0.13, function()
				Fx.burst("Crack-01", g(7.4, 0.5, 0.15), {scale = 1.5})
				dust(g(7.4, 0.5), 1.2) Kit.snd(S.Thud, 0.8, 0.6) Kit.shake(0.5)
			end)
			at(7.66) -- le tourbillon : trois tours d'un seul trait, sans aucun arrêt ; chaque zombie est projeté à dix studs
			X.c = hero.pos
			hero:to(SPIN, 0.1, "outQuad", {lag = false})
			hero:body({yaw = hero.yaw + rad(1080)}, 0.66, "linear")
			trail.Enabled = true
			Kit.cam(function(t) return Kit.look(X.c + V(11 - t, 11, -13.5), X.c + V(0, 1, 0), 56) end, 0.15)
			Fx.burst("Tornado-01", X.c + V(0, 0.5, 0), {scale = 0.8, time = 0.4})
			Fx.burst("Wind-01", X.c + V(0, 2, 0), {scale = 2})
			Fx.mesh("SwirlWind", CFrame.new(X.c + V(0, 2.2, 0)), {color = rgb(210, 240, 255), size0 = 1.4, size1 = 6, time = 0.7, transp0 = 0.55, spin = 2.5})
			Fx.mesh("Tornado", CFrame.new(X.c + V(0, 4.5, 0)), {color = rgb(190, 225, 255), size0 = 1.2, size1 = 3.6, time = 0.8, transp0 = 0.75, spin = 3})
			ring(X.c, WHITE, 7.5, 0.6)
			Kit.snd(S.Lunge, 0.8, 0.7) Kit.snd(S.Swing, 0.6, 0.8)
			Kit.shake(0.5)
			Kit.fork(function() for _ = 1, 5 do Kit.wait(0.1) leaves(X.c, 4) Kit.snd(S.Swing, 0.35, 1.3) end end)
			Kit.delay(0.12, function() X.cut(z3, z3:center(0.8), 1.2) launch(z3, g(5, -15.5), 0.65, 3.2, true, GREEN) end)
			Kit.delay(0.32, function() X.cut(z4, z4:center(0.8), 1.2) knockdown(z4, g(13.5, 7.5), 0.7, 3.4) end)
			Kit.delay(0.52, function() X.cut(z5, z5:center(0.8), 1.2) knockdown(z5, g(0, 15), 0.7, 3.4) end)
			at(8.32)
			trail.Enabled = false
			hero:to(H.ZANSHIN, 0.28, "outBack")
			leaves(X.c, 10) dust(X.c, 1.2)
			Kit.cam(X.wide({hero, z4, z5}, -55, 9, 2, 0.04), 0.35)
			at(9.1) -- au fond de la clairière, le phantom prépare son tir
			hero:watch(p2) hero:face(p2, 0.3)
			hero:to(H.GUARD, 0.3, "outBack")
			p2:to(E.P_CAST, 0.3, "outBack")
			X.orb = Fx.attach("Charge-01", p2.rig.Torso, {offset = CFrame.new(0, 0.2, -2.6), scale = 1.2})
			Kit.snd(S.Spark, 0.4, 1.4) Kit.snd(S.Ghost, 0.5, 0.9)
			Kit.cam(function(t) return Kit.look(hero:point(-4.8, 2.3, 1.9), p2:center(0.5), 46) end, 0.35)
			at(10.3) getUp(z4, 1.3) getUp(z5, 1.3)

			-- 10,6 s : trois tirs ; il zigzague entre les explosions et remonte jusqu'au phantom
			at(10.6)
			X.orb.stop()
			Kit.cam(function(t) return Kit.look(g(-3, -20.5, 7.5), g(-5, 0, 2), 56) end, 0.3)
			local function shot(target)
				local from = p2.rig.Torso.Position + p2.rig.Torso.CFrame.LookVector * 3
				p2:hit(0.6)
				Kit.snd(S.Spark, 0.5, 1.8)
				Fx.projectile(from, target + V(0, 0.8, 0), 0.26, {color = CYAN, done = function(p)
					Fx.burst("Ground-Impact", p, {scale = 0.9})
					Fx.burst("Explosion-01", p + V(0, 1, 0), {scale = 0.45, time = 0.1, color = CYAN})
					Fx.burst("Crack-01", V(p.X, ORIGIN.Y + 0.15, p.Z), {scale = 1.4})
					ring(V(p.X, ORIGIN.Y, p.Z), CYAN, 3.5, 0.45)
					Fx.light(p + V(0, 2, 0), CYAN, 30, 7, 0.4)
					Kit.snd(BOOM, 0.55, 1.5) Kit.shake(0.55)
				end})
			end
			local function zig(to)
				hero:to(merge(H.SKID, {Waist = {-26, 0, 0}}), 0.07, "outQuad")
				hero:face(to, 0.06)
				dash(hero, to, 0.15, CYAN, true)
			end
			at(10.7) shot(hero.pos)
			at(10.84) zig(g(-1, -5.6))
			at(11.1) shot(hero.pos)
			at(11.24) zig(g(-5.6, 4.6))
			at(11.5) shot(hero.pos)
			z5:gait("zombieShamble", 0.2, function() dust(z5.pos, 0.3) end) z5:move(g(-0.5, 8.5), 2.7, "linear", {face = true, faceTime = 0.5})
			z4:gait("zombieShamble", 0.2, function() dust(z4.pos, 0.3) end) z4:move(g(2.8, -0.4), 6.2, "linear", {face = true, faceTime = 0.5})
			at(11.64) zig(g(-10.6, -2.4))
			at(11.86) -- sous le phantom : appui, saut, coup descendant
			hero:face(p2, 0.08)
			hero:to(H.CROUCH, 0.1, "outQuad")
			Kit.cam(function(t) return Kit.look(g(-3.5, -11.5, 5.5), (hero:center() + p2:center()) / 2, 56) end, 0.2)
			at(11.98)
			hero:body({air = 1}, 0.06)
			hero:to(H.AIR_WIND, 0.2, "outQuad")
			hero:move(g(-13.2, -1.2), 0.5, "linear", {arc = 5.4})
			dust(hero.pos, 0.8) leaves(hero.pos, 4)
			Kit.snd(S.Lunge, 0.5, 1)
			at(12.32)
			slash(nil, H.AIR_STRIKE, {cut = 0.1, normal = V(1, 0.2, 0), size = 1.4, hit = function()
				wound(p2, p2:center(0.4), 1.7, CYAN)
				p2.idle = 0
				p2:to(E.P_RECOIL, 0.1)
				p2:move(g(-20, -3), 0.7, "outQuad")
				p2:body({lift = 9, pitch = 1.2}, 0.7, "outQuad")
				vanish(p2, CYAN, 0.4)
			end})
			at(12.5) -- atterrissage
			hero:body({air = 0}, 0.05)
			hero:to(H.LAND, 0.1, "outQuad")
			dust(hero.pos, 1) leaves(hero.pos, 5) Kit.snd(S.Thud, 0.5, 1.1) Kit.shake(0.3)
			at(12.9)
			hero:to(H.GUARD, 0.35, "outBack")
			hero:watch(z5) hero:face(z5, 0.35)
			Kit.cam(X.wide({hero, z5, z4}, 205, 7.5, 0, 0.03), 0.4)
			Kit.snd(S.Ghost, 0.5, 0.45)

			-- 14,3 s : le zombie abat ses deux poings ; la parade fait reculer le héros de dix studs
			at(14.25) z5:gait(nil, 0.15) z5:to(E.Z_RAISE, 0.45, "inOut") z5:face(g(-2.3, 5.4), 0.3)
			at(14.46)
			Kit.cam(twoShot(hero, z5, -1, 6, 4, 52, 0.1), 0.2)
			X.rush(g(-2.3, 5.4), 0.26, CYAN)
			at(14.72)
			hero:watch(nil)
			hero:to(H.BLOCKHI, 0.08, "outQuad", {lag = false})
			z5:to(E.Z_SLAM, 0.11, "inQuad", {lag = false})
			at(14.83)
			clash(tip(0.6), 1.7, GREEN)
			Fx.burst("Crack-01", hero.pos + V(0, 0.15, 0), {scale = 1.6})
			Kit.flash(0.15, WHITE, 0.4)
			X.skid(hero, z5.pos, 10, 0.6, H.SKID)
			Kit.cam(X.wide({hero, z5}, -105, 6.5), 0.25)
			at(15.2)
			z5:gait("zombieShamble", 0.2, function() dust(z5.pos, 0.3) end)
			z5:move(g(-0.6, -1.3), 2.5, "linear", {face = true, faceTime = 0.5})
			at(15.5) hero:to(H.FATIGUE, 0.45, "inOut") hero.idle = 2.6 hero:face(g(9, 1.5), 0.5)
			at(16.2) -- l'eau monte le long de la lame
			hero.idle = 1
			hero:to(H.IAI, 0.45, "inOut")
			Kit.cam(function(t) return Kit.look(hero:point(-6 + 0.3 * t, 2.8, 3.6), hero:point(9, 0, 1.2), 46) end, 0.3)
			X.w1 = Fx.attach("Water-01", blade, {offset = CFrame.new(0, 0, -1.6), scale = 0.9})
			X.w2 = Fx.aura("Water-Aura-01", hero, {scale = 0.8})
			X.wl = Instance.new("PointLight")
			X.wl.Color, X.wl.Range, X.wl.Brightness, X.wl.Shadows = BLUE, 18, 2.4, false
			X.wl.Parent = blade
			Fx.burst("Splash-01", hero.pos + V(0, 0.5, 0), {scale = 1.2})
			trail.Color = ColorSequence.new(BLUE)
			Kit.snd(S.Ping, 0.4, 0.6) Kit.snd(S.Ghost, 0.3, 1.2)
			at(17.45)
			Kit.cam(function(t) return Kit.look(g(5.3, -16.3, 6), g(0.85, -0.9, 1.6), 56) end, 0.25)
			at(17.68) for _, z in {z4, z5} do z:gait(nil, 0.05) z:to(E.Z_RAISE, 0.2, "outQuad") end
			at(17.76) -- un seul trait à travers les deux : dix-sept studs
			X.a, X.b = hero.pos, g(9, 1.5)
			Kit.speedLines(0.35, 0.8) Kit.flash(0.25, rgb(170, 215, 255), 0.75)
			Kit.snd(S.Lunge, 0.8, 1.2) Kit.snd(SLASH_HIT, 0.9, 0.8)
			trail.Enabled = true
			hero:to(H.IAI_END, 0.1, "outQuart", {lag = false})
			hero:face(X.b, 0.04)
			hero:move(X.b, 0.15, "outCubic")
			Kit.fork(function()
				for i = 1, 5 do
					local p = X.a:Lerp(X.b, i / 6)
					Fx.burst("Water-02", p + V(0, 1.6, 0), {scale = 1.8})
					Fx.burst("Splash-01", p + V(0, 0.4, 0), {scale = 1.5})
					Kit.wait(0.025)
				end
			end)
			for _ = 1, 4 do Kit.ghost(hero, BLUE, 0.4, 0.4) Kit.wait(0.035) end
			do
				local mid = (X.a + X.b) / 2 + V(0, 2.4, 0)
				Fx.mesh("Shock", CFrame.lookAt(mid, mid + (X.b - X.a).Unit) * CFrame.Angles(0, 0, rad(12)) * CFrame.Angles(rad(90), 0, 0), {color = BLUE, size0 = 0.6, size1 = 5, time = 0.4, transp0 = 0})
			end
			Kit.hitstop(0.1)
			at(17.98) -- il s'arrête ; derrière lui, plus rien ne bouge
			trail.Enabled = false
			X.w1.stop() X.w2.stop()
			hero.idle = 0.3
			z4.idle, z5.idle = 0, 0
			Kit.cam(X.wide({hero, z4, z5}, 40, 6.5), 0.2)
			at(18.7) hero:to(merge(H.ZANSHIN, {RightShoulder = {20, 0, 60}, Grip = {-95}}), 0.12, "outQuart") Kit.snd(S.Swing, 0.3, 1.6)
			at(18.84)
			for i, z in {z5, z4} do
				Kit.delay(0.1 * (i - 1), function()
					wound(z, z:center(0.8), 1.3, BLUE)
					Fx.burst("Splash-01", z:center(0.4), {scale = 1.4})
					launch(z, z.pos + V(1.2, 0, i == 1 and -2.2 or 2.2), 0.5, 0.8, true, GREEN)
				end)
			end
			Kit.tween(0.8, function(e) X.wl.Brightness = 2.4 * (1 - e) end, "outQuad", function() X.wl:Destroy() end)
			trail.Color = ColorSequence.new(rgb(210, 240, 255))
			at(19.4) hero.idle = 1 flickerAmp = 1
			at(20.0)
		end

		------------------------------------------------ 0 - 15 s : l'appel téléphonique
		local PATH = g(40, 0)
		hero:place(g(13.2, 0), g(-10, 0))
		local ear = reach(V(0.78, 1.5, 0.05))
		local PHONE = merge(ear, {LeftShoulder = {-5, 0, -8}, LeftElbow = {18}, Waist = {-2, 5, 0}, LeftHip = {3, 0, -4}, RightHip = {-2, 0, 4}, Neck = {2, -6, 4}})
		hero:to(PHONE, 0)
		task.wait(0.1)
		-- le téléphone est collé à l'oreille droite, écran contre la joue ; on le fixe ensuite dans la main
		local atEar = hero.hrp.CFrame * (CFrame.fromMatrix(V(0.68, 1.52, -0.12), V(0, 0, -1), V(0, 1, 0), V(1, 0, 0)) * CFrame.Angles(rad(-14), 0, 0))
		pw.C0 = hand.CFrame:ToObjectSpace(atEar)
		local wind = loop(S.Ghost, 0.04, 0.5)
		local music = loop(MUSIC_CALM, 0.16, 1)
		local function head() return hero:center(1.55) end
		Kit.cam(function(t) -- gros plan sur le visage et le téléphone, puis la caméra recule : la forêt et la lune apparaissent
			local u = Kit.Ease.inOut(clamp(t / 3.2, 0, 1))
			local d, a = 2.7 + 5.6 * u, 0.62 - 0.2 * u
			return Kit.look(head() + V(-cos(a) * d, 0.1 + 0.7 * u, -sin(a) * d), head() + V(0, -0.5 * u, 0), 42 + 6 * u)
		end)
		Kit.bars(true, 1)
		if not o.ffTo then -- autour d'un décor qui vient d'apparaître, les lumières mettent une à deux secondes à se calculer
			Kit.paused = true
			task.wait(time() < 45 and 4 or 2.2)
			Kit.paused = false
		end
		Kit.fade(1, 1.4)
		-- il marche en téléphonant : petits pas, le bras libre balance, puis parle avec lui
		hero:gait("heroStroll", 0.3, function() leaves(hero.pos, 1) end)
		hero:move(g(0, 0), 6.4, "linear")
		Kit.at(0.5) Kit.say("Yeah, I'm on my way. I took the shortcut.", 2.9)
		Kit.at(0.9) hero:to({Neck = {6, -12, 4}}, 0.3, nil, {only = true}) -- il hoche la tête
		Kit.at(1.4) hero:to({Neck = {-3, -4, 2}}, 0.3, nil, {only = true})
		Kit.at(1.9) -- « the shortcut » : le pouce par-dessus l'épaule
		hero.gaitMask = {LeftShoulder = true, LeftElbow = true}
		hero:to({LeftShoulder = {64, 0, -30}, LeftElbow = {118}, Neck = {2, 10, 0}}, 0.3, "outBack", {only = true})
		Kit.at(2.35) hero:to({LeftShoulder = {52, 0, -26}, LeftElbow = {132}}, 0.16, nil, {only = true})
		Kit.at(2.6) hero:to({LeftShoulder = {64, 0, -30}, LeftElbow = {118}}, 0.16, nil, {only = true})
		Kit.at(2.9) hero:to({LeftShoulder = {4, 0, -6}, LeftElbow = {18}, Neck = {2, -6, 4}}, 0.3, "inOut", {only = true})
		Kit.at(3.0)
		Kit.cam(function(t) -- lent travelling autour de lui
			local a = 0.42 - 0.2 * t
			return Kit.look(head() + V(-cos(a) * 8.3, 0.8, -sin(a) * 8.3), head() + V(0, -0.5, 0), 48)
		end, 0.4)
		Kit.at(3.2) X.release(hero, {"LeftShoulder", "LeftElbow"}, 0.25)
		Kit.at(3.6) Kit.say("Through the forest. Relax, it's just trees.", 2.7)
		hero.gaitMask = {LeftShoulder = true, LeftElbow = true}
		hero:to({LeftShoulder = {42, 0, -58}, LeftElbow = {30}, Neck = {4, 16, -3}}, 0.4, "outBack", {only = true}) -- grand geste vers les arbres
		Kit.at(4.5) hero:to({LeftShoulder = {46, 0, -18}, LeftElbow = {74}, Neck = {2, -4, 2}}, 0.3, nil, {only = true})
		Kit.at(4.85) hero:to({LeftShoulder = {36, 0, -12}, LeftElbow = {88}}, 0.14, nil, {only = true}) -- « relax » : la main à plat tapote l'air
		Kit.at(5.05) hero:to({LeftShoulder = {44, 0, -12}, LeftElbow = {80}}, 0.14, nil, {only = true})
		Kit.at(5.25) hero:to({LeftShoulder = {36, 0, -12}, LeftElbow = {88}}, 0.14, nil, {only = true})
		Kit.at(5.45) hero:to({LeftShoulder = {44, 0, -12}, LeftElbow = {80}}, 0.14, nil, {only = true})
		Kit.at(5.7) hero:to({LeftShoulder = {4, 0, -6}, LeftElbow = {18}}, 0.3, "inOut", {only = true})
		Kit.at(6.0) X.release(hero, {"LeftShoulder", "LeftElbow"}, 0.25)
		Kit.at(6.4) hero:gait(nil, 0.22) hero.gaitMask = nil -- un bruit dans la forêt : il s'arrête de parler
		Kit.snd(S.Snap, 0.5, 0.7)
		Kit.fadeSound(wind, 0.12, 1.5)
		Kit.fadeSound(music, 0.06, 1.5)
		hero.look = PATH + V(0, 3, 0)
		hero:watch(PATH + V(0, 3, -14), 0.55)
		hero:to(merge(ear, {RightShoulder = {ear.RightShoulder[1] - 14, ear.RightShoulder[2], ear.RightShoulder[3] + 6}, Waist = {-2, -14, 0}}), 0.5, "outQuad", {only = true}) -- le bras descend un peu
		flickerAmp = 2.2
		Kit.at(7.5) Kit.say("...Hold on.", 1.5)
		Kit.at(8.1)
		Kit.snd(S.Snap, 0.8, 0.55)
		Kit.snd(S.Ghost, 0.2, 1.5)
		Kit.shake(0.08)
		Kit.cam(function(t) -- par-dessus son épaule : le sentier noir, la lune
			return Kit.look(g(-4.6 + 0.2 * t, -2.4, 4.3), g(30, 2, 4), 40)
		end)
		hero:watch(PATH + V(0, 3, 0), 1)
		Kit.at(10.2) -- il se retourne : la tête, les épaules, le buste, puis les pieds
		Kit.cam(function(t) return Kit.look(g(7.5 - 0.25 * t, 2.2, 2.9), head() + V(0, -0.4, 0), 44) end, 0.3)
		hero:to({Waist = {-4, 42, 0}}, 0.45, "inOut", {only = true})
		Kit.at(10.6)
		hero:body({yaw = hero.yaw - rad(92)}, 0.5, "inOut")
		hero:to({Waist = {-4, 20, 0}, RightHip = {18, 0, 10}, RightKnee = {-30}, LeftHip = {-6, 0, -4}}, 0.3, nil, {only = true})
		Kit.at(11.1)
		hero:face(PATH, 0.55, "inOut")
		hero:to({Waist = {-3, 0, 0}, RightHip = {-4, 0, 5}, RightKnee = {-6}, LeftHip = {14, 0, -5}, LeftKnee = {-22}}, 0.4, nil, {only = true})
		leaves(hero.pos, 3)
		Kit.at(12.4) flickerAmp = 1
		Kit.at(13.0) -- il écarte le téléphone, regarde l'écran
		Kit.cam(function(t) return Kit.look(g(5.6, 3.2, 3.8), hero:center(0.9), 38) end)
		hero:watch(nil)
		hero:to({RightShoulder = {28, 0, -8}, RightElbow = {88}, RightWrist = {-20}, Neck = {-24, -6, 0}, Waist = {-8, 0, 0}}, 0.45, "inOut", {only = true})
		Kit.at(13.6) Kit.say("I'll call you back.", 1.5) Kit.snd(S.Ping, 0.35, 1.3)
		Kit.at(14.1) -- et le glisse dans sa poche
		hero:to({RightShoulder = {-16, 0, 10}, RightElbow = {38}, RightWrist = {0}, Neck = {6}, Waist = {-3, -6, 0}}, 0.4, "inOut", {only = true})
		Kit.delay(0.36, function()
			for _, p in phone:GetDescendants() do if p:IsA("BasePart") then p.Transparency = 1 elseif p:IsA("PointLight") then p.Enabled = false end end
		end)
		hero:watch(PATH + V(0, 3, 0), 1)

		------------------------------------------------ 14,4 s : quelque chose passe derrière les troncs
		local v1 = spawn("vampire", g(47, -15), g(47, 15), 3)
		Kit.at(14.4)
		Kit.cam(function(t) return Kit.look(g(20, 3.4, 1), g(46, -4 + 6 * t, 4), 30) end)
		v1.gaitMask = nil
		v1:gait("vampireSprint", 0.05)
		v1:move(g(45, 13), 0.75, "linear")
		Kit.snd(S.Ghost, 0.5, 1.7)
		Kit.fadeSound(music, 0, 0.6)
		local fight = loop(MUSIC_FIGHT, 0, 1)
		Kit.fadeSound(fight, 0.42, 2)
		Kit.at(15.15)

		------------------------------------------------ 15 - 22 s : le vampire
		v1:gait(nil, 0.05)
		v1:place(g(33, 2), hero.pos)
		v1:to(E.V_CROUCH, 0)
		v1:watch(hero)
		Kit.cam(function(t) return Kit.look(v1:point(-4.6, 2.4, 2.2) + V(0, 0.3 * t, 0), hero:center(0.5), 38) end) -- derrière l'épaule du vampire
		Kit.snd(S.Ghost, 0.45, 2.1)
		v1:to(merge(E.V_CROUCH, {Root = {-36}, RightShoulder = {-30, 0, 70}, LeftShoulder = {-30, 0, -70}, Cape = {35}}), 0.8, "inOut")
		-- le héros recule d'un pas, porte la main au katana, dégaine
		hero:watch(v1)
		hero:move(g(-1.6, 0), 0.35, "outQuad")
		hero:to({RightHip = {-22, 0, 8}, RightKnee = {-20}, LeftHip = {26, 0, -8}, LeftKnee = {-34}, Waist = {-8, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}}, 0.3, "outQuad", {only = true})
		Kit.at(15.5)
		Kit.cam(function(t) return Kit.look(hero:point(3.6, -2.6, 0.6), hero:center(-0.3), 40) end) -- la main sur la poignée
		local handle = hero.hrp.CFrame:PointToObjectSpace((scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position)
		local toHandle = reach(handle)
		hero:to(toHandle, 0.28, "inOut", {only = true, lag = false})
		Kit.at(15.82)
		grab(0.22)
		Kit.snd(S.Unsheath, 0.7, 1)
		hero:to({RightShoulder = {70, 0, 45}, RightElbow = {12}, Grip = {-70}, Waist = {-6, -30, 0}, Root = {0, -10, 0}}, 0.3, "outCubic", {only = true}) -- la lame sort
		trail.Enabled = true
		Kit.delay(0.16, function() Fx.attach("Shiny-01", blade, {pulse = true, scale = 0.6}) Fx.light(blade, CYAN, 12, 4, 0.5) end)
		Kit.at(16.15)
		trail.Enabled = false
		Kit.cam(twoShot(hero, v1, -1, 5, 2.2, 46, 0.05))
		hero:to(H.GUARD, 0.3, "outBack")
		Kit.at(16.6) -- le vampire fonce
		v1:gait("vampireSprint", 0.06, function() leaves(v1.pos, 2) end)
		v1:move(g(3.4, 0.6), 0.8, "inQuad")
		Kit.snd(S.Lunge, 0.5, 0.8)
		Kit.fork(function() for _ = 1, 6 do Kit.wait(0.12) Kit.ghost(v1, RED, 0.28, 0.6) end end)
		Kit.at(17.34)
		v1:gait(nil, 0.05)
		v1:to(E.V_WIND, 0.12, "outQuad")
		Kit.at(17.42) -- esquive : il pivote sur le côté, déjà armé
		hero:move(g(0.2, -2.9), 0.24, "outCubic")
		hero:face(g(3.4, 0.6), 0.2)
		hero:to(H.HW, 0.2, "outQuad")
		Kit.ghost(hero, CYAN, 0.25, 0.6)
		Kit.at(17.5)
		v1:to(E.V_CLAW, 0.1, "outQuart", {lag = false})
		v1:move(g(2.2, 0.4), 0.12, "outQuad")
		swoosh(v1:point(2, 0, 1.2), V(0.3, 1, 0), RED, 0.8)
		Kit.snd(S.Swing, 0.4, 1.5)
		Kit.at(17.7) -- premier coup de katana
		slash(nil, H.HS, {hit = function()
			wound(v1, v1:center(0.8), 1)
			v1:to(E.RECOIL, 0.1, "outQuad")
			v1:move(g(10.6, 2.2), 0.5, "outCubic")
			Kit.fork(function() for _ = 1, 3 do Kit.wait(0.1) dust(v1.pos, 0.6) end end)
		end})
		Kit.cam(twoShot(hero, v1, -1, 7, 2.6, 50, 0.08), 0.25)
		Kit.at(18.0) hero:to(H.GUARD, 0.3, "outBack") hero:face(v1, 0.2)
		Kit.at(18.35) v1:to(E.V_CROUCH, 0.3, "outBack") Kit.snd(S.Ghost, 0.4, 2.3)
		Kit.at(19.0) -- enchaînement : il court, coup remontant, le vampire bloque
		X.rush(g(7.8, 1.7), 0.26, CYAN)
		v1:to(E.V_BLOCK, 0.12, "outQuad")
		slash(H.RW, H.RS, {wind = 0.08, hit = function()
			clash(v1:point(1.2, 0, 1), 1, RED)
			v1:hit(0.8)
			X.skid(v1, hero.pos, 9, 0.45)
			dust(v1.pos, 0.6)
		end})
		Kit.at(19.82) -- le vampire bondit, griffes en avant ; le héros passe dessous
		v1:to(E.V_LEAP, 0.12, "outQuad")
		v1:body({air = 1}, 0.05)
		v1:move(g(8.2, 1.8), 0.5, "linear", {arc = 3.4})
		Kit.snd(S.Ghost, 0.4, 2.5)
		Kit.cam(twoShot(hero, v1, 1, 6, 3.6, 52, -0.2), 0.2)
		Kit.at(19.95)
		hero:to(H.DUCK, 0.12, "outQuad")
		hero:move(g(11, -1), 0.2, "outQuad")
		Kit.at(20.15)
		hero:move(g(13.4, 1.9), 0.22, "outQuad")
		hero:face(g(8.2, 1.8), 0.22)
		dust(hero.pos, 0.5)
		Kit.at(20.32)
		v1:body({air = 0}, 0.06)
		v1:to(E.V_CLAW, 0.08)
		dust(v1.pos, 0.8) Kit.snd(S.Thud, 0.4, 0.9)
		Kit.at(20.42) -- il est dans son dos : le coup qui l'achève
		slash(H.HW, H.HS, {wind = 0.12, size = 1.4, hit = function()
			wound(v1, v1:center(0.8), 1.6)
			ring(v1.pos, WHITE, 2.4, 0.4)
			Kit.flash(0.2, WHITE, 0.5)
			launch(v1, g(-4, -1.5), 0.7, 2.6, false, RED)
		end})
		Kit.cam(X.wide({hero, v1}, -100, 6.5, 0, 0.05), 0.3) -- contre-plongée, la lune derrière lui
		Kit.at(20.95) hero:to(H.ZANSHIN, 0.35, "outBack")

		------------------------------------------------ 22 - 26,5 s : le zombie
		local z1 = spawn("zombie", g(15.5, 17), g(13.6, 7.2), 7)
		z1:setVisible(0)
		Kit.at(22.1)
		z1:fade(1, 0.3)
		z1:gait("zombieShamble", 0.1, function() dust(z1.pos, 0.3) end)
		z1:move(g(13.6, 7.2), 1.55, "linear")
		Kit.snd(S.Ghost, 0.5, 0.45)
		Kit.at(22.6) hero:watch(z1)
		Kit.cam(twoShot(hero, z1, -1, 7, 4.4, 50, 0.06), 0.5)
		Kit.at(23.0) hero:face(z1, 0.35) hero:to(H.GUARD, 0.3, "outBack")
		Kit.at(23.65) z1:gait(nil, 0.1) z1:to(E.Z_RAISE, 0.5, "inOut") z1:face(hero, 0.2)
		Kit.at(24.08) -- glissade sous les bras du zombie
		hero:watch(nil)
		hero:to(H.SLIDE, 0.14, "outQuad")
		hero:body({pitch = 0.55, sink = 0.15}, 0.14)
		hero:face(g(17, 10.5), 0.08)
		hero:move(g(17, 10.5), 0.55, "outQuad")
		Kit.snd(S.Lunge, 0.4, 0.8)
		Kit.fork(function() for _ = 1, 6 do Kit.wait(0.08) dust(hero.pos, 0.45) leaves(hero.pos, 1) end end)
		Kit.at(24.2)
		z1:to(E.Z_SLAM, 0.11, "inQuad", {lag = false})
		Kit.delay(0.1, function()
			Fx.burst("Crack-01", z1:point(2.6, 0, 0.1) + V(0, 0.15, 0), {scale = 1.2})
			dust(z1:point(2.6), 1) Kit.snd(S.Thud, 0.7, 0.6) Kit.shake(0.4)
		end)
		Kit.at(24.66) -- il se relève en tournant et frappe dans le dos
		hero:body({pitch = 0, sink = 0}, 0.16, "outQuad")
		hero:face(z1, 0.2)
		slash(H.HW, H.HS, {wind = 0.16, hit = function()
			wound(z1, z1:center(0.8), 1)
			z1:to(E.Z_STAGGER, 0.12)
			X.skid(z1, hero.pos, 7, 0.45)
		end})
		Kit.at(25.2) z1:face(hero, 0.35)
		Kit.at(25.4) -- coup vertical : le zombie tombe
		X.rush(z1.pos + (hero.pos - z1.pos).Unit * V(1, 0, 1) * 2.8, 0.18, CYAN)
		slash(H.VW, H.VS, {wind = 0.16, normal = V(1, 0.1, 0), hit = function()
			wound(z1, z1:center(1), 1.4)
			launch(z1, z1.pos + (z1.pos - hero.pos).Unit * V(1, 0, 1) * 9, 0.55, 1.6, true, rgb(140, 255, 90))
		end})
		Kit.at(25.95) hero:to(H.GUARD, 0.3, "outBack")

		------------------------------------------------ 26 - 30,5 s : le phantom
		local ph = spawn("phantom", g(26, 6), hero.pos, 11)
		ph.lift = 5
		ph:setVisible(0)
		ph:gait("phantomFloat", 0)
		Kit.at(26.0)
		Fx.burst("Portal-01", ph:center(4.5), {scale = 1.6})
		Kit.snd(S.Ghost, 0.6, 0.9)
		Kit.cam(function(t) return Kit.look(hero:point(-4.5, 2.2, 1.8), ph:center(4.2) - V(0, 1.5, 0), 46) end, 0.4) -- la caméra monte vers lui
		ph:fade(1, 0.6)
		hero:watch(ph)
		Kit.at(26.5) hero:face(ph, 0.3)
		Kit.at(27.15)
		ph:to(E.P_CAST, 0.3, "outBack")
		local orb = Fx.attach("Charge-01", ph.rig.Torso, {offset = CFrame.new(0, 0.2, -2.6), scale = 1.1})
		Kit.snd(S.Spark, 0.4, 1.4)
		Kit.at(27.85)
		orb.stop()
		Kit.cam(twoShot(hero, ph, -1, 5, 3.4, 52, 0.05, 2), 0.2)
		local from = ph.rig.Torso.Position + ph.rig.Torso.CFrame.LookVector * 3
		Fx.projectile(from, hero:center(1.2) + (from - hero:center()).Unit * 1.6, 0.36, {color = CYAN, done = function(p)
			clash(p, 1.5, CYAN)
			Fx.burst("Shield-Break-01", p, {scale = 1.3})
			Kit.flash(0.2, CYAN, 0.45)
			local back = (hero.pos - ph.pos) * V(1, 0, 1)
			X.skid(hero, ph.pos, 9, 0.5)
			dust(hero.pos, 0.7)
		end})
		Kit.at(28.02) hero:to(H.BLOCK, 0.13, "outQuad", {lag = false})
		Kit.at(28.6) -- il court vers le phantom, qui esquive sur le côté
		X.rush(g(22.4, 6.4), 0.34, CYAN)
		Kit.fork(function()
			Kit.ghost(ph, CYAN, 0.4, 0.4)
			Kit.snd(S.Ghost, 0.4, 2.6)
			ph:move(g(24, -5), 0.22, "outCubic")
			ph:body({lift = 4.2}, 0.22)
			Fx.burst("Wind-01", ph:center(4), {scale = 1.4})
		end)
		slash(H.HW, H.HS, {wind = 0.07}) -- dans le vide
		Kit.at(29.36) -- il change de direction et saute
		hero:face(ph, 0.12)
		hero:to(H.CROUCH, 0.1, "outQuad")
		Kit.cam(function(t) return Kit.look(g(15.5, 1.2, 4), (hero:center() + ph:center(4)) / 2, 54) end, 0.25)
		Kit.at(29.48)
		hero:body({air = 1}, 0.06)
		hero:to(H.AIR_WIND, 0.2, "outQuad")
		hero:move(g(23.2, -2.8), 0.56, "linear", {arc = 5})
		dust(hero.pos, 0.8) leaves(hero.pos, 4)
		Kit.snd(S.Lunge, 0.5, 1)
		Kit.at(29.86)
		slash(nil, H.AIR_STRIKE, {cut = 0.1, normal = V(1, 0.2, 0), size = 1.3, hit = function()
			wound(ph, ph:center(4.2), 1.4, CYAN)
			ph:to(E.P_RECOIL, 0.1)
			ph:move(g(30, -6), 0.5, "outCubic")
			ph:body({lift = 3.4}, 0.5)
		end})
		Kit.at(30.04) -- atterrissage, les jambes absorbent
		hero:body({air = 0}, 0.05)
		hero:to(H.LAND, 0.1, "outQuad")
		dust(hero.pos, 1) leaves(hero.pos, 5) Kit.snd(S.Thud, 0.5, 1.1) Kit.shake(0.3)

		------------------------------------------------ 30,3 - 35 s : les renforts, puis la lame de feu
		local v2 = spawn("vampire", g(54, -3), hero.pos, 5)
		local z2 = spawn("zombie", g(50, 4), hero.pos, 9)
		Kit.at(30.3)
		v2:gait("vampireSprint", 0.1) v2:move(g(36, -3), 1.1, "outQuad") v2:watch(hero)
		z2:gait("zombieShamble", 0.1) z2:move(g(35.5, 3.4), 2.6, "linear") z2:watch(hero)
		ph:move(g(33, 0.4), 1.4, "inOut") ph:body({lift = 4}, 1.4) ph:to({}, 0.4)
		Kit.at(30.85) -- il se redresse et se place face à eux
		hero:watch(g(34, 0, 3))
		hero:to(H.GUARD, 0.3, "outBack")
		hero.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, LeftShoulder = true, LeftElbow = true, Neck = true}
		hero:gait("heroWalk", 0.12)
		Kit.delay(0.5, function() hero:gait(nil, 0.15) end)
		hero:move(g(21, 0), 0.5, "inOut")
		hero:face(g(34, 0), 0.4)
		Kit.cam(function(t) return Kit.look(g(15.2, -4.4, 3.2), g(31, 0, 2.6), 46) end, 0.4) -- derrière lui : les trois monstres sur le sentier
		Kit.at(31.4) v2:gait(nil, 0.1) v2:to(E.V_CROUCH, 0.25, "outBack") Kit.snd(S.Ghost, 0.4, 2.2)
		Kit.at(31.5) -- il place le katana devant lui : le feu monte le long de la lame
		hero:to(H.CHARGE, 0.4, "inOut")
		Kit.cam(function(t) return Kit.look(hero:point(3.4 - 0.2 * t, -0.9, 1.3), hero:center(1.35), 34) end, 0.3) -- visage et lame
		Kit.at(31.9)
		local fire = Fx.attach("Fire-01", blade, {offset = CFrame.new(0, 0, -1.2), scale = 0.9})
		local fire2 = Fx.attach("Fire-03", blade, {offset = CFrame.new(0, 0, -2.6), scale = 0.7})
		local charge = Fx.attach("Charge-01", blade, {offset = CFrame.new(0, 0, -1.6), scale = 0.8, color = ORANGE})
		local aura = Fx.aura("Fire-Aura-01", hero, {limbs = {["Right Arm"] = true, ["Left Arm"] = true}, scale = 0.7})
		local glow = Instance.new("PointLight")
		glow.Color, glow.Range, glow.Brightness, glow.Shadows = ORANGE, 16, 0, false
		glow.Parent = blade
		Kit.tween(0.9, function(e) glow.Brightness = 5 * e end)
		local burn = Kit.snd(S.Fire, 0.5, 1, true) table.insert(loops, burn)
		trail.Color = ColorSequence.new(ORANGE)
		Kit.at(32.5)
		Kit.cam(function(t) return Kit.look(g(14.5, -5.5, 6.5), g(31, 0.5, 1.5), 50) end, 0.25) -- contre-plongée derrière lui
		v2:gait("vampireSprint", 0.06) v2:move(g(27, -1), 0.75, "inQuad") -- le vampire charge
		Kit.at(32.7)
		hero:to(H.HW, 0.24, "outCubic")
		Kit.at(32.96) -- la lame de feu part
		slash(nil, H.HS, {color = ORANGE, size = 1.8, cut = 0.1})
		charge.stop() aura.stop()
		Kit.snd(BOOM, 0.5, 1.5)
		Kit.shake(0.5)
		Kit.flash(0.2, ORANGE, 0.4)
		do
			local start, finish = hero:point(2.5, 0, 0), g(34.5, 1)
			local carrier = Instance.new("Part")
			carrier.Size = V(1, 1, 1)
			carrier.Transparency = 1
			carrier.Anchored, carrier.CanCollide, carrier.CanQuery, carrier.CanTouch = true, false, false, false
			carrier.Parent = scene
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = ORANGE, 30, 6, false
			l.Parent = carrier
			local f1 = Fx.attach("Fire-01", carrier, {scale = 2.2, rate = 2})
			local f2 = Fx.attach("Fire-02", carrier, {scale = 2})
			local dir = (finish - start).Unit
			local last = 0
			Kit.tween(0.42, function(e)
				local p = start:Lerp(finish, e) + V(0, 2.2, 0)
				carrier.CFrame = CFrame.lookAt(p, p + dir)
				if e - last > 0.12 then -- croissant de feu et traînée au sol, tout le long de la trajectoire
					last = e
					Fx.mesh("Shock", CFrame.lookAt(p, p + dir) * CFrame.Angles(0, 0, rad(90)) * CFrame.Angles(rad(90), 0, 0), {color = ORANGE, size0 = 1.2, size1 = 2.4, time = 0.25, transp0 = 0.1})
					Fx.burst("Fire-Slash-01", p, {scale = 1.6})
					Fx.burst("Fire-02", p - V(0, 2, 0), {scale = 1.2, time = 0.5})
				end
			end, "linear", function()
				f1.stop() f2.stop()
				Kit.delay(1, function() carrier:Destroy() end)
			end)
		end
		Kit.at(33.2) -- le vampire est fauché en pleine course
		wound(v2, v2:center(0.8), 1, ORANGE)
		launch(v2, g(46, -8), 0.6, 4, true, ORANGE)
		Kit.at(33.38) -- explosion sur le sentier
		local boomAt = g(34.5, 1)
		Fx.burst("Explosion-01", boomAt + V(0, 2, 0), {scale = 1.5, time = 0.35})
		Fx.burst("Realistic-Explosion-01", boomAt + V(0, 2, 0), {scale = 1.6, time = 0.3})
		Fx.burst("Big-Crack-01", boomAt + V(0, 0.6, 0), {scale = 0.9, time = 0.4})
		ring(boomAt, ORANGE, 5, 0.6)
		Fx.light(boomAt + V(0, 3, 0), ORANGE, 60, 10, 0.8)
		Kit.snd(BOOM, 0.9, 0.9)
		Kit.shake(1.3) Kit.flash(0.3, ORANGE, 0.7) Kit.hitstop(0.1)
		z2:gait(nil, 0.05) z2:hit(2) z2:to(E.Z_STAGGER, 0.15) z2:move(g(33, 4.4), 0.4, "outCubic")
		ph:hit(2) ph:to(E.P_RECOIL, 0.15) ph:move(g(34.5, -3.4), 0.5, "outCubic")
		Kit.cam(function(t) return Kit.look(g(12 - 0.6 * t, -6, 5.5 + 0.2 * t), g(29, 1, 2), 52) end, 0.3) -- la caméra recule devant l'explosion
		fire.stop() fire2.stop()
		Kit.tween(1.2, function(e) glow.Brightness = 5 * (1 - e) end, "outQuad", function() glow:Destroy() end)
		Kit.fadeSound(burn, 0, 1)
		Kit.at(33.9) hero:to(H.GUARD, 0.4, "outBack")
		trail.Color = ColorSequence.new(rgb(210, 240, 255))
		Kit.at(34.4) z2:to({RightShoulder = {80}, LeftShoulder = {60}, Root = {-12}}, 0.5) ph:to({}, 0.4) z2:face(hero, 0.3) ph:face(hero, 0.3)

		------------------------------------------------ 35 - 38 s : les deux derniers
		Kit.at(35.0)
		Kit.cam(twoShot(hero, z2, 1, 6, 4, 52, 0.1), 0.3)
		run(g(27, 2.6), 0.36, "inQuad")
		dash(hero, g(30.9, 3.8), 0.16, CYAN, true)
		slash(H.HW, H.HS, {wind = 0.07, size = 1.3, hit = function()
			wound(z2, z2:center(0.8), 1.4)
			launch(z2, g(40, 8), 0.6, 2.4, true, rgb(140, 255, 90))
		end})
		Kit.at(35.95) -- le phantom fond sur lui par derrière : il pivote et bloque
		ph:to(E.P_WIND, 0.15)
		ph:move(g(32.4, 1.2), 0.3, "inQuad") ph:body({lift = 1.3}, 0.3)
		Kit.ghost(ph, CYAN, 0.4, 0.4) Kit.snd(S.Ghost, 0.4, 2.6)
		hero:face(ph, 0.18)
		hero:to(H.BLOCK, 0.16, "outQuad", {lag = false})
		Kit.cam(twoShot(hero, ph, -1, 4.5, 2.4, 50, 0.3, 1.2), 0.2)
		Kit.at(36.24)
		ph:to(E.P_CLAW, 0.09, "outQuart", {lag = false})
		Kit.at(36.3)
		clash(tip(0.4), 1.2, CYAN)
		X.skid(hero, hero.pos + V(4, 0, 0.4), 8, 0.3)
		Kit.at(36.6) X.rush(ph.pos + (hero.pos - ph.pos).Unit * V(1, 0, 1) * 2.6, 0.16, CYAN) -- contre : coup remontant
		slash(H.RW, H.RS, {wind = 0.12, size = 1.4, hit = function()
			wound(ph, ph:center(1.6), 1.6, CYAN)
			ph.idle = 0
			ph:to(E.P_RECOIL, 0.1)
			ph:move(g(41, -7), 0.7, "outQuad")
			ph:body({lift = 8, pitch = 1.2}, 0.7, "outQuad")
			vanish(ph, CYAN, 0.45)
		end})
		Kit.at(37.15) hero:to(H.ZANSHIN, 0.3, "outBack")
		Kit.at(37.6) hero:to(merge(H.ZANSHIN, {RightShoulder = {20, 0, 60}, Grip = {-95}}), 0.12, "outQuart") Kit.snd(S.Swing, 0.3, 1.6) -- il secoue la lame

		------------------------------------------------ 38 - 43,6 s : le silence, puis Headless
		X.wave2()
		-- à partir d'ici X.at(t) = Kit.at(t + 20) : les repères écrits ci-dessous sont ceux d'avant l'ajout de la deuxième vague
		X.at(38.0)
		Kit.fadeSound(fight, 0, 0.35)
		Kit.fadeSound(wind, 0.22, 1)
		-- il baisse sa lame et repart vers la clairière ; derrière lui, entre les deux grands troncs, quelque chose sort de la brume
		hero:watch(nil)
		hero:to({RightShoulder = {8, 0, 14}, RightElbow = {18}, Grip = {-70}, LeftShoulder = {-4, 0, -8}, LeftElbow = {14}, Waist = {-3}}, 0.5, "inOut")
		hero:face(g(19.5, 2.4), 0.5)
		flickerAmp = 2.6
		Kit.cam(function(t) return Kit.look(g(7 - 0.4 * t, -2.4, 2.2), g(40, 1.4, 4.4), 36) end, 0.6)
		Kit.delay(0.45, function()
			hero.gaitMask = {Grip = true}
			hero:gait("heroWalkSword", 0.2, function() leaves(hero.pos, 1) end)
			hero:move(g(19.5, 2.4), 1.75, "inOut")
		end)
		local boss = spawn("headless", g(49, 0), g(0, 0), 13)
		boss:setVisible(0)
		boss:to(B.IDLE, 0)
		local gs, gsRoot, gsBlade = Cast.greatsword()
		gs.Parent = scene
		local gw = Instance.new("Weld")
		gw.Part0, gw.Part1 = boss.rig["Right Arm"], gsRoot
		gw.C0, gw.C1 = CFrame.new(0, -1.0 * boss.scale, 0), CFrame.new(Cast.GREATSWORD_GRIP)
		gw.Parent = gsRoot
		boss:addWeldJoint("Grip", gw)
		local Blades = {}
		do
			local raw, arm = boss.joints.Grip, boss.rig["Right Arm"]
			local function bossHand() return (arm.CFrame * CFrame.new(0, -boss.scale, 0)).Position end
			boss.joints.Grip = function(cf)
				raw(cf)
				local a = Blades.bossAim
				if a then gw.C0 = gw.C0:Lerp(arm.CFrame:ToObjectSpace(CFrame.lookAt(bossHand(), a.point(), a.up)), a.w) end
			end
			local function aimGreat(point, up, dur)
				if point then
					local a = {point = point, up = up, w = 0}
					Blades.bossAim = a
					Kit.tween(dur or 0.1, function(e) a.w = e end, "outQuad")
				elseif Blades.bossAim then
					local a = Blades.bossAim
					Kit.tween(dur or 0.15, function(e) a.w = 1 - e end, "inOut", function() if Blades.bossAim == a then Blades.bossAim = nil end end)
				end
			end
			-- point de rencontre des deux lames : entre les deux mains, un peu plus haut
			function Blades.meet(lift) return ((hand.CFrame * gripBase).Position + bossHand()) / 2 + V(0, lift or 1.5, 0) end
			-- les deux lames visent ce point : elles se touchent vraiment à l impact
			function Blades.cross(lift, dur)
				local hb = (boss.pos - hero.pos) * V(1, 0, 1)
				hb = hb.Magnitude > 0.1 and hb.Unit or V(1, 0, 0)
				local function point() return Blades.meet(lift) end
				aimKatana(point, V(0, 1, 0) - hb * 0.5, dur or 0.06)
				aimGreat(point, V(0, 1, 0) + hb * 0.5, dur or 0.06)
			end
			function Blades.uncross(dur) aimKatana(nil, nil, dur or 0.14) aimGreat(nil, nil, dur or 0.14) end
		end
		boss:to(B.IDLE, 0)
		for _, p in gs:GetDescendants() do if p:IsA("BasePart") then p.Parent = boss.rig end end -- l'espadon s'efface avec lui
		boss:setVisible(0)
		local function bossTip(back) return (gsBlade.CFrame * CFrame.new(0, 0, -(back or 2))).Position end
		X.at(39.0)
		boss:fade(1, 1.2)
		Kit.snd(S.Thunder, 0.5, 0.5)
		local bossAura = Fx.aura("Fire-Aura-01", boss, {color = VIOLET, scale = 1.5, limbs = {Torso = true, ["Right Arm"] = true, ["Left Arm"] = true}})
		X.at(40.2) -- le héros s'arrête : il l'a senti
		hero:gait(nil, 0.2)
		hero:watch(boss)
		X.at(40.3) -- il avance : d'abord ses jambes, chaque pas fait trembler le sol
		flickerAmp = 1
		Kit.camSubject = nil
		boss.gaitMask = {RightShoulder = true}
		boss:gait("headlessWalk", 0.2, function()
			dust(boss.pos, 1) leaves(boss.pos, 3)
			Kit.snd(S.Thud, 0.6, 0.45) Kit.shake(0.22)
		end)
		boss:move(g(29, 0), 3.3, "linear")
		Kit.cam(function(t) return Kit.look(V(boss.pos.X - 11, ORIGIN.Y + 0.9, boss.pos.Z + 5), boss.pos + V(0, 2.1, 0), 38) end)
		Kit.delay(0.3, function() hero:face(boss, 0.45) hero:to(H.GUARD, 0.4, "outBack") end) -- le héros se retourne, en garde
		Kit.delay(0.9, function() -- puis recule sans le quitter des yeux
			hero.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, LeftShoulder = true, LeftElbow = true, Neck = true}
			hero:gait("heroWalk", 0.2)
			hero:move(g(6, 0), 2.4, "inOut")
		end)
		X.at(41.9)
		Kit.cam(function(t) -- la caméra remonte le long de son corps
			local u = Kit.Ease.inOut(clamp(t / 1.5, 0, 1))
			return Kit.look(V(boss.pos.X - 13, ORIGIN.Y + 1.2 + 2 * u, boss.pos.Z + 4.4), boss.pos + V(0, 2.5 + 3.7 * u, 0), 40)
		end, 0.5)
		X.at(42.6)
		fight.TimePosition = 20
		fight.PlaybackSpeed = 0.92
		Kit.fadeSound(fight, 0.5, 1.6)
		X.at(43.6)
		boss:gait(nil, 0.3)
		hero:gait(nil, 0.3)
		Kit.camSubject = function() return hero:center(1) end
		Kit.cam(twoShot(hero, boss, -1, 5, 2.4, 50, 0.04), 0.5)
		boss:to(B.GUARD, 0.6, "inOut")
		hero:to(H.GUARD, 0.4, "outBack")
		hero:watch(boss)

		------------------------------------------------ 44,4 - 48,7 s : le face à face et le premier choc
		X.at(44.4)
		hero:gait("heroWalk", 0.25) hero:move(g(8, 0), 1.9, "inOut")
		boss.gaitMask = {RightShoulder = true, LeftShoulder = true, Grip = true}
		boss:gait("headlessWalk", 0.25, function() dust(boss.pos, 0.8) Kit.snd(S.Thud, 0.5, 0.45) Kit.shake(0.15) end) boss:move(g(20.5, 0), 1.9, "inOut")
		Kit.cam(function(t) return Kit.look(g(15.5 - 1.2 * t, -16 + 0.5 * t, 2.3), g(15.5, 0, 3.6), 58) end, 0.4) -- travelling latéral, la lune au fond
		X.at(46.3)
		hero:gait(nil, 0.25) boss:gait(nil, 0.25)
		Kit.fadeSound(fight, 0.12, 0.5)
		Kit.cam(function(t) return Kit.look(tip(1.5) + V(-1.2, 0.2, -1.8), tip(1.2), 30) end) -- la lame
		hero:to(merge(H.GUARD, {LeftHip = {42, 0, -8}, LeftKnee = {-58}, RightHip = {-22, 0, 10}, RightKnee = {-40}}), 0.5, "inOut") -- il baisse son centre de gravité
		X.at(46.65) Kit.cam(function(t) return Kit.look(boss:point(9.5, 5.5, 3.6), boss:center(0.9), 48) end) -- le torse du Headless
		boss:to(merge(B.GUARD, {Root = {-16, -22, 0}, RightShoulder = {85, 0, 20}, Grip = {-35}}), 0.4, "inOut")
		X.at(47.0) Kit.cam(function(t) return Kit.look(hero:point(5.6, -1.7, 3.7), hero:center(0.9), 34) end) -- son regard
		X.at(47.3) Kit.cam(function(t) return Kit.look(g(14.2, -19, 1.0), g(14.2, 0, 4.5), 48) end) -- les deux silhouettes dans la lumière de la lune
		local LOCK_H = merge({LeftShoulder = {78, 0, 38}, LeftElbow = {72}, Waist = {-14}, Neck = {10}, LeftHip = {46, 0, -8}, LeftKnee = {-62}, RightHip = {-32, 0, 8}, RightKnee = {-16}}, reach(V(0.3, 0.75, -1.3)))
		local LOCK_B = {Root = {-14, 8, 0}, RightShoulder = {82, 0, -14}, LeftShoulder = {70, 0, 28}, Grip = {-40}, LeftHip = {32}, RightHip = {-26}, Cape = {30}, Coat = {-20}}
		X.at(47.85) -- ils s'élancent en même temps
		Kit.fadeSound(fight, 0.55, 0.3)
		Kit.cam(twoShot(hero, boss, -1, 4, 2.6, 50, 0.25, 1.2), 0.15)
		hero:to(H.HW, 0.12, "outQuad") boss:to(B.HWIND, 0.14, "outQuad")
		Kit.wait(0.12)
		Kit.speedLines(0.3, 0.5)
		hero:move(g(10.7, 0), 0.14, "outCubic") boss:move(g(17.9, 0), 0.14, "outCubic")
		Kit.ghost(hero, CYAN, 0.3, 0.5) Kit.ghost(boss, VIOLET, 0.3, 0.5)
		trail.Enabled = true
		hero:to(LOCK_H, 0.12, "outQuart", {lag = false})
		boss:to(LOCK_B, 0.12, "outQuart", {lag = false})
		Blades.cross(1.5, 0.1)
		Kit.wait(0.12)
		trail.Enabled = false
		local lockAt = Blades.meet(1.5)
		clash(lockAt, 2, WHITE)
		ring(g(14.3, 0), WHITE, 4, 0.5)
		Kit.flash(0.25, WHITE, 0.7)
		Kit.snd(BOOM, 0.5, 1.6)
		dust(hero.pos, 0.8) dust(boss.pos, 1.2)
		-- les lames restent croisées : ils poussent l'un contre l'autre
		local lock = true
		Kit.fork(function()
			while lock and Kit.running do
				local p = Blades.meet(1.5)
				Fx.burst("Slash-Impact-01", p, {scale = 0.45})
				Fx.light(p, rgb(255, 220, 160), 12, 3, 0.12)
				hero:hit(0.25) boss:hit(0.18)
				Kit.wait(0.11)
			end
		end)
		local spark = Kit.snd(S.Spark, 0.3, 1, true) table.insert(loops, spark)
		Kit.cam(function(t)
			local m = (hero:center() + boss:center()) / 2
			return Kit.look(V(m.X - 0.5 + 0.4 * t, ORIGIN.Y + 2.6, m.Z - 12.5 + 1.2 * t), V(m.X, ORIGIN.Y + 4.6, m.Z), 48 - 3 * t)
		end, 0.3)
		hero:move(g(10.4, 0), 0.6, "inOut") boss:move(g(17.6, 0), 0.6, "inOut")
		hero:to({Waist = {-22, 0, 0}, LeftKnee = {-70}, RightKnee = {-24}}, 0.6, nil, {only = true})
		X.at(48.75) -- le Headless le repousse
		lock = false
		if spark then spark:Stop() end
		Blades.uncross(0.12)
		boss:to(merge(B.HSTRIKE, {Root = {-20, 50, 0}}), 0.12, "outQuart")
		clash(lockAt, 1.4, VIOLET)
		hero:to(H.SKID, 0.14, "outQuad")
		hero:move(g(1, 0.6), 0.55, "outCubic")
		Kit.fork(function() for _ = 1, 5 do Kit.wait(0.09) dust(hero.pos, 0.6) leaves(hero.pos, 1) end end)
		Kit.cam(function(t) return Kit.look(g(9.5, -15, 3.4), g(9, 0, 2.4), 50) end, 0.4)
		X.at(49.0) boss:move(g(18.3, 0), 0.3, "outQuad") boss:to(B.GUARD, 0.35, "outBack")
		X.at(49.35) hero:to(H.GUARD, 0.3, "outBack")

		------------------------------------------------ 49,6 - 58 s : le duel
		-- A. balayage horizontal : il se baisse, la lame passe au-dessus, contre-attaque bloquée
		X.at(49.6)
		Kit.cam(twoShot(hero, boss, 1, 5, 2.2, 52, -0.12, 1), 0.3)
		boss.gaitMask = {RightShoulder = true, LeftShoulder = true, Grip = true, Root = true}
		Kit.fork(function() dash(boss, g(6.9, 0.5), 0.44, VIOLET, false) end) -- onze studs d'un trait
		boss:to(B.HWIND, 0.45, "inOut")
		X.at(50.08) boss:gait(nil, 0.05)
		hero:to(H.DUCK, 0.11, "outQuad", {lag = false})
		X.at(50.14)
		boss:to(B.HSTRIKE, 0.14, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 0.7, 0.6)
		Kit.delay(0.06, function() swoosh(boss:center(1.2) + V(-2.5, 0, 0), V(0, 1, 0), VIOLET, 3.2, 0.3) end)
		X.at(50.36) -- il se relève en frappant ; le Headless bloque
		boss:to(B.BLOCK, 0.14, "outQuad")
		slash(nil, H.RS, {cut = 0.11, hit = function()
			Blades.cross(1.2, 0.05) Kit.delay(0.16, Blades.uncross) clash(Blades.meet(1.2), 1.2)
			boss:hit(0.5)
		end})
		X.at(50.62) -- le Headless pivote et riposte : le héros bondit en arrière
		boss:to(B.VWIND, 0.16, "outQuad")
		X.at(50.74)
		hero:to(H.CROUCH, 0.08) hero:body({air = 1}, 0.05)
		hero:move(g(-8.5, -0.6), 0.36, "outQuad", {arc = 1.5}) Kit.ghost(hero, CYAN, 0.3, 0.55)
		X.at(50.8)
		boss:to(B.VSTRIKE, 0.1, "outQuart", {lag = false})
		Kit.delay(0.09, function()
			Fx.burst("Crack-01", boss:point(4.5) + V(0, 0.15, 0), {scale = 1.6})
			dust(boss:point(4.5), 1.3) Kit.snd(S.Thud, 0.8, 0.5) Kit.shake(0.6)
		end)
		X.at(51.08) hero:body({air = 0}, 0.05) hero:to(H.SKID, 0.1) dust(hero.pos, 0.7)

		-- B. le Headless charge ; pas de côté, coup dans le flanc
		X.at(51.25)
		Kit.cam(function(t) return Kit.look(g(-3, -18, 2.6), (hero:center() + boss:center()) / 2, 56) end, 0.3)
		boss:to(B.DASHWIND, 0.28, "inOut")
		Fx.burst("Wind-02", boss:center(-2), {scale = 2})
		hero:to(H.GUARD, 0.2, "outBack")
		X.at(51.55)
		boss:to(B.THRUST, 0.1, "outQuart")
		Kit.fork(function() dash(boss, g(-13, -0.4), 0.24, VIOLET, false) end)
		Kit.fork(function() for i = 1, 4 do Kit.wait(0.05) Fx.burst("Crack-01", boss.pos + V(0, 0.15, 0), {scale = 1}) end end)
		Kit.snd(S.Thunder, 0.4, 1.4)
		X.at(51.56)
		hero:to(merge(H.SKID, {Waist = {-20, 0, -18}}), 0.08)
		hero:body({roll = 0.35}, 0.08)
		Kit.fork(function() dash(hero, g(-8.6, 7.6), 0.17, CYAN, true) end)
		X.at(51.78)
		hero:body({roll = 0}, 0.12)
		hero:face(boss, 0.12)
		X.at(51.86)
		hero:move(g(-11, 3.2), 0.16, "outCubic")
		slash(H.HW, H.HS, {wind = 0.1, hit = function()
			wound(boss, boss:center(1), 1, VIOLET)
			boss:to(B.RECOIL, 0.12)
			X.skid(boss, hero.pos, 5, 0.3)
		end})
		X.at(52.3) boss:face(hero, 0.3) boss:to(B.GUARD, 0.3, "outBack") hero:to(H.GUARD, 0.25, "outBack")

		-- C. trois attaques, trois parades
		X.at(52.6)
		Kit.cam(twoShot(hero, boss, -1, 4, 2.8, 50, 0.3, 1.4), 0.25)
		boss:move(boss.pos + (hero.pos - boss.pos).Unit * V(1, 0, 1) * 2.8, 0.2, "outQuad") -- il revient au contact
		boss:to(B.VWIND, 0.2, "outQuad")
		X.at(52.76) hero:to(H.BLOCKHI, 0.12, "outQuad", {lag = false})
		X.at(52.82) boss:to(merge(B.VSTRIKE, {RightShoulder = {95, 0, -8}, LeftShoulder = {95, 0, 10}, Grip = {-60}, Root = {-12}}), 0.09, "outQuart", {lag = false})
		X.at(52.85) Blades.cross(1.4, 0.05)
		X.at(52.9)
		clash(Blades.meet(1.4), 1.4) Kit.delay(0.12, Blades.uncross)
		hero:body({sink = 0.5}, 0.08) X.h1 = X.skid(hero, hero.pos + V(-7, 0, -0.4), 7, 0.3) -- chaque coup paré le fait reculer de sept studs
		X.at(53.05) hero:body({sink = 0}, 0.15) boss:to(merge(B.HWIND, {Root = {0, 45, 0}, RightShoulder = {70, 0, -60}}), 0.2, "outQuad") Kit.fork(function() dash(boss, X.h1 + V(-5.6, 0, -0.6), 0.18, VIOLET, false) end) -- revers
		X.at(53.22) hero:to(merge(H.BLOCK, {Grip = {-85, -40, 0}, RightShoulder = {95, 0, 25}, Waist = {-6, -25, 0}}), 0.1, "outQuad", {lag = false})
		X.at(53.27) boss:to(merge(B.HSTRIKE, {Root = {-8, -45, 0}, RightShoulder = {70, 0, 50}}), 0.09, "outQuart", {lag = false})
		X.at(53.3) Blades.cross(1.0, 0.05)
		X.at(53.35) clash(Blades.meet(1.0), 1.2) hero:hit(0.5) Kit.delay(0.1, Blades.uncross) X.h2 = X.skid(hero, hero.pos + V(-7, 0, -0.6), 7, 0.28)
		X.at(53.5) boss:to(B.DASHWIND, 0.16, "outQuad")
		X.at(53.62) -- le troisième : il recule d'un bond
		hero:to(H.CROUCH, 0.07) hero:body({air = 1}, 0.05)
		hero:move(X.h2 + V(9.6, 0, 0.6), 0.32, "outQuad", {arc = 1.4}) Kit.ghost(hero, CYAN, 0.3, 0.55)
		X.at(53.68) boss:to(B.THRUST, 0.09, "outQuart", {lag = false}) Kit.fork(function() dash(boss, X.h2 + V(1.6, 0, 0), 0.14, VIOLET, false) end) Kit.snd(S.Lunge, 0.6, 0.6)
		X.at(53.94) hero:body({air = 0}, 0.05) hero:to(H.SKID, 0.1) dust(hero.pos, 0.7)
		X.at(54.05) boss:to(B.GUARD, 0.3, "outBack")

		-- D. élan, saut, coup aérien bloqué, salto arrière, atterrissage
		X.at(54.15)
		Kit.cam(function(t) return Kit.look(g(8.5, -11.5, 1.0), (hero:center(1) + boss:center(2)) / 2, 58) end, 0.3)
		run(hero.pos + (boss.pos - hero.pos).Unit * V(1, 0, 1) * 2.4, 0.24, "inQuad")
		hero:to(H.CROUCH, 0.09, "outQuad")
		Kit.wait(0.09)
		local takeoff = hero.pos
		hero:body({air = 1}, 0.05)
		hero:to(H.AIR_WIND, 0.25, "outQuad")
		local overBoss = boss.pos + (hero.pos - boss.pos).Unit * V(1, 0, 1) * 3.4
		hero:move(overBoss, 0.62, "linear", {arc = 8})
		dust(takeoff, 1) leaves(takeoff, 5) Kit.snd(S.Lunge, 0.6, 0.9)
		X.at(54.8) boss:to(B.BLOCKHI, 0.18, "outQuad")
		X.at(54.92)
		trail.Enabled = true
		hero:to(H.AIR_STRIKE, 0.1, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.6, 0.9)
		X.at(54.96) Blades.cross(0.4, 0.04)
		X.at(55.0) -- les deux lames se touchent en l'air
		clash(Blades.meet(0.4), 2.2)
		ring(boss.pos, WHITE, 5, 0.5)
		Fx.burst("Crack-01", boss.pos + V(0, 0.15, 0), {scale = 2})
		Kit.flash(0.25, WHITE, 0.6)
		boss:body({sink = 0.6}, 0.1)
		X.at(55.12) Blades.uncross(0.1) -- repoussé : salto arrière
		trail.Enabled = false
		boss:body({sink = 0}, 0.3)
		boss:to(merge(B.BLOCKHI, {RightShoulder = {120, 0, -20}, LeftShoulder = {120, 0, 20}, Root = {-10}}), 0.15, "outQuart")
		hero:to(merge(H.CROUCH, {RightShoulder = {60, 0, 50}, Grip = {-90}}), 0.15)
		local landing = boss.pos + (takeoff - boss.pos).Unit * V(1, 0, 1) * 11
		hero.pos = V(hero.pos.X, ORIGIN.Y, hero.pos.Z) + V(0, 4.2, 0)
		hero:move(landing + V(0, 0, 0), 0.6, "linear", {arc = 2.2})
		hero:body({pitch = math.pi * 2}, 0.55, "inOut")
		Kit.cam(function(t) return Kit.look(g(10, -12.5, 1.4), hero:center(), 50) end, 0.25)
		X.at(55.72)
		hero.pos = landing
		hero:body({air = 0, pitch = 0}, 0)
		hero:to(H.LAND, 0.09, "outQuad")
		hero:face(boss, 0.1)
		dust(landing, 1.2) leaves(landing, 6) ring(landing, WHITE, 2, 0.4) Kit.snd(S.Thud, 0.6, 1) Kit.shake(0.4)

		-- E. échange rapide : il tourne autour du Headless
		X.at(56.05)
		local center = boss.pos
		local a0 = math.atan2(hero.pos.Z - center.Z, hero.pos.X - center.X)
		local function around(k) local a = a0 + rad(k) return V(center.X + cos(a) * 4.4, ORIGIN.Y, center.Z + sin(a) * 4.4) end
		Kit.cam(function(t)
			local a = a0 - 1.9 + 0.9 * t
			return Kit.look(V(center.X + cos(a) * 12, ORIGIN.Y + 2.4, center.Z + sin(a) * 12), center + V(0, 3.4, 0), 54)
		end, 0.25)
		Kit.fork(function() dash(hero, around(0), 0.15, CYAN, true) end)
		Kit.wait(0.15)
		local reactions = {
			function() boss:to(B.BLOCK, 0.1, "outQuad") end,
			function() boss:to(merge(B.BLOCK, {Grip = {-70, -50, 0}, RightShoulder = {100, 0, 30}}), 0.1, "outQuad") end,
			function() boss:to(B.DODGE, 0.1, "outQuad") end,
			function() end,
		}
		local cuts = {{H.HW, H.HS}, {H.RW, H.RS}, {H.VW, H.VS}, {H.HW, H.HS}}
		for i = 1, 4 do
			boss:face(hero, 0.16)
			reactions[i]()
			slash(cuts[i][1], cuts[i][2], {wind = 0.08, cut = 0.08, hit = function()
				if i <= 2 then
					Blades.cross(1.2, 0.04) Kit.delay(0.1, Blades.uncross) clash(Blades.meet(1.2), 1)
				elseif i == 4 then
					wound(boss, boss:center(1.2), 1.5, VIOLET)
					boss:to(B.RECOIL, 0.12)
				end
			end})
			if i < 4 then
				hero:move(around(i * -30), 0.1, "outQuad")
				Kit.ghost(hero, CYAN, 0.22, 0.6)
				Kit.wait(0.07)
				hero:face(boss, 0.07)
			end
		end

		-- F. le coup de masse : il est projeté loin en arrière
		X.at(57.25)
		hero:to(H.GUARD, 0.25, "outBack")
		boss:to(B.ROAR, 0.25, "outBack") boss:face(hero, 0.2)
		Fx.burst("Hit-Purple", boss:center(2), {scale = 1.5})
		Kit.snd(S.Thunder, 0.6, 0.7) Kit.shake(0.4)
		Kit.cam(twoShot(hero, boss, 1, 6, 1.6, 54, 0.1, 1.6), 0.25)
		X.at(57.55)
		boss:to(B.VWIND, 0.4, "inOut")
		local bossFire = Fx.attach("Fire-01", gsBlade, {offset = CFrame.new(0, 0, -1), scale = 1.2, color = VIOLET})
		X.at(57.9) hero:to(H.BLOCKHI, 0.12, "outQuad", {lag = false})
		X.at(57.98) boss:to(merge(B.VSTRIKE, {RightShoulder = {70, 0, -8}, LeftShoulder = {72, 0, 10}}), 0.09, "inQuart", {lag = false})
		X.at(58.03) Blades.cross(1.3, 0.04)
		X.at(58.07)
		bossFire.stop()
		local slamAt = hero.pos
		clash(Blades.meet(1.3), 2.4, VIOLET) Blades.uncross(0.1)
		Fx.burst("Big-Crack-01", slamAt + V(0, 0.6, 0), {scale = 1.1, time = 0.3, color = VIOLET})
		Fx.burst("Ground-Impact", slamAt + V(0, 0.3, 0), {scale = 1})
		ring(slamAt, VIOLET, 6, 0.6)
		Fx.light(slamAt + V(0, 3, 0), VIOLET, 50, 9, 0.6)
		Kit.snd(BOOM, 0.9, 0.8) Kit.shake(1.5) Kit.flash(0.3, VIOLET, 0.6)
		local away = (hero.pos - boss.pos) * V(1, 0, 1)
		hero:to(H.SKID, 0.12)
		hero:move(hero.pos + away.Unit * 12.5, 0.7, "outCubic")
		Kit.fork(function() for _ = 1, 7 do Kit.wait(0.09) dust(hero.pos, 0.7) leaves(hero.pos, 1) end end)
		Kit.cam(function(t) return Kit.look(hero:point(7, 3, 2.2), hero:center(0.4), 44) end, 0.4)
		X.at(58.4) boss:to(B.IDLE, 0.8, "inOut")
		Kit.fadeSound(fight, 0.1, 0.8)
		X.at(58.85) -- il reprend son souffle
		hero:to(H.FATIGUE, 0.5, "inOut")
		hero.idle = 3.2
		X.at(59.4) Kit.cam(twoShot(hero, boss, -1, 6, 2.2, 46, 0.03), 0.6)
		X.at(60.3) Kit.cam(function(t) return Kit.look(hero:point(4.6 - 0.9 * t, -1.0, 3.4), hero:center(1.25), 30) end, 0.5) -- la caméra se rapproche
		X.at(61.3) -- il resserre sa prise
		hero.idle = 1
		hero:to(merge(H.GUARD, {LeftHip = {42, 0, -8}, LeftKnee = {-58}}), 0.3, "outBack")
		Fx.attach("Shiny-01", blade, {pulse = true, scale = 0.7})
		Kit.snd(S.Ping, 0.4, 0.7)
		Kit.fadeSound(fight, 0.6, 0.6)

		------------------------------------------------ 61,6 - 67 s : le dernier échange
		X.at(61.7)
		Kit.cam(twoShot(hero, boss, 1, 5, 1.5, 50, 0.08), 0.3)
		hero:to(H.IAI, 0.45, "inOut")
		local bolt = Fx.attach("Lighting-03", blade, {offset = CFrame.new(0, 0, -1.6), scale = 0.8})
		local bolt2 = Fx.attach("Charge-01", blade, {offset = CFrame.new(0, 0, -1.6), scale = 0.9, color = CYAN})
		local blue = Instance.new("PointLight")
		blue.Color, blue.Range, blue.Brightness, blue.Shadows = CYAN, 18, 4, false
		blue.Parent = blade
		trail.Color = ColorSequence.new(CYAN)
		Kit.snd(S.Spark, 0.5, 1.2)
		boss:to(B.DASHWIND, 0.5, "inOut")
		local violet = Fx.attach("Fire-01", gsBlade, {offset = CFrame.new(0, 0, -1), scale = 1.2, color = VIOLET})
		X.at(62.45) -- ils se croisent
		Kit.fadeSound(fight, 0, 0.15)
		local hFrom, bFrom = hero.pos, boss.pos
		local line = (bFrom - hFrom) * V(1, 0, 1)
		local dirU = line.Unit
		Kit.speedLines(0.35, 0.8)
		Kit.flash(0.3, WHITE, 0.9)
		Kit.snd(S.Lunge, 0.8, 1.2) Kit.snd(SLASH_HIT, 0.9, 0.8)
		trail.Enabled = true
		hero:to(H.IAI_END, 0.12, "outQuart", {lag = false})
		boss:to(B.THRUST, 0.12, "outQuart", {lag = false})
		local midG = (hFrom + bFrom) / 2
		hero:move(midG + dirU * 5.5, 0.13, "outCubic")
		boss:move(midG - dirU * 5.5, 0.13, "outCubic")
		for i = 1, 4 do Kit.ghost(hero, CYAN, 0.4, 0.4) Kit.ghost(boss, VIOLET, 0.4, 0.5) Kit.wait(0.035) end
		local mid = (hFrom + bFrom) / 2 + V(0, 3.2, 0)
		Fx.mesh("Shock", CFrame.lookAt(mid, mid + dirU) * CFrame.Angles(0, 0, rad(25)) * CFrame.Angles(rad(90), 0, 0), {color = CYAN, size0 = 0.6, size1 = 4.5, time = 0.4, transp0 = 0})
		X.at(62.62) -- dos à dos, immobiles
		trail.Enabled = false
		bolt.stop() bolt2.stop() violet.stop()
		hero.idle, boss.idle = 0.3, 0.3
		hero:watch(nil) boss:watch(nil)
		Kit.cam(function(t) return Kit.look(mid + V(-dirU.Z, 0, dirU.X) * (17 - 0.6 * t) + V(0, -2.2, 0), mid + V(0, 0.2, 0), 46) end)
		X.at(63.45) -- les coups apparaissent sur le Headless
		for i = 1, 3 do
			Fx.burst("Slashes-01", boss:center(0.5 + i * 0.7), {scale = 2})
			Fx.burst("Slash-Impact-01", boss:center(0.5 + i * 0.7), {scale = 1.8, color = CYAN})
			Kit.snd(SLASH_HIT, 0.7, 1 + i * 0.12)
			boss:hit(1.5)
			Kit.shake(0.4)
			Kit.wait(0.09)
		end
		X.at(63.8) -- la foudre tombe
		Fx.mesh("Thunder", CFrame.new(boss.pos + V(0, 18, 0)), {color = CYAN, size0 = V(4, 38, 4), size1 = V(9, 38, 9), time = 0.35, transp0 = 0})
		Fx.burst("Lighting-01-Big", boss.pos + V(0, 1, 0), {scale = 1.4, time = 0.4})
		Fx.burst("Explosion-01", boss:center(1), {scale = 0.8, time = 0.15, color = CYAN})
		Fx.burst("Big-Crack-01", boss.pos + V(0, 0.6, 0), {scale = 0.9, time = 0.3, color = CYAN})
		ring(boss.pos, CYAN, 6, 0.6)
		Fx.light(boss:center(3), CYAN, 70, 12, 0.8)
		Kit.snd(S.Thunder, 1, 1) Kit.snd(BOOM, 0.8, 1.1)
		Kit.shake(1.6) Kit.flash(0.4, WHITE, 0.95) Kit.hitstop(0.12)
		boss:hit(3)
		boss:to(B.RECOIL, 0.15)
		blue:Destroy()
		trail.Color = ColorSequence.new(rgb(210, 240, 255))
		X.at(64.2) -- il lâche son arme, tombe à genoux
		bossAura.stop()
		boss:to(B.KNEEL, 0.5, "inQuad")
		Fx.light(boss:center(2), rgb(150, 170, 255), 28, 2.4, 3.4)
		X.kneel = boss.pos + ((g(2, 0) - boss.pos) * V(1, 0, 1)).Unit * 15.5 + V(-(g(2, 0) - boss.pos).Z, 0, (g(2, 0) - boss.pos).X).Unit * 3.5 + V(0, 2.6, 0) -- vu depuis le centre de la clairière, jamais depuis les arbres
		Kit.cam(function(t) return Kit.look(X.kneel, boss:center(0.3), 44) end, 0.5)
		do
			local world = gsRoot.CFrame
			boss.joints.Grip = nil boss.val.Grip = nil boss.tw.Grip = nil
			gw:Destroy()
			for _, p in boss.rig:GetChildren() do
				local w = p:IsA("BasePart") and p:FindFirstChildOfClass("Weld")
				if w and w.Part0 == gsRoot then p.Parent = gs end
			end
			gsRoot.Anchored = true
			local down = CFrame.new(world.Position.X, ORIGIN.Y + 0.3, world.Position.Z) * CFrame.Angles(0, boss.yaw + 0.6, rad(90))
			Kit.tween(0.5, function(e) gsRoot.CFrame = world:Lerp(down, e) end, "inQuad", function() Kit.snd(S.Clang, 0.6, 0.6) dust(down.Position, 0.8) end)
		end
		X.at(64.75) dust(boss.pos, 1.2) Kit.snd(S.Thud, 0.7, 0.5) Kit.shake(0.3)
		X.at(65.2) -- puis s'effondre et se dissout
		boss.idle = 0
		boss:body({air = 1}, 0.05)
		boss:body({pitch = -1.45, lift = -(boss.stand - 0.6 * boss.scale)}, 0.6, "inQuad")
		Kit.delay(0.6, function() dust(boss:point(3), 1.8) leaves(boss:point(3), 8) Kit.snd(S.Thud, 0.8, 0.4) Kit.shake(0.5) end)
		-- pendant ce temps le héros secoue sa lame et rengaine
		hero.idle = 1
		hero:to(merge(H.ZANSHIN, {RightShoulder = {20, 0, 60}, Grip = {-95}}), 0.14, "outQuart") Kit.snd(S.Swing, 0.3, 1.6)
		X.at(65.9)
		Kit.cam(function(t) return Kit.look(hero:point(4.2, -2.8, 0.3), hero:center(0), 40) end, 0.5)
		local mouth = hero.hrp.CFrame:PointToObjectSpace((scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position)
		hero:to(merge({Waist = {-6, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}, Grip = {-150}, LeftHip = {10, 0, -5}, RightHip = {-6, 0, 5}, Neck = {-10, 10, 0}}, reach(mouth)), 0.5, "inOut")
		X.at(66.45)
		sheath(0.45)
		Kit.delay(0.45, function() Kit.snd(S.Unsheath, 0.5, 0.7) Fx.light(scabRoot, WHITE, 8, 2, 0.3) end)
		Fx.burst("Stars-01", boss:center(), {scale = 2.4, color = VIOLET})
		Fx.burst("Smoke-01", boss:center(), {scale = 2.6})
		boss:fade(0, 1.1)
		X.at(67.1) -- il se redresse et regarde la lune
		hero:to({LeftShoulder = {-4, 0, -8}, LeftElbow = {14}, RightShoulder = {-4, 0, 8}, RightElbow = {14}, Waist = {-2}, Neck = {8}}, 0.6, "inOut")
		hero:watch(g(200, 0, 60))
		Kit.fadeSound(music, 0.2, 1)
		Kit.cam(function(t) return Kit.look(hero.pos + V(-9 - 0.4 * t, 2.2, 3.5), hero.pos + V(14, 6.5, 0), 44) end, 0.8)
		X.at(68.6)
		Kit.fade(0, 1.0)
		X.at(69.8)
	end)

	---------------------------------------------------------------- remise en état
	if not ok and err ~= "FILM_ABORT" then warn("[SamuraiFilm] " .. tostring(err)) end
	for _, s in loops do if s then s:Destroy() end end
	Kit.fade(0, 0)
	Kit.finish()
	scene:Destroy()
	grade:Destroy()
	for prop, value in savedLighting do Lighting[prop] = value end
	if sunRays then sunRays.Enabled = sunRaysWere end
	if gameMusic and musicWasPlaying then gameMusic:Resume() end
	return ok, err
end

function M.stop() Kit.running = false end

return M
