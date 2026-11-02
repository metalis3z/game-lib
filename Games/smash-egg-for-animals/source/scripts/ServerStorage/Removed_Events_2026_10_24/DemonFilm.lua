-- Cinématique "Demon City" (panneau admin > Cutscene-Event) : dans une ville détruite sous un ciel rouge sang, kinoshi112 et
-- rexydev1 affrontent un démon géant ; combo duo qui l'envoie dans un hôtel, attaque ultime synchronisée, puis la vraie forme
-- du démon se lève au bout de l'avenue : PHASE 2 — THE TRUE DEMON. Ensuite le combat devient jouable (DemonBossController).
-- Tout est joué côté client par FightFilm.Kit (acteurs articulés animés par code, caméra, ralentis, bandes, flash) et
-- FightFilm.Fx (effets ALL VFX). Aucune animation publiée : chaque mouvement est une suite de poses interpolées (préparation,
-- impact, récupération). Les héros sont les vrais avatars R15 (FightFilm.DemonRigs, sinon AlienRigs, sinon un R6 en blocs).
-- Le décor est la vraie ville (Workspace.DestroyedCity) : le film n'y change que des choses locales, remises à la fin.
-- Repères de temps absolus (Kit.at(secondes)). o.toArena = le combat suit (écran noir gardé jusqu'à l'arène).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local film = script.Parent
local Kit = require(film:WaitForChild("Kit"))
local Fx = require(film:WaitForChild("Fx"))
require(film:WaitForChild("Cast")) -- (allures des héros : heroWalk, heroRun)
local DemonCast = require(film:WaitForChild("DemonCast"))
local shared = ReplicatedStorage:WaitForChild("DemonCity")
local Config = require(shared:WaitForChild("CinematicConfig"))
local Mood = require(shared:WaitForChild("Mood"))
local CutsceneLock = require(ReplicatedStorage:WaitForChild("CutsceneLock"))

local M = {}
local V, rgb = Vector3.new, Color3.fromRGB
local rad, sin, cos, random, clamp = math.rad, math.sin, math.cos, math.random, math.clamp
local CENTER = Config.CENTER
local function P(x, y, z) return CENTER + V(x, y, z) end
M.LENGTH = Config.Film.Length
local S, MUSIC, LINES = Config.Sounds, Config.Music, Config.Lines
local ORANGE, GOLD, CYAN, RED, BLOOD, WHITE = rgb(255, 140, 40), rgb(255, 210, 90), rgb(90, 220, 255), rgb(255, 40, 30), rgb(170, 10, 10), rgb(255, 255, 255)

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
local function flatUnit(v)
	v = v * V(1, 0, 1)
	return v.Magnitude > 0.01 and v.Unit or V(0, 0, -1)
end

---------------------------------------------------------------- poses des héros (avatars R15) : angles en degrés (conventions FightFilm.Kit)
-- épaules / hanches x > 0 = vers l'avant ; épaule droite z > 0 = bras écarté (gauche z < 0) ; coudes x > 0 = pliés ;
-- genoux x < 0 = pliés ; Waist x < 0 = penché en avant, y > 0 = tourne vers la gauche ; Neck x > 0 = lève la tête
local H = {}
H.READY = {RightShoulder = {18, 0, 12}, RightElbow = {28}, LeftShoulder = {18, 0, -12}, LeftElbow = {28}, Waist = {-3}, Neck = {6},
	RightHip = {4, 0, 7}, LeftHip = {-2, 0, -7}, RightKnee = {-8}, LeftKnee = {-6}}
-- garde de boxeur : poings à hauteur du menton, menton rentré, genoux fléchis, poids légèrement vers l'avant, profil de trois quarts
H.GUARD = {RightShoulder = {72, 0, -14}, RightElbow = {126}, LeftShoulder = {80, 0, 16}, LeftElbow = {130}, Waist = {-9, -20, 0}, Root = {0, 20, 0}, Neck = {-4, 12, 0},
	LeftHip = {26, 0, -9}, LeftKnee = {-36}, RightHip = {-12, 0, 9}, RightKnee = {-28}}
H.GUARD2 = mirror(H.GUARD) -- (rexydev1 : garde inversée)
-- direct : la hanche et l'épaule tournent dans le coup, le talon arrière pivote, l'autre poing reste collé au menton
H.JAB_R = merge(H.GUARD, {RightShoulder = {94, 0, -6}, RightElbow = {4}, LeftShoulder = {74, 0, 20}, LeftElbow = {134}, Waist = {-12, 28, 0}, Root = {0, -16, 0}, Neck = {-6, -18, 0},
	RightHip = {-18, 0, 9}, RightKnee = {-14}, LeftKnee = {-40}})
H.JAB_L = merge(H.GUARD, {LeftShoulder = {94, 0, 6}, LeftElbow = {4}, RightShoulder = {70, 0, -18}, RightElbow = {132}, Waist = {-12, -34, 0}, Root = {0, 28, 0}, Neck = {-6, 10, 0},
	LeftKnee = {-42}})
-- uppercut : il plonge sur ses jambes puis remonte de tout le corps
H.UPPER_R = merge(H.GUARD, {RightShoulder = {150, 0, -10}, RightElbow = {58}, LeftShoulder = {70, 0, 22}, LeftElbow = {130}, Waist = {12, 28, 0}, Root = {0, -16, 0}, Neck = {10, -10, 0},
	RightHip = {-6, 0, 8}, RightKnee = {-4}, LeftKnee = {-14}})
-- coup de pied : genou monté, buste qui part en arrière pour faire contrepoids, bras qui équilibrent
H.KICK_WIND = merge(H.GUARD, {RightHip = {80, 0, 8}, RightKnee = {-114}, LeftKnee = {-34}, Waist = {4}, Neck = {-4}, LeftShoulder = {60, 0, 30}})
H.KICK = merge(H.GUARD, {RightHip = {102, 0, 8}, RightKnee = {-4}, LeftHip = {-6}, LeftKnee = {-26}, Waist = {22}, Neck = {-12},
	RightShoulder = {20, 0, 42}, RightElbow = {60}, LeftShoulder = {70, 0, 12}, LeftElbow = {110}})
H.LOWKICK_WIND = merge(H.GUARD, {RightHip = {20, 0, 40}, RightKnee = {-70}, Root = {0, 40, 0}})
H.LOWKICK = merge(H.GUARD, {RightHip = {45, 0, 40}, RightKnee = {-4}, Root = {0, 60, 0}, Waist = {-4, 10, 0}, LeftKnee = {-30}})
H.DODGE = merge(H.GUARD, {Waist = {14, 0, 26}, Root = {0, 0, 10}, Neck = {-8, 0, -18}, LeftHip = {10, 0, -20}, RightHip = {-6, 0, 18}})
H.DUCK = {RightHip = {95, 0, 8}, RightKnee = {-125}, LeftHip = {100, 0, -8}, LeftKnee = {-130}, Waist = {-28}, Neck = {24},
	RightShoulder = {80, 0, -10}, RightElbow = {110}, LeftShoulder = {85, 0, 10}, LeftElbow = {115}}
H.SLIDE = {Waist = {20}, Neck = {-6}, RightHip = {88, 0, 6}, RightKnee = {-6}, LeftHip = {30, 0, -6}, LeftKnee = {-110},
	RightShoulder = {-30, 0, 50}, RightElbow = {20}, LeftShoulder = {30, 0, -40}, LeftElbow = {40}}
H.TUCK = {RightHip = {85, 0, 6}, RightKnee = {-115}, LeftHip = {70, 0, -6}, LeftKnee = {-105}, Waist = {10}, Neck = {-4},
	RightShoulder = {50, 0, 30}, RightElbow = {80}, LeftShoulder = {50, 0, -30}, LeftElbow = {80}}
H.AIR_GUARD = merge(H.GUARD, {RightHip = {60, 0, 8}, RightKnee = {-90}, LeftHip = {40, 0, -8}, LeftKnee = {-80}})
H.AIR_WIND_R = merge(H.AIR_GUARD, {RightShoulder = {50, 0, -6}, RightElbow = {130}, Waist = {-6, -30, 0}})
H.AIR_JAB_R = merge(H.AIR_GUARD, {RightShoulder = {92, 0, -4}, RightElbow = {6}, Waist = {-10, 22, 0}, Root = {0, -12, 0}})
H.AIR_JAB_L = merge(H.AIR_GUARD, {LeftShoulder = {92, 0, 4}, LeftElbow = {6}, Waist = {-10, -30, 0}, Root = {0, 25, 0}})
H.ROUND_WIND_AIR = merge(H.AIR_GUARD, {RightHip = {40, 0, 45}, RightKnee = {-90}, Root = {0, 50, 0}, Waist = {10, 20, 0}})
H.ROUND_AIR = merge(H.AIR_GUARD, {RightHip = {80, 0, 75}, RightKnee = {-8}, Root = {0, 95, 0}, Waist = {16, 30, 0}, LeftKnee = {-60}})
H.AXE_WIND = {RightShoulder = {172, 0, -12}, RightElbow = {40}, LeftShoulder = {170, 0, 12}, LeftElbow = {40}, Waist = {18}, Neck = {6},
	RightHip = {60, 0, 8}, RightKnee = {-100}, LeftHip = {50, 0, -8}, LeftKnee = {-90}}
H.AXE = {RightShoulder = {50, 0, -8}, RightElbow = {10}, LeftShoulder = {46, 0, 8}, LeftElbow = {12}, Waist = {-30}, Neck = {18},
	RightHip = {70, 0, 8}, RightKnee = {-80}, LeftHip = {60, 0, -8}, LeftKnee = {-70}}
H.LAND = {RightHip = {80, 0, 10}, RightKnee = {-105}, LeftHip = {35, 0, -10}, LeftKnee = {-110}, Waist = {-18}, Neck = {14},
	LeftShoulder = {30, 0, -40}, LeftElbow = {30}, RightShoulder = {20, 0, 50}, RightElbow = {20}}
-- il se protège du souffle : avant-bras croisés devant le visage, tête rentrée, jambes écartées et ancrées
H.BRACE = {RightShoulder = {96, 0, -30}, RightElbow = {122}, LeftShoulder = {102, 0, 30}, LeftElbow = {126}, Waist = {-24}, Neck = {-12},
	RightHip = {38, 0, 14}, RightKnee = {-50}, LeftHip = {-24, 0, -14}, LeftKnee = {-26}}
H.HURT = {Waist = {18, 0, 8}, Neck = {-20, 0, 10}, RightShoulder = {-20, 0, 40}, RightElbow = {30}, LeftShoulder = {-25, 0, -40}, LeftElbow = {35},
	RightHip = {-10, 0, 6}, RightKnee = {-20}, LeftHip = {25, 0, -6}, LeftKnee = {-30}}
-- un genou à terre après le choc, une main au sol pour se rattraper, le regard qui remonte
H.KNEEL = {RightHip = {90, 0, 5}, RightKnee = {-90}, LeftHip = {-4, 0, -5}, LeftKnee = {-96}, Waist = {-14}, Neck = {16},
	RightShoulder = {40, 0, 14}, RightElbow = {50}, LeftShoulder = {46, 0, -12}, LeftElbow = {8}}
H.RISE = {RightHip = {45, 0, 5}, RightKnee = {-55}, LeftHip = {20, 0, -5}, LeftKnee = {-45}, Waist = {-28}, Neck = {14},
	RightShoulder = {-10, 0, 20}, RightElbow = {30}, LeftShoulder = {-10, 0, -20}, LeftElbow = {30}}
H.BLOCK_HIGH = {RightShoulder = {158, 0, -24}, RightElbow = {72}, LeftShoulder = {158, 0, 24}, LeftElbow = {72}, Waist = {4}, Neck = {-8},
	RightHip = {34, 0, 16}, RightKnee = {-62}, LeftHip = {34, 0, -16}, LeftKnee = {-62}}
H.PUSH_UP = {RightShoulder = {176, 0, -6}, RightElbow = {4}, LeftShoulder = {176, 0, 6}, LeftElbow = {4}, Waist = {10}, Neck = {22},
	RightHip = {4, 0, 12}, LeftHip = {4, 0, -12}, RightKnee = {-8}, LeftKnee = {-8}}
H.TAUNT = merge(H.GUARD2, {RightShoulder = {60, 0, 30}, RightElbow = {70}, RightWrist = {0, 0, -40}, Neck = {8, -10, 0}, Waist = {2, 0, 0}})
H.CHARGE_LOW = {RightShoulder = {-40, 0, 30}, RightElbow = {100}, LeftShoulder = {70, 0, -20}, LeftElbow = {30}, Waist = {-24, -25, 0}, Root = {0, -10, 0}, Neck = {20, 30, 0},
	RightHip = {-20, 0, 10}, RightKnee = {-60}, LeftHip = {70, 0, -10}, LeftKnee = {-90}}
H.MEGA_PUNCH = {RightShoulder = {92, 0, -2}, RightElbow = {2}, LeftShoulder = {-36, 0, -26}, LeftElbow = {72}, Waist = {-18, 32, 0}, Root = {0, 10, 0}, Neck = {6, -30, 0},
	LeftHip = {50, 0, -8}, LeftKnee = {-60}, RightHip = {-30, 0, 8}, RightKnee = {-10}}
H.SPINKICK_WIND = merge(H.GUARD2, {LeftHip = {30, 0, -40}, LeftKnee = {-90}, Root = {0, -40, 0}, Waist = {10, -20, 0}})
-- coup de pied retourné : le buste bascule à l'opposé de la jambe pour l'équilibre, les bras s'ouvrent, l'œil suit la cible
H.SPINKICK = merge(H.GUARD2, {LeftHip = {110, 0, -60}, LeftKnee = {-6}, Root = {0, -90, 0}, Waist = {18, -30, 24}, RightKnee = {-34},
	RightShoulder = {40, 0, 62}, RightElbow = {40}, LeftShoulder = {70, 0, -10}, LeftElbow = {110}, Neck = {-6, 40, -10}})
