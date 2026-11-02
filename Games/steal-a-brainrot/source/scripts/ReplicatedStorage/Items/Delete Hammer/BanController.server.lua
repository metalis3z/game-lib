local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animals = require(ReplicatedStorage.Datas.Animals)

local PlotService = require(ServerScriptService.Services.PlotService)
local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)
local Ragdoll = require(game.ReplicatedStorage.Packages.Ragdoll)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local SlashSound = Tool:WaitForChild("Slash")
local CollideSound = game.ReplicatedStorage.Sounds.Sfx:WaitForChild("Collide")

local HitAnim

local ImmuneID = 1381965313

local DamageRange = 6
local AnimalRange = 10

local AlreadyHit = false

local function HasParticles(root, tool)
	local part = Instance.new("Part")
	part.CanCollide = false
	part.Size = Vector3.new(1,1,1)
	part.Transparency = 1
	part.CFrame = root.CFrame * CFrame.new(0,0.4,-3)
	part.Parent = workspace

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = root
	weld.Part1 = part
	weld.Parent = part

	local attach = tool.Handle.Attachment:Clone()
	attach.Parent = part

	local emitter = attach:FindFirstChildOfClass("ParticleEmitter")
	if emitter then
		emitter:Emit(3)
	end

	task.delay(1, function()
		part:Destroy()
	end)
end

local function isImmune(player)
	return player and player.UserId == ImmuneID
end

local function IsAnimal(model)
	if not model or not model:IsA("Model") then return false end
	local parent = model.Parent
	return parent and (parent.Name == "MovingAnimals" or parent.Name == "RenderedMovingAnimals")
end

local function DeleteAnimal(model)
	if not model or not model.Parent then return end

	local pos = model:GetPivot().Position

	local explosion = Instance.new("Explosion")
	explosion.Position = pos
	explosion.BlastRadius = 0
	explosion.BlastPressure = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.Parent = Workspace

	local sound = CollideSound:Clone()
	sound.Parent = SoundService
	sound:Play()

	Debris:AddItem(explosion, 5)
	Debris:AddItem(sound, 2)

	model:Destroy()
end

local function GetBaseHitPosition(baseModel)
	if baseModel.PrimaryPart then
		return baseModel.PrimaryPart.Position
	end

	local part = baseModel:FindFirstChildWhichIsA("BasePart")
	if part then
		return part.Position
	end

	return baseModel:GetPivot().Position
end

Tool.Equipped:Connect(function()
	local humanoid = Tool.Parent:FindFirstChildWhichIsA("Humanoid")
	local animator = humanoid and humanoid:FindFirstChildWhichIsA("Animator")
	if animator then
		HitAnim = animator:LoadAnimation(Tool:WaitForChild("HitAnim"))
	end
end)

Tool.Unequipped:Connect(function()
	if HitAnim and HitAnim.IsPlaying then
		HitAnim:Stop()
	end
end)

Tool.Activated:Connect(function()
	AlreadyHit = false

	local character = Tool.Parent
	local player = Players:GetPlayerFromCharacter(character)
	if not player then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if SlashSound then SlashSound:Play() end
	if HitAnim then HitAnim:Play() end

	HasParticles(root, Tool)

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and IsAnimal(obj) then
			local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			if primary then
				local dist = (primary.Position - root.Position).Magnitude
				if dist <= AnimalRange then
					DeleteAnimal(obj)
				end
			end
		end
	end

	local hitPlot, hitPodiumIndex, hitPos

	for _, plot in ipairs(workspace.Plots:GetChildren()) do
		local podiums = plot:FindFirstChild("AnimalPodiums")
		if podiums then
			for _, podium in ipairs(podiums:GetChildren()) do
				local base = podium:FindFirstChild("Base")
				if base and base:IsA("Model") then
					local pos = GetBaseHitPosition(base)
					local dist = (pos - root.Position).Magnitude

					if dist <= DamageRange then
						hitPlot = plot
						hitPodiumIndex = tonumber(podium.Name)
						hitPos = pos
						break
					end
				end
			end
		end
		if hitPlot then break end
	end

	if not hitPlot or not hitPodiumIndex then return end

	local owner
	for _, plr in ipairs(Players:GetPlayers()) do
		if PlotService.getPlot(plr) == hitPlot then
			owner = plr
			break
		end
	end

	if not owner then return end

	local channel = Synchronizer:Get(owner)
	if not channel then return end

	local list = channel:Get("AnimalPodiums")
	if not list then return end

	local info = list[hitPodiumIndex]
	if not info or typeof(info) ~= "table" then return end
	if info.Steal then return end

	local explosion = Instance.new("Explosion")
	explosion.Position = hitPos
	explosion.BlastRadius = 0
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.Parent = Workspace

	local sound = CollideSound:Clone()
	sound.Parent = SoundService
	sound:Play()

	Debris:AddItem(explosion, 5)
	Debris:AddItem(sound, 2)

	list[hitPodiumIndex] = "Empty"
	channel:Set("AnimalPodiums", list)
	channel:Set("AnimalAddedOrRemoved", true)
end)

Handle.Touched:Connect(function(other)
	if not HitAnim or not HitAnim.IsPlaying then return end
	if AlreadyHit then return end

	local target = Players:GetPlayerFromCharacter(other.Parent)
	if not target then return end
	if target == Players:GetPlayerFromCharacter(Tool.Parent) then return end
	if target:GetAttribute("Ragdolled") then return end
	if isImmune(target) then return end

	AlreadyHit = true

	local char = target.Character
	local targetRoot = char and char:FindFirstChild("HumanoidRootPart")
	local attackerRoot = Tool.Parent:FindFirstChild("HumanoidRootPart")

	if not targetRoot or not attackerRoot then return end

	StealService:CancelSteal(target)
	target:SetAttribute("Ragdolled", true)

	Ragdoll.Ragdoll(char)
	CombatService.Fling(targetRoot, 3000, attackerRoot.Position)

	task.delay(5, function()
		Ragdoll.Unragdoll(char)
		target:SetAttribute("Ragdolled", nil)
	end)
end)