-- Animaux en mesh (tag "MeshAnimal") : anime leur squelette avec AnimalKit.AnimalAnimator dès qu'ils sont dans le monde.
-- Animaux posés dans les jardins, portés sur la tête, sortant d'un œuf, gardiens des zones : ils marchent / volent / nagent quand ils se déplacent.
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Animator = require(ReplicatedStorage:WaitForChild("AnimalKit"):WaitForChild("AnimalAnimator"))
local TAG = "MeshAnimal"
Animator.MaxDistance = 600 -- les gardiens géants se voient de loin
local STILL = {CarriedPet = true, HeldPet = true} -- portés par un joueur : ils ne « marchent » pas parce que le joueur avance
local tracked = {}

local function start(model)
	if tracked[model] or not model:IsDescendantOf(workspace) then return end
	tracked[model] = false -- en cours
	task.spawn(function()
		local root = model.PrimaryPart or model:WaitForChild("Root", 10)
		local body = model:WaitForChild("Body", 10)
		if not root or not body or not model.Parent then tracked[model] = nil return end
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
		if not ok then tracked[model] = nil return end
		tracked[model] = {Anim = anim, Root = root, Body = body, Last = root.Position, Moving = false, Speed = 0,
			Surface = body:FindFirstChildOfClass("SurfaceAppearance")}
	end)
end
local function add(model)
	if model:IsDescendantOf(workspace) then start(model) end
	model.AncestryChanged:Connect(function()
		if model:IsDescendantOf(workspace) then start(model) elseif tracked[model] then
			if tracked[model] ~= false then tracked[model].Anim:destroy() end
			tracked[model] = nil
		end
	end)
end
CollectionService:GetInstanceAddedSignal(TAG):Connect(add)
for _, model in CollectionService:GetTagged(TAG) do add(model) end

RunService.RenderStepped:Connect(function(dt)
	if dt <= 0 then return end
	local now = os.clock()
	for model, s in tracked do
		if s and s.Root.Parent then
			local pos = s.Root.Position
			local flat = Vector3.new(pos.X - s.Last.X, 0, pos.Z - s.Last.Z).Magnitude / dt
			s.Last = pos
			s.Speed += (flat - s.Speed) * math.min(1, dt * 8)
			local moving = not STILL[model.Name] and s.Speed > (s.Moving and 1 or 2.5)
			if moving ~= s.Moving then
				s.Moving = moving
				s.Anim:play(moving and "Move" or "Idle")
			end
			-- un gardien qui charge bat des pattes plus vite
			s.Anim.speed = moving and math.clamp(s.Speed / 14, 0.8, 2.2) or 1
			-- mutation Rainbow : la teinte du mesh tourne (attribut posé par EggConfig.ApplyMutation)
			if s.Surface and s.Body:GetAttribute("RainbowTint") then
				s.Surface.Color = Color3.fromHSV((now * 0.2) % 1, 0.45, 1)
			end
		elseif s then
			tracked[model] = nil
		end
	end
end)