-- épuisé : mains sur les genoux, dos courbé, la tête se relève pour regarder devant
H.TIRED = {Waist = {-38}, Neck = {26}, RightShoulder = {40, 0, 14}, RightElbow = {10}, LeftShoulder = {40, 0, -14}, LeftElbow = {10},
	RightHip = {34, 0, 8}, RightKnee = {-42}, LeftHip = {32, 0, -8}, LeftKnee = {-40}}
H.FISTBUMP = {RightShoulder = {86, 0, -12}, RightElbow = {18}, LeftShoulder = {10, 0, -8}, LeftElbow = {20}, Waist = {-4, -10, 0}, Neck = {4, -8, 0},
	RightHip = {-2, 0, 8}, LeftHip = {4, 0, -8}}
H.CHARGE_FIST = {RightShoulder = {-48, 0, 22}, RightElbow = {112}, LeftShoulder = {82, 0, -6}, LeftElbow = {12}, Waist = {-10, -34, 0}, Root = {0, -14, 0}, Neck = {8, 40, 0},
	LeftHip = {46, 0, -14}, LeftKnee = {-74}, RightHip = {-22, 0, 14}, RightKnee = {-38}}
H.FIST_THRUST = merge(H.MEGA_PUNCH, {LeftHip = {46, 0, -14}, LeftKnee = {-60}, RightHip = {-34, 0, 14}, RightKnee = {-12}})
H.CUP_CHARGE = {RightShoulder = {-24, 0, 16}, RightElbow = {96}, LeftShoulder = {34, 0, 46}, LeftElbow = {112}, Waist = {-6, -38, 0}, Root = {0, -10, 0}, Neck = {8, 44, 0},
	LeftHip = {40, 0, -14}, LeftKnee = {-60}, RightHip = {-20, 0, 14}, RightKnee = {-40}}
H.CUP_DEEP = merge(H.CUP_CHARGE, {RightShoulder = {-34, 0, 18}, Waist = {-10, -48, 0}, Neck = {8, 52, 0}, LeftKnee = {-70}, RightKnee = {-46}})
H.CUP_PUSH = {RightShoulder = {86, 0, -16}, RightElbow = {8}, LeftShoulder = {86, 0, 16}, LeftElbow = {8}, Waist = {-10, 0, 0}, Neck = {6},
	LeftHip = {42, 0, -12}, LeftKnee = {-56}, RightHip = {-28, 0, 12}, RightKnee = {-16}}
H.VICTORY = {RightShoulder = {172, 0, 12}, RightElbow = {8}, LeftShoulder = {8, 0, -14}, LeftElbow = {24}, Waist = {6}, Neck = {22},
	RightHip = {-4, 0, 10}, LeftHip = {-4, 0, -10}}
H.CROSS = {RightShoulder = {62, 0, -38}, RightElbow = {112}, LeftShoulder = {58, 0, 38}, LeftElbow = {112}, Waist = {2}, Neck = {4, 14, 0},
	RightHip = {-2, 0, 9}, LeftHip = {-2, 0, -9}}
H.SURPRISE = {RightShoulder = {70, 0, 55}, RightElbow = {35}, LeftShoulder = {70, 0, -55}, LeftElbow = {35}, Waist = {12}, Neck = {22},
	RightHip = {12, 0, 6}, RightKnee = {-18}, LeftHip = {-6, 0, -6}, LeftKnee = {-10}}
