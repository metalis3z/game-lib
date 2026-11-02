-- Cinématique "Samouraï contre la horde" (refaite) : appel téléphonique dans la forêt ; au bout du sentier un portail
-- violet s'ouvre et le Headless en sort ; il raccroche, dégaine, le Headless bondit ; duel ; puis un saut immense et la méga
-- boule de feu : le Headless est renvoyé dans son portail, qui aspire tout le monde vers l'arène (BossArenaServer).
-- Tout est joué côté client par FightFilm.Kit (acteurs, caméra) et FightFilm.Fx (effets de ALL VFX).
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
-- vol : le corps est couché par X.fly, les bras filent en arrière, la tête relevée regarde devant
H.FLY = {RightShoulder = {-25, 0, 22}, RightElbow = {55}, Grip = {-190}, LeftShoulder = {-38, 0, -22}, LeftElbow = {28}, Waist = {10}, Neck = {36},
	RightHip = {-14, 0, 6}, RightKnee = {-10}, LeftHip = {24, 0, -6}, LeftKnee = {-58}}
H.HOVER = {RightShoulder = {18, 0, 28}, RightElbow = {22}, Grip = {-70}, LeftShoulder = {10, 0, -26}, LeftElbow = {30}, Waist = {4}, Neck = {-14},
	RightHip = {8, 0, 6}, RightKnee = {-18}, LeftHip = {30, 0, -6}, LeftKnee = {-62}}
H.ORB = merge(H.HOVER, {LeftShoulder = {176, 0, -8}, LeftElbow = {12}, Neck = {18}, Waist = {12}}) -- la main gauche levée sous la boule de feu
H.THROWL = {LeftShoulder = {48, 0, 14}, LeftElbow = {8}, Waist = {-34, 20, 0}, Neck = {-18}, RightShoulder = {-30, 0, 40}, RightElbow = {30}, Grip = {-120},
	RightHip = {30}, RightKnee = {-70}, LeftHip = {-20}, LeftKnee = {-30}}
-- redescente : salto groupé, puis droit, le katana traîné derrière lui (comme en courant), la main gauche ouverte pour l'équilibre
H.DESCEND = {RightShoulder = {-25, 0, 22}, RightElbow = {55}, Grip = {-190}, LeftShoulder = {30, 0, -50}, LeftElbow = {25}, Waist = {-8}, Neck = {14},
	RightHip = {45, 0, 6}, RightKnee = {-70}, LeftHip = {20, 0, -6}, LeftKnee = {-40}}
