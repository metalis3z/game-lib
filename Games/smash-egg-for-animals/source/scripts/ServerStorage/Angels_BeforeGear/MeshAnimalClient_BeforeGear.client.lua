-- Animaux en mesh (tag "MeshAnimal") : anime leur squelette avec AnimalKit.AnimalAnimator dès qu'ils sont dans le monde.
-- Animaux posés dans les jardins, portés sur la tête, sortant d'un œuf, gardiens des zones : ils marchent / volent / nagent quand ils se déplacent.
-- Gardiens (attribut Rig = "Mesh") : ils se dressent et menacent avant de charger, courent, se ramassent avant de bondir.
-- Animaux ange (attribut Angel) : l'auréole suit la tête, les ailes suivent le dos et battent.
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Animator = require(ReplicatedStorage:WaitForChild("AnimalKit"):WaitForChild("AnimalAnimator"))
local BossStyles = require(ReplicatedStorage:WaitForChild("BossStyles")) -- aura, coup signature et effets propres à chaque gardien
local TAG = "MeshAnimal"
Animator.MaxDistance = 600 -- les gardiens géants se voient de loin
local STILL = {CarriedPet = true, HeldPet = true} -- portés par un joueur : ils ne « marchent » pas parce que le joueur avance
local tracked = {}

-- soudures animées d'un animal ange : auréole (AngelHalo) et pivots des ailes (AngelWing).
-- Chacune suit un os du squelette (attribut Bone) : la tête pour l'auréole, le dos pour les ailes.
local restC0 = setmetatable({}, {__mode = "k"}) -- [soudure] = sa position de repos (lue une seule fois, avant qu'on l'anime)
-- pose de repos d'un os dans le repère du mesh : le produit des CFrame de sa chaîne d'os
-- (Bone.WorldCFrame ne convient pas : il contient déjà l'animation en cours)
local function restPose(bone)
	if not bone then return nil end
	local rest, k = CFrame.new(), bone
	while k and k:IsA("Bone") do
		rest = k.CFrame * rest
		k = k.Parent
	end
	return rest
end
local function readAngel(model, s)
	local halo, wings = {}, {}
	for _, d in model:GetDescendants() do
		if d:IsA("Weld") and (d.Name == "AngelHalo" or d.Name == "AngelWing") then
			restC0[d] = restC0[d] or d.C0
			local boneName = d:GetAttribute("Bone")
			local bone = boneName and s.Body:FindFirstChild(boneName, true)
			if d.Name == "AngelHalo" then
				table.insert(halo, {Weld = d, Base = restC0[d]})
				s.HaloBone, s.HaloRest = bone, restPose(bone)
			else
				table.insert(wings, {Weld = d, Base = restC0[d], Side = d:GetAttribute("Side") or 1})
				s.WingBone, s.WingRest = bone, restPose(bone)
			end
		end
	end
	s.Halo, s.Wings = halo, wings
	if #halo > 0 then
		local sum = Vector3.zero
		for _, h in halo do sum += h.Base.Position end
		local center = sum / #halo
		s.HaloCenter = CFrame.new(center)
		s.HaloRadius = (halo[1].Base.Position - center).Magnitude
	end
	return #halo + #wings
end

-- de combien un os a bougé depuis sa pose de repos, exprimé dans le repère de la racine de l'animal
local IDENTITY = CFrame.new()
local function boneMotion(rootInverse, body, bone, rest)
	if not bone or not rest or not bone.Parent then return IDENTITY end
	return (rootInverse * bone.TransformedWorldCFrame) * (rootInverse * body.CFrame * rest):Inverse()
end

local function start(model)
	if tracked[model] ~= nil or not model:IsDescendantOf(workspace) then return end -- déjà animé, ou en cours de préparation
	tracked[model] = false -- en cours
	task.spawn(function()
		-- un animal lointain existe déjà chez le joueur, mais ses pièces n'arrivent que quand on s'approche (streaming) :
		-- s'il en manque, on abandonne ici et l'arrivée d'une pièce relancera start (voir add)
		local root = model.PrimaryPart or model:FindFirstChild("Root") or model:WaitForChild("Root", 2)
		local body = model:FindFirstChild("Body") or model:WaitForChild("Body", 2)
		local isBoss = model:GetAttribute("Rig") == "Mesh"
		if not root or not body or not model.Parent then
			tracked[model] = nil
			return
		end
		-- le mesh arrive du serveur morceau par morceau : on attend tous ses os (attribut Bones) avant de lire le squelette
		local expected, waited = model:GetAttribute("Bones") or 1, 0
		local function bones()
			local n = 0
			for _, d in body:GetDescendants() do if d:IsA("Bone") then n += 1 end end
			return n
		end
		while bones() < expected and waited < 12 do waited += task.wait(0.15) end
		if not model.Parent or not model:IsDescendantOf(workspace) then tracked[model] = nil return end
		local ok, anim = pcall(Animator.new, model)
		if not ok then
			if isBoss then warn("[MeshAnimalClient] " .. model.Name .. " : l'animateur a planté : " .. tostring(anim)) end
			tracked[model] = nil
			return
		end
		local s = {Anim = anim, Root = root, Body = body, Last = root.Position, Moving = false, Speed = 0, Seed = math.random() * 10,
			Surface = body:FindFirstChildOfClass("SurfaceAppearance"), Halo = {}, Wings = {}, Boss = model:GetAttribute("Rig") == "Mesh", Want = "Idle"}
		if s.Boss then
			-- gardiens géants : la tête bouge très peu, avec un petit regard de côté toutes les 5 secondes environ
			anim.headCalm, anim.accentGap, anim.accentJitter = 0.2, 5, 1
			-- le corps se balance moitié moins, la tête reste droite quand le corps bouge, et elle bouge peu pendant un rugissement ou un coup
			anim.bodyCalm, anim.headSteady, anim.gestureHead = 0.5, 0.85, 0.3
		end
		if model:GetAttribute("Angel") then
			-- les soudures peuvent arriver après le reste : on relit quelques fois (un animal qui sort d'un œuf n'en a pas, il est tout ancré)
			s.AngelExpected = model:GetAttribute("AngelParts") or 0
			s.AngelTries = 0
			if readAngel(model, s) >= s.AngelExpected then s.AngelExpected = nil end
		end
		tracked[model] = s
		if s.Boss then
			local okStyle, styleErr = pcall(BossStyles.register, model, anim)
			if not okStyle then warn("[MeshAnimalClient] BossStyles : " .. tostring(styleErr)) end

		end
	end)
end
local function add(model)
	if model:IsDescendantOf(workspace) then start(model) end
	model.ChildAdded:Connect(function(child) -- une pièce vient d'arriver (on s'est approché) : l'animal peut être animé
		if (child.Name == "Root" or child.Name == "Body") and tracked[model] == nil then start(model) end
	end)
	model.AncestryChanged:Connect(function()
		if model:IsDescendantOf(workspace) then start(model) elseif tracked[model] then
			if tracked[model] ~= false then tracked[model].Anim:destroy() end
			tracked[model] = nil
		end
	end)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(add)
