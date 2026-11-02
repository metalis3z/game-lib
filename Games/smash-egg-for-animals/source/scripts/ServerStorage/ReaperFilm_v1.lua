-- Cinématique "The Hollow Reaper" (nouvelle version) : feu de camp, la Faucheuse sort de terre, trois sabres et trois pouvoirs
-- (rexydev1 le feu, kinoshi112 la glace, Nono275er le vent), la Nova creuse, puis la boule de feu qui rase la forêt.
-- Joué côté client par FightFilm.Kit (acteurs, caméra) et FightFilm.Fx (effets tirés de ALL VFX).
-- Positions : g(x, z, y) dans le repère du décor (clairière au centre, lune du côté +X). Temps : Kit.at(secondes de film).
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local film = script.Parent
local Kit = require(film:WaitForChild("Kit"))
local Fx = require(film:WaitForChild("Fx"))
local Cast = require(film:WaitForChild("Cast"))
local Samurai = require(film:WaitForChild("SamuraiFilm"))

local M = {}
local V, rgb = Vector3.new, Color3.fromRGB
local rad, sin, cos, clamp, max, min = math.rad, math.sin, math.cos, math.clamp, math.max, math.min
local ORIGIN = V(6000, 300, -7000)
local function g(x, z, y) return ORIGIN + V(x, y or 0, z) end
local FLAT = V(1, 0, 1)
local function flat(v) v = v * FLAT return v.Magnitude > 0.05 and v.Unit or V(1, 0, 0) end

local MUSIC_CALM, MUSIC_FIGHT = 1848159364, 1838626086
local S = {
	Swing = "rbxasset://sounds/swordslash.wav", Lunge = "rbxasset://sounds/swordlunge.wav", Unsheath = "rbxasset://sounds/unsheath.wav",
	Clang = 9119747138, Thud = "rbxasset://sounds/collide.wav", Ghost = "rbxasset://sounds/HalloweenGhost.wav", Thunder = "rbxasset://sounds/HalloweenThunder.wav",
	Snap = "rbxasset://sounds/snap.wav", Ping = "rbxasset://sounds/electronicpingshort.wav", Fire = 9079463756, Spark = 9116279560,
}
local FIRE, ICE, WIND, SOUL, WHITE = rgb(255, 130, 40), rgb(140, 225, 255), rgb(170, 255, 200), rgb(210, 80, 255), rgb(255, 255, 255)

local function merge(a, b)
	local out = {}
	for k, v in a do out[k] = v end
	for k, v in b or {} do out[k] = v end
	return out
end

---------------------------------------------------------------- poses
local H = Samurai.Poses -- poses de sabre du héros (garde, coups, parades...), partagées avec l'autre film
local P = {}
P.SIT = {RightHip = {84, 0, 8}, LeftHip = {84, 0, -8}, RightKnee = {-88}, LeftKnee = {-88}, Waist = {-10}, Neck = {4},
	RightShoulder = {26, 0, 6}, RightElbow = {58}, LeftShoulder = {26, 0, -6}, LeftElbow = {58}}
P.STAND = {RightShoulder = {-4, 0, 8}, RightElbow = {14}, LeftShoulder = {-4, 0, -8}, LeftElbow = {14}, Waist = {-2}}
P.SHIELD = {RightShoulder = {120, 0, -30}, RightElbow = {80}, LeftShoulder = {125, 0, 30}, LeftElbow = {85}, Waist = {8}, Neck = {-14},
	LeftHip = {-20, 0, -6}, LeftKnee = {-20}, RightHip = {25, 0, 6}, RightKnee = {-40}}
P.DOWN = {RightShoulder = {-30, 0, 70}, LeftShoulder = {-20, 0, -80}, RightElbow = {20}, LeftElbow = {30}, Grip = {-90},
	RightHip = {10, 0, 14}, LeftHip = {-6, 0, -18}, RightKnee = {-25}, LeftKnee = {-8}, Neck = {-12}}
P.RISE = {Waist = {-40}, Neck = {-10}, RightHip = {70, 0, 10}, RightKnee = {-110}, LeftHip = {40, 0, -12}, LeftKnee = {-70},
	RightShoulder = {-40, 0, 30}, RightElbow = {30}, Grip = {-120}, LeftShoulder = {-50, 0, -30}, LeftElbow = {20}}
P.KNEEL = {RightHip = {90, 0, 6}, RightKnee = {-95}, LeftHip = {-5, 0, -6}, LeftKnee = {-100}, Waist = {-22}, Neck = {-14},
	RightShoulder = {30, 0, 20}, RightElbow = {40}, Grip = {-150}, LeftShoulder = {35, 0, -10}, LeftElbow = {70}}
P.CAST = {RightShoulder = {10, 0, 20}, RightElbow = {30}, Grip = {-80}, LeftShoulder = {95, 0, -10}, LeftElbow = {10}, Waist = {-4, 20, 0}, Root = {0, -20, 0},
	LeftHip = {26, 0, -8}, LeftKnee = {-34}, RightHip = {-16, 0, 8}, RightKnee = {-22}}
P.FIREBALL = {RightShoulder = {172, 0, -12}, RightElbow = {24}, LeftShoulder = {172, 0, 12}, LeftElbow = {24}, Waist = {14}, Neck = {-18},
	RightHip = {30, 0, 6}, RightKnee = {-80}, LeftHip = {-10, 0, -6}, LeftKnee = {-60}}
P.THROW = {RightShoulder = {40, 0, -10}, RightElbow = {10}, LeftShoulder = {44, 0, 10}, LeftElbow = {10}, Waist = {-38}, Neck = {22},
	RightHip = {60, 0, 6}, RightKnee = {-50}, LeftHip = {30, 0, -6}, LeftKnee = {-80}}
P.REACH = {Waist = {-52}, Neck = {20}, RightShoulder = {120, 0, -10}, RightElbow = {10}, LeftShoulder = {110, 0, 10}, LeftElbow = {20},
	LeftHip = {60, 0, -8}, LeftKnee = {-80}, RightHip = {-30, 0, 8}, RightKnee = {-30}}
P.PULLED = {RightShoulder = {170, 0, -20}, LeftShoulder = {170, 0, 20}, RightElbow = {20}, LeftElbow = {20}, Neck = {-20}, Waist = {6}}

