--Willy's File
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

local ImmuneName = "szokeeeeee1122"
local ImmuneID = 1381965313

local DamageRange = 6
local AnimalRange = 10

local AlreadyHit = false

local function HasParticles(v122, v123)
	local part = Instance.new("Part")
	part.CanCollide = false
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = false
	part.Transparency = 1
	part.CFrame = v122.CFrame * CFrame.new(0, 0.4, -3)
	part.Parent = workspace

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = v122
	weld.Part1 = part
	weld.Parent = part

	local attachClone = v123.Handle.Attachment:Clone()
	attachClone.Parent = part
	if attachClone:FindFirstChildOfClass("ParticleEmitter") then
		attachClone.ParticleEmitter:Emit(3)
	end

	task.delay(1, function()
		if part then part:Destroy() end
		if weld then weld:Destroy() end
		if attachClone then attachClone:Destroy() end
	end)
end

local function isImmune(player)
	if not player then return false end
	if player.UserId == ImmuneID then return true end
	if player.Name == ImmuneName then return true end
	return false
end

local function IsAnimal(model)
	if not model or not model:IsA("Model") then return false end
	local parent = model.Parent
	if not parent then return false end
	return parent.Name == "MovingAnimals" or parent.Name == "RenderedMovingAnimals"
end

local function DeleteAnimal(model)
	if model and model.Parent then
		local pos = model:GetPivot().Position

		local explosion = Instance.new("Explosion")
		explosion.BlastRadius = 0
		explosion.BlastPressure = 0
		explosion.Position = pos
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
		explosion.Parent = Workspace

		local boomSound = CollideSound:Clone()
		boomSound.Parent = SoundService
		boomSound:Play()

		Debris:AddItem(explosion, 5)
		Debris:AddItem(boomSound, 2)

		model:Destroy()
	end
end

local function GetBaseHitPosition(baseModel)
	local cf, size = baseModel:GetBoundingBox()
	return cf.Position - Vector3.new(0, size.Y / 2, 0)
end

Tool.Equipped:Connect(function()
	local Character = Tool.Parent
	local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
	local Animator = Humanoid and Humanoid:FindFirstChildWhichIsA("Animator")
	if Animator then
		HitAnim = Animator:LoadAnimation(Tool:WaitForChild("HitAnim"))
	end
end)

Tool.Unequipped:Connect(function()
	if HitAnim and HitAnim.IsPlaying then
		HitAnim:Stop()
	end
end)

Tool.Activated:Connect(function()
	AlreadyHit = false

	local Character = Tool.Parent
	local Player = Players:GetPlayerFromCharacter(Character)
	if not Player then return end

	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end

	if SlashSound then
		SlashSound:Play()
	end

	if HitAnim then
		HitAnim:Play()
	end

	HasParticles(Root, Tool)

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and IsAnimal(obj) then
			local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			if primary then
				local dist = (primary.Position - Root.Position).Magnitude
				if dist <= AnimalRange then
					DeleteAnimal(obj)
				end
			end
		end
	end

	local hitPlot
	local hitPodiumIndex
	local hitPos

	for _, plot in ipairs(workspace.Plots:GetChildren()) do
		local podiums = plot:FindFirstChild("AnimalPodiums")
		if podiums then
			for _, podium in ipairs(podiums:GetChildren()) do
				local base = podium:FindFirstChild("Base")
				if base and base:IsA("Model") then
					local pos = GetBaseHitPosition(base)
					local rootPos = Root.Position
					local flatRoot = Vector3.new(rootPos.X, 0, rootPos.Z)
					local flatBase = Vector3.new(pos.X, 0, pos.Z)
					local dist = (flatBase - flatRoot).Magnitude
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

	if not hitPlot or not hitPodiumIndex or not hitPos then return end

	local plotChannel = Synchronizer:Get(hitPlot.Name)
	if not plotChannel then return end

	local animalList = plotChannel:Get("AnimalList")
	if not animalList then return end

	local animalInfo = animalList[hitPodiumIndex]
	if not animalInfo or animalInfo == "Empty" then
		return
	end

	if typeof(animalInfo) == "table" and animalInfo.Steal then
		return
	end

	local owner
	for _, plr in ipairs(Players:GetPlayers()) do
		local p = PlotService.getPlot(plr)
		if p and p == hitPlot then
			owner = plr
			break
		end
	end

	if not owner then return end

	local Explosion_upvr = Instance.new("Explosion")
	Explosion_upvr.Position = hitPos
	Explosion_upvr.BlastRadius = 0
	Explosion_upvr.ExplosionType = Enum.ExplosionType.NoCraters
	Explosion_upvr.Parent = Workspace

	local boomSound = CollideSound:Clone()
	boomSound.Parent = SoundService
	boomSound:Play()

	game:GetService("Debris"):AddItem(Explosion_upvr, 5)
	game:GetService("Debris"):AddItem(boomSound, 2)

	local playerChannel = Synchronizer:Get(owner)
	if not playerChannel then return end

	local animalList = playerChannel:Get("AnimalPodiums")
	if not animalList then return end

	local animalInfo = animalList[hitPodiumIndex]
	if typeof(animalInfo) ~= "table" then return end
	if animalInfo.Steal then return end

	local animalId = animalInfo.Index
	local animalData = Animals[animalId]

	animalList[hitPodiumIndex] = "Empty"

	playerChannel:Set("AnimalPodiums", animalList)
	playerChannel:Set("AnimalAddedOrRemoved", true)
end)

Handle.Touched:Connect(function(other)
	if not HitAnim or not HitAnim.IsPlaying then return end
	if AlreadyHit then return end

	local targetPlayer = Players:GetPlayerFromCharacter(other.Parent)
	if not targetPlayer then return end
	if targetPlayer == Players:GetPlayerFromCharacter(Tool.Parent) then return end
	if targetPlayer:GetAttribute("Ragdolled") then return end
	if isImmune(targetPlayer) then return end

	AlreadyHit = true

	local character = targetPlayer.Character
	if not character then return end

	local targetRoot = character:FindFirstChild("HumanoidRootPart")
	local attackerRoot = Tool.Parent:FindFirstChild("HumanoidRootPart")
	if not targetRoot or not attackerRoot then return end

	StealService:CancelSteal(targetPlayer)
	targetPlayer:SetAttribute("Ragdolled", true)

	Ragdoll.Ragdoll(character)
	CombatService.Fling(targetRoot, 3000, attackerRoot.Position)

	task.delay(5, function()
		Ragdoll.Unragdoll(character)
		targetPlayer:SetAttribute("Ragdolled", nil)
	end)
end)