H.POINT = {RightShoulder = {120, 0, 20}, RightElbow = {4}, LeftShoulder = {6, 0, -6}, LeftElbow = {12}, Waist = {0, 14, 0}, Neck = {6, 20, 0}}
---------------------------------------------------------------- mains et poignets (les avatars n'ont pas de doigts : tout passe par le poignet)
-- Wrist : x = la main se casse vers l'avant / l'arrière, y = l'avant-bras vrille (paume vers le haut ou le bas), z = la main s'incline
local GW_R, GW_L = {8, -28, 6}, {8, 28, -6}       -- en garde : poings serrés, pouces vers le haut, légèrement cassés
local PRON_R, PRON_L = {-4, -78, 0}, {-4, 78, 0}  -- direct : le poing vrille en frappant, paume vers le sol à l'impact
for _, name in {"GUARD", "JAB_R", "JAB_L", "UPPER_R", "KICK_WIND", "KICK", "LOWKICK_WIND", "LOWKICK", "DODGE", "AIR_GUARD", "AIR_WIND_R", "AIR_JAB_R",
	"AIR_JAB_L", "ROUND_WIND_AIR", "ROUND_AIR", "DUCK", "TUCK", "GUARD2", "SPINKICK_WIND", "SPINKICK", "TAUNT"} do
	H[name].RightWrist = H[name].RightWrist or GW_R
	H[name].LeftWrist = H[name].LeftWrist or GW_L
end
local function hands(name, r, l)
	if r then H[name].RightWrist = r end
	if l then H[name].LeftWrist = l end
end
hands("JAB_R", PRON_R) hands("AIR_JAB_R", PRON_R)
hands("JAB_L", nil, PRON_L) hands("AIR_JAB_L", nil, PRON_L)
hands("UPPER_R", {12, 62, 0})                         -- uppercut : paume tournée vers soi
hands("AIR_WIND_R", {14, -10, 0})
hands("MEGA_PUNCH", PRON_R, {20, 30, 0})
hands("FIST_THRUST", PRON_R, {20, 30, 0})
hands("CHARGE_FIST", {16, -10, 4}, {-48, 0, 0})        -- poing armé serré, l'autre main ouverte vise la cible
hands("CHARGE_LOW", {16, -10, 4}, {-30, 20, 0})
hands("CUP_CHARGE", {-62, 0, 10}, {-62, 0, -10})        -- mains en coupe autour de la boule d'énergie
hands("CUP_DEEP", {-70, 0, 12}, {-70, 0, -12})
hands("CUP_PUSH", {-78, 0, 0}, {-78, 0, 0})             -- paumes vers l'avant, poignets cassés en arrière
hands("PUSH_UP", {-72, 0, 0}, {-72, 0, 0})
hands("BLOCK_HIGH", {6, -40, 0}, {6, 40, 0})
hands("BRACE", {4, -30, 0}, {4, 30, 0})
hands("TIRED", {-46, 0, 0}, {-46, 0, 0})                -- paumes à plat sur les genoux
hands("KNEEL", {20, 0, 0}, {-64, 0, 0})                 -- paume à plat au sol
hands("LAND", {-30, 0, 0}, {-56, 0, 0})
hands("HURT", {34, 0, 10}, {30, 0, -10})                -- mains lâches sous le choc
hands("SURPRISE", {-40, 0, 0}, {-40, 0, 0})
hands("AXE_WIND", {20, 0, 0}, {20, 0, 0})
hands("AXE", {-10, 0, 0}, {-10, 0, 0})
hands("SLIDE", {-40, 0, 0}, {-20, 0, 0})
hands("VICTORY", {6, -24, 0})
hands("FISTBUMP", {0, -60, 0})
hands("POINT", {-6, 0, 0})
M.Poses = H
-- course de combattant : bassin et épaules qui tournent en sens contraire, bras qui pompent coudés à 90°, genoux montés,
-- buste penché, tête stable (elle compense la rotation des épaules)
Kit.Gaits.fighterRun = {stride = 8.6, fn = function(p)
	local s, c = sin(p), cos(p)
	local arm = sin(p - 0.25)
	return {
		RightHip = {14 + 56 * s}, LeftHip = {14 - 56 * s},
		RightKnee = {-(24 + 92 * math.max(0, c) ^ 1.2)}, LeftKnee = {-(24 + 92 * math.max(0, -c) ^ 1.2)},
		RightAnkle = {18 * s}, LeftAnkle = {-18 * s},
		RightShoulder = {-60 * arm, 0, 10}, LeftShoulder = {60 * arm, 0, -10},
		RightElbow = {88 + 14 * s}, LeftElbow = {88 - 14 * s},
		Root = {0, 12 * s, 0}, Waist = {-22 + 3 * math.abs(c), -18 * s, 0}, Neck = {18 - 3 * math.abs(c), 6 * s, 0},
	}
end}
-- poses du démon pour ce film : tout le corps travaille (hanches, buste, queue et ailes en contrepoids) ; le reste vient de DemonCast
local B = setmetatable({}, {__index = DemonCast.Poses})
B.SWIPE_WIND = {Root = {-10, -48, 0}, RightShoulder = {-38, 0, 88}, LeftShoulder = {50, 0, -28}, RightHip = {24, 0, 6}, LeftHip = {-18, 0, -8}, Neck = {12, 36, 0},
	Jaw = {-18}, Tail = {0, 36, 0}, Tail2 = {0, 24, 0}, WingR = {0, -30, 20}, WingL = {0, 30, -10}}
B.SWIPE = {Root = {-24, 52, 0}, RightShoulder = {108, 0, -46}, LeftShoulder = {-36, 0, -34}, RightHip = {-18}, LeftHip = {38}, Neck = {16, -34, 0},
	Jaw = {-26}, Tail = {0, -38, 0}, Tail2 = {0, -26, 0}, WingR = {0, -44, -10}, WingL = {0, 44, 24}}
B.SWIPE_L_WIND = DemonCast.mirror(B.SWIPE_WIND)
B.SWIPE_L = DemonCast.mirror(B.SWIPE)
B.BACKHAND_WIND = {Root = {-8, 42, 0}, LeftShoulder = {100, 0, 46}, RightShoulder = {26, 0, 26}, Neck = {10, -30, 0}, RightHip = {-12}, LeftHip = {24},
	Jaw = {-14}, Tail = {0, -26, 0}, Tail2 = {0, -18, 0}}
B.BACKHAND = {Root = {-16, -54, 0}, LeftShoulder = {70, 0, -104}, RightShoulder = {-14, 0, 34}, Neck = {16, 34, 0}, RightHip = {30}, LeftHip = {-18},
	Jaw = {-28}, Tail = {0, 34, 0}, Tail2 = {0, 24, 0}}
B.SLAM_WIND = {RightShoulder = {172, 0, -12}, LeftShoulder = {172, 0, 12}, Root = {22}, Neck = {-10}, RightHip = {12}, LeftHip = {-10}, Jaw = {-32},
	Tail = {34}, Tail2 = {24}, WingR = {0, -6, 46}, WingL = {0, 6, -46}}
B.SLAM = {RightShoulder = {44}, LeftShoulder = {40}, Root = {-48}, Neck = {32}, RightHip = {54}, LeftHip = {-20}, Jaw = {-28}, Tail = {-30}, Tail2 = {-14},
	WingR = {0, -44, -14}, WingL = {0, 44, 14}}
B.HURT = {Root = {18, 14, 10}, Neck = {-24, 20, 14}, RightShoulder = {-18, 0, 48}, LeftShoulder = {-24, 0, -44}, RightHip = {-12}, LeftHip = {22}, Jaw = {-30},
	Tail = {0, 30, 0}, Tail2 = {0, 20, 0}}
B.RECOIL = {Root = {26, 0, 0}, RightShoulder = {-44, 0, 64}, LeftShoulder = {-44, 0, -64}, RightHip = {28}, LeftHip = {-12}, Neck = {-28}, Jaw = {-26}, Tail = {18}, Tail2 = {12}}
B.ROAR = {Root = {20}, Neck = {36}, RightShoulder = {34, 0, 128}, LeftShoulder = {34, 0, -128}, RightHip = {8, 0, 12}, LeftHip = {-8, 0, -12}, Jaw = {-46},
	Tail = {26}, Tail2 = {20}, WingR = {0, 14, 38}, WingL = {0, -14, -38}}

---------------------------------------------------------------- déroulé
function M.play(o)
	o = o or {}
	local player = Players.LocalPlayer
	local scene = Instance.new("Folder")
	scene.Name = "DemonFilmScene"
	scene.Parent = workspace
	local restore = {} -- changements locaux sur la vraie ville (façade, cratère, feux) : remis à la fin, quoi qu'il arrive
	Mood.enter()
	Kit.begin(scene, {})
	Kit.handheld = 0.006 -- caméra à l'épaule : l'image respire un peu (réalisme)
	Kit.fade(0, 0) -- (écran noir pendant le chargement)
	-- la ville (côté serveur) doit être chargée autour de la place avant la première image
	local city
	pcall(function()
		CutsceneLock.focus(P(0, 0, 40), 4)
		city = workspace:FindFirstChild("DestroyedCity")
		local waitStart = os.clock()
		while not city and os.clock() - waitStart < 6 do
			task.wait(0.2)
			city = workspace:FindFirstChild("DestroyedCity")
		end
	end)
	Kit.time = 0 -- (le film commence maintenant)
	if o.ffTo then Kit.ffTo = o.ffTo end
	local loops = {}
	local function loop(id, volume, speed) local s = Kit.snd(id, volume, speed, true) table.insert(loops, s) return s end
	local at = Kit.at

	local ok, err = pcall(function()
		------------------------------------------------ distribution
		local function avatar(name, colors)
			local src = (film:FindFirstChild("DemonRigs") and film.DemonRigs:FindFirstChild(name)) or (film:FindFirstChild("AlienRigs") and film.AlienRigs:FindFirstChild(name))
			local rig
			if src then
				rig = src:Clone()
			else
				-- secours : un personnage R6 en blocs (les poses R15 s'y appliquent : coudes, genoux et taille en moins)
				warn("[DemonFilm] avatar " .. name .. " introuvable : personnage de secours")
				rig = Kit.makeR6({Name = name, Colors = colors})
			end
			rig.Parent = scene
			local a = Kit.actor(rig, name)
			a.neckSmooth = 13
			a.seed = random() * 10
			a.phys = {freq = 1.6, damp = 0.58, weight = 0.7} -- corps physique : élan, dépassement, recul aux coups, rebond des pas
			return a
		end
		local kino = avatar("Kino", {Torso = rgb(30, 30, 36), Head = rgb(234, 184, 146), Arms = rgb(234, 184, 146), Legs = rgb(40, 40, 60)})
		local rex = avatar("Rex", {Torso = rgb(40, 90, 200), Head = rgb(234, 184, 146), Arms = rgb(234, 184, 146), Legs = rgb(30, 30, 40)})
		local bossRig, bossParts = DemonCast.demon({Scale = Config.Film.BossScale})
		bossRig.Parent = scene
		local boss = DemonCast.actor(bossRig, "Demon")
		boss.neckSmooth = 9
		boss.seed = 3
		boss.phys = {freq = 0.9, damp = 0.55, weight = 1.8} -- lourd : il met plus de temps à lancer et à arrêter ses gestes
		local bossHead = bossRig.Head
		local giantRig, giantParts = DemonCast.demon({Scale = Config.Film.GiantScale, True = true, Palette = "Shadow", Aura = false})
		giantRig.Parent = scene
		local giant = DemonCast.actor(giantRig, "TrueDemon")
		giant.idle = 0.5
		giant.phys = {freq = 0.6, damp = 0.6, weight = 3}
		-- contour rouge : la silhouette se découpe sur le ciel même dans la brume (un Highlight n'est pas atténué par l'atmosphère)
		-- le corps suit les gestes : il s'élance dans ses coups, recule pour armer, encaisse en arrière (sans bouger ses pieds)
		local function bodyFollows(a, map)
			local baseTo = a.to
			a.to = function(self, pose, dur, ease, o)
				baseTo(self, pose, dur, ease, o)
				if o and o.only then return end
				local l = map[pose] or 0
				self.restLunge = l
				if map.guards then
					self.bounceTo = map.guards[pose] and 1 or 0
					self.heaveTo = pose == H.TIRED and 1 or 0
				end
				if not dur or dur <= 0 then
					self:body({lunge = l}, 0)
				elseif l > self.lunge + 0.2 then
					self:body({lunge = l}, math.max(dur, 0.06) * 1.3, "outBack")
				else
					self:body({lunge = l}, math.max(dur, 0.1) * 1.4, "inOut")
				end
			end
		end
		bodyFollows(boss, {[B.SWIPE_WIND] = -0.35, [B.SWIPE] = 0.8, [B.SWIPE_L_WIND] = -0.35, [B.SWIPE_L] = 0.8, [B.BACKHAND_WIND] = -0.3, [B.BACKHAND] = 0.6,
			[B.SLAM_WIND] = -0.45, [B.SLAM] = 0.9, [B.RECOIL] = -0.7, [B.HURT] = -0.45, [B.STAGGER] = -0.5, [B.THROW] = 0.7, [B.ROAR] = -0.15, [B.CHANNEL] = -0.1})
		local heroBody = {[H.MEGA_PUNCH] = 0.7, [H.FIST_THRUST] = 0.6, [H.CUP_PUSH] = 0.5, [H.CHARGE_FIST] = -0.35, [H.CHARGE_LOW] = -0.25, [H.CUP_CHARGE] = -0.3,
			[H.CUP_DEEP] = -0.45, [H.BRACE] = -0.3, [H.HURT] = -0.35, [H.BLOCK_HIGH] = -0.15, [H.PUSH_UP] = 0.35, [H.DODGE] = -0.2,
			guards = {[H.GUARD] = true, [H.GUARD2] = true, [H.TAUNT] = true}}
		bodyFollows(kino, heroBody)
		bodyFollows(rex, heroBody)
		local giantGlow = Instance.new("Highlight")
		giantGlow.FillColor, giantGlow.FillTransparency = rgb(10, 0, 2), 1
		giantGlow.OutlineColor, giantGlow.OutlineTransparency = rgb(255, 50, 30), 1
		giantGlow.DepthMode = Enum.HighlightDepthMode.Occluded
		giantGlow.Enabled = false
		giantGlow.Parent = giantRig

		------------------------------------------------ petits outils
		local function say(who, text, t) Kit.say(who .. " : " .. text, t or 2.4) end
		local function dust(pos, s) Fx.burst("Smoke-01", pos + V(0, 0.4, 0), {scale = s or 0.6}) end
		local function chest(a) return a:center(a == boss and 3.4 or 0.9) end
		local function headPos(a) local h = a:part("Head") return h and h.Position or a:center(1.6) end
		local function handOf(a, side) return a:part(side .. "Hand") or a:part(side .. " Arm") end
		local function bossFront(up, out) return boss:center(up or 3.4) + flatUnit(boss:point(1) - boss.pos) * (out or 1.8) end
		local function impact(target, pos, power, color)
			power = power or 1
			Fx.burst("Punch-01", pos, {scale = 1.1 * power, color = color})
			if power >= 1.3 then Fx.burst("Punch-02", pos, {scale = 1.4 * power, color = color}) end
			Fx.light(pos, color or WHITE, 16 * power, 4, 0.25)
			Kit.snd(power >= 1.3 and S.HeavyPunch or S.Punch, 0.75, 0.9 + random() * 0.25)
			target:hit(power)
			-- réaction selon l'endroit touché : un coup à droite fait tourner le corps, un coup au visage fait partir la tête,
			-- un coup dans les jambes fait plier le genou ; puis le corps recule et revient en place
			if target.phys and target.hrp then
				local p = power / (target.phys.weight or 1) ^ 0.5
				local l = (CFrame.new(target.hrp.Position) * CFrame.Angles(0, target.yaw, 0)):PointToObjectSpace(pos)
				local side = clamp(l.X / (1.2 * target.scale), -1, 1)
				local height = (pos.Y - target.pos.Y) / math.max(target.stand, 0.1)
				local upper = target.kind == "R15" and "Waist" or "Root"
				target:kick(upper, {0, -side * 240 * p, -side * 140 * p})
				if height > 1.15 then
					target:kick("Neck", {200 * p, -side * 320 * p, -side * 160 * p})
				elseif height < 0.55 then
					target:kick(side >= 0 and "RightHip" or "LeftHip", {-260 * p, 0, 0})
					target:kick(upper, {-180 * p, 0, 0})
				end
				target:body({lunge = (target.restLunge or 0) - 0.35 * p}, 0.07, "outQuad")
				Kit.delay(0.12, function() target:body({lunge = target.restLunge or 0}, 0.45, "inOut") end)
			end
			Kit.shake(0.22 * power)
			Kit.punch(-3 * power)
			Kit.hitstop(0.035 + 0.03 * power)
		end
		-- repoussé : il glisse en arrière, les pieds raclent le sol
		local function skid(a, from, dist, dur, pose)
			local to = a.pos + flatUnit(a.pos - from) * dist
			if pose then a:to(pose, 0.1, "outQuad") end
			a:move(to, dur or 0.35, "outCubic")
			Kit.fork(function() for _ = 1, 3 do Kit.wait(0.08) dust(a.pos, 0.45 * a.scale) end end)
			return to
		end
		-- un coup : préparation, frappe (le membre arrive au contact), impact, retour en garde
		-- (vrai coup : le poids part sur la jambe arrière pendant l'armement, puis la force remonte du sol au poing — hanches,
		-- buste, épaule, coude, poignet — et le corps entre dans le coup ; même durée totale qu'avant, les repères du film tiennent)
		local function strike(a, wind, hit, target, opt)
			opt = opt or {}
			local cut = opt.cut or 0.08
			if wind then
				a:to(wind, opt.wind or 0.1, "outCubic")
				a:body({lunge = -0.18}, opt.wind or 0.1, "outQuad")
				Kit.wait(opt.wind or 0.1)
			end
			Kit.snd(S.Whoosh, 0.35, 1.2 + random() * 0.3)
			a:to(hit, cut * 0.6, "outQuart", {chain = cut * 0.1})
			a:body({lunge = opt.step or 0.45}, cut * 0.9, "outQuad")
			Kit.wait(cut * 0.85)
			if target then
				impact(target, opt.where and opt.where() or chest(target), opt.power, opt.color)
				if opt.react then target:to(opt.react, 0.08, "outQuad") end
				-- le frappeur sent la résistance : son buste encaisse un petit contrecoup
				a:kick(a.kind == "R15" and "Waist" or "Root", {70 * (opt.power or 1), (random() - 0.5) * 60, 0})
			end
			Kit.wait(cut * 0.15 + (opt.hold or 0.05))
			if opt.back ~= false then
				a:to(opt.guard or H.GUARD, opt.recover or 0.16, "outCubic") -- le bras revient vite en garde (on ne laisse pas le poing traîner)
				a:body({lunge = 0}, (opt.recover or 0.16) * 1.6, "inOut")
			end
		end
		---------------------------------------- gestes des mains
		local function crack() Kit.snd(S.Thud, 0.22, 2.6 + random() * 0.4) end
		-- craquement des jointures (0,8 s) : le poing droit dans la paume gauche, il pousse, ça craque, il vrille le poignet,
		-- puis il penche la tête pour faire craquer sa nuque et retombe en garde
		local function crackKnuckles(a, guard)
			local A = {RightShoulder = {62, 0, -34}, RightElbow = {112}, RightWrist = {10, -20, 0}, LeftShoulder = {64, 0, 34}, LeftElbow = {108}, LeftWrist = {-30, 20, 0},
				Waist = {-6}, Neck = {-6}, RightHip = {4, 0, 7}, LeftHip = {-2, 0, -7}, RightKnee = {-8}, LeftKnee = {-6}}
			local PUSH = merge(A, {RightElbow = {96}, LeftElbow = {92}, RightWrist = {30, -30, 0}, LeftWrist = {-56, 30, 0}, Waist = {-10}, Neck = {-10}})
			local TWIST = merge(PUSH, {RightWrist = {20, 40, 0}, LeftWrist = {-40, -20, 0}, Neck = {-4, 0, 22}})
			a:to(A, 0.14, "outCubic") Kit.wait(0.14)
			a:to(PUSH, 0.08, "outQuart") Kit.wait(0.08)
			crack()
			a:kick("RightElbow", {-220, 0, 0})
			Kit.wait(0.1)
			a:to(TWIST, 0.12, "inOut") Kit.wait(0.12)
			crack()
			a:kick("Neck", {0, 0, 180})
			Kit.wait(0.12)
			a:to(guard, 0.22, "outBack")
		end
		-- il fait rouler ses poignets puis secoue les mains pour se détendre, avant de remonter sa garde
		local function rollWrists(a, dur, guard)
			local base = {RightShoulder = {58, 0, 18}, RightElbow = {96}, LeftShoulder = {58, 0, -18}, LeftElbow = {96}, Waist = {-4}, Neck = {-6},
				RightHip = {4, 0, 7}, LeftHip = {-2, 0, -7}, RightKnee = {-8}, LeftKnee = {-6}}
			a:to(base, 0.15, "outCubic")
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				local u = (Kit.time - t0) * 11
				a:to({RightWrist = {cos(u) * 34, 0, sin(u) * 30}, LeftWrist = {-cos(u) * 34, 0, sin(u) * 30}}, 0.05, "linear", {only = true})
				Kit.wait(0.04)
			end
			for i = 1, 4 do
				local k = i % 2 == 0 and 1 or -1
				a:to({RightWrist = {40 * k, 0, 0}, LeftWrist = {-40 * k, 0, 0}, RightElbow = {92 + 12 * k}, LeftElbow = {92 - 12 * k}}, 0.05, "inOut", {only = true})
				Kit.wait(0.05)
			end
			a:to(guard, 0.2, "outBack")
		end
		-- « viens » : bras tendu paume vers le ciel, deux appels du bout des doigts (0,6 s)
		local function beckon(a)
			local OPEN = merge(H.GUARD2, {RightShoulder = {74, 0, 14}, RightElbow = {34}, RightWrist = {0, 92, 0}, Neck = {6, -8, 0}, Waist = {2, 0, 0}})
			a:to(OPEN, 0.18, "outBack") Kit.wait(0.18)
			for _ = 1, 2 do
				a:to({RightWrist = {58, 92, 0}, RightElbow = {58}}, 0.09, "outQuad", {only = true}) Kit.wait(0.1)
				a:to({RightWrist = {-6, 92, 0}, RightElbow = {34}}, 0.1, "inOut", {only = true}) Kit.wait(0.11)
			end
		end
		-- check qui explose : après le contact, la main s'ouvre et part en arrière en « éclatant » (doigts qui frétillent)
		local function blowUp(a, side)
			local pose = {RightShoulder = {64, 0, 46}, RightElbow = {62}, RightWrist = {-56, 0, 30}, Waist = {8, -10, 0}, Neck = {10, -8, 0},
				LeftShoulder = {10, 0, -8}, LeftElbow = {20}, RightHip = {-2, 0, 8}, LeftHip = {4, 0, -8}}
			if side < 0 then pose = mirror(pose) end
			a:to(pose, 0.16, "outBack")
			Kit.wait(0.16)
			for i = 1, 4 do
				local k = i % 2 == 0 and 1 or -1
				local w = {-56 + k * 12, 0, 30 + k * 16}
				a:to(side > 0 and {RightWrist = w} or {LeftWrist = {w[1], -w[2], -w[3]}}, 0.05, "inOut", {only = true})
				Kit.wait(0.05)
			end
		end
		local function run(a, to, dur)
			a:gait("fighterRun", 0.1, function() dust(a.pos, 0.3 * a.scale) end)
			a:move(to, dur, "inOut", {face = true, faceTime = 0.12})
			Kit.delay(dur, function() a:gait(nil, 0.12) end)
		end
		-- course éclair : silhouette lumineuse laissée derrière lui, traits de vitesse
		local function dash(a, to, dur, color)
			Kit.snd(S.Whoosh, 0.7, 1.3)
			Fx.burst("Wind-02", a:center(0), {scale = 1.2})
			a:move(to, dur, "outQuad", {face = true, faceTime = 0.05})
			Kit.fork(function()
				local t0 = Kit.time
				while Kit.time - t0 < dur do Kit.ghost(a, color, 0.3, 0.5) Kit.wait(0.035) end
			end)
			Kit.speedLines(dur + 0.2, 0.5)
		end
		-- le démon marche : chaque pas fait trembler la caméra et soulève la poussière
		local function stomp(a, to, dur)
			a:gait("demonStomp", 0.15, function()
				Kit.shake(0.25)
				Kit.snd(S.Thud, 0.6, 0.55)
				dust(a.pos, 1.3)
			end)
			a:move(to, dur, "inOut", {face = true, faceTime = 0.3})
			Kit.delay(dur, function() a:gait(nil, 0.2) end)
		end
		local function slowmo(scale, ramp)
			local from = Kit.scale
			Kit.tween(ramp or 0.1, function(e) Kit.scale = from + (scale - from) * e end, "inOut")
		end
		local function orbit(centerFn, radius, height, a0, a1, dur, fov0, fov1)
			return function(t)
				local u = clamp(t / dur, 0, 1)
				local e = u * u * (3 - 2 * u)
				local ang = rad(a0 + (a1 - a0) * e)
				local c = centerFn()
				local f0 = fov0 or 50
				return Kit.look(c + V(cos(ang) * radius, height, sin(ang) * radius), c, f0 + ((fov1 or f0) - f0) * e)
			end
		end
		local function rocks(center, count, power, size, color)
			if Kit.fast() then return end
			for _ = 1, count do
				local r = Instance.new("Part")
				r.Size = V(1, 1, 1) * size * (0.5 + random())
				r.Color = color or rgb(74, 66, 66)
				r.Material = Enum.Material.Plastic
				r.MaterialVariant = "Studs"
				r.CFrame = CFrame.new(center + V(random(-3, 3), 1.5, random(-3, 3))) * CFrame.Angles(random(), random(), random())
				r.CanCollide, r.CanQuery, r.CanTouch, r.CastShadow = true, false, false, false
				r.Parent = scene
				local a = random() * math.pi * 2
				r.AssemblyLinearVelocity = V(cos(a) * random(10, 30) * power, random(30, 60) * power, sin(a) * random(10, 30) * power)
				r.AssemblyAngularVelocity = V(random(-8, 8), random(-8, 8), random(-8, 8))
				Debris:AddItem(r, 4)
			end
		end
		local function neonPart(shape, color, transp)
			local p = Instance.new("Part")
			p.Shape = shape
			p.Material, p.Color, p.Transparency = Enum.Material.Neon, color, transp or 0
			p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
			p.Size = V(0.2, 0.2, 0.2)
			p.Parent = scene
			return p
		end
		-- cylindre lumineux tendu entre deux points (rayons d'énergie)
		local function stretch(p, a, b, d)
			local len = (b - a).Magnitude
			if len < 0.05 then p.Size = V(0.05, d, d) p.CFrame = CFrame.new(a) return end
			p.Size = V(len, d, d)
			p.CFrame = CFrame.lookAt((a + b) / 2, b) * CFrame.Angles(0, math.pi / 2, 0)
		end
		-- changements locaux sur la vraie ville
		local function setLocal(part, prop, value)
			local old = part[prop]
			part[prop] = value
			table.insert(restore, function() if part.Parent then part[prop] = old end end)
		end
		local function hideModel(model, hidden)
			for _, p in model:GetDescendants() do
				if p:IsA("BasePart") then
					if hidden then
						local old = p.Transparency
						p:SetAttribute("FilmT", old)
						p.Transparency = 1
						table.insert(restore, function() if p.Parent then p.Transparency = old end end)
					else
						local old = p:GetAttribute("FilmT")
						if old then p.Transparency = old end
					end
				end
			end
		end
		local filmGui = player.PlayerGui:FindFirstChild("FightFilmGui")
		local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
		-- grand texte à l'écran qui tremble
		local function bigText(text, colors, dur, y, height)
			if not filmGui then return end
			y = y or 0.42
			local l = Instance.new("TextLabel")
			l.BackgroundTransparency = 1
			l.AnchorPoint = Vector2.new(0.5, 0.5)
			l.Position, l.Size = UDim2.fromScale(0.5, y), UDim2.fromScale(0.9, height or 0.14)
			l.FontFace = HEAVY
			l.TextScaled, l.TextColor3, l.ZIndex = true, WHITE, 7
			l.Text = text
			l:SetAttribute("No3D", true)
			local points = {}
			for i, c in colors do points[i] = ColorSequenceKeypoint.new((i - 1) / math.max(1, #colors - 1), c) end
			local g = Instance.new("UIGradient")
			g.Color = ColorSequence.new(points)
			g.Rotation = 90
			g.Parent = l
			local stroke = Instance.new("UIStroke")
			stroke.Thickness, stroke.Color = 5, rgb(30, 0, 4)
			stroke.Parent = l
			local scale = Instance.new("UIScale")
			scale.Scale = 2.2
			scale.Parent = l
			l.TextTransparency = 1
			l.Parent = filmGui
			TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
			TweenService:Create(l, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
			Kit.tween(dur, function(_, u)
				local k = (1 - u) * 0.008
				l.Position = UDim2.fromScale(0.5 + (random() - 0.5) * k, y + (random() - 0.5) * k * 1.4)
			end, "linear")
			Kit.delay(dur, function()
				TweenService:Create(l, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
				TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
			end)
			return l
		end
		local function overlay(color, z)
			if not filmGui then return nil end
			local f = Instance.new("Frame")
			f.BorderSizePixel = 0
			f.BackgroundColor3 = color
			f.BackgroundTransparency = 1
			f.Size = UDim2.fromScale(1, 1)
			f.ZIndex = z or 9
			f.Parent = filmGui
			return f
		end

		------------------------------------------------ la ville : points d'explosion, feux, hôtel, cratère d'atterrissage
		local boomPoints, fires = {}, {}
		local hotel, landingCrater
		if city then
			local env = city:FindFirstChild("EnvironmentalEffects")
			local pf = env and env:FindFirstChild("ExplosionPoints")
			for _, p in pf and pf:GetChildren() or {} do table.insert(boomPoints, p.Position) end
			for _, f in city:GetDescendants() do if f:IsA("Fire") then table.insert(fires, f) end end
			local buildings = city:FindFirstChild("Buildings")
			hotel = buildings and buildings:FindFirstChild("AbandonedHotel")
			local debrisFolder = city:FindFirstChild("Debris")
			local craters = debrisFolder and debrisFolder:FindFirstChild("Craters")
			for _, c in craters and craters:GetChildren() or {} do
				if ((c:GetPivot().Position - P(0, 0, -6)) * V(1, 0, 1)).Magnitude < 5 then landingCrater = c end
			end
		end
		local function bigBoom(pos, s, color)
			s = s or 1
			Fx.burst("Explosion-01", pos, {scale = 6 * s, color = color or ORANGE, time = 0.4})
			Fx.burst("Realistic-Explosion-01", pos, {scale = 4 * s})
			Fx.burst("Smoke-01", pos, {scale = 5 * s})
			Fx.light(pos, color or ORANGE, 150 * s, 5, 0.8)
			Kit.snd(S.Boom, math.min(0.25 * s, 0.9), 0.75 + random() * 0.3)
		end
		-- une explosion dans le décor, là où regarde la caméra
		local function distantBoom()
			if #boomPoints == 0 then return end
			local cam = workspace.CurrentCamera.CFrame
			for _ = 1, 14 do
				local p = boomPoints[random(#boomPoints)]
				local d = p - cam.Position
				if d.Magnitude > 90 and cam.LookVector:Dot(d.Unit) > 0.6 then
					bigBoom(p, 0.8 + random() * 0.6, random() < 0.3 and RED or ORANGE)
					return
				end
			end
		end
		local function lightning(pos, color)
			pos = pos or P(random(-400, 400), 0, random(-450, -150))
			Fx.mesh("Thunder", CFrame.new(pos + V(0, 140, 0)) * CFrame.Angles(0, random() * 6.28, rad(random(-10, 10))), {color = color or rgb(255, 130, 120), size0 = V(26, 220, 30), size1 = V(32, 250, 36), time = 0.35, transp0 = 0, ease = "linear"})
			Fx.light(pos + V(0, 240, 0), rgb(255, 120, 110), 700, 4, 0.3)
			Kit.flash(0.18, rgb(255, 80, 70), 0.2)
			Kit.snd(S.Thunder, 0.5, 0.8 + random() * 0.3)
		end
		local fireSizes = {}
		local function boostFires(k, t)
			for _, f in fires do
				if f.Parent then
					if not fireSizes[f] then fireSizes[f] = f.Size end
					local to = fireSizes[f] * k
					if t and t > 0 then TweenService:Create(f, TweenInfo.new(t), {Size = to}):Play() else f.Size = to end
				end
			end
		end
		table.insert(restore, function() for f, s in fireSizes do if f.Parent then f.Size = s end end end)
		-- explosions de fond pendant tout le film
		local ambientBooms = true
		Kit.fork(function()
			while true do
				Kit.wait(1.8 + random() * 2.2)
				if ambientBooms then distantBoom() end
			end
		end)

		-- ================================================ SCÈNE 1 : l'arrivée du boss (0 - 8 s)
		local KINO0, REX0, LAND = P(-5, 0, 62), P(5, 0, 64), P(0, 0, -6)
		kino:place(KINO0, P(-5, 0, 0))
		rex:place(REX0, P(5, 0, 0))
		kino:to(H.READY, 0)
		rex:to(mirror(H.READY), 0)
		kino:watch(P(0, 30, -40), 0.4)
		rex:watch(P(0, 30, -40), 0.4)
		boss:place(LAND, P(0, 0, 60)) -- il regarde vers le sud (vers les héros)
		boss:setVisible(0)
		for _, e in bossParts.Aura or {} do e.Enabled = false end
		giant:place(P(0, 0, 470), P(0, 0, 0)) -- au bout de l'avenue sud, tourné vers la place
		giant:to(merge(B.IDLE, {WingR = {0, -60, 0}, WingL = {0, 60, 0}}), 0)
		giant:body({air = 1, lift = -80}, 0)
		giant:setVisible(0)
		if landingCrater then hideModel(landingCrater, true) end
		local music = loop(MUSIC.Epic, 0)
		Kit.fadeSound(music, 0.5, 2.5)
		local rumble = loop(S.Hum, 0.22, 0.55)
		Kit.bars(true, 0)
		Kit.fade(1, 1.4)
		-- travelling au-dessus de la ville détruite
		Kit.cam(function(t)
			local u = clamp(t / 3.8, 0, 1)
			local e = u * u * (3 - 2 * u)
			return Kit.look(P(60, 190, 380):Lerp(P(8, 70, 150), e), P(0, 30, -100):Lerp(P(0, 12, 20), e), 62 - 6 * e)
		end)
		Kit.delay(0.6, distantBoom)
		Kit.delay(1.0, lightning)
		Kit.delay(1.5, distantBoom)
		Kit.delay(2.3, distantBoom)
		Kit.delay(2.8, lightning)
		Kit.delay(3.2, distantBoom)
		at(3.8)
		-- la caméra descend derrière les deux héros
		Kit.cam(function(t) return Kit.look(P(-1 + t * 0.4, 7 - t * 0.5, 86 - t * 1.5), P(0, 16 + t * 2, 0), 58) end, 0.9)
		at(4.1)
		local skyPos = P(0, 135, -6)
		Fx.burst("Portal-01", CFrame.new(skyPos) * CFrame.Angles(rad(90), 0, 0), {scale = 10, color = RED, time = 1.2})
		Fx.mesh("Spiral", CFrame.new(skyPos), {color = BLOOD, size0 = 2, size1 = 9, time = 1.2, transp0 = 0.2, spin = 1.5})
		Fx.burst("Smoke-01", skyPos, {scale = 8})
		Fx.light(skyPos, RED, 300, 5, 1.2)
		Kit.snd(S.Hum, 0.6, 0.4)
		lightning(P(-60, 0, -40))
		for _, a in {kino, rex} do a:watch(skyPos, 1) end
		kino:to(merge(H.READY, {Waist = {6}, Neck = {20}}), 0.4, "inOut")
		rex:to(merge(mirror(H.READY), {Waist = {6}, Neck = {22}}), 0.45, "inOut")
		at(4.4)
		-- il tombe du ciel dans la fumée
		boss:setVisible(1)
		boss:to(B.FALL, 0)
		boss:body({air = 1, lift = 125}, 0)
		boss:body({lift = 0}, 0.75, "inQuad")
		for _, a in {kino, rex} do a:watch(boss, 1) end
		Kit.fork(function() for _ = 1, 4 do Kit.ghost(boss, BLOOD, 0.25, 0.6) Kit.wait(0.12) end end)
		at(5.15)
		-- l'atterrissage : onde de choc, poussière, débris
		boss:body({air = 0}, 0)
		boss:to(B.LAND, 0.06, "outQuad")
		for _, e in bossParts.Aura or {} do e.Enabled = true end
		if landingCrater then hideModel(landingCrater, false) end
		Fx.burst("Ground-Impact", LAND + V(0, 0.5, 0), {scale = 3.5})
		Fx.burst("Big-Crack-01", LAND + V(0, 0.3, 0), {scale = 3})
		for i = 1, 3 do
			Kit.delay((i - 1) * 0.08, function()
				Fx.mesh("Shockwave", CFrame.new(LAND + V(0, 0.6 + i * 0.2, 0)), {color = ({ORANGE, RED, rgb(70, 56, 56)})[i], size0 = 0.5, size1 = 10 + i * 2.5, time = 0.9, transp0 = 0.15, ease = "outQuad"})
			end)
		end
		for i = 1, 10 do
			local a = i / 10 * math.pi * 2
			Kit.delay(0.04 * i, function() Fx.burst("Smoke-01", LAND + V(cos(a) * 14, 1, sin(a) * 14), {scale = 3}) end)
		end
		rocks(LAND, 14, 1.2, 1.8)
		Fx.light(LAND + V(0, 4, 0), ORANGE, 140, 6, 0.6)
		Kit.flash(0.35, RED, 0.5)
		Kit.shake(1.6)
		Kit.hitstop(0.12, 0.05)
		Kit.snd(S.Boom, 1, 0.65)
		Kit.snd(S.CosmicBoom, 0.6, 0.85)
		Kit.delay(0.25, function()
			for _, a in {kino, rex} do
				a:to(H.BRACE, 0.12, "outQuad")
				a:move(a.pos + V(0, 0, 1.8), 0.3, "outCubic")
				dust(a.pos, 0.8)
			end
		end)
		at(5.7)
		-- il se relève dans la fumée (contre-plongée)
		Kit.cam(function(t) return Kit.look(P(3 - t, 2.2, 20 - t * 1.5), boss:center(2 + t), 48) end)
		boss:to(B.RISE, 0.6, "inOut")
		at(6.2)
		boss:to(B.GLARE, 0.5, "inOut")
		at(6.4)
		-- gros plan sur ses yeux rouges
		Kit.cam(function(t)
			local h = bossHead.Position
			return Kit.look(h + V(-0.6 + t * 0.4, 0.3, 6.5 - t * 1.6), h + V(0, 0.35, 0), 32)
		end)
		for _, eye in bossParts.Eyes do
			Fx.burst("Glowing-Eyes-01", eye.CFrame, {scale = 1.4, color = RED})
			Fx.light(eye.Position, RED, 14, 6, 0.9)
		end
		Kit.snd(S.Ghost, 0.8, 0.45)
		Kit.punch(-4)
		at(7.3)
		-- les héros prennent leur position de combat
		Kit.cam(function(t) return Kit.look(P(t, 2.4, 50 - t * 0.6), P(0, 3.8, 63), 52) end)
		kino:to(H.GUARD, 0.25, "outBack")
		Kit.delay(0.15, function() rex:to(H.GUARD2, 0.25, "outBack") end)
		dust(kino.pos, 0.6)
		dust(rex.pos, 0.6)
		Fx.aura("Fire-Aura-01", kino, {scale = 0.5, time = 0.9})
		Fx.burst("Lighting-02", rex:center(0.5), {scale = 0.8, color = CYAN})
		Kit.snd(S.Whoosh, 0.5, 0.9)

		-- ================================================ SCÈNE 2 : le premier échange (8 - 20 s)
		at(8.0)
		-- le boss rugit
		Kit.cam(function(t) return Kit.look(P(-36 + t * 1.2, 9, 30), P(0, 8, 26), 56) end)
		boss:to(B.ROAR, 0.35, "outBack")
		Kit.snd(S.Screech, 0.9, 0.5)
		Kit.snd(S.Ghost, 0.7, 0.35)
		Kit.delay(0.2, function()
			Fx.mesh("Shockwave", CFrame.lookAt(bossHead.Position + V(0, 0, 2), bossHead.Position + V(0, 0, 10)) * CFrame.Angles(rad(90), 0, 0), {color = RED, size0 = 0.2, size1 = 3, time = 0.6})
			Kit.shake(0.7)
		end)
		at(8.8)
		boss:to(B.GLARE, 0.4, "inOut")
		-- kinoshi112 fonce vers le boss
		run(kino, P(-3, 0, 12), 1.2)
		kino:watch(boss, 0.6)
		Kit.cam(function() return Kit.look(kino.pos + V(-11, 3.5, 4), kino:center(0.5) + V(0, 0, -6), 60) end, 0.2)
		Kit.speedLines(1.0, 0.4)
		at(9.5)
		boss:face(kino.pos, 0.2)
		boss:to(B.SWIPE_WIND, 0.25, "outCubic")
		Kit.snd(S.Ghost, 0.4, 0.8)
		at(9.75)
		-- esquive au dernier moment : glissade sous les griffes (ralenti)
		kino:gait(nil, 0.08)
		kino:move(P(-1.5, 0, 3), 0.4, "outQuad")
		kino:to(H.SLIDE, 0.12, "outQuad")
		kino:body({sink = 1.2, pitch = rad(14)}, 0.12)
		Kit.cam(function() return Kit.look(P(-6, 1.4, 20), P(-1.5, 5, 4), 50) end)
		slowmo(0.3, 0.1)
		at(9.95)
		boss:to(B.SWIPE, 0.12, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.8, 0.6)
		Fx.burst("Slash-01", CFrame.new(P(-2, 6, 6)) * CFrame.Angles(0, rad(90), rad(-10)), {scale = 2, color = RED})
		Fx.burst("Wind-01", P(-1.5, 5, 6), {scale = 1.5})
		at(10.2)
		slowmo(1, 0.15)
		kino:body({sink = 0, pitch = 0}, 0.15)
		at(10.3)
		-- saut et enchaînement aérien : deux directs, retourné au visage, marteau sur le crâne
		kino:face(boss.pos, 0.1)
		kino:to(H.TUCK, 0.12, "outQuad")
		kino:body({air = 1}, 0.08)
		kino:body({lift = 6.5}, 0.35, "outQuad")
		kino:move(P(-0.5, 0, -1.6), 0.35, "outQuad")
		Kit.snd(S.Whoosh, 0.6, 1.1)
		dust(kino.pos, 0.6)
		Kit.cam(orbit(function() return (kino:center(0) + boss:center(2)) / 2 end, 14, 1.5, 40, 150, 2.0, 55), 0.2)
		at(10.7)
		strike(kino, H.AIR_WIND_R, H.AIR_JAB_R, boss, {where = function() return bossFront(3.2) end, power = 0.9, color = ORANGE, guard = H.AIR_GUARD})
		at(11.0)
		strike(kino, nil, H.AIR_JAB_L, boss, {where = function() return bossFront(3.6) end, power = 0.9, color = ORANGE, guard = H.AIR_GUARD})
		at(11.3)
		kino:body({lift = 8.5}, 0.2, "outQuad")
		strike(kino, H.ROUND_WIND_AIR, H.ROUND_AIR, boss, {where = function() return bossHead.Position + flatUnit(boss:point(1) - boss.pos) * 1.2 end, power = 1.3, color = ORANGE, guard = H.AIR_GUARD})
		boss:to(merge(B.GLARE, {Neck = {-10, 40, 10}, Root = {-10, 20, 0}}), 0.1, "outQuad")
		at(11.75)
		kino:body({lift = 10}, 0.15, "outQuad")
		strike(kino, H.AXE_WIND, H.AXE, boss, {where = function() return bossHead.Position + V(0, 1.2, 0) end, power = 1.5, color = GOLD, wind = 0.14, guard = H.AIR_GUARD})
		boss:to(B.HURT, 0.1, "outQuad")
		at(12.1)
		kino:body({lift = 0}, 0.28, "inQuad")
		kino:to(H.TUCK, 0.15)
		boss:to(B.GLARE, 0.4, "inOut")
		at(12.38)
		kino:body({air = 0}, 0.05)
		kino:to(H.LAND, 0.08, "outQuad")
		dust(kino.pos, 0.9)
		Kit.snd(S.Thud, 0.6, 0.9)
		Kit.cam(function(t) return Kit.look(P(10, 3, 8 + t), P(-1, 4, -2), 50) end, 0.15)
		at(12.6)
		kino:to(H.GUARD, 0.15)
		at(12.75)
		strike(kino, H.LOWKICK_WIND, H.LOWKICK, boss, {where = function() return bossRig["Left Leg"].Position + flatUnit(boss:point(1) - boss.pos) * 1.2 end, power = 1, color = ORANGE})
		at(13.05)
		strike(kino, nil, H.UPPER_R, boss, {where = function() return bossFront(0.5) end, power = 1.2, color = GOLD})
		-- le boss contre-attaque et projette kinoshi112
		at(13.35)
		boss:to(B.BACKHAND_WIND, 0.22, "outCubic")
		Kit.snd(S.Ghost, 0.5, 0.7)
		at(13.6)
		boss:to(B.BACKHAND, 0.1, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.9, 0.55)
		at(13.68)
		impact(kino, kino:center(1), 1.6, RED)
		kino:to(H.HURT, 0.08, "outQuad")
		kino:body({air = 1, pitch = rad(25)}, 0.12)
		kino:move(P(-6, 0, 30), 0.65, "outCubic", {arc = 4})
		Kit.cam(function(t) return Kit.look(P(26, 7, 20), P(-4, 5, 16 + t * 5), 54) end)
		Kit.fork(function() for _ = 1, 5 do Kit.ghost(kino, ORANGE, 0.25, 0.6) Kit.wait(0.06) end end)
		at(14.33)
		kino:body({air = 0, pitch = 0}, 0.08)
		skid(kino, boss.pos, 3, 0.35, H.KNEEL)
		kino:watch(boss, 0.8)
		at(14.5)
		-- il avance lourdement vers kinoshi112, sonné
		boss:to(B.GLARE, 0.3)
		stomp(boss, P(-5, 0, 19), 1.0)
		Kit.cam(function() return Kit.look(P(-24, 2.5, 44), boss:center(2), 50) end, 0.4)
		at(15.5)
		boss:face(kino.pos, 0.2)
		boss:to(B.SLAM_WIND, 0.4, "outCubic")
		Kit.snd(S.Screech, 0.6, 0.6)
		at(15.7)
		-- rexydev1 surgit et bloque le coup
		dash(rex, P(-5.5, 0, 28), 0.22, CYAN)
		rex:watch(boss, 0.8)
		Kit.cam(function() return Kit.look(P(-26, 2.2, 31), P(-5, 7, 25), 52) end)
		at(15.95)
		rex:face(boss.pos, 0.05)
		rex:to(H.BLOCK_HIGH, 0.1, "outQuad")
		Fx.burst("Shield-01", rex:center(2), {scale = 1.6, color = CYAN})
		at(16.1)
		boss:to(B.SLAM, 0.12, "outQuart", {lag = false})
		slowmo(0.25, 0.05)
		at(16.2)
		local hitPos = rex:center(3.2)
		Fx.burst("ForceField-Break-01", hitPos, {scale = 2.5, color = CYAN})
		Fx.burst("Explosion-01", hitPos, {scale = 3, color = CYAN, time = 0.3})
		Fx.mesh("Shockwave", CFrame.new(rex.pos + V(0, 0.5, 0)), {color = CYAN, size0 = 0.3, size1 = 6, time = 0.8, transp0 = 0.1})
		Fx.mesh("Shockwave", CFrame.new(rex.pos + V(0, 0.8, 0)), {color = WHITE, size0 = 0.3, size1 = 4, time = 0.6, transp0 = 0.3})
		for i = 1, 6 do
			local a = i / 6 * math.pi * 2
			Fx.burst("Smoke-01", rex.pos + V(cos(a) * 5, 0.5, sin(a) * 5), {scale = 1.6})
		end
		Fx.burst("Big-Crack-01", rex.pos + V(0, 0.2, 0), {scale = 1.4})
		Fx.light(hitPos, CYAN, 60, 6, 0.6)
		Kit.flash(0.3, CYAN, 0.6)
		Kit.shake(1.2)
		Kit.hitstop(0.18, 0.04)
		rex:hit(1.2)
		rex:body({sink = 0.7}, 0.1)
		Kit.snd(S.Clang, 0.9, 0.7)
		Kit.snd(S.Boom, 0.7, 1.1)
		rocks(rex.pos, 8, 0.7, 1)
		at(16.55)
		slowmo(1, 0.15)
		at(16.8)
		-- il repousse les poings du boss
		rex:to(H.PUSH_UP, 0.12, "outBack")
		rex:body({sink = 0}, 0.2)
		boss:to(B.RECOIL, 0.15, "outQuad")
		boss:move(boss:point(-6), 0.5, "outCubic")
		Fx.burst("Punch-02", hitPos + V(0, 2, 0), {scale = 1.5, color = CYAN})
		Kit.snd(S.HeavyPunch, 0.8, 0.9)
		Kit.shake(0.5)
		at(17.3)
		kino:to(H.RISE, 0.3, "inOut")
		at(17.7)
		kino:to(H.GUARD, 0.3, "inOut")
		kino:move(P(-11, 0, 29), 0.4, "inOut")
		rex:to(H.GUARD2, 0.3)
		at(18.0)
		-- plan à deux par-dessus l'épaule du boss ; un regard
		Kit.cam(function(t) return Kit.look(boss.pos + V(9 + t * 0.4, 15, -3), (kino.pos + rex.pos) / 2 + V(0, 3, 0), 46) end, 0.3)
		boss:to(B.GLARE, 0.5, "inOut")
		rex:watch(kino, 0.7)
		Kit.fork(crackKnuckles, kino, H.GUARD) -- kinoshi112 fait craquer ses jointures et sa nuque
		at(18.6)
		kino:watch(rex, 0.7)
		Kit.fork(rollWrists, rex, 0.25, H.GUARD2) -- rexydev1 fait rouler ses poignets et secoue ses mains
		at(19.2)
		kino:watch(boss, 0.8)
		rex:watch(boss, 0.8)
		boss:to(B.ROAR, 0.3, "outBack")
		Kit.snd(S.Screech, 0.5, 0.55)
		Kit.shake(0.4)
		at(19.8)
		boss:to(B.GLARE, 0.3)

		-- ================================================ SCÈNE 3 : le combo duo (20 - 38 s)
		local B3 = boss.pos
		at(20.0)
		-- rexydev1 attire l'attention du boss : course autour de lui
		Kit.cam(function() return Kit.look(P(32, 7, 30), rex:center(1), 52) end, 0.3)
		run(rex, P(10, 0, 18), 0.5)
		boss:face(P(10, 0, 18), 0.4)
		at(20.5)
		run(rex, P(5, 0, 0), 0.5)
		boss:face(P(5, 0, 0), 0.5)
		at(21.0)
		local toRex = flatUnit(P(5, 0, 0) - B3)
		rex:move(B3 + toRex * 5, 0.2, "outQuad")
		rex:face(B3, 0.08)
		rex:to(H.GUARD2, 0.12)
		Kit.cam(function(t) return Kit.look(B3 + toRex * 5 + V(-6 + t, 3, -5), (B3 + rex.pos) / 2 + V(0, 4, 0), 50) end, 0.15)
		at(21.2)
		strike(rex, nil, mirror(H.JAB_R), boss, {where = function() return bossRig["Right Arm"].Position end, power = 0.8, color = CYAN, guard = H.GUARD2})
		at(21.45)
		strike(rex, nil, mirror(H.JAB_L), boss, {where = function() return boss:center(1) + toRex * 1.6 end, power = 0.8, color = CYAN, guard = H.GUARD2})
		at(21.7)
		strike(rex, mirror(H.KICK_WIND), mirror(H.KICK), boss, {where = function() return boss:center(-1.5) + toRex * 1.8 end, power = 1, color = CYAN, guard = H.GUARD2})
		at(21.95)
		-- le boss balaie : salto arrière
		boss:to(B.SWIPE_L_WIND, 0.2, "outCubic")
		at(22.15)
		rex:to(H.TUCK, 0.1)
		rex:body({air = 1}, 0.03)
		rex:move(rex.pos + toRex * 9, 0.55, "outQuad", {arc = 6})
		rex:body({pitch = math.pi * 2}, 0.55, "inOut")
		Kit.snd(S.Whoosh, 0.6, 1.2)
		at(22.25)
		boss:to(B.SWIPE_L, 0.12, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.8, 0.6)
		Fx.burst("Slash-01", CFrame.new(B3 + toRex * 6 + V(0, 6, 0)), {scale = 2, color = RED})
		at(22.72)
		rex:body({pitch = 0, air = 0}, 0)
		rex:to(H.LAND, 0.08, "outQuad")
		dust(rex.pos, 0.7)
		at(22.95)
		Kit.fork(beckon, rex) -- « viens », paume vers le ciel
		boss:to(B.GLARE, 0.3)
		at(23.15)
		boss:to(B.ROAR, 0.25, "outBack")
		Kit.snd(S.Screech, 0.6, 0.6)
		Kit.shake(0.4)
		at(23.6)
		boss:face(rex.pos, 0.2)
		boss:to(B.SLAM_WIND, 0.35, "outCubic")
		Kit.cam(function(t) return Kit.look(P(26, 6, 22 - t), (B3 + rex.pos) / 2 + V(0, 6, 0), 54) end, 0.2)
		local slamAt = rex.pos
		at(23.95)
		dash(rex, rex.pos + flatUnit(V(-toRex.Z, 0, toRex.X)) * 7, 0.18, CYAN)
		at(24.1)
		boss:to(B.SLAM, 0.1, "outQuart", {lag = false})
		at(24.18)
		Fx.burst("Ground-Impact", slamAt + V(0, 0.5, 0), {scale = 2})
		Fx.burst("Big-Crack-01", slamAt + V(0, 0.3, 0), {scale = 1.8})
		Fx.mesh("Shockwave", CFrame.new(slamAt + V(0, 0.6, 0)), {color = RED, size0 = 0.4, size1 = 5, time = 0.6})
		rocks(slamAt, 8, 0.8, 1.3)
		Kit.shake(1.0)
		Kit.snd(S.Boom, 0.8, 0.9)
		at(24.45)
		-- contre-attaque de rexydev1 : coup de pied retourné sur le poignet du boss
		rex:face(slamAt, 0.08)
		strike(rex, H.SPINKICK_WIND, H.SPINKICK, boss, {where = function() return bossRig["Right Arm"].Position end, power = 1.2, color = CYAN, guard = H.GUARD2})
		boss:to(B.HURT, 0.1, "outQuad")
		at(24.85)
		rex:move(P(-2, 0, 1), 0.3, "outQuad")
		rex:face(B3, 0.2)
		boss:to(B.GLARE, 0.35, "inOut")
		boss:face(P(-2, 0, 1), 0.4)
		at(25.2)
		-- kinoshi112 : dash éclair en zigzag, il passe derrière le boss
		local fwd = flatUnit(P(-2, 0, 1) - B3)
		local behind = B3 - fwd * 7.5
		Kit.cam(function() return Kit.look(P(-30, 5, 34), (kino.pos + behind) / 2 + V(0, 3, 0), 58) end, 0)
		Fx.burst("Lighting-01", kino:center(0), {scale = 1.6, color = GOLD})
		Kit.snd(S.Spark, 0.8, 1.2)
		dash(kino, P(-17, 0, 24), 0.12, GOLD)
		at(25.34)
		Fx.burst("Lighting-01", kino:center(0), {scale = 1.4, color = GOLD})
		dash(kino, behind, 0.14, GOLD)
		at(25.5)
		Fx.burst("Lighting-01-Big", kino:center(0), {scale = 1.2, color = GOLD})
		Kit.snd(S.Spark, 0.9, 0.9)
		kino:face(B3, 0.1)
		kino:to(H.CHARGE_LOW, 0.2, "outQuad")
		dust(kino.pos, 0.8)
		local kinoFist = Fx.attach("Charge-01", handOf(kino, "Right"), {color = ORANGE, scale = 0.8})
		local kinoAura = Fx.aura("Fire-Aura-01", kino, {scale = 0.7})
		Kit.cam(function(t) return Kit.look(kino.pos - fwd * 6 + V(2, 3.5, 0) + fwd * t * 0.5, B3 + V(0, 10, 0), 56) end, 0.2)
		at(26.0)
		-- pendant ce temps, rexydev1 occupe le boss
		boss:to(B.SWIPE_WIND, 0.2, "outCubic")
		at(26.2)
		rex:to(H.DUCK, 0.08, "outQuad")
		boss:to(B.SWIPE, 0.12, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.7, 0.7)
		at(26.6)
		rex:to(H.GUARD2, 0.2)
		boss:to(B.GLARE, 0.3)
		at(27.0)
		-- ils se regardent brièvement
		Kit.cam(function(t)
			local h = headPos(kino)
			return Kit.look(h + fwd * 3.2 + V(0.8, 0.2, 0) + fwd * t * 0.3, h + V(0, 0.1, 0), 36)
		end)
		kino:watch(rex, 1)
		at(27.4)
		kino:to(merge(H.CHARGE_LOW, {Neck = {4, 30, 0}}), 0.15, "outQuad")
		at(27.55)
		kino:to(H.CHARGE_LOW, 0.15, "inOut")
		at(27.7)
		Kit.cam(function(t)
			local h = headPos(rex)
			return Kit.look(h - fwd * 3.2 + V(-0.8, 0.2, 0) - fwd * t * 0.3, h + V(0, 0.1, 0), 36)
		end)
		rex:watch(kino, 1)
		at(28.0)
		rex:to(merge(H.GUARD2, {Neck = {-12, 0, 0}}), 0.12, "outQuad")
		at(28.15)
		rex:to(H.GUARD2, 0.15)
		at(28.4)
		-- « MAINTENANT ! »
		bigText(LINES.Now, {WHITE, GOLD, RED}, 1.4, 0.4)
		Kit.snd(S.Spark, 0.9, 1)
		Kit.shake(0.5)
		kino:to(H.CHARGE_FIST, 0.12, "outQuad")
		rex:to(H.SPINKICK_WIND, 0.12, "outQuad")
		at(28.7)
		slowmo(0.22, 0.08)
		Kit.cam(function(t) return Kit.look(P(30, 7, 10) + V(0, 0, t * 2), B3 + V(0, 8, 0), 52) end, 0.15)
		kino:move(B3 - fwd * 4.4, 0.18, "outQuad")
		local kinoFire = Fx.attach("Fire-01", handOf(kino, "Right"), {scale = 1, color = ORANGE})
		rex:body({air = 1}, 0.05)
		rex:move(B3 + fwd * 5.2 + V(-fwd.Z, 0, fwd.X) * 3, 0.2, "outQuad")
		rex:body({lift = 8}, 0.25, "outQuad")
		at(28.9)
		kino:to(H.MEGA_PUNCH, 0.08, "outQuart", {lag = false})
		rex:to(merge(H.SPINKICK, {RightHip = {40, 0, 20}, RightKnee = {-80}}), 0.08, "outQuart", {lag = false})
		Kit.snd(S.Whoosh, 0.8, 0.8)
		at(29.0)
		-- double impact
		local backHit = B3 - fwd * 1.8 + V(0, 9.6, 0)
		local jawHit = bossHead.Position + fwd * 1.1
		Fx.burst("Explosion-01", backHit, {scale = 2.5, color = ORANGE, time = 0.3})
		Fx.burst("Punch-03", backHit, {scale = 2, color = ORANGE})
		Fx.burst("ForceField-Break-01", jawHit, {scale = 1.8, color = CYAN})
		Fx.burst("Punch-02", jawHit, {scale = 1.8, color = CYAN})
		for i, c in {ORANGE, CYAN} do
			local p = i == 1 and backHit or jawHit
			Fx.mesh("Shockwave", CFrame.lookAt(p, p + fwd) * CFrame.Angles(rad(90), 0, 0), {color = c, size0 = 0.3, size1 = 3.5, time = 0.6, transp0 = 0.1})
		end
		Fx.light(backHit, WHITE, 90, 8, 0.6)
		Kit.flash(0.4, WHITE, 0.8)
		Kit.speedLines(1.2, 0.8)
		Kit.shake(1.4)
		Kit.hitstop(0.25, 0.03)
		boss:hit(2)
		Kit.snd(S.HeavyPunch, 1, 0.8)
		Kit.snd(S.HeavyPunch, 0.8, 1.1)
		Kit.snd(S.Boom, 0.9, 0.9)
		Kit.snd(S.Clang, 0.6, 0.8)
		at(29.05)
		-- rexydev1 s'écarte d'abord (le boss va passer là)
		rex:move(P(9, 0, 4), 0.3, "outQuad")
		Kit.delay(0.25, function() rex:body({lift = 0}, 0.25, "inQuad") end)
		Kit.delay(0.5, function() rex:body({air = 0}, 0) rex:to(H.LAND, 0.08) dust(rex.pos, 0.6) end)
		at(29.2)
		slowmo(1, 0.12)
		kinoFist.stop()
		kinoFire.stop()
		kinoAura.stop()
		at(29.25)
		-- le boss est projeté (de dos) contre l'hôtel abandonné
		local wall = P(-14, 0, Config.Points.HotelFront + 3)
		boss:gait(nil, 0)
		boss:face(P(-14, 0, 100), 0.15)
		boss:to(B.FLY, 0.1, "outQuad")
		boss:body({air = 1, pitch = rad(28)}, 0.15)
		boss:move(wall, 0.7, "outQuad", {face = false})
		boss:body({lift = 22}, 0.7, "outQuad")
		Kit.fork(function() for _ = 1, 4 do Kit.ghost(boss, RED, 0.3, 0.6) Kit.wait(0.12) end end)
		kino:to(H.FIST_THRUST, 0.1)
		Kit.cam(function() return Kit.look(P(18, 9, 30), boss:center(0), 54) end, 0.12)
		at(29.95)
		-- choc contre la façade : une partie de l'hôtel s'effondre
		boss:to(B.SPLAT, 0.06, "outQuad")
		local wallHit = boss:center(0) - V(0, 0, 2)
		if hotel then
			local col, pile = hotel:FindFirstChild("Collapsible"), hotel:FindFirstChild("CollapseRubble")
			for _, p in col and col:GetChildren() or {} do
				if p:IsA("BasePart") then
					setLocal(p, "Transparency", 1)
					if p.Name == "FacadeBlock" and not Kit.fast() then
						for _ = 1, 4 do
							local c = Instance.new("Part")
							c.Size = V(random(4, 8), random(3, 7), random(2, 4))
							c.Color = p.Color
							c.Material = Enum.Material.Plastic
							c.MaterialVariant = "Studs"
							c.CFrame = p.CFrame * CFrame.new(random(-6, 6), random(-8, 8), 0) * CFrame.Angles(random(), random(), random())
							c.CanQuery, c.CanTouch = false, false
							c.Parent = scene
							c.AssemblyLinearVelocity = V(random(-14, 14), random(-4, 14), random(18, 40))
							c.AssemblyAngularVelocity = V(random(-5, 5), random(-5, 5), random(-5, 5))
							Debris:AddItem(c, 6)
						end
					end
				end
			end
			Kit.delay(0.9, function()
				for _, p in pile and pile:GetChildren() or {} do
					if p:IsA("BasePart") then setLocal(p, "Transparency", 0) end
				end
			end)
		end
		bigBoom(wallHit, 1.4, RED)
		for i = 1, 6 do Kit.delay(i * 0.12, function() Fx.burst("Smoke-01", wallHit + V(random(-20, 20), random(-14, 10), 6), {scale = 5}) end) end
		Fx.light(wallHit, RED, 220, 6, 1)
		Kit.shake(1.6)
		Kit.hitstop(0.1, 0.05)
		Kit.snd(S.CosmicBoom, 0.8, 0.8)
		Kit.cam(function(t) return Kit.look(P(24 - t * 1.5, 13, 34 - t * 3), P(-10, 30 - t * 2, -112), 56 - t) end, 0.1)
		at(30.4)
		-- il retombe dans les gravats
		boss:body({lift = 0, pitch = 0}, 0.5, "inQuad")
		boss:to(B.SLUMP, 0.5, "inOut")
		at(30.9)
		boss:body({air = 0}, 0)
		dust(boss.pos, 3)
		Kit.shake(0.8)
		Kit.snd(S.Thud, 0.9, 0.5)
		at(31.2)
		-- une explosion rouge illumine la rue
		bigBoom(P(-10, 40, Config.Points.HotelFront - 8), 2.2, RED)
		Fx.light(P(0, 20, -40), RED, 300, 5, 1.6)
		Kit.flash(0.4, RED, 0.45)
		Kit.shake(1)
		at(32.4)
		bigBoom(P(30, 70, Config.Points.HotelFront - 10), 1.4, ORANGE)
		at(33.0)
		-- ils se regroupent au milieu de la rue
		local KINO1, REX1 = P(-4, 0, 16), P(4, 0, 16)
		kino:gait("heroWalk", 0.15)
		kino:move(KINO1, 1.2, "inOut", {face = true})
		rex:gait("heroWalk", 0.15)
		rex:move(REX1, 1.2, "inOut", {face = true})
		Kit.delay(1.2, function() kino:gait(nil, 0.2) rex:gait(nil, 0.2) end)
		kino:to(H.TIRED, 0.6, "inOut")
		rex:to(H.TIRED, 0.6, "inOut")
		kino:watch(nil)
		rex:watch(nil)
		Kit.cam(orbit(function() return (kino.pos + rex.pos) / 2 + V(0, 3, 0) end, 12, 1.5, -60, -120, 5, 48, 44), 0.6)
		at(34.3)
		kino:face(REX1 + V(0, 0, -1), 0.4)
		rex:face(KINO1 + V(0, 0, -1), 0.4)
		kino:watch(rex, 0.8)
		rex:watch(kino, 0.8)
		kino:to(H.READY, 0.4, "inOut")
		rex:to(mirror(H.READY), 0.4, "inOut")
		at(34.8)
		kino:to(H.FISTBUMP, 0.25, "outBack")
		rex:to(mirror(H.FISTBUMP), 0.25, "outBack")
		at(35.05)
		Fx.burst("Stars-01", (kino.pos + rex.pos) / 2 + V(0, 3.4, -0.5), {scale = 0.8, color = GOLD})
		Kit.snd(S.Clang, 0.35, 1.6)
		Kit.fork(blowUp, kino, 1) -- check qui explose
		Kit.fork(blowUp, rex, -1)
		at(35.7)
		kino:to(H.READY, 0.4, "inOut")
		rex:to(mirror(H.READY), 0.4, "inOut")
		kino:face(P(-4, 0, -100), 0.5)
		rex:face(P(4, 0, -100), 0.5)
		at(36.6)
		-- les gravats bougent : ses yeux se rallument dans la poussière
		Kit.cam(function(t) return Kit.look(P(-4, 6, -78 + t), boss:center(2), 46) end)
		rocks(boss.pos + V(0, 6, 0), 6, 0.5, 1.5, rgb(124, 108, 96))
		Kit.snd(S.Thud, 0.8, 0.45)
		dust(boss.pos, 2.5)
		for _, eye in bossParts.Eyes do Fx.burst("Glowing-Eyes-01", eye.CFrame, {scale = 1.6, color = RED}) end
		Kit.snd(S.Ghost, 0.7, 0.4)
		at(37.3)
		kino:watch(boss, 1)
		rex:watch(boss, 1)
		kino:to(H.GUARD, 0.25, "outBack")
		rex:to(H.GUARD2, 0.25, "outBack")

		-- ================================================ SCÈNE 4 : l'attaque ultime (38 - 55 s)
		at(38.0)
		-- le boss se relève et rugit
		Kit.cam(function(t) return Kit.look(P(-8, 1.2, -86 + t), boss:center(3), 50) end)
		boss:to(B.RISE, 0.8, "inOut")
		rocks(boss.pos + V(0, 8, 0), 8, 0.6, 1.8, rgb(124, 108, 96))
		at(38.8)
		boss:to(B.ROAR, 0.3, "outBack")
		Kit.snd(S.Screech, 1, 0.45)
		Kit.shake(0.9)
		Fx.mesh("Shockwave", CFrame.new(boss.pos + V(0, 1, 0)), {color = RED, size0 = 0.5, size1 = 8, time = 0.8})
		at(39.6)
		boss:to(B.GLARE, 0.3)
		stomp(boss, P(-8, 0, -66), 2.0)
		Kit.cam(function() return Kit.look(P(0, 4, 34), boss:center(4), 50) end, 0.5)
		kino:move(KINO1, 0.5, "inOut")
		rex:move(REX1, 0.5, "inOut")
		at(41.7)
		-- il prépare une attaque gigantesque : une sphère d'énergie au-dessus de lui
		boss:face(P(0, 0, 16), 0.3)
		boss:to(B.CHANNEL, 0.6, "inOut")
		local sphere = neonPart(Enum.PartType.Ball, rgb(255, 40, 30), 0)
		local shell = neonPart(Enum.PartType.Ball, rgb(20, 0, 0), 0.35)
		shell.Material = Enum.Material.SmoothPlastic
		local sphereLight = Instance.new("PointLight")
		sphereLight.Color, sphereLight.Range, sphereLight.Brightness, sphereLight.Shadows = RED, 60, 4, false
		sphereLight.Parent = sphere
		local sphereSize = 1
		local spherePos = boss.hrp.Position + V(0, 16, 0)
		Kit.tween(4.5, function(e)
			sphereSize = 1 + 23 * e
			spherePos = boss.hrp.Position + V(0, 12 + sphereSize * 0.5, 0)
			sphere.Size = V(1, 1, 1) * sphereSize * 0.8
			shell.Size = V(1, 1, 1) * sphereSize
			sphere.CFrame = CFrame.new(spherePos)
			shell.CFrame = CFrame.new(spherePos)
			sphereLight.Range = 30 + sphereSize * 6
		end, "inOut")
		local crackle = true
		Kit.fork(function()
			while crackle do
				Fx.burst("Lighting-01-Big", spherePos, {scale = 1 + sphereSize * 0.08, color = RED})
				Kit.wait(0.35)
			end
		end)
		Mood.setLevel(2, 3)
		boostFires(1.9, 2)
		Kit.fadeSound(rumble, 0.7, 2)
		Kit.snd(S.Meltdown, 0.5, 0.7)
		Kit.delay(0.3, lightning)
		Kit.delay(1.3, lightning)
		Kit.delay(2.6, lightning)
		Kit.cam(function(t) return Kit.look(P(10, 2, -30 + t), spherePos, 58) end, 0.4)
		at(42.2)
		-- le temps ralentit : les deux héros chargent leur énergie
		slowmo(0.62, 0.4)
		ambientBooms = false
		kino:watch(boss, 1)
		rex:watch(boss, 1)
		kino:to(H.CHARGE_FIST, 0.5, "inOut")
		rex:to(H.CUP_CHARGE, 0.5, "inOut")
		local auraK = Fx.aura("Fire-Aura-01", kino, {scale = 1.1})
		local auraR = Fx.aura("Fire-Aura-01", rex, {scale = 1.1, color = CYAN})
		local fistK = Fx.attach("Charge-01", handOf(kino, "Right"), {color = ORANGE, scale = 1.2})
		Fx.burst("Crack-01", kino.pos + V(0, 0.2, 0), {scale = 1.5})
		Fx.burst("Crack-01", rex.pos + V(0, 0.2, 0), {scale = 1.5})
		Kit.snd(S.Hum, 0.6, 1.3)
		-- la boule d'énergie bleue entre les mains de rexydev1
		local ballR = neonPart(Enum.PartType.Ball, CYAN, 0.05)
		local ballLight = Instance.new("PointLight")
		ballLight.Color, ballLight.Range, ballLight.Brightness, ballLight.Shadows = CYAN, 18, 3, false
		ballLight.Parent = ballR
		local ballSize = 0.4
		local function rexHands()
			local a, b = handOf(rex, "Right"), handOf(rex, "Left")
			if a and b then return (a.Position + b.Position) / 2 end
			return rex:center(0)
		end
		Kit.tween(4.0, function(e)
			ballSize = 0.4 + 2.4 * e
			ballR.Size = V(1, 1, 1) * ballSize
			ballR.CFrame = CFrame.new(rexHands())
		end, "outQuad")
		-- pierres qui flottent autour de kinoshi112
		local floaters = {}
		if not Kit.fast() then
			for i = 1, 8 do
				local r = Instance.new("Part")
				r.Size = V(1, 1, 1) * (0.5 + random() * 0.9)
				r.Color = rgb(80, 72, 72)
				r.Material = Enum.Material.Plastic
				r.MaterialVariant = "Studs"
				r.Anchored, r.CanCollide, r.CanQuery, r.CanTouch = true, false, false, false
				r.Parent = scene
				local a, d, h = i / 8 * math.pi * 2, 2.5 + random() * 2.5, 1.5 + random() * 4
				table.insert(floaters, {part = r, a = a, d = d, h = h, spin = random() * 2})
			end
		end
		Kit.tween(4.1, function(e)
			for _, f in floaters do
				local ang = f.a + Kit.time * 0.6
				f.part.CFrame = CFrame.new(kino.pos + V(cos(ang) * f.d, f.h * e + sin(Kit.time * 3 + f.a) * 0.2, sin(ang) * f.d)) * CFrame.Angles(Kit.time * f.spin, Kit.time, 0)
			end
		end, "outQuad")
		-- le poing de kinoshi112 tremble, les bras de rexydev1 reculent lentement
		local trembling = true
		Kit.fork(function()
			while trembling do
				kino:to({RightShoulder = {-48 + random(-4, 4), 0, 22 + random(-3, 3)}, RightElbow = {112 + random(-5, 5)}, RightWrist = {16 + random(-7, 7), -10 + random(-6, 6), 4 + random(-5, 5)},
					LeftWrist = {-48 + random(-5, 5), random(-4, 4), 0}}, 0.08, "inOut", {only = true})
				Kit.wait(0.09)
			end
		end)
		Kit.delay(1.2, function() rex:to(H.CUP_DEEP, 2.6, "inOut") end)
		Kit.fork(function()
			for _ = 1, 9 do
				Fx.burst("Lighting-02", rexHands(), {scale = 0.6 + ballSize * 0.3, color = CYAN})
				Kit.wait(0.45)
			end
		end)
		-- la caméra tourne autour d'eux
		Kit.cam(orbit(function() return (kino.pos + rex.pos) / 2 + V(0, 3, 0) end, 11, 1.2, -100, 170, 3.8, 52, 46), 0.6)
		at(46.0)
		-- puis se rapproche au moment de frapper
		Kit.cam(function(t) return Kit.look(P(0, 3 + t * 0.4, 6 + t * 3), P(0, 4, 16), 40 - t * 6) end, 0.3)
		at(46.3)
		slowmo(1, 0.2)
		at(46.4)
		-- le boss lance sa sphère
		boss:to(B.THROW, 0.15, "outQuart", {lag = false})
		Kit.snd(S.Screech, 0.9, 0.5)
		crackle = false
		local merge0 = P(0, 5, 8)
		local S0 = spherePos
		local X0 = S0:Lerp(merge0, 0.55)
		local X = S0
		local bossChest = boss:center(3)
		-- les deux attaques ultimes
		at(46.55)
		trembling = false
		kino:to(H.FIST_THRUST, 0.08, "outQuart", {lag = false})
		rex:to(H.CUP_PUSH, 0.08, "outQuart", {lag = false})
		for _, f in floaters do
			local p = f.part
			Kit.tween(0.5, function(e) p.CFrame = p.CFrame + (p.Position - kino.pos).Unit * e * 1.5 end, "outQuad", function() p:Destroy() end)
		end
		Kit.snd(S.CosmicBoom, 0.9, 1.2)
		Kit.snd(S.Spark, 0.9, 0.8)
		local beamK = neonPart(Enum.PartType.Cylinder, ORANGE, 0.05)
		local beamR = neonPart(Enum.PartType.Cylinder, CYAN, 0.05)
		local beamOuter = neonPart(Enum.PartType.Cylinder, CYAN, 0.45)
		local beamCore = neonPart(Enum.PartType.Cylinder, rgb(255, 235, 200), 0)
		local clashLight = Instance.new("PointLight")
		clashLight.Color, clashLight.Range, clashLight.Brightness, clashLight.Shadows = WHITE, 80, 5, false
		clashLight.Parent = beamCore
		local power = 1
		local t46 = Kit.time
		Kit.tween(3.0, function()
			local t = Kit.time - t46
			-- la sphère arrive, les rayons la retiennent, oscillent, puis la repoussent jusqu'au boss
			if t < 0.35 then
				X = S0:Lerp(X0, t / 0.35)
			elseif t < 2.05 then
				X = X0 + (merge0 - X0).Unit * sin((t - 0.35) * 9) * 2.2
			else
				local u = clamp((t - 2.05) / 0.55, 0, 1)
				X = X0:Lerp(bossChest, u * u)
			end
			local front = t < 0.35 and merge0:Lerp(X0, t / 0.35) or X
			local hk = handOf(kino, "Right")
			stretch(beamK, hk and hk.Position or kino:center(0.5), merge0, 1.3 * power)
			stretch(beamR, rexHands(), merge0, 1.5 * power)
			stretch(beamOuter, merge0, front, 5 * power)
			stretch(beamCore, merge0, front, 2.4 * power)
			sphere.CFrame, shell.CFrame = CFrame.new(X + (X - merge0).Unit * sphereSize * 0.45), CFrame.new(X + (X - merge0).Unit * sphereSize * 0.45)
			ballR.CFrame = CFrame.new(rexHands())
		end, "linear")
		local clashing = true
		Kit.fork(function()
			Kit.wait(0.35)
			while clashing do
				local c = ({RED, CYAN, ORANGE, WHITE})[random(1, 4)]
				Fx.burst("Lighting-01", X, {scale = 2.2, color = c})
				Fx.burst("Stars-01", X, {scale = 1.5, color = c})
				Fx.light(X, c, 60, 4, 0.15)
				Kit.shake(0.3)
				if random() < 0.35 then Kit.snd(S.Spark, 0.5, 0.8 + random() * 0.6) end
				Kit.wait(0.12)
			end
		end)
		Kit.cam(function(t) return Kit.look(P(-22, 6, 22) + V(t * 1.5, 0, 0), (merge0 + X0) / 2 + V(0, 4, 0), 62) end, 0.15)
		at(46.9)
		-- l'affrontement : ils reculent sous la poussée
		kino:move(kino.pos + V(0, 0, 1.6), 1.6, "inOut")
		rex:move(rex.pos + V(0, 0, 1.6), 1.6, "inOut")
		Fx.burst("Smoke-01", kino.pos, {scale = 1.2})
		Fx.burst("Smoke-01", rex.pos, {scale = 1.2})
		at(47.7)
		Kit.cam(function(t) return Kit.look(P(3, 3.2, 4 - t), P(0, 4.2, 16), 46) end, 0.3)
		at(48.55)
		-- ils poussent ensemble : les rayons grossissent et l'emportent
		power = 1.6
		kino:move(kino.pos + V(0, 0, -1.2), 0.4, "outQuad")
		rex:move(rex.pos + V(0, 0, -1.2), 0.4, "outQuad")
		auraK.stop()
		auraR.stop()
		auraK = Fx.aura("Fire-Aura-01", kino, {scale = 1.6})
		auraR = Fx.aura("Fire-Aura-01", rex, {scale = 1.6, color = CYAN})
		Kit.flash(0.25, GOLD, 0.4)
		Kit.snd(S.CosmicBoom, 0.8, 1.4)
		Kit.cam(function(t) return Kit.look(P(-16, 10, 30) + V(0, t * 2, -t * 4), boss:center(4), 58) end, 0.2)
		at(49.15)
		-- explosion géante qui engloutit le boss
		clashing = false
		local Bc = boss:center(3)
		Fx.mesh("Sphere", CFrame.new(Bc), {color = WHITE, size0 = 0.5, size1 = 14, time = 1.4, transp0 = 0, ease = "outQuad"})
		Fx.mesh("Explosion", CFrame.new(Bc), {color = ORANGE, size0 = 0.5, size1 = 11, time = 1.2, transp0 = 0.1})
		Fx.burst("Realistic-Explosion-01", Bc, {scale = 12})
		Fx.burst("Explosion-01", Bc, {scale = 18, color = RED, time = 0.5})
		for i = 1, 3 do
			Kit.delay((i - 1) * 0.12, function()
				Fx.mesh("Shockwave", CFrame.new(boss.pos + V(0, 1 + i, 0)), {color = ({WHITE, ORANGE, RED})[i], size0 = 1, size1 = 25, time = 1.6, transp0 = 0.1, ease = "outQuad"})
			end)
		end
		Fx.light(Bc, ORANGE, 600, 8, 2)
		Kit.shake(2.2)
		Kit.punch(8)
		Kit.snd(S.Boom, 1, 0.6)
		Kit.snd(S.CosmicBoom, 0.9, 0.7)
		Kit.snd(S.Meltdown, 0.7, 1)
		Kit.cam(function() return Kit.look(P(0, 5, 30), Bc, 64) end, 0)
		at(49.35)
		-- l'écran devient blanc pendant une seconde
		local white = overlay(WHITE, 9)
		if white then TweenService:Create(white, TweenInfo.new(0.22), {BackgroundTransparency = 0}):Play() end
		at(49.7)
		for _, p in {sphere, shell, beamK, beamR, beamOuter, beamCore, ballR} do p:Destroy() end
		fistK.stop()
		auraK.stop()
		auraR.stop()
		boostFires(1, 0)
		Mood.setLevel(1, 0)
		Kit.fadeSound(rumble, 0.2, 0.5)
		Kit.fadeSound(music, 0.3, 1)
		-- le boss gît au sol, fumant ; ils sont épuisés
		boss:to(B.DOWN, 0)
		boss:place(P(-8, 0, -62), P(-8, 0, 20))
		boss:body({air = 1, pitch = rad(90), lift = -(boss.stand - 0.55 * boss.scale)}, 0)
		for _, eye in bossParts.Eyes do eye.Transparency = 0.7 end
		for _, e in bossParts.Aura or {} do e.Rate = e.Rate * 0.3 end
		local scorch = neonPart(Enum.PartType.Cylinder, rgb(14, 10, 10), 0)
		scorch.Material = Enum.Material.SmoothPlastic
		scorch.Size = V(0.3, 38, 38)
		scorch.CFrame = CFrame.new(P(-8, 0.16, -62)) * CFrame.Angles(0, 0, rad(90))
		kino:to(H.TIRED, 0)
		rex:to(H.TIRED, 0)
		kino:watch(boss, 0.6)
		rex:watch(boss, 0.6)
		at(50.5)
		if white then TweenService:Create(white, TweenInfo.new(1.2), {BackgroundTransparency = 1}):Play() end
		ambientBooms = true
		local smoking = true
		Kit.fork(function()
			while smoking do
				Fx.burst("Smoke-01", boss:center(0), {scale = 2})
				Fx.burst("Fire-02", P(random(-30, 30), 0.5, random(-10, 40)), {scale = 1})
				Kit.wait(0.7)
			end
		end)
		-- la fumée se dissipe : les héros au milieu de la rue détruite
		Kit.cam(function(t) return Kit.look(P(22 - t * 1.6, 16 - t * 1.6, 44 - t * 2), P(0, 3, 14), 50) end)
		at(52.6)
		kino:watch(nil)
		kino:to(H.VICTORY, 0.35, "outBack")
		Kit.snd(S.Whoosh, 0.5, 0.9)
		at(53.0)
		rex:watch(nil)
		rex:to(H.CROSS, 0.4, "outBack")
		Kit.cam(function(t) return Kit.look(P(0, 2.4, 4 - t * 0.5), P(0, 4, 16), 46) end, 0.4)

		-- ================================================ SCÈNE 5 : la surprise finale (55 - 61,5 s)
		at(54.4)
		-- un grondement sourd, le ciel s'embrase au sud
		local GIANT = P(0, 0, 470)
		Kit.snd(S.Hum, 0.9, 0.3)
		Kit.shake(0.5)
		Fx.light(GIANT + V(0, 150, 0), RED, 500, 4, 2)
		lightning(P(30, 0, 420))
		at(54.7)
		rex:to(merge(H.READY, {Neck = {10, 0, 0}}), 0.5, "inOut")
		rex:face(GIANT, 0.6)
		rex:watch(GIANT + V(0, 120, 0), 1)
		at(55.0)
		-- gros plan sur rexydev1, le boss vaincu au fond
		Kit.cam(function(t)
			local h = headPos(rex)
			return Kit.look(h + V(0.9, 0.2, 3.6 - t * 0.25), h + V(0, 0, 0), 38)
		end)
		rex:to(merge(H.SURPRISE, {RightShoulder = {30, 0, 25}, LeftShoulder = {30, 0, -25}}), 0.4, "outQuad")
		at(55.3)
		say(LINES.Rex, LINES.Behind, 2.6)
		at(55.5)
		-- le corps du démon se dissout en fumée rouge qui file vers le sud
		smoking = false
		boss:fade(0, 1.4)
		for _, e in bossParts.Aura or {} do e.Enabled = false end
		for i = 1, 6 do
			Kit.delay(i * 0.18, function()
				Fx.burst("Smoke-01", boss:center(0) + V(random(-6, 6), 2, random(-4, 4)), {scale = 3, color = BLOOD})
				local orb = neonPart(Enum.PartType.Ball, RED, 0.1)
				orb.Size = V(1.6, 1.6, 1.6)
				local from = boss:center(0) + V(random(-5, 5), 2, random(-3, 3))
				local to = GIANT + V(random(-30, 30), 140, 0)
				Kit.tween(2.4, function(e) orb.CFrame = CFrame.new(from:Lerp(to, e) + V(0, sin(e * math.pi) * 40, 0)) end, "inQuad", function() orb:Destroy() end)
			end)
		end
		at(56.2)
		kino:to(H.READY, 0.5, "inOut")
		kino:face(GIANT, 0.9)
		kino:watch(GIANT + V(0, 120, 0), 1)
		at(56.6)
		-- la caméra pivote lentement vers le ciel rouge : une silhouette gigantesque se lève au bout de l'avenue
		Kit.cam(function(t)
			local u = clamp(t / 3.4, 0, 1)
			local e = u * u * (3 - 2 * u)
			return Kit.look(P(1.5, 4.5 + 3 * e, 8 - 2 * e), P(0, 8, 60):Lerp(GIANT + V(0, 115, 0), e), 60 + 8 * e)
		end, 0.6)
		at(56.9)
		lightning(P(-60, 0, 440))
		giantGlow.Enabled = true
		TweenService:Create(giantGlow, TweenInfo.new(2), {FillTransparency = 0.35, OutlineTransparency = 0}):Play()
		giant:fade(1, 1.8)
		giant:body({lift = 0}, 2.6, "outCubic")
		giant:to(B.SPREAD, 2.4, "inOut")
		for _, eye in giantParts.Eyes do eye:SetAttribute("T0", 0.8) end -- (yeux éteints pendant qu'il apparaît)
		for i = 1, 5 do
			Kit.delay(i * 0.25, function() Fx.burst("Smoke-01", GIANT + V(random(-80, 80), 10, random(-30, 30)), {scale = 22, color = BLOOD}) end)
		end
		Kit.snd(S.Hum, 1, 0.25)
		Kit.shake(0.6)
		at(58.6)
		-- ses yeux s'allument : il rugit
		for _, eye in giantParts.Eyes do
			eye:SetAttribute("T0", 0)
			eye.Transparency = 0
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = RED, 120, 8, false
			l.Parent = eye
			Fx.burst("Flamming-Eyes-01", eye.CFrame, {scale = 18, color = RED})
		end
		-- des yeux qui brillent à travers la brume (pièces à part avec leur propre contour rouge vif)
		local eyesModel = Instance.new("Model")
		eyesModel.Name = "GiantEyes"
		local glows = {}
		for _, eye in giantParts.Eyes do
			local g = neonPart(Enum.PartType.Block, rgb(255, 60, 40), 0)
			g.Size = eye.Size * 1.5
			g.Parent = eyesModel
			glows[g] = eye
		end
		local eyeGlow = Instance.new("Highlight")
		eyeGlow.FillColor, eyeGlow.FillTransparency = rgb(255, 40, 20), 0
		eyeGlow.OutlineColor, eyeGlow.OutlineTransparency = rgb(255, 210, 160), 0.2
		eyeGlow.DepthMode = Enum.HighlightDepthMode.Occluded
		eyeGlow.Parent = eyesModel
		eyesModel.Parent = scene
		Kit.tween(4, function() for g, eye in glows do g.CFrame = eye.CFrame end end, "linear")
		giant:to(B.ROAR, 0.4, "outBack")
		Kit.snd(S.Screech, 1, 0.3)
		Kit.snd(S.Thunder, 0.9, 0.6)
		lightning(P(50, 0, 480))
		Kit.flash(0.4, RED, 0.5)
		Kit.shake(1)
		Mood.setLevel(2, 1.5)
		at(59.0)
		bigText(LINES.Title, {rgb(255, 200, 190), RED, rgb(120, 0, 0)}, 2.3, 0.4, 0.13)
		Kit.snd(S.Boom, 0.9, 0.7)
		at(59.8)
		-- une nouvelle barre de vie apparaît
		if filmGui then
			local holder = Instance.new("Frame")
			holder.AnchorPoint = Vector2.new(0.5, 0)
			holder.Position, holder.Size = UDim2.fromScale(0.5, 0.135), UDim2.fromScale(0.46, 0.035)
			holder.BackgroundColor3 = rgb(20, 6, 8)
			holder.BorderSizePixel = 0
			holder.ZIndex = 7
			holder.Parent = filmGui
			local st = Instance.new("UIStroke")
			st.Thickness, st.Color = 3, rgb(255, 60, 40)
			st.Parent = holder
			local fill = Instance.new("Frame")
			fill.BorderSizePixel = 0
			fill.BackgroundColor3 = WHITE
			fill.Size = UDim2.fromScale(0, 1)
			fill.ZIndex = 8
			fill.Parent = holder
			local g = Instance.new("UIGradient")
			g.Color = ColorSequence.new(rgb(255, 70, 40), rgb(140, 0, 20))
			g.Parent = fill
			local name = Instance.new("TextLabel")
			name.BackgroundTransparency = 1
			name.AnchorPoint = Vector2.new(0.5, 1)
			name.Position, name.Size = UDim2.new(0.5, 0, 0, -4), UDim2.new(1, 0, 1.3, 0)
			name.FontFace = HEAVY
			name.TextScaled, name.TextColor3, name.ZIndex = true, rgb(255, 220, 210), 8
			name.Text = LINES.BossName
			local ns = Instance.new("UIStroke")
			ns.Thickness = 3
			ns.Parent = name
			name.Parent = holder
			TweenService:Create(fill, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale(1, 1)}):Play()
			Kit.snd(S.Hum, 0.6, 1.6)
		end
		at(61.0)
		Kit.fadeSound(music, 0, 0.8)
		Kit.fade(0, 0.5)
		at(M.LENGTH)
	end)

	---------------------------------------------------------------- remise en état (toujours, même si le film a été interrompu)
	if not ok and err ~= "FILM_ABORT" then warn("[DemonFilm] " .. tostring(err)) end
	for _, s in loops do if s then s:Destroy() end end
	Kit.finish()
	-- enchaînement avec le combat : écran noir jusqu'à l'arrivée dans l'arène (DemonArenaClient le retire)
	if o.toArena and ok then
		local g = Instance.new("ScreenGui")
		g.Name = "DemonTransitionGui"
		g.IgnoreGuiInset, g.ResetOnSpawn, g.DisplayOrder = true, false, 260
		local black = Instance.new("Frame")
		black.Name = "Black"
		black.BorderSizePixel = 0
		black.BackgroundColor3 = Color3.new(0, 0, 0)
		black.Size = UDim2.fromScale(1, 1)
		black.Parent = g
		g.Parent = player.PlayerGui
		-- sécurité : s'il n'arrive jamais dans l'arène, l'écran noir s'en va tout seul
		task.delay(8, function()
			if g.Parent then
				TweenService:Create(black, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
				Debris:AddItem(g, 0.7)
			end
		end)
	end
	scene:Destroy()
	for i = #restore, 1, -1 do pcall(restore[i]) end
	Mood.leave(o.toArena and ok and 5 or nil)
	return ok, err
end

function M.stop() Kit.running = false end

return M