for _, model in CollectionService:GetTagged(TAG) do add(model) end
-- filet de sécurité (streaming) : la racine peut arriver après le corps sans que rien ne relance l'animation.
-- Toutes les secondes, tout animal du monde qui n'est pas encore animé est repris.
task.spawn(function()
	while true do
		task.wait(1)
		for _, model in CollectionService:GetTagged(TAG) do
			if tracked[model] == nil and model:IsDescendantOf(workspace) then start(model) end
		end
	end
end)

local lastAngelScan = 0
RunService.RenderStepped:Connect(function(dt)
	if dt <= 0 then return end
	local now = os.clock()
	local rescan = now - lastAngelScan > 0.5
	if rescan then lastAngelScan = now end
	for model, s in tracked do
		if s and s.Root.Parent then
			local pos = s.Root.Position
			local flat = Vector3.new(pos.X - s.Last.X, 0, pos.Z - s.Last.Z).Magnitude / dt
			s.Last = pos
			s.Speed += (flat - s.Speed) * math.min(1, dt * 8)
			local moving = not STILL[model.Name] and s.Speed > (s.Moving and 1 or 2.5)
			s.Moving = moving
			local want = moving and "Move" or "Idle"
			if s.Boss then
				-- gardien : menace quand il repère un voleur, course pendant la charge, saut ramassé puis bond
				local chasing = model:GetAttribute("Chasing") == true
				if chasing and not s.Chasing then s.Anim:gesture("Roar", 0.9) end
				s.Chasing = chasing
				local jump = model:GetAttribute("Jump") == true
				if jump and not s.Jump then s.Anim:gesture("Crouch", 0.4) end
				s.Jump = jump
				if model:GetAttribute("Flying") then want = "Leap" elseif moving and chasing then want = "Run" end
				s.Anim.speed = moving and math.clamp(s.Speed / 24, 0.8, 2) or 1 -- les foulées suivent sa vitesse
			else
				s.Anim.speed = moving and math.clamp(s.Speed / 14, 0.8, 2.2) or 1
			end
			if want ~= s.Want then
				s.Want = want
				s.Anim:play(want)
			end
			-- mutation Rainbow : la teinte du mesh tourne (attribut posé par EggConfig.ApplyMutation)
			if s.Surface and s.Body:GetAttribute("RainbowTint") then
				s.Surface.Color = Color3.fromHSV((now * 0.2) % 1, 0.45, 1)
			end
			-- ange : l'auréole suit la tête (elle tourne et flotte un peu), les ailes suivent le dos et battent, plus fort en mouvement
			if s.AngelExpected and rescan then
				s.AngelTries += 1
				if readAngel(model, s) >= s.AngelExpected or s.AngelTries > 16 then s.AngelExpected = nil end
			end
			if #s.Halo > 0 or #s.Wings > 0 then
				local rootInverse = s.Root.CFrame:Inverse()
				if s.HaloCenter and #s.Halo > 0 then
					local turn = boneMotion(rootInverse, s.Body, s.HaloBone, s.HaloRest) * CFrame.new(0, math.sin(now * 2 + s.Seed) * s.HaloRadius * 0.1, 0)
						* s.HaloCenter * CFrame.Angles(0, now * 0.9, 0) * s.HaloCenter:Inverse()
					for _, h in s.Halo do h.Weld.C0 = turn * h.Base end
				end
				if #s.Wings > 0 then
					local follow = boneMotion(rootInverse, s.Body, s.WingBone, s.WingRest)
					local flap = moving and (math.sin(now * 9 + s.Seed) * 0.42 + 0.1) or (math.sin(now * 2.4 + s.Seed) * 0.16)
					for _, w in s.Wings do w.Weld.C0 = follow * w.Base * CFrame.Angles(0, 0, w.Side * flap) end
				end
			end
		elseif s then
			tracked[model] = nil
		end
	end
end)