-- la Faucheuse (mêmes noms d'articulations que le modèle : Root, Neck, Jaw, épaules, coudes, poignets, Grip = la faux)
local R = {}
R.IDLE = {RightShoulder = {6, 0, 4}, RightElbow = {8}, Grip = {-10, 0, -6}, LeftShoulder = {10, 0, -6}, LeftElbow = {18}, Neck = {4}, Jaw = {6}, Root = {-3}}
R.ROAR = {Root = {14}, Neck = {-18}, Jaw = {32}, RightShoulder = {20, 0, 50}, RightElbow = {20}, Grip = {-20, 0, 20}, LeftShoulder = {30, 0, -60}, LeftElbow = {40}, LeftWrist = {-30}}
R.SWEEP_WIND = {Root = {4, -55, 0}, Neck = {6, 30, 0}, RightShoulder = {50, 0, 60}, RightElbow = {30}, Grip = {-100, 0, 0}, LeftShoulder = {30, 0, -30}, LeftElbow = {40}, Jaw = {18}}
R.SWEEP = {Root = {-14, 70, 0}, Neck = {8, -30, 0}, RightShoulder = {60, 0, -20}, RightElbow = {10}, Grip = {-108, 0, 0}, LeftShoulder = {-20, 0, -50}, LeftElbow = {20}, Jaw = {26}}
R.SLAM_WIND = {Root = {12}, Neck = {-10}, RightShoulder = {165, 0, -10}, RightElbow = {20}, Grip = {30, 0, 0}, LeftShoulder = {150, 0, 20}, LeftElbow = {30}, Jaw = {22}}
R.SLAM = {Root = {-26}, Neck = {16}, RightShoulder = {48, 0, -8}, RightElbow = {6}, Grip = {-96, 0, 0}, LeftShoulder = {40, 0, 10}, LeftElbow = {20}, Jaw = {30}}
R.BLOCK = {Root = {4}, RightShoulder = {70, 0, -40}, RightElbow = {40}, Grip = {-10, 0, 70}, LeftShoulder = {80, 0, 40}, LeftElbow = {50}, Jaw = {10}}
R.CAST = {Root = {6, 20, 0}, Neck = {-6, -16, 0}, RightShoulder = {0, 0, 20}, RightElbow = {10}, Grip = {-6, 0, -10}, LeftShoulder = {110, 0, -10}, LeftElbow = {20}, LeftWrist = {-40}, Jaw = {24}}
R.NOVA = {Root = {16}, Neck = {-24}, Jaw = {36}, RightShoulder = {30, 0, 80}, RightElbow = {20}, Grip = {-30, 0, 30}, LeftShoulder = {30, 0, -85}, LeftElbow = {20}, LeftWrist = {-30}}
R.RECOIL = {Root = {22, 12, 6}, Neck = {-20, 24, 10}, Jaw = {28}, RightShoulder = {-20, 0, 40}, RightElbow = {20}, Grip = {-30, 0, 20}, LeftShoulder = {-30, 0, -50}, LeftElbow = {30}}
R.FALLEN = {Root = {-10}, Neck = {30}, Jaw = {14}, RightShoulder = {70, 0, 30}, RightElbow = {30}, Grip = {-80, 0, 40}, LeftShoulder = {80, 0, -30}, LeftElbow = {40}}

-- flottement : la robe ondule d'un étage à l'autre, le halo et le cœur tournent (vitesses réglables : a.haloSpeed, a.coreSpeed)
Kit.Gaits.reaperFloat = {stride = 9, idleRate = 1.6, fn = function(p, a)
	local now = Kit.time
	local dt = now - (a.floatT or now)
	a.floatT = now
	a.halo = (a.halo or 0) + dt * (a.haloSpeed or 20)
	a.core = (a.core or 0) + dt * (a.coreSpeed or 70)
	a.sink = -sin(p * 0.8) * 0.5
	local function sway(k) return sin(p * 1.2 - k * 0.7) end
	return {Core = {a.core * 0.6, a.core, 0}, Halo = {0, 0, a.halo},
		Robe1 = {sway(0) * 2.5, 0, sway(0.5) * 2}, Robe2 = {sway(1) * 3.5, 0, sway(1.5) * 3},
		Robe3 = {sway(2) * 4.5, 0, sway(2.5) * 4}, Robe4 = {sway(3) * 6, 0, sway(3.5) * 5},
		CapeR = {10 + sway(1) * 7, 0, -4 + sway(2) * 3}, CapeL = {10 + sway(1.6) * 7, 0, 4 + sway(2.4) * 3}}
end}

local ELEMENT = {
	Rex = {name = "fire", color = FIRE, hit = "Fire-Slash-01", flare = "Fire-02", aura = "Fire-Aura-01"},
	Kino = {name = "ice", color = ICE, hit = "Shiny-01", flare = "Splash-01", aura = "Water-Aura-01"},
	Nono = {name = "wind", color = WIND, hit = "Wind-01", flare = "Wind-02", aura = "Water-Aura-01"},
}

local playing = false
---------------------------------------------------------------- déroulé
function M.play(o)
	o = o or {}
	if playing then return false, "already playing" end
	playing = true
	local scene = film:WaitForChild("Set"):Clone()
	scene.Name = "FightFilmScene"
	scene:PivotTo(CFrame.new(ORIGIN))
	scene.Parent = workspace
	local blockers = {}
	for _, d in scene:GetDescendants() do
		if d:IsA("BasePart") and d:GetAttribute("Blocker") then table.insert(blockers, d) end
	end

	-- éclairage : le même que le film du samouraï, réimposé à chaque image (le cycle jour/nuit du serveur l'écrase sinon)
	local FILM_LIGHTING = Samurai.LIGHT
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
		local rigs = ReplicatedStorage:WaitForChild("ReaperCutscene"):WaitForChild("Rigs")
		local CAMP, RPOS = g(-2, 0), g(13, 0)

		------------------------------------------------ petits outils de mise en scène
		local function dust(pos, scale) Fx.burst("Smoke-01", pos + V(0, 0.4, 0), {scale = scale or 0.6}) end
		local function leaves(pos, n, spread)
			if Kit.fast() then return end
			for i = 1, n or 4 do
				local p = Instance.new("Part")
				p.Size = V(0.5, 0.05, 0.4)
				p.Color = ({rgb(190, 86, 20), rgb(140, 60, 16), rgb(214, 130, 30)})[i % 3 + 1]
				p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
				p.Parent = scene
				local a = math.random() * 6.283
				local r = (spread or 1) * (1.5 + math.random() * 2)
				local to = pos + V(cos(a) * r, 0.1, sin(a) * r)
				local spin = CFrame.Angles(math.random() * 6, math.random() * 6, math.random() * 6)
				local h = 1.2 + math.random() * 1.6
				Kit.tween(0.7 + math.random() * 0.4, function(e, u)
					p.CFrame = CFrame.new(pos:Lerp(to, e) + V(0, h * 4 * u * (1 - u), 0)) * spin * CFrame.Angles(u * 9, u * 7, 0)
				end, "outQuad", function() p:Destroy() end)
			end
		end
		local function swoosh(pos, normal, color, size, time)
			local cf = CFrame.lookAt(pos, pos + normal) * CFrame.Angles(rad(90), 0, 0)
			Fx.mesh("Shock", cf, {color = color or WHITE, size0 = 0.25 * (size or 1), size1 = 1.5 * (size or 1), time = time or 0.22, transp0 = 0.15})
		end
		local function ring(pos, color, size, time)
			Fx.mesh("Shockwave", CFrame.new(pos + V(0, 0.4, 0)), {color = color or WHITE, size0 = 0.2, size1 = size or 3, time = time or 0.5, transp0 = 0.2})
		end
		local function clash(pos, power, color)
			power = power or 1
			Fx.burst("Slash-Impact-01", pos, {scale = 0.8 * power, color = color})
			Fx.burst("Punch-01", pos, {scale = 1.4 * power})
			Fx.light(pos, color or rgb(255, 230, 170), 18 * power, 6, 0.3)
			Kit.snd(S.Clang, 0.55 + 0.2 * min(power, 2), 0.9 + math.random() * 0.25)
			Kit.shake(0.35 * power)
			Kit.hitstop(0.05 + 0.03 * min(power, 2))
		end
		-- coup qui touche ; stop = false : aucun arrêt sur image (enchaînements continus)
		local function wound(target, pos, power, color, stop)
			power = power or 1
			Fx.burst("Slash-Impact-01", pos, {scale = 1.1 * power, color = color})
			Fx.burst("Slashes-01", pos, {scale = 0.9 * power})
			Fx.light(pos, color or WHITE, 16 * power, 5, 0.3)
			Kit.snd(SLASH_HIT, 0.7, 0.95 + math.random() * 0.2)
			target:hit(1.2 * power)
			Kit.shake(0.4 * power)
			if stop ~= false then
				Kit.punch(-5 * power)
				Kit.hitstop(0.06 + 0.04 * min(power, 2))
			end
		end
		local function dash(actor, to, dur, color, lines)
			Kit.snd(S.Lunge, 0.5, 1.1)
			if lines then Kit.speedLines(dur + 0.2, 0.5) end
			Fx.burst("Wind-02", actor:center(-1), {scale = 1.2 * min(actor.scale, 2)})
			actor:move(to, dur, "outCubic")
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				Kit.ghost(actor, color, 0.3, 0.5)
				Kit.wait(min(dur / 4, max(dur - (Kit.time - t0), 0.001)))
			end
			dust(to, 0.7 * min(actor.scale, 2.5))
		end
		local function skid(actor, from, dist, dur, pose)
			local away = flat(actor.pos - from)
			local to = actor.pos + away * dist
			dur = dur or 0.45
			if pose then actor:to(pose, 0.12, "outQuad") end
			actor:move(to, dur, "outCubic")
			Kit.fork(function()
				for _ = 1, max(3, math.floor(dur / 0.07)) do
					Kit.wait(0.07)
					dust(actor.pos, 0.55 * min(actor.scale, 2.5))
					leaves(actor.pos, 1)
				end
			end)
			return to
		end
		-- plan large en plongée sur un groupe d'acteurs ; lookY = hauteur visée, cap = distance maximale
		local function wide(actors, angle, height, extra, drift, lookY, cap, fov)
			return function(t)
				local sum, count = Vector3.zero, 0
				for _, a in actors do if a.alive then sum += a.pos count += 1 end end
				local mid = count > 0 and sum / count or CAMP
				local reach = 0
				for _, a in actors do if a.alive then reach = max(reach, ((a.pos - mid) * FLAT).Magnitude) end end
				local ang = rad(angle) + (drift or 0) * t
				local dist = min(9 + reach * 1.5 + (extra or 0), cap or 26)
				return Kit.look(V(mid.X + cos(ang) * dist, ORIGIN.Y + (height or 7), mid.Z + sin(ang) * dist), V(mid.X, ORIGIN.Y + (lookY or 1.6), mid.Z), fov or 50)
			end
		end

		------------------------------------------------ glace : cristaux en blocs à studs qui jaillissent du sol
		local ices = {}
		local function iceSpike(pos, h, lean, o)
			o = o or {}
			local model = Instance.new("Model")
			model.Name = "Ice"
			local w = o.width or max(0.9, h * 0.34)
			local up = (V(0, h, 0) + (lean or Vector3.zero)).Unit
			local cf = CFrame.lookAt(pos, pos + up) * CFrame.Angles(rad(-90), 0, 0) * CFrame.Angles(0, math.random() * 6.28, 0)
			local function piece(class, size, offset, color, neon)
				local p = Instance.new(class)
				p.Size = size
				p.Color = color
				p.Material = neon and Enum.Material.Neon or Enum.Material.Plastic
				if not neon and class == "Part" then pcall(function() p.MaterialVariant = "Studs" end) end
				p.Transparency = neon and 0.25 or 0.08
				p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
				p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
				p.CFrame = cf * offset
				p.Parent = model
				return p
			end
			piece("Part", V(w, h * 0.55, w), CFrame.new(0, h * 0.275, 0), rgb(34, 88, 160))
			piece("Part", V(w * 0.72, h * 0.3, w * 0.72), CFrame.new(0, h * 0.7, 0), rgb(52, 122, 196))
			piece("WedgePart", V(w * 0.72, h * 0.16, w * 0.36), CFrame.new(0, h * 0.93, w * 0.18), rgb(96, 170, 226))
			piece("WedgePart", V(w * 0.72, h * 0.16, w * 0.36), CFrame.new(0, h * 0.93, -w * 0.18) * CFrame.Angles(0, rad(180), 0), rgb(96, 170, 226))
			piece("Part", V(w * 0.3, h * 0.5, w * 0.3), CFrame.new(w * 0.52, h * 0.22, w * 0.2) * CFrame.Angles(0, 0, rad(-14)), rgb(44, 104, 178))
			piece("Part", V(w * 0.1, h * 0.6, w * 0.1), CFrame.new(0, h * 0.42, -w * 0.52), ICE, true) -- une veine de lumière, pas plus
			model.Parent = scene
			local rest = model:GetPivot()
			local hidden = rest - up * (h + 0.6)
			model:PivotTo(hidden)
			Kit.tween(o.time or 0.16, function(e) model:PivotTo(hidden:Lerp(rest, e)) end, "outBack")
			if not o.quiet then
				Fx.burst("Shiny-01", pos + up * h * 0.6, {scale = 0.35 + h * 0.05, color = ICE})
				Fx.light(pos + V(0, 1.5, 0), ICE, 10 + h, 1, 0.5)
			end
			table.insert(ices, model)
			return model
		end
		local function shatter(model, power)
			local i = table.find(ices, model)
			if i then table.remove(ices, i) end
			if not model.Parent then return end
			Fx.burst("Shield-Break-01", model:GetPivot().Position + V(0, 1.5, 0), {scale = 0.8 * (power or 1), color = ICE})
			for _, p in model:GetChildren() do
				if p:IsA("BasePart") then
					local from, t0 = p.CFrame, p.Transparency
					local dir = V(math.random() - 0.5, 0.5 + math.random() * 0.8, math.random() - 0.5).Unit * (4 + math.random() * 5) * (power or 1)
					Kit.tween(0.55 + math.random() * 0.25, function(e, u)
						p.CFrame = (from + dir * e - V(0, 9 * u * u, 0)) * CFrame.Angles(u * 5, u * 7, u * 3)
						p.Transparency = t0 + (1 - t0) * u
					end, "outQuad")
				end
			end
			Kit.delay(0.9, function() model:Destroy() end)
		end
		local function shatterAll(power) for i = #ices, 1, -1 do shatter(ices[i], power) end end
		-- ligne de cristaux de plus en plus hauts ; renvoie quand le dernier a jailli
		local function iceLine(from, to, n, h0, h1, step)
			local dir = flat(to - from)
			for i = 1, n do
				local u = (i - 1) / max(n - 1, 1)
				local side = V(-dir.Z, 0, dir.X) * ((i % 2 == 0) and 0.7 or -0.7)
				iceSpike(from:Lerp(to, u) + side, h0 + (h1 - h0) * u, dir * (0.8 + u * 1.6))
				if i % 2 == 1 then Kit.snd(S.Snap, 0.35, 1.6 + u * 0.6) end
				Kit.wait(step or 0.045)
			end
		end
		local function iceWall(center, facing, width, height)
			local dir = flat(facing - center)
			local side = V(-dir.Z, 0, dir.X)
			local made = {}
			for i = -2, 2 do
				table.insert(made, iceSpike(center + side * (i * width / 5), height * (1 - math.abs(i) * 0.12), dir * 0.6, {width = width / 4.4, quiet = i ~= 0}))
			end
			Kit.snd(S.Snap, 0.6, 1.2)
			return made
		end

		------------------------------------------------ vague élémentaire qui file au sol (feu, vent, âmes)
		local function wave(from, to, dur, color, flare, done)
			local dir = flat(to - from)
			local carrier = Instance.new("Part")
			carrier.Size = V(1, 1, 1)
			carrier.Transparency = 1
			carrier.Anchored, carrier.CanCollide, carrier.CanQuery, carrier.CanTouch = true, false, false, false
			carrier.Parent = scene
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = color, 26, 5, false
			l.Parent = carrier
			local f1 = Fx.attach(flare, carrier, {scale = 1.8})
			local last = -1
			Kit.tween(dur, function(e)
				local p = from:Lerp(to, e) + V(0, 2.2, 0)
				carrier.CFrame = CFrame.lookAt(p, p + dir)
				if e - last > 0.14 then
					last = e
					Fx.mesh("Shock", CFrame.lookAt(p, p + dir) * CFrame.Angles(0, 0, rad(90)) * CFrame.Angles(rad(90), 0, 0), {color = color, size0 = 0.8, size1 = 1.6, time = 0.25, transp0 = 0.1})
					Fx.burst(flare, p - V(0, 1.6, 0), {scale = 1.1, time = 0.4})
				end
			end, "linear", function()
				f1.stop()
				Kit.delay(1, function() carrier:Destroy() end)
				if done then done(to) end
			end)
		end

		------------------------------------------------ distribution : trois sabreurs
		local function swordsman(role)
			local element = ELEMENT[role]
			local rig = rigs:WaitForChild(role, 20):Clone()
			for _, p in rig:GetChildren() do -- une peau très claire sature sous les lumières du décor : un ton plus bas
				if p:IsA("MeshPart") and p.Name ~= "Head" and p.Color.R > 0.9 and p.Color.G > 0.9 and p.Color.B > 0.9 then p.Color = rgb(176, 172, 186) end
			end
			for _, c in rig:GetChildren() do
				if c:IsA("Shirt") or c:IsA("Pants") then c.Color3 = rgb(165, 165, 176) end -- un rouge vif devient une tache unie sous les lumières
			end
			rig.Parent = scene
			local hrp0 = rig.HumanoidRootPart
			local function rel(part, att) return hrp0.CFrame:PointToObjectSpace(rig[part][att].WorldPosition) end
			local SH, EL = rel("RightUpperArm", "RightShoulderRigAttachment"), rel("RightLowerArm", "RightElbowRigAttachment")
			local HAND = hrp0.CFrame:PointToObjectSpace(rig.RightHand.Position)
			local a = Kit.actor(rig, role)
			local hand = rig.RightHand
			local h = {a = a, rig = rig, role = role, element = element, color = element.color}
			local function handAt(sx, sy, sz, ex)
				return SH + CFrame.Angles(rad(sx), rad(sy), rad(sz)):VectorToWorldSpace((EL - SH) + CFrame.Angles(rad(ex), 0, 0):VectorToWorldSpace(HAND - EL))
			end
			function h.reach(target) -- angles d'épaule et de coude pour amener la main droite sur un point (repère du buste)
				local best, bestD = {0, 0, 0, 0}, math.huge
				for sx = -60, 190, 10 do for sz = -120, 110, 10 do for sy = -60, 60, 20 do for ex = 0, 140, 10 do
					local d = (handAt(sx, sy, sz, ex) - target).Magnitude + math.abs(sy) * 0.002
					if d < bestD then best, bestD = {sx, sy, sz, ex}, d end
				end end end end
				return {RightShoulder = {best[1], best[2], best[3]}, RightElbow = {best[4]}}
			end
			-- fourreau à la hanche gauche, katana dedans
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
			local held, blend = false, nil
			a.joints.Grip = function(cf)
				if not held then return end
				local target = gripBase * cf * gripTail
				if blend then
					local u = clamp((Kit.time - blend.t0) / blend.dur, 0, 1)
					target = blend.from:Lerp(target, u * u * (3 - 2 * u))
					if u >= 1 then blend = nil end
				end
				kw.C0 = target
			end
			a.val.Grip = {0, 0, 0}
			function h.grab(dur)
				local world = kRoot.CFrame
				kw.Part0 = hand
				blend = {from = hand.CFrame:ToObjectSpace(world), t0 = Kit.time, dur = dur or 0.25}
				kw.C0 = blend.from
				held = true
			end
			function h.sheath(dur)
				local from = scabRoot.CFrame:ToObjectSpace(kRoot.CFrame)
				held = false
				kw.Part0 = scabRoot
				kw.C0 = from
				Kit.tween(dur or 0.4, function(e) kw.C0 = from:Lerp(CFrame.new(), e) end, "inOut")
			end
			function h.handle() return hrp0.CFrame:PointToObjectSpace((scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position) end
			h.trail = Fx.bladeTrail(blade, V(0, 0, 1.6), V(0, 0, -2.1), element.color)
			function h.tip(back) return (blade.CFrame * CFrame.new(0, 0, -(back or 1.2))).Position end
			h.blade, h.scabRoot = blade, scabRoot
			-- le sabre et le fourreau suivent la visibilité du personnage
			for _, m in {katana, scab} do
				for _, p in m:GetDescendants() do if p:IsA("BasePart") then p.Parent = rig end end
			end
			return h
		end
		local rex, kino, nono = swordsman("Rex"), swordsman("Kino"), swordsman("Nono")
		local team = {rex, kino, nono}

		local function hitFx(h, pos, power)
			Fx.burst(h.element.hit, pos, {scale = 1.2 * (power or 1), color = h.element.name ~= "fire" and h.color or nil})
			Fx.light(pos, h.color, 20, 5, 0.3)
		end
		local function slash(h, windup, strike, opts)
			opts = opts or {}
			local a = h.a
			if windup then
				a:to(windup, opts.wind or 0.13, "outCubic")
				Kit.wait(opts.wind or 0.13)
			end
			h.trail.Enabled = true
			Kit.snd(S.Swing, 0.5, 1 + math.random() * 0.25)
			a:to(strike, opts.cut or 0.09, "outQuart", {lag = false})
			Kit.wait((opts.cut or 0.09) * 0.55)
			swoosh(a:center(0.6) + (CFrame.Angles(0, a.yaw, 0) * V(0, 0, -2.2)), opts.normal or V(0.15, 1, 0), h.color, opts.size)
			if opts.hit then opts.hit() end
			Kit.wait((opts.cut or 0.09) * 0.45)
			Kit.delay(0.14, function() h.trail.Enabled = false end)
		end
		-- ruée : bien plus vite qu'une course, silhouettes de la couleur du pouvoir, traits de vitesse
		local function rush(h, to, dur, lines)
			local a = h.a
			a.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, RightWrist = true}
			a:to(H.RUNARM, 0.08, "outQuad", {only = true})
			a:gait("heroRun", 0.06, function() dust(a.pos, 0.5) leaves(a.pos, 2) end)
			if lines ~= false then Kit.speedLines(dur + 0.15, 0.5) end
			Kit.snd(S.Lunge, 0.45, 1.2)
			Fx.burst("Wind-02", a:center(-1), {scale = 1.2})
			a:move(to, dur, "inOut", {face = true, faceTime = 0.08})
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				Kit.ghost(a, h.color, 0.28, 0.55)
				Kit.wait(min(0.045, max(dur - (Kit.time - t0), 0.001)))
			end
			a:gait(nil, 0.08)
		end
		-- projeté : il vole en tournant, retombe sur le dos et glisse
		local function blowBack(h, from, dist, dur, arc)
			local a = h.a
			local away = flat(a.pos - from)
			local to = V(a.pos.X, ORIGIN.Y, a.pos.Z) + away * dist
			a:gait(nil, 0.05)
			a.idle = 0
			a:watch(nil)
			a:to(P.DOWN, 0.2, "outQuad")
			a:body({air = 1}, 0.05)
			a:body({yaw = Kit.yawTo(a.pos, a.pos - away)}, 0.1)
			a:move(to, dur, "outQuad", {arc = arc or 4})
			a:body({pitch = 1.45 + math.pi * 2, lift = -(a.stand - 0.75)}, dur, "outQuad")
			Kit.fork(function() for _ = 1, 5 do Kit.ghost(a, h.color, 0.3, 0.6) Kit.wait(dur / 6) end end)
			Kit.delay(dur, function()
				a:body({pitch = 1.45}, 0)
				a:move(to + away * 2.5, 0.4, "outCubic")
				dust(to, 1.1) leaves(to, 6) Kit.snd(S.Thud, 0.6, 0.7) Kit.shake(0.35)
				Kit.fork(function() for _ = 1, 4 do Kit.wait(0.08) dust(a.pos, 0.6) end end)
			end)
			return to + away * 2.5
		end
		-- se relève : s'assoit, un genou à terre, debout
		local function getUp(h, dur, final)
			local a = h.a
			dur = dur or 1.5
			a:body({pitch = 0, lift = 0}, dur * 0.45, "inOut")
			a:to(P.RISE, dur * 0.4, "inOut")
			Kit.delay(dur * 0.42, function() a:body({air = 0}, 0.1) a:to(P.KNEEL, dur * 0.3, "inOut") end)
			Kit.delay(dur * 0.78, function() a.idle = 1 a:to(final or H.FATIGUE, dur * 0.25, "inOut") end)
		end

		------------------------------------------------ la Faucheuse
		local reaperModel = film:WaitForChild("HollowReaper"):Clone()
		reaperModel.Name = "Reaper"
		reaperModel.Parent = scene
		local reaper = Kit.actor(reaperModel, "reaper")
		reaper:place(RPOS, CAMP)
		reaper.lift = -34
		reaper:to(R.IDLE, 0)
		reaper:gait("reaperFloat", 0)
		reaper.seed = 17
		local function mark(name) return reaperModel[name].Position end
		local coreLight = reaperModel.Core:FindFirstChild("CoreLight")

		------------------------------------------------ feu de camp et sièges
		local camp = Instance.new("Model")
		camp.Name = "Campfire"
		local function block(size, cf, color, o)
			o = o or {}
			local p = Instance.new(o.wedge and "WedgePart" or "Part")
			p.Size, p.CFrame, p.Color = size, cf, color
			p.Material = o.neon and Enum.Material.Neon or Enum.Material.Plastic
			if not o.neon and not o.wedge then pcall(function() p.MaterialVariant = "Studs" end) end
			p.TopSurface, p.BottomSurface = Enum.SurfaceType.Smooth, Enum.SurfaceType.Smooth
			p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch = true, false, false, false
			p.CastShadow = not o.neon
			p.Parent = camp
			return p
		end
		for k = 0, 7 do
			local a = k * math.pi / 4
			block(V(1.1, 0.7, 0.8), CFrame.new(CAMP + V(cos(a) * 1.9, 0.35, sin(a) * 1.9)) * CFrame.Angles(0, -a, 0), k % 2 == 0 and rgb(92, 90, 104) or rgb(70, 68, 82))
		end
		for k = 0, 2 do
			block(V(0.5, 0.5, 2.6), CFrame.new(CAMP + V(0, 0.55 + k * 0.12, 0)) * CFrame.Angles(0, k * math.pi / 3, rad(12)), rgb(74, 44, 28))
		end
		local flames = {}
		for k = 0, 2 do
			flames[k + 1] = block(V(0.7 - k * 0.15, 1.4 - k * 0.2, 0.7 - k * 0.15), CFrame.new(CAMP + V((k - 1) * 0.35, 1.3 + k * 0.25, (k % 2) * 0.3)) * CFrame.Angles(rad(45), 0, rad(45)), ({rgb(255, 170, 50), rgb(255, 120, 30), rgb(255, 220, 120)})[k + 1], {neon = true})
		end
		local fireLight = Instance.new("PointLight")
		fireLight.Name = "CampLight"
		fireLight.Color, fireLight.Range, fireLight.Brightness, fireLight.Shadows = rgb(255, 150, 60), 30, 2.2, true
		fireLight.Parent = flames[1]
		local SEAT = {Rex = CAMP + V(-2.6, 0, -3.5), Nono = CAMP + V(-2.6, 0, 3.5), Kino = CAMP + V(4.2, 0, 0.4)}
		for _, pos in SEAT do
			local back = flat(pos - CAMP)
			block(V(1.3, 1.25, 2.8), CFrame.lookAt(pos + back * 0.25 + V(0, 0.62, 0), pos + back * 2 + V(0, 0.62, 0)) * CFrame.Angles(0, rad(90), 0), rgb(84, 52, 32))
		end
		camp.Parent = scene
		local function scatterCamp() -- le souffle emporte les pierres, les bûches et les sièges
			for _, part in camp:GetChildren() do
				if part:IsA("BasePart") then
					local from, t0 = part.CFrame, part.Transparency
					local dir = flat(part.Position - RPOS) * (10 + math.random() * 10) + V(0, 0, (math.random() - 0.5) * 12)
					local hop = 3 + math.random() * 4
					Kit.tween(0.8 + math.random() * 0.3, function(e, u)
						part.CFrame = (from + dir * e + V(0, hop * 4 * u * (1 - u), 0)) * CFrame.Angles(u * 7, u * 5, u * 3)
						part.Transparency = t0 + (1 - t0) * max(0, (u - 0.6) / 0.4)
					end, "outQuad")
				end
			end
			Kit.delay(1.3, function() camp:Destroy() end)
		end
		local campFire = Fx.attach("Fire-01", flames[1], {scale = 0.9})
		local fireOn = true

		------------------------------------------------ ambiance : citrouilles qui vacillent, chauves-souris, feux follets, lumière d'appoint
		local flickerAmp, flickers, bats, wisps, grassBlades = 1, {}, {}, {}, {}
		for _, d in scene:GetDescendants() do
			if d:IsA("PointLight") and d.Name == "Flicker" then table.insert(flickers, {d, d.Brightness, math.random() * 50})
			elseif d:IsA("Model") and d.Name == "Bat" then table.insert(bats, d)
			elseif d:IsA("BasePart") and d.Name == "Wisp" then table.insert(wisps, {d, d.Position})
			elseif d:IsA("BasePart") and d.Name == "Blade" and d.Parent.Name == "Grass" then table.insert(grassBlades, d) end
		end
		local fill = Instance.new("Part")
		fill.Name = "FillLight"
		fill.Size = V(1, 1, 1)
		fill.Transparency = 1
		fill.Anchored, fill.CanCollide, fill.CanQuery, fill.CanTouch = true, false, false, false
		fill.Parent = scene
		local fillLight = Instance.new("PointLight")
		fillLight.Color, fillLight.Range, fillLight.Brightness, fillLight.Shadows = rgb(200, 215, 255), 46, 0.6, false
		fillLight.Parent = fill
		Kit.fork(function()
			while Kit.running do
				local t = Kit.time
				applyLighting()
				local camCF = workspace.CurrentCamera.CFrame
				fill.CFrame = camCF * CFrame.new(0, 1.5, 2)
				for _, b in grassBlades do
					local near = (b.Position - camCF.Position).Magnitude < 5
					if near ~= (b.LocalTransparencyModifier == 1) then b.LocalTransparencyModifier = near and 1 or 0 end
				end
				for _, f in flickers do
					if f[1].Parent then f[1].Brightness = f[2] * (0.8 + 0.2 * math.noise(t * 4, f[3])) * (1 + (flickerAmp - 1) * (0.5 + 0.5 * sin(t * 23 + f[3]))) end
				end
				if fireOn then fireLight.Brightness = 2.2 * (0.85 + 0.15 * math.noise(t * 6, 3.3)) end
				for _, bat in bats do
					if bat.Parent then
						local r, hh, sp, ph = bat:GetAttribute("Radius"), bat:GetAttribute("Height"), bat:GetAttribute("Speed"), bat:GetAttribute("Phase")
						local a = ph + t * sp
						local pos = g(cos(a) * r, sin(a) * r, hh + sin(t * 1.3 + ph) * 3)
						local cf = CFrame.lookAt(pos, pos + V(-sin(a) * sp, 0, cos(a) * sp))
						local flap = sin(t * 16 + ph) * 0.9
						bat.Body.CFrame = cf
						bat.WingR.CFrame = cf * CFrame.new(0.3, 0, 0) * CFrame.Angles(0, 0, flap) * CFrame.new(0.85, 0, 0)
						bat.WingL.CFrame = cf * CFrame.new(-0.3, 0, 0) * CFrame.Angles(0, 0, -flap) * CFrame.new(-0.85, 0, 0)
					end
				end
				for i, w in wisps do
					if w[1].Parent then w[1].CFrame = CFrame.new(w[2] + V(sin(t * 0.6 + i) * 2, sin(t * 1.1 + i * 2) * 1.2, cos(t * 0.5 + i) * 2)) * CFrame.Angles(t, t * 1.3, 0) end
				end
				task.wait()
			end
		end)

		-- la forêt soufflée : les arbres basculent vers l'extérieur l'un après l'autre, lanternes et citrouilles s'envolent
		local function breakForest(center, speed)
			local list = {}
			for _, name in {"TreesNear", "TreesFar", "Lanterns", "Pumpkins"} do
				local f = scene:FindFirstChild(name)
				if f then for _, m in f:GetChildren() do if m:IsA("Model") then table.insert(list, m) end end end
			end
			for _, m in list do
				local cf0 = m:GetPivot()
				local cfb, size = m:GetBoundingBox()
				local base = V(cfb.Position.X, ORIGIN.Y, cfb.Position.Z)
				local d = ((base - center) * FLAT).Magnitude
				local away = flat(base - center)
				local small = size.Y < 12
				local axis = V(away.Z, 0, -away.X)
				local angle = small and rad(220 + math.random() * 260) or rad(70 + math.random() * 16)
				local push = small and (12 + math.random() * 16) or (1.5 + math.random() * 3)
				Kit.delay(d / (speed or 100), function()
					if not m.Parent then return end
					for _, l in m:GetDescendants() do if l:IsA("Light") then l.Enabled = false end end
					Kit.tween(small and 1.0 or 1.6, function(e, u)
						local hop = small and V(0, 7 * 4 * u * (1 - u), 0) or Vector3.zero
						m:PivotTo(CFrame.new(base + away * push * e + hop) * CFrame.fromAxisAngle(axis, angle * e) * CFrame.new(-base) * cf0)
					end, small and "outQuad" or "inQuad", function()
						if not small then dust(base + away * 12, 2.4) Kit.shake(0.25) end
					end)
					if not small then leaves(base, 6, 3) Kit.snd(S.Snap, 0.45, 0.5 + math.random() * 0.2) end
				end)
			end
		end

		------------------------------------------------ pouvoirs : allumage des lames
		local function ignite(h)
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = h.color, 14, 1.2, false
			l.Parent = h.blade
			h.light = l
			if h.element.name == "fire" then
				h.bladeFx = Fx.attach("Fire-01", h.blade, {offset = CFrame.new(0, 0, -1.2), scale = 0.7})
			elseif h.element.name == "ice" then
				h.bladeFx = Fx.attach("Shiny-01", h.blade, {pulse = true, scale = 0.8, color = ICE})
			else
				h.bladeFx = Fx.attach("Shiny-01", h.blade, {pulse = true, scale = 0.6, color = WIND})
			end
			Fx.burst(h.element.flare, h.a.pos + V(0, 0.6, 0), {scale = 1.2, color = h.element.name ~= "fire" and h.color or nil})
			ring(h.a.pos, h.color, 2.6, 0.5)
			Fx.light(h.a:center(0.5), h.color, 26, 2, 0.6)
		end

		------------------------------------------------ 0 - 10 s : le feu de camp (dialogue court)
		for role, h in {Rex = rex, Kino = kino, Nono = nono} do
			h.a:place(SEAT[role], CAMP)
			h.a:to(P.SIT, 0)
			h.a:watch(CAMP + V(0, 1.2, 0), 0.5)
		end
		task.wait(0.1)
		local wind = loop(S.Ghost, 0.04, 0.5)
		local music = loop(MUSIC_CALM, 0.16, 1)
		Kit.camSubject = nil
		Kit.cam(function(t) return Kit.look(CAMP + V(-12.5 + 0.4 * t, 5.2, 0.6), CAMP + V(1.5, 1.2, 0), 46) end)
		Kit.bars(true, 1)
		if not o.ffTo then
			Kit.paused = true
			task.wait(time() < 45 and 4 or 2.2)
			Kit.paused = false
		end
		Kit.fade(1, 1.2)
		Kit.at(0.6)
		Kit.say("Nono275er:  This update is going to be huge.", 1.7)
		nono.a:to(merge(P.SIT, {RightShoulder = {70, 0, 60}, RightElbow = {30}, LeftShoulder = {70, 0, -60}, LeftElbow = {30}, Waist = {-2}, Neck = {-6}}), 0.3, "outBack")
		Kit.at(1.5) nono.a:to(P.SIT, 0.4, "inOut")
		Kit.at(2.4)
		Kit.say("kinoshi112:  Only if Rexy stops breaking the build.", 1.9)
		Kit.cam(function(t) return Kit.look(CAMP + V(0.2, 2.5, -2.6 + 0.2 * t), kino.a:center(1.0), 42) end, 0.4) -- depuis le feu : personne entre la camera et lui
		kino.a:watch(rex.a, 1)
		kino.a:to(merge(P.SIT, {RightShoulder = {82, 0, -20}, RightElbow = {8}, Waist = {-14, 14, 0}}), 0.3, "outBack")
		Kit.at(3.3) kino.a:to(P.SIT, 0.4, "inOut") nono.a:to(merge(P.SIT, {Waist = {-20}, Neck = {10}}), 0.3) -- Nono rit
		Kit.at(4.4)
		Kit.say("rexydev1:  No promises.", 1.1)
		Kit.cam(function(t) return Kit.look(CAMP + V(1.6, 2.6, -2.6), rex.a:center(1.1), 38) end, 0.3)
		rex.a:watch(kino.a, 1)
		rex.a:to(merge(P.SIT, {RightShoulder = {30, 0, 40}, RightElbow = {95}, LeftShoulder = {30, 0, -40}, LeftElbow = {95}, Neck = {-4, 0, 6}}), 0.25, "outBack") -- il hausse les épaules
		Kit.at(5.2) rex.a:to(P.SIT, 0.35, "inOut")
		Kit.at(5.6) -- le feu vire au violet, quelque chose approche
		Kit.snd(S.Ghost, 0.5, 0.6) Kit.snd(S.Snap, 0.6, 0.6)
		Kit.fadeSound(music, 0.04, 1)
		Kit.fadeSound(wind, 0.2, 1)
		flickerAmp = 2.6
		Kit.tween(0.6, function(e)
			fireLight.Color = rgb(255, 150, 60):Lerp(SOUL, e)
			for i, f in flames do f.Color = f.Color:Lerp(i == 3 and rgb(245, 225, 255) or SOUL, e) end
		end)
		campFire.stop()
		campFire = Fx.attach("Fire-01", flames[1], {scale = 1.1, color = SOUL})
		Kit.cam(function(t) return Kit.look(CAMP + V(-9, 3.2, 0.8), CAMP + V(6, 1.8, 0.2), 42) end, 0.5)
		for _, h in team do h.a:watch(RPOS + V(0, 3, 0), 1) end
		Kit.at(6.3)
		Kit.say("kinoshi112:  ...Did you hear that?", 1.1)
		kino.a:to(merge(P.SIT, {Waist = {-6, -50, 0}, Neck = {0, -40, 0}}), 0.35, "outBack")
		Kit.at(7.2) -- le sol s'ouvre sous kinoshi112
		Fx.burst("Crack-01", kino.a.pos + V(0, 0.15, 0), {scale = 1.6})
		Fx.burst("Portal-01", kino.a.pos + V(0, 0.4, 0), {scale = 1.3})
		Fx.burst("Hit-Purple", kino.a.pos + V(0, 1, 0), {scale = 1.2})
		Fx.light(kino.a.pos + V(0, 1, 0), SOUL, 24, 6, 0.8)
		Kit.snd(S.Thud, 0.8, 0.6) Kit.shake(0.6)
		Kit.cam(wide({kino.a, rex.a}, -70, 5.2, -2, 0.1, 1.2), 0.2)
		kino.a:watch(nil)
		kino.a:body({air = 1}, 0.05)
		kino.a:to(P.PULLED, 0.2, "outQuad")
		kino.a:body({lift = -3.6}, 0.5, "inQuad")
		Kit.fork(function() for _ = 1, 6 do Kit.wait(0.1) dust(kino.a.pos, 0.6) Fx.burst("Stars-01", kino.a.pos + V(0, 0.6, 0), {scale = 0.6, color = SOUL}) end end)
		Kit.at(7.45)
		Kit.say("Nono275er:  KINOSHI!!", 0.9)
		nono.a:to(P.STAND, 0.3, "outBack")
		nono.a:watch(kino.a, 1)
		Kit.at(7.6) -- rexydev1 plonge et l'attrape
		rex.a:watch(nil)
		rex.a:to(P.REACH, 0.22, "outQuad")
		rex.a:move(kino.a.pos + flat(rex.a.pos - kino.a.pos) * 2.1, 0.32, "outCubic", {face = true, faceTime = 0.1})
		Kit.ghost(rex.a, FIRE, 0.3, 0.6)
		Kit.at(7.95)
		Kit.say("rexydev1:  I've got you!", 1.0)
		Kit.shake(0.3)
		Kit.at(8.5) -- il le tire hors du trou, ils roulent en arrière
		Fx.burst("Portal-Enter-01", kino.a.pos + V(0, 0.6, 0), {scale = 1.2})
		Fx.burst("Crack-01", kino.a.pos + V(0, 0.15, 0), {scale = 1.2})
		Kit.snd(S.Lunge, 0.6, 0.8)
		kino.a:body({lift = 0}, 0.3, "outBack")
		kino.a:move(g(-4.5, 4.2), 0.5, "outCubic", {arc = 1.6})
		kino.a:to(H.LAND, 0.3, "outQuad")
		Kit.delay(0.45, function() kino.a:body({air = 0}, 0.08) dust(kino.a.pos, 0.9) end)
		rex.a:move(g(-5.5, 0), 0.5, "outCubic")
		rex.a:to(H.SKID, 0.3, "outQuad")
		rex.a:face(RPOS, 0.4)
		nono.a:move(g(-5, -4.2), 0.6, "inOut", {face = true})
		nono.a:gait("heroWalk", 0.1)
		Kit.delay(0.6, function() nono.a:gait(nil, 0.15) nono.a:face(RPOS, 0.3) end)
		Kit.at(9.2)
		Kit.say("kinoshi112:  Something grabbed my legs...!", 1.3)
		kino.a:face(RPOS, 0.3)
		Kit.cam(function(t) return Kit.look(g(1.5, 1.2, 2.4), kino.a:center(0.8), 38) end, 0.3)

		------------------------------------------------ 10,6 - 19 s : la Faucheuse sort de terre, les trois dégainent
		Kit.at(10.6)
		fireOn = false
		campFire.stop()
		Fx.burst("Explosion-01", CAMP + V(0, 1.5, 0), {scale = 0.5, time = 0.15, color = SOUL})
		Kit.tween(0.4, function(e) fireLight.Brightness = 2.2 * (1 - e) for _, f in flames do f.Transparency = e end end)
		Fx.burst("Big-Crack-01", RPOS + V(0, 0.6, 0), {scale = 1.3, time = 0.5, color = SOUL})
		Kit.snd(S.Thunder, 0.7, 0.5) Kit.shake(0.8)
		Kit.cam(function(t) return Kit.look(g(-12, 2.6, 2.0 + 0.3 * t), RPOS + V(0, 5 + 2.2 * t, 0), 48) end, 0.4)
		for _, h in team do h.a:to(P.SHIELD, 0.35, "outBack") h.a:watch(RPOS + V(0, 12, 0), 1) end
		kino.a:move(g(-6.2, 4.2), 0.4, "outQuad") nono.a:move(g(-6.2, -4.2), 0.4, "outQuad")
		Kit.at(11.2)
		reaper:body({lift = 0}, 3.3, "outCubic")
		Kit.fork(function()
			for i = 1, 11 do
				Fx.burst("Smoke-01", RPOS + V(math.random() * 6 - 3, 0.6, math.random() * 6 - 3), {scale = 2.2})
				Fx.burst("Stars-01", RPOS + V(math.random() * 8 - 4, 2 + math.random() * 6, math.random() * 8 - 4), {scale = 1.4, color = SOUL})
				leaves(RPOS, 3, 3)
				Kit.shake(0.35)
				Kit.wait(0.3)
			end
		end)
		Kit.at(12.6)
		Kit.cam(function(t) -- la caméra remonte le long de son corps
			local u = Kit.Ease.inOut(clamp(t / 1.8, 0, 1))
			return Kit.look(RPOS + V(-13, 1.5 + 5 * u, 5), reaper:center(-9 + 13 * u), 44)
		end, 0.5)
		Kit.at(14.5) -- elle rugit
		reaper:to(R.ROAR, 0.35, "outBack")
		reaper.haloSpeed = 260
		Kit.delay(1.4, function() reaper.haloSpeed = 30 end)
		Kit.say("THE HOLLOW REAPER", 2.4)
		Fx.mesh("Shockwave", CFrame.new(RPOS + V(0, 1, 0)), {color = SOUL, size0 = 0.5, size1 = 7, time = 0.9, transp0 = 0.1})
		Fx.burst("Hit-Purple", mark("Mouth"), {scale = 3})
		Fx.light(reaper:center(4), SOUL, 70, 8, 0.9)
		Kit.snd(S.Thunder, 1, 0.7) Kit.snd(S.Ghost, 0.8, 0.5)
		Kit.shake(1.4) Kit.flash(0.35, SOUL, 0.55)
		scatterCamp()
		Kit.cam(function(t) return Kit.look(g(-23 - 0.4 * t, 9, 6.5), RPOS + V(-5, 8, 0), 58) end, 0.2)
		for _, h in team do Kit.fork(function() skid(h.a, RPOS, 4.5, 0.6) end) end
		leaves(g(0, 0), 14, 5)
		local fight = loop(MUSIC_FIGHT, 0, 1)
		Kit.fadeSound(music, 0, 0.6)
		Kit.fadeSound(fight, 0.42, 1.6)
		Kit.at(16.2)
		reaper:to(R.IDLE, 0.6, "inOut")
		for _, h in team do
			h.a:watch(reaper)
			h.a:face(RPOS, 0.3)
			h.a:to(merge({RightHip = {-22, 0, 8}, RightKnee = {-20}, LeftHip = {26, 0, -8}, LeftKnee = {-34}, Waist = {-8, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}}, h.reach(h.handle())), 0.35, "inOut")
		end
		Kit.cam(function(t) return Kit.look(g(-4.6, 1.3 - 0.3 * t, 2.2), g(-11, 0, 2.6), 46) end, 0.3) -- de face : les trois, la main sur la poignée
		Kit.at(16.75) -- ils dégainent en même temps
		Kit.snd(S.Unsheath, 0.8, 1) Kit.snd(S.Unsheath, 0.6, 1.15)
		for _, h in team do
			h.grab(0.22)
			h.trail.Enabled = true
			h.a:to({RightShoulder = {70, 0, 45}, RightElbow = {12}, Grip = {-70}, Waist = {-6, -30, 0}, Root = {0, -10, 0}}, 0.3, "outCubic", {only = true})
		end
		Kit.at(17.1)
		for _, h in team do h.trail.Enabled = false h.a:to(H.GUARD, 0.3, "outBack") end
		-- trois gros plans : le feu, la glace, le vent
		Kit.cam(function(t) return Kit.look(rex.a:point(7, 3.2, 2.4), rex.a:center(0.6), 40) end)
		ignite(rex) Kit.snd(S.Fire, 0.5, 1.2)
		Kit.at(17.6)
		Kit.cam(function(t) return Kit.look(kino.a:point(7, 3.2, 2.4), kino.a:center(0.6), 40) end)
		ignite(kino) Kit.snd(S.Ping, 0.5, 0.6)
		for i = 1, 3 do iceSpike(kino.a.pos + V(-1.6 + i * 0.5, 0, 1.4 - i * 0.2), 1.2 + i * 0.5, V(0.2, 0, 0.5), {quiet = true}) end
		Kit.at(18.1)
		Kit.cam(function(t) return Kit.look(nono.a:point(7, 3.2, 2.4), nono.a:center(0.6), 40) end)
		ignite(nono) Kit.snd(S.Lunge, 0.5, 0.7)
		Fx.mesh("SwirlWind", CFrame.new(nono.a.pos + V(0, 2.2, 0)), {color = WIND, size0 = 0.5, size1 = 1.8, time = 0.7, transp0 = 0.5, spin = 2})
		leaves(nono.a.pos, 8, 2)
		Kit.at(18.6)
		Kit.cam(function(t) return Kit.look(g(-15, 5.5, 3.4), RPOS + V(0, 0, 8.5), 56) end, 0.3)

		------------------------------------------------ 19 - 36 s : chacun son côté, puis tous sur elle
		Kit.at(19.0)
		shatterAll(0.6)
		Kit.camSubject = function() return rex.a:center(1) end
		Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, 180, 11, 2, 0.05, 5, 30, 56), 0.4)
		Kit.fork(function() rush(kino, g(8, -10.5), 0.5, false) kino.a:face(reaper, 0.1) kino.a:to(H.GUARD, 0.25, "outBack") end)
		Kit.fork(function() rush(nono, g(8, 10.5), 0.5, false) nono.a:face(reaper, 0.1) nono.a:to(H.GUARD, 0.25, "outBack") end)
		rush(rex, g(2.5, 0), 0.42)
		rex.a:to(H.GUARD, 0.25, "outBack")
		-- Nono275er ouvre : bond porté par le vent, coupe en plein vol
		Kit.at(19.9)
		Kit.cam(function(t) return Kit.look(g(0, 20, 12), (nono.a:center() + reaper:center(-3)) / 2, 58) end, 0.25)
		nono.a:to(H.CROUCH, 0.1, "outQuad")
		Kit.wait(0.1)
		nono.a:body({air = 1}, 0.05)
		nono.a:to(H.AIR_WIND, 0.2, "outQuad")
		nono.a:move(g(17.5, 4), 0.7, "linear", {arc = 12})
		Fx.mesh("SwirlWind", CFrame.new(nono.a.pos + V(0, 2, 0)), {color = WIND, size0 = 0.5, size1 = 2.2, time = 0.6, transp0 = 0.4, spin = 2})
		Fx.burst("Wind-01", nono.a.pos + V(0, 1, 0), {scale = 1.6})
		leaves(nono.a.pos, 8, 2) Kit.snd(S.Lunge, 0.6, 0.9)
		Kit.fork(function() for _ = 1, 6 do Kit.ghost(nono.a, WIND, 0.3, 0.55) Kit.wait(0.1) end end)
		Kit.at(20.34)
		slash(nono, nil, H.AIR_STRIKE, {cut = 0.1, normal = V(0.3, 0.4, 1), size = 2, hit = function()
			wound(reaper, reaper:center(-1) + V(-1, 0, 2.5), 1.4, WIND)
			hitFx(nono, reaper:center(-1) + V(-1, 0, 2.5), 1.6)
			reaper:to(R.RECOIL, 0.14)
		end})
		Kit.at(20.72)
		nono.a:body({air = 0}, 0.05) nono.a:to(H.LAND, 0.1, "outQuad")
		dust(nono.a.pos, 1) leaves(nono.a.pos, 5) Kit.snd(S.Thud, 0.5, 1.1)
		reaper:face(nono.a, 0.4) reaper:to(R.SWEEP_WIND, 0.5, "inOut")
		Kit.at(21.0) nono.a:to(H.GUARD, 0.2, "outBack") nono.a:face(reaper, 0.15)
		-- la faux balaie : Nono saute en arrière, Rex se baisse
		Kit.at(21.3)
		Kit.cam(wide({rex.a, nono.a, reaper}, 150, 9, 2, 0.08, 4.5, 30, 56), 0.25)
		reaper:to(R.SWEEP, 0.16, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 0.9, 0.5)
		Kit.delay(0.07, function()
			Fx.mesh("Shock", CFrame.new(reaper.pos + V(0, 4.5, 0)), {color = SOUL, size0 = 2, size1 = 5.2, time = 0.35, transp0 = 0.1})
			Kit.shake(0.5)
		end)
		nono.a:to(H.CROUCH, 0.06) nono.a:body({air = 1}, 0.05)
		nono.a:move(g(22, 15.5), 0.42, "outQuad", {arc = 3.4})
		nono.a:body({pitch = math.pi * 2}, 0.4, "inOut")
		Kit.delay(0.42, function() nono.a:body({air = 0, pitch = 0}, 0) nono.a:to(H.LAND, 0.1) dust(nono.a.pos, 0.9) nono.a:face(reaper, 0.1) end)
		rex.a:to(H.DUCK, 0.1, "outQuad", {lag = false})
		-- kinoshi112 : une ligne de glace court jusqu'à elle
		Kit.at(21.9)
		rex.a:to(H.GUARD, 0.25, "outBack")
		Kit.cam(wide({kino.a, reaper}, 155, 9.5, 3, 0.05, 3, 30, 56), 0.3)
		kino.a:to(H.VW, 0.25, "outQuad")
		Kit.at(22.2)
		kino.a:to(merge(H.VS, {Grip = {-110}}), 0.1, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.6, 0.8)
		Fx.burst("Splash-01", kino.a:point(2), {scale = 1.2, color = ICE})
		iceLine(kino.a:point(2.4), reaper.pos + flat(kino.a.pos - reaper.pos) * 2.4, 9, 1.4, 6.5, 0.05)
		wound(reaper, reaper:center(-7) + flat(kino.a.pos - reaper.pos) * 3, 1.5, ICE)
		Fx.burst("Shield-Break-01", reaper:center(-7), {scale = 1.6, color = ICE})
		reaper:to(R.RECOIL, 0.14)
		reaper:move(g(15.5, 1.5), 0.45, "outCubic") dust(reaper.pos, 2)
		Kit.at(23.3) kino.a:to(H.GUARD, 0.3, "outBack") reaper:to(R.IDLE, 0.5, "inOut") reaper:face(rex.a, 0.5)
		-- rexydev1 : la lame de feu
		Kit.at(23.5)
		Kit.cam(wide({rex.a, reaper}, 250, 9, 3, 0.05, 4, 30, 56), 0.3)
		rex.a:to(H.CHARGE, 0.3, "inOut")
		local rexAura = Fx.aura("Fire-Aura-01", rex.a, {limbs = {["Right Arm"] = true, ["Left Arm"] = true}, scale = 0.7})
		Kit.snd(S.Fire, 0.5, 1.3)
		Kit.at(23.95) rex.a:to(H.HW, 0.2, "outCubic")
		Kit.at(24.2)
		slash(rex, nil, H.HS, {size = 1.8, cut = 0.1})
		rexAura.stop()
		Kit.snd(BOOM, 0.5, 1.5) Kit.shake(0.5) Kit.flash(0.2, FIRE, 0.35)
		wave(rex.a:point(2.5), reaper.pos + flat(rex.a.pos - reaper.pos) * 3, 0.34, FIRE, "Fire-02", function(p)
			Fx.burst("Explosion-01", p + V(0, 5, 0), {scale = 1.2, time = 0.3})
			Fx.burst("Realistic-Explosion-01", p + V(0, 5, 0), {scale = 1.3, time = 0.3})
			ring(p, FIRE, 4.5, 0.6)
			Fx.light(p + V(0, 5, 0), FIRE, 60, 9, 0.7)
			Kit.snd(BOOM, 0.8, 1) Kit.shake(1.1) Kit.flash(0.25, FIRE, 0.5)
			wound(reaper, reaper:center(-5), 1.8, FIRE)
			reaper:to(R.RECOIL, 0.14)
			reaper:move(g(18, 0), 0.5, "outCubic") dust(reaper.pos, 2)
		end)
		Kit.at(24.6) Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, 200, 10, 2, 0.06, 5, 30, 56), 0.3)
		Kit.at(25.3) rex.a:to(H.GUARD, 0.3, "outBack") reaper:to(R.ROAR, 0.3, "outBack") Kit.snd(S.Ghost, 0.7, 0.5) Kit.shake(0.4)
		-- elle fond sur Rex : la faux s'abat, il pare et recule de onze studs
		Kit.at(25.8)
		reaper:to(R.SLAM_WIND, 0.42, "inOut")
		reaper:move(rex.a.pos + flat(reaper.pos - rex.a.pos) * 10.5, 0.42, "inOut")
		Kit.snd(S.Ghost, 0.7, 1.2)
		Kit.fork(function() for _ = 1, 5 do Fx.burst("Smoke-01", reaper.pos + V(0, 1, 0), {scale = 2}) Kit.wait(0.08) end end)
		Kit.cam(function(t) return Kit.look(g(-3, -15, 6), (rex.a:center(1) + reaper:center(-6)) / 2, 58) end, 0.25)
		Kit.at(26.2) rex.a:to(H.BLOCKHI, 0.1, "outQuad", {lag = false})
		Kit.at(26.28) reaper:to(R.SLAM, 0.13, "inQuart", {lag = false}) Kit.snd(S.Lunge, 1, 0.45)
		Kit.at(26.41)
		clash(rex.tip(0.6), 2.2, SOUL)
		Fx.burst("Big-Crack-01", rex.a.pos + V(0, 0.6, 0), {scale = 1.1, time = 0.3, color = SOUL})
		Fx.burst("Ground-Impact", rex.a.pos + V(0, 0.3, 0), {scale = 1})
		ring(rex.a.pos, SOUL, 6, 0.6)
		Kit.snd(BOOM, 0.8, 0.8) Kit.shake(1.4) Kit.flash(0.25, SOUL, 0.5)
		skid(rex.a, reaper.pos, 11, 0.65, H.SKID)
		-- kinoshi112 gèle la lame au sol
		Kit.at(26.6)
		Kit.fork(function()
			rush(kino, mark("BladeTip") * FLAT + V(0, ORIGIN.Y, 0) + flat(kino.a.pos - reaper.pos) * 3, 0.3, false)
			slash(kino, H.VW, H.VS, {wind = 0.1, hit = function()
				local at = mark("BladeMid") * FLAT + V(0, ORIGIN.Y, 0)
				for i = 1, 6 do iceSpike(at + V(math.random() * 5 - 2.5, 0, math.random() * 5 - 2.5), 3.5 + math.random() * 3.5, V(math.random() - 0.5, 0, math.random() - 0.5) * 2, {quiet = i > 2}) end
				Fx.burst("Shield-01", at + V(0, 2, 0), {scale = 1.6, color = ICE})
				Kit.snd(S.Ping, 0.6, 0.5) Kit.shake(0.5)
			end})
			kino.a:to(H.GUARD, 0.3, "outBack")
		end)
		Kit.cam(function(t) return Kit.look(g(-1, -15, 6.5), reaper:center(-8), 56) end, 0.4)
		Kit.at(27.5) reaper:hit(1.5) reaper.haloSpeed = 120 Kit.snd(S.Ghost, 0.6, 0.8) -- elle tire sur sa faux, prise dans la glace
		-- Nono275er : la tornade, d'un seul trait autour d'elle
		Kit.at(27.7)
		Kit.cam(function(t) return Kit.look(reaper.pos + V(-17 + t, 13, -15), reaper.pos + V(0, 4, 0), 58) end, 0.3)
		nono.a:to(H.HW, 0.12, "outQuad")
		Fx.burst("Tornado-01", reaper.pos + V(0, 0.5, 0), {scale = 0.8, time = 0.9, color = WIND})
		Fx.mesh("Tornado", CFrame.new(reaper.pos + V(0, 8, 0)), {color = WIND, size0 = 1.2, size1 = 2.6, time = 1.4, transp0 = 0.7, transp1 = 1, spin = 2.5})
		do
			local c, r0 = reaper.pos, 7.5
			local a0 = math.atan2(nono.a.pos.Z - c.Z, nono.a.pos.X - c.X)
			nono.a.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, RightWrist = true}
			nono.a:gait("heroRun", 0.05)
			nono.trail.Enabled = true
			nono.a:to({RightShoulder = {88, 0, 55}, RightElbow = {6}, Grip = {-85}}, 0.1, "outQuad", {only = true})
			for i = 1, 8 do
				local a = a0 + i * rad(58)
				local to = V(c.X + cos(a) * r0, ORIGIN.Y, c.Z + sin(a) * r0)
				nono.a:move(to, 0.13, "linear", {face = true, faceTime = 0.05})
				Kit.ghost(nono.a, WIND, 0.3, 0.5)
				Kit.wait(0.13)
				wound(reaper, reaper:center(-8 + i) + flat(to - c) * 3, 0.7, WIND, false)
				Fx.mesh("Wind", CFrame.new(c + V(0, 2 + i * 1.3, 0)), {color = WIND, size0 = 0.6, size1 = 1.3, time = 0.4, transp0 = 0.6, spin = 3})
				leaves(to, 2)
			end
			nono.a:gait(nil, 0.08)
			nono.trail.Enabled = false
		end
		Kit.at(28.9) nono.a:face(reaper, 0.1) nono.a:to(H.ZANSHIN, 0.25, "outBack")
		-- elle se libère : la glace vole en éclats, les deux sont repoussés
		Kit.at(29.3)
		reaper:to(R.ROAR, 0.25, "outBack")
		reaper.haloSpeed = 300
		Kit.delay(1, function() reaper.haloSpeed = 30 end)
		shatterAll(1.6)
		Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 1, 0)), {color = SOUL, size0 = 0.5, size1 = 5.5, time = 0.7, transp0 = 0.1})
		Kit.snd(S.Thunder, 0.8, 0.9) Kit.shake(1) Kit.flash(0.25, SOUL, 0.4)
		Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, 160, 10, 3, 0.05, 5, 30, 58), 0.2)
		Kit.fork(function() skid(kino.a, reaper.pos, 9, 0.6, H.SKID) end)
		Kit.fork(function() skid(nono.a, reaper.pos, 9, 0.6, H.SKID) end)
		Kit.at(30.2) for _, h in team do h.a:to(H.GUARD, 0.3, "outBack") h.a:face(reaper, 0.2) end
		-- trois lames d'âmes : Rex en coupe une, kinoshi112 lève un mur, Nono esquive
		Kit.at(30.5)
		reaper:face(rex.a, 0.3)
		reaper:to(R.CAST, 0.4, "outBack")
		local palmFx = Fx.attach("Charge-01", reaperModel.Palm, {scale = 1.4, color = SOUL})
		Kit.snd(S.Spark, 0.5, 0.8)
		Kit.cam(function(t) return Kit.look(reaper:center(-2) + V(-9, 0, 9), mark("Palm"), 40) end, 0.3)
		Kit.at(31.15)
		palmFx.stop()
		Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, 185, 10.5, 3, 0.05, 4, 30, 58), 0.2)
		local function soulBlade(h, done)
			reaper:hit(0.5)
			Kit.snd(S.Spark, 0.5, 1.6)
			Fx.projectile(mark("Palm"), h.a:center(0.6), 0.42, {color = SOUL, size = 1.7, done = done})
		end
		local wall
		soulBlade(rex, function(p)
			Fx.burst("Explosion-01", p, {scale = 0.5, time = 0.15, color = SOUL})
			Fx.burst("Fire-Slash-01", p, {scale = 1.6})
			Kit.snd(BOOM, 0.5, 1.5) Kit.shake(0.5)
		end)
		Kit.delay(0.3, function() slash(rex, nil, H.RS, {cut = 0.1, size = 1.4}) end)
		Kit.at(31.33)
		kino.a:to(P.CAST, 0.12, "outQuad")
		wall = iceWall(kino.a.pos + flat(reaper.pos - kino.a.pos) * 3.2, reaper.pos, 6.5, 6.5)
		soulBlade(kino, function(p)
			for _, m in wall do shatter(m, 1.1) end
			Fx.burst("Explosion-01", p, {scale = 0.5, time = 0.15, color = SOUL})
			Kit.snd(BOOM, 0.5, 1.4) Kit.shake(0.5)
			skid(kino.a, reaper.pos, 4, 0.35, H.SKID)
		end)
		Kit.at(31.5)
		soulBlade(nono, function(p)
			Fx.burst("Explosion-01", p, {scale = 0.5, time = 0.15, color = SOUL})
			Fx.burst("Crack-01", V(p.X, ORIGIN.Y + 0.15, p.Z), {scale = 1.4})
			Kit.snd(BOOM, 0.5, 1.6) Kit.shake(0.5)
		end)
		Kit.delay(0.2, function()
			nono.a:to(merge(H.SKID, {Waist = {-26, 0, 0}}), 0.07, "outQuad")
			dash(nono.a, nono.a.pos + V(-7.5, 0, 3), 0.17, WIND, false)
			nono.a:face(reaper, 0.1)
		end)
		Kit.at(32.4)
		reaper:to(R.IDLE, 0.5, "inOut")
		for _, h in team do h.a:to(H.GUARD, 0.3, "outBack") h.a:face(reaper, 0.2) end
		-- tous ensemble : trois traits qui se croisent sur elle
		Kit.at(32.9)
		Kit.cam(function(t) return Kit.look(g(-12 + 0.6 * t, 0.6, 3.4), reaper:center(-7), 54) end, 0.4)
		rex.a:move(g(1.5, 0), 0.4, "inOut") kino.a:move(g(7, -11.5), 0.4, "inOut") nono.a:move(g(7, 11.5), 0.4, "inOut")
		for _, h in team do
			h.a:face(reaper, 0.3)
			h.a:to(H.IAI, 0.45, "inOut")
			h.aura = Fx.aura(h.element.aura, h.a, {scale = 0.8, color = h.element.name ~= "fire" and h.color or nil})
			ring(h.a.pos, h.color, 2.4, 0.5)
		end
		Kit.snd(S.Spark, 0.5, 1.1) Kit.snd(S.Fire, 0.4, 1.4)
		Kit.at(33.75)
		Kit.cam(function(t) return Kit.look(reaper.pos + V(-19, 15, 0.5), reaper.pos + V(0, 3, 0), 60) end, 0.2) -- de haut : les trois trajectoires
		Kit.at(33.95)
		Kit.speedLines(0.35, 0.8) Kit.flash(0.3, WHITE, 0.85)
		Kit.snd(S.Lunge, 0.9, 1.2) Kit.snd(SLASH_HIT, 0.9, 0.8)
		do
			local c = reaper.pos
			for i, h in team do
				local from = h.a.pos
				local dir = flat(c - from)
				local side = V(-dir.Z, 0, dir.X) * 3.4
				h.trail.Enabled = true
				h.a:to(H.IAI_END, 0.1, "outQuart", {lag = false})
				h.a:move(c + dir * 10 + side, 0.16, "outCubic")
				h.a:face(c + dir * 20, 0.05)
				Kit.fork(function() for _ = 1, 4 do Kit.ghost(h.a, h.color, 0.4, 0.4) Kit.wait(0.035) end end)
				local mid = c + V(0, 4 + i * 1.6, 0)
				Fx.mesh("Shock", CFrame.lookAt(mid, mid + dir) * CFrame.Angles(0, 0, rad(-30 + i * 30)) * CFrame.Angles(rad(90), 0, 0), {color = h.color, size0 = 0.8, size1 = 6, time = 0.45, transp0 = 0})
			end
		end
		Kit.hitstop(0.12)
		Kit.at(34.2) -- dos tournés, immobiles
		for _, h in team do h.trail.Enabled = false h.a.idle = 0.3 h.a:watch(nil) if h.aura then h.aura.stop() end end
		reaper.idle = 0.3
		Kit.cam(function(t) return Kit.look(reaper.pos + V(-16, 2.4, 6 - 0.4 * t), reaper:center(-6), 54) end)
		Kit.at(34.85) -- les trois coups apparaissent sur elle
		for i, h in team do
			Kit.delay((i - 1) * 0.1, function()
				local p = reaper:center(-9 + i * 3.4)
				wound(reaper, p, 1.5, h.color, i == 3)
				hitFx(h, p, 2)
			end)
		end
		Kit.at(35.2)
		reaper:to(R.RECOIL, 0.2)
		reaper:body({lift = -4.5, pitch = -0.3}, 0.7, "inQuad")
		reaper.haloSpeed = 4
		Kit.snd(S.Ghost, 0.7, 0.4) Kit.shake(0.6)
		Kit.at(35.5)
		for _, h in team do h.a.idle = 1 h.a:face(reaper, 0.3) h.a:to(H.ZANSHIN, 0.3, "outBack") end
		Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, 20, 9, 3, -0.05, 4, 30, 58), 0.4)

		------------------------------------------------ 36 - 43 s : la Nova creuse
		Kit.at(36.3)
		reaper.idle = 1
		reaper:body({lift = 3.5, pitch = 0}, 1.2, "inOut")
		reaper:to(R.NOVA, 0.8, "inOut")
		reaper.haloSpeed, reaper.coreSpeed = 520, 600
		Kit.fadeSound(fight, 0.15, 0.6)
		Kit.snd(S.Spark, 0.7, 0.5) Kit.snd(S.Ghost, 0.8, 0.35)
		local coreFx = Fx.attach("Charge-01", reaperModel.Core, {scale = 2.4, color = SOUL})
		if coreLight then Kit.tween(1.9, function(e) coreLight.Brightness, coreLight.Range = 1.4 + 4 * e, 20 + 22 * e end) end
		Fx.mesh("Sphere", CFrame.new(reaper.pos + V(0, 14.5, 0)), {color = rgb(26, 6, 40), size0 = 0.3, size1 = 1.9, time = 1.9, transp0 = 0.25, transp1 = 0.05, ease = "inQuad"})
		Kit.fork(function()
			for i = 1, 9 do
				Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 0.6, 0)), {color = SOUL, size0 = 4.5, size1 = 0.4, time = 0.4, transp0 = 0.75, transp1 = 0.2, ease = "inQuad"})
				Kit.shake(0.2 + i * 0.05)
				Kit.wait(0.2)
			end
		end)
		flickerAmp = 3
		Kit.cam(function(t) return Kit.look(reaper.pos + V(-12 + 0.8 * t, 3, 7), reaper:center(1), 46) end, 0.4)
		-- les trois se regroupent devant elle
		Kit.fork(function() rush(rex, g(0, 0), 0.4, false) rex.a:face(reaper, 0.1) rex.a:to(H.BLOCK, 0.2, "outQuad") end)
		Kit.fork(function() rush(kino, g(-1, -4.5), 0.42, false) kino.a:face(reaper, 0.1) kino.a:to(H.BLOCK, 0.2, "outQuad") end)
		Kit.fork(function() rush(nono, g(-1, 4.5), 0.42, false) nono.a:face(reaper, 0.1) nono.a:to(H.BLOCK, 0.2, "outQuad") end)
		Kit.at(37.4)
		Kit.cam(function(t) return Kit.look(g(-9, 0.4, 2.2), reaper:center(-2), 52) end, 0.3) -- derrière eux : la sphère grossit
		Kit.at(38.2) -- elle explose
		coreFx.stop()
		Kit.fadeSound(fight, 0, 0.1)
		Fx.mesh("Explosion", CFrame.new(reaper.pos + V(0, 12, 0)), {color = SOUL, size0 = 1.5, size1 = 4.2, time = 0.9, transp0 = 0.25})
		Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 1, 0)), {color = SOUL, size0 = 1, size1 = 10, time = 1.0, transp0 = 0.05})
		Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 6, 0)), {color = WHITE, size0 = 1, size1 = 7, time = 0.8, transp0 = 0.2})
		Fx.burst("Explosion-01", reaper:center(0), {scale = 2, time = 0.3, color = SOUL})
		Fx.burst("Big-Crack-01", reaper.pos + V(0, 0.6, 0), {scale = 2.2, time = 0.5, color = SOUL})
		Fx.light(reaper:center(0), SOUL, 80, 6, 1.0)
		Kit.snd(BOOM, 1, 0.7) Kit.snd(S.Thunder, 1, 0.8)
		Kit.shake(2.4) Kit.flash(0.5, rgb(240, 210, 255), 0.8) Kit.hitstop(0.14)
		if coreLight then coreLight.Brightness, coreLight.Range = 1.4, 20 end
		reaper.haloSpeed, reaper.coreSpeed = 40, 70
		Kit.cam(function(t) return Kit.look(g(-27, -9, 5.5), g(-8, 0, 2.5), 60) end, 0.15)
		local landed = {}
		for i, h in team do landed[i] = blowBack(h, reaper.pos, 15 + i, 0.8, 5) end
		leaves(g(0, 0), 16, 6)
		Kit.at(39.3)
		reaper:to(R.IDLE, 0.8, "inOut")
		reaper:body({lift = 0}, 1, "inOut")
		flickerAmp = 1
		Kit.at(40.0)
		Kit.cam(function(t) return Kit.look(kino.a.pos + V(-3.4, 1.3, 2.8), kino.a.pos + V(0.4, 0.7, 0), 40) end, 0.4)
		Kit.say("kinoshi112:  It's too strong...", 1.5)
		getUp(kino, 2.2, P.KNEEL)
		Kit.delay(0.5, function() getUp(nono, 2.2, P.KNEEL) end)
		Kit.at(41.3)
		Kit.fadeSound(fight, 0.4, 1.2)
		Kit.cam(function(t) return Kit.look(rex.a.pos + V(-3.6, 1.0, -2.6), rex.a.pos + V(0.3, 1.0, 0), 38) end, 0.4)
		getUp(rex, 1.5, H.GUARD)

		------------------------------------------------ 43 - 53 s : Rex fonce, elle bloque et le projette au loin
		Kit.at(43.0)
		for _, h in team do h.a:watch(reaper) end
		Kit.camSubject = function() return rex.a:center(1) end
		Kit.cam(function(t) return Kit.look(g(-2, -17, 4.5), (rex.a:center(1) + reaper:center(-7)) / 2, 60) end, 0.3)
		rex.a:face(reaper, 0.1)
		Fx.burst("Fire-02", rex.a.pos + V(0, 0.5, 0), {scale = 1.4})
		rush(rex, reaper.pos + flat(rex.a.pos - reaper.pos) * 9, 0.5)
		rex.a:to(H.CROUCH, 0.07, "outQuad")
		Kit.wait(0.07)
		rex.a:body({air = 1}, 0.05)
		rex.a:to(H.AIR_WIND, 0.16, "outQuad")
		rex.a:move(reaper.pos + flat(rex.a.pos - reaper.pos) * 5.5 + V(0, 7.5, 0), 0.3, "outQuad")
		reaper:to(R.BLOCK, 0.2, "outQuad")
		Kit.at(43.84)
		rex.trail.Enabled = true
		rex.a:to(H.AIR_STRIKE, 0.09, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.7, 0.9)
		Kit.at(43.92) -- la lame s'écrase sur le manche de la faux
		clash(rex.tip(0.8), 2.4, SOUL)
		Fx.mesh("Shockwave", CFrame.new(rex.tip(0.8)), {color = WHITE, size0 = 0.3, size1 = 3.2, time = 0.5, transp0 = 0.1})
		Kit.flash(0.25, WHITE, 0.6)
		Kit.at(44.05) -- elle le repousse d'un revers
		rex.trail.Enabled = false
		reaper:to(R.SWEEP, 0.12, "outQuart", {lag = false})
		Fx.mesh("Shock", CFrame.new(reaper.pos + V(0, 7, 0)), {color = SOUL, size0 = 2, size1 = 5, time = 0.35, transp0 = 0.1})
		Kit.snd(BOOM, 0.7, 1.3) Kit.shake(1)
		Kit.cam(function(t) return Kit.look(g(-8, -20, 6), rex.a:center(0), 58) end, 0.2)
		local rexDown = blowBack(rex, reaper.pos, 25, 1.0, 5)
		Kit.at(45.2)
		Kit.say("Nono275er:  REXY!", 0.9)
		reaper:to(R.IDLE, 0.5, "inOut")
		-- elle avance sur Rex à terre ; les deux autres lui barrent la route
		Kit.at(45.6)
		reaper:face(rexDown, 0.6)
		reaper:move(g(4, 0), 4.4, "inOut")
		Kit.cam(wide({rex.a, kino.a, nono.a, reaper}, -90, 9, 3, 0.03, 4, 30, 60), 0.4)
		Kit.fork(function() -- kinoshi112 : un mur de glace en travers de sa route
			kino.a:to(H.GUARD, 0.3, "outBack")
			Kit.wait(0.3)
			rush(kino, reaper.pos + flat(rexDown - reaper.pos) * 9 + V(0, 0, -2), 0.4, false)
			kino.a:face(reaper, 0.1)
			kino.a:to(P.CAST, 0.12, "outQuad")
			local w2 = iceWall(kino.a.pos + flat(reaper.pos - kino.a.pos) * 3.2, reaper.pos, 9, 8.5)
			Kit.wait(0.55)
			reaper:to(R.SLAM_WIND, 0.3, "inOut")
			Kit.wait(0.32)
			reaper:to(R.SLAM, 0.13, "inQuart", {lag = false})
			Kit.snd(S.Lunge, 0.9, 0.5)
			Kit.wait(0.13)
			for _, m in w2 do shatter(m, 1.5) end
			Fx.burst("Shield-Break-01", kino.a.pos + flat(reaper.pos - kino.a.pos) * 3.2 + V(0, 3, 0), {scale = 2, color = ICE})
			Kit.snd(BOOM, 0.6, 1.2) Kit.shake(0.9)
			skid(kino.a, reaper.pos + V(-4, 0, 8), 13, 0.6, H.SKID)
			Kit.wait(0.5)
			reaper:to(R.IDLE, 0.5, "inOut")
			kino.a:to(H.GUARD, 0.3, "outBack")
		end)
		Kit.fork(function() -- Nono275er : trois lames de vent dans son flanc
			nono.a:to(H.GUARD, 0.3, "outBack")
			Kit.wait(0.5)
			rush(nono, g(6, 13), 0.45, false)
			nono.a:face(reaper, 0.1)
			Kit.wait(1.1)
			for i = 1, 3 do
				nono.a:face(reaper, 0.05)
				slash(nono, i % 2 == 1 and H.HW or H.RW, i % 2 == 1 and H.HS or H.RS, {wind = 0.09, size = 1.3})
				wave(nono.a:point(2), reaper.pos + flat(nono.a.pos - reaper.pos) * 3, 0.3, WIND, "Wind-02", function(p)
					wound(reaper, reaper:center(-6 + i * 2), 0.8, WIND, false)
					Fx.burst("Wind-01", p + V(0, 5, 0), {scale = 2})
				end)
				Kit.wait(0.12)
			end
			nono.a:to(H.GUARD, 0.3, "outBack")
		end)
		-- Rex se relève lentement
		Kit.at(47.6)
		Kit.cam(function(t) return Kit.look(rex.a.pos + V(-4.2 + 0.3 * t, 0.9, 2.6), rex.a.pos + V(0.6, 1.1, 0), 40) end, 0.5)
		rex.a:face(reaper, 0)
		getUp(rex, 3.2, H.FATIGUE)
		rex.a.idle = 2.6
		Kit.at(50.9)
		-- les deux autres s'écartent : la suite se joue entre lui et elle
		Kit.fork(function() rush(kino, g(-2, -22), 0.5, false) kino.a:face(reaper, 0.1) kino.a:to(H.GUARD, 0.3, "outBack") end)
		Kit.fork(function() rush(nono, g(-2, 22), 0.5, false) nono.a:face(reaper, 0.1) nono.a:to(H.GUARD, 0.3, "outBack") end)
		rex.a.idle = 1
		rex.a:to(H.GUARD, 0.3, "outBack")
		Kit.cam(function(t) return Kit.look(rex.a:point(4.4 - 0.8 * t, -1.2, 3.2), rex.a:center(1.2), 32) end, 0.4)
		Kit.snd(S.Ping, 0.4, 0.7)
		Kit.at(51.4) -- le feu le recouvre
		rexAura = Fx.aura("Fire-Aura-01", rex.a, {scale = 0.9})
		if rex.bladeFx then rex.bladeFx.stop() end
		rex.bladeFx = Fx.attach("Fire-03", rex.blade, {offset = CFrame.new(0, 0, -1.4), scale = 1.1})
		if rex.light then rex.light.Brightness, rex.light.Range = 5, 22 end
		Fx.burst("Fire-02", rex.a.pos + V(0, 0.5, 0), {scale = 2})
		ring(rex.a.pos, FIRE, 4, 0.6)
		Fx.light(rex.a:center(0.5), FIRE, 40, 7, 0.8)
		Kit.snd(S.Fire, 0.7, 1) Kit.shake(0.4)
		Kit.fadeSound(fight, 0.6, 0.5)

		------------------------------------------------ 52 - 56 s : il disparaît devant elle, réapparaît dans son dos
		Kit.at(52.2)
		Kit.cam(wide({rex.a, reaper}, 245, 10, 2, 0.04, 4, 30, 60), 0.25)
		reaper:face(rex.a, 0.3)
		reaper:to(R.SLAM_WIND, 0.45, "inOut")
		Kit.fork(function() -- traînée de flammes sous ses pas
			for _ = 1, 9 do Fx.burst("Fire-02", rex.a.pos + V(0, 0.4, 0), {scale = 0.9, time = 0.5}) Kit.wait(0.05) end
		end)
		rush(rex, reaper.pos + flat(rex.a.pos - reaper.pos) * 8, 0.5)
		Kit.at(52.74)
		reaper:to(R.SLAM, 0.12, "inQuart", {lag = false})
		Kit.snd(S.Lunge, 1, 0.45)
		-- au moment où la faux tombe : un éclair de feu, plus personne
		local gone = rex.a.pos
		Fx.burst("Portal-Enter-01", rex.a:center(0), {scale = 1.4})
		Fx.burst("Fire-01", rex.a:center(0), {scale = 1.6, time = 0.3})
		Fx.mesh("Flash", CFrame.new(rex.a:center(0)), {color = FIRE, size0 = 0.3, size1 = 1.2, time = 0.25, transp0 = 0})
		Kit.ghost(rex.a, FIRE, 0.5, 0.3)
		Kit.flash(0.15, FIRE, 0.5)
		Kit.snd(S.Spark, 0.7, 1.8)
		rexAura.stop()
		if rex.bladeFx then rex.bladeFx.stop() end
		rex.a:setVisible(0)
		if rex.light then rex.light.Enabled = false end
		Kit.at(52.86) -- la faux ne frappe que le sol
		Fx.burst("Big-Crack-01", gone + V(0, 0.6, 0), {scale = 1.2, time = 0.3, color = SOUL})
		Fx.burst("Ground-Impact", gone + V(0, 0.3, 0), {scale = 1.2})
		ring(gone, SOUL, 5, 0.5)
		Kit.snd(BOOM, 0.7, 0.9) Kit.shake(1.1)
		Kit.at(53.1) -- derrière elle, en l'air
		Kit.camSubject = nil
		local back, r0 = flat(reaper.pos - gone), reaper.pos
		local side = V(back.Z, 0, -back.X)
		local landSpot = r0 + back * 2 -- elle va tomber quatorze studs plus loin : il retombe à l'écart de sa robe
		rex.a:body({air = 1}, 0)
		rex.a:place(r0 + back * 6 + V(0, 9, 0), r0 + V(0, 9, 0))
		rex.a:to(H.AIR_WIND, 0)
		rex.a:setVisible(1)
		if rex.light then rex.light.Enabled = true end
		rexAura = Fx.aura("Fire-Aura-01", rex.a, {scale = 0.9})
		rex.bladeFx = Fx.attach("Fire-03", rex.blade, {offset = CFrame.new(0, 0, -1.4), scale = 1.1})
		Fx.burst("Portal-01", rex.a:center(0), {scale = 1.4})
		Fx.burst("Fire-01", rex.a:center(0), {scale = 1.4, time = 0.3})
		Fx.mesh("Flash", CFrame.new(rex.a:center(0)), {color = FIRE, size0 = 0.3, size1 = 1.4, time = 0.3, transp0 = 0})
		Kit.snd(S.Spark, 0.7, 1.4)
		Kit.cam(function(t) return Kit.look(r0 + back * 2 + side * 20 + V(0, 12, 0), r0 + back * 2 + V(0, 6.5, 0), 58) end)
		Kit.at(53.28) -- le coup dans le dos
		rex.a:move(r0 + back * 5.4 + V(0, 6.5, 0), 0.14, "outQuad")
		slash(rex, nil, H.AIR_STRIKE, {cut = 0.1, normal = V(0.2, 0.3, 1), size = 3, hit = function()
			local p = reaper:center(1) + back * 3
			wound(reaper, p, 2.4, FIRE)
			Fx.burst("Fire-Slash-01", p, {scale = 1.8})
			Fx.burst("Explosion-01", p, {scale = 0.8, time = 0.15})
			Fx.mesh("Shock", CFrame.lookAt(p, p + back) * CFrame.Angles(0, 0, rad(-35)) * CFrame.Angles(rad(90), 0, 0), {color = FIRE, size0 = 1, size1 = 6, time = 0.5, transp0 = 0})
			Fx.light(p, FIRE, 70, 7, 0.8)
			Kit.snd(BOOM, 0.9, 1.1) Kit.flash(0.3, FIRE, 0.6) Kit.shake(1.5)
		end})
		-- elle est projetée en avant et s'écroule de tout son long
		reaper.idle = 0
		reaper:to(R.RECOIL, 0.15)
		Kit.at(53.6)
		reaper:to(R.FALLEN, 0.5, "inQuad")
		reaper:move(r0 - back * 14, 0.75, "outQuad")
		reaper:body({pitch = -1.2, lift = -8.2}, 0.75, "inQuad")
		reaper.haloSpeed, reaper.coreSpeed = 0, 12
		Kit.cam(function(t) return Kit.look(r0 - back * 4 + side * 25 + V(0, 13, 0), r0 - back * 8 + V(0, 3, 0), 60) end, 0.3)
		Kit.delay(0.75, function()
			local front = reaper.pos - back * 8
			dust(front, 3) dust(reaper.pos, 3) leaves(front, 12, 4)
			Fx.burst("Ground-Impact", front + V(0, 0.3, 0), {scale = 2})
			Fx.burst("Big-Crack-01", front + V(0, 0.6, 0), {scale = 1.4, time = 0.4, color = SOUL})
			Kit.snd(BOOM, 0.8, 0.6) Kit.snd(S.Thud, 0.9, 0.4) Kit.shake(1.3)
		end)
		rex.a:move(landSpot, 0.4, "inQuad")
		Kit.delay(0.4, function()
			rex.a:body({air = 0}, 0.05) rex.a:to(H.LAND, 0.1, "outQuad")
			dust(rex.a.pos, 1) ring(rex.a.pos, FIRE, 2.4, 0.4) Kit.snd(S.Thud, 0.5, 1)
		end)

		------------------------------------------------ 55 - 62 s : le grand saut, la boule de feu, la forêt soufflée
		local shelterWall
		Kit.at(54.9)
		rex.a:face(reaper, 0.15)
		rex.a:to(H.CROUCH, 0.22, "outQuad")
		Kit.cam(function(t) return Kit.look(rex.a.pos + V(9, 1.2, 7), rex.a:center(0.5), 46) end, 0.3)
		-- les deux autres se mettent à l'abri derrière un mur de glace
		Kit.fork(function()
			local shelter = g(17, 0)
			Kit.fork(function() rush(nono, shelter + V(1.5, 0, 2.2), 0.5, false) nono.a:face(reaper, 0.1) nono.a:to(P.SHIELD, 0.3, "outBack") end)
			rush(kino, shelter + V(1.5, 0, -2.2), 0.5, false)
			kino.a:face(reaper, 0.1)
			kino.a:to(P.CAST, 0.15, "outQuad")
			shelterWall = iceWall(shelter + V(-2.6, 0, 0), reaper.pos, 11, 9)
			Kit.wait(0.3)
			kino.a:to(P.SHIELD, 0.3, "outBack")
		end)
		Kit.at(55.15) -- il saute en arrière, très haut
		local takeoff = rex.a.pos
		local apex = takeoff + flat(takeoff - reaper.pos) * 1.5 + V(0, 27, 0)
		rex.a:body({air = 1}, 0.05)
		rex.a:to(merge(H.AIR_WIND, {RightShoulder = {60, 0, 40}, LeftShoulder = {70, 0, -40}}), 0.25, "outQuad")
		rex.a:move(apex, 1.5, "outCubic")
		dust(takeoff, 1.6) leaves(takeoff, 10, 2) ring(takeoff, FIRE, 4, 0.5)
		Fx.burst("Fire-02", takeoff + V(0, 0.5, 0), {scale = 2})
		Kit.snd(S.Lunge, 0.9, 0.7) Kit.shake(0.6)
		Kit.speedLines(0.5, 0.6)
		Kit.fork(function() for _ = 1, 10 do Kit.ghost(rex.a, FIRE, 0.35, 0.55) Kit.wait(0.06) end end)
		Kit.cam(function(t) return Kit.look(takeoff + V(8, 1.5, 9), rex.a:center(0), 52) end, 0.2)
		Kit.at(55.75) -- en l'air, il rengaine
		Kit.cam(function(t) return Kit.look(rex.a:point(5.5, -2.4, -1.2), rex.a:center(0.2), 42) end, 0.3)
		rex.a:to(merge({Waist = {-6, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}, Grip = {-150}, RightHip = {30, 0, 6}, RightKnee = {-70}, LeftHip = {-10, 0, -6}, LeftKnee = {-50}, Neck = {-10, 10, 0}},
			rex.reach(rex.a.hrp.CFrame:PointToObjectSpace((rex.scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position))), 0.3, "inOut")
		if rex.bladeFx then rex.bladeFx.stop() end
		Kit.at(56.1)
		rex.sheath(0.3)
		if rex.light then rex.light.Enabled = false end
		Kit.delay(0.3, function() Kit.snd(S.Unsheath, 0.6, 0.7) end)
		Kit.at(56.5) -- la boule de feu grandit au-dessus de ses mains
		Kit.scale = 0.6
		rex.a:to(P.FIREBALL, 0.35, "outBack")
		Kit.fadeSound(fight, 0.1, 0.4)
		local function orb(color, transparency)
			local part = Instance.new("Part")
			part.Name = "Fireball"
			part.Shape = Enum.PartType.Ball
			part.Material, part.Color, part.Transparency = Enum.Material.Neon, color, transparency
			part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.CastShadow = true, false, false, false, false
			part.Size = V(1, 1, 1)
			part.Parent = scene
			return part
		end
		local ball, heart = orb(FIRE, 0.15), orb(rgb(255, 235, 170), 0)
		local ballLight = Instance.new("PointLight")
		ballLight.Color, ballLight.Range, ballLight.Brightness, ballLight.Shadows = FIRE, 40, 6, false
		ballLight.Parent = ball
		local ballSize, ballPos, ballFree = 1, rex.a:center(4), false
		local ballFx = {Fx.attach("Fire-01", ball, {scale = 2.2}), Fx.attach("Fire-03", ball, {scale = 2}), Fx.attach("Ball-01", ball, {scale = 2})}
		-- l'effet Ball-01 de la bibliothèque grossit avec elle, en trois temps
		Kit.delay(0.45, function() if ball.Parent then table.insert(ballFx, Fx.attach("Ball-01", ball, {scale = 4})) end end)
		Kit.delay(0.9, function() if ball.Parent then table.insert(ballFx, Fx.attach("Ball-01", ball, {scale = 6.5})) end end)
		Kit.fork(function()
			while ball.Parent and Kit.running do
				if not ballFree then ballPos = rex.a:center(3.2 + ballSize * 0.5) end
				ball.Size, heart.Size = V(1, 1, 1) * ballSize, V(1, 1, 1) * ballSize * 0.6
				ball.CFrame = CFrame.new(ballPos) * CFrame.Angles(Kit.time * 3, Kit.time * 4, 0)
				heart.CFrame = CFrame.new(ballPos)
				task.wait()
			end
		end)
		Kit.tween(1.25, function(e) ballSize = 1 + 8 * e ballLight.Range = 40 + 60 * e end, "outQuad")
		Kit.snd(S.Fire, 0.9, 0.6) Kit.snd(S.Spark, 0.6, 0.5)
		Kit.cam(function(t) return Kit.look(g(-4, -12, 6), rex.a:center(4), 50 + 5 * min(t, 1.2)) end, 0.3) -- d'en bas : lui et sa boule de feu
		Kit.at(57.3) Kit.say("rexydev1:  My turn.", 0.9)
		Kit.at(57.75) -- il la lance
		Kit.scale = 1
		Kit.cam(function(t) return Kit.look(g(22, -12, 10), reaper.pos + V(4, 8, 0), 62) end, 0.25)
		rex.a:to(P.THROW, 0.1, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 1, 0.6) Kit.snd(BOOM, 0.5, 1.6)
		ballFree = true
		local ballFrom, target = ballPos, reaper.pos + V(0, 3, 0)
		Kit.tween(0.5, function(e)
			ballPos = ballFrom:Lerp(target, e)
			if not Kit.fast() and math.random() < 0.6 then Fx.burst("Fire-02", ballPos, {scale = 1.6, time = 0.4}) end
		end, "inQuad")
		Kit.at(58.25) -- elle touche : tout explose, la forêt est soufflée
		for _, f in ballFx do f.stop() end
		ball:Destroy() heart:Destroy()
		Kit.fadeSound(fight, 0, 0.1)
		for _, m in {
			Fx.mesh("Sphere", CFrame.new(target), {color = rgb(255, 240, 200), size0 = 1, size1 = 7, time = 0.7, transp0 = 0, transp1 = 1}),
			Fx.mesh("Explosion", CFrame.new(target), {color = FIRE, size0 = 1.5, size1 = 12, time = 2.3, transp0 = 0.3, transp1 = 1, fadeLate = true}),
			Fx.mesh("Explosion", CFrame.new(target), {color = rgb(255, 80, 20), size0 = 1, size1 = 8, time = 1.8, transp0 = 0.35, transp1 = 1, fadeLate = true, spin = 0.2}),
		} do
			pcall(function() m.DoubleSided = true end) -- la caméra est engloutie : on voit la boule de feu de l'intérieur
		end
		Fx.mesh("Shockwave", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 1, 0)), {color = rgb(255, 210, 150), size0 = 1, size1 = 34, time = 1.9, transp0 = 0, ease = "outQuad"})
		Fx.mesh("Shockwave", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 5, 0)), {color = FIRE, size0 = 1, size1 = 22, time = 1.5, transp0 = 0.1, ease = "outQuad"})
		Fx.burst("Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Realistic-Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Big-Crack-01", reaper.pos + V(0, 0.6, 0), {scale = 3.2, time = 0.6})
		Fx.burst("Ground-Impact", reaper.pos + V(0, 0.3, 0), {scale = 3})
		Fx.light(target + V(0, 8, 0), rgb(255, 190, 110), 220, 6, 2.6)
		Kit.snd(BOOM, 1, 0.55) Kit.snd(BOOM, 1, 0.9) Kit.snd(S.Thunder, 1, 0.6)
		Kit.flash(0.7, rgb(255, 245, 225), 1) Kit.hitstop(0.16)
		Kit.cam(function(t) return Kit.look(g(22 + 0.4 * t, -14, 6), g(-12, 2, 9), 68) end, 0.1) -- un seul plan large : l'impact, les arbres qui tombent, le mur de glace
		Kit.fork(function() for i = 1, 12 do Kit.shake(2.6 - i * 0.18) Kit.wait(0.12) end end)
		reaper:setVisible(0)
		do -- sa faux reste plantée dans le cratère
			local scythe = film.HollowReaper:FindFirstChild("GripParts")
			if scythe then
				scythe = scythe:Clone()
				scythe.Name = "PlantedScythe"
				for _, d in scythe:GetDescendants() do
					if d:IsA("BasePart") then d.Anchored = true elseif d:IsA("Weld") then d:Destroy() end
				end
				scythe.Parent = scene
				scythe:PivotTo(CFrame.new(reaper.pos + V(0, 12.6, 0)) * CFrame.Angles(0, rad(100), 0) * CFrame.Angles(0, 0, rad(13)))
			end
		end
		breakForest(reaper.pos, 60)
		for _, f in flickers do if f[1].Parent then f[1].Enabled = false end end
		-- braises partout
		Kit.fork(function()
			for i = 1, 18 do
				local a, r = math.random() * 6.283, 6 + math.random() * 30
				Fx.burst("Fire-02", reaper.pos + V(cos(a) * r, 0.5, sin(a) * r), {scale = 1.4 + math.random(), time = 5})
				if i % 3 == 0 then Fx.light(reaper.pos + V(cos(a) * r, 3, sin(a) * r), FIRE, 46, 1.1, 14) end -- les braises éclairent ce qu'il reste
				Kit.wait(0.06)
			end
		end)
		Kit.at(58.9) -- le souffle atteint le mur de glace
		if shelterWall then for _, m in shelterWall do shatter(m, 2) end end
		Fx.burst("Shield-Break-01", g(14.4, 0, 4), {scale = 2.6, color = ICE})
		Fx.mesh("SwirlWind", CFrame.new(g(18.5, 0, 2.2)), {color = WIND, size0 = 1.5, size1 = 2.6, time = 0.9, transp0 = 0.4, spin = 2})
		Kit.fork(function() skid(kino.a, reaper.pos, 6, 0.6) end)
		Kit.fork(function() skid(nono.a, reaper.pos, 6, 0.6) end)
		leaves(g(17, 0), 16, 5)
		Kit.at(60.3) -- ce qu'il reste de la forêt
		Kit.cam(function(t) return Kit.look(g(20 + 0.5 * t, -12, 12), g(-22, 6, 7), 64) end, 0.3)
		Kit.at(61.4) -- il retombe du ciel
		rex.a:to(H.AIR_STRIKE, 0.2)
		local landAt = takeoff
		rex.a:move(landAt, 0.5, "inQuad")
		Kit.cam(function(t) return Kit.look(landAt + V(8, 1.4, 6), landAt + V(0, 2.2, 0), 46) end, 0.3)
		Kit.at(61.9)
		rex.a:body({air = 0}, 0.05)
		rex.a:to(H.LAND, 0.1, "outQuad")
		dust(landAt, 2) leaves(landAt, 10, 3) ring(landAt, FIRE, 4, 0.5)
		Fx.burst("Ground-Impact", landAt + V(0, 0.3, 0), {scale = 1.4})
		Kit.snd(S.Thud, 0.9, 0.6) Kit.shake(0.9)
		rexAura.stop()

		------------------------------------------------ 62 - 72 s : ce qu'il reste d'elle, puis on rentre
		Kit.at(62.8)
		rex.a:to(P.STAND, 0.9, "inOut")
		rex.a:watch(reaper.pos + V(0, 2, 0), 1)
		local calm = loop(MUSIC_CALM, 0, 1)
		Kit.fadeSound(calm, 0.18, 2)
		Kit.fadeSound(wind, 0.25, 1)
		Kit.at(63.4) -- la faux plantée dans le cratère, les âmes s'en vont
		Kit.cam(function(t) return Kit.look(landAt + V(9 - 0.4 * t, 6, 8), reaper.pos + V(0, 8, 0), 52) end, 0.5)
		Kit.fork(function()
			for i = 1, 14 do
				Fx.burst("Stars-01", reaper.pos + V(math.random() * 10 - 5, 1 + i * 0.9, math.random() * 10 - 5), {scale = 1.1, color = SOUL})
				if i % 3 == 0 then Kit.snd(S.Ghost, 0.25, 1.4 + i * 0.05) end
				Kit.wait(0.22)
			end
		end)
		local toShelter = flat(g(17, 0) - landAt)
		for i, h in {kino, nono} do
			Kit.fork(function()
				local side = V(0, 0, i == 1 and -3.2 or 3.2)
				h.a:watch(rex.a)
				rush(h, landAt + toShelter * 9 + side, 0.5, false)
				h.a:to({RightShoulder = {8, 0, 14}, RightElbow = {18}, Grip = {-70}, LeftShoulder = {-4, 0, -8}, LeftElbow = {14}, Waist = {-3}}, 0.5, "inOut")
				h.a.gaitMask = {Grip = true}
				h.a:gait("heroWalkSword", 0.3, function() leaves(h.a.pos, 1) end)
				h.a:move(landAt + toShelter * 5 + side, 2.4, "inOut", {face = true, faceTime = 0.4})
				Kit.wait(2.4)
				h.a:gait(nil, 0.3)
				h.a.gaitMask = nil
			end)
		end
		Kit.at(66.5) rex.a:face(g(17, 0), 0.6, "inOut")
		Kit.at(67.2)
		rex.a:watch(kino.a, 1)
		Kit.cam(function(t) return Kit.look(landAt + V(-4, 4.2, -15 + 0.4 * t), landAt + V(3.3, 2.2, 0), 46) end, 0.6)
		for _, h in {kino, nono} do
			h.a:to(merge({Waist = {-6, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}, Grip = {-150}, Neck = {-10, 10, 0}}, h.reach(h.handle())), 0.45, "inOut")
			if h.bladeFx then h.bladeFx.stop() end
			if h.light then h.light.Enabled = false end
		end
		Kit.at(67.7)
		kino.sheath(0.4) nono.sheath(0.4)
		Kit.delay(0.4, function() Kit.snd(S.Unsheath, 0.5, 0.7) for _, h in {kino, nono} do h.a:to(P.STAND, 0.5, "inOut") end end)
		Kit.at(68.2)
		Kit.say("kinoshi112:  You broke the whole forest.", 1.7)
		kino.a:to(merge(P.STAND, {RightShoulder = {70, 0, 70}, RightElbow = {10}, Neck = {0, -30, 0}}), 0.35, "outBack") -- il montre les arbres couchés
		Kit.at(70.0)
		kino.a:to(P.STAND, 0.4, "inOut")
		Kit.say("rexydev1:  ...Let's go home.", 1.8)
		rex.a:to(merge(P.STAND, {RightShoulder = {30, 0, 40}, RightElbow = {95}, LeftShoulder = {30, 0, -40}, LeftElbow = {95}}), 0.3, "outBack")
		Kit.at(70.7) rex.a:to(P.STAND, 0.4, "inOut")
		Kit.at(71.6)
		Kit.fadeSound(calm, 0, 1.2)
		Kit.fade(0, 1.1)
		Kit.at(72.9)
	end)

	---------------------------------------------------------------- remise en état
	if not ok and err ~= "FILM_ABORT" then warn("[ReaperFilm] " .. tostring(err)) end
	for _, s in loops do if s then s:Destroy() end end
	Kit.scale = 1
	Kit.fade(0, 0)
	Kit.finish()
	scene:Destroy()
	grade:Destroy()
	for prop, value in savedLighting do Lighting[prop] = value end
	if sunRays then sunRays.Enabled = sunRaysWere end
	if gameMusic and musicWasPlaying then gameMusic:Resume() end
	playing = false
	return ok, err
end

function M.stop() Kit.running = false end

return M
