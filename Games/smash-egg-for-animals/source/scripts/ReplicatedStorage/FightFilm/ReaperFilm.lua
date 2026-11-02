-- Cinématique "The Hollow Reaper" (nouvelle version) : feu de camp, la Faucheuse sort de terre, trois sabres et trois pouvoirs
-- (rexydev1 le feu, kinoshi112 la glace, Nono275er le vent), le combat dans le ciel (vol, projections de cent studs),
-- la Nova creuse, puis la boule de feu qui rase la forêt.
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

		local CENTER = g(0, 0)
		local function inClearing(p, radius) -- ramène un point dans la clairière (les arbres commencent vers 25 studs du centre)
			local d = (p - CENTER) * FLAT
			radius = radius or 20
			if d.Magnitude > radius then return CENTER + d.Unit * radius end
			return V(p.X, ORIGIN.Y, p.Z)
		end

		------------------------------------------------ glace : cristaux en blocs à studs qui jaillissent du sol
		local ices = {}
		local ICE_PALETTE = {rgb(36, 92, 168), rgb(54, 124, 198), rgb(104, 176, 228), rgb(44, 106, 180), ICE}
		local VOID_PALETTE = {rgb(44, 22, 66), rgb(74, 36, 110), rgb(150, 70, 220), rgb(60, 30, 90), SOUL} -- les pics du néant de la Faucheuse
		local function iceSpike(pos, h, lean, o)
			o = o or {}
			local pal = o.palette or ICE_PALETTE
			local model = Instance.new("Model")
			model.Name = "Ice"
			model:SetAttribute("Void", o.palette == VOID_PALETTE)
			local w = o.width or max(0.9, min(h * 0.34, 2 + h * 0.12))
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
			piece("Part", V(w, h * 0.55, w), CFrame.new(0, h * 0.275, 0), pal[1])
			piece("Part", V(w * 0.72, h * 0.3, w * 0.72), CFrame.new(0, h * 0.7, 0), pal[2])
			piece("WedgePart", V(w * 0.72, h * 0.16, w * 0.36), CFrame.new(0, h * 0.93, w * 0.18), pal[3])
			piece("WedgePart", V(w * 0.72, h * 0.16, w * 0.36), CFrame.new(0, h * 0.93, -w * 0.18) * CFrame.Angles(0, rad(180), 0), pal[3])
			piece("Part", V(w * 0.3, h * 0.5, w * 0.3), CFrame.new(w * 0.52, h * 0.22, w * 0.2) * CFrame.Angles(0, 0, rad(-14)), pal[4])
			piece("Part", V(w * 0.1, h * 0.6, w * 0.1), CFrame.new(0, h * 0.42, -w * 0.52), pal[5], true) -- une veine de lumière, pas plus
			model.Parent = scene
			local rest = model:GetPivot()
			local hidden = rest - up * (h + 0.6)
			model:PivotTo(hidden)
			Kit.tween(o.time or 0.16, function(e) model:PivotTo(hidden:Lerp(rest, e)) end, "outBack")
			if not o.quiet then
				Fx.burst("Shiny-01", pos + up * h * 0.6, {scale = 0.35 + h * 0.05, color = pal[5]})
				Fx.light(pos + V(0, 1.5, 0), pal[5], 10 + h, 0.5, 0.5)
			end
			table.insert(ices, model)
			return model
		end
		local function shatter(model, power)
			local i = table.find(ices, model)
			if i then table.remove(ices, i) end
			if not model.Parent then return end
			Fx.burst("Shield-Break-01", model:GetPivot().Position + V(0, 1.5, 0), {scale = 0.8 * (power or 1), color = model:GetAttribute("Void") and SOUL or ICE})
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
		-- rangée de cristaux de plus en plus hauts ; rend la main quand le dernier a jailli. o.palette, o.life (ils se brisent seuls), o.spread
		local function iceLine(from, to, n, h0, h1, step, o)
			o = o or {}
			local dir = flat(to - from)
			for i = 1, n do
				local u = (i - 1) / max(n - 1, 1)
				local side = V(-dir.Z, 0, dir.X) * ((i % 2 == 0) and 1 or -1) * (o.spread or 0.7)
				local height = h0 + (h1 - h0) * u
				local spike = iceSpike(from:Lerp(to, u) + side, height, dir * height * 0.22, {palette = o.palette, quiet = i % 3 ~= 1})
				if o.life then Kit.delay(o.life, function() shatter(spike, 0.6) end) end
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
		-- glacier : une couronne de grands cristaux penchés vers l'extérieur et un pic central, d'un seul coup
		local function glacier(center, n, radius, hMin, hMax)
			for i = 1, n do
				local a = i / n * 6.283 + math.random() * 0.5
				local out = V(cos(a), 0, sin(a))
				local height = hMin + (hMax - hMin) * math.random()
				iceSpike(center + out * radius * (0.45 + 0.55 * math.random()), height, out * height * 0.3, {quiet = i > 2})
			end
			iceSpike(center + V(1.5, 0, 1), hMax * 1.15, V(0.4, 0, 0.3), {quiet = true})
			Fx.burst("Shield-01", center + V(0, hMax * 0.4, 0), {scale = 1.8, color = ICE})
			Fx.burst("Splash-01", center + V(0, 1, 0), {scale = 3, color = ICE})
			ring(center, ICE, radius * 0.4, 0.5)
			Fx.light(center + V(0, 5, 0), ICE, 50, 1.4, 0.7)
			Kit.snd(S.Ping, 0.7, 0.45) Kit.snd(S.Snap, 0.8, 0.9) Kit.shake(0.8)
		end

		------------------------------------------------ vague élémentaire qui file au sol (feu, vent, âmes)
		local function wave(from, to, dur, color, flare, done, o)
			o = o or {}
			local size = o.size or 1
			local dir = flat(to - from)
			local carrier = Instance.new("Part")
			carrier.Size = V(1, 1, 1)
			carrier.Transparency = 1
			carrier.Anchored, carrier.CanCollide, carrier.CanQuery, carrier.CanTouch = true, false, false, false
			carrier.Parent = scene
			local l = Instance.new("PointLight")
			l.Color, l.Range, l.Brightness, l.Shadows = color, 26, 5, false
			l.Parent = carrier
			local f1 = Fx.attach(flare, carrier, {scale = 1.8 * size, color = o.tint})
			local last = -1
			Kit.tween(dur, function(e)
				local p = from:Lerp(to, e) + V(0, o.lift or 2.2, 0)
				carrier.CFrame = CFrame.lookAt(p, p + dir)
				if e - last > 0.14 then
					last = e
					Fx.mesh("Shock", CFrame.lookAt(p, p + dir) * CFrame.Angles(0, 0, rad(90)) * CFrame.Angles(rad(90), 0, 0), {color = color, size0 = 0.8 * size, size1 = 1.6 * size, time = 0.25, transp0 = 0.1})
					Fx.burst(flare, p - V(0, 1.6, 0), {scale = 1.1 * size, time = 0.4, color = o.tint})
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
			a.neckSmooth = 13 -- tête amortie : elle suit ses consignes comme un ressort, sans à-coups (Kit)
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
			local to = inClearing(V(a.pos.X, ORIGIN.Y, a.pos.Z) + away * dist, 20)
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
				a:move(inClearing(to + away * 2.5, 22.5), 0.4, "outCubic")
				dust(to, 1.1) leaves(to, 6) Kit.snd(S.Thud, 0.6, 0.7) Kit.shake(0.35)
				Kit.fork(function() for _ = 1, 4 do Kit.wait(0.08) dust(a.pos, 0.6) end end)
			end)
			return inClearing(to + away * 2.5, 22.5)
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

		------------------------------------------------ outils du combat : gros impacts, traversées, projections, déplacements de la Faucheuse
		local function bigHit(h, pos, power)
			power = power or 2
			local tint = h.element.name ~= "fire" and h.color or nil
			Fx.burst(h.element.hit, pos, {scale = 1.5 * power, color = tint})
			Fx.burst(h.element.flare, pos, {scale = 1.2 * power, color = tint})
			Fx.mesh("Shockwave", CFrame.new(pos), {color = h.color, size0 = 0.2, size1 = 0.5 * power, time = 0.4, transp0 = 0.25})
			Fx.light(pos, h.color, 30 + 8 * power, 5, 0.4)
		end
		-- point de vue fixe dans la clairière (jamais dans les arbres) qui suit le milieu d'un groupe d'acteurs
		local function view(spot, actors, lookY, fov, drift)
			return function(t)
				local sum, n = Vector3.zero, 0
				for _, a in actors do if a.alive then sum += a.pos n += 1 end end
				local mid = n > 0 and sum / n or CENTER
				return Kit.look(spot + (drift or Vector3.zero) * t, V(mid.X, ORIGIN.Y + (lookY or 5), mid.Z), fov or 60)
			end
		end
		-- traversée éclair : il la traverse de part en part jusqu'à `to` et la coupe au passage (o.hit(point))
		local function pass(h, to, dur, o)
			o = o or {}
			local a = h.a
			local from = a.pos
			local dir = flat(to - from)
			a:gait(nil, 0.02)
			a:face(to, 0.04)
			a:to(H.IAI, 0.06, "outQuad", {lag = false})
			Kit.wait(0.06)
			h.trail.Enabled = true
			a:to(H.IAI_END, 0.09, "outQuart", {lag = false})
			a:move(to, dur, "outCubic")
			Kit.snd(S.Lunge, 0.6, 1.3)
			if o.lines ~= false then Kit.speedLines(dur + 0.1, 0.5) end
			local t0, cut = Kit.time, false
			while Kit.time - t0 < dur do
				Kit.ghost(a, h.color, 0.3, 0.5)
				if not cut and Kit.time - t0 >= dur * 0.25 then
					cut = true
					local mid = (from + to) / 2 + V(0, o.height or 4, 0)
					Fx.mesh("Shock", CFrame.lookAt(mid, mid + dir) * CFrame.Angles(0, 0, rad(o.tilt or 20)) * CFrame.Angles(rad(90), 0, 0), {color = h.color, size0 = 1, size1 = o.size or 5, time = 0.4, transp0 = 0})
					Kit.snd(SLASH_HIT, 0.7, 1 + math.random() * 0.2)
					if o.hit then o.hit(mid) end
				end
				Kit.wait(min(0.035, max(dur - (Kit.time - t0), 0.001)))
			end
			Kit.delay(0.12, function() h.trail.Enabled = false end)
			dust(to, 0.9) leaves(to, 3)
		end
		-- propulsé très loin : il part en vrille, se rétablit en l'air et atterrit en glissade, face à elle
		local function fling(h, to, dur, arc)
			local a = h.a
			local from = V(a.pos.X, ORIGIN.Y, a.pos.Z)
			to = inClearing(to, 19.5)
			local dir = flat(to - from)
			a:gait(nil, 0.03)
			a:watch(nil)
			a.idle = 0
			a.pos = from
			a:to(P.DOWN, 0.1, "outQuad")
			a:body({air = 1, sink = 0, roll = 0}, 0.03)
			a:face(from - dir * 10, 0.08)
			a:move(to, dur, "outQuad", {arc = arc or 5})
			a:body({pitch = math.pi * 2}, dur * 0.9, "inOut")
			local t0 = Kit.time
			while Kit.time - t0 < dur do
				Kit.ghost(a, h.color, 0.3, 0.6)
				Kit.wait(min(0.05, max(dur - (Kit.time - t0), 0.001)))
			end
			a:body({air = 0, pitch = 0}, 0)
			a.idle = 1
			a:to(H.SKID, 0.08, "outQuad")
			a:move(inClearing(to + dir * 2.5, 22), 0.25, "outCubic")
			dust(to, 1.2) leaves(to, 6, 2) ring(to, h.color, 1.2, 0.4) Kit.snd(S.Thud, 0.6, 0.9) Kit.shake(0.3)
			Kit.wait(0.25)
			dust(a.pos, 0.8)
			a:watch(reaper)
		end
		-- et il revient aussitôt, d'un trait
		local function comeBack(h, to, dur, lines)
			rush(h, to, dur or 0.25, lines)
			h.a:face(reaper, 0.08)
			h.a:to(H.GUARD, 0.2, "outBack")
		end
		-- la Faucheuse ne tient pas en place : elle file penchée en avant, une traînée d'âmes derrière elle
		local function reaperDash(to, dur, pitch)
			reaper:move(to, dur, "inOut")
			reaper:body({pitch = pitch or -0.2}, dur * 0.4, "outQuad")
			Kit.delay(dur * 0.55, function() reaper:body({pitch = 0}, dur * 0.5, "inOut") end)
			Kit.snd(S.Ghost, 0.6, 1.6)
			Kit.fork(function()
				local t0 = Kit.time
				while Kit.time - t0 < dur do
					Fx.burst("Smoke-01", reaper.pos + V(0, 2, 0), {scale = 2.6})
					Fx.light(reaper:center(-6), SOUL, 22, 1.2, 0.25)
					Kit.wait(0.05)
				end
				dust(to, 2.2) leaves(to, 6, 3)
			end)
		end
		-- ou elle disparaît dans la fumée et reparaît ailleurs
		local function reaperBlink(to, look)
			Fx.burst("Portal-Enter-01", reaper:center(-4), {scale = 3})
			Fx.burst("Smoke-01", reaper:center(-6), {scale = 4})
			Fx.light(reaper:center(-4), SOUL, 50, 5, 0.4)
			Kit.snd(S.Spark, 0.7, 0.7) Kit.snd(S.Ghost, 0.6, 2)
			reaper:fade(0, 0.1)
			Kit.wait(0.18)
			reaper:place(to, look)
			Fx.burst("Portal-01", to + V(0, 9, 0), {scale = 3})
			Fx.burst("Smoke-01", to + V(0, 3, 0), {scale = 4})
			Fx.mesh("Shockwave", CFrame.new(to + V(0, 1, 0)), {color = SOUL, size0 = 0.3, size1 = 2.2, time = 0.5, transp0 = 0.15})
			Fx.light(to + V(0, 8, 0), SOUL, 60, 6, 0.5)
			reaper:fade(1, 0.12)
			Kit.shake(0.5)
			Kit.wait(0.12)
		end

		------------------------------------------------ vol, courbes et grandes projections (les mêmes outils que le film du samouraï)
		-- rangés dans une seule table pour ne pas multiplier les variables du film
		local X = {}
		do
			local function ground(p) return V(p.X, ORIGIN.Y, p.Z) end
			local function nearAngle(target, current) return current + ((target - current + math.pi) % (2 * math.pi) - math.pi) end
			X.ground = ground
			-- le champ dégagé par l'onde : au-delà la forêt est encore debout (cimes à 81 studs)
			X.FIELD = 72
			-- ramène un point au-dessus du champ dégagé (sa hauteur est gardée)
			function X.inField(p, radius)
				local d = (p - CENTER) * FLAT
				radius = radius or X.FIELD
				if d.Magnitude > radius then d = d.Unit * radius end
				return V(CENTER.X + d.X, max(p.Y, ORIGIN.Y), CENTER.Z + d.Z)
			end
			-- la caméra ne se glisse jamais entre les arbres restés debout : dès qu'elle sort du champ, elle passe au-dessus des cimes
			function X.clear(p)
				local r = ((p - CENTER) * FLAT).Magnitude
				return V(p.X, max(p.Y, ORIGIN.Y + 2, ORIGIN.Y + clamp((r - 58) / 14, 0, 1) * 100), p.Z)
			end
			-- courbes : chaque fonction rend path(u) -> position des pieds, u de 0 à 1
			function X.bez(p0, p1, p2, p3)
				return function(u)
					local a, b, c = p0:Lerp(p1, u), p1:Lerp(p2, u), p2:Lerp(p3, u)
					return a:Lerp(b, u):Lerp(b:Lerp(c, u), u)
				end
			end
			-- de `from` à `to` en s'écartant sur le côté (side, studs ; le signe donne le côté) et en montant (rise)
			function X.curve(from, to, side, rise)
				local dir = flat(to - from)
				local off = V(-dir.Z, 0, dir.X) * (side or 0) + V(0, rise or 0, 0)
				return X.bez(from, from:Lerp(to, 0.3) + off * 1.33, from:Lerp(to, 0.7) + off * 1.33, to)
			end
			-- courbe qui part dans l'élan de l'acteur et arrive sur `to` : les enchaînements ne font pas d'angle
			function X.flow(actor, to, o)
				o = o or {}
				local from = actor.pos
				local d = (to - from).Magnitude
				local dirTo = d > 0.01 and (to - from).Unit or V(1, 0, 0)
				local perp = V(-dirTo.Z, 0, dirTo.X)
				return X.bez(from, from + (actor.flyDir or dirTo) * d * (o.carry or 0.38), to - (o.arrive or dirTo) * d * 0.3 + perp * (o.side or 0) + V(0, o.rise or 0, 0), to)
			end
			-- spirale autour d'un point ou d'un acteur : rayon r0 -> r1, angle a0 -> a1 (radians), hauteur y0 -> y1 au-dessus du sol
			function X.spiral(center, r0, r1, a0, a1, y0, y1)
				return function(u)
					local c = typeof(center) == "Vector3" and center or center.pos
					local a, r = a0 + (a1 - a0) * u, r0 + (r1 - r0) * u
					return V(c.X + cos(a) * r, ORIGIN.Y + y0 + (y1 - y0) * u, c.Z + sin(a) * r)
				end
			end
			-- vrille autour de la ligne droite from -> to
			function X.cork(from, to, radius, turns)
				local dir = (to - from).Unit
				local side = flat(V(-dir.Z, 0, dir.X))
				local up = dir:Cross(side)
				return function(u)
					local a = u * turns * 2 * math.pi
					return from:Lerp(to, u) + (side * cos(a) + up * sin(a)) * radius * sin(u * math.pi)
				end
			end
			function X.chain(a, b, split)
				return function(u)
					if u < split then return a(u / split) end
					return b((u - split) / (1 - split))
				end
			end
			-- vol le long d'une courbe : le corps se tourne dans le sens du vol, pique ou se cabre, penche dans les virages.
			-- o.lean = bascule vers l'avant ; o.ghost = couleur des silhouettes (false = aucune) ; o.yaw = "keep" : ne se tourne pas ;
			-- o.tumble = tours sur lui-même ; o.trail(p, v) le long du trajet ; o.settle = 0 : garde son attitude à l'arrivée ; o.wait = false
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
						local turn = (nearAngle(math.atan2(-v.X, -v.Z), actor.yaw) - actor.yaw) * 0.4
						actor.yaw += turn
						actor.roll += (clamp(turn * 14, -1, 1) - actor.roll) * 0.2
					end
					if o.tumble then
						actor.pitch = pitch0 + o.tumble * 2 * math.pi * u
					elseif v.Magnitude > 1e-3 then
						local elev = math.atan2(v.Y, (v * FLAT).Magnitude)
						local start = min(u / 0.12, 1)
						local stop = o.settle == 0 and 1 or min((1 - u) / (o.settle or 0.14), 1)
						actor.pitch = (elev - lean) * (o.tilt or 1) * start * stop + pitch0 * (1 - start)
					end
					if o.ghost ~= false and u - lastGhost > (o.every or 0.045) / dur then
						lastGhost = u
						Kit.ghost(actor, o.ghost or WHITE, 0.3, 0.55)
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
			-- il se pose : les pieds retrouvent le sol, le corps se redresse, les jambes amortissent
			function X.land(actor, pose, dustScale)
				actor.pos = ground(actor.pos)
				actor:body({air = 0, pitch = 0, roll = 0}, 0.08)
				if pose then actor:to(pose, 0.1, "outQuad") end
				actor:body({sink = 0.35}, 0.07, "outQuad")
				Kit.delay(0.08, function() actor:body({sink = 0}, 0.22, "outBack") end)
				dust(actor.pos, dustScale or 1) leaves(actor.pos, 4)
			end
			-- projection : emporté sur une longue distance, il tournoie, laboure le sol quand il le rase
			function X.blast(actor, to, dur, o)
				o = o or {}
				actor:gait(nil, 0.05)
				X.fly(actor, X.curve(actor.pos, to, o.side or 0, o.rise or 6), dur, {yaw = "keep", tumble = o.tumble or 1.5, ghost = o.ghost or false, ease = o.ease or "outQuad", lines = o.lines, wait = false, every = 0.06,
					trail = function(p)
						if p.Y - ORIGIN.Y < 2.2 then dust(ground(p), 0.9) leaves(ground(p), 1) end
					end,
					done = function()
						if o.crash ~= false then
							dust(ground(to), 1.6) leaves(ground(to), 5)
							Kit.snd(S.Thud, 0.6, 0.6) Kit.shake(0.4)
						end
						if o.done then o.done() end
					end})
			end
			-- glissade : repoussé debout, les pieds labourent le sol
			function X.slide(actor, to, dur, pose)
				actor:gait(nil, 0.05)
				actor:body({air = 0, pitch = 0, roll = 0}, 0.05)
				if pose then actor:to(pose, 0.12, "outQuad") end
				actor:move(ground(to), dur, "outCubic")
				Kit.fork(function()
					for _ = 1, math.floor(dur / 0.05) do
						Kit.wait(0.05)
						dust(actor.pos, 0.7) leaves(actor.pos, 1)
					end
				end)
			end
			-- caméras : accompagnement à décalage fixe, poursuite, plan d'ensemble sur un groupe
			function X.side(actor, offset, lookUp, fov, k)
				local camPos
				return function()
					local p = actor.hrp.Position
					local want = p + offset
					want = X.clear(want)
					camPos = camPos and camPos:Lerp(want, k or 0.2) or want
					return Kit.look(camPos, p + V(0, lookUp or 0, 0), fov or 58)
				end
			end
			function X.chase(actor, back, up, fov, ahead)
				local camPos, last
				return function()
					local p = actor.hrp.Position
					local v = last and (p - last) or Vector3.zero
					last = p
					local dir = (v * FLAT).Magnitude > 0.05 and flat(v) or flat(CFrame.Angles(0, actor.yaw, 0) * V(0, 0, -1))
					local want = p - dir * back + V(0, up, 0)
					want = X.clear(want)
					camPos = camPos and camPos:Lerp(want, 0.14) or want
					return Kit.look(camPos, p + dir * (ahead or 8), fov or 64)
				end
			end
			function X.group(actors, angle, elevation, fov, drift, extra, cap)
				local mid, reach
				return function(t)
					local sum, n = Vector3.zero, 0
					for _, a in actors do if a.alive then sum += a.hrp.Position n += 1 end end
					local m = n > 0 and sum / n or CENTER
					local r = 8
					for _, a in actors do if a.alive then r = max(r, (a.hrp.Position - m).Magnitude) end end
					mid = mid and mid:Lerp(m, 0.25) or m
					reach = reach and (reach + (r - reach) * 0.2) or r
					local dist = min(reach / math.tan(rad((fov or 60) * 0.5)) * 1.15 + (extra or 8), cap or 400)
					local ang, el = rad(angle) + (drift or 0) * t, rad(elevation or 20)
					local from = mid + V(cos(ang) * cos(el), sin(el), sin(ang) * cos(el)) * dist
					return Kit.look(X.clear(from), mid, fov or 60)
				end
			end
			-- gros impact (ciel ou sol) et cratère
			-- flare : l'effet du pouvoir (glace, vent) à la place de l'explosion de feu
			function X.boom(pos, color, power, flare)
				power = power or 1
				Fx.burst(flare or "Explosion-01", pos, {scale = (flare and 2.4 or 1.1) * power, time = 0.25, color = color})
				Fx.burst("Punch-02", pos, {scale = 2 * power})
				Fx.mesh("Shockwave", CFrame.new(pos), {color = color or WHITE, size0 = 0.4, size1 = 3.2 * power, time = 0.5, transp0 = 0.4})
				Fx.mesh("Sphere", CFrame.new(pos), {color = WHITE, size0 = 0.5, size1 = 2.2 * power, time = 0.3, transp0 = 0.1})
				Fx.light(pos, color or WHITE, 70 * power, 8, 0.5)
				Kit.snd(BOOM, 0.7, 1.1 + math.random() * 0.3)
				Kit.shake(0.8 * power)
			end
			function X.crater(pos, color, power)
				power = power or 1
				pos = ground(pos)
				Fx.burst("Big-Crack-01", pos + V(0, 0.6, 0), {scale = 1.3 * power, time = 0.4, color = color})
				Fx.burst("Ground-Impact", pos + V(0, 0.3, 0), {scale = 1.3 * power})
				ring(pos, color or WHITE, 7 * power, 0.6)
				for i = 1, 6 do dust(pos + V(cos(i) * 4 * power, 0, sin(i) * 4 * power), 1.6 * power) end
				leaves(pos, 8, 3)
				Kit.snd(BOOM, 0.9, 0.7) Kit.snd(S.Thud, 0.8, 0.5)
				Kit.shake(1.4 * power)
			end
			-- un sabreur traverse sa cible en volant et frappe au passage (onHit(direction, point)) ; il arrive `over` studs plus loin.
			-- point = le point du monde qu'il traverse (le corps de la Faucheuse, par exemple)
			function X.through(h, point, dur, o, onHit)
				o = o or {}
				local a = h.a
				local aim = point - V(0, a.stand * 0.55, 0)
				local through = (aim - a.pos).Unit
				local d1 = (aim - a.pos).Magnitude
				local over = o.over or 22
				local exit = through.Y < -0.1 and (flat(through) + V(0, 0.15, 0)).Unit or through
				local out = aim + exit * over + V(0, o.endRise or 0, 0)
				local split = d1 / (d1 + over)
				local path = X.chain(X.flow(a, aim, {side = o.side, rise = o.rise, arrive = through}), X.bez(aim, aim + through * over * 0.2, out - exit * over * 0.4, out), split)
				a:gait(nil, 0.03)
				a:to(H.FLY, 0.1, "outQuad")
				h.trail.Enabled = true
				X.fly(a, path, dur, {ghost = h.color, lines = o.lines, wait = false, settle = 0, ease = o.ease or "linear", every = 0.035, trail = o.trail})
				Kit.wait(max(dur * split - 0.06, 0))
				a:to(o.strike or H.HS, 0.07, "outQuart", {lag = false})
				Kit.snd(S.Swing, 0.5, 1.2)
				Kit.wait(0.06)
				onHit(through, point)
				Kit.wait(max(dur * (1 - split), 0))
			end
			-- l'onde de la Faucheuse : les arbres les plus proches (à moins de `radius` studs) basculent, se consument et disparaissent ;
			-- le reste de la forêt tient encore debout (il tombera avec la boule de feu, à la fin)
			function X.breakNear(center, radius, speed)
				for _, b in blockers do b.CanQuery = false end
				Kit.camSubject = nil
				for _, name in {"TreesNear", "TreesFar", "Lanterns", "Pumpkins"} do
					local f = scene:FindFirstChild(name)
					for _, m in f and f:GetChildren() or {} do
						if m:IsA("Model") then
							local cf0 = m:GetPivot()
							local cfb, size = m:GetBoundingBox()
							local base = ground(cfb.Position)
							local distance = ((base - CENTER) * FLAT).Magnitude
							if distance < radius then
								local away = flat(base - center)
								local small = size.Y < 12
								local axis = V(away.Z, 0, -away.X)
								local angle = small and rad(220 + math.random() * 260) or rad(72 + math.random() * 14)
								local push = small and (14 + math.random() * 22) or (1.5 + math.random() * 3)
								Kit.delay(((base - center) * FLAT).Magnitude / speed, function()
									if not m.Parent then return end
									for _, l in m:GetDescendants() do if l:IsA("Light") then l.Enabled = false end end
									Kit.tween(small and 1.0 or 0.85, function(e, u)
										local hop = small and V(0, 8 * 4 * u * (1 - u), 0) or Vector3.zero
										m:PivotTo(CFrame.new(base + away * push * e + hop) * CFrame.fromAxisAngle(axis, angle * e) * CFrame.new(-base) * cf0)
									end, small and "outQuad" or "inQuad", function()
										if not m.Parent then return end
										if small then m:Destroy() return end
										local lying = m:GetPivot()
										local depth = max(size.X, size.Z) + 6
										if math.random() < 0.5 then dust(base + away * 12, 2.4) end
										Kit.tween(0.8, function(k) m:PivotTo(lying + V(0, -depth * k, 0)) end, "inQuad", function() m:Destroy() end)
									end)
									if not small and math.random() < 0.3 then leaves(base, 5, 3) Kit.snd(S.Snap, 0.4, 0.5 + math.random() * 0.2) end
								end)
							end
						end
					end
				end
				for _, name in {"Grass", "Mist", "Wisps", "Watchers"} do -- l'herbe et la brume sont soufflées
					local f = scene:FindFirstChild(name)
					if f then
						for _, d in f:GetDescendants() do
							if d:IsA("BasePart") then d.Transparency = 1 elseif d:IsA("ParticleEmitter") or d:IsA("Light") then d.Enabled = false end
						end
					end
				end
			end
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

		------------------------------------------------ 19 - 32 s : le combat. Dashs de 15 à 35 studs, projections à travers toute la clairière,
		-- pouvoirs très gros, et la Faucheuse ne tient pas en place. Haute de 28 studs, elle reste dans la zone sans branches
		-- (x de -12 à 12, z de -8 à 12) ; les caméras restent dans la clairière, à moins de 21 studs du centre.
		local all = {rex.a, kino.a, nono.a, reaper}
		Kit.at(19.0)
		shatterAll(0.6)
		Kit.camSubject = function() return rex.a:center(1) end
		-- 1. Rex traverse la clairière d'un trait et ouvre d'un coup remontant ; les deux autres prennent les flancs
		Kit.cam(view(g(-15, -15, 10), all, 10, 72), 0.3)
		Kit.fork(function() rush(kino, g(8, 15), 0.4, false) kino.a:face(reaper, 0.1) kino.a:to(H.GUARD, 0.2, "outBack") end)
		Kit.fork(function() rush(nono, g(8, -15), 0.4, false) nono.a:face(reaper, 0.1) nono.a:to(H.GUARD, 0.2, "outBack") end)
		rush(rex, g(5.5, 0), 0.3)
		slash(rex, H.RW, H.RS, {wind = 0.07, size = 2.4, hit = function()
			local p = reaper:center(-7) + V(-3.5, 0, 0)
			wound(reaper, p, 1.6, FIRE)
			bigHit(rex, p, 2.4)
			reaper:to(R.RECOIL, 0.12)
		end})

		-- 2. elle balaie : il pare et traverse toute la clairière en vol ; elle le poursuit
		Kit.at(19.55)
		reaper:face(rex.a, 0.15)
		reaper:to(R.SWEEP_WIND, 0.22, "outQuad")
		rex.a:to(H.BLOCK, 0.15, "outQuad")
		Kit.cam(view(g(2, -17, 8), {rex.a, reaper}, 10, 72), 0.2)
		Kit.at(19.8)
		reaper:to(R.SWEEP, 0.13, "outQuart", {lag = false})
		reaper:move(g(11.5, 0), 0.12, "outQuad")
		Kit.snd(S.Lunge, 0.9, 0.5)
		Kit.at(19.9)
		clash(rex.tip(0.8), 2.2, SOUL)
		Fx.mesh("Shock", CFrame.new(reaper.pos + V(-3, 4.5, 0)), {color = SOUL, size0 = 2, size1 = 5.5, time = 0.35, transp0 = 0.1})
		ring(rex.a.pos, SOUL, 2.4, 0.5)
		Kit.snd(BOOM, 0.7, 1.2) Kit.flash(0.2, SOUL, 0.4)
		Kit.cam(view(g(-4, -18, 9), {rex.a, reaper}, 10, 72), 0.2)
		Kit.fork(function()
			fling(rex, g(-17, 2), 0.5, 6)
			comeBack(rex, g(-9, 1), 0.22)
		end)
		Kit.at(20.0)
		reaper:to(R.SLAM_WIND, 0.35, "inOut")
		reaperDash(g(0, 1), 0.42)

		-- 3. Nono275er la coupe deux fois au passage, d'un bord à l'autre de la clairière, puis lâche une lame de vent
		Kit.at(20.42)
		Kit.cam(view(g(-15, -15, 11), {reaper}, 10, 72), 0.2)
		Kit.fork(function() -- 5. pendant ce temps kinoshi112 contourne et gèle tout : une ligne de cristaux, puis un glacier qui l'enferme
			Kit.wait(0.5)
			rush(kino, g(-6, 11), 0.22, false)
			kino.a:face(reaper, 0.05)
			kino.a:to(H.VW, 0.1, "outQuad")
			Kit.wait(0.1)
			kino.a:to(merge(H.VS, {Grip = {-110}}), 0.08, "outQuart", {lag = false})
			Kit.snd(S.Swing, 0.6, 0.8)
			Fx.burst("Splash-01", kino.a:point(2), {scale = 2.5, color = ICE})
			iceLine(kino.a:point(2.5), reaper.pos + flat(kino.a.pos - reaper.pos) * 4.5, 5, 6, 13, 0.03)
			glacier(reaper.pos, 7, 6.5, 10, 17)
			wound(reaper, reaper:center(-6), 1.8, ICE)
			reaper:to(R.RECOIL, 0.14)
			reaper.haloSpeed = 0
			for _ = 1, 3 do Kit.wait(0.1) reaper:hit(0.8) end -- prise dans la glace, elle force
		end)
		pass(nono, g(-8, 15), 0.18, {tilt = -25, size = 6, hit = function()
			wound(reaper, reaper:center(-6), 1.2, WIND, false)
			bigHit(nono, reaper:center(-6), 2)
			reaper:to(R.RECOIL, 0.12)
		end})
		pass(nono, g(9, -13), 0.18, {tilt = 30, size = 6, lines = false, hit = function()
			wound(reaper, reaper:center(-3), 1.2, WIND, false)
			bigHit(nono, reaper:center(-3), 2)
		end})
		nono.a:face(reaper, 0.06)
		slash(nono, H.RW, H.RS, {wind = 0.07, size = 2})
		wave(nono.a:point(2), reaper.pos + flat(nono.a.pos - reaper.pos) * 3, 0.2, WIND, "Wind-02", function(p)
			wound(reaper, reaper:center(-5), 1, WIND, false)
			Fx.burst("Wind-01", p + V(0, 6, 0), {scale = 3.5})
			Fx.mesh("SwirlWind", CFrame.new(p + V(0, 5, 0)), {color = WIND, size0 = 1, size1 = 3, time = 0.5, transp0 = 0.4, spin = 2})
		end, {size = 2})

		-- 4. elle répond : une rangée de pics du néant file au sol vers lui ; il s'envole par-dessus
		Kit.at(21.3)
		Kit.cam(view(g(-15, -15, 11), {reaper}, 10, 72), 0.25)
		reaper:face(nono.a, 0.12)
		reaper:to(R.CAST, 0.15, "outBack")
		Kit.snd(S.Thunder, 0.5, 1.6)
		Kit.fork(function()
			local away = flat(nono.a.pos - reaper.pos)
			iceLine(reaper.pos + away * 5, nono.a.pos + away * 3, 8, 5, 12, 0.03, {palette = VOID_PALETTE, life = 0.7, spread = 1.2})
		end)
		Kit.at(21.42)
		nono.a:to(H.CROUCH, 0.06, "outQuad")
		Kit.at(21.48)
		nono.a:body({air = 1}, 0.04)
		nono.a:to(H.AIR_WIND, 0.2, "outQuad")
		nono.a:move(g(14, 7), 0.5, "linear", {arc = 10})
		nono.a:body({pitch = -math.pi * 2}, 0.46, "inOut")
		Fx.mesh("SwirlWind", CFrame.new(nono.a.pos + V(0, 2, 0)), {color = WIND, size0 = 0.8, size1 = 3, time = 0.6, transp0 = 0.4, spin = 2})
		Fx.burst("Wind-01", nono.a.pos + V(0, 1, 0), {scale = 2.4})
		leaves(nono.a.pos, 8, 2) Kit.snd(S.Lunge, 0.6, 0.9)
		Kit.fork(function() for _ = 1, 8 do Kit.ghost(nono.a, WIND, 0.3, 0.55) Kit.wait(0.06) end end)
		Kit.delay(0.5, function()
			nono.a:body({air = 0, pitch = 0}, 0)
			nono.a:to(H.LAND, 0.1, "outQuad")
			nono.a:face(reaper, 0.1)
			dust(nono.a.pos, 1) leaves(nono.a.pos, 5) Kit.snd(S.Thud, 0.5, 1.1)
			Kit.delay(0.3, function() nono.a:to(H.GUARD, 0.25, "outBack") end)
		end)

		-- 6. Rex revient d'un trait : il traverse le glacier et elle avec, tout vole en éclats
		Kit.at(21.98)
		Kit.cam(view(g(2, -18, 9), {reaper}, 10, 74), 0.2)
		pass(rex, g(15, 0.5), 0.18, {tilt = 15, size = 7, height = 5, hit = function()
			wound(reaper, reaper:center(-5), 2, FIRE)
			bigHit(rex, reaper:center(-5), 3)
			Fx.burst("Explosion-01", reaper:center(-5), {scale = 1.6, time = 0.2})
			Fx.burst("Smoke-01", reaper.pos + V(0, 3, 0), {scale = 5})
			shatterAll(1.6)
			Kit.snd(BOOM, 0.8, 1.1) Kit.flash(0.2, FIRE, 0.45) Kit.shake(1)
		end})
		rex.a:face(reaper, 0.1)
		rex.a:to(H.ZANSHIN, 0.2, "outBack")

		-- 7. elle se dégage en rugissant, puis disparaît et reparaît de l'autre côté
		Kit.at(22.4)
		reaper:to(R.ROAR, 0.2, "outBack")
		reaper.haloSpeed = 300
		Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 1, 0)), {color = SOUL, size0 = 0.4, size1 = 3.5, time = 0.6, transp0 = 0.1})
		Kit.snd(S.Thunder, 0.8, 0.9) Kit.shake(0.9)
		Kit.fork(function() skid(kino.a, reaper.pos, 7, 0.45, H.SKID) end)
		Kit.cam(view(g(15, -14, 10), all, 10, 72), 0.25)
		Kit.at(22.75)
		reaper.haloSpeed = 30
		reaperBlink(g(-2, 11), g(12, 0))
		reaper:to(R.IDLE, 0.2, "outQuad")
		rex.a:to(H.GUARD, 0.2, "outBack") kino.a:to(H.GUARD, 0.2, "outBack")

		-- 8. trois grandes lames d'âmes, lancées en glissant d'un bout à l'autre de la clairière
		Kit.at(23.15)
		reaper:to(R.CAST, 0.15, "outBack")
		reaperDash(g(-7, -6), 0.8, -0.06)
		local wallK
		local function soulBlade(h, done)
			reaper:hit(0.5)
			Kit.snd(S.Spark, 0.5, 1.6)
			wave(mark("Palm"), h.a:center(0.5), 0.3, SOUL, "Fire-02", done, {lift = 0, size = 2.2, tint = SOUL})
		end
		Kit.at(23.3)
		rex.a:face(reaper, 0.05)
		soulBlade(rex, function(p)
			Fx.burst("Explosion-01", p, {scale = 0.8, time = 0.15, color = SOUL})
			Fx.burst("Fire-Slash-01", p, {scale = 2.4})
			Kit.snd(BOOM, 0.5, 1.5) Kit.shake(0.5)
		end)
		Kit.delay(0.2, function() slash(rex, nil, H.RS, {cut = 0.1, size = 2}) end)
		Kit.at(23.45)
		kino.a:face(reaper, 0.05)
		kino.a:to(P.CAST, 0.1, "outQuad")
		wallK = iceWall(kino.a.pos + flat(reaper.pos - kino.a.pos) * 3.5, reaper.pos, 13, 12)
		soulBlade(kino, function(p)
			for _, m in wallK do shatter(m, 1.3) end
			Fx.burst("Explosion-01", p, {scale = 0.8, time = 0.15, color = SOUL})
			Kit.snd(BOOM, 0.5, 1.4) Kit.shake(0.5)
			kino.a:hit(1)
			kino.a:to(H.GUARD, 0.25, "outBack")
		end)
		Kit.at(23.6)
		soulBlade(nono, function(p)
			Fx.burst("Explosion-01", p, {scale = 0.8, time = 0.15, color = SOUL})
			Fx.burst("Crack-01", V(p.X, ORIGIN.Y + 0.15, p.Z), {scale = 2})
			Kit.snd(BOOM, 0.5, 1.6) Kit.shake(0.5)
		end)
		Kit.delay(0.14, function()
			nono.a:to(merge(H.SKID, {Waist = {-26, 0, 0}}), 0.07, "outQuad")
			dash(nono.a, g(13, -7), 0.16, WIND, false)
			nono.a:face(reaper, 0.1)
			nono.a:to(H.GUARD, 0.2, "outBack")
		end)
		-- Rex répond aussitôt : une vague de feu deux fois plus grosse
		Kit.at(23.72)
		rex.a:face(g(-7, -6), 0.05)
		slash(rex, H.HW, H.HS, {wind = 0.08, size = 2.6})
		Kit.snd(BOOM, 0.5, 1.5) Kit.shake(0.5)
		wave(rex.a:point(2.5), g(-7, -6) + flat(rex.a.pos - g(-7, -6)) * 3, 0.25, FIRE, "Fire-02", function(p)
			Fx.burst("Explosion-01", p + V(0, 6, 0), {scale = 2.2, time = 0.3})
			Fx.burst("Realistic-Explosion-01", p + V(0, 6, 0), {scale = 2.4, time = 0.3})
			ring(p, FIRE, 3, 0.5)
			Fx.light(p + V(0, 6, 0), FIRE, 70, 8, 0.6)
			Kit.snd(BOOM, 0.8, 1) Kit.shake(1.1) Kit.flash(0.2, FIRE, 0.45)
			wound(reaper, reaper:center(-5), 1.8, FIRE, false)
			reaper:to(R.RECOIL, 0.14)
		end, {size = 2.2})

		-- 9. kinoshi112 traverse la clairière et frappe ; elle bloque du manche puis le fauche : il repart en vol, se rétablit, revient
		Kit.at(24.2)
		Kit.cam(view(g(15, -14, 10), {kino.a, reaper}, 10, 72), 0.25)
		rush(kino, reaper.pos + flat(kino.a.pos - reaper.pos) * 5.5, 0.26)
		reaper:face(kino.a, 0.1)
		reaper:to(R.BLOCK, 0.12, "outQuad")
		slash(kino, H.VW, H.VS, {wind = 0.07, size = 2.2, hit = function()
			local toward = flat(reaper.pos - kino.a.pos)
			clash(kino.tip(0.8), 1.8, ICE)
			iceSpike(kino.a:point(3.5), 10, toward * 3, {quiet = true})
			iceSpike(kino.a:point(3, 2.4), 7, toward * 2, {quiet = true})
			iceSpike(kino.a:point(3, -2.4), 7, toward * 2, {quiet = true})
			Fx.burst("Shield-Break-01", kino.tip(0.8), {scale = 1.8, color = ICE})
		end})
		Kit.at(24.76)
		reaper:to(R.SWEEP_WIND, 0.12, "outQuad")
		Kit.at(24.88)
		reaper:to(R.SWEEP, 0.12, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 0.9, 0.5)
		Kit.at(24.97)
		shatterAll(1.2)
		Fx.mesh("Shock", CFrame.new(reaper.pos + V(0, 4.5, 0)), {color = SOUL, size0 = 2, size1 = 5.5, time = 0.35, transp0 = 0.1})
		clash(kino.a:center(0.5), 1.6, SOUL)
		Kit.snd(BOOM, 0.6, 1.3)
		Kit.fork(function()
			fling(kino, kino.a.pos + flat(kino.a.pos - reaper.pos) * 19, 0.5, 6)
			comeBack(kino, g(-3, 6), 0.22, false)
		end)

		-- 10. à deux : un pilier de glace jaillit sous Rex et le lance ; il plonge sur son crâne, lame en feu
		Kit.at(25.4)
		Kit.fork(function() rush(rex, g(4, -1), 0.22, false) rex.a:face(reaper, 0.08) rex.a:to(H.CROUCH, 0.2, "outQuad") end)
		Kit.cam(view(g(14, 13, 9), {rex.a, reaper}, 11, 68), 0.3)
		Kit.at(26.05)
		kino.a:face(rex.a, 0.06)
		kino.a:to(merge(H.VS, {Grip = {-110}}), 0.08, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.5, 0.8) Kit.snd(S.Ping, 0.5, 0.5)
		do
			local base = rex.a.pos
			local pillar = iceSpike(base, 14, V(0.2, 0, 0.1), {width = 4.6, time = 0.16})
			rex.a:body({air = 1}, 0.03)
			rex.a:move(base + V(0, 13.5, 0), 0.16, "outQuad")
			Kit.wait(0.2)
			-- du sommet, il bondit sur elle
			local head = reaper:center(6)
			local toHead = flat(head - base)
			rex.a:face(reaper, 0.05)
			rex.a:to(H.AIR_WIND, 0.12, "outQuad")
			rex.a:move(V(head.X, ORIGIN.Y + 16, head.Z) - toHead * 3.2, 0.26, "outQuad", {arc = 2.5})
			shatter(pillar, 1.4)
			Kit.snd(S.Lunge, 0.7, 1)
			Kit.fork(function() for _ = 1, 6 do Kit.ghost(rex.a, FIRE, 0.3, 0.5) Kit.wait(0.045) end end)
			Kit.wait(0.2)
			slash(rex, nil, H.AIR_STRIKE, {cut = 0.1, normal = V(0.2, 0.4, 1), size = 3.4, hit = function()
				wound(reaper, head, 2.2, FIRE)
				bigHit(rex, head, 3.2)
				Fx.burst("Explosion-01", head, {scale = 1.8, time = 0.2})
				Fx.burst("Fire-Slash-01", head, {scale = 3})
				Fx.light(head, FIRE, 70, 7, 0.6)
				Kit.snd(BOOM, 0.9, 1.1) Kit.flash(0.25, FIRE, 0.55) Kit.shake(1.3)
				reaper:to(R.RECOIL, 0.14)
				reaper:move(g(-11.5, -7), 0.35, "outCubic")
				reaper:body({pitch = 0.3}, 0.15, "outQuad")
				Kit.delay(0.3, function() reaper:body({pitch = 0}, 0.4, "inOut") end)
			end})
			-- il retombe en salto, devant elle
			rex.a:move(g(1, -4), 0.4, "inQuad")
			rex.a:body({pitch = math.pi * 2}, 0.36, "inOut")
			Kit.wait(0.4)
			rex.a:body({air = 0, pitch = 0}, 0)
			rex.a:to(H.LAND, 0.1, "outQuad")
			dust(rex.a.pos, 1.2) ring(rex.a.pos, FIRE, 1.4, 0.4) Kit.snd(S.Thud, 0.6, 1) Kit.shake(0.35)
			Kit.delay(0.3, function() rex.a:face(reaper, 0.1) rex.a:to(H.GUARD, 0.25, "outBack") end)
		end

		-- 11. Nono275er : la tornade. Il tourne autour d'elle d'un seul trait ; elle est soulevée et tournoie
		Kit.at(27.0)
		Kit.cam(function(t) return Kit.look(g(7 - t, 9, 9), reaper.pos + V(0, 12, 0), 68) end, 0.3)
		do
			local c, r0 = reaper.pos, 8
			rush(nono, c + V(r0, 0, 0), 0.22)
			nono.a.gaitMask = {RightShoulder = true, RightElbow = true, Grip = true, RightWrist = true}
			nono.a:gait("heroRun", 0.05)
			nono.trail.Enabled = true
			nono.a:to({RightShoulder = {88, 0, 55}, RightElbow = {6}, Grip = {-85}}, 0.1, "outQuad", {only = true})
			Fx.burst("Tornado-01", c + V(0, 0.5, 0), {scale = 1.6, time = 1.0, color = WIND})
			Fx.mesh("Tornado", CFrame.new(c + V(0, 10, 0)), {color = WIND, size0 = 1.4, size1 = 2.8, time = 1.3, transp0 = 0.5, transp1 = 1, spin = 2.5})
			Fx.mesh("SwirlWind", CFrame.new(c + V(0, 6, 0)), {color = WIND, size0 = 2, size1 = 4.5, time = 1.2, transp0 = 0.45, spin = 3})
			reaper.idle = 0
			reaper:to(R.RECOIL, 0.2)
			reaper:body({lift = 3.5}, 0.4, "outQuad")
			reaper:body({yaw = reaper.yaw + math.pi * 4}, 1.0, "inOut")
			Kit.snd(S.Lunge, 0.7, 0.6)
			for i = 1, 8 do
				local a = i * rad(58)
				local to = V(c.X + cos(a) * r0, ORIGIN.Y, c.Z + sin(a) * r0)
				nono.a:move(to, 0.11, "linear", {face = true, faceTime = 0.05})
				Kit.ghost(nono.a, WIND, 0.3, 0.5)
				Kit.wait(0.11)
				wound(reaper, reaper:center(-8 + i * 1.5) + flat(to - c) * 3, 0.8, WIND, false)
				Fx.mesh("Wind", CFrame.new(c + V(0, 2 + i * 1.6, 0)), {color = WIND, size0 = 0.8, size1 = 1.7, time = 0.4, transp0 = 0.55, spin = 3})
				leaves(to, 2)
			end
			nono.a:gait(nil, 0.08)
			nono.trail.Enabled = false
			nono.a:face(reaper, 0.1)
			nono.a:to(H.ZANSHIN, 0.2, "outBack")
			reaper:body({lift = 0}, 0.18, "inQuad")
			Kit.delay(0.18, function() dust(c, 3) Kit.snd(BOOM, 0.6, 0.9) Kit.shake(0.8) ring(c, WIND, 2.4, 0.5) end)
			reaper.idle = 1
		end

		-- 12. sa colère : elle fonce au centre en tournoyant, la faux à l'horizontale ; les trois sont projetés aux trois coins
		Kit.at(28.3)
		reaper:to(R.ROAR, 0.15, "outBack")
		reaper.haloSpeed = 320
		Kit.snd(S.Thunder, 0.8, 0.9)
		Kit.cam(function(t) return Kit.look(g(-2, -18, 16), g(-2, 0, 6), 72) end, 0.25) -- du sud, de haut : les trois partent vers l'est, le nord et l'ouest
		Kit.at(28.5)
		reaper:to(R.SWEEP, 0.15, "outQuart")
		reaperDash(g(-2, -5), 0.3, -0.1)
		reaper:body({yaw = reaper.yaw + math.pi * 2}, 0.42, "inOut")
		Kit.fork(function()
			for i = 1, 4 do
				Fx.mesh("Shock", CFrame.new(reaper.pos + V(0, 3 + i, 0)), {color = SOUL, size0 = 2, size1 = 5.5, time = 0.3, transp0 = 0.15})
				Kit.wait(0.08)
			end
		end)
		Kit.at(28.78)
		Fx.mesh("Shockwave", CFrame.new(g(-2, -5, 1)), {color = SOUL, size0 = 0.5, size1 = 4.5, time = 0.6, transp0 = 0.4})
		Kit.snd(BOOM, 0.8, 1) Kit.snd(S.Clang, 0.8, 0.9) Kit.shake(1.2) Kit.flash(0.2, SOUL, 0.45) Kit.hitstop(0.08)
		reaper.haloSpeed = 30
		for _, h in team do
			Fx.burst("Slash-Impact-01", h.a:center(0.5), {scale = 0.8, color = SOUL})
			Kit.fork(function() fling(h, h.a.pos + flat(h.a.pos - g(-2, -5)) * 19, 0.5, 6) end)
		end
		Kit.at(29.2) reaper:to(R.IDLE, 0.4, "inOut")

		-- 13. à peine retombés, ils reviennent en même temps : trois traits qui se croisent sur elle
		Kit.at(29.6)
		Kit.cam(view(g(-14, -14, 12), all, 9, 74), 0.3)
		for _, h in team do
			local tint = h.element.name ~= "fire" and h.color or nil
			h.a:face(reaper, 0.1)
			h.a:to(H.IAI, 0.25, "inOut")
			h.aura = Fx.aura(h.element.aura, h.a, {scale = 0.9, color = tint})
			ring(h.a.pos, h.color, 1.6, 0.4)
			Fx.burst(h.element.flare, h.a.pos + V(0, 0.6, 0), {scale = 2, color = tint})
		end
		Kit.snd(S.Spark, 0.5, 1.1) Kit.snd(S.Fire, 0.4, 1.4)
		Kit.at(29.95)
		Kit.speedLines(0.35, 0.8) Kit.flash(0.3, WHITE, 0.85)
		Kit.snd(S.Lunge, 0.9, 1.2) Kit.snd(SLASH_HIT, 0.9, 0.8)
		do
			local c = reaper.pos
			for i, h in team do
				local dir = flat(c - h.a.pos)
				local side = V(-dir.Z, 0, dir.X) * 3.4
				h.trail.Enabled = true
				h.a:to(H.IAI_END, 0.1, "outQuart", {lag = false})
				h.a:move(inClearing(c + dir * 12 + side, 19), 0.2, "outCubic")
				h.a:face(c + dir * 40, 0.05)
				Kit.fork(function() for _ = 1, 5 do Kit.ghost(h.a, h.color, 0.4, 0.4) Kit.wait(0.035) end end)
				local mid = c + V(0, 4 + i * 1.6, 0)
				Fx.mesh("Shock", CFrame.lookAt(mid, mid + dir) * CFrame.Angles(0, 0, rad(-30 + i * 30)) * CFrame.Angles(rad(90), 0, 0), {color = h.color, size0 = 1, size1 = 8, time = 0.5, transp0 = 0})
			end
		end
		Kit.hitstop(0.12)
		Kit.at(30.2) -- immobiles, dos à elle
		for _, h in team do h.trail.Enabled = false h.a.idle = 0.3 h.a:watch(nil) if h.aura then h.aura.stop() end end
		reaper.idle = 0.3
		Kit.cam(view(g(15, 14, 5), {reaper}, 11, 72, V(-0.4, 0, -0.3)))
		Kit.at(30.75) -- les trois coups apparaissent sur elle
		for i, h in team do
			Kit.delay((i - 1) * 0.1, function()
				local p = reaper:center(-9 + i * 3.4)
				wound(reaper, p, 1.5, h.color, i == 3)
				bigHit(h, p, 3)
			end)
		end
		Kit.at(31.1) -- elle est soufflée en arrière et s'affaisse
		reaper:to(R.RECOIL, 0.2)
		reaper:face(g(-12, 0), 0.5)
		reaper:move(g(12, 0), 0.8, "outCubic")
		reaper:body({lift = -4.5, pitch = -0.3}, 0.7, "inQuad")
		reaper.haloSpeed = 4
		Kit.snd(S.Ghost, 0.7, 0.4) Kit.shake(0.6)
		Kit.fork(function() for _ = 1, 6 do Kit.wait(0.1) dust(reaper.pos, 2.4) end end)
		Kit.at(31.4)
		for _, h in team do h.a.idle = 1 h.a:face(reaper, 0.3) h.a:to(H.ZANSHIN, 0.3, "outBack") end
		Kit.cam(view(g(-16, 4, 11), all, 5, 64), 0.4)

		-- la suite est écrite avec ses anciens repères de temps : `at` les avance. Le combat ci-dessus est plus court de 4,2 s,
		-- et deux charges ont été raccourcies plus bas (Nova creuse, aura de feu) ; la boule de feu, elle, grandit pendant 5 s.
		local skip = 4.2
		local function at(t) Kit.at(t - skip) end

		------------------------------------------------ le combat dans le ciel (ajouté) : son cri rase les arbres proches et jette les trois à cent studs ;
		-- ils volent, la traversent, sont abattus et renvoyés, l'enferment (vent, glace) pour la chute de feu, puis la traversent ensemble.
		-- Joué dans une fonction à part ; `skip` est recalé sur sa durée, la Nova reprend ensuite comme avant.
		X.skyFight = function()
			local body = V(0, 11, 0) -- du bas de sa robe (reaper.pos) au milieu de son corps
			local function tint(h) return h.element.name ~= "fire" and h.color or nil end
			local function chest() return reaper:center(-2) end
			local function till(t) if t > Kit.time then Kit.wait(t - Kit.time) end end
			-- la Faucheuse vole elle aussi : à peine penchée, une traînée d'âmes derrière elle
			local function reaperFly(path, dur, o) X.fly(reaper, path, dur, merge({lean = 0.3, tilt = 0.35, ghost = SOUL, every = 0.07}, o)) end
			-- un coup porté sur elle en plein vol : entaille, éclat du pouvoir, elle recule de quelques studs
			local function strike(h, dir, power, push)
				local p = chest()
				wound(reaper, p, power, h.color, false)
				bigHit(h, p, 2 + power)
				reaper:to(R.RECOIL, 0.1, "outQuad")
				if push > 0 then reaperFly(X.curve(reaper.pos, reaper.pos + dir * push, 0, 2), 0.3, {yaw = "keep", ghost = false, wait = false, ease = "outQuad"}) end
			end
			local function hover(h)
				h.a.flyDir = nil
				h.a:body({pitch = 0, roll = 0}, 0.15)
				h.a:to(H.HOVER, 0.25, "outBack")
				h.a:face(reaper, 0.15)
				h.a:watch(reaper)
				h.a.idle = 1.4
			end
			-- éclat du pouvoir de chacun (le feu explose, la glace éclabousse, le vent souffle)
			local function pop(h, pos, power) X.boom(pos, h.color, power, h.element.name ~= "fire" and h.element.flare or nil) end
			-- point de vue placé du côté du centre du champ : jamais dans la forêt restée debout. up = hauteur au-dessus du sol
			local function inside(p, dist, up, swing)
				local d = CFrame.Angles(0, rad(swing or 0), 0):VectorToWorldSpace(flat(CENTER - p))
				return X.clear(V(p.X, ORIGIN.Y + up, p.Z) + d * dist)
			end
			local function launch(h)
				h.a:watch(nil)
				h.a.idle = 0
				h.a.flyDir = nil
			end

			-- 0. à terre, elle hurle : l'onde rase les arbres proches et jette les trois vers le ciel
			Kit.camSubject = nil
			Kit.say("kinoshi112:  Did we get her?", 0.8)
			Kit.wait(0.55)
			Kit.fadeSound(fight, 0.55, 0.3)
			for _, h in team do h.a:watch(reaper) end
			Kit.cam(function(t) return Kit.look(g(-15 + 0.6 * t, -8, 3.5), reaper:center(-5), 64) end, 0.3)
			reaper.idle = 1
			reaper:face(g(-12, 0), 0.3)
			reaper:body({lift = 2, pitch = 0}, 0.4, "outBack")
			reaper:to(R.ROAR, 0.32, "outBack")
			reaper.haloSpeed, reaper.coreSpeed = 420, 520
			Kit.snd(S.Ghost, 0.9, 0.35) Kit.snd(S.Thunder, 0.8, 0.7)
			Kit.wait(0.45)
			Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 1, 0)), {color = SOUL, size0 = 1, size1 = 16, time = 1.2, transp0 = 0.05, ease = "outQuad"})
			Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 8, 0)), {color = WHITE, size0 = 1, size1 = 9, time = 0.9, transp0 = 0.2})
			Fx.burst("Explosion-01", chest(), {scale = 2.4, time = 0.3, color = SOUL})
			Fx.burst("Big-Crack-01", reaper.pos + V(0, 0.6, 0), {scale = 2.6, time = 0.5, color = SOUL})
			Fx.light(chest(), SOUL, 140, 7, 1)
			Kit.snd(BOOM, 1, 0.6)
			Kit.shake(2.6) Kit.flash(0.5, rgb(240, 210, 255), 0.85) Kit.hitstop(0.12)
			X.breakNear(reaper.pos, 82, 240)
			flickerAmp = 1
			local outs = {g(-64, -4, 74), g(-56, 30, 82), g(-52, -34, 90)}
			Kit.cam(function(t) return Kit.look(g(30 - 3 * t, 6, 124), g(-26, 0, 40), 74) end) -- de très haut : le cercle d'arbres qui tombe, trois corps projetés
			for i, h in team do
				h.a:watch(nil)
				h.a.idle = 0
				h.a:to(H.TUCK, 0.12, "outQuad")
				X.blast(h.a, outs[i], 0.85, {rise = 10, tumble = -1.5, ghost = h.color, crash = false, lines = i == 1 and 0.6 or nil})
			end
			Kit.wait(0.85)
			-- ils se rattrapent en plein ciel : leurs pouvoirs les portent
			Kit.cam(function(t) return Kit.look(g(-8 - t, 2, 92), g(-58, 0, 82), 70) end)
			for _, h in team do
				hover(h)
				h.aura = Fx.aura(h.element.aura, h.a, {scale = 0.9, color = tint(h)})
				pop(h, h.a:center(0), 0.6)
				local glow = Instance.new("PointLight") -- une lueur à leur couleur : on les lit de loin, même de nuit
				glow.Color, glow.Range, glow.Brightness, glow.Shadows = h.color, 28, 2.2, false
				glow.Parent = h.a.hrp
				h.glow = glow
			end
			Kit.wait(0.5)

			-- 1. elle monte à leur hauteur
			Kit.cam(function() return Kit.look(g(-76, -10, 80), chest(), 60) end) -- par-dessus l'épaule de rexydev1 : elle s'élève des ruines
			reaper:to(R.SWEEP_WIND, 0.4, "inOut")
			reaper:body({lift = 0}, 0.3)
			reaperFly(X.curve(reaper.pos, g(-18, 0, 60), 10, 6), 0.75)
			reaper:face(outs[1], 0.2)

			-- 2. ils la traversent l'un après l'autre, chacun en courbe ; le troisième, venu d'en haut, l'envoie à cent studs
			Kit.cam(X.group({reaper, rex.a, kino.a, nono.a}, 60, 18, 66, 0.2, 10))
			for i, h in {kino, nono, rex} do
				Kit.delay((i - 1) * 0.22, function()
					launch(h)
					pop(h, h.a:center(-2), 0.5)
					X.through(h, chest(), 0.5, {side = ({30, -36, 0})[i], rise = ({8, -6, 30})[i], over = 34, lines = i == 3 and 0.7 or nil}, function(dir)
						if i < 3 then
							strike(h, flat(dir), 1.4, 5)
						else
							strike(h, flat(dir), 2.2, 0)
							Kit.flash(0.2, FIRE, 0.5) Kit.hitstop(0.08)
							reaperFly(X.curve(reaper.pos, g(72, 12, 50), 0, 6), 0.75, {yaw = "keep", tumble = 0.5, wait = false, ease = "outQuad"})
						end
					end)
					hover(h)
				end)
			end
			Kit.wait(0.44 + 0.5 + 0.8)

			-- 3. sa riposte : elle disparaît, reparaît dans le dos de kinoshi112 et l'abat vers le sol, cent studs plus bas
			reaper:body({pitch = 0, roll = 0}, 0.15)
			reaper:to(R.IDLE, 0.2)
			Kit.cam(X.side(kino.a, V(24, 5, 15), 1, 64, 1))
			local kp = kino.a.pos
			reaperBlink(X.inField(kp + flat(kp - CENTER) * 8 - V(0, 9, 0), 70), kp)
			reaper.flyDir = nil
			reaper:to(R.SLAM_WIND, 0.14, "outQuad")
			kino.a:face(reaper, 0.08)
			kino.a:to(H.BLOCKHI, 0.1, "outQuad", {lag = false})
			Kit.wait(0.16)
			reaper:to(R.SLAM, 0.09, "outQuart", {lag = false})
			Kit.wait(0.08)
			clash(kino.a:center(1.5), 2.2, SOUL)
			X.boom(kino.a:center(1.5), SOUL, 1)
			local kinoDown = g(-30, 44)
			launch(kino)
			kino.a:to(P.DOWN, 0.12, "outQuad")
			Kit.cam(X.group({reaper, kino.a}, 20, 36, 66, 0, 12), 0.1)
			X.blast(kino.a, kinoDown, 0.6, {rise = 0, tumble = 1.5, ghost = ICE, ease = "inQuad", lines = 0.6, done = function()
				X.crater(kinoDown, ICE, 1)
				kino.a:body({pitch = 1.45, lift = -(kino.a.stand - 0.75)}, 0) -- sur le dos, dans son cratère
				Kit.delay(0.5, function() getUp(kino, 1.1, H.GUARD) end)
			end})
			Kit.wait(0.72)
			-- puis elle contourne Nono275er et le fauche : il traverse tout le ciel
			local np = nono.a.pos
			local outward = flat(np - CENTER)
			Kit.cam(X.group({reaper, nono.a}, 190, 20, 64, 0.3, 10))
			reaper:to(R.SWEEP_WIND, 0.16, "outQuad")
			nono.a:to(H.BLOCK, 0.3, "outQuad")
			reaperFly(X.curve(reaper.pos, X.inField(np + outward * 9, 72) - V(0, 9, 0), 18, 4), 0.42, {ease = "inQuad"})
			nono.a:face(reaper, 0.05)
			reaper:to(R.SWEEP, 0.09, "outQuart", {lag = false})
			Kit.wait(0.08)
			clash(nono.a:center(1), 2.2, SOUL)
			pop(nono, nono.a:center(1), 0.9)
			launch(nono)
			nono.a:to(H.TUCK, 0.12, "outQuad")
			Kit.cam(X.side(nono.a, V(24, 6, 20), 0, 66, 0.2))
			X.blast(nono.a, X.inField(np - outward * 100 + V(0, 6, 0), 70), 0.7, {rise = 8, tumble = -1.5, ghost = WIND, crash = false, lines = 0.6, done = function() hover(nono) end})
			Kit.wait(0.45)
			-- rexydev1 s'interpose : trois croisements à travers tout le ciel, un choc à chaque fois, ils tournent l'un autour de l'autre
			do
				local axis = flat(reaper.pos - rex.a.pos)
				Kit.cam(X.group({reaper, rex.a}, math.deg(math.atan2(axis.X, -axis.Z)), 12, 62, 0.3, 8))
			end
			reaper:body({pitch = 0, roll = 0}, 0.15)
			reaper:to(R.IDLE, 0.2)
			reaper:face(rex.a, 0.2)
			Kit.say("rexydev1:  My turn.", 0.7)
			Kit.wait(0.4)
			launch(rex)
			rex.trail.Enabled = true
			local sep = (reaper.pos + body - rex.a.pos).Magnitude
			for k = 1, 3 do
				local hFrom, bFrom = rex.a.pos, reaper.pos + body
				local dir = flat(bFrom - hFrom)
				sep = min(sep + 60, 108)
				local mid = ((hFrom + bFrom) / 2):Lerp(g(0, 0, 64), 0.5) + V(0, ({8, -6, 4})[k], 0)
				local out = CFrame.Angles(0, rad(k % 2 == 1 and 36 or -36), 0):VectorToWorldSpace(dir) -- le choc les dévie
				local hTo = X.inField(mid + out * sep / 2 + V(0, ({-6, 10, 0})[k], 0), 68)
				local bTo = X.inField(mid - out * sep / 2 + V(0, ({8, -8, -4})[k], 0), 68) - body
				local side = (k % 2 == 1 and 1 or -1) * 22
				local hMid, bMid = mid - dir * 5, mid + dir * 6 - body
				local d1, d2 = (hMid - hFrom).Magnitude, (hTo - hMid).Magnitude
				local dur = clamp((d1 + d2) / 210, 0.38, 0.62)
				local split = clamp(d1 / (d1 + d2), 0.25, 0.6)
				local camAt = X.clear(mid + V(-dir.Z, 0, dir.X) * (k == 3 and -44 or 44) + V(0, k == 3 and -10 or 10, 0)) -- de profil : ils entrent par les deux bords
				Kit.cam(k == 2 and X.chase(rex.a, 22, 9, 72, 16) or function() return Kit.look(camAt, mid, 72) end)
				rex.a:to(H.FLY, 0.08, "outQuad")
				reaper:to(k % 2 == 1 and R.SWEEP_WIND or R.SLAM_WIND, 0.12, "outQuad")
				reaperFly(X.chain(X.curve(reaper.pos, bMid, side, 3), X.curve(bMid, bTo, -side * 0.6, -3), split), dur, {wait = false, ease = "linear", settle = 0})
				X.fly(rex.a, X.chain(X.curve(hFrom, hMid, side, 3), X.curve(hMid, hTo, -side * 0.6, -3), split), dur, {ghost = FIRE, wait = false, ease = "linear", every = 0.03, settle = 0, lines = 0.7})
				Kit.wait(max(dur * split - 0.07, 0.02))
				rex.a:to(({H.HS, H.RS, H.VS})[k], 0.06, "outQuart", {lag = false})
				reaper:to(k % 2 == 1 and R.SWEEP or R.SLAM, 0.06, "outQuart", {lag = false})
				Kit.snd(S.Swing, 0.5, 1.1)
				Kit.wait(0.06)
				clash(mid + V(0, 2, 0), 1.8 + k * 0.2, WHITE)
				X.boom(mid + V(0, 2, 0), k % 2 == 1 and FIRE or SOUL, 1 + k * 0.15)
				Kit.wait(dur * (1 - split) + 0.1)
			end
			rex.trail.Enabled = false

			-- 4. à trois : le vent l'aspire en tournoyant, la glace la transperce et la fige en plein ciel, le feu tombe d'en haut
			reaper:body({pitch = 0, roll = 0}, 0.15)
			reaper:to(R.IDLE, 0.2)
			hover(rex)
			local hold = X.inField(reaper.pos, 30)
			hold = V(hold.X, ORIGIN.Y + clamp(hold.Y - ORIGIN.Y, 46, 56), hold.Z) -- le pied de la tornade
			local caught = hold + V(0, 14, 0) -- là où elle sera figée
			local cage = {}
			local t0 = Kit.time
			Kit.cam(function() return Kit.look(inside(hold, 56, hold.Y - ORIGIN.Y + 18, 35), hold + V(0, 14, 0), 66) end)
			Kit.fork(function() -- Nono275er : la tornade
				launch(nono)
				nono.a:to(H.FLY, 0.1, "outQuad")
				X.fly(nono.a, X.flow(nono.a, X.inField(reaper.pos + flat(nono.a.pos - reaper.pos) * 30 + V(0, 8, 0), 70), {side = 20}), 0.5, {ghost = WIND, lines = 0.5})
				nono.a:face(reaper, 0.08)
				slash(nono, H.HW, H.HS, {wind = 0.08, size = 3})
				Fx.mesh("Tornado", CFrame.new(hold + V(0, 12, 0)), {color = WIND, size0 = 2, size1 = 5.4, time = 1.4, transp0 = 0.4, transp1 = 1, spin = 2.5})
				Fx.mesh("Tornado", CFrame.new(hold + V(0, 24, 0)), {color = WHITE, size0 = 1.4, size1 = 3.6, time = 1.2, transp0 = 0.6, transp1 = 1, spin = -3})
				Kit.snd(S.Ghost, 0.7, 1.8) Kit.shake(0.6)
				reaper:to(R.RECOIL, 0.2)
				reaperFly(X.curve(reaper.pos, caught, 0, 0), max(t0 + 1.6 - Kit.time, 0.4), {yaw = "keep", ghost = false, wait = false})
				reaper:body({yaw = reaper.yaw + math.pi * 4}, max(t0 + 1.6 - Kit.time, 0.4), "inOut")
				hover(nono)
			end)
			Kit.fork(function() -- kinoshi112 : il décolle, tourne autour d'elle, et la glace se referme
				till(t0 + 0.25)
				launch(kino)
				kino.a:body({pitch = 0, lift = 0}, 0)
				kino.a:to(H.FLY, 0.1, "outQuad")
				pop(kino, kino.a.pos + V(0, 1, 0), 0.6)
				local level = caught.Y - ORIGIN.Y
				local a0 = math.atan2(kino.a.pos.Z - hold.Z, kino.a.pos.X - hold.X)
				X.fly(kino.a, X.flow(kino.a, caught + V(cos(a0) * 25, 0, sin(a0) * 25), {rise = 18}), 0.5, {ghost = ICE, settle = 0, ease = "outQuad", lines = 0.5})
				X.fly(kino.a, X.spiral(caught, 25, 24, a0, a0 + 2 * math.pi, level, level + 8), 0.8, {ghost = ICE, ease = "linear", every = 0.03, settle = 0,
					trail = function(p) Fx.burst("Shiny-01", p, {scale = 1.6, color = ICE}) end})
				hover(kino)
				till(t0 + 1.62)
				local center = caught + body
				for i = 1, 12 do
					local a = i / 8 * 2 * math.pi
					local dir = i <= 8 and V(cos(a), (i % 2 == 0) and 0.25 or -0.25, sin(a)).Unit or V(cos(a) * 0.6, i <= 10 and 0.8 or -0.8, sin(a) * 0.6).Unit
					local length = 15 + (i % 3) * 2
					table.insert(cage, iceSpike(center + dir * (length + 2), length, -dir * length - V(0, length, 0), {width = 3 + (i % 2), quiet = i % 3 ~= 0, time = 0.14}))
				end
				reaper.idle = 0
				reaper.haloSpeed, reaper.coreSpeed = 0, 0
				Fx.burst("Shield-01", center, {scale = 2.6, color = ICE})
				Fx.light(center, ICE, 90, 5, 0.8)
				Fx.mesh("Shockwave", CFrame.new(center), {color = ICE, size0 = 0.5, size1 = 4, time = 0.5, transp0 = 0.3})
				Kit.snd(S.Ping, 0.7, 0.45) Kit.snd(S.Snap, 0.8, 0.9) Kit.shake(0.8)
			end)
			Kit.fork(function() -- rexydev1 : il monte très haut, la lame en feu
				till(t0 + 0.6)
				launch(rex)
				rex.a:to(H.FLY, 0.1, "outQuad")
				X.fly(rex.a, X.flow(rex.a, caught + V(-6, 84, 0), {side = 24, carry = 0.3}), 0.9, {ghost = FIRE, ease = "outQuad"})
				rex.a:to(H.AIR_WIND, 0.2, "outQuad")
				rex.a:face(reaper, 0.15)
				X.rexFire = Fx.attach("Fire-01", rex.blade, {offset = CFrame.new(0, 0, -1.2), scale = 1.4})
				Fx.light(rex.a:center(1), FIRE, 60, 6, 0.6)
			end)
			till(t0 + 1.5)
			Kit.cam(X.group({reaper, kino.a, nono.a}, 110, 16, 62, 0.5, 6)) -- la glace se referme sur elle
			till(t0 + 2.0)
			Kit.cam(function() return Kit.look(rex.a:point(13, 7, -4), rex.a:center(1), 56) end) -- tout là-haut, vu d'en dessous : la lame s'embrase
			Kit.snd(S.Fire, 0.6, 1.1)
			Kit.wait(0.4)
			-- ... et il tombe comme une météorite : la glace éclate, elle est enfoncée dans le sol
			local diveCam = X.inField(hold + V(-56, 0, 30), 64) -- du côté opposé à la lune : elle est dans le champ
			diveCam = V(diveCam.X, hold.Y + 26, diveCam.Z)
			Kit.cam(function() return Kit.look(diveCam, hold + V(0, 42, 0), 76) end)
			local top = reaper:center(3)
			rex.trail.Enabled = true
			Kit.snd(S.Lunge, 0.7, 0.7)
			X.fly(rex.a, X.curve(rex.a.pos, top - V(0, rex.a.stand * 0.55, 0), 0, 0), 0.36, {ghost = FIRE, lines = 0.9, ease = "inQuad", every = 0.025, settle = 0,
				trail = function(p) Fx.burst("Fire-02", p, {scale = 2.4, time = 0.4}) end})
			rex.a:to(H.AIR_STRIKE, 0.05, "outQuart", {lag = false})
			for _, m in cage do shatter(m, 3) end
			wound(reaper, top, 2.4, FIRE)
			bigHit(rex, top, 4.5)
			X.boom(top, FIRE, 1.8)
			Kit.flash(0.3, WHITE, 0.8)
			local pit = X.ground(hold)
			Kit.cam(function(t) return Kit.look(inside(pit, 46, 12, 30), pit + V(0, 4 + 30 * (1 - min(t / 0.4, 1)), 0), 68) end)
			reaper:to(R.RECOIL, 0.1)
			reaperFly(X.curve(reaper.pos, pit, 0, 0), 0.4, {yaw = "keep", tumble = 0.75, ease = "inQuad", wait = false})
			X.fly(rex.a, X.curve(rex.a.pos, pit + V(-5, 16, 0), 0, 0), 0.4, {yaw = "keep", ghost = FIRE, ease = "inQuad", settle = 0})
			reaper:to(R.FALLEN, 0.15, "outQuad")
			reaper:body({lift = -5, pitch = -0.35}, 0.2, "outQuad")
			X.crater(pit, FIRE, 2.4)
			X.boom(pit + V(0, 4, 0), SOUL, 2)
			Fx.mesh("Shockwave", CFrame.new(pit + V(0, 1, 0)), {color = FIRE, size0 = 1, size1 = 13, time = 1.3, transp0 = 0.1, ease = "outQuad"})
			Kit.flash(0.4, WHITE, 0.9) Kit.hitstop(0.14)
			if X.rexFire then X.rexFire.stop() end
			rex.trail.Enabled = false
			rex.a:to(H.TUCK, 0.1, "outQuad") -- il rebondit en salto arrière et se pose plus loin
			local inward = flat(CENTER - pit)
			local rexLand = X.inField(pit + inward * 38, 50)
			X.blast(rex.a, rexLand, 0.6, {rise = 16, tumble = -1, ghost = FIRE, crash = false})
			Kit.wait(0.6)
			X.land(rex.a, H.SKID, 1.3)
			rex.a:face(reaper, 0.1)
			rex.a:watch(reaper)

			-- 5. elle ressort dans une colonne d'âmes et lance six lames ; les trois les esquivent en vrille
			Kit.wait(0.35)
			local behindRex = X.clear(rexLand + inward * 13 + V(-inward.Z * 5, 5, inward.X * 5))
			Kit.cam(function() return Kit.look(behindRex, pit + V(0, 20, 0), 68) end) -- derrière rexydev1 : la colonne d'âmes
			Fx.mesh("Thunder", CFrame.new(pit + V(0, 45, 0)), {color = SOUL, size0 = V(8, 90, 8), size1 = V(18, 90, 18), time = 1.0, transp0 = 0.05})
			X.boom(pit + V(0, 6, 0), SOUL, 1.6)
			Kit.snd(S.Thunder, 0.9, 0.6) Kit.snd(S.Ghost, 0.8, 0.4)
			reaper.idle = 1
			reaper.haloSpeed, reaper.coreSpeed = 520, 600
			reaper:body({lift = 0, pitch = 0}, 0.3, "outBack")
			reaper:to(R.CAST, 0.3, "outBack")
			reaperFly(X.curve(pit, pit + V(0, 24, 0), 4, 0), 0.5, {ease = "outQuad", yaw = "keep"})
			reaper:face(rex.a, 0.15)
			for k = 1, 6 do
				Kit.delay(k * 0.09, function()
					local h = team[(k - 1) % 3 + 1]
					Fx.projectile(reaper:center(2) + V(0, 6, (k - 3.5) * 5), h.a:center(0) + V(0, 0, (k % 2 - 0.5) * 8), 0.34, {color = SOUL, size = 2.2, done = function(p) X.boom(p, SOUL, 0.5) end})
					Kit.snd(S.Ghost, 0.3, 2.2)
				end)
			end
			local dodge = {g(-56, -26, 30), g(-58, 24, 38), g(-36, -52, 46)}
			for i, h in team do
				Kit.delay(0.12 + i * 0.07, function()
					launch(h)
					h.a:body({air = 1, lift = 0, pitch = 0}, 0.05)
					h.a:to(H.FLY, 0.1, "outQuad")
					X.fly(h.a, X.cork(h.a.pos, dodge[i], 7, 1.5), 0.6, {ghost = h.color, every = 0.035})
					hover(h)
				end)
			end
			Kit.wait(1.05)
			-- sa charge : elle reparaît derrière eux et les fauche l'un après l'autre ; chacun traverse tout le champ de ruines
			reaperBlink(g(-72, 4, 30), g(0, 0, 30))
			reaper.flyDir = nil
			Kit.cam(function() return Kit.look(g(-2, -6, 48), reaper:center(-2), 72) end)
			reaper:to(R.SWEEP_WIND, 0.12, "outQuad")
			local lands = {g(30, 26), g(36, -20), g(40, 4)}
			for i, h in {kino, rex, nono} do
				local target = h.a.pos
				h.a:to(H.BLOCK, 0.2, "outQuad")
				reaperFly(X.flow(reaper, target - body - flat(target - reaper.pos) * 7, {side = i % 2 == 0 and 14 or -14}), 0.27, {ease = "linear", settle = 0})
				reaper:to(i % 2 == 1 and R.SWEEP or R.SLAM, 0.07, "outQuart", {lag = false})
				clash(h.a:center(1), 2, SOUL)
				pop(h, h.a:center(1), 0.9)
				launch(h)
				h.a:to(H.TUCK, 0.1, "outQuad")
				local to = lands[i]
				X.blast(h.a, to, 0.7, {rise = 14, tumble = -1.5, ghost = h.color, crash = false, done = function()
					X.land(h.a, H.SKID, 1.3)
					h.a:face(reaper, 0.1)
					X.slide(h.a, to + V(8, 0, 0), 0.3, H.SKID)
				end})
				reaper:to(R.SWEEP_WIND, 0.1, "outQuad")
			end
			Kit.wait(0.25)
			Kit.cam(function(t) return Kit.look(g(24, -42, 7 + t), g(40, 4, 4), 66) end) -- ils retombent et labourent le sol
			Kit.delay(0.45, function()
				reaper:body({pitch = 0, roll = 0}, 0.15)
				reaper:to(R.IDLE, 0.25)
				reaperFly(X.flow(reaper, g(0, 0, 34), {rise = 10}), 0.55, {wait = false})
				Kit.delay(0.55, function() reaper:face(g(50, 0), 0.2) end)
			end)
			Kit.wait(1.05)

			-- 6. les trois ensemble : ils s'élancent et la traversent d'un même élan, chacun avec son pouvoir
			for _, h in team do h.a:to(H.GUARD, 0.25, "outBack") h.a:watch(reaper) h.a.idle = 1 end
			Kit.cam(function(t) return Kit.look(g(63, 6 - 3 * t, 5.5), g(20, 0, 17), 70) end) -- derrière eux : elle les attend dans le ciel
			Kit.say("rexydev1:  Together!", 0.9)
			Kit.wait(0.6)
			Kit.cam(function() return Kit.look(g(4, 56, 44), g(0, 0, 44), 74) end) -- de profil : trois traits de couleur la traversent
			for i, h in team do
				Kit.delay((i - 1) * 0.07, function()
					launch(h)
					pop(h, h.a.pos + V(0, 1, 0), 0.6)
					dust(h.a.pos, 1.4)
					local level = V(0, (i - 2) * 5, 0)
					X.through(h, chest() + level, 0.5, {side = ({22, -26, 12})[i], rise = ({10, 16, 24})[i], over = 60, lines = i == 1 and 0.8 or nil}, function()
						wound(reaper, chest() + level, 1.8, h.color, false)
						bigHit(h, chest() + level, 3)
					end)
					hover(h)
				end)
			end
			Kit.wait(0.42)
			X.boom(chest(), WHITE, 2)
			for i, h in team do Fx.mesh("Shockwave", CFrame.new(chest()) * CFrame.Angles(rad(40 * i), i, 0), {color = h.color, size0 = 0.5, size1 = 5, time = 0.7, transp0 = 0.2}) end
			Kit.flash(0.4, WHITE, 0.9) Kit.hitstop(0.14)
			reaper:to(R.RECOIL, 0.12)
			-- elle tombe dans la clairière et s'affaisse ; les trois reviennent se poser devant elle
			Kit.cam(function() return Kit.look(g(-20, -22, 8), chest(), 62) end)
			reaperFly(X.curve(reaper.pos, g(12, 0), 0, 0), 0.6, {yaw = "keep", tumble = 0.5, ease = "inQuad"})
			reaper:face(g(-12, 0), 0.4)
			reaper:body({lift = -4.5, pitch = -0.3}, 0.3, "outQuad")
			reaper.haloSpeed, reaper.coreSpeed = 4, 70
			X.crater(g(12, 0), SOUL, 1.6)
			Kit.snd(S.Ghost, 0.7, 0.4)
			local spots = {g(-9, 0), g(-10, -7), g(-10, 7)}
			for i, h in team do
				Kit.delay(i * 0.06, function()
					launch(h)
					h.a:to(H.FLY, 0.1, "outQuad")
					X.fly(h.a, X.flow(h.a, spots[i], {rise = 14, side = (i - 2) * 12}), 0.6, {ghost = h.color})
					X.land(h.a, H.LAND, 1.1)
					h.a:face(reaper, 0.15)
					h.trail.Enabled = false
					if h.aura then h.aura.stop() h.aura = nil end
					if h.glow then h.glow:Destroy() h.glow = nil end
					Kit.delay(0.25, function() h.a.idle = 1 h.a:to(H.ZANSHIN, 0.3, "outBack") h.a:watch(reaper) end)
				end)
			end
			Kit.wait(1.35)
			Kit.fadeSound(fight, 0.42, 0.4)
			Kit.cam(view(g(-16, 4, 11), all, 5, 64), 0.4)
		end
		do
			local t0 = Kit.time
			X.skyFight()
			skip -= Kit.time - t0
		end

		------------------------------------------------ la Nova creuse (anciens repères 36 - 43 s, avancés par `at`)
		at(36.3)
		reaper.idle = 1
		reaper:body({lift = 3.5, pitch = 0}, 0.8, "inOut")
		reaper:to(R.NOVA, 0.8, "inOut")
		reaper.haloSpeed, reaper.coreSpeed = 520, 600
		Kit.fadeSound(fight, 0.15, 0.6)
		Kit.snd(S.Spark, 0.7, 0.5) Kit.snd(S.Ghost, 0.8, 0.35)
		local coreFx = Fx.attach("Charge-01", reaperModel.Core, {scale = 2.4, color = SOUL})
		if coreLight then Kit.tween(1.1, function(e) coreLight.Brightness, coreLight.Range = 1.4 + 4 * e, 20 + 22 * e end) end
		Fx.mesh("Sphere", CFrame.new(reaper.pos + V(0, 14.5, 0)), {color = rgb(26, 6, 40), size0 = 0.3, size1 = 1.9, time = 1.1, transp0 = 0.25, transp1 = 0.05, ease = "inQuad"})
		Kit.fork(function()
			for i = 1, 5 do
				Fx.mesh("Shockwave", CFrame.new(reaper.pos + V(0, 0.6, 0)), {color = SOUL, size0 = 4.5, size1 = 0.4, time = 0.4, transp0 = 0.75, transp1 = 0.2, ease = "inQuad"})
				Kit.shake(0.2 + i * 0.05)
				Kit.wait(0.2)
			end
		end)
		flickerAmp = 3
		Kit.cam(function(t) return Kit.look(reaper.pos + V(-9 + 0.6 * t, 3, 13), reaper:center(1), 50) end, 0.4)
		-- les trois se regroupent devant elle
		Kit.fork(function() rush(rex, g(0, 0), 0.4, false) rex.a:face(reaper, 0.1) rex.a:to(H.BLOCK, 0.2, "outQuad") end)
		Kit.fork(function() rush(kino, g(-1, -4.5), 0.42, false) kino.a:face(reaper, 0.1) kino.a:to(H.BLOCK, 0.2, "outQuad") end)
		Kit.fork(function() rush(nono, g(-1, 4.5), 0.42, false) nono.a:face(reaper, 0.1) nono.a:to(H.BLOCK, 0.2, "outQuad") end)
		at(36.9)
		Kit.cam(function(t) return Kit.look(g(-9, 0.4, 2.2), reaper:center(-2), 52) end, 0.3) -- derrière eux : la sphère grossit
		skip += 0.8 -- la charge de la Nova dure 1,1 s au lieu de 1,9
		at(38.2) -- elle explose
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
		for i, h in team do landed[i] = blowBack(h, reaper.pos, 19 + i * 1.5, 0.8, 5) end
		leaves(g(0, 0), 16, 6)
		at(39.3)
		reaper:to(R.IDLE, 0.8, "inOut")
		reaper:body({lift = 0}, 1, "inOut")
		flickerAmp = 1
		at(40.0)
		Kit.cam(function(t) return Kit.look(kino.a.pos + V(-3.4, 1.3, 2.8), kino.a.pos + V(0.4, 0.7, 0), 40) end, 0.4)
		Kit.say("kinoshi112:  It's too strong...", 1.5)
		getUp(kino, 2.2, P.KNEEL)
		Kit.delay(0.5, function() getUp(nono, 2.2, P.KNEEL) end)
		at(41.3)
		Kit.fadeSound(fight, 0.4, 1.2)
		Kit.cam(function(t) return Kit.look(rex.a.pos + V(-3.6, 1.0, -2.6), rex.a.pos + V(0.3, 1.0, 0), 38) end, 0.4)
		getUp(rex, 1.5, H.GUARD)

		------------------------------------------------ 43 - 53 s : Rex fonce, elle bloque et le projette au loin
		at(43.0)
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
		at(43.84)
		rex.trail.Enabled = true
		rex.a:to(H.AIR_STRIKE, 0.09, "outQuart", {lag = false})
		Kit.snd(S.Swing, 0.7, 0.9)
		at(43.92) -- la lame s'écrase sur le manche de la faux
		clash(rex.tip(0.8), 2.4, SOUL)
		Fx.mesh("Shockwave", CFrame.new(rex.tip(0.8)), {color = WHITE, size0 = 0.3, size1 = 3.2, time = 0.5, transp0 = 0.1})
		Kit.flash(0.25, WHITE, 0.6)
		at(44.05) -- elle le repousse d'un revers
		rex.trail.Enabled = false
		reaper:to(R.SWEEP, 0.12, "outQuart", {lag = false})
		Fx.mesh("Shock", CFrame.new(reaper.pos + V(0, 7, 0)), {color = SOUL, size0 = 2, size1 = 5, time = 0.35, transp0 = 0.1})
		Kit.snd(BOOM, 0.7, 1.3) Kit.shake(1)
		Kit.cam(function(t) return Kit.look(g(-8, -20, 6), rex.a:center(0), 58) end, 0.2)
		local rexDown = blowBack(rex, reaper.pos, 25, 1.0, 5)
		at(45.2)
		Kit.say("Nono275er:  REXY!", 0.9)
		reaper:to(R.IDLE, 0.5, "inOut")
		-- elle avance sur Rex à terre ; les deux autres lui barrent la route
		at(45.6)
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
		at(47.6)
		Kit.cam(function(t) return Kit.look(rex.a.pos + V(-4.2 + 0.3 * t, 0.9, 2.6), rex.a.pos + V(0.6, 1.1, 0), 40) end, 0.5)
		rex.a:face(reaper, 0)
		getUp(rex, 3.2, H.FATIGUE)
		rex.a.idle = 2.6
		at(50.9)
		-- les deux autres s'écartent : la suite se joue entre lui et elle
		Kit.fork(function() rush(kino, g(-2, -22), 0.5, false) kino.a:face(reaper, 0.1) kino.a:to(H.GUARD, 0.3, "outBack") end)
		Kit.fork(function() rush(nono, g(-2, 22), 0.5, false) nono.a:face(reaper, 0.1) nono.a:to(H.GUARD, 0.3, "outBack") end)
		rex.a.idle = 1
		rex.a:to(H.GUARD, 0.3, "outBack")
		Kit.cam(function(t) return Kit.look(rex.a:point(4.4 - 0.8 * t, -1.2, 3.2), rex.a:center(1.2), 32) end, 0.4)
		Kit.snd(S.Ping, 0.4, 0.7)
		at(51.1) -- le feu le recouvre
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
		skip += 0.7 -- il repart 0,4 s après s'être embrasé
		at(52.2)
		Kit.cam(wide({rex.a, reaper}, 245, 10, 2, 0.04, 4, 30, 60), 0.25)
		reaper:face(rex.a, 0.3)
		reaper:to(R.SLAM_WIND, 0.45, "inOut")
		Kit.fork(function() -- traînée de flammes sous ses pas
			for _ = 1, 9 do Fx.burst("Fire-02", rex.a.pos + V(0, 0.4, 0), {scale = 0.9, time = 0.5}) Kit.wait(0.05) end
		end)
		rush(rex, reaper.pos + flat(rex.a.pos - reaper.pos) * 8, 0.5)
		at(52.74)
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
		at(52.86) -- la faux ne frappe que le sol
		Fx.burst("Big-Crack-01", gone + V(0, 0.6, 0), {scale = 1.2, time = 0.3, color = SOUL})
		Fx.burst("Ground-Impact", gone + V(0, 0.3, 0), {scale = 1.2})
		ring(gone, SOUL, 5, 0.5)
		Kit.snd(BOOM, 0.7, 0.9) Kit.shake(1.1)
		at(53.1) -- derrière elle, en l'air
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
		at(53.28) -- le coup dans le dos
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
		at(53.6)
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
		at(54.9)
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
		at(55.15) -- il saute en arrière, très haut
		local takeoff = rex.a.pos
		local apex = takeoff + flat(takeoff - reaper.pos) * 1.5 + V(0, 17, 0)
		rex.a:body({air = 1}, 0.05)
		rex.a:to(merge(H.AIR_WIND, {RightShoulder = {60, 0, 40}, LeftShoulder = {70, 0, -40}}), 0.25, "outQuad")
		rex.a:move(apex, 0.9, "outCubic")
		dust(takeoff, 1.6) leaves(takeoff, 10, 2) ring(takeoff, FIRE, 4, 0.5)
		Fx.burst("Fire-02", takeoff + V(0, 0.5, 0), {scale = 2})
		Kit.snd(S.Lunge, 0.9, 0.7) Kit.shake(0.6)
		Kit.speedLines(0.5, 0.6)
		Kit.fork(function() for _ = 1, 8 do Kit.ghost(rex.a, FIRE, 0.35, 0.55) Kit.wait(0.06) end end)
		Kit.cam(function(t) return Kit.look(takeoff + V(8, 1.5, 9), rex.a:center(0), 52) end, 0.2)
		at(55.5) -- en l'air, il rengaine
		Kit.cam(function(t) return Kit.look(rex.a:point(5.5, -2.4, -1.2), rex.a:center(0.2), 42) end, 0.3)
		rex.a:to(merge({Waist = {-6, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}, Grip = {-150}, RightHip = {30, 0, 6}, RightKnee = {-70}, LeftHip = {-10, 0, -6}, LeftKnee = {-50}, Neck = {-10, 10, 0}},
			rex.reach(rex.a.hrp.CFrame:PointToObjectSpace((rex.scabRoot.CFrame * CFrame.new(0, 0, 0.45)).Position))), 0.2, "inOut")
		if rex.bladeFx then rex.bladeFx.stop() end
		at(55.72)
		rex.sheath(0.2)
		if rex.light then rex.light.Enabled = false end
		Kit.delay(0.2, function() Kit.snd(S.Unsheath, 0.6, 0.7) end)
		at(55.98) -- la boule de feu naît au-dessus de ses mains et grandit pendant cinq secondes, à vue d'œil
		rex.a:to(P.FIREBALL, 0.2, "outBack")
		Kit.fadeSound(fight, 0.1, 0.4)
		local GROW, BALL_END = 5.0, 14 -- durée de la croissance (s) et diamètre final (studs)
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
		ballLight.Color, ballLight.Range, ballLight.Brightness, ballLight.Shadows = FIRE, 40, 5, false
		ballLight.Parent = ball
		local ballSize, ballPos, ballFree = 1, rex.a:center(4), false
		local ballFx = {}
		Kit.fork(function() -- les flammes de la bibliothèque (Ball-01, Fire-03) restent à la taille de la boule : remplacées toutes les demi-secondes
			local n = 10
			for _ = 1, n do
				if ballFree or not ball.Parent then return end
				local old = ballFx
				ballFx = {Fx.attach("Ball-01", ball, {scale = 0.3 + ballSize * 0.42}), Fx.attach("Fire-03", ball, {scale = 0.2 + ballSize * 0.26})}
				for _, f in old do f.stop() end
				Kit.wait(GROW / n)
			end
		end)
		Kit.fork(function()
			while ball.Parent and Kit.running do
				if not ballFree then ballPos = rex.a:center(3.2 + ballSize * 0.5) end
				local pulse = 1 + 0.03 * sin(Kit.time * 16)
				ball.Size, heart.Size = V(1, 1, 1) * ballSize * pulse, V(1, 1, 1) * ballSize * 0.6
				ball.CFrame = CFrame.new(ballPos) * CFrame.Angles(Kit.time * 3, Kit.time * 4, 0)
				heart.CFrame = CFrame.new(ballPos)
				task.wait()
			end
		end)
		Kit.tween(GROW, function(e)
			ballSize = 1 + (BALL_END - 1) * e
			ballLight.Range, ballLight.Brightness = 40 + 90 * e, 5 + 3 * e
		end, "linear")
		local burn = loop(S.Fire, 0.4, 0.7)
		Kit.tween(GROW, function(e) if burn then burn.PlaybackSpeed, burn.Volume = 0.7 + 0.6 * e, 0.4 + 0.5 * e end end, "linear")
		Kit.snd(S.Spark, 0.6, 0.5)
		Kit.fork(function() -- l'énergie afflue : des anneaux se referment sur elle, les feuilles montent, tout tremble de plus en plus
			for i = 1, math.floor(GROW / 0.45) do
				if ballFree or not ball.Parent then return end
				Fx.mesh("Shockwave", CFrame.new(ballPos), {color = FIRE, size0 = 0.6 + ballSize * 0.22, size1 = 0.1, time = 0.4, transp0 = 0.75, transp1 = 0.2, ease = "inQuad"})
				Fx.burst("Fire-02", takeoff + V(math.random() * 14 - 7, 0.5, math.random() * 14 - 7), {scale = 1.2, time = 0.6})
				leaves(takeoff, 3, 3)
				Kit.shake(0.12 + i * 0.07)
				if i % 3 == 0 then Kit.snd(S.Spark, 0.4, 0.6 + i * 0.05) end
				Kit.wait(0.45)
			end
		end)
		Kit.cam(function(t) return Kit.look(g(-5, -13, 5), (rex.a:center(1) + ballPos) / 2, 54 + 3 * t) end, 0.3) -- d'en bas : lui, et la boule qui grossit
		at(56.4) Kit.say("rexydev1:  My turn.", 0.9)
		at(57.6) -- de près : ses bras levés, la boule au-dessus de lui
		Kit.cam(function(t) return Kit.look(rex.a:point(6.5 + 0.5 * t, 2.2, 3.5), rex.a:center(3.5), 58) end)
		at(58.7) -- au sol, la Faucheuse se redresse et lève la tête vers elle
		reaper.idle = 0.5
		reaper:watch(rex.a, 1)
		reaper:to(R.BLOCK, 1.6, "inOut")
		reaper:body({pitch = -0.4, lift = -3.5}, 1.9, "inOut")
		Kit.snd(S.Ghost, 0.6, 0.5)
		Kit.cam(function(t) return Kit.look(g(-1 + 0.5 * t, -20, 6), g(-1, 0, 16), 84 - 2.5 * t) end) -- plan large de côté : lui et la boule d'un côté, elle de l'autre
		at(59.9) Kit.shake(0.6) Kit.snd(S.Thunder, 0.5, 1.3) -- elle est devenue énorme, toute la clairière est orange
		at(60.98) -- il la lance
		Kit.scale = 1
		Kit.cam(function(t) return Kit.look(g(22, -12, 10), reaper.pos + V(4, 9, 0), 66) end, 0.2)
		rex.a:to(P.THROW, 0.1, "outQuart", {lag = false})
		Kit.snd(S.Lunge, 1, 0.6) Kit.snd(BOOM, 0.5, 1.6)
		Kit.speedLines(0.5, 0.6)
		ballFree = true
		if burn then burn:Stop() end
		local ballFrom, target = ballPos, reaper.pos + V(0, 3, 0)
		Kit.tween(0.6, function(e)
			ballPos = ballFrom:Lerp(target, e)
			if not Kit.fast() and math.random() < 0.7 then Fx.burst("Fire-02", ballPos + V(0, ballSize * 0.3, 0), {scale = 3, time = 0.5}) end
		end, "inQuad")
		skip -= 3.33 -- la boule grandit 5 s avant d'être lancée : la suite, écrite avec ses anciens repères, est repoussée d'autant
		at(58.25) -- elle touche : tout explose, la forêt est soufflée
		for _, f in ballFx do f.stop() end
		ball:Destroy() heart:Destroy()
		Kit.fadeSound(fight, 0, 0.1)
		for _, m in {
			Fx.mesh("Sphere", CFrame.new(target), {color = rgb(255, 240, 200), size0 = 1, size1 = 7, time = 0.7, transp0 = 0, transp1 = 1}),
			Fx.mesh("Explosion", CFrame.new(target), {color = FIRE, size0 = 1.5, size1 = 15, time = 2.6, transp0 = 0.3, transp1 = 1, fadeLate = true}),
			Fx.mesh("Explosion", CFrame.new(target), {color = rgb(255, 80, 20), size0 = 1, size1 = 10, time = 2.0, transp0 = 0.35, transp1 = 1, fadeLate = true, spin = 0.2}),
		} do
			pcall(function() m.DoubleSided = true end) -- la caméra est engloutie : on voit la boule de feu de l'intérieur
		end
		Fx.mesh("Shockwave", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 1, 0)), {color = rgb(255, 210, 150), size0 = 1, size1 = 40, time = 1.9, transp0 = 0, ease = "outQuad"})
		Fx.mesh("Shockwave", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 5, 0)), {color = FIRE, size0 = 1, size1 = 22, time = 1.5, transp0 = 0.1, ease = "outQuad"})
		Fx.burst("Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Realistic-Explosion-01", target, {scale = 5, time = 0.4})
		Fx.burst("Big-Crack-01", reaper.pos + V(0, 0.6, 0), {scale = 3.2, time = 0.6})
		Fx.burst("Ground-Impact", reaper.pos + V(0, 0.3, 0), {scale = 3})
		Fx.mesh("Tornado", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 16, 0)), {color = rgb(255, 120, 30), size0 = 1.2, size1 = 4, time = 2.4, transp0 = 0.25, transp1 = 1, spin = 0.8, fadeLate = true}) -- colonne de feu
		Kit.delay(0.3, function() -- second souffle
			Fx.mesh("Shockwave", CFrame.new(target * FLAT + V(0, ORIGIN.Y + 2, 0)), {color = FIRE, size0 = 2, size1 = 44, time = 1.6, transp0 = 0.15, ease = "outQuad"})
			Fx.burst("Realistic-Explosion-01", target + V(0, 8, 0), {scale = 7, time = 0.4})
			Kit.snd(BOOM, 1, 0.4)
		end)
		Fx.light(target + V(0, 8, 0), rgb(255, 190, 110), 220, 6, 2.6)
		Kit.snd(BOOM, 1, 0.55) Kit.snd(BOOM, 1, 0.9) Kit.snd(S.Thunder, 1, 0.6)
		Kit.flash(0.9, rgb(255, 245, 225), 1) Kit.hitstop(0.2)
		Kit.cam(function(t) return Kit.look(g(22 + 0.4 * t, -14, 6), g(-12, 2, 9), 68) end, 0.1) -- un seul plan large : l'impact, les arbres qui tombent, le mur de glace
		Kit.fork(function() for i = 1, 16 do Kit.shake(3 - i * 0.17) Kit.wait(0.12) end end)
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
		breakForest(reaper.pos, 130) -- les arbres proches sont tombés pendant le combat dans le ciel : l'onde atteint vite ceux qui restent
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
		at(58.9) -- le souffle atteint le mur de glace
		if shelterWall then for _, m in shelterWall do shatter(m, 2) end end
		Fx.burst("Shield-Break-01", g(14.4, 0, 4), {scale = 2.6, color = ICE})
		Fx.mesh("SwirlWind", CFrame.new(g(18.5, 0, 2.2)), {color = WIND, size0 = 1.5, size1 = 2.6, time = 0.9, transp0 = 0.4, spin = 2})
		Kit.fork(function() skid(kino.a, reaper.pos, 4, 0.6) end)
		Kit.fork(function() skid(nono.a, reaper.pos, 4, 0.6) end)
		leaves(g(17, 0), 16, 5)
		at(60.3) -- ce qu'il reste de la forêt
		Kit.cam(function(t) return Kit.look(g(20 + 0.5 * t, -12, 12), g(-22, 6, 7), 64) end, 0.3)
		at(61.4) -- il retombe du ciel
		rex.a:to(H.AIR_STRIKE, 0.2)
		local landAt = takeoff
		rex.a:move(landAt, 0.5, "inQuad")
		Kit.cam(function(t) return Kit.look(landAt + V(8, 1.4, 6), landAt + V(0, 2.2, 0), 46) end, 0.3)
		at(61.9)
		rex.a:body({air = 0}, 0.05)
		rex.a:to(H.LAND, 0.1, "outQuad")
		dust(landAt, 2) leaves(landAt, 10, 3) ring(landAt, FIRE, 4, 0.5)
		Fx.burst("Ground-Impact", landAt + V(0, 0.3, 0), {scale = 1.4})
		Kit.snd(S.Thud, 0.9, 0.6) Kit.shake(0.9)
		rexAura.stop()

		------------------------------------------------ 62 - 72 s : ce qu'il reste d'elle, puis on rentre
		at(62.8)
		rex.a:to(P.STAND, 0.9, "inOut")
		rex.a:watch(reaper.pos + V(0, 2, 0), 1)
		local calm = loop(MUSIC_CALM, 0, 1)
		Kit.fadeSound(calm, 0.18, 2)
		Kit.fadeSound(wind, 0.25, 1)
		at(63.4) -- la faux plantée dans le cratère, les âmes s'en vont
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
		at(66.5) rex.a:face(g(17, 0), 0.6, "inOut")
		at(67.2)
		rex.a:watch(kino.a, 1)
		Kit.cam(function(t) return Kit.look(landAt + V(-4, 4.2, -15 + 0.4 * t), landAt + V(3.3, 2.2, 0), 46) end, 0.6)
		for _, h in {kino, nono} do
			h.a:to(merge({Waist = {-6, 14, 0}, LeftShoulder = {12, 0, -6}, LeftElbow = {62}, Grip = {-150}, Neck = {-10, 10, 0}}, h.reach(h.handle())), 0.45, "inOut")
			if h.bladeFx then h.bladeFx.stop() end
			if h.light then h.light.Enabled = false end
		end
		at(67.7)
		kino.sheath(0.4) nono.sheath(0.4)
		Kit.delay(0.4, function() Kit.snd(S.Unsheath, 0.5, 0.7) for _, h in {kino, nono} do h.a:to(P.STAND, 0.5, "inOut") end end)
		at(68.2)
		Kit.say("kinoshi112:  You broke the whole forest.", 1.7)
		kino.a:to(merge(P.STAND, {RightShoulder = {70, 0, 70}, RightElbow = {10}, Neck = {0, -30, 0}}), 0.35, "outBack") -- il montre les arbres couchés
		at(70.0)
		kino.a:to(P.STAND, 0.4, "inOut")
		Kit.say("rexydev1:  ...Let's go home.", 1.8)
		rex.a:to(merge(P.STAND, {RightShoulder = {30, 0, 40}, RightElbow = {95}, LeftShoulder = {30, 0, -40}, LeftElbow = {95}}), 0.3, "outBack")
		at(70.7) rex.a:to(P.STAND, 0.4, "inOut")
		at(71.6)
		Kit.fadeSound(calm, 0, 1.2)
		Kit.fade(0, 1.1)
		at(72.9)
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