H.TUCK = {RightHip = {100, 0, 6}, RightKnee = {-125}, LeftHip = {105, 0, -6}, LeftKnee = {-130}, Waist = {-30}, Neck = {-20},
	RightShoulder = {40, 0, 30}, RightElbow = {80}, Grip = {-110}, LeftShoulder = {50, 0, -30}, LeftElbow = {90}} -- groupé (salto, projection)

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
		-- le héros : ton avatar en R6 (comme en jeu, préparé par SamuraiFilmServer), sinon l'ancien en R15
		local rig = (rigs:WaitForChild("RexR6", 12) or rigs:WaitForChild("Rex", 20)):Clone()
		local R6 = rig:FindFirstChild("UpperTorso") == nil
		-- la peau blanche de l avatar sature sous les lumières du décor (mains comme du néon) : un ton plus bas, le temps du film
		for _, p in rig:GetChildren() do
			if p:IsA("BasePart") and p.Name ~= "Head" and p.Name ~= "HumanoidRootPart" and p.Color.R > 0.9 and p.Color.G > 0.9 and p.Color.B > 0.9 then p.Color = rgb(176, 172, 186) end
		end
		rig.Parent = scene
		local hrp0 = rig.HumanoidRootPart
		local function rel(part, att) return hrp0.CFrame:PointToObjectSpace(rig[part][att].WorldPosition) end
		local SH, EL, HAND
		if R6 then -- R6 : pas de coude, la main est le bas du bras
			SH, EL, HAND = V(1, 0.5, 0), V(1, 0.5, 0), V(1.5, -0.95, 0)
		else
			SH, EL = rel("RightUpperArm", "RightShoulderRigAttachment"), rel("RightLowerArm", "RightElbowRigAttachment")
			HAND = hrp0.CFrame:PointToObjectSpace(rig.RightHand.Position)
		end
		local hero = Kit.actor(rig, "Hero")
		if R6 then
			-- les poses ont été écrites pour un R15 (coudes) : sur un R6, le pli du coude est reporté sur l'épaule et sur la prise
			-- du katana, pour que la lame garde la même inclinaison
			local rawTo = hero.to
			hero.to = function(self, pose, dur, ease, o)
				local p = {}
				for k, v in pose do p[k] = v end
				local re, rs = pose.RightElbow, pose.RightShoulder
				if re and rs and (re[1] or 0) ~= 0 then
					p.RightShoulder = {(rs[1] or 0) + re[1] * 0.55, rs[2] or 0, rs[3] or 0}
					local gr = pose.Grip
					if gr then p.Grip = {(gr[1] or 0) + re[1] * 0.45, gr[2] or 0, gr[3] or 0} end
				end
				local le, ls = pose.LeftElbow, pose.LeftShoulder
				if le and ls and (le[1] or 0) ~= 0 then p.LeftShoulder = {(ls[1] or 0) + le[1] * 0.55, ls[2] or 0, ls[3] or 0} end
				return rawTo(self, p, dur, ease, o)
			end
		end
		hero.neckSmooth = 13 -- tête amortie : elle suit ses consignes comme un ressort, sans à-coups (Kit)
		local hand = R6 and rig["Right Arm"] or rig.RightHand
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
			return {RightShoulder = {best[1], best[2], best[3]}, RightElbow = {R6 and 0 or best[4]}}, bestD
		end

		-- fourreau à la hanche gauche, poignée vers l'avant ; katana rangé dedans
		local scab, scabRoot = Cast.scabbard()
		scab.Parent = scene
		local sw = Instance.new("Weld")
		sw.Part0, sw.Part1 = R6 and rig.Torso or rig.LowerTorso, scabRoot
		sw.C0 = CFrame.new(-0.85, R6 and -0.8 or 0.12, -0.35) * CFrame.Angles(0, rad(155), 0) * CFrame.Angles(rad(-18), 0, 0)
		sw.Parent = scabRoot
		local katana, kRoot, blade = Cast.katana()
		katana.Parent = scene
		local kw = Instance.new("Weld")
		kw.Part0, kw.Part1 = scabRoot, kRoot
		kw.Parent = kRoot
		local gripAtt = hand:FindFirstChild("RightGripAttachment")
		-- GRIP_FIX : la poignée traverse le poing (comme le manche du marteau) au lieu de prolonger l'avant-bras : toutes les poses
		-- tiennent la lame 40° plus relevée par rapport au bras
		local GRIP_FIX = CFrame.Angles(rad(40), 0, 0)
		local gripBase, gripTail = CFrame.new(gripAtt and gripAtt.Position or V(0, -0.1, -0.1)) * GRIP_FIX, CFrame.new(-Cast.KATANA_GRIP)
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
		-- (refonte) effets de la lame : une large lueur qui reste plus longtemps derrière la traînée, et des étincelles qui
		-- jaillissent le long de la lame pendant les coups ; tout suit la couleur de la traînée (bleu glacé, puis feu)
		local glowTrail = Fx.bladeTrail(blade, V(0, 0, 2.1), V(0, 0, -2.4), CYAN)
		glowTrail.Lifetime = 0.32
		glowTrail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1)})
		local bladeSparks = Instance.new("ParticleEmitter")
		bladeSparks.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		bladeSparks.Color = ColorSequence.new(WHITE, CYAN)
		bladeSparks.LightEmission, bladeSparks.LightInfluence = 1, 0
		bladeSparks.Rate = 0
		bladeSparks.Lifetime = NumberRange.new(0.2, 0.4)
		bladeSparks.Speed = NumberRange.new(1, 4)
		bladeSparks.SpreadAngle = Vector2.new(180, 180)
		bladeSparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.28), NumberSequenceKeypoint.new(1, 0)})
		bladeSparks.Shape = Enum.ParticleEmitterShape.Box
		bladeSparks.Parent = blade
		trail:GetPropertyChangedSignal("Enabled"):Connect(function()
			glowTrail.Enabled = trail.Enabled
			bladeSparks.Rate = trail.Enabled and 90 or 0
		end)
		trail:GetPropertyChangedSignal("Color"):Connect(function()
			glowTrail.Color = trail.Color
			bladeSparks.Color = ColorSequence.new(WHITE, trail.Color.Keypoints[1].Value)
		end)
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
			swoosh(hero:center(0.6) + (CFrame.Angles(0, hero.yaw, 0) * V(0, 0, -2.6)), opts.normal or V(0.15, 1, 0), opts.color or trail.Color.Keypoints[1].Value, (opts.size or 1) * 1.7, 0.34) -- (refonte) grand arc lumineux
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
		-- X.at : repères de l'ancien film pour tout ce qui suit la horde ; X.shift les recale après chaque passage ajouté
		X.shift = 0
		function X.at(t) Kit.at(t + X.shift) end
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
		------------------------------------------------ vol, courbes et grandes projections (combat à longue distance)
		local FLAT = V(1, 0, 1)
		local function flat(v)
			v = v * FLAT
			return v.Magnitude > 0.01 and v.Unit or V(1, 0, 0)
		end
		local function ground(p) return V(p.X, ORIGIN.Y, p.Z) end
		local function nearAngle(target, current) return current + ((target - current + math.pi) % (2 * math.pi) - math.pi) end
		-- courbes : chaque fonction rend path(u) -> position des pieds, u de 0 à 1
		function X.bez(p0, p1, p2, p3)
			return function(u)
				local a, b, c = p0:Lerp(p1, u), p1:Lerp(p2, u), p2:Lerp(p3, u)
				return a:Lerp(b, u):Lerp(b:Lerp(c, u), u)
			end
		end
		-- de `from` à `to` en s'écartant sur le côté (side, en studs ; le signe donne le côté) et en montant (rise)
		function X.curve(from, to, side, rise)
			local dir = flat(to - from)
			local off = V(-dir.Z, 0, dir.X) * (side or 0) + V(0, rise or 0, 0)
			return X.bez(from, from:Lerp(to, 0.3) + off * 1.33, from:Lerp(to, 0.7) + off * 1.33, to)
		end
		-- courbe qui part dans l'élan de l'acteur (sa direction de vol du moment) et arrive sur `to` : les enchaînements ne font pas d'angle
		function X.flow(actor, to, o)
			o = o or {}
			local from = actor.pos
			local d = (to - from).Magnitude
			local dirTo = d > 0.01 and (to - from).Unit or V(1, 0, 0)
			local perp = V(-dirTo.Z, 0, dirTo.X)
			local p1 = from + (actor.flyDir or dirTo) * d * (o.carry or 0.38)
			local p2 = to - (o.arrive or dirTo) * d * 0.3 + perp * (o.side or 0) + V(0, o.rise or 0, 0)
			return X.bez(from, p1, p2, to)
		end
		-- spirale autour d'un point ou d'un acteur : rayon r0 -> r1, angle a0 -> a1 (radians), hauteur y0 -> y1 au-dessus du sol
		function X.spiral(center, r0, r1, a0, a1, y0, y1)
			return function(u)
				local c = typeof(center) == "Vector3" and center or center.pos
				local a, r = a0 + (a1 - a0) * u, r0 + (r1 - r0) * u
				return V(c.X + cos(a) * r, ORIGIN.Y + y0 + (y1 - y0) * u, c.Z + sin(a) * r)
			end
		end
		-- vrille autour de la ligne droite from -> to (elle part et arrive sur la ligne)
		function X.cork(from, to, radius, turns)
			local dir = (to - from).Unit
			local side = flat(V(-dir.Z, 0, dir.X))
			local up = dir:Cross(side)
			return function(u)
				local a = u * turns * 2 * math.pi
				return from:Lerp(to, u) + (side * cos(a) + up * sin(a)) * radius * sin(u * math.pi)
			end
		end
		-- deux courbes bout à bout (la première occupe la part `split` du trajet)
		function X.chain(a, b, split)
			return function(u)
				if u < split then return a(u / split) end
				return b((u - split) / (1 - split))
			end
		end

		-- vol le long d'une courbe : le corps se tourne dans le sens du vol, pique ou se cabre, penche dans les virages.
		-- o.ease ; o.lean = bascule vers l'avant (1,15 = presque couché) ; o.ghost = couleur des silhouettes (false = aucune) ;
		-- o.yaw = "keep" : il ne se tourne pas (projection) ; o.tumble = tours sur lui-même ; o.trail(p, v) appelé le long du trajet ;
		-- o.settle = 0 : il garde son attitude de vol à l'arrivée (enchaînement) ; o.wait = false : ne bloque pas
		function X.fly(actor, path, dur, o)
			o = o or {}
			actor.btw.pos, actor.btw.yaw, actor.btw.pitch, actor.btw.roll = nil, nil, nil, nil
			actor:body({air = 1}, 0.05)
			local lean = o.lean or 1.15
			local pitch0 = actor.pitch
			local lastGhost, lastTrail = -1, -1
			Kit.tween(dur, function(e, u)
				local p = path(e)
				local q = e < 0.98 and path(e + 0.02) or p + (p - path(e - 0.02))
				local v = q - p
				if p.Y < ORIGIN.Y then p = ground(p) end -- jamais sous le sol
				actor.pos = p
				if v.Magnitude > 1e-3 then actor.flyDir = v.Unit end
				if o.yaw ~= "keep" and (v * FLAT).Magnitude > 1e-3 then
					local yaw = nearAngle(math.atan2(-v.X, -v.Z), actor.yaw)
					local turn = (yaw - actor.yaw) * 0.4 -- il tourne en douceur, jamais d'un coup
					actor.yaw += turn
					actor.roll += (clamp(turn * 14, -1, 1) - actor.roll) * 0.2
				end
				if o.flip then -- un salto avant sur la première partie du vol, puis bien droit (jamais la tête en bas à l'arrivée)
					local k = math.min(u / o.flip, 1)
					actor.pitch = -2 * math.pi * k * k * (3 - 2 * k)
				elseif o.tumble then
					actor.pitch = pitch0 + o.tumble * 2 * math.pi * u
				elseif v.Magnitude > 1e-3 then
					local elev = math.atan2(v.Y, (v * FLAT).Magnitude)
					local start = math.min(u / 0.12, 1)
					local stop = o.settle == 0 and 1 or math.min((1 - u) / (o.settle or 0.14), 1)
					actor.pitch = (elev - lean) * start * stop + pitch0 * (1 - start) -- il s'allonge au départ, se redresse à l'arrivée
				end
				if o.ghost ~= false and u - lastGhost > (o.every or 0.045) / dur then
					lastGhost = u
					Kit.ghost(actor, o.ghost or CYAN, 0.3, 0.55)
				end
				if o.trail and u - lastTrail > 0.06 / dur then
					lastTrail = u
					o.trail(p, v)
				end
			end, o.ease or "inOut", function()
				if o.tumble or o.settle ~= 0 then actor.pitch = o.endPitch or 0 end
				if o.settle ~= 0 then actor.roll = 0 end
				if o.done then o.done() end
			end)
			if o.lines then Kit.speedLines(dur + 0.1, o.lines) end
			if o.wait ~= false then Kit.wait(dur) end
		end
		-- il se pose : les pieds retrouvent le sol, le corps se redresse
		function X.land(actor, pose, dustScale)
			actor.pos = ground(actor.pos)
			actor:body({air = 0, pitch = 0, roll = 0}, 0.08)
			if pose then actor:to(pose, 0.1, "outQuad") end
			actor:body({sink = 0.35 * actor.scale}, 0.07, "outQuad")
			Kit.delay(0.08, function() actor:body({sink = 0}, 0.22, "outBack") end)
			dust(actor.pos, dustScale or 1) leaves(actor.pos, 4)
		end
		-- projection : il est emporté sur une longue distance, tournoie, laboure le sol quand il le rase, s'écrase à l'arrivée
		function X.blast(actor, to, dur, o)
			o = o or {}
			actor:gait(nil, 0.05)
			local path = X.curve(actor.pos, to, o.side or 0, o.rise or 6)
			X.fly(actor, path, dur, {yaw = "keep", tumble = o.tumble or 1.5, ghost = o.ghost or false, ease = o.ease or "outQuad", lines = o.lines, wait = false, every = 0.06,
				trail = function(p)
					if p.Y - ORIGIN.Y < 2.2 then dust(ground(p), 0.9 * actor.scale) leaves(ground(p), 1) end
				end,
				done = function()
					if o.crash ~= false then
						dust(ground(to), 1.5 * actor.scale) leaves(ground(to), 5)
						Kit.snd(S.Thud, 0.6, 0.6) Kit.shake(0.4)
					end
					if o.done then o.done() end
				end})
		end
		-- glissade : repoussé sur une longue distance, mais debout, les pieds labourent le sol
		function X.slide(actor, to, dur, pose)
			actor:gait(nil, 0.05)
			actor:body({air = 0, pitch = 0, roll = 0}, 0.05)
			if pose then actor:to(pose, 0.12, "outQuad") end
			actor:move(ground(to), dur, "outCubic")
			Kit.fork(function()
				for _ = 1, math.floor(dur / 0.05) do
					Kit.wait(0.05)
					dust(actor.pos, 0.7 * actor.scale) leaves(actor.pos, 1)
					if math.random() < 0.4 then Fx.burst("Crack-01", actor.pos + V(0, 0.4, 0), {scale = 0.5 * actor.scale, time = 0.2}) end
				end
			end)
		end
		-- saut soigné du héros : appui (les jambes plient), détente, groupé avec salto si demandé, réception amortie
		function X.jump(to, height, dur, o)
			o = o or {}
			hero:gait(nil, 0.05)
			hero:to(H.CROUCH, 0.1, "outQuad")
			hero:body({sink = 0.3}, 0.1, "outQuad")
			hero:face(to, 0.1)
			Kit.wait(0.11)
			hero:body({sink = 0}, 0.04)
			dust(hero.pos, 0.8) leaves(hero.pos, 3)
			Kit.snd(S.Lunge, 0.5, 0.9)
			hero:to(H.AIR_WIND, 0.12, "outQuad")
			local from = hero.pos
			local path = function(u) return from:Lerp(to, u) + V(0, height * 4 * u * (1 - u), 0) end
			Kit.delay(dur * 0.3, function() hero:to(o.flip and H.TUCK or H.AIR_STRIKE, dur * 0.25, "inOut") end)
			Kit.delay(dur * 0.72, function() hero:to(H.AIR_STRIKE, dur * 0.2, "outQuad") end)
			X.fly(hero, path, dur, {yaw = "keep", tumble = o.flip or 0, ghost = o.ghost or CYAN, every = 0.07, ease = "linear", lines = o.lines})
			X.land(hero, H.LAND, 1.1)
			Kit.snd(S.Thud, 0.5, 0.8) Kit.shake(0.3)
			ring(hero.pos, o.color or CYAN, 3, 0.4)
		end

		-- caméras pour l'action à longue distance
		-- poursuite : derrière et au-dessus du sujet, dans l'axe de son déplacement, avec de l'inertie
		function X.chase(actor, back, up, fov, ahead)
			local camPos, last
			return function()
				local p = actor.hrp.Position
				local v = last and (p - last) or Vector3.zero
				last = p
				local dir = (v * FLAT).Magnitude > 0.05 and flat(v) or flat(CFrame.Angles(0, actor.yaw, 0) * V(0, 0, -1))
				local want = p - dir * back + V(0, up, 0)
				want = V(want.X, math.max(want.Y, ORIGIN.Y + 1.8), want.Z)
				camPos = camPos and camPos:Lerp(want, 0.14) or want
				return Kit.look(camPos, p + dir * (ahead or 8), fov or 64)
			end
		end
		-- accompagnement : la caméra reste à un décalage fixe du sujet (sur le côté, au-dessus...), avec de l'inertie
		function X.side(actor, offset, lookUp, fov, k)
			local camPos
			return function()
				local p = actor.hrp.Position
				local want = p + offset
				want = V(want.X, math.max(want.Y, ORIGIN.Y + 1.8), want.Z)
				camPos = camPos and camPos:Lerp(want, k or 0.2) or want
				return Kit.look(camPos, p + V(0, lookUp or 0, 0), fov or 58)
			end
		end
		-- plan d'ensemble : cadre tous les acteurs donnés, vus d'un angle et d'une élévation (degrés), d'aussi loin qu'il le faut
		function X.sky(actors, angle, elevation, fov, drift, extra)
			local mid, reach
			return function(t)
				local sum, n = Vector3.zero, 0
				for _, a in actors do if a.alive then sum += a.hrp.Position n += 1 end end
				local m = n > 0 and sum / n or hero.hrp.Position
				local r = 8
				for _, a in actors do if a.alive then r = math.max(r, (a.hrp.Position - m).Magnitude) end end
				mid = mid and mid:Lerp(m, 0.25) or m
				reach = reach and (reach + (r - reach) * 0.2) or r
				local dist = reach / math.tan(rad((fov or 60) * 0.5)) * 1.2 + (extra or 8)
				local ang, el = rad(angle) + (drift or 0) * t, rad(elevation or 26)
				local from = mid + V(cos(ang) * cos(el), sin(el), sin(ang) * cos(el)) * dist
				return Kit.look(V(from.X, math.max(from.Y, ORIGIN.Y + 2), from.Z), mid, fov or 60)
			end
		end

		-- gros impact dans le ciel ou au sol : onde, éclair, lumière, son
		function X.boom(pos, color, power)
			power = power or 1
			Fx.burst("Explosion-01", pos, {scale = 1.1 * power, time = 0.25, color = color})
			Fx.burst("Punch-02", pos, {scale = 2 * power})
			Fx.mesh("Shockwave", CFrame.new(pos), {color = color or WHITE, size0 = 0.4, size1 = 3.2 * power, time = 0.5, transp0 = 0.15})
			Fx.mesh("Sphere", CFrame.new(pos), {color = WHITE, size0 = 0.5, size1 = 2.2 * power, time = 0.3, transp0 = 0.1})
			Fx.light(pos, color or WHITE, 70 * power, 8, 0.5)
			Kit.snd(BOOM, 0.7, 1.1 + math.random() * 0.3)
			Kit.shake(0.8 * power)
		end
		-- cratère : le sol se fend, les débris sautent
		function X.crater(pos, color, power)
			power = power or 1
			pos = ground(pos)
			Fx.burst("Big-Crack-01", pos + V(0, 0.6, 0), {scale = 1.3 * power, time = 0.4, color = color})
			Fx.burst("Ground-Impact", pos + V(0, 0.3, 0), {scale = 1.3 * power})
			ring(pos, color or WHITE, 7 * power, 0.6)
			for i = 1, 6 do dust(pos + V(cos(i) * 4 * power, 0, sin(i) * 4 * power), 1.6 * power) end
			leaves(pos, 8)
			Kit.snd(BOOM, 0.9, 0.7) Kit.snd(S.Thud, 0.8, 0.5)
			Kit.shake(1.4 * power)
		end
		-- un monstre fauché au passage : coupé sans pause, il part à cent studs et explose en retombant
		function X.smash(mob, dir, color, dist)
			X.cut(mob, mob:center(0.8), 1.3, color)
			swoosh(mob:center(0.8), V(0.2, 1, 0), color, 2.2)
			mob.idle = 0
			mob:watch(nil)
			mob:to(E.RECOIL, 0.08, "outQuad")
			local to = ground(mob.pos) + dir * (dist or 100)
			X.blast(mob, to, 0.7, {rise = 14, tumble = 2.5, side = (math.random() - 0.5) * 30, done = function()
				Fx.burst("Explosion-01", to + V(0, 2, 0), {scale = 1.2, time = 0.25, color = color})
				ring(to, color or ORANGE, 4, 0.5)
				Fx.light(to + V(0, 3, 0), color or ORANGE, 40, 6, 0.5)
				vanish(mob, color, 0.02)
			end})
		end
		-- le héros traverse une cible en volant et frappe au passage (onHit(direction)) ; il arrive `over` studs plus loin, sans ralentir.
		-- o.at = où seront les pieds de la cible à son arrivée (si elle est en train d'être projetée)
		function X.through(target, dur, o, onHit)
			o = o or {}
			local aim = (o.at and (o.at + V(0, target.stand, 0)) or target.hrp.Position) - V(0, hero.stand * 0.55, 0)
			local through = ((aim - hero.pos) * (o.level and FLAT or V(1, 1, 1))).Unit
			local d1 = (aim - hero.pos).Magnitude
			local over = o.over or 22
			local exit = through.Y < -0.1 and (flat(through) + V(0, 0.15, 0)).Unit or through -- en piqué, il redresse après la cible
			local out = aim + exit * over + V(0, o.endRise or 0, 0)
			local split = d1 / (d1 + over)
			local path = X.chain(X.flow(hero, aim, {side = o.side, rise = o.rise, arrive = through}), X.bez(aim, aim + through * over * 0.2, out - exit * over * 0.4, out), split)
			hero:watch(target)
			hero:to(H.FLY, 0.1, "outQuad")
			trail.Enabled = true
			X.fly(hero, path, dur, {ghost = o.ghost or ORANGE, lines = 0.7, wait = false, settle = 0, ease = o.ease or "linear", every = 0.035, trail = o.trail})
			Kit.wait(math.max(dur * split - 0.06, 0))
			hero:to(o.strike or H.HS, 0.07, "outQuart", {lag = false})
			Kit.snd(S.Swing, 0.5, 1.2)
			Kit.wait(0.06)
			onHit(through)
			Kit.wait(math.max(dur * (1 - split), 0))
			hero:watch(nil)
		end
		-- la même traversée sur un monstre de la horde : fauché, il part à cent studs
		function X.pass(mob, dur, o)
			X.through(mob, dur, o, function(dir)
				if mob.alive then X.smash(mob, flat(dir), (o and o.color) or ORANGE, o and o.dist) end
			end)
		end
		-- la forêt soufflée : les arbres basculent vers l'extérieur l'un après l'autre, lanternes et citrouilles s'envolent
		function X.breakForest(center, speed)
			for _, b in blockers do b.CanQuery = false end -- plus de troncs debout entre la caméra et les personnages
			Kit.camSubject = nil
			for _, name in {"TreesNear", "TreesFar", "Lanterns", "Pumpkins", "Graves"} do
				local f = scene:FindFirstChild(name)
				for _, m in f and f:GetChildren() or {} do
					if m:IsA("Model") then
						local cf0 = m:GetPivot()
						local cfb, size = m:GetBoundingBox()
						local base = ground(cfb.Position)
						local away = flat(base - center)
						local small = size.Y < 12
						local axis = V(away.Z, 0, -away.X)
						local angle = small and rad(220 + math.random() * 260) or rad(72 + math.random() * 14)
						local push = small and (14 + math.random() * 22) or (1.5 + math.random() * 3)
						Kit.delay(((base - center) * FLAT).Magnitude / speed, function()
							if not m.Parent then return end
							for _, l in m:GetDescendants() do if l:IsA("Light") then l.Enabled = false end end
							Kit.tween(small and 1.0 or 1.2, function(e, u)
								local hop = small and V(0, 8 * 4 * u * (1 - u), 0) or Vector3.zero
								m:PivotTo(CFrame.new(base + away * push * e + hop) * CFrame.fromAxisAngle(axis, angle * e) * CFrame.new(-base) * cf0)
							end, small and "outQuad" or "inQuad", function()
								if not m.Parent then return end
								if small then m:Destroy() return end
								-- couché, il se consume et s'enfonce dans la cendre : le champ de bataille reste dégagé
								local lying = m:GetPivot()
								local depth = math.max(size.X, size.Z) + 6
								if math.random() < 0.5 then dust(base + away * 12, 2.4) Fx.burst("Fire-02", base + away * (8 + math.random() * 20) + V(0, 2, 0), {scale = 3, time = 0.7}) end
								Kit.tween(0.8, function(k) m:PivotTo(lying + V(0, -depth * k, 0)) end, "inQuad", function() m:Destroy() end)
							end)
							if not small and math.random() < 0.3 then leaves(base, 5) Kit.snd(S.Snap, 0.4, 0.5 + math.random() * 0.2) end
						end)
					end
				end
			end
			for _, name in {"Grass", "Leaves", "Mist", "Wisps", "Watchers"} do -- l'herbe et la brume sont soufflées
				local f = scene:FindFirstChild(name)
				if f then
					for _, d in f:GetDescendants() do
						if d:IsA("BasePart") then d.Transparency = 1 elseif d:IsA("ParticleEmitter") or d:IsA("Light") then d.Enabled = false end
					end
				end
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

		------------------------------------------------ (refonte) le portail violet, loin au bout du sentier, et le Headless qui en sort
		function X.portal(center, radius) -- (refonte) un trou noir : coeur noir, anneau de photons, disques d'accrétion, éclairs
			local BlackHole = require(ReplicatedStorage:WaitForChild("BlackHole"))
			local cf = CFrame.lookAt(center, center - V(1, 0, 0)) -- tourné vers le héros (-X)
			local bh = BlackHole.new(cf, radius, scene)
			local P = {center = center, radius = radius, cf = cf, bh = bh}
			function P.open(dur)
				Kit.snd(S.Thunder, 0.7, 0.4)
				Kit.snd(BOOM, 0.5, 0.35)
				Kit.shake(0.25)
				Fx.burst("Portal-Enter-01", center, {scale = radius / 2.2, color = VIOLET})
				Fx.light(center, VIOLET, 120, 5, 0.6)
				bh:open(dur)
			end
			function P.flare()
				bh:flare()
				Fx.mesh("Shockwave", cf * CFrame.Angles(rad(90), 0, 0), {color = VIOLET, size0 = radius * 0.5, size1 = radius * 4, time = 0.6, transp0 = 0.1})
				Kit.snd(BOOM, 0.6, 0.6)
			end
			function P.suck()
				bh:suck(1.5)
				local wind = loop(S.Ghost, 0.5, 0.35)
				Kit.fork(function()
					for _ = 1, 22 do
						if not Kit.running then return end
						Fx.mesh("Shockwave", cf * CFrame.new(0, 0, -6) * CFrame.Angles(rad(90), 0, 0), {color = VIOLET, size0 = radius * 4, size1 = radius * 0.4, time = 0.5, transp0 = 0.7, transp1 = 0.1, ease = "inQuad"})
						Kit.wait(0.12)
					end
				end)
				return wind
			end
			return P
		end
		local portal = X.portal(g(105, 0, 16), 13)

		-- le Headless (créé ici, invisible dans le portail ; il en sortira pendant l'appel)
		local boss = spawn("headless", g(110, 0), g(0, 0), 13)
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
			function Blades.meet(lift) return ((hand.CFrame * gripBase).Position + bossHand()) / 2 + V(0, lift or 1.5, 0) end
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
		local bossAura
		function X.emerge() -- il traverse le vide du portail et s'avance, aura violette
			boss:fade(1, 0.9)
			bossAura = Fx.aura("Fire-Aura-01", boss, {color = VIOLET, scale = 1.5, limbs = {Torso = true, ["Right Arm"] = true, ["Left Arm"] = true}})
			Fx.burst("Smoke-01", portal.center - V(3, 10, 0), {scale = 3})
			Fx.burst("Hit-Purple", portal.center - V(3, 6, 0), {scale = 2.4})
			Kit.snd(S.Thunder, 0.5, 0.5)
			boss.gaitMask = {RightShoulder = true}
			boss:gait("headlessWalk", 0.2, function() dust(boss.pos, 1) Kit.snd(S.Thud, 0.45, 0.45) Kit.shake(0.12) end)
			boss:move(g(94, 0), 2.2, "inOut")
			Kit.delay(2.2, function() boss:gait(nil, 0.3) end)
		end
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
		Kit.at(6.4) hero:gait(nil, 0.22) hero.gaitMask = nil -- un grondement sourd : il s'arrête de parler
		Kit.snd(S.Thunder, 0.35, 0.35) Kit.shake(0.12)
		Kit.fadeSound(wind, 0.12, 1.5)
		Kit.fadeSound(music, 0.06, 1.5)
		hero.look = PATH + V(0, 3, 0)
		hero:watch(PATH + V(0, 3, -14), 0.55)
		hero:to(merge(ear, {RightShoulder = {ear.RightShoulder[1] - 14, ear.RightShoulder[2], ear.RightShoulder[3] + 6}, Waist = {-2, -14, 0}}), 0.5, "outQuad", {only = true}) -- le bras descend un peu
		flickerAmp = 2.2
		Kit.delay(0.4, function() portal.open(1.5) end) -- au bout du sentier, loin derrière lui, un portail violet s'ouvre
		Kit.at(7.5) Kit.say("...Hold on.", 1.5)
		Kit.at(8.1)
		Kit.snd(S.Ghost, 0.3, 0.8)
		Kit.shake(0.1)
		Kit.cam(function(t) -- par-dessus son épaule : le sentier noir, la lune
			return Kit.look(g(-4.6 + 0.2 * t, -2.4, 4.3), g(30, 2, 4), 40)
		end)
		hero:watch(PATH + V(0, 3, 0), 1)
		Kit.at(8.9) X.emerge() -- le Headless sort du portail
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
		Kit.at(11.5) -- devant le portail, le Headless rugit
		Kit.cam(function(t) return Kit.look(boss:point(15 - 0.9 * t, 5, 3), boss:center(3.5), 46) end)
		boss:to(B.ROAR, 0.25, "outBack")
		Fx.burst("Hit-Purple", boss:center(3), {scale = 2})
		Kit.snd(S.Thunder, 0.6, 0.6) Kit.shake(0.35)
		portal.flare()
		Kit.at(12.4) flickerAmp = 1
		boss:to(B.IDLE, 0.6, "inOut")
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

		------------------------------------------------ 14,4 s : (refonte) il dégaine ; le Headless bondit hors du portail
		local fight = loop(MUSIC_FIGHT, 0, 1)
		Kit.fadeSound(music, 0, 0.6)
		Kit.fadeSound(fight, 0.45, 2)
		Kit.at(14.5)
		hero:watch(boss)
		hero:to({RightHip = {-22, 0, 8}, RightKnee = {-20}, LeftHip = {26, 0, -8}, LeftKnee = {-34}, Waist = {-8, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}}, 0.3, "outQuad", {only = true})
		Kit.at(14.8)
		Kit.cam(function(t) return Kit.look(hero:point(3.6, -2.6, 0.6), hero:center(-0.3), 40) end) -- la main sur la poignée
		do
			local handle = hero.hrp.CFrame:PointToObjectSpace((scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position)
			hero:to(reach(handle), 0.28, "inOut", {only = true, lag = false})
		end
		Kit.at(15.12)
		grab(0.22)
		Kit.snd(S.Unsheath, 0.7, 1)
		hero:to({RightShoulder = {70, 0, 45}, RightElbow = {12}, Grip = {-70}, Waist = {-6, -30, 0}, Root = {0, -10, 0}}, 0.3, "outCubic", {only = true}) -- la lame sort
		trail.Enabled = true
		Kit.delay(0.16, function() Fx.attach("Shiny-01", blade, {pulse = true, scale = 0.6}) Fx.light(blade, CYAN, 12, 4, 0.5) end)
		Kit.at(15.45)
		trail.Enabled = false
		hero:to(H.GUARD, 0.3, "outBack")
		Kit.cam(function(t) return Kit.look(hero:point(-5.5, 2.2, 2.4), boss:center(4), 46) end, 0.3) -- par-dessus son épaule : le Headless devant le portail
		Kit.at(15.9) -- il s'accroupit et bondit
		boss:to(B.DASHWIND, 0.22, "outQuad")
		boss:body({sink = 0.6}, 0.2, "outQuad")
		Kit.snd(S.Thunder, 0.5, 0.8)
		Kit.at(16.15)
		boss:body({sink = 0}, 0.05)
		Fx.burst("Crack-01", boss.pos + V(0, 0.4, 0), {scale = 2.2, time = 0.3})
		dust(boss.pos, 2)
		Kit.cam(function(t) return Kit.look(hero:point(-10, 3, 7), boss:center(1), 62) end, 0.15) -- par-dessus l'épaule du héros : le Headless fond sur lui
		X.fly(boss, X.curve(boss.pos, g(29, 0), 0, 22), 1.05, {lean = 0.35, ghost = VIOLET, every = 0.06, ease = "inOut"})
		X.land(boss, B.GUARD, 2.2)
		X.crater(boss.pos, VIOLET, 1.1)
		Kit.flash(0.2, VIOLET, 0.5)
		hero:to(H.GUARD, 0.2, "outBack")
		-- la suite (la montée de caméra, le face à face, le duel) garde les repères de l'ancien film : X.at les recale
		X.shift = Kit.time - 41.9
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


		------------------------------------------------ le duel à longue distance (ajouté) : projections de cent studs, poursuite dans le ciel, chute en météorite
		-- joué dans une fonction à part ; la suite du duel reprend ensuite là où elle en était (X.shift est recalé sur sa durée)
		X.bossAir = function()
			local WEST = g(-98, -4)
			-- 0. il rugit et charge : le héros bloque, mais part à cent studs
			Kit.fadeSound(fight, 0.62, 0.3)
			Kit.cam(twoShot(hero, boss, -1, 6, 2.0, 54, 0.1, 1.4), 0.25)
			boss:to(B.ROAR, 0.22, "outBack")
			Fx.burst("Hit-Purple", boss:center(2), {scale = 1.6})
			Kit.snd(S.Thunder, 0.6, 0.7) Kit.shake(0.45)
			Kit.wait(0.4)
			boss:to(B.DASHWIND, 0.14, "outQuad")
			Kit.wait(0.14)
			hero:to(H.BLOCK, 0.1, "outQuad", {lag = false})
			boss:to(B.THRUST, 0.09, "outQuart", {lag = false})
			Kit.fork(function() dash(boss, hero.pos + flat(boss.pos - hero.pos) * 4.2, 0.13, VIOLET, false) end)
			Kit.wait(0.11)
			Blades.cross(1.2, 0.04)
			Kit.wait(0.04)
			clash(Blades.meet(1.2), 2.2, VIOLET)
			X.boom(Blades.meet(1.2), VIOLET, 0.9)
			Blades.uncross(0.1)
			Kit.flash(0.2, VIOLET, 0.5)
			Kit.cam(X.side(hero, V(8, 6, -26), 0, 62, 0.22), 0.15) -- la caméra l'accompagne sur le côté pendant qu'il est emporté
			hero:to(H.TUCK, 0.12, "outQuad")
			X.blast(hero, WEST + V(14, 0, 0), 0.72, {rise = 4, tumble = -1.5, ghost = CYAN, lines = 0.8, crash = false})
			boss:to(B.GUARD, 0.4, "outBack")
			Kit.wait(0.72)
			X.land(hero, H.SKID, 1.5) -- il se rattrape et freine sur quatorze studs de plus
			hero:face(boss, 0.05)
			X.slide(hero, WEST, 0.4, H.SKID)
			Kit.wait(0.42)
			hero:to(H.GUARD, 0.25, "outBack")
			hero:watch(boss)

			-- 1. le Headless bondit : plus de cent studs d'une seule cloche, espadon levé ; le héros s'efface d'un grand pas courbe
			Kit.cam(X.sky({hero, boss}, -90, 10, 60, 0, 6), 0.3)
			boss:to(B.VWIND, 0.3, "inOut")
			Kit.snd(S.Lunge, 0.8, 0.5)
			local slamAt = hero.pos + V(3, 0, 0)
			X.fly(boss, X.curve(boss.pos, slamAt, 0, 62), 0.95, {lean = 0.5, ghost = VIOLET, every = 0.06, wait = false})
			Kit.wait(0.6)
			hero:to(H.FLY, 0.1, "outQuad")
			X.fly(hero, X.curve(hero.pos, hero.pos + V(8, 0, 30), -10, 4), 0.3, {ghost = CYAN, lean = 0.9, ease = "outQuad"})
			X.land(hero, H.SKID, 1)
			hero:face(slamAt, 0.08)
			Kit.wait(0.06)
			X.land(boss, nil, 2)
			boss:to(merge(B.VSTRIKE, {Root = {-36}}), 0.07, "outQuart", {lag = false})
			X.crater(slamAt, VIOLET, 1.5)
			Kit.flash(0.25, VIOLET, 0.6) Kit.hitstop(0.08)

			-- 2. contre-attaque : il s'enroule autour de lui en montant, six coups sans une pause, puis le coup qui le soulève
			Kit.cam(X.sky({boss, hero}, 60, 24, 58, 1.6, 10), 0.25)
			hero:to(merge(H.FLY, {RightShoulder = {72, 0, 62}, RightElbow = {8}, Grip = {-80}, Neck = {10, -40, 0}}), 0.1, "outQuad") -- la lame tendue vers lui
			trail.Enabled = true
			do
				local a0 = math.atan2(hero.pos.Z - boss.pos.Z, hero.pos.X - boss.pos.X)
				local r0 = ((hero.pos - boss.pos) * FLAT).Magnitude
				Kit.fork(function()
					for i = 1, 6 do
						Kit.wait(0.15)
						X.cut(boss, boss:center(0.6 + i * 0.7), 0.8, CYAN)
						boss:to(i % 2 == 0 and B.RECOIL or merge(B.RECOIL, {Root = {-14, -24, 0}}), 0.08, "outQuad")
					end
				end)
				X.fly(hero, X.spiral(boss, r0, 6.5, a0, a0 + 5 * math.pi, 0.5, 13), 1.0, {ghost = CYAN, every = 0.03, ease = "linear", lean = 1.0, settle = 0, lines = 0.6})
			end
			local skyPoint = g(-30, 34, 76)
			hero:face(ground(boss.pos), 0.05)
			hero:to(H.RS, 0.08, "outQuart", {lag = false})
			Kit.wait(0.07)
			wound(boss, boss:center(3), 1.8, CYAN)
			X.boom(boss:center(3), CYAN, 1)
			boss:to(B.RECOIL, 0.1)
			X.blast(boss, skyPoint, 0.6, {rise = 8, tumble = 1, ghost = VIOLET, crash = false})
			Kit.cam(X.sky({hero, boss}, 150, -6, 64, 0.5, 10), 0.3) -- d'en dessous : les deux silhouettes devant la lune

			-- 3. il le rattrape dans le ciel : trois traversées qui se croisent ; la troisième est parée, le choc les renvoie chacun à cent studs
			hero:to(H.FLY, 0.1)
			for i = 1, 2 do
				X.through(boss, i == 1 and 0.62 or 0.44, {side = i == 1 and 26 or -34, rise = i == 1 and 10 or -8, over = 30, ghost = CYAN, at = i == 1 and skyPoint or nil}, function(dir)
					X.cut(boss, boss.hrp.Position, 1.2, CYAN)
					swoosh(boss.hrp.Position, V(0.3, 1, 0.2), CYAN, 3)
					boss:to(B.RECOIL, 0.08)
					X.fly(boss, X.curve(boss.pos, boss.pos + dir * 12, 0, 2), 0.3, {yaw = "keep", tumble = 0, ghost = false, wait = false, ease = "outQuad"})
				end)
			end
			boss:to(B.BLOCK, 0.14, "outQuad")
			X.through(boss, 0.42, {side = 30, rise = 12, over = 0.5, ghost = CYAN, strike = H.VS}, function(dir)
				local at = boss.hrp.Position - dir * 3
				clash(at, 2.4, WHITE)
				X.boom(at, WHITE, 1.6)
				Fx.mesh("Shockwave", CFrame.new(at) * CFrame.Angles(rad(90), 0, 0), {color = VIOLET, size0 = 0.5, size1 = 9, time = 0.6, transp0 = 0.1})
				Kit.flash(0.3, WHITE, 0.8) Kit.hitstop(0.1)
				local apart = flat(dir)
				hero:to(H.TUCK, 0.12, "outQuad")
				X.blast(hero, hero.pos - apart * 100 + V(0, -22, 0), 0.6, {rise = 10, tumble = -1, ghost = CYAN, crash = false, lines = 0.7})
				X.blast(boss, boss.pos + apart * 96 + V(0, -6, 0), 0.6, {rise = 12, tumble = 1, ghost = VIOLET, crash = false})
			end)
			Kit.cam(X.sky({hero, boss}, -70, 6, 62, 0.25, 10), 0.3)
			Kit.wait(0.62)
			hero:to(H.HOVER, 0.2, "outBack") hero:face(ground(boss.pos), 0.15) hero:watch(boss)
			boss:to(B.HWIND, 0.25, "outBack") boss:face(ground(hero.pos), 0.15)

			-- 4. le Headless lance trois croissants violets : le héros slalome entre eux, en tranche un, et revient au contact
			for k = 1, 3 do
				Kit.delay(0.08 + k * 0.17, function()
					local from, to = boss:center(2), hero.hrp.Position + V((k - 2) * 16, (k % 2) * 10 - 5, (2 - k) * 12)
					Fx.projectile(from, from + (to - from).Unit * 240, 0.7, {color = VIOLET, size = 2.6})
					Fx.mesh("Shock", CFrame.lookAt(from, to) * CFrame.Angles(rad(90), 0, 0), {color = VIOLET, size0 = 1, size1 = 5, time = 0.3, transp0 = 0.1})
					boss:to(k % 2 == 1 and B.HSTRIKE or B.HWIND, 0.1, "outQuart", {lag = false})
					Kit.snd(S.Swing, 0.6, 0.7)
				end)
			end
			Kit.wait(0.3)
			do
				local aim = boss.hrp.Position - V(0, hero.stand * 0.55, 0)
				local from = hero.pos
				local dir = (aim - from).Unit
				local perp = V(-dir.Z, 0, dir.X)
				local d = (aim - from).Magnitude
				Kit.cam(X.chase(hero, 19, 8, 70, 16), 0.25)
				hero:to(H.FLY, 0.1, "outQuad")
				Kit.delay(0.4, function() -- un croissant en travers de sa route : il le fend
					hero:to(H.HS, 0.07, "outQuart", {lag = false})
					clash(hero.hrp.Position + dir * 3, 1.2, VIOLET)
					X.boom(hero.hrp.Position + dir * 3, VIOLET, 0.7)
					Kit.delay(0.12, function() hero:to(H.FLY, 0.1) end)
				end)
				X.fly(hero, X.bez(from, from + dir * d * 0.3 + perp * 46 + V(0, 14, 0), aim - dir * d * 0.3 - perp * 46 - V(0, 10, 0), aim - dir * 7.5), 0.86, {ghost = CYAN, lines = 0.8, ease = "linear", settle = 0, every = 0.03})
			end

			-- 5. lames bloquées en plein ciel : ils tombent ensemble comme une météorite jusqu'au milieu du champ de ruines
			hero:face(ground(boss.pos), 0.05) boss:face(ground(hero.pos), 0.05)
			hero:body({pitch = 0, roll = 0}, 0.1) boss:body({pitch = 0, roll = 0}, 0.1)
			hero:to(LOCK_H, 0.1, "outQuart", {lag = false})
			boss:to(LOCK_B, 0.1, "outQuart", {lag = false})
			Blades.cross(1.5, 0.08)
			Kit.wait(0.1)
			clash(Blades.meet(1.5), 2, WHITE)
			Kit.cam(X.sky({hero, boss}, -90, 4, 46, 0.6, 6), 0.2)
			do
				local falling = true
				Kit.fork(function()
					while falling and Kit.running do
						local p = Blades.meet(1.5)
						Fx.burst("Slash-Impact-01", p, {scale = 0.5})
						Fx.burst("Fire-02", p, {scale = 1.4, time = 0.3, color = VIOLET})
						hero:hit(0.25) boss:hit(0.18)
						Kit.wait(0.08)
					end
				end)
				local offset = boss.pos - hero.pos
				local landHero = g(6, 0) - flat(offset) * 3.6
				local landBoss = landHero + flat(offset) * offset.Magnitude
				Kit.wait(0.25)
				Kit.speedLines(0.9, 0.8)
				X.fly(boss, X.curve(boss.pos, landBoss, 0, 0), 0.8, {yaw = "keep", tumble = 0, ghost = VIOLET, wait = false, ease = "inQuad", every = 0.05})
				X.fly(hero, X.curve(hero.pos, landHero, 0, 0), 0.8, {yaw = "keep", tumble = 0, ghost = CYAN, ease = "inQuad", every = 0.05})
				falling = false
				Blades.uncross(0.1)
				local mid = (landHero + landBoss) / 2
				X.crater(mid, WHITE, 2)
				X.boom(mid + V(0, 3, 0), WHITE, 1.8)
				Fx.mesh("Shockwave", CFrame.new(mid + V(0, 1, 0)), {color = WHITE, size0 = 1, size1 = 34, time = 1.2, transp0 = 0.1, ease = "outQuad"})
				Kit.flash(0.4, WHITE, 0.9) Kit.hitstop(0.12)
				X.land(hero, H.SKID, 1.5) X.land(boss, B.RECOIL, 2)
			end
			-- le souffle les repousse chacun de cent studs, debout, les pieds dans la terre
			Kit.cam(X.sky({hero, boss}, -90, 22, 62, 0, 8), 0.2)
			do
				local axis = flat(boss.pos - hero.pos)
				X.slide(hero, hero.pos - axis * 100, 0.8, H.SKID)
				X.slide(boss, boss.pos + axis * 100, 0.8, B.RECOIL)
			end
			Kit.wait(0.85)
			hero:to(H.GUARD, 0.25, "outBack") boss:to(B.GUARD, 0.3, "outBack")
			hero:face(boss, 0.1) boss:face(hero, 0.1)
			Kit.wait(0.45)

			-- 6. deux traversées : ils foncent l'un sur l'autre en courbe, se choquent au milieu et échangent leurs places
			for k = 1, 2 do
				local hFrom, bFrom = hero.pos, boss.pos
				local hTo, bTo = ground(bFrom) + V(0, 0, k == 1 and -16 or 10), ground(hFrom) + V(0, 0, k == 1 and 14 or -8)
				local meet = (hFrom + bFrom) / 2 + V(0, k == 1 and 5 or 16, 0)
				local side = k == 1 and 30 or -36
				local axis = flat(bFrom - hFrom) * 4
				Kit.cam(k == 1 and X.chase(hero, 18, 7, 70, 14) or X.sky({hero, boss}, 90, 16, 64, 0, 8), 0.2)
				hero:to(H.FLY, 0.08, "outQuad") boss:to(B.DASHWIND, 0.1, "outQuad")
				trail.Enabled = true
				Kit.snd(BOOM, 0.5, 1.7)
				ring(hero.pos, CYAN, 4, 0.4) ring(boss.pos, VIOLET, 5, 0.4)
				X.fly(boss, X.chain(X.curve(bFrom, meet + axis, side, 4), X.curve(meet + axis, bTo, -side, 6), 0.5), 0.56, {lean = 0.7, ghost = VIOLET, wait = false, ease = "linear", every = 0.04})
				X.fly(hero, X.chain(X.curve(hFrom, meet - axis, side, 4), X.curve(meet - axis, hTo, -side, 6), 0.5), 0.56, {ghost = CYAN, wait = false, ease = "linear", every = 0.03, lines = 0.8})
				Kit.wait(0.21)
				hero:to(k == 1 and H.HS or H.RS, 0.07, "outQuart", {lag = false})
				boss:to(k == 1 and B.HSTRIKE or B.VSTRIKE, 0.07, "outQuart", {lag = false})
				Kit.wait(0.07)
				clash(meet + V(0, 3, 0), 2, WHITE)
				X.boom(meet + V(0, 3, 0), k == 1 and CYAN or VIOLET, 1.3)
				Kit.wait(0.28)
				X.land(hero, H.SKID, 1.2) X.land(boss, B.GUARD, 1.6)
				hero:face(boss, 0.12) boss:face(hero, 0.12)
				Kit.wait(0.2)
			end
			trail.Enabled = false

			-- 7. le Headless plante son espadon : une faille violette file vers le héros, qui saute par-dessus (salto) et revient au centre
			Kit.cam(X.sky({hero, boss}, -90, 14, 60, 0, 8), 0.3)
			boss:to(B.VWIND, 0.22, "outQuad")
			Kit.wait(0.22)
			boss:to(merge(B.VSTRIKE, {Root = {-36}}), 0.08, "outQuart", {lag = false})
			Kit.wait(0.08)
			X.crater(boss:point(4), VIOLET, 1)
			do
				local from, dir = boss:point(4), flat(hero.pos - boss.pos)
				local n = math.floor(((hero.pos - boss.pos) * FLAT).Magnitude / 12)
				for i = 1, n + 3 do
					Kit.delay(i * 0.035, function()
						local p = from + dir * i * 12
						Fx.burst("Big-Crack-01", p + V(0, 0.6, 0), {scale = 0.9, time = 0.3, color = VIOLET})
						Fx.mesh("Thunder", CFrame.new(p + V(0, 9, 0)), {color = VIOLET, size0 = V(2, 18, 2), size1 = V(4.5, 18, 4.5), time = 0.4, transp0 = 0.05})
						dust(p, 1.2)
						if i % 3 == 0 then Kit.snd(BOOM, 0.4, 1.4) Kit.shake(0.5) end
					end)
				end
			end
			Kit.wait(0.12)
			Kit.cam(X.side(hero, V(-6, 4, -28), 2, 62, 0.16), 0.2)
			X.jump(g(1, 0.6), 30, 0.85, {flip = -1, lines = 0.5})
			hero:face(boss, 0.15)
			hero:to(H.GUARD, 0.3, "outBack")
			-- et lui revient se placer en face, d'un bond
			Kit.cam(twoShot(hero, boss, 1, 6, 2.4, 54, 0.05), 0.4)
			boss:to(B.DASHWIND, 0.12, "outQuad")
			X.fly(boss, X.curve(boss.pos, g(18.3, 0), 0, 16), 0.55, {lean = 0.5, ghost = VIOLET, every = 0.06})
			X.land(boss, B.GUARD, 1.8)
			boss:face(hero, 0.15)
			Kit.snd(S.Thud, 0.7, 0.5) Kit.shake(0.4)
			Kit.wait(0.35)
		end
		do
			local t0 = Kit.time
			X.bossAir()
			X.shift += Kit.time - t0
		end

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

		------------------------------------------------ le duel dans le ciel (ajouté) : le feu revient, quatre coups à cent studs, quatre croisements en l'air, vague contre vague
		X.bossSky = function()
			local FIRE = rgb(255, 150, 50)
			-- 0. un genou à terre ; le Headless s'avance pour l'achever, espadon levé
			hero:watch(boss)
			hero:to(merge(H.LAND, {Neck = {22}}), 0.4, "inOut")
			hero.idle = 2.6
			Kit.cam(function(t) return Kit.look(hero:point(-6, 2.6, 1.3), boss:center(1.5), 52) end, 0.4)
			boss.gaitMask = {RightShoulder = true, LeftShoulder = true, Grip = true}
			boss:gait("headlessWalk", 0.2, function() dust(boss.pos, 0.8) Kit.snd(S.Thud, 0.5, 0.45) Kit.shake(0.15) end)
			boss:face(hero, 0.2)
			boss:move(hero.pos + flat(boss.pos - hero.pos) * 6.5, 0.95, "inOut")
			boss:to(B.VWIND, 0.85, "inOut")
			Kit.wait(0.95)
			boss:gait(nil, 0.1)
			-- 1. le feu revient d'un coup : l'onde repousse le Headless sur trente studs
			Kit.fadeSound(fight, 0.66, 0.3)
			Kit.say("My turn.", 1.0)
			hero.idle = 1
			hero:to(H.CHARGE, 0.14, "outBack")
			X.bladeFire = Fx.attach("Fire-01", blade, {offset = CFrame.new(0, 0, -1.2), scale = 0.9})
			X.heroAura = Fx.aura("Fire-Aura-01", hero, {scale = 0.9})
			trail.Color = ColorSequence.new(ORANGE)
			X.boom(hero:center(1), FIRE, 1.1)
			ring(hero.pos, FIRE, 9, 0.6)
			Kit.flash(0.25, FIRE, 0.6) Kit.hitstop(0.06)
			Kit.cam(twoShot(hero, boss, -1, 8, 3, 58, 0.1), 0.2)
			X.slide(boss, boss.pos + flat(boss.pos - hero.pos) * 30, 0.5, B.RECOIL)
			Kit.wait(0.4)
			-- 2. il décolle
			hero:to(H.HOVER, 0.3, "outBack")
			ring(hero.pos, FIRE, 5, 0.4) dust(hero.pos, 1.2)
			X.fly(hero, X.curve(hero.pos, hero.pos + V(0, 8, 0), 0, 0), 0.32, {ghost = ORANGE, lean = 1.57, ease = "outQuad"})

			-- 3. quatre coups : à chaque fois le Headless part à cent studs, le héros le devance en courbe et le renvoie
			local axis = flat(boss.pos - hero.pos)
			local function strike(to, dur, o) -- le coup lui-même : onde, éclair, le Headless est projeté vers `to`
				X.cut(boss, boss.hrp.Position, 1.6, FIRE)
				X.boom(boss.hrp.Position, FIRE, 1.1)
				swoosh(boss.hrp.Position, V(0.3, 1, 0.2), FIRE, 3.2)
				boss:to(B.RECOIL, 0.08)
				X.blast(boss, to, dur, merge({rise = 8, tumble = 1, ghost = VIOLET, crash = false}, o))
			end
			Kit.cam(X.sky({hero, boss}, math.deg(math.atan2(axis.Z, axis.X)) + 90, 12, 64, 0, 10), 0.25)
			local east = ground(boss.pos) + axis * 100 + V(0, 16, 0)
			X.through(boss, 0.3, {over = 8, ghost = ORANGE, ease = "inQuad"}, function() strike(east, 0.6) end)
			-- il passe au-dessus de lui et l'attend à l'arrivée
			X.fly(hero, X.flow(hero, east + axis * 9 + V(0, 2, 0), {rise = 30, side = 26}), 0.5, {ghost = ORANGE, lines = 0.8, settle = 0, ease = "linear", every = 0.03})
			hero:face(ground(boss.pos), 0.05)
			hero:to(H.HS, 0.07, "outQuart", {lag = false})
			Kit.wait(0.08)
			local west = east - axis * 112 + V(0, 8, 0)
			strike(west, 0.6, {tumble = -1})
			hero:to(H.FLY, 0.1)
			X.fly(hero, X.flow(hero, west - axis * 9 - V(0, 8, 0), {rise = -14, side = -30}), 0.5, {ghost = ORANGE, lines = 0.8, settle = 0, ease = "linear", every = 0.03})
			hero:face(ground(boss.pos), 0.05)
			hero:to(H.RS, 0.07, "outQuart", {lag = false}) -- coup remontant : il part vers le ciel
			Kit.wait(0.08)
			local high = west + V(0, 78, 0)
			Kit.cam(X.sky({hero, boss}, math.deg(math.atan2(axis.Z, axis.X)) + 60, -4, 66, 0.3, 12), 0.2)
			strike(high, 0.55, {rise = 0, side = 14})
			hero:to(H.FLY, 0.1)
			X.fly(hero, X.flow(hero, high + V(0, 13, 0), {side = 22, carry = 0.5}), 0.5, {ghost = ORANGE, lines = 0.8, ease = "linear", every = 0.03})
			-- le dernier, de haut en bas : il le renvoie au sol comme une météorite
			hero:to(H.AIR_WIND, 0.06, "outQuad")
			Kit.wait(0.07)
			hero:to(H.AIR_STRIKE, 0.06, "outQuart", {lag = false})
			local pit = ground(west)
			X.cut(boss, boss.hrp.Position, 2, FIRE)
			X.boom(boss.hrp.Position, FIRE, 1.4)
			Kit.flash(0.2, FIRE, 0.6)
			Kit.cam(function(t) return Kit.look(pit + V(-axis.Z, 0, axis.X) * 60 + V(0, 14, 0), pit + V(0, 20 - 14 * math.min(t / 0.35, 1), 0), 66) end, 0.15)
			X.fly(boss, X.curve(boss.pos, pit, 0, 0), 0.34, {yaw = "keep", tumble = 1.5, ghost = VIOLET, ease = "inQuad", every = 0.04, trail = function(p) Fx.burst("Fire-02", p, {scale = 2.4, time = 0.4, color = VIOLET}) end})
			X.land(boss, B.KNEEL, 2.5)
			X.crater(pit, FIRE, 2.2)
			X.boom(pit + V(0, 3, 0), VIOLET, 1.8)
			Fx.mesh("Shockwave", CFrame.new(pit + V(0, 1, 0)), {color = FIRE, size0 = 1, size1 = 40, time = 1.3, transp0 = 0.1, ease = "outQuad"})
			Kit.flash(0.4, WHITE, 0.9) Kit.hitstop(0.14)
			hero:to(H.HOVER, 0.3, "outBack")
			hero:watch(boss)
			hero:body({pitch = 0, roll = 0}, 0.2)

			-- 4. un silence ; puis la colonne violette : il ressort du cratère et monte à sa hauteur
			Kit.cam(function(t) return Kit.look(hero:point(-8, 4, 7), pit + V(0, 4, 0), 60) end, 0.4)
			Kit.wait(0.55)
			Fx.mesh("Thunder", CFrame.new(pit + V(0, 45, 0)), {color = VIOLET, size0 = V(7, 90, 7), size1 = V(17, 90, 17), time = 1.0, transp0 = 0.05})
			Fx.mesh("Tornado", CFrame.new(pit + V(0, 14, 0)), {color = VIOLET, size0 = 1.2, size1 = 3.4, time = 1.2, transp0 = 0.3, transp1 = 1, spin = 1.5})
			X.boom(pit + V(0, 4, 0), VIOLET, 1.6)
			Kit.snd(S.Thunder, 0.9, 0.6)
			boss:to(B.ROAR, 0.2, "outBack")
			local faceOff = hero.pos + axis * 46
			X.fly(boss, X.curve(pit, faceOff, 8, 4), 0.62, {lean = 1.2, ghost = VIOLET, every = 0.05})
			boss:body({pitch = 0, roll = 0}, 0.15)
			boss:face(ground(hero.pos), 0.12) hero:face(ground(boss.pos), 0.12)
			boss:to(B.GUARD, 0.25, "outBack")
			Kit.cam(X.sky({hero, boss}, math.deg(math.atan2(axis.Z, axis.X)) - 90, 4, 56, 0.25, 8), 0.3)
			Kit.wait(0.4)

			-- 5. quatre croisements dans le ciel : chacun arrive en courbe, un choc à chaque croisement, ils échangent leurs places
			trail.Enabled = true
			for k = 1, 4 do
				local hFrom, bFrom = hero.pos, boss.pos
				local mid = (hFrom + bFrom) / 2
				local up = ({V(0, 12, 0), V(0, -10, 0), V(0, 16, 0), V(0, 0, 0)})[k]
				local side = (k % 2 == 1 and 1 or -1) * (20 + k * 4)
				local between = (bFrom - hFrom).Unit * 4
				hero:to(H.FLY, 0.08, "outQuad") boss:to(k % 2 == 1 and B.DASHWIND or B.HWIND, 0.1, "outQuad")
				X.fly(boss, X.chain(X.curve(bFrom, mid + up + between, side, 3), X.curve(mid + up + between, hFrom + up * 0.5, -side, -3), 0.5), 0.46, {lean = 0.8, ghost = VIOLET, wait = false, ease = "linear", every = 0.04, settle = 0})
				X.fly(hero, X.chain(X.curve(hFrom, mid + up - between, side, 3), X.curve(mid + up - between, bFrom + up * 0.5, -side, -3), 0.5), 0.46, {ghost = ORANGE, wait = false, ease = "linear", every = 0.03, settle = 0, lines = 0.7})
				Kit.wait(0.17)
				hero:to(({H.HS, H.RS, H.VS, H.HS})[k], 0.06, "outQuart", {lag = false})
				boss:to(({B.HSTRIKE, B.VSTRIKE, B.HSTRIKE, B.THRUST})[k], 0.06, "outQuart", {lag = false})
				Kit.wait(0.06)
				local at = mid + up + V(0, hero.stand * 0.7, 0)
				clash(at, 1.6 + k * 0.2, WHITE)
				X.boom(at, k % 2 == 1 and FIRE or VIOLET, 1 + k * 0.15)
				Fx.mesh("Shockwave", CFrame.new(at) * CFrame.Angles(rad(60 + k * 30), k, 0), {color = WHITE, size0 = 0.5, size1 = 8 + k * 2, time = 0.5, transp0 = 0.1})
				Kit.wait(0.23)
			end
			trail.Enabled = false
			hero:body({pitch = 0, roll = 0}, 0.15) boss:body({pitch = 0, roll = 0}, 0.15)
			hero:face(ground(boss.pos), 0.12) boss:face(ground(hero.pos), 0.12)

			-- 6. ils chargent : vague de feu contre vague violette, elles se bloquent au milieu, puis tout saute
			Kit.cam(X.sky({hero, boss}, math.deg(math.atan2(axis.Z, axis.X)) + 90, 6, 58, -0.2, 8), 0.3)
			hero:to(H.HW, 0.35, "inOut") boss:to(B.HWIND, 0.35, "inOut")
			local c1 = Fx.attach("Charge-01", blade, {offset = CFrame.new(0, 0, -1.6), scale = 1.2, color = FIRE})
			local c2 = Fx.attach("Fire-01", gsBlade, {offset = CFrame.new(0, 0, -1), scale = 1.6, color = VIOLET})
			Kit.snd(S.Spark, 0.5, 0.8)
			Kit.wait(0.45)
			hero:to(H.HS, 0.08, "outQuart", {lag = false}) boss:to(B.HSTRIKE, 0.08, "outQuart", {lag = false})
			Kit.snd(S.Swing, 0.7, 0.8) Kit.snd(BOOM, 0.5, 1.6)
			c1.stop() c2.stop()
			local hc, bc = hero:center(1), boss:center(2)
			local center = (hc + bc) / 2
			local toward = (bc - hc).Unit
			local function wave(from, to, color) -- un grand croissant qui file jusqu'au milieu
				local face = CFrame.lookAt(from, to) * CFrame.Angles(0, 0, rad(90)) * CFrame.Angles(rad(90), 0, 0)
				local last = 0
				Kit.tween(0.22, function(e)
					if e - last > 0.2 then
						last = e
						local p = from:Lerp(to, e)
						Fx.mesh("Shock", face + (p - from), {color = color, size0 = 2.5, size1 = 6, time = 0.22, transp0 = 0.05})
						Fx.burst("Fire-Slash-01", p, {scale = 2.4, color = color ~= FIRE and color or nil})
					end
				end, "linear")
			end
			wave(hc, center - toward * 3, FIRE)
			wave(bc, center + toward * 3, VIOLET)
			Kit.wait(0.22)
			Kit.cam(function(t) return Kit.look(center + V(-toward.Z, 0.1, toward.X) * (40 - 6 * t) + V(0, -4, 0), center, 60) end, 0.15)
			do -- la lutte : deux sphères qui enflent l'une contre l'autre, tout tremble de plus en plus
				local a = Fx.mesh("Sphere", CFrame.new(center - toward * 4), {color = FIRE, size0 = 2, size1 = 9, time = 0.9, transp0 = 0.15, transp1 = 0.3, ease = "linear"})
				local b = Fx.mesh("Sphere", CFrame.new(center + toward * 4), {color = VIOLET, size0 = 2, size1 = 9, time = 0.9, transp0 = 0.15, transp1 = 0.3, ease = "linear"})
				Fx.light(center, WHITE, 120, 6, 0.9)
				for i = 1, 9 do
					Fx.burst("Slash-Impact-01", center + V(0, (i % 3 - 1) * 2, 0), {scale = 1 + i * 0.15})
					Fx.burst("Lighting-01", center, {scale = 1.2 + i * 0.1, time = 0.1})
					Kit.shake(0.3 + i * 0.12)
					if i % 3 == 0 then Kit.snd(S.Spark, 0.5, 0.8 + i * 0.05) end
					hero:hit(0.3) boss:hit(0.3)
					Kit.wait(0.1)
				end
			end
			Fx.mesh("Sphere", CFrame.new(center), {color = WHITE, size0 = 2, size1 = 16, time = 0.8, transp0 = 0, transp1 = 1})
			Fx.mesh("Explosion", CFrame.new(center), {color = FIRE, size0 = 1.5, size1 = 14, time = 1.6, transp0 = 0.3, transp1 = 1, fadeLate = true})
			Fx.mesh("Explosion", CFrame.new(center), {color = VIOLET, size0 = 1, size1 = 10, time = 1.3, transp0 = 0.35, transp1 = 1, fadeLate = true, spin = 0.3})
			Fx.mesh("Shockwave", CFrame.new(center), {color = WHITE, size0 = 1, size1 = 50, time = 1.2, transp0 = 0.1, ease = "outQuad"})
			Fx.burst("Realistic-Explosion-01", center, {scale = 4, time = 0.3})
			Fx.light(center, WHITE, 240, 8, 1.2)
			Kit.snd(BOOM, 1, 0.6) Kit.snd(S.Thunder, 1, 0.7)
			Kit.flash(0.6, WHITE, 1) Kit.hitstop(0.16)
			Kit.fork(function() for i = 1, 8 do Kit.shake(2.4 - i * 0.25) Kit.wait(0.1) end end)

			-- 7. le souffle les rejette vers le sol : le héros se rattrape et se pose, le Headless s'écrase debout
			X.bladeFire.stop() X.heroAura.stop()
			trail.Color = ColorSequence.new(rgb(210, 240, 255))
			hero:to(H.TUCK, 0.12, "outQuad") boss:to(B.RECOIL, 0.12)
			Kit.cam(X.sky({hero, boss}, -90, 16, 62, 0, 10), 0.3)
			X.blast(boss, g(21, 0), 0.75, {rise = 6, tumble = 1, ghost = VIOLET, done = function() X.land(boss, B.KNEEL, 2.2) X.crater(g(21, 0), VIOLET, 1) end})
			X.blast(hero, g(-7, 0), 0.75, {rise = 10, tumble = -1, ghost = false, crash = false})
			Kit.wait(0.75)
			X.land(hero, H.SKID, 1.4)
			hero:face(boss, 0.1) boss:face(hero, 0.2)
			X.slide(hero, g(-11, 0), 0.3, H.SKID)
			Kit.fadeSound(fight, 0.1, 0.8)
			Kit.wait(0.45)
			boss:to(B.IDLE, 0.8, "inOut")
			hero:watch(boss)
		end
		do
			local t0 = Kit.time
			X.bossSky()
			X.shift += Kit.time - t0
		end

		------------------------------------------------ (refonte) final : un saut immense, la MÉGA boule de feu ; le Headless est renvoyé
		-- dans son portail, qui se met à tout aspirer (et emmène tout le monde dans l'arène)
		local FIRE = rgb(255, 150, 50)
		X.at(58.9)
		hero:watch(boss)
		hero:to(merge(H.LAND, {Neck = {22}}), 0.35, "inOut")
		hero.idle = 2.4
		Kit.cam(function(t) return Kit.look(hero:point(-6, 2.6, 1.3), boss:center(1.5), 52) end, 0.4)
		X.at(59.6)
		Kit.fadeSound(fight, 0.7, 0.3)
		Kit.say("This ends now.", 1.2)
		hero.idle = 1
		hero:to(H.CHARGE, 0.14, "outBack")
		local heroAura = Fx.aura("Fire-Aura-01", hero, {scale = 0.9})
		local bladeFire = Fx.attach("Fire-01", blade, {offset = CFrame.new(0, 0, -1.2), scale = 0.9})
		trail.Color = ColorSequence.new(ORANGE)
		X.boom(hero:center(1), FIRE, 1.1)
		ring(hero.pos, FIRE, 9, 0.6)
		Kit.flash(0.25, FIRE, 0.6) Kit.hitstop(0.06)
		-- l'onde de feu couche toute la forêt autour de lui : le ciel est dégagé pour la suite
		Fx.mesh("Shockwave", CFrame.new(ground(hero.pos) + V(0, 0.5, 0)), {color = FIRE, size0 = 2, size1 = 90, time = 1.1, transp0 = 0.1, ease = "outQuad"})
		Fx.mesh("Shockwave", CFrame.new(ground(hero.pos) + V(0, 0.8, 0)), {color = rgb(255, 220, 160), size0 = 1, size1 = 60, time = 0.8, transp0 = 0.2, ease = "outQuad"})
		Kit.snd(BOOM, 0.9, 0.7)
		X.at(60.3) -- appui : les jambes plient, le sol se fend
		hero:to(H.CROUCH, 0.12, "outQuad")
		hero:body({sink = 0.4}, 0.12, "outQuad")
		Fx.burst("Crack-01", hero.pos + V(0, 0.4, 0), {scale = 1.4, time = 0.3})
		X.at(60.45) -- et il s'arrache du sol
		hero:body({sink = 0}, 0.04)
		X.crater(hero.pos, FIRE, 0.7)
		trail.Enabled = true
		local apex = hero.pos + flat(hero.pos - boss.pos) * 6 + V(0, 78, 0) -- au-dessus de la cime des arbres
		-- vu d'au-dessus des arbres : il jaillit de la cime au milieu d'une gerbe de feuilles et monte jusqu'à la caméra
		local launchCam = hero.pos + flat(hero.pos - boss.pos) * 58 + V(0, 84, 0) + flat(V(-(boss.pos - hero.pos).Z, 0, (boss.pos - hero.pos).X)) * 20
		Kit.cam(function(t) return Kit.look(launchCam + V(0, 4 * t, 0), hero:center(1), 56 - 4 * t) end, 0.15)
		local launchFrom = hero.pos
		Kit.delay(0.32, function() leaves(launchFrom + V(0, 52, 0), 10) Kit.snd(S.Snap, 0.5, 0.6) Fx.burst("Fire-02", hero:center(0), {scale = 3, time = 0.3}) end)
		X.fly(hero, X.curve(hero.pos, apex, 0, 6), 0.95, {ghost = ORANGE, lines = 0.7, ease = "outQuad", lean = 0.3})
		trail.Enabled = false
		hero:body({pitch = 0, roll = 0}, 0.2)
		hero:to(H.ORB, 0.3, "outBack") -- la main gauche levée au-dessus de lui
		hero:face(boss, 0.3)
		local hovering = true
		Kit.fork(function() -- il flotte, léger balancement
			while Kit.running and hovering do hero.lift = sin(Kit.time * 2.4) * 0.4 task.wait() end
			hero.lift = 0
		end)

		-- LA MÉGA BOULE DE FEU : un coeur blanc, la boule, un halo, une coque rouge ; trois anneaux de feu qui tournent autour
		-- sur trois axes, de l'air (des étincelles) aspiré de partout, des éclairs qui crépitent, le sol qui tremble de plus en plus
		local GROW, BALL_END = 2.4, 18
		local function orb(color, transparency)
			local part = Instance.new("Part")
			part.Shape = Enum.PartType.Ball
			part.Material, part.Color, part.Transparency = Enum.Material.Neon, color, transparency
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
			part.Size = V(1, 1, 1)
			part.Parent = scene
			return part
		end
		local ball, heart, halo, shell = orb(FIRE, 0.1), orb(rgb(255, 245, 205), 0), orb(rgb(255, 110, 30), 0.7), orb(rgb(255, 50, 20), 0.86)
		local rings = {}
		for i, c in {rgb(255, 205, 90), rgb(255, 120, 40), rgb(255, 240, 185)} do
			local r = film.Vfx.Meshes.Ring:Clone()
			r.Anchored, r.CanCollide, r.CanQuery, r.CanTouch, r.CastShadow = true, false, false, false, false
			r.Material, r.Color, r.Transparency = Enum.Material.Neon, c, 0.15
			r.Parent = scene
			rings[i] = r
		end
		local shellPart = orb(FIRE, 1) -- coque invisible : les étincelles naissent sur elle et filent vers la boule
		local inflow = Instance.new("ParticleEmitter")
		inflow.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		inflow.Color = ColorSequence.new(rgb(255, 240, 200), FIRE)
		inflow.LightEmission, inflow.LightInfluence = 1, 0
		inflow.Shape, inflow.ShapeInOut, inflow.ShapeStyle = Enum.ParticleEmitterShape.Sphere, Enum.ParticleEmitterShapeInOut.Inward, Enum.ParticleEmitterShapeStyle.Surface
		inflow.Rate, inflow.Lifetime, inflow.Speed = 90, NumberRange.new(0.35, 0.5), NumberRange.new(18, 30)
		inflow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0.1)})
		inflow.Parent = shellPart
		local ballLight = Instance.new("PointLight")
		ballLight.Color, ballLight.Range, ballLight.Brightness, ballLight.Shadows = FIRE, 50, 5, false
		ballLight.Parent = ball
		local ballSize, ballPos, ballFree = 1, hero:center(5), false
		local ballFx = {}
		Kit.fork(function() -- les flammes grossissent avec elle, par paliers
			for _, step in {1.2, 2, 3, 3.8, 4.6} do
				if ballFree or not ball.Parent then return end
				local old = ballFx
				ballFx = {Fx.attach("Ball-01", ball, {scale = step})}
				for _, d in ball:GetDescendants() do
					if d:IsA("ParticleEmitter") and string.find(d.Name, "Ash") then d.Enabled = false end
				end
				for _, f in old do f.stop() end
				Kit.wait(GROW / 5)
			end
		end)
		Kit.fork(function()
			while ball.Parent and Kit.running do
				if not ballFree then ballPos = hero:center(3.6 + ballSize * 0.55) end
				local t = Kit.time
				local pulse = 1 + 0.035 * sin(t * 16)
				ball.Size, heart.Size = V(1, 1, 1) * ballSize * pulse, V(1, 1, 1) * ballSize * 0.58
				halo.Size, shell.Size = V(1, 1, 1) * ballSize * (1.22 + 0.06 * sin(t * 9)), V(1, 1, 1) * ballSize * (1.45 + 0.05 * sin(t * 5))
				ball.CFrame = CFrame.new(ballPos) * CFrame.Angles(t * 3, t * 4, 0)
				heart.CFrame, halo.CFrame, shell.CFrame = CFrame.new(ballPos), CFrame.new(ballPos), CFrame.new(ballPos) * CFrame.Angles(0, t, 0)
				for i, r in rings do
					local d = ballSize * (1.55 + i * 0.18)
					r.Size = V(d, d * 0.1, d)
					r.CFrame = CFrame.new(ballPos) * CFrame.Angles(t * (1.6 + i * 0.7), t * (2.2 - i * 0.5), i * 1.1)
				end
				shellPart.Size = V(1, 1, 1) * ballSize * 2.6
				shellPart.CFrame = CFrame.new(ballPos)
				task.wait()
			end
		end)
		Kit.fork(function() -- éclairs qui crépitent autour
			while ball.Parent and Kit.running and not ballFree do
				local dir = V(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
				dir = dir.Magnitude > 0.01 and dir.Unit or V(0, 1, 0)
				Fx.burst("Lighting-02", ballPos + dir * ballSize * 0.65, {scale = 0.3 + ballSize * 0.05, color = rgb(255, 225, 150)})
				Kit.wait(0.2)
			end
		end)
		Kit.tween(GROW, function(e)
			ballSize = 1 + (BALL_END - 1) * e
			ballLight.Range, ballLight.Brightness = 50 + 160 * e, 5 + 5 * e
		end, "linear")
		local burn = loop(S.Fire, 0.4, 0.7)
		Kit.tween(GROW, function(e) if burn then burn.PlaybackSpeed, burn.Volume = 0.7 + 0.6 * e, 0.4 + 0.5 * e end end, "linear")
		Kit.fork(function() -- l'air afflue : des anneaux se referment, tout tremble de plus en plus
			for i = 1, math.floor(GROW / 0.35) do
				if ballFree or not ball.Parent then return end
				Fx.mesh("Shockwave", CFrame.new(ballPos), {color = FIRE, size0 = 0.6 + ballSize * 0.26, size1 = 0.1, time = 0.34, transp0 = 0.7, transp1 = 0.15, ease = "inQuad"})
				Kit.shake(0.15 + i * 0.08)
				if i % 2 == 0 then Kit.snd(S.Spark, 0.4, 0.6 + i * 0.06) end
				Kit.wait(0.35)
			end
		end)
		Kit.cam(function(t) return Kit.look(hero:point(16 - t, -9, -2), (hero:center(1) + ballPos) / 2, 62 + 4 * t) end, 0.3) -- de côté, dans le ciel : lui, et la boule qui enfle
		X.at(61.9)
		Kit.cam(function(t) return Kit.look(ballPos + flat(ballPos - boss.pos) * (46 + 3 * t) + V(0, 10, 0), ballPos - V(0, 10, 0), 64) end, 0.4) -- de loin : la boule au-dessus de la forêt
		Kit.snd(S.Ghost, 0.5, 0.6)
		boss:to(B.BLOCKHI, 0.4, "inOut")
		X.at(63.0) -- il la jette
		Kit.cam(function(t) return Kit.look(hero.hrp.Position + flat(hero.pos - boss.pos) * 16 + V(0, 9, 0), boss:center(2), 62) end, 0.15)
		hero:to(H.THROWL, 0.1, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 1, 0.6) Kit.snd(BOOM, 0.5, 1.6)
		Kit.speedLines(0.5, 0.7)
		ballFree = true
		if burn then burn:Stop() end
		inflow.Rate = 0
		local ballFrom = ballPos
		Kit.tween(0.45, function(e) ballPos = ballFrom:Lerp(boss:center(2.5), e) end, "inQuad")
		Kit.fork(function() -- traînée de feu derrière elle
			for _ = 1, 8 do Fx.burst("Fire-02", ballPos, {scale = 2.5, time = 0.25}) Kit.wait(0.055) end
		end)
		X.at(63.45) -- l'impact : tout explose
		local target = boss:center(2)
		for _, f in ballFx do f.stop() end
		ball:Destroy() heart:Destroy() halo:Destroy() shell:Destroy() shellPart:Destroy()
		for _, r in rings do r:Destroy() end
		Fx.mesh("Sphere", CFrame.new(target), {color = rgb(255, 240, 200), size0 = 1, size1 = 8, time = 0.7, transp0 = 0, transp1 = 1})
		Fx.mesh("Explosion", CFrame.new(target), {color = FIRE, size0 = 1.5, size1 = 16, time = 2.2, transp0 = 0.3, transp1 = 1, fadeLate = true})
		Fx.mesh("Explosion", CFrame.new(target), {color = rgb(255, 80, 20), size0 = 1, size1 = 11, time = 1.8, transp0 = 0.35, transp1 = 1, fadeLate = true, spin = 0.2})
		Fx.mesh("Shockwave", CFrame.new(ground(target)), {color = rgb(255, 210, 150), size0 = 1, size1 = 55, time = 1.6, transp0 = 0, ease = "outQuad"})
		Fx.mesh("Shockwave", CFrame.new(ground(target)), {color = FIRE, size0 = 1, size1 = 32, time = 1.3, transp0 = 0.1, ease = "outQuad"})
		Fx.mesh("Tornado", CFrame.new(ground(target)), {color = rgb(255, 120, 30), size0 = 1.4, size1 = 4.5, time = 2.0, transp0 = 0.25, transp1 = 1, spin = 0.8, fadeLate = true})
		Fx.burst("Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Realistic-Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Big-Crack-01", ground(target) + V(0, 0.6, 0), {scale = 3, time = 0.6})
		Fx.burst("Ground-Impact", ground(target) + V(0, 0.3, 0), {scale = 3})
		Fx.light(target, rgb(255, 190, 110), 220, 7, 2.2)
		X.breakForest(ground(target), 110) -- l'explosion couche toute la forêt autour
		Kit.snd(BOOM, 1, 0.55) Kit.snd(BOOM, 1, 0.9) Kit.snd(S.Thunder, 1, 0.6)
		Kit.flash(0.7, rgb(255, 245, 225), 1) Kit.hitstop(0.18)
		Kit.fork(function() for i = 1, 12 do Kit.shake(2.6 - i * 0.2) Kit.wait(0.12) end end)
		boss:hit(3)
		boss:to(B.RECOIL, 0.1)
		-- il est projeté jusque dans son portail, qui l'avale
		-- vu du ciel, derrière le héros (au-dessus des arbres) : l'explosion, la forêt qui se couche, le Headless avalé par le portail
		local skyCam = hero.hrp.Position + flat(hero.pos - portal.center) * 26 + V(0, 16, 0)
		Kit.cam(function(t) return Kit.look(skyCam + V(0, 3 * t, 0), (boss:center(2) + portal.center) / 2, 60 + 6 * t) end, 0.2)
		X.blast(boss, g(104, 0), 1.15, {rise = 14, tumble = 1.2, ghost = VIOLET, crash = false, done = function()
			boss:fade(0, 0.25)
			if bossAura then bossAura.stop() end
			portal.flare()
		end})
		X.at(64.0) -- le héros redescend
		hovering = false
		hero:to(merge(H.TUCK, {RightShoulder = {20, 0, 30}, RightElbow = {40}, Grip = {-70}, LeftShoulder = {30, 0, -30}, LeftElbow = {60}}), 0.14, "outQuad")
		Kit.delay(0.34, function() hero:to(H.DESCEND, 0.18, "outQuad") end)
		X.fly(hero, X.curve(hero.pos, g(4, 0), 0, 0), 0.6, {ghost = ORANGE, ease = "inQuad", flip = 0.55, settle = 0, wait = false,
			trail = function(p) Fx.burst("Fire-02", p + V(0, 1, 0), {scale = 1.3, time = 0.2}) end})
		X.at(64.65)
		X.land(hero, H.LAND, 1.6) -- réception : un genou presque à terre, le katana toujours derrière lui
		ring(hero.pos, FIRE, 7, 0.45)
		Fx.mesh("Shockwave", CFrame.new(ground(hero.pos) + V(0, 0.4, 0)), {color = FIRE, size0 = 1, size1 = 26, time = 0.6, transp0 = 0.2, ease = "outQuad"})
		Fx.burst("Crack-01", hero.pos + V(0, 0.4, 0), {scale = 1.6, time = 0.35})
		Kit.snd(S.Thud, 0.8, 0.7) Kit.snd(BOOM, 0.4, 1.4) Kit.shake(0.7)
		X.at(64.9) -- le portail se met à tout aspirer
		local suckWind = portal.suck()
		Kit.cam(function(t) return Kit.look(hero:point(-7, 2, 2.5), portal.center, 52 + 8 * t) end, 0.4)
		hero:watch(portal.center)
		hero:to(merge(H.GUARD, {Waist = {-18}}), 0.3, "outQuad")
		Kit.say("...Wait.", 1.0)
		X.at(65.9) -- emporté vers le portail
		Kit.speedLines(1.4, 0.8)
		X.slide(hero, g(40, 0), 1.2, H.SKID)
		Kit.cam(function(t) return Kit.look(hero:point(-9, 0, 3), portal.center, 60 + 10 * t) end, 0.3)
		X.at(66.5)
		Kit.flash(1.0, VIOLET, 0.95)
		X.at(66.7)
		Kit.fade(0, 0.6)
		X.at(67.5)
		bladeFire.stop() heroAura.stop()
		if suckWind then suckWind:Stop() end
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
