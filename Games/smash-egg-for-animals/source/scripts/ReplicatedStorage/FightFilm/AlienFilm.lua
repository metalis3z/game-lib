-- Cinématique "Alien Invasion" (panneau admin > Cutscene-Event) : kinoshi112 et rexydev1 discutent dans une prairie, un vaisseau
-- alien les aspire ; réveil dans le vaisseau, combat de 20 s contre l'alien, kinoshi112 le projette contre un mur ; fuite au
-- cockpit, rexydev1 ne sait pas piloter, crash et explosion dans la Safe Zone ; ils font entrer en collision deux galaxies :
-- le serveur lance alors le VRAI Galaxy Event (o.onCollide), puis plan large de la carte transformée et texte final.
-- Tout est joué côté client par FightFilm.Kit (acteurs articulés, caméra, bandes, flash) et FightFilm.Fx (effets ALL VFX).
-- Les repères de temps sont absolus (Kit.at(secondes)) : on les change à un seul endroit. Textes à l'écran en anglais.
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local film = script.Parent
local Kit = require(film:WaitForChild("Kit"))
local Fx = require(film:WaitForChild("Fx"))
require(film:WaitForChild("Cast")) -- (allures des héros : heroWalk, heroRun)
local AlienCast = require(film:WaitForChild("AlienCast"))
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock"))

local M = {}
local V, rgb = Vector3.new, Color3.fromRGB
local rad, sin, cos, clamp, random = math.rad, math.sin, math.cos, math.clamp, math.random

-- lieux : la prairie et la salle du vaisseau sont des décors construits loin de la carte ; la fin se passe dans la vraie Safe Zone
M.MEADOW = V(-4000, 200, 4000)
M.ROOM = V(-4000, 1500, 7000)
M.WRECK = V(-38, 0, -100)      -- l'épave tombe dans la Safe Zone (sol à y = 0)
M.STAGE = V(-14, 0, -146)      -- là où ils font naître la collision (près du texte "Safe Zone")
M.COLLIDE = V(400, 480, -160)  -- point de rencontre des deux galaxies, haut au-dessus des zones (au-dessus des murs de la Safe Zone)
M.COLLIDE_AT = 108             -- seconde du film où les galaxies se percutent (le serveur lance l'event)
M.LENGTH = 123
local function m(x, z, y) return M.MEADOW + V(x, y or 0, z) end
local function r(x, z, y) return M.ROOM + V(x, y or 0, z) end

local MUSIC = {Calm = 1848159364, Alien = 9040159960, Fight = 1838626086, Epic = 9045936046}
local S = {
	Birds = 9113444360, Hum = 9119392328, Screech = 9118850866, Alarm = 139605093465964, Meltdown = 6463943513,
	Punch = 109316755832781, HeavyPunch = 124469494822166, Clang = 9119747138, MetalHit = 9125819216, Spark = 9116279560,
	Boom = 7157159568, CosmicBoom = 9126102254, Whoosh = "rbxasset://sounds/swordlunge.wav", Thud = "rbxasset://sounds/collide.wav",
	Ping = "rbxasset://sounds/electronicpingshort.wav", Snap = "rbxasset://sounds/snap.wav",
}
local GREEN, CYAN, PURPLE, PINK, RED, WHITE, ORANGE = rgb(140, 255, 150), rgb(100, 225, 255), rgb(170, 110, 255), rgb(255, 130, 220), rgb(255, 50, 60), rgb(255, 255, 255), rgb(255, 150, 50)

local function merge(a, b)
	local out = {}
	for k, v in a do out[k] = v end
	for k, v in b or {} do out[k] = v end
	return out
end
local function mirror(pose) -- même geste de l'autre côté (gauche <-> droite)
	local out = {}
	for k, v in pose do
		local name = string.gsub(k, "Right", "#")
		name = string.gsub(name, "Left", "Right")
		name = string.gsub(name, "#", "Left")
		local flip = (k == "Waist" or k == "Root" or k == "Neck" or name ~= k)
		out[name] = flip and {v[1] or 0, -(v[2] or 0), -(v[3] or 0)} or v
	end
	return out
end

---------------------------------------------------------------- poses des héros (avatars R15) : angles en degrés (conventions FightFilm.Kit)
local P = {}
P.STAND = {}
P.SIT = {RightHip = {90, 0, 4}, LeftHip = {90, 0, -4}, RightKnee = {-90}, LeftKnee = {-90}, Waist = {3},
	RightShoulder = {22, 0, 6}, RightElbow = {38}, LeftShoulder = {22, 0, -6}, LeftElbow = {38}}
P.SIT_TALK = merge(P.SIT, {RightShoulder = {55, 0, 22}, RightElbow = {75}, RightWrist = {0, 0, 25}, Waist = {0, 12, 0}})
P.SIT_TALK2 = merge(P.SIT, {RightShoulder = {48, 0, 8}, RightElbow = {85}, LeftShoulder = {42, 0, -14}, LeftElbow = {80}, Waist = {4, -8, 0}})
P.SIT_LAUGH = merge(P.SIT, {Waist = {12, 0, 0}, Neck = {16}, RightShoulder = {30, 0, 20}, RightElbow = {60}, LeftShoulder = {35, 0, -18}, LeftElbow = {70}})
P.SIT_LEAN = merge(P.SIT, {Waist = {-10, 0, 0}, RightShoulder = {35, 0, 4}, RightElbow = {50}, LeftShoulder = {35, 0, -4}, LeftElbow = {50}})
P.SURPRISE = {RightShoulder = {70, 0, 55}, RightElbow = {35}, LeftShoulder = {70, 0, -55}, LeftElbow = {35}, Waist = {12}, Neck = {22},
	RightHip = {12, 0, 6}, RightKnee = {-18}, LeftHip = {-6, 0, -6}, LeftKnee = {-10}}
P.BRACE = {RightShoulder = {-30, 0, 30}, RightElbow = {40}, LeftShoulder = {-25, 0, -30}, LeftElbow = {40}, Waist = {-22}, Neck = {12},
	RightHip = {35, 0, 8}, RightKnee = {-45}, LeftHip = {-25, 0, -8}, LeftKnee = {-20}}
P.LIE = {RightShoulder = {150, 0, 30}, RightElbow = {80}, LeftShoulder = {150, 0, -30}, LeftElbow = {85}, Neck = {25}, RightHip = {0, 0, 4}, LeftHip = {0, 0, -6}}
P.PUSHUP = {RightShoulder = {62, 0, 12}, RightElbow = {12}, LeftShoulder = {62, 0, -12}, LeftElbow = {12}, Neck = {38}, Waist = {6},
	RightHip = {-30, 0, 4}, LeftHip = {-30, 0, -4}, RightKnee = {-10}, LeftKnee = {-10}}
P.KNEEL = {RightHip = {90, 0, 5}, RightKnee = {-90}, LeftHip = {-4, 0, -5}, LeftKnee = {-96}, Waist = {8}, Neck = {6},
	RightShoulder = {30, 0, 10}, RightElbow = {40}, LeftShoulder = {10, 0, -8}, LeftElbow = {25}}
P.RISE = {RightHip = {45, 0, 5}, RightKnee = {-55}, LeftHip = {20, 0, -5}, LeftKnee = {-45}, Waist = {-28}, Neck = {14},
	RightShoulder = {-10, 0, 20}, RightElbow = {30}, LeftShoulder = {-10, 0, -20}, LeftElbow = {30}}
P.DAZED = {Waist = {-6, 0, 6}, Neck = {-6, 0, 8}, RightShoulder = {8, 0, 10}, RightElbow = {20}, LeftShoulder = {25, 0, -6}, LeftElbow = {70}, LeftWrist = {0, 0, 0}}
P.GUARD = {RightShoulder = {78, 0, -18}, RightElbow = {112}, LeftShoulder = {82, 0, 18}, LeftElbow = {118}, Waist = {-6, -18, 0}, Root = {0, 18, 0}, Neck = {4, 10, 0},
	LeftHip = {22, 0, -8}, LeftKnee = {-30}, RightHip = {-14, 0, 8}, RightKnee = {-22}}
P.JAB_R = merge(P.GUARD, {RightShoulder = {92, 0, -4}, RightElbow = {6}, Waist = {-10, 22, 0}, Root = {0, -12, 0}, Neck = {4, -14, 0}})
P.JAB_L = merge(P.GUARD, {LeftShoulder = {92, 0, 4}, LeftElbow = {6}, Waist = {-10, -30, 0}, Root = {0, 25, 0}})
P.HOOK_R = merge(P.GUARD, {RightShoulder = {85, 0, 55}, RightElbow = {80}, Waist = {-8, 40, 0}, Root = {0, -25, 0}})
P.UPPER_R = merge(P.GUARD, {RightShoulder = {160, 0, -8}, RightElbow = {45}, Waist = {14, 20, 0}, RightHip = {-10, 0, 8}, RightKnee = {-5}, LeftKnee = {-10}})
P.KICK_WIND = merge(P.GUARD, {RightHip = {70, 0, 8}, RightKnee = {-100}, LeftKnee = {-25}, Waist = {6}})
P.KICK = merge(P.GUARD, {RightHip = {98, 0, 8}, RightKnee = {-6}, LeftHip = {-8}, LeftKnee = {-22}, Waist = {16}, Neck = {-6}})
P.ROUND_WIND = merge(P.GUARD, {RightHip = {40, 0, 45}, RightKnee = {-90}, Root = {0, 50, 0}, Waist = {10, 20, 0}})
P.ROUND = merge(P.GUARD, {RightHip = {75, 0, 70}, RightKnee = {-8}, Root = {0, 90, 0}, Waist = {16, 30, 0}, LeftKnee = {-25}})
P.SWEEP = {RightHip = {20, 0, 75}, RightKnee = {-5}, LeftHip = {95, 0, -6}, LeftKnee = {-120}, Waist = {-30, 40, 0}, Root = {0, 60, 0},
	RightShoulder = {40, 0, 60}, RightElbow = {20}, LeftShoulder = {60, 0, -10}, LeftElbow = {40}}
P.DODGE = merge(P.GUARD, {Waist = {14, 0, 26}, Root = {0, 0, 10}, Neck = {-8, 0, -18}, LeftHip = {10, 0, -20}, RightHip = {-6, 0, 18}})
P.DUCK = {RightHip = {95, 0, 8}, RightKnee = {-125}, LeftHip = {100, 0, -8}, LeftKnee = {-130}, Waist = {-28}, Neck = {24},
	RightShoulder = {80, 0, -10}, RightElbow = {110}, LeftShoulder = {85, 0, 10}, LeftElbow = {115}}
P.BLOCK = merge(P.GUARD, {RightShoulder = {120, 0, -30}, RightElbow = {95}, LeftShoulder = {120, 0, 30}, LeftElbow = {95}, Neck = {-8}, Waist = {6}})
P.HURT = {Waist = {18, 0, 8}, Neck = {-20, 0, 10}, RightShoulder = {-20, 0, 40}, RightElbow = {30}, LeftShoulder = {-25, 0, -40}, LeftElbow = {35},
	RightHip = {-10, 0, 6}, RightKnee = {-20}, LeftHip = {25, 0, -6}, LeftKnee = {-30}}
P.JUMPKICK = {RightHip = {95, 0, 6}, RightKnee = {-5}, LeftHip = {50, 0, -6}, LeftKnee = {-110}, Waist = {8}, Neck = {-4},
	RightShoulder = {-30, 0, 40}, RightElbow = {30}, LeftShoulder = {60, 0, -30}, LeftElbow = {60}}
P.LAND = {RightHip = {80, 0, 10}, RightKnee = {-105}, LeftHip = {35, 0, -10}, LeftKnee = {-110}, Waist = {-18}, Neck = {14},
	LeftShoulder = {30, 0, -40}, LeftElbow = {30}, RightShoulder = {20, 0, 50}, RightElbow = {20}}
P.GRAB = {RightShoulder = {112, 0, -14}, RightElbow = {22}, LeftShoulder = {112, 0, 14}, LeftElbow = {22}, Waist = {-12}, Neck = {6},
	LeftHip = {35, 0, -8}, LeftKnee = {-45}, RightHip = {-18, 0, 8}, RightKnee = {-25}}
P.LIFT_LOW = {RightShoulder = {130, 0, -10}, RightElbow = {30}, LeftShoulder = {130, 0, 10}, LeftElbow = {30}, Waist = {6}, Neck = {16},
	RightHip = {40, 0, 10}, RightKnee = {-70}, LeftHip = {40, 0, -10}, LeftKnee = {-70}}
P.LIFT_HIGH = {RightShoulder = {168, 0, -8}, RightElbow = {12}, LeftShoulder = {168, 0, 8}, LeftElbow = {12}, Waist = {14}, Neck = {28},
	RightHip = {6, 0, 10}, RightKnee = {-12}, LeftHip = {6, 0, -10}, LeftKnee = {-12}}
P.THROW = {RightShoulder = {70, 0, -20}, RightElbow = {8}, LeftShoulder = {70, 0, 20}, LeftElbow = {8}, Waist = {-30, -10, 0}, Neck = {10},
	LeftHip = {45, 0, -8}, LeftKnee = {-55}, RightHip = {-28, 0, 8}, RightKnee = {-18}}
P.POINT = {RightShoulder = {120, 0, 20}, RightElbow = {4}, RightWrist = {0}, LeftShoulder = {6, 0, -6}, LeftElbow = {12}, Waist = {0, 14, 0}, Neck = {6, 20, 0}}
P.POINT_SKY = {RightShoulder = {158, 0, 18}, RightElbow = {0}, LeftShoulder = {10, 0, -8}, LeftElbow = {15}, Waist = {8}, Neck = {32}}
P.LOOK_UP = {Neck = {40}, Waist = {12}, RightShoulder = {6, 0, 8}, LeftShoulder = {6, 0, -8}}
P.TIRED = {Waist = {-26}, Neck = {12}, RightShoulder = {48, 0, 12}, RightElbow = {22}, LeftShoulder = {48, 0, -12}, LeftElbow = {22},
	RightHip = {28, 0, 8}, RightKnee = {-34}, LeftHip = {26, 0, -8}, LeftKnee = {-32}}
P.WIPE = {RightShoulder = {140, 0, -30}, RightElbow = {120}, LeftShoulder = {10, 0, -10}, LeftElbow = {20}, Waist = {6}, Neck = {10}}
P.THUMB = {RightShoulder = {80, 0, 30}, RightElbow = {60}, LeftShoulder = {6, 0, -6}, LeftElbow = {10}, Neck = {4, 20, 0}, Waist = {0, 10, 0}}
P.CHANNEL = {RightShoulder = {165, 0, 28}, RightElbow = {8}, LeftShoulder = {165, 0, -28}, LeftElbow = {8}, Waist = {12}, Neck = {30},
	RightHip = {-4, 0, 14}, LeftHip = {-4, 0, -14}, RightKnee = {-14}, LeftKnee = {-14}}
P.CHANNEL_PUSH = {RightShoulder = {130, 0, -6}, RightElbow = {0}, LeftShoulder = {125, 0, 6}, LeftElbow = {0}, Waist = {-8, 0, 0}, Neck = {22},
	LeftHip = {32, 0, -10}, LeftKnee = {-40}, RightHip = {-22, 0, 10}, RightKnee = {-15}}
P.CHANNEL_SWEEP = {RightShoulder = {150, 0, 70}, RightElbow = {5}, LeftShoulder = {120, 0, -10}, LeftElbow = {20}, Waist = {4, -25, 8}, Neck = {26, -15, 0},
	LeftHip = {28, 0, -10}, LeftKnee = {-36}, RightHip = {-18, 0, 10}, RightKnee = {-14}}
P.HERO = {RightShoulder = {62, 0, -38}, RightElbow = {105}, LeftShoulder = {62, 0, 38}, LeftElbow = {105}, Waist = {6}, Neck = {14},
	RightHip = {-4, 0, 12}, LeftHip = {-4, 0, -12}}
P.PILOT = merge(P.SIT, {RightShoulder = {70, 0, -6}, RightElbow = {35}, LeftShoulder = {70, 0, 6}, LeftElbow = {35}, Waist = {-8}, Neck = {-6}})
P.PILOT_A = merge(P.SIT, {RightShoulder = {85, 0, -20}, RightElbow = {20}, LeftShoulder = {55, 0, 20}, LeftElbow = {60}, Waist = {-10, 15, 0}, Neck = {-10, -10, 0}})
P.PILOT_B = merge(P.SIT, {RightShoulder = {50, 0, 25}, RightElbow = {65}, LeftShoulder = {90, 0, -10}, LeftElbow = {15}, Waist = {-12, -15, 0}, Neck = {-12, 15, 0}})
P.PILOT_PANIC = merge(P.SIT, {RightShoulder = {120, 0, 40}, RightElbow = {40}, LeftShoulder = {120, 0, -40}, LeftElbow = {40}, Waist = {10}, Neck = {14}})
P.HOLD_WALL = {RightShoulder = {95, 0, 5}, RightElbow = {35}, LeftShoulder = {80, 0, -5}, LeftElbow = {55}, Waist = {-10, 0, 0}, Neck = {6},
	LeftHip = {25, 0, -10}, LeftKnee = {-35}, RightHip = {-10, 0, 10}, RightKnee = {-25}}
P.CROUCH = {RightHip = {70, 0, 8}, RightKnee = {-100}, LeftHip = {72, 0, -8}, LeftKnee = {-104}, Waist = {-20}, Neck = {14},
	RightShoulder = {30, 0, 25}, RightElbow = {40}, LeftShoulder = {30, 0, -25}, LeftElbow = {40}}

---------------------------------------------------------------- poses de l'alien (R6 : Root, Neck, épaules, hanches, + Jaw)
local A = {}
A.IDLE = {RightShoulder = {18, 0, 18}, LeftShoulder = {18, 0, -18}, Root = {-10}, Neck = {8}}
A.CROUCH = {Root = {-26}, RightHip = {40}, LeftHip = {10}, RightShoulder = {-10, 0, 55}, LeftShoulder = {-10, 0, -55}, Neck = {24}}
A.ROAR = {Root = {14}, Neck = {28}, RightShoulder = {40, 0, 85}, LeftShoulder = {40, 0, -85}, RightHip = {8}, LeftHip = {-8}, Jaw = {40}}
A.SWIPE_WIND = {Root = {-10, -40, 0}, RightShoulder = {-35, 0, 75}, LeftShoulder = {40, 0, -20}, RightHip = {25}, LeftHip = {-15}, Neck = {12, 30, 0}}
A.SWIPE = {Root = {-25, 45, 0}, RightShoulder = {112, 0, -45}, LeftShoulder = {-30, 0, -30}, RightHip = {-20}, LeftHip = {40}, Neck = {20, -30, 0}}
A.SWIPE_L_WIND = mirror(A.SWIPE_WIND)
A.SWIPE_L = mirror(A.SWIPE)
A.SLAM_WIND = {RightShoulder = {172, 0, -10}, LeftShoulder = {170, 0, 10}, Root = {16}, Neck = {-10}, RightHip = {10}, LeftHip = {-8}, Jaw = {25}}
A.SLAM = {RightShoulder = {40}, LeftShoulder = {36}, Root = {-40}, Neck = {25}, RightHip = {45}, LeftHip = {-12}}
A.RECOIL = {Root = {26}, RightShoulder = {-40, 0, 60}, LeftShoulder = {-40, 0, -60}, RightHip = {28}, LeftHip = {-10}, Neck = {-22}, Jaw = {22}}
A.STAGGER = {Root = {-28, 20, 12}, RightShoulder = {50, 0, 60}, LeftShoulder = {-30, 0, -50}, RightHip = {40}, LeftHip = {-15}, Neck = {24, 0, 15}}
A.SPIN = {RightShoulder = {90, 0, 90}, LeftShoulder = {90, 0, -90}, Root = {-8}, Neck = {10}, RightHip = {12}, LeftHip = {-12}}
A.LEAP = {Root = {-38}, RightShoulder = {160, 0, 20}, LeftShoulder = {160, 0, -20}, RightHip = {-30}, LeftHip = {50}, Neck = {30}}
A.GRAB = {Root = {-22}, RightShoulder = {100, 0, -20}, LeftShoulder = {100, 0, 20}, RightHip = {20}, LeftHip = {-10}, Neck = {18}, Jaw = {20}}
A.KNEEL = {Root = {-24}, RightHip = {88}, LeftHip = {-70}, RightShoulder = {10, 0, 25}, LeftShoulder = {30, 0, -15}, Neck = {-10}}
A.CHOKED = {RightShoulder = {120, 0, 30}, LeftShoulder = {120, 0, -30}, Root = {8}, Neck = {30}, RightHip = {20}, LeftHip = {-20}, Jaw = {30}}
A.FLY = {Root = {30}, RightShoulder = {150, 0, 60}, LeftShoulder = {150, 0, -60}, RightHip = {-30, 0, 20}, LeftHip = {40, 0, -20}, Neck = {-25}, Jaw = {25}}
A.SPLAT = {Root = {0}, RightShoulder = {170, 0, 40}, LeftShoulder = {170, 0, -40}, RightHip = {10, 0, 20}, LeftHip = {10, 0, -20}, Neck = {-10}}
A.DOWN = {RightShoulder = {0, 0, 80}, LeftShoulder = {0, 0, -70}, RightHip = {0, 0, 18}, LeftHip = {0, 0, -14}, Neck = {-10, 25, 0}, Jaw = {14}}

---------------------------------------------------------------- déroulé
-- o.onCollide() : appelé au moment exact où les galaxies se percutent (le client prévient le serveur, qui lance le Galaxy Event)
-- o.ffTo = secondes : essais, avance rapide jusqu'à ce temps puis pause
function M.play(o)
	o = o or {}
	local player = Players.LocalPlayer
	local scene = Instance.new("Folder")
	scene.Name = "AlienFilmScene"
	scene.Parent = workspace
	local sets = film:WaitForChild("AlienSets")
	local meadow = sets:WaitForChild("Meadow"):Clone()
	meadow:PivotTo(CFrame.new(M.MEADOW))
	meadow.Parent = scene
	local grade = Instance.new("ColorCorrectionEffect")
	grade.Name = "AlienFilmGrade"
	grade.Parent = Lighting
	local gameMusic = SoundService:FindFirstChild("Days")
	local musicWasPlaying = gameMusic and gameMusic.IsPlaying
	if gameMusic then gameMusic:Pause() end
	local hiddenChars = {} -- personnages des joueurs cachés (chez ce joueur seulement) pendant les plans dans la vraie Safe Zone

	Kit.begin(scene, {})
	if o.ffTo then Kit.ffTo = o.ffTo end
	Kit.fade(0, 0)
	local loops = {}
	local function loop(id, volume, speed) local s = Kit.snd(id, volume, speed, true) table.insert(loops, s) return s end
	local at = Kit.at

	local ok, err = pcall(function()
		------------------------------------------------ distribution
		local rigs = film:WaitForChild("AlienRigs")
		local function avatar(name)
			local rig = rigs:WaitForChild(name, 15):Clone()
			rig.Parent = scene
			local a = Kit.actor(rig, name)
			a.neckSmooth = 13
			a.seed = random() * 10
			return a
		end
		local kino, rex = avatar("Kino"), avatar("Rex")
		local alienRig, alienParts = AlienCast.alien()
		alienRig.Parent = scene
		local alien = Kit.actor(alienRig, "Alien")
		alien:addWeldJoint("Jaw", alienParts.Jaw)
		alien.val.Jaw = {0, 0, 0}
		alien.neckSmooth = 10
		alien:setVisible(0)
		alien:place(r(0, 60), r(0, 0))

		------------------------------------------------ petits outils
		local function say(who, text, t) Kit.say(who .. ": " .. text, t or 2.4) end
		local function dust(pos, s) Fx.burst("Smoke-01", pos + V(0, 0.4, 0), {scale = s or 0.6}) end
		local function chest(a) return a:center(a == alien and 1.1 or 0.9) end
		local function flat(v) v = v * V(1, 0, 1) return v.Magnitude > 0.01 and v.Unit or V(0, 0, -1) end
		local function impact(target, pos, power, color)
			power = power or 1
			Fx.burst("Punch-01", pos, {scale = 1.1 * power})
			if power >= 1.3 then Fx.burst("Punch-02", pos, {scale = 1.4 * power}) Fx.burst("Hit-Purple", pos, {scale = 0.7 * power}) end
			Fx.light(pos, color or WHITE, 14 * power, 4, 0.25)
			Kit.snd(power >= 1.3 and S.HeavyPunch or S.Punch, 0.75, 0.9 + random() * 0.25)
			target:hit(power)
			Kit.shake(0.22 * power)
			Kit.punch(-3 * power)
			Kit.hitstop(0.035 + 0.03 * power)
		end
		-- repoussé : il glisse en arrière, les pieds raclent le sol
		local function skid(a, from, dist, dur, pose)
			local to = a.pos + flat(a.pos - from) * dist
			if pose then a:to(pose, 0.1, "outQuad") end
			a:move(to, dur or 0.35, "outCubic")
			Kit.fork(function() for _ = 1, 3 do Kit.wait(0.08) dust(a.pos, 0.45 * a.scale) end end)
			return to
		end
		-- un coup : élan, frappe (le bras ou la jambe arrive au contact), impact, retour en garde
		local function strike(a, wind, hit, target, opt)
			opt = opt or {}
			if wind then a:to(wind, opt.wind or 0.1, "outCubic") Kit.wait(opt.wind or 0.1) end
			Kit.snd(S.Whoosh, 0.35, 1.2 + random() * 0.3)
			a:to(hit, opt.cut or 0.08, "outQuart", {lag = false})
			Kit.wait((opt.cut or 0.08) * 0.7)
			if target then
				impact(target, opt.where and opt.where() or chest(target), opt.power, opt.color)
				if opt.push then skid(target, a.pos, opt.push, 0.3, opt.react) elseif opt.react then target:to(opt.react, 0.08, "outQuad") end
			end
			Kit.wait((opt.cut or 0.08) * 0.3 + (opt.hold or 0.05))
			if opt.back ~= false then a:to(opt.guard or P.GUARD, opt.recover or 0.16, "inOut") end
		end
		-- s'agite dans tous les sens (aspiré, étranglé...) pendant `dur` secondes
		local function flail(a, dur, amp, extra)
			Kit.fork(function()
				local t0 = Kit.time
				while Kit.time - t0 < dur do
					local k = amp or 1
					a:to(merge({
						RightShoulder = {random(40, 170) * k, 0, random(20, 85)}, RightElbow = {random(10, 90)},
						LeftShoulder = {random(40, 170) * k, 0, -random(20, 85)}, LeftElbow = {random(10, 90)},
						RightHip = {random(-40, 60) * k, 0, random(0, 22)}, RightKnee = {-random(0, 95)},
						LeftHip = {random(-40, 60) * k, 0, -random(0, 22)}, LeftKnee = {-random(0, 95)},
						Waist = {random(-15, 15), random(-20, 20), random(-12, 12)}, Root = {random(-15, 15), random(-15, 15), random(-10, 10)},
						Neck = {random(-10, 30), random(-35, 35), 0},
					}, extra), 0.15, "inOut")
					Kit.wait(0.13 + random() * 0.06)
				end
			end)
		end
		local function walk(a, to, dur, gait)
			a:gait(gait or "heroWalk", 0.15)
			a:move(to, dur, "inOut", {face = true, faceTime = 0.25})
			Kit.delay(dur, function() a:gait(nil, 0.2) end)
		end
		local function run(a, to, dur, gait)
			a:gait(gait or "heroRun", 0.1, function() dust(a.pos, 0.3 * a.scale) end)
			a:move(to, dur, "inOut", {face = true, faceTime = 0.12})
			Kit.delay(dur, function() a:gait(nil, 0.12) end)
		end
		-- s'allonger / se relever : le corps entier bascule autour du bassin
		local function lieDown(a, pitch, dur)
			a:body({air = 1, pitch = pitch, lift = -(a.stand - 0.6 * a.scale)}, dur or 0)
		end
		local function wide(list, angle, height, extra, drift)
			return function(t)
				local sum, n = Vector3.zero, 0
				for _, a in list do if a.alive then sum += a.pos n += 1 end end
				local mid = sum / math.max(n, 1)
				local reach = 0
				for _, a in list do reach = math.max(reach, ((a.pos - mid) * V(1, 0, 1)).Magnitude) end
				local ang = rad(angle) + (drift or 0) * t
				local dist = math.min(11 + reach * 1.4 + (extra or 0), 30)
				return Kit.look(mid + V(cos(ang) * dist, height or 7, sin(ang) * dist), mid + V(0, 2.4, 0), 52)
			end
		end
		local function seatHeight(a) return a.L2 + a.footH end

		-- ================================================ SCÈNE 1 : discussion tranquille dans la prairie (0 - 12 s)
		local benchTop = math.min(seatHeight(kino), seatHeight(rex)) - 0.4
		local bench = AlienCast.bench(8, benchTop)
		bench:PivotTo(CFrame.new(m(0, 0, benchTop - 0.25)) * CFrame.Angles(0, math.pi, 0))
		bench.Parent = scene
		local front = m(0, 30)
		kino:place(m(-1.75, 0), m(-1.75, 30))
		rex:place(m(1.75, 0), m(1.75, 30))
		for _, a in {kino, rex} do
			a:to(P.SIT, 0)
			a.sink = seatHeight(a) - 0.4 - benchTop -- les deux bassins sur la même planche
		end
		kino:watch(rex, 0.7)
		rex:watch(kino, 0.5)
		local birds = loop(S.Birds, 0.45)
		local music = loop(MUSIC.Calm, 0)
		Kit.fadeSound(music, 0.35, 2)
		Kit.bars(true, 0)
		Kit.fade(1, 1.6)
		-- plan large, lent travelling
		Kit.cam(function(t) return Kit.look(m(15 - t * 1.1, 24 - t * 1.4, 4.5 - t * 0.2), m(0, 0, 2.6), 50) end)
		at(1.0)
		kino:to(P.SIT_TALK, 0.45, "inOut")
		say("kinoshi112", "The Galaxy Event is almost ready...", 2.6)
		at(1.8) kino:to(P.SIT_TALK2, 0.5, "inOut")
		at(2.6) kino:to(P.SIT, 0.5, "inOut") rex:to(merge(P.SIT, {Neck = {-12}}), 0.25) at(2.9) rex:to(merge(P.SIT, {Neck = {8}}), 0.25)
		at(3.3)
		rex:to(P.SIT_LAUGH, 0.35, "outQuad")
		say("rexydev1", "Bro, the players are gonna love it!", 2.4)
		-- gros plan sur rexydev1 (caméra devant eux, à l'épaule de kinoshi112 : on voit son visage)
		Kit.cam(function(t) return Kit.look(kino:center(1.6) + V(-1.4, 0.5, 2.8) + V(0, 0, t * 0.12), rex:center(2.2), 38) end)
		at(4.0) rex:to(P.SIT_TALK2, 0.5, "inOut")
		at(5.0) rex:to(mirror(P.SIT_TALK), 0.45, "inOut")
		at(5.8)
		-- gros plan sur kinoshi112
		Kit.cam(function(t) return Kit.look(rex:center(1.6) + V(1.4, 0.5, 2.8) + V(0, 0, t * 0.12), kino:center(2.2), 38) end)
		kino:to(P.SIT_LEAN, 0.5, "inOut")
		say("kinoshi112", "Wait... did you hear that?", 2.2)
		rex:to(P.SIT, 0.5, "inOut")
		at(7.2)
		-- une ombre géante passe sur eux : le vaisseau descend
		local ship, shipSize = AlienCast.ship(3)
		local hoverY = 42 + shipSize.Y / 2
		local shipFrom = m(-40, -260, hoverY + 260)
		ship:PivotTo(CFrame.new(shipFrom))
		ship.Parent = scene
		local shadow = Instance.new("Part")
		shadow.Shape = Enum.PartType.Cylinder
		shadow.Anchored, shadow.CanCollide, shadow.CanQuery, shadow.CanTouch, shadow.CastShadow = true, false, false, false, false
		shadow.Color, shadow.Material, shadow.Transparency = rgb(10, 10, 20), Enum.Material.SmoothPlastic, 1
		shadow.Size = V(0.2, 10, 10)
		shadow.CFrame = CFrame.new(m(0, 0, 0.15)) * CFrame.Angles(0, 0, rad(90))
		shadow.Parent = scene
		local hum = loop(S.Hum, 0)
		Kit.fadeSound(hum, 0.9, 3)
		Kit.fadeSound(birds, 0, 2.5)
		Kit.fadeSound(music, 0, 2.5)
		TweenService:Create(grade, TweenInfo.new(3, Enum.EasingStyle.Sine), {Brightness = -0.22, Saturation = -0.25, Contrast = 0.12, TintColor = rgb(215, 225, 255)}):Play()
		Kit.tween(4.6, function(e)
			ship:PivotTo(CFrame.new(shipFrom:Lerp(m(0, 0, hoverY), e)) * CFrame.Angles(0, e * 2.5, 0))
			shadow.Size = V(0.2, 20 + 120 * e, 20 + 120 * e)
			shadow.Transparency = 1 - 0.55 * e
		end, "outCubic")
		at(8.2)
		for _, a in {kino, rex} do a:watch(m(0, 0, 60), 1) end
		kino:to(merge(P.SIT, {Waist = {8}, Neck = {30}}), 0.6, "inOut")
		rex:to(merge(P.SIT, {Waist = {10}, Neck = {34}}), 0.7, "inOut")
		-- contre-plongée derrière eux : le vaisseau géant envahit le ciel
		Kit.cam(function(t) return Kit.look(m(0.5, -7 - t * 0.4, 2.2), m(0, 0, 45), 62 + t * 2) end, 0.6)
		local alienMusic = loop(MUSIC.Alien, 0)
		Kit.fadeSound(alienMusic, 0.45, 2)
		at(10.4)
		say("rexydev1", "...WHAT IS THAT?!", 1.6)
		Kit.shake(0.3)

		-- ================================================ SCÈNE 2 : l'enlèvement (12 - 24 s)
		at(12.0)
		-- (le vaisseau continue de tourner lentement sur lui-même, sans à-coup)
		Kit.tween(10, function(e) ship:PivotTo(CFrame.new(m(0, 0, hoverY)) * CFrame.Angles(0, 2.5 + e * 2.2, 0)) end, "linear")
		local hatch = ship:FindFirstChild("Hatch")
		local hatchY = hoverY - shipSize.Y * 0.5
		-- rayon d'aspiration : deux Beams en cône, anneau lumineux au sol, particules qui montent, projecteur
		local beamTop = Instance.new("Part")
		beamTop.Anchored, beamTop.CanCollide, beamTop.CanQuery, beamTop.CanTouch, beamTop.Transparency = true, false, false, false, 1
		beamTop.Size = V(1, 1, 1)
		beamTop.CFrame = CFrame.new(m(0, 0, hatchY))
		beamTop.Parent = scene
		local beamBottom = beamTop:Clone()
		beamBottom.Size = V(26, 0.1, 26)
		beamBottom.CFrame = CFrame.new(m(0, 0, 0.12))
		beamBottom.Parent = scene
		local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
		a0.Parent, a1.Parent = beamTop, beamBottom
		local beams = {}
		for i, texture in {"rbxassetid://1084975295", "rbxassetid://4509687978"} do
			local b = Instance.new("Beam")
			b.Attachment0, b.Attachment1 = a0, a1
			b.Texture, b.TextureMode, b.TextureSpeed, b.TextureLength = texture, Enum.TextureMode.Stretch, i == 1 and 1.2 or -0.4, 1
			b.FaceCamera, b.Segments, b.LightEmission, b.LightInfluence, b.Brightness = true, 20, 1, 0, 3
			b.Color = ColorSequence.new(rgb(220, 255, 220), GREEN)
			b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, i == 1 and 0.1 or 0.35), NumberSequenceKeypoint.new(0.7, i == 1 and 0.3 or 0.5), NumberSequenceKeypoint.new(1, 0.6)})
			b.Width0, b.Width1 = 2, 2
			b.Parent = beamTop
			table.insert(beams, b)
		end
		Kit.tween(0.5, function(e) for i, b in beams do b.Width0, b.Width1 = 2 + 10 * e, 2 + (i == 1 and 20 or 26) * e end end, "outBack")
		local ringDecal = Instance.new("Decal")
		ringDecal.Face, ringDecal.Texture, ringDecal.Color3, ringDecal.Transparency = Enum.NormalId.Top, "rbxassetid://8271495905", GREEN, 0.1
		ringDecal.Parent = beamBottom
		Kit.tween(14, function(e) beamBottom.CFrame = CFrame.new(m(0, 0, 0.12)) * CFrame.Angles(0, e * 18, 0) end, "linear")
		local riser = Instance.new("ParticleEmitter")
		riser.Texture, riser.LightEmission, riser.LightInfluence = "rbxasset://textures/particles/sparkles_main.dds", 1, 0
		riser.Color = ColorSequence.new(WHITE, GREEN)
		riser.EmissionDirection = Enum.NormalId.Top
		riser.Shape, riser.ShapeStyle = Enum.ParticleEmitterShape.Cylinder, Enum.ParticleEmitterShapeStyle.Volume
		riser.Rate, riser.Lifetime, riser.Speed = 60, NumberRange.new(2, 3), NumberRange.new(10, 18)
		riser.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0)})
		local riserPart = beamTop:Clone()
		riserPart.Size = V(18, 2, 18)
		riserPart.CFrame = CFrame.new(m(0, 0, 1))
		riserPart.Parent = scene
		riser.Parent = riserPart
		local spot = Instance.new("SpotLight")
		spot.Face, spot.Angle, spot.Range, spot.Brightness, spot.Color, spot.Shadows = Enum.NormalId.Bottom, 50, 70, 5, GREEN, false
		spot.Parent = beamTop
		if hatch then hatch.Transparency = 0 end
		Kit.flash(0.4, GREEN, 0.6)
		Kit.snd(S.CosmicBoom, 0.5, 1.6)
		Kit.shake(0.5)
		-- ils se lèvent d'un bond, surpris
		at(12.25)
		for i, a in {kino, rex} do
			a:watch(nil)
			a.sink = 0
			a:to(P.SURPRISE, 0.22, "outBack")
			Fx.burst("Surprised-01", a:center(4), {scale = 1})
		end
		bench:Destroy()
		Kit.cam(function(t) return Kit.look(m(-9 + t * 0.6, 3.2, 8.5), m(0, 0, 3.4), 50) end)
		at(12.9)
		-- ils résistent : penchent en arrière, jambes plantées, bras qui battent l'air
		kino:to(P.BRACE, 0.2, "outQuad")
		rex:to(mirror(P.BRACE), 0.2, "outQuad")
		kino:move(m(-3.2, 1.2), 1.2, "outQuad")
		rex:move(m(3.2, 1.0), 1.2, "outQuad")
		say("kinoshi112", "IT'S PULLING US!", 1.6)
		at(13.6)
		flail(kino, 8, 0.9) flail(rex, 8, 1)
		local auraK = Fx.attach("Shiny-01", kino.hrp, {color = GREEN, scale = 1.2})
		local auraR = Fx.attach("Shiny-01", rex.hrp, {color = GREEN, scale = 1.2})
		at(14.5)
		-- les pieds quittent le sol, ils montent en tournoyant
		for i, a in {kino, rex} do
			a:body({air = 1}, 0.3)
			Kit.tween(7, function(e)
				a.lift = (hatchY - 6) * e
				a.yaw += (i == 1 and 0.012 or -0.015)
				a.pitch = sin(Kit.time * (1.6 + i * 0.3)) * 0.35
				a.roll = cos(Kit.time * (1.3 + i * 0.4)) * 0.3
			end, "inQuad")
			a:move(m(i == 1 and -1.4 or 1.4, 0.2), 6, "inOut")
		end
		Kit.snd(S.Whoosh, 0.6, 0.6)
		-- la caméra suit leur ascension jusqu'au vaisseau
		Kit.cam(function(t)
			local mid = (kino:center() + rex:center()) / 2
			return Kit.look(mid + V(16 - t * 0.6, -3 + t * 0.4, 14 - t * 0.5), mid + V(0, 3 + t * 1.2, 0), 58 + t * 1.5)
		end, 0.8)
		at(17.5)
		say("rexydev1", "NOOOOO!", 1.8)
		at(19.5)
		Kit.cam(function(t)
			local mid = (kino:center() + rex:center()) / 2
			return Kit.look(m(0, 0, 2) + V(0, mid.Y - M.MEADOW.Y - 14 + t * 2.5, 0) + V(3, 0, 18), m(0, 0, hatchY), 64)
		end, 0.6)
		at(20.6)
		kino:fade(0, 0.8) rex:fade(0, 0.8)
		auraK.stop() auraR.stop()
		Fx.burst("Portal-Enter-01", m(0, 0, hatchY - 2), {scale = 3, color = GREEN})
		at(21.3)
		Kit.flash(0.9, rgb(220, 255, 220), 1)
		Kit.snd(S.CosmicBoom, 0.4, 2)
		Kit.fade(0, 0.7)
		Kit.fadeSound(alienMusic, 0.15, 1.5)
		at(22.3)
		-- changement de décor (écran noir)
		meadow:Destroy() ship:Destroy() shadow:Destroy() beamTop:Destroy() beamBottom:Destroy() riserPart:Destroy()
		Kit.fadeSound(hum, 0.35, 1)
		local room = sets:WaitForChild("ShipRoom"):Clone()
		room:PivotTo(CFrame.new(M.ROOM))
		room.Parent = scene
		TweenService:Create(grade, TweenInfo.new(1), {Brightness = -0.06, Saturation = -0.05, Contrast = 0.16, TintColor = rgb(225, 225, 255)}):Play()

		-- ================================================ SCÈNE 3 : réveil dans le vaisseau (24 - 36 s)
		at(23.6)
		for _, a in {kino, rex} do
			a:body({yaw = 0, pitch = 0, roll = 0, lift = 0}, 0)
			a.btw.lift, a.btw.pitch, a.btw.roll = nil, nil, nil
		end
		kino:place(r(-3, 6), r(-3, -20))
		rex:place(r(3.5, 8), r(3.5, -20))
		for _, a in {kino, rex} do
			a:setVisible(1)
			a.idle = 0
			a:to(P.LIE, 0)
			lieDown(a, -rad(90))
		end
		local eerie = loop(S.Hum, 0.6, 0.7)
		at(24.0)
		Kit.fade(1, 2.2)
		-- plongée lente sur les deux corps
		Kit.cam(function(t) return Kit.look(r(0.5 + t * 0.3, 12, 14 - t * 0.4), r(0.3, 7, 1.2), 50) end)
		at(25.2)
		-- ils bougent les bras et les jambes
		for i, a in {kino, rex} do
			Kit.delay(i * 0.35, function()
				a:to(merge(P.LIE, {RightShoulder = {120, 0, 40}, RightElbow = {100}, LeftHip = {10, 0, -6}, LeftKnee = {-30}}), 0.5, "inOut")
				Kit.wait(0.7)
				a:to(merge(P.LIE, {LeftShoulder = {120, 0, -40}, LeftElbow = {100}, RightHip = {12, 0, 6}, RightKnee = {-35}, Neck = {35}}), 0.5, "inOut")
			end)
		end
		at(27.0)
		-- ils se redressent en prenant appui sur leurs mains
		Kit.cam(function(t) return Kit.look(kino:point(4.8, -2.2, 0) + V(0, 0.4, 0), kino:center(0.4), 46) end, 0.5)
		for i, a in {kino, rex} do
			Kit.delay((i - 1) * 0.4, function()
				a:to(P.PUSHUP, 0.9, "inOut")
				a:body({pitch = -rad(52), lift = -(a.stand - 1.5 * a.scale)}, 1.1, "inOut")
				Kit.wait(1.3)
				-- à genoux
				a:to(P.KNEEL, 0.7, "inOut")
				a:body({pitch = 0, lift = 0, air = 0}, 0.7, "inOut")
				Kit.wait(1.1)
				-- debout (un appui sur le genou, le buste se redresse)
				a:to(P.RISE, 0.45, "inOut")
				Kit.wait(0.5)
				a.idle = 1
				a:to(P.DAZED, 0.6, "inOut")
			end)
		end
		at(29.2)
		Kit.cam(function(t) return Kit.look(r(9 - t * 0.5, -6 + t * 0.4, 4.2), r(0, 7, 3.5), 50) end, 0.6)
		at(31.4)
		-- désorientés, ils regardent autour d'eux
		say("rexydev1", "Where... are we?", 2)
		Fx.burst("Confused-01", rex:center(3.6), {scale = 1})
		for i, a in {kino, rex} do
			Kit.fork(function()
				for _, dir in {V(-14, 3, -10), V(12, 6, 4), V(-6, 2, 10)} do
					a:watch(a.pos + dir, 1)
					Kit.wait(0.65 + i * 0.1)
				end
			end)
		end
		-- l'alien sort de l'ombre au fond de la salle
		at(32.6)
		alien:place(r(0, 36), r(0, 0))
		alien:to(A.IDLE, 0)
		alien:fade(1, 0.8)
		alien:gait("alienStalk", 0.2)
		alien:move(r(0, 23), 3, "linear")
		for _, a in {kino, rex} do Kit.delay(0.4, function() a:watch(alien, 1) a:face(alien, 0.5) a:to(merge(P.DAZED, {Waist = {-8}, Neck = {6}}), 0.4) end) end
		Kit.snd(S.MetalHit, 0.35, 0.6)
		-- travelling vers l'alien qui avance lentement
		Kit.cam(function(t) return Kit.look(r(1.2, 10 + t * 2.4, 4.6), alien:center(2), 46 - t * 2) end, 0.6)
		at(35.4)
		alien:gait(nil, 0.2)
		-- le cri menaçant
		alien:to(A.ROAR, 0.25, "outBack")
		alienParts.Mouth.Transparency = 0
		Kit.snd(S.Screech, 0.9, 0.85)
		Kit.shake(0.6)
		Kit.punch(-6)
		Fx.burst("Wind-02", alien:center(2), {scale = 2})
		Kit.cam(function(t) return Kit.look(alien:point(6.5, 0.6, 2.6), alien:center(2.2), 44 - t * 4) end)
		for _, a in {kino, rex} do a:to(P.GUARD, 0.3, "outQuad") end

		-- ================================================ SCÈNE 4 : combat contre l'alien (36.5 - 56.5 s, 20 s)
		at(36.5)
		alienParts.Mouth.Transparency = 1
		Kit.fadeSound(alienMusic, 0, 0.6)
		local fightMusic = loop(MUSIC.Fight, 0.5)
		Kit.fadeSound(eerie, 0.2, 1)
		local fighters = {kino, rex, alien}
		Kit.cam(wide(fighters, 60, 6.5, 2, 0.12), 0.3)
		-- 1) l'alien fonce sur eux
		alien:to(A.CROUCH, 0.12, "outQuad")
		run(alien, r(-1, 10), 0.75, "alienRun")
		Kit.snd(S.Screech, 0.5, 1.2)
		at(37.2)
		-- griffe vers kinoshi112, qui esquive en déplaçant le buste et les jambes
		alien:face(kino, 0.08)
		alien:to(A.SWIPE_WIND, 0.14, "outCubic")
		at(37.36)
		alien:to(A.SWIPE, 0.1, "outQuart", {lag = false})
		kino:to(P.DODGE, 0.1, "outQuad")
		kino:move(kino:point(-0.4, -2.6, 0), 0.22, "outCubic")
		Kit.snd(S.Whoosh, 0.5, 0.9)
		Fx.mesh("Shock", CFrame.lookAt(alien:point(2.4, 0, 2.2), alien:point(2.4, 0, 2.2) + V(0, 1, 0)), {color = CYAN, size0 = 0.3, size1 = 2.2, time = 0.22})
		at(37.7)
		kino:to(P.GUARD, 0.2, "inOut")
		-- 2) rexydev1 riposte : trois coups de poing
		Kit.cam(function(t) return Kit.look(rex:point(-2.5, 3.2, 1.2), alien:center(1.6), 48) end, 0.2)
		rex:face(alien, 0.1)
		rex:move(alien.pos + flat(rex.pos - alien.pos) * 3.0, 0.15, "outQuad") -- un pas vers lui : les coups arrivent au contact
		Kit.wait(0.12)
		strike(rex, nil, P.JAB_R, alien, {react = A.RECOIL})
		strike(rex, nil, P.JAB_L, alien, {react = A.RECOIL})
		strike(rex, P.GUARD, P.HOOK_R, alien, {power = 1.3, push = 1.6, react = A.STAGGER})
		at(38.9)
		-- 3) contre-attaque de l'alien : il frappe rexydev1 (qui bloque), puis tente d'écraser kinoshi112
		Kit.cam(wide(fighters, 20, 7, 3, -0.15), 0.25)
		alien:to(A.IDLE, 0.12)
		alien:face(rex, 0.1)
		alien:to(A.SWIPE_L_WIND, 0.14, "outCubic")
		at(39.1)
		alien:to(A.SWIPE_L, 0.1, "outQuart", {lag = false})
		rex:to(P.BLOCK, 0.08, "outQuad")
		at(39.18)
		Fx.burst("Slash-Impact-01", rex:center(1.2) + flat(alien.pos - rex.pos) * 0.8, {scale = 0.8, color = CYAN})
		Kit.snd(S.Clang, 0.5, 1.2)
		Kit.shake(0.3)
		skid(rex, alien.pos, 2.2, 0.35, P.BLOCK)
		at(39.6)
		alien:face(kino, 0.12)
		alien:to(A.SLAM_WIND, 0.3, "outCubic")
		Kit.snd(S.Screech, 0.4, 1.4)
		at(39.95)
		-- kinoshi112 saute de côté
		kino:to(P.TUCK or P.CROUCH, 0.1)
		kino:body({air = 1}, 0.05)
		kino:move(kino:point(0.5, 3.6, 0), 0.4, "outQuad", {arc = 2.2})
		alien:to(A.SLAM, 0.1, "outQuart", {lag = false})
		at(40.05)
		local slamAt = alien:point(2.6, 0, 0)
		Fx.burst("Crack-01", slamAt + V(0, 0.2, 0), {scale = 1.2, time = 0.3})
		Fx.burst("Ground-Impact", slamAt + V(0, 0.3, 0), {scale = 0.8})
		Kit.snd(S.MetalHit, 0.7, 0.8)
		Kit.shake(0.6)
		at(40.4)
		kino:body({air = 0}, 0.08)
		kino:to(P.LAND, 0.08, "outQuad")
		dust(kino.pos, 0.8)
		at(40.65)
		-- 4) kinoshi112 esquive encore (sous la griffe) puis enchaîne quatre coups de poing
		kino:to(P.GUARD, 0.15)
		alien:to(A.IDLE, 0.15)
		Kit.cam(function(t) return Kit.look(kino:point(-1.5, 3.4, 1.4), (kino:center(1.5) + alien:center(1.5)) / 2, 50) end, 0.2)
		alien:face(kino, 0.08)
		alien:to(A.SWIPE_WIND, 0.12, "outCubic")
		at(40.85)
		alien:to(A.SWIPE, 0.09, "outQuart", {lag = false})
		kino:to(P.DUCK, 0.08, "outQuad")
		Kit.snd(S.Whoosh, 0.5, 1)
		at(41.15)
		kino:face(alien, 0.08)
		kino:move(alien.pos + flat(kino.pos - alien.pos) * 3.2, 0.15, "outQuad")
		strike(kino, P.GUARD, P.JAB_L, alien, {wind = 0.08, react = A.RECOIL})
		strike(kino, nil, P.JAB_R, alien, {react = A.RECOIL})
		strike(kino, P.GUARD, P.HOOK_R, alien, {power = 1.2, react = A.STAGGER})
		strike(kino, P.DUCK, P.UPPER_R, alien, {wind = 0.14, power = 1.6, push = 1.2, react = A.RECOIL, hold = 0.12})
		alien:body({lift = 1.2}, 0.12, "outQuad")
		Kit.delay(0.2, function() alien:body({lift = 0}, 0.2, "inQuad") end)
		Kit.flash(0.15, WHITE, 0.4)
		at(42.7)
		-- 5) rexydev1 enchaîne avec des coups de pied, puis se défend
		Kit.cam(wide(fighters, 120, 5.5, 1, 0.1), 0.3)
		rex:face(alien, 0.1)
		rex:move(alien.pos + flat(rex.pos - alien.pos) * 3.6, 0.2, "outQuad")
		strike(rex, P.KICK_WIND, P.KICK, alien, {wind = 0.12, cut = 0.1, power = 1.4, push = 2.4, react = A.STAGGER, guard = P.GUARD})
		at(43.4)
		rex:move(alien.pos + flat(rex.pos - alien.pos) * 3.6, 0.18, "outQuad")
		strike(rex, P.ROUND_WIND, P.ROUND, alien, {wind = 0.14, cut = 0.12, power = 1.3, push = 1.4, react = A.RECOIL, where = function() return alien:center(2.2) end})
		at(44.0)
		alien:face(rex, 0.1)
		alien:to(A.SWIPE_WIND, 0.12)
		at(44.15)
		alien:to(A.SWIPE, 0.09, "outQuart", {lag = false})
		rex:to(P.BLOCK, 0.08)
		at(44.22)
		Fx.burst("Slash-Impact-01", rex:center(1.2) + flat(alien.pos - rex.pos) * 0.8, {scale = 0.7, color = CYAN})
		Kit.snd(S.Clang, 0.45, 1.3)
		skid(rex, alien.pos, 1.2, 0.3)
		at(44.6)
		-- 6) l'alien recule, rugit, puis revient à la charge
		alien:to(A.IDLE, 0.2)
		alien:gait("alienStalk", 0.15)
		alien:move(r(0, 21), 0.9, "outQuad")
		Kit.cam(function(t) return Kit.look(r(-6 + t, 3, 6), alien:center(2), 50 - t * 3) end, 0.3)
		for _, a in {kino, rex} do a:to(P.GUARD, 0.2) a:face(alien, 0.3) end
		at(45.5)
		alien:gait(nil, 0.1)
		alien:to(A.ROAR, 0.18, "outBack")
		alienParts.Mouth.Transparency = 0
		Kit.snd(S.Screech, 0.7, 1)
		Kit.shake(0.4)
		at(46.1)
		alienParts.Mouth.Transparency = 1
		-- 7) tout le monde bouge : les héros s'écartent en courant, l'alien bondit sur rexydev1
		Kit.cam(wide(fighters, 200, 8, 6, 0.18), 0.35)
		run(kino, r(-11, 13), 0.7)
		run(rex, r(11, 14), 0.7)
		alien:to(A.CROUCH, 0.15)
		at(46.85)
		local leapTo = rex.pos + flat(alien.pos - rex.pos) * 1.2
		alien:to(A.LEAP, 0.12, "outQuad")
		alien:body({air = 1}, 0.05)
		alien:move(leapTo, 0.55, "inOut", {arc = 5, face = true})
		Kit.snd(S.Whoosh, 0.6, 0.7)
		at(47.05)
		-- rexydev1 saute pour l'éviter
		rex:to(P.CROUCH, 0.08)
		rex:body({air = 1}, 0.05)
		rex:move(rex:point(-1, -4.5, 0), 0.45, "outQuad", {arc = 2.6})
		at(47.4)
		alien:body({air = 0}, 0.06)
		alien:to(A.SLAM, 0.08)
		Fx.burst("Ground-Impact", alien.pos + V(0, 0.3, 0), {scale = 1})
		Fx.burst("Crack-01", alien.pos + V(0, 0.2, 0), {scale = 1.4, time = 0.3})
		Kit.snd(S.MetalHit, 0.8, 0.7)
		Kit.shake(0.7)
		at(47.5)
		rex:body({air = 0}, 0.06)
		rex:to(P.LAND, 0.08)
		-- kinoshi112 arrive en courant et lui met un coup de pied sauté
		kino:face(alien, 0.1)
		run(kino, alien.pos + flat(kino.pos - alien.pos) * 7, 0.35)
		at(47.9)
		kino:to(P.JUMPKICK, 0.12, "outQuad")
		kino:body({air = 1}, 0.05)
		kino:move(alien.pos + flat(kino.pos - alien.pos) * 2.6, 0.32, "outQuad", {arc = 2})
		Kit.cam(function(t) return Kit.look(kino:point(1, -5, 2), alien:center(1.5), 48) end, 0.15)
		at(48.2)
		impact(alien, alien:center(1.4), 1.5)
		skid(alien, kino.pos, 3, 0.4, A.STAGGER)
		Kit.ghost(kino, CYAN, 0.3, 0.5)
		at(48.4)
		kino:body({air = 0}, 0.08)
		kino:to(P.LAND, 0.08)
		dust(kino.pos, 0.8)
		at(48.7)
		-- 8) rexydev1 frappe, l'alien le touche en retour (rexydev1 encaisse et recule)
		kino:to(P.GUARD, 0.2)
		rex:to(P.GUARD, 0.12)
		rex:face(alien, 0.1)
		run(rex, alien.pos + flat(rex.pos - alien.pos) * 3.4, 0.35)
		at(49.1)
		Kit.cam(wide(fighters, 300, 6, 2, -0.1), 0.25)
		strike(rex, nil, P.JAB_R, alien, {react = A.RECOIL})
		strike(rex, nil, P.JAB_L, alien, {react = A.RECOIL})
		at(49.6)
		alien:face(rex, 0.06)
		alien:to(A.SWIPE_WIND, 0.1)
		at(49.72)
		alien:to(A.SWIPE, 0.08, "outQuart", {lag = false})
		at(49.78)
		impact(rex, rex:center(1.2), 1.2, CYAN)
		skid(rex, alien.pos, 3, 0.4, P.HURT)
		at(50.3)
		rex:to(P.GUARD, 0.25)
		-- 9) l'alien se jette sur kinoshi112, qui plonge sous lui et passe dans son dos
		alien:face(kino, 0.1)
		alien:to(A.GRAB, 0.15)
		alien:move(alien.pos + flat(kino.pos - alien.pos) * 2.5, 0.25, "outQuad")
		at(50.5)
		kino:to(P.DUCK, 0.08)
		local behind = alien.pos + flat(alien.pos - kino.pos) * 3.2
		kino:move(behind, 0.32, "inOut")
		Kit.ghost(kino, CYAN, 0.3, 0.5)
		Kit.snd(S.Whoosh, 0.5, 1.1)
		at(50.9)
		kino:to(P.GUARD, 0.12)
		kino:face(alien, 0.08)
		rex:face(alien, 0.08)
		rex:move(alien.pos + flat(rex.pos - alien.pos) * 3.6, 0.2, "outQuad")
		at(51.15)
		-- 10) les deux frappent en même temps : coup de pied de face, coup de poing dans le dos
		Kit.cam(function(t) return Kit.look(alien:point(0, 7, 1.5), alien:center(1.2), 50) end, 0.15)
		rex:to(P.KICK_WIND, 0.12)
		kino:to(P.GUARD, 0.12)
		at(51.3)
		rex:to(P.KICK, 0.08, "outQuart", {lag = false})
		kino:to(P.JAB_R, 0.08, "outQuart", {lag = false})
		at(51.36)
		impact(alien, alien:center(1.2), 1.8, PURPLE)
		Kit.flash(0.2, WHITE, 0.6)
		Fx.mesh("Shockwave", CFrame.new(alien.pos + V(0, 0.4, 0)), {color = PURPLE, size0 = 0.1, size1 = 1.2, time = 0.4})
		alien:to(A.STAGGER, 0.08)
		at(51.7)
		kino:to(P.GUARD, 0.2) rex:to(P.GUARD, 0.2)
		-- 11) l'alien tourne sur lui-même, bras tendus : les deux héros reculent d'un bond
		alien:to(A.SPIN, 0.15)
		Kit.tween(0.6, function(e) alien.yaw += 0.42 end, "linear")
		Kit.snd(S.Whoosh, 0.6, 0.6)
		Kit.cam(wide(fighters, 80, 9, 5, 0.2), 0.3)
		at(51.85)
		for _, a in {kino, rex} do
			a:to(P.CROUCH, 0.08)
			a:body({air = 1}, 0.04)
			a:move(a.pos + flat(a.pos - alien.pos) * 3.5, 0.42, "outQuad", {arc = 1.8})
			Kit.delay(0.42, function() a:body({air = 0}, 0.06) a:to(P.LAND, 0.08) dust(a.pos, 0.6) end)
		end
		at(52.6)
		for _, a in {kino, rex} do a:to(P.GUARD, 0.25) a:face(alien, 0.2) end
		alien:to(A.IDLE, 0.25)
		at(53.0)
		-- 12) il charge kinoshi112 : bloqué, contre en coup de poing puissant ; rexydev1 le fauche, il tombe à genoux
		alien:face(kino, 0.1)
		run(alien, alien.pos + flat(kino.pos - alien.pos) * ((kino.pos - alien.pos).Magnitude - 3.4), 0.45, "alienRun")
		Kit.cam(function(t) return Kit.look(kino:point(-2.5, 3.5, 1), alien:center(1.6), 50) end, 0.2)
		at(53.5)
		alien:to(A.SWIPE_WIND, 0.1)
		at(53.62)
		alien:to(A.SWIPE, 0.08, "outQuart", {lag = false})
		kino:to(P.BLOCK, 0.07)
		at(53.68)
		Fx.burst("Slash-Impact-01", kino:center(1.2) + flat(alien.pos - kino.pos) * 0.8, {scale = 0.8, color = CYAN})
		Kit.snd(S.Clang, 0.5, 1.15)
		Kit.shake(0.3)
		at(53.95)
		strike(kino, P.GUARD, P.HOOK_R, alien, {wind = 0.1, power = 1.7, push = 2.2, react = A.STAGGER})
		at(54.5)
		rex:face(alien, 0.08)
		run(rex, alien.pos + flat(rex.pos - alien.pos) * 2.8, 0.3)
		at(54.85)
		rex:to(P.SWEEP, 0.12, "outQuart")
		Kit.snd(S.Whoosh, 0.6, 0.8)
		at(55.0)
		impact(alien, alien.pos + V(0, 1, 0), 1.2)
		alien:to(A.KNEEL, 0.12, "outQuad")
		dust(alien.pos, 1)
		Kit.cam(wide(fighters, 160, 5, 3, 0.1), 0.3)
		at(55.5)
		rex:to(P.GUARD, 0.3)
		kino:watch(alien, 1)
		say("kinoshi112", "It's over for you!", 1.6)

		------------------------------------------------ FIN DU COMBAT : kinoshi112 l'attrape par le cou et le projette contre le mur
		at(56.3)
		Kit.cam(function(t) return Kit.look(kino:point(-3, 4, 1.6) + V(0, 0, 0), alien:center(1.5), 50) end, 0.2)
		kino:face(alien, 0.08)
		run(kino, alien.pos + flat(kino.pos - alien.pos) * 2.2, 0.4)
		Kit.ghost(kino, CYAN, 0.3, 0.5)
		at(56.75)
		kino:to(P.GRAB, 0.12, "outQuad")
		Kit.snd(S.Snap, 0.6, 0.7)
		Kit.shake(0.25)
		local holding = true
		local liftH = 0
		alien:body({air = 1}, 0.1)
		alien:to(A.CHOKED, 0.12)
		alien.idle = 0
		Kit.fork(function()
			while holding and Kit.running do
				local f = kino:point(2.0, 0, 0)
				alien.pos, alien.btw.pos = V(f.X, kino.pos.Y, f.Z), nil
				alien.yaw, alien.btw.yaw = kino.yaw + math.pi, nil
				alien.lift = liftH
				Kit.wait(1 / 120)
			end
		end)
		at(57.0)
		-- il le soulève : jambes fléchies, puis poussée du buste
		kino:to(P.LIFT_LOW, 0.3, "inOut")
		Kit.cam(function(t) return Kit.look(kino:point(1, -5.5, 0.3), (kino:center(2) + alien:center(1)) / 2, 50 + t * 2) end, 0.3)
		at(57.35)
		kino:to(P.LIFT_HIGH, 0.45, "outQuad")
		Kit.tween(0.45, function(e) liftH = 3.4 * e end, "outQuad")
		Kit.snd(S.Thud, 0.6, 0.6)
		-- l'alien se débat
		flail(alien, 1.5, 0.7, {Neck = {35}, Jaw = {random(10, 40)}})
		Kit.snd(S.Screech, 0.6, 1.5)
		at(58.85)
		-- kinoshi112 pivote sur lui-même...
		Kit.cam(function(t) return Kit.look(kino.pos + V(0, 12, 0) + V(cos(t * 2) * 9, 0, sin(t * 2) * 9), kino:center(2), 60) end, 0.2)
		kino:to(merge(P.LIFT_HIGH, {Waist = {8, 30, 0}, LeftHip = {30, 0, -10}, LeftKnee = {-40}}), 0.3)
		kino:body({yaw = kino.yaw - rad(250)}, 0.75, "inOut")
		Kit.snd(S.Whoosh, 0.6, 0.5)
		at(59.6)
		-- ...et le lance violemment contre le mur métallique
		holding = false
		local panel = room:WaitForChild("ImpactWall"):WaitForChild("Panel")
		local wallHit = V(panel.Position.X - 1.4, M.ROOM.Y, panel.Position.Z)
		kino:face(wallHit, 0.05)
		kino:to(P.THROW, 0.12, "outQuart", {lag = false})
		alien:to(A.FLY, 0.1)
		alien.yaw = Kit.yawTo(wallHit, kino.pos)
		alien:move(wallHit, 0.42, "outQuad", {arc = 1.2})
		alien:body({lift = 2.8, roll = rad(25)}, 0.42, "linear")
		Kit.speedLines(0.5, 0.6)
		Kit.snd(S.Whoosh, 0.8, 0.6)
		Kit.cam(function(t) return Kit.look(r(18, 5, -4), alien:center(1), 52 - t * 6) end)
		Kit.fork(function() for _ = 1, 6 do Kit.ghost(alien, PURPLE, 0.25, 0.5) Kit.wait(0.06) end end)
		at(60.02)
		-- impact : étincelles, bruit métallique, le mur se déforme, la caméra tremble
		alien:to(A.SPLAT, 0.05)
		local hitPoint = V(panel.Position.X - 0.5, alien:center(1).Y, panel.Position.Z)
		Fx.burst("Slash-Impact-01", hitPoint, {scale = 1.6, color = ORANGE})
		Fx.burst("Lighting-01", hitPoint, {scale = 1.4, color = ORANGE, time = 0.15})
		Fx.burst("Punch-02", hitPoint, {scale = 2})
		Fx.mesh("Shockwave", CFrame.new(hitPoint) * CFrame.Angles(0, 0, rad(90)), {color = ORANGE, size0 = 0.1, size1 = 1.4, time = 0.45})
		Fx.light(hitPoint, ORANGE, 30, 7, 0.5)
		do -- gerbe d'étincelles
			local holder = Instance.new("Attachment")
			holder.WorldPosition = hitPoint
			holder.Parent = workspace.Terrain
			local sparks = Instance.new("ParticleEmitter")
			sparks.Texture, sparks.LightEmission, sparks.LightInfluence = "rbxasset://textures/particles/sparkles_main.dds", 1, 0
			sparks.Color = ColorSequence.new(rgb(255, 240, 180), ORANGE)
			sparks.Rate, sparks.Lifetime, sparks.Speed = 0, NumberRange.new(0.4, 0.9), NumberRange.new(18, 36)
			sparks.SpreadAngle, sparks.Acceleration, sparks.Drag = Vector2.new(70, 70), V(0, -60, 0), 1
			sparks.EmissionDirection = Enum.NormalId.Left
			sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(1, 0)})
			sparks.Parent = holder
			if not Kit.fast() then sparks:Emit(90) end
			Debris:AddItem(holder, 1.5)
		end
		Kit.snd(S.MetalHit, 1, 0.75)
		Kit.snd(S.Clang, 0.8, 0.6)
		Kit.snd(S.Spark, 0.7, 1)
		Kit.shake(1.2)
		Kit.punch(-8)
		Kit.hitstop(0.18, 0.05)
		local panelCF = panel.CFrame
		panel.CFrame = panelCF * CFrame.new(0.35, 0, 0) * CFrame.Angles(0, 0, rad(4))
		panel.Color = rgb(96, 100, 116)
		at(60.4)
		-- il glisse le long du mur et tombe au sol, immobile
		alien:to(A.DOWN, 0.4, "inQuad")
		alien:body({lift = -(alien.stand - 0.55 * alien.scale), pitch = rad(85), roll = 0}, 0.45, "inQuad")
		alien:move(wallHit - V(2.2, 0, 0), 0.45, "inQuad")
		at(60.85)
		dust(alien.pos, 1.4)
		Kit.snd(S.Thud, 0.8, 0.7)
		Kit.shake(0.4)
		for _, n in {"EyeGlint", "AntennaTip", "Core"} do
			for _, p in alienRig:GetDescendants() do
				if p.Name == n and p:IsA("BasePart") then TweenService:Create(p, TweenInfo.new(1.2), {Color = rgb(40, 40, 50)}):Play() end
			end
		end
		Kit.cam(function(t) return Kit.look(alien:point(-1, 6, 3) + V(0, -t * 0.5, 0), alien:center(0), 46 - t * 2) end, 0.4)
		kino:to(P.TIRED, 0.5, "inOut")
		Kit.fadeSound(fightMusic, 0.15, 1.5)

		-- ================================================ SCÈNE 5 : la fuite vers le cockpit (62 - 71 s)
		at(62.2)
		kino:watch(nil) rex:watch(nil)
		Kit.cam(function(t) return Kit.look(rex:point(3.2, 1.6, 0.8), rex:center(2), 42) end, 0.5)
		rex:watch(r(0, -52, 4), 1)
		rex:to(P.DAZED, 0.3)
		at(63.1)
		-- il se retourne brusquement vers kinoshi112
		rex:face(kino, 0.18, "outQuad")
		rex:watch(kino, 1)
		rex:to(P.POINT, 0.2, "outQuad")
		say("rexydev1", "THE COCKPIT! Let's get out of here!", 2.2)
		Kit.cam(function(t) return Kit.look((kino:center(1) + rex:center(1)) / 2 + V(6, 2.5, 6), (kino:center(2) + rex:center(2)) / 2, 48) end, 0.3)
		at(64.4)
		rex:watch(nil) kino:watch(nil)
		local seatPos = r(0, -50.6, 1.2)
		run(rex, r(0.6, -41), 1.7)
		Kit.delay(0.35, function() run(kino, r(-3.2, -42.5), 1.9) end)
		Kit.cam(function(t) return Kit.look(r(9, -44 + t * 0.5, 4.5), rex:center(1.5), 54) end, 0.4)
		at(66.1)
		-- il saute sur le siège du pilote
		rex:to(P.CROUCH, 0.08)
		rex:body({air = 1}, 0.05)
		rex:move(seatPos, 0.5, "inOut", {arc = 3})
		rex:body({yaw = Kit.yawTo(seatPos, r(0, -60))}, 0.4)
		Kit.snd(S.Whoosh, 0.4, 1)
		at(66.6)
		local seatLift = (3.25 + 0.4) - (1.2 + seatHeight(rex))
		rex:to(P.PILOT, 0.15, "outQuad")
		rex:body({air = 0, lift = seatLift}, 0.1)
		Kit.snd(S.Thud, 0.4, 1.2)
		kino:face(r(0, -60), 0.3)
		kino:to(P.DAZED, 0.3)
		-- il regarde les boutons, tire les leviers, appuie partout
		local cockpit = room:WaitForChild("Cockpit")
		local levers = {cockpit:FindFirstChild("Lever1"), cockpit:FindFirstChild("Lever2")}
		local leverBase = {}
		for i, l in levers do if l then leverBase[i] = l:GetPivot() end end
		local function pull(i, angle, dur)
			local l, base = levers[i], leverBase[i]
			if not l or not base then return end
			local from = l:GetPivot()
			Kit.tween(dur or 0.2, function(e) l:PivotTo(from:Lerp(base * CFrame.Angles(rad(angle), 0, 0), e)) end, "outQuad")
			Kit.snd(S.Snap, 0.5, 0.8)
		end
		local buttons = {}
		for _, d in cockpit:GetDescendants() do if d.Name == "Button" then table.insert(buttons, d) end end
		local function press(n)
			for _ = 1, n or 1 do
				local b = buttons[random(1, math.max(#buttons, 1))]
				if b then
					local c = b.Color
					b.Color = WHITE
					Kit.delay(0.15, function() b.Color = c end)
				end
			end
			Kit.snd(S.Ping, 0.35, 0.8 + random() * 0.6)
		end
		Kit.cam(function(t) return Kit.look(r(-3.5 + t * 0.4, -57.5, 6.5), rex:center(1.2), 50) end, 0.4)
		say("kinoshi112", "Wait... do you even know how to fly this?!", 2.2)
		at(67.2) rex:to(P.PILOT_A, 0.15) press(2)
		at(67.5) rex:to(P.PILOT_B, 0.15) press(2)
		at(67.8) rex:to(merge(P.PILOT, {RightShoulder = {80, 0, -12}, RightElbow = {15}}), 0.12) pull(1, -45)
		at(68.1) rex:to(P.PILOT_A, 0.12) press(3)
		Kit.shake(0.2)
		at(68.4)
		say("rexydev1", "...No. Not at all.", 1.8)
		rex:watch(kino, 1)
		rex:to(merge(P.PILOT, {Neck = {0, 50, 0}}), 0.2)
		Kit.cam(function(t) return Kit.look(r(4, -46, 5.5), rex:center(2), 40) end, 0.3)
		at(69.4)
		rex:watch(nil)
		rex:to(P.PILOT_B, 0.12) pull(2, -50) press(2)
		-- le vaisseau vibre, les lumières clignotent
		local ceilingLights = {}
		for _, d in room:GetDescendants() do if d.Name == "CeilingLight" then table.insert(ceilingLights, d) end end
		local flicker = true
		Kit.fork(function()
			while flicker and Kit.running do
				for _, p in ceilingLights do p.Transparency = random() < 0.4 and 0.85 or 0.25 end
				Kit.wait(0.07 + random() * 0.08)
			end
			for _, p in ceilingLights do p.Transparency = 0.25 end
		end)
		Kit.shake(0.35)
		at(70.0)
		-- LA mauvaise commande : le gros bouton rouge
		rex:to(merge(P.PILOT, {RightShoulder = {95, 0, -5}, RightElbow = {5}}), 0.1, "outQuart")
		Kit.cam(function(t) return Kit.look(rex:point(1.2, 1.4, 1.4), rex:point(2.6, 0.2, 0.2), 34) end)
		at(70.15)
		press(4)
		Kit.snd(S.Ping, 0.7, 0.5)

		-- ================================================ SCÈNE 6 : perte de contrôle, crash et explosion (70.3 - 88 s)
		at(70.3)
		-- moteurs qui s'emballent, alarmes, lumières rouges
		task.spawn(CutsceneLock.focus, M.WRECK, 2) -- la Safe Zone (lieu du crash) se charge dès maintenant, sans bloquer le film
		local alarm = loop(S.Alarm, 0.55)
		Kit.snd(S.Meltdown, 0.6)
		Kit.fadeSound(eerie, 0.9, 0.5)
		if eerie then eerie.PlaybackSpeed = 1.4 end
		Kit.fadeSound(fightMusic, 0.45, 1)
		local alarms = {}
		for _, d in room:GetDescendants() do if d.Name == "Alarm" then table.insert(alarms, d) end end
		local alarmOn = true
		Kit.fork(function()
			local on = false
			while alarmOn and Kit.running do
				on = not on
				for _, p in alarms do
					p.Color = on and rgb(255, 40, 50) or rgb(90, 20, 24)
					local l = p:FindFirstChild("AlarmLight")
					if l then l.Brightness = on and 4 or 0 end
				end
				Kit.wait(0.28)
			end
		end)
		TweenService:Create(grade, TweenInfo.new(0.5), {TintColor = rgb(255, 205, 205), Saturation = 0.1}):Play()
		Kit.shake(0.8)
		Kit.cam(function(t) return Kit.look(r(7 + sin(t * 9) * 0.3, -43, 6), r(-1, -54, 4), 58, sin(t * 3) * 8) end, 0.2)
		say("kinoshi112", "WHAT DID YOU PRESS?!", 1.8)
		-- kinoshi112 s'agrippe à une paroi
		local ribPos = r(-26.4, -42.2, 0)
		run(kino, ribPos, 0.8)
		Kit.delay(0.85, function() kino:face(r(-40, -42), 0.15) kino:to(P.HOLD_WALL, 0.2, "outQuad") end)
		-- rexydev1 s'agite sur les commandes
		Kit.fork(function()
			for i = 1, 18 do
				if not Kit.running then return end
				rex:to(i % 3 == 0 and P.PILOT_PANIC or (i % 2 == 0 and P.PILOT_A or P.PILOT_B), 0.1)
				if i % 2 == 0 then press(1) end
				if i % 5 == 0 then pull(1 + i % 2, i % 2 == 0 and 35 or -55, 0.15) end
				Kit.wait(0.17)
			end
		end)
		-- secousses : ils sont projetés vers l'avant et sur les côtés
		Kit.fork(function()
			for i = 1, 9 do
				if not Kit.running then return end
				Kit.shake(0.5 + random() * 0.6)
				local side = (i % 2 == 0) and 1 or -1
				for _, a in {kino, rex} do
					a:body({roll = rad(14 * side), pitch = -rad(8 + random() * 8)}, 0.12, "outQuad")
					Kit.delay(0.18, function() a:body({roll = 0, pitch = 0}, 0.25, "inOut") end)
					a:hit(0.6)
				end
				Kit.wait(0.42)
			end
		end)
		at(72.2)
		Kit.cam(function(t) return Kit.look(r(-20, -36, 6.5), kino:center(1.5), 52, sin(t * 4) * 10) end, 0.3)
		at(73.4)
		Kit.cam(function(t) return Kit.look(r(2 + sin(t * 11) * 0.4, -40, 7), r(0, -62, 9), 70, -10 + sin(t * 5) * 14) end, 0.2)
		say("rexydev1", "WE'RE GOING DOWN!!!", 1.6)
		at(74.6)
		Kit.flash(0.3, WHITE, 0.7)
		Kit.fade(0, 0.25)
		at(74.9)
		-- dehors : le vaisseau plonge vers la Safe Zone en fumant
		flicker, alarmOn = false, false
		-- personnages des joueurs cachés chez ce joueur pendant les plans dans la Safe Zone
		for _, p in Players:GetPlayers() do
			if p.Character then
				for _, d in p.Character:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Decal") then
						hiddenChars[d] = d.LocalTransparencyModifier
						d.LocalTransparencyModifier = 1
					elseif d:IsA("BillboardGui") then
						hiddenChars[d] = d.Enabled
						d.Enabled = false
					end
				end
			end
		end
		room:Destroy()
		for _, a in {kino, rex} do a:setVisible(0) a:gait(nil, 0) a:body({air = 0, lift = 0, pitch = 0, roll = 0}, 0) end
		alien:destroy()
		Kit.fadeSound(eerie, 0, 1)
		TweenService:Create(grade, TweenInfo.new(0.6), {Brightness = 0, Saturation = 0.05, Contrast = 0.08, TintColor = rgb(255, 240, 230)}):Play()
		local crashShip, crashSize = AlienCast.ship(1.6)
		crashShip.Parent = scene
		local pathFrom, pathTo = M.WRECK + V(520, 300, -140), M.WRECK + V(0, crashSize.Y * 0.18, 0)
		crashShip:PivotTo(CFrame.new(pathFrom))
		local smokeTrail = true
		Kit.fork(function()
			while smokeTrail and Kit.running do
				local p = crashShip:GetPivot().Position
				Fx.burst("Smoke-01", p + V(0, 4, 0), {scale = 3.5})
				Fx.burst("Fire-02", p + V(random(-8, 8), 2, random(-8, 8)), {scale = 3, time = 0.2})
				Kit.wait(0.07)
			end
		end)
		at(75.2)
		Kit.fade(1, 0.35)
		Kit.tween(4, function(e, u)
			local p = pathFrom:Lerp(pathTo, e) + V(sin(u * 9) * 10 * (1 - u), sin(u * 6) * 6 * (1 - u), 0)
			crashShip:PivotTo(CFrame.new(p) * CFrame.Angles(rad(20) * sin(u * 7), u * 9, rad(28) * u))
		end, "inQuad")
		Kit.cam(function(t)
			local p = crashShip:GetPivot().Position
			return Kit.look(M.STAGE + V(-40, 18, 70), p, 60 - t * 4)
		end, 0)
		Kit.snd(S.Whoosh, 0.9, 0.35)
		at(77.4)
		Kit.cam(function(t)
			local p = crashShip:GetPivot().Position
			return Kit.look(M.WRECK + V(70, 14, -90), p, 58)
		end, 0.4)
		at(79.2)
		-- CRASH : boule de feu, fumée, débris, onde de choc
		smokeTrail = false
		local boom = M.WRECK + V(0, 6, 0)
		Kit.flash(0.7, rgb(255, 220, 160), 1)
		Fx.burst("Realistic-Explosion-01", boom, {scale = 9, time = 0.4})
		Fx.burst("Explosion-01", boom, {scale = 8, time = 0.4})
		Fx.burst("Big-Crack-01", M.WRECK + V(0, 0.6, 0), {scale = 5, time = 0.6})
		Fx.burst("Ground-Impact", M.WRECK + V(0, 0.4, 0), {scale = 5})
		Fx.mesh("Shockwave", CFrame.new(M.WRECK + V(0, 0.8, 0)), {color = ORANGE, size0 = 0.5, size1 = 16, time = 1, transp0 = 0.2, ease = "outQuad"})
		Fx.mesh("Sphere", CFrame.new(boom), {color = rgb(255, 170, 70), size0 = 0.5, size1 = 7, time = 0.9, transp0 = 0.1})
		Fx.light(boom, ORANGE, 120, 10, 1.6)
		Kit.snd(S.Boom, 1, 0.9)
		Kit.snd(S.CosmicBoom, 0.5, 0.7)
		Kit.shake(2.2)
		Kit.punch(-10)
		Kit.hitstop(0.12, 0.2)
		-- l'épave : enfoncée de travers dans le sol, carbonisée, au milieu d'un cratère noirci
		crashShip:PivotTo(CFrame.new(M.WRECK - V(0, crashSize.Y * 0.08, 0)) * CFrame.Angles(rad(22), rad(35), rad(-18)))
		for _, p in crashShip:GetDescendants() do
			if p:IsA("BasePart") then
				if p.Material ~= Enum.Material.Neon then p.Color = p.Color:Lerp(rgb(30, 26, 26), 0.55) end
				p.CanQuery = true -- (pour poser les héros sur la coque, voir onWreck)
			end
		end
		local crater = Instance.new("Part")
		crater.Shape = Enum.PartType.Cylinder
		crater.Anchored, crater.CanCollide, crater.CanQuery, crater.CanTouch, crater.CastShadow = true, false, false, false, false
		crater.Size = V(0.2, crashSize.X * 1.1, crashSize.X * 1.1)
		crater.CFrame = CFrame.new(M.WRECK + V(0, 0.1, 0)) * CFrame.Angles(0, 0, rad(90))
		crater.Color, crater.Material, crater.Transparency = rgb(28, 24, 24), Enum.Material.Slate, 0.1
		crater.Parent = scene
		local debris = {}
		for i = 1, 24 do
			local d = Instance.new("Part")
			d.Size = V(random(10, 40) / 10, random(4, 14) / 10, random(10, 30) / 10)
			d.Color = i % 3 == 0 and rgb(60, 60, 70) or rgb(150, 156, 170)
			d.Material = Enum.Material.Metal
			d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch = true, false, false, false
			d.Parent = scene
			local a = random() * math.pi * 2
			local dist = random(20, 70)
			local to = M.WRECK + V(cos(a) * dist, 0.4, sin(a) * dist)
			local h = random(14, 40)
			local spin = CFrame.Angles(random() * 6, random() * 6, random() * 6)
			Kit.tween(0.9 + random() * 0.6, function(e, u) d.CFrame = CFrame.new(boom:Lerp(to, e) + V(0, h * 4 * u * (1 - u), 0)) * spin * CFrame.Angles(u * 8, u * 5, 0) end, "outQuad")
			table.insert(debris, d)
		end
		-- l'épave brûle : feu et colonne de fumée
		local fireHolder = Instance.new("Part")
		fireHolder.Anchored, fireHolder.CanCollide, fireHolder.CanQuery, fireHolder.CanTouch, fireHolder.Transparency = true, false, false, false, 1
		fireHolder.Size = V(crashSize.X * 0.7, 2, crashSize.Z * 0.7)
		fireHolder.CFrame = CFrame.new(M.WRECK + V(0, 6, 0))
		fireHolder.Parent = scene
		local fire = Instance.new("ParticleEmitter")
		fire.Texture, fire.LightEmission = "rbxasset://textures/particles/fire_main.dds", 0.9
		fire.Color = ColorSequence.new(rgb(255, 220, 120), rgb(255, 80, 20))
		fire.Shape, fire.Rate, fire.Lifetime, fire.Speed = Enum.ParticleEmitterShape.Box, 60, NumberRange.new(0.6, 1.2), NumberRange.new(4, 9)
		fire.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5), NumberSequenceKeypoint.new(1, 1)})
		fire.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1)})
		fire.EmissionDirection = Enum.NormalId.Top
		fire.Parent = fireHolder
		local smoke = Instance.new("ParticleEmitter")
		smoke.Texture, smoke.LightEmission = "rbxasset://textures/particles/smoke_main.dds", 0
		smoke.Color = ColorSequence.new(rgb(90, 86, 86), rgb(40, 38, 40))
		smoke.Shape, smoke.Rate, smoke.Lifetime, smoke.Speed = Enum.ParticleEmitterShape.Box, 22, NumberRange.new(4, 6), NumberRange.new(8, 14)
		smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 8), NumberSequenceKeypoint.new(1, 22)})
		smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1)})
		smoke.RotSpeed, smoke.EmissionDirection = NumberRange.new(-20, 20), Enum.NormalId.Top
		smoke.Parent = fireHolder
		local fireLight = Instance.new("PointLight")
		fireLight.Color, fireLight.Range, fireLight.Brightness, fireLight.Shadows = ORANGE, 50, 2.5, false
		fireLight.Parent = fireHolder
		local fireSound = loop(9079463756, 0.5)
		Kit.cam(function(t) return Kit.look(M.WRECK + V(85 - t * 3, 20 + t, -60 + t * 2), M.WRECK + V(0, 6, 0), 62) end, 0)
		Kit.fadeSound(alarm, 0, 0.3)
		Kit.fadeSound(fightMusic, 0, 2)
		at(80.4)
		Fx.burst("Smoke-01", M.WRECK + V(0, 4, 0), {scale = 8})
		at(83.0)
		-- ils sortent de l'épave : accroupis sur la coque, ils se redressent, traversent la fumée et sautent
		-- point de la coque sous un endroit donné (rayon vers le bas sur l'épave)
		local function onWreck(offset)
			local p = M.WRECK + offset
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Include
			params.FilterDescendantsInstances = {crashShip}
			local hit = workspace:Raycast(p + V(0, 80, 0), V(0, -160, 0), params)
			return hit and hit.Position or (p + V(0, 6, 0))
		end
		local exitK, exitR = onWreck(V(16, 0, -14)), onWreck(V(19, 0, -10))
		kino:place(exitK, exitK + V(10, 0, -8))
		rex:place(exitR, exitR + V(10, 0, -8))
		for _, a in {kino, rex} do
			a:to(P.CROUCH, 0)
			a:setVisible(1)
			a.idle = 1
		end
		Kit.cam(function(t) return Kit.look(M.WRECK + V(46, 6, -36) + V(0, 0, t * 0.6), (kino:center(1) + rex:center(1)) / 2, 50) end, 0)
		Fx.burst("Smoke-01", exitK, {scale = 4})
		at(83.5)
		for i, a in {kino, rex} do Kit.delay((i - 1) * 0.3, function() a:to(P.RISE, 0.4) Kit.wait(0.45) a:to(P.DAZED, 0.4) end) end
		say("rexydev1", "*cough* *cough*", 1.4)
		at(84.6)
		walk(kino, onWreck(V(22, 0, -19)), 1.2)
		walk(rex, onWreck(V(25, 0, -15)), 1.2)
		at(86.0)
		local landK, landR = M.WRECK + V(30, 0, -34), M.WRECK + V(33, 0, -29)
		for i, a in {kino, rex} do
			Kit.delay((i - 1) * 0.2, function()
				a:to(P.CROUCH, 0.1)
				a:body({air = 1}, 0.05)
				a:move(i == 1 and landK or landR, 0.55, "inOut", {arc = 3})
				Kit.wait(0.55)
				a:body({air = 0}, 0.06)
				a:to(P.LAND, 0.08)
				dust(a.pos, 1)
				Kit.snd(S.Thud, 0.5, 1)
			end)
		end
		Kit.cam(function(t) return Kit.look(landK + V(14, 4, -12), landK + V(0, 2.5, 0), 52) end, 0.4)

		-- ================================================ SCÈNE 7 : arrivée dans la Safe Zone (88 - 96 s)
		at(87.4)
		for _, a in {kino, rex} do a:to(P.STAND, 0.4) end
		at(88.0)
		-- la caméra révèle la Safe Zone (grue qui monte au-dessus d'eux)
		Kit.fadeSound(fireSound, 0.15, 3)
		local calm2 = loop(MUSIC.Calm, 0)
		Kit.fadeSound(calm2, 0.3, 3)
		Kit.cam(function(t) return Kit.look(landK + V(-26 + t * 2, 10 + t * 6, -26 - t * 2), M.STAGE + V(0, 0, 10), 60) end, 0.5)
		Kit.say("SAFE ZONE", 2)
		walk(kino, M.STAGE + V(-2.6, 0, 0), 4)
		walk(rex, M.STAGE + V(2.6, 0, -1.5), 4)
		at(92.2)
		for _, a in {kino, rex} do a:face(M.STAGE + V(0, 0, 60), 0.3) end
		-- soulagés : ils se regardent, reprennent leur souffle
		Kit.cam(function(t) return Kit.look((kino:center(1.5) + rex:center(1.5)) / 2 + V(2, 1, 11 - t * 0.5), (kino:center(2) + rex:center(2)) / 2, 44) end, 0.4)
		kino:watch(rex, 1) rex:watch(kino, 1)
		rex:to(P.TIRED, 0.4)
		kino:to(P.WIPE, 0.4)
		say("kinoshi112", "We made it... the Safe Zone!", 2)
		at(93.4)
		rex:to(P.THUMB, 0.35)
		kino:to(P.STAND, 0.4)
		at(94.2)
		-- kinoshi112 pointe soudain le ciel
		kino:watch(M.COLLIDE, 1)
		kino:face(M.COLLIDE, 0.25)
		kino:to(P.POINT_SKY, 0.22, "outBack")
		say("kinoshi112", "LOOK! Up there!", 1.8)
		Kit.delay(0.4, function() rex:watch(M.COLLIDE, 1) rex:face(M.COLLIDE, 0.4) rex:to(P.LOOK_UP, 0.4) end)
		-- deux galaxies apparaissent au loin
		local galaxyA = AlienCast.galaxy({{0, rgb(255, 240, 250)}, {0.25, rgb(255, 120, 210)}, {0.55, rgb(190, 80, 255)}, {1, rgb(120, 70, 255)}}, 2.6)
		local galaxyB = AlienCast.galaxy({{0, rgb(240, 255, 255)}, {0.25, rgb(120, 230, 255)}, {0.55, rgb(70, 150, 255)}, {1, rgb(255, 210, 110)}}, 2.6)
		local startA, startB = M.COLLIDE + V(-30, 50, -340), M.COLLIDE + V(20, 40, 340)
		local faceStage = function(pos) return CFrame.lookAt(pos, M.STAGE + V(0, 20, 0)) * CFrame.Angles(-rad(90) + rad(25), 0, 0) end
		local galaxies = {{Model = galaxyA, From = startA, Pos = startA, Spin = 0, Rate = 0.25, Dir = 1}, {Model = galaxyB, From = startB, Pos = startB, Spin = 0, Rate = 0.25, Dir = -1}}
		local galaxyAlpha = 0
		local function applyAlpha(g, alpha)
			for _, d in g:GetDescendants() do
				if d:IsA("BasePart") then d.LocalTransparencyModifier = 1 - alpha
				elseif d:IsA("ParticleEmitter") then d.Enabled = alpha > 0.4 end
			end
		end
		for _, g in galaxies do
			g.Model:PivotTo(faceStage(g.Pos))
			applyAlpha(g.Model, 0)
			g.Model.Parent = scene
		end
		local galaxiesLive = true
		Kit.fork(function() -- les galaxies tournent, chacune dans son sens
			local last = Kit.time
			while galaxiesLive and Kit.running do
				local dt = Kit.time - last
				last = Kit.time
				for _, g in galaxies do
					g.Spin += dt * g.Rate * g.Dir
					g.Model:PivotTo(faceStage(g.Pos) * CFrame.Angles(0, g.Spin, 0))
				end
				Kit.wait(1 / 60)
			end
		end)
		Kit.tween(2.5, function(e) for _, g in galaxies do applyAlpha(g.Model, e) end end, "inOut")
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-14, 2.5, 6), M.COLLIDE + V(0, 40 - t * 4, 0), 70 - t * 1.5) end, 0.6)
		Kit.fadeSound(calm2, 0, 2.5)
		local epic = loop(MUSIC.Epic, 0)
		Kit.fadeSound(epic, 0.65, 3)
		at(96.2)
		-- plan sur eux, de face, la tête levée
		Kit.cam(function(t) return Kit.look((kino:center(1) + rex:center(1)) / 2 + V(9 - t * 0.6, -0.5, -1.5), (kino:center(2.4) + rex:center(2.4)) / 2, 48) end, 0.5)
		say("rexydev1", "Two galaxies...?!", 1.8)

		-- ================================================ SCÈNE 8 : la collision des deux galaxies (97.5 - 108.5 s)
		at(97.6)
		say("kinoshi112", "Let's make them COLLIDE!", 2)
		kino:watch(nil) rex:watch(nil)
		walk(kino, M.STAGE + V(1.5, 0, -1.6), 1.1)
		walk(rex, M.STAGE + V(1.5, 0, 3.6), 1.1)
		at(98.9)
		for _, a in {kino, rex} do a:face(M.COLLIDE, 0.25) a:watch(M.COLLIDE, 1) end
		-- bras levés vers le ciel, synchronisés : ils canalisent l'énergie cosmique
		kino:to(P.CHANNEL, 0.5, "outBack")
		rex:to(P.CHANNEL, 0.5, "outBack")
		local auras = {}
		for i, a in {kino, rex} do
			table.insert(auras, Fx.aura("Water-Aura-01", a, {color = i == 1 and PINK or CYAN}))
			table.insert(auras, Fx.attach("Charge-01", a.hrp, {color = i == 1 and PURPLE or CYAN, scale = 1.4}))
			Fx.burst("Wind-02", a:center(-1), {scale = 1.5})
		end
		Kit.snd(S.CosmicBoom, 0.35, 1.8)
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-12 - t * 0.5, 1.2, 8 + t * 0.3), M.STAGE + V(4, 6, 1), 56) end, 0.4)
		at(100.4)
		-- kinoshi112 dirige la première galaxie, rexydev1 la deuxième
		kino:to(P.CHANNEL_SWEEP, 0.25, "outQuart")
		Kit.snd(S.Whoosh, 0.7, 0.6)
		Fx.burst("Wind-02", kino:center(2), {scale = 1.6, color = PINK})
		local function energyLine(fromPos, toPos, color)
			local pa, pb = Instance.new("Attachment"), Instance.new("Attachment")
			pa.WorldPosition, pb.WorldPosition = fromPos, toPos
			pa.Parent, pb.Parent = workspace.Terrain, workspace.Terrain
			local b = Instance.new("Beam")
			b.Attachment0, b.Attachment1 = pa, pb
			b.Texture, b.TextureMode, b.TextureSpeed = "rbxassetid://1084975295", Enum.TextureMode.Stretch, 3
			b.FaceCamera, b.LightEmission, b.LightInfluence, b.Brightness = true, 1, 0, 3
			b.Color = ColorSequence.new(WHITE, color)
			b.Width0, b.Width1 = 1.2, 14
			b.CurveSize0, b.CurveSize1 = random(-40, 40), random(-40, 40)
			b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0.6)})
			b.Parent = pa
			Kit.tween(0.9, function(e) b.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2 + 0.8 * e), NumberSequenceKeypoint.new(1, 0.6 + 0.4 * e)}) end, "inQuad", function() pa:Destroy() pb:Destroy() end)
		end
		energyLine(kino:center(4), galaxies[1].Pos, PINK)
		local moving = Kit.time
		Kit.tween(7.6, function(e, u)
			-- les galaxies se rapprochent de plus en plus vite et tournent de plus en plus vite
			galaxies[1].Pos = galaxies[1].From:Lerp(M.COLLIDE + V(0, 0, -30), e)
			galaxies[1].Rate = 0.25 + 2.6 * u * u
		end, "inCubic")
		at(101.2)
		rex:to(mirror(P.CHANNEL_SWEEP), 0.25, "outQuart")
		Kit.snd(S.Whoosh, 0.7, 0.55)
		Fx.burst("Wind-02", rex:center(2), {scale = 1.6, color = CYAN})
		energyLine(rex:center(4), galaxies[2].Pos, CYAN)
		Kit.tween(6.8, function(e, u)
			galaxies[2].Pos = galaxies[2].From:Lerp(M.COLLIDE + V(0, 0, 30), e)
			galaxies[2].Rate = 0.25 + 2.6 * u * u
		end, "inCubic")
		-- plan large du ciel : les deux galaxies avancent l'une vers l'autre
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-30, 8 + t * 2, 0), M.COLLIDE + V(0, 10, 0), 72) end, 0.6)
		-- traînées d'énergie, particules stellaires et éclairs cosmiques autour d'elles
		local storm = true
		Kit.fork(function()
			while storm and Kit.running do
				local g = galaxies[random(1, 2)]
				local other = g == galaxies[1] and galaxies[2] or galaxies[1]
				Fx.burst("Stars-01", g.Pos + V(random(-60, 60), random(-30, 30), random(-60, 60)), {scale = 8, color = g == galaxies[1] and PINK or CYAN})
				if random() < 0.5 then Fx.burst("Lighting-01-Big", g.Pos:Lerp(other.Pos, random()) + V(0, random(-40, 40), 0), {scale = 9, color = random() < 0.5 and PURPLE or CYAN, time = 0.1}) end
				if random() < 0.35 then energyLine(g.Pos, other.Pos, random() < 0.5 and PINK or CYAN) end
				Kit.wait(0.18)
			end
		end)
		at(103.4)
		Kit.cam(function(t) return Kit.look((kino:center(1) + rex:center(1)) / 2 + V(-7, -0.4, 0.5), M.COLLIDE + V(0, 20, 0), 64) end, 0.5)
		kino:to(P.CHANNEL_PUSH, 0.4, "inOut")
		rex:to(P.CHANNEL_PUSH, 0.4, "inOut")
		Kit.shake(0.3)
		at(105.0)
		Kit.cam(function(t) return Kit.look(M.COLLIDE + V(-380 + t * 10, -60, 0), M.COLLIDE, 60 - t * 2) end, 0.6)
		at(106.5)
		-- ils lèvent les bras une dernière fois : accélération finale
		kino:to(P.CHANNEL, 0.18, "outBack")
		rex:to(P.CHANNEL, 0.18, "outBack")
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-9, 0.8, 1), M.STAGE + V(3, 7, 1), 60 + t * 6) end, 0.15)
		say("kinoshi112 & rexydev1", "NOW!!!", 1.2)
		Kit.snd(S.CosmicBoom, 0.5, 1.4)
		Kit.shake(0.6)
		at(107.3)
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-40, 30, 10), M.COLLIDE, 66 - t * 10) end, 0.25)

		-- ================================================ SCÈNE 9 : la collision déclenche le Galaxy Event (108 s - fin)
		at(M.COLLIDE_AT)
		if o.onCollide then task.spawn(o.onCollide) end -- le serveur lance le VRAI Galaxy Event maintenant
		storm = false
		galaxiesLive = false
		Kit.flash(1.6, WHITE, 1)
		Kit.shake(2.4)
		Kit.punch(-14)
		Kit.snd(S.CosmicBoom, 1, 0.8)
		Kit.snd(S.Boom, 0.8, 0.6)
		Kit.fadeSound(epic, 0, 3.5)
		local blast = Instance.new("Part")
		blast.Shape = Enum.PartType.Ball
		blast.Material, blast.Color = Enum.Material.Neon, rgb(255, 230, 255)
		blast.Anchored, blast.CanCollide, blast.CanQuery, blast.CanTouch, blast.CastShadow = true, false, false, false, false
		blast.Size = V(20, 20, 20)
		blast.CFrame = CFrame.new(M.COLLIDE)
		blast.Parent = scene
		Kit.tween(3, function(e) blast.Size = V(1, 1, 1) * (20 + 900 * e) blast.Transparency = 0.1 + 0.9 * e blast.Color = rgb(255, 230, 255):Lerp(PURPLE, e) end, "outQuad")
		for i = 1, 3 do
			Kit.delay((i - 1) * 0.25, function()
				Fx.mesh("Shockwave", CFrame.lookAt(M.COLLIDE, M.STAGE) * CFrame.Angles(rad(90), 0, 0), {color = ({PINK, CYAN, PURPLE})[i], size0 = 1, size1 = 160, time = 2.4, transp0 = 0.2, ease = "outQuad"})
			end)
		end
		Fx.burst("Stars-01", M.COLLIDE, {scale = 40, mult = 4})
		Fx.burst("Explosion-01", M.COLLIDE, {scale = 30, time = 0.5, color = PINK})
		Fx.light(M.COLLIDE, PURPLE, 600, 6, 3)
		for _, g in galaxies do
			local model = g.Model
			Kit.tween(0.6, function(e) applyAlpha(model, 1 - e) end, "outQuad", function() model:Destroy() end)
		end
		for _, h in auras do if h and h.stop then h.stop() end end
		at(M.COLLIDE_AT + 0.7)
		-- une onde d'énergie traverse la carte
		Fx.mesh("Shockwave", CFrame.new(M.STAGE + V(0, 0.6, 0)), {color = PURPLE, size0 = 0.4, size1 = 160, time = 3.2, transp0 = 0.15, ease = "outQuad"})
		Fx.mesh("Shockwave", CFrame.new(M.STAGE + V(0, 0.8, 0)), {color = CYAN, size0 = 0.4, size1 = 110, time = 2.6, transp0 = 0.3, ease = "outQuad"})
		-- particules cosmiques qui tombent autour des joueurs, lumières violettes / bleues / roses
		local rain = Instance.new("Part")
		rain.Anchored, rain.CanCollide, rain.CanQuery, rain.CanTouch, rain.Transparency = true, false, false, false, 1
		rain.Size = V(260, 1, 260)
		rain.CFrame = CFrame.new(M.STAGE + V(60, 70, 0))
		rain.Parent = scene
		local stars = Instance.new("ParticleEmitter")
		stars.Texture, stars.LightEmission, stars.LightInfluence = "rbxassetid://1084970835", 1, 0
		stars.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, PINK), ColorSequenceKeypoint.new(0.5, PURPLE), ColorSequenceKeypoint.new(1, CYAN)})
		stars.Shape, stars.EmissionDirection = Enum.ParticleEmitterShape.Box, Enum.NormalId.Bottom
		stars.Rate, stars.Lifetime, stars.Speed = 140, NumberRange.new(5, 7), NumberRange.new(8, 16)
		stars.RotSpeed, stars.Rotation = NumberRange.new(-90, 90), NumberRange.new(0, 360)
		stars.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0.4)})
		stars.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0.1), NumberSequenceKeypoint.new(1, 1)})
		stars.Parent = rain
		for i, c in {PURPLE, CYAN, PINK} do
			local holder = rain:Clone()
			holder:ClearAllChildren()
			holder.Size = V(1, 1, 1)
			holder.CFrame = CFrame.new(M.STAGE + V(-30 + i * 20, 14, (i - 2) * 22))
			holder.Parent = scene
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = c, 60, 0, false
			l.Parent = holder
			TweenService:Create(l, TweenInfo.new(2), {Brightness = 1.6}):Play()
		end
		TweenService:Create(grade, TweenInfo.new(2.5), {TintColor = rgb(245, 235, 255), Saturation = 0.15, Contrast = 0.08, Brightness = 0.02}):Play()
		-- ils observent le résultat, au premier plan
		Kit.cam(function(t) return Kit.look((kino:center(1) + rex:center(1)) / 2 + V(-8 + t * 0.6, -0.6, 4), M.COLLIDE + V(0, -40, 0), 62) end, 0.6)
		for _, a in {kino, rex} do a:to(P.LOOK_UP, 0.8, "inOut") end
		at(112.2)
		-- plan large de la carte transformée (ciel cosmique, galaxie de l'event)
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-160 + t * 12, 150 + t * 4, 140 - t * 6), V(700, 20, -170), 65) end, 0.8)
		at(116.6)
		-- plan héroïque sur kinoshi112 et rexydev1
		for _, a in {kino, rex} do a:watch(nil) a:face(M.STAGE + V(-40, 0, 0), 0.4) a:to(P.HERO, 0.5, "inOut") end
		Kit.cam(function(t) return Kit.look(M.STAGE + V(-10 + t * 0.4, 0.6, 1 + t * 0.2), M.STAGE + V(1, 3.4, 1), 50 - t) end, 0.5)
		at(117.4)
		-- texte cinématique
		local filmGui = player.PlayerGui:FindFirstChild("FightFilmGui")
		if filmGui then
			local title = Instance.new("TextLabel")
			title.Name = "GalaxyTitle"
			title.BackgroundTransparency = 1
			title.AnchorPoint = Vector2.new(0.5, 0.5)
			title.Position, title.Size = UDim2.fromScale(0.5, 0.42), UDim2.fromScale(0.86, 0.13)
			title.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
			title.TextScaled, title.TextColor3, title.ZIndex = true, WHITE, 7
			title.Text = "🌌 GALAXY EVENT ACTIVATED 🌌"
			title:SetAttribute("No3D", true)
			local gradient = Instance.new("UIGradient")
			gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, PINK), ColorSequenceKeypoint.new(0.5, WHITE), ColorSequenceKeypoint.new(1, CYAN)})
			gradient.Parent = title
			local stroke = Instance.new("UIStroke")
			stroke.Thickness, stroke.Color = 4, rgb(40, 10, 80)
			stroke.Parent = title
			local scale = Instance.new("UIScale")
			scale.Scale = 0.4
			scale.Parent = title
			title.TextTransparency = 1
			title.Parent = filmGui
			TweenService:Create(scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
			TweenService:Create(title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
			Kit.tween(5, function(e) gradient.Offset = Vector2.new(sin(e * 6) * 0.3, 0) end, "linear")
			Kit.delay(3.6, function()
				TweenService:Create(title, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
				TweenService:Create(stroke, TweenInfo.new(0.8), {Transparency = 1}):Play()
			end)
		end
		Kit.snd(S.Boom, 0.9, 0.8)
		Kit.snd(S.CosmicBoom, 0.6, 1.1)
		Kit.flash(0.5, PINK, 0.5)
		Kit.shake(0.8)
		at(121.2)
		-- la caméra revient doucement vers le joueur
		stars.Enabled = false
		Kit.bars(false, 1.2)
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local target = hrp.Position
			Kit.cam(function() return Kit.look(target - hrp.CFrame.LookVector * 12 + V(0, 5, 0), target + V(0, 1.5, 0), 70) end, 1.6)
		end
		at(M.LENGTH)
		for _, d in debris do d:Destroy() end
	end)

	---------------------------------------------------------------- remise en état (toujours, même si le film a été interrompu)
	if not ok and err ~= "FILM_ABORT" then warn("[AlienFilm] " .. tostring(err)) end
	for _, s in loops do if s then s:Destroy() end end
	Kit.finish()
	scene:Destroy()
	grade:Destroy()
	for d, value in hiddenChars do
		pcall(function()
			if d:IsA("BillboardGui") then d.Enabled = value else d.LocalTransparencyModifier = value end
		end)
	end
	-- la musique de fond reprend, sauf si le Galaxy Event (lancé par le film) joue déjà la sienne
	local galaxyEnd = ReplicatedStorage:GetAttribute("GalaxyEventEnd")
	local eventMusic = type(galaxyEnd) == "number" and galaxyEnd > workspace:GetServerTimeNow()
	if gameMusic and musicWasPlaying and not eventMusic then gameMusic:Resume() end
	return ok, err
end

function M.stop() Kit.running = false end

return M
