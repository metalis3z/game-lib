local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local PlotService = require(game.ServerScriptService.Services.PlotService)
local StealService = require(game.ServerScriptService.Services.StealService)
local NotificationService = require(script.Parent.Parent.Parent.NotificationService)

local animalChances = {
	["Dul Dul Dul"] = 20,
	["Sammyni Spyderini"] = 20,
	["Bisonte Giuppitere"] = 20,
	["Los Bombinitos"] = 10,
	["Tartaruga Cisterna"] = 10,
	["Pakrahmatmamat"] = 10,
	["Brainrot God Lucky Block"] = 30,
	["Secret Lucky Block"] = 5,
	["Admin Lucky Block"] = 30,
	["Los Taco Blocks"] = 30,
	["Los Lucky Blocks"] = 30,

	["Chicleteira Bicicleteira"] = 2,
	["Arcadopus"] = 0.5,
	["La Grande Combinasion"] = 0.3,
	["Mariachi Corazoni"] = 0.1,
	["Money Money Puggy"] = 0.05
}

local Phase = {}

local activeConnections = {}
local timerThread = nil
local isActive = false
local clonedSteps = nil
local clonedBase = nil

local function getRandomAnimalByChance()
	local totalWeight = 0

	for _, weight in pairs(animalChances) do
		totalWeight += weight
	end

	local roll = math.random() * totalWeight
	local current = 0

	for animalName, weight in pairs(animalChances) do
		current += weight
		if roll <= current then
			return animalName
		end
	end
end

local function addoverhead(animalName: string, spawnPart: BasePart, model: Model): Model
	local animalData = animals[animalName]
	if not animalData then
		return model
	end

	local attachment = model:FindFirstChild("OVERHEAD_ATTACHMENT", true) :: Attachment?
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Position = Vector3.new(0, model:GetExtentsSize().Y * 0.75 * (animalData.OverheadYOffsetModifier or 1), 0)
		attachment.Name = "OVERHEAD_ATTACHMENT"
		attachment.Parent = spawnPart
	end

	local overhead: Model = ReplicatedStorage.Overheads.AnimalOverhead:Clone()
	local sharedAnimals = require(game.ReplicatedStorage.Shared.Animals)
	overhead.Generation.Text = ("$%*/s"):format(NumberUtils:ToString(sharedAnimals:GetGeneration(animalName)))
	overhead.DisplayName.Text = animalData.DisplayName or animalName
	overhead.Price.Text = "$" .. NumberUtils:ToString(animalData.Price or 0)
	overhead.Rarity.Text = animalData.Rarity or "Common"

	if Rarities[animalData.Rarity] then
		overhead.Rarity.TextColor3 = Rarities[animalData.Rarity].Color
		if Rarities[animalData.Rarity].StrokeColor then
			overhead.Rarity.UIStroke.Color = Rarities[animalData.Rarity].StrokeColor
		end
		if Rarities[animalData.Rarity].GradientPreset then
			Trove.new():Add(Gradients.apply(overhead.Rarity, Rarities[animalData.Rarity].GradientPreset))
		end
	end

	overhead.Mutation.Visible = false
	overhead.Parent = attachment
	return overhead
end

local function addAnimal(base: Model, podiumIndex: number, animalName: string)
	local podiums = base.AnimalPodiums:GetChildren()
	local podium = podiums[podiumIndex]

	if not podium then
		return
	end

	local animalTemplate = ReplicatedStorage.Models.Animals:FindFirstChild(animalName) :: Model?
	if not animalTemplate then
		return
	end

	local animalClone = animalTemplate:Clone()

	local spawnPart = podium:FindFirstChild("Base") and podium.Base:FindFirstChild("Spawn") 
		or podium:FindFirstChild("Spawn") 
		or podium:FindFirstChildWhichIsA("BasePart")

	if not spawnPart then
		animalClone:Destroy()
		return
	end

	local mutationList = {"Gold", "Diamond"}
	local shouldApplyMutation = math.random() < 0.15
	local selectedMutation = nil

	if shouldApplyMutation then
		selectedMutation = mutationList[math.random(1, #mutationList)]
		local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
		SharedAnimals:ApplyMutation(animalClone, animalName, selectedMutation)
	end

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Steal"
	prompt.ObjectText = animalName
	prompt.HoldDuration = 1.5
	prompt.MaxActivationDistance = 10
	prompt.Parent = spawnPart

	animalClone:PivotTo(spawnPart:GetPivot())
	if not animalClone.PrimaryPart then
		local p = animalClone:FindFirstChildWhichIsA("BasePart", true)
		if p then
			animalClone.PrimaryPart = p
		end
	end

	animalClone:PivotTo(spawnPart:GetPivot())
	animalClone.Parent = base

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = spawnPart
	weld.Part1 = animalClone.PrimaryPart
	weld.Parent = spawnPart

	for _, part in ipairs(animalClone:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.CanCollide = false
		end
	end

	animalClone.Parent = base

	local anim: Animation? = ReplicatedStorage.Animations.Animals:FindFirstChild(animalClone.Name) 
		and ReplicatedStorage.Animations.Animals[animalClone.Name]:FindFirstChild("Idle") :: Animation?

	if anim and animalClone:FindFirstChild("AnimationController") then
		local animator = animalClone.AnimationController:FindFirstChildWhichIsA("Animator")
		if animator then
			animator:LoadAnimation(anim):Play()
		end
	end

	local overhead = addoverhead(animalName, spawnPart, animalClone)

	if selectedMutation and overhead then
		local mutationData = Mutations[selectedMutation]

		if mutationData then
			if mutationData.UseRichText then
				overhead.Mutation.RichText = true
				overhead.Mutation.Text = mutationData.DisplayWithRichText
			else
				overhead.Mutation.Text = mutationData.DisplayText
			end

			if mutationData.GradientPreset then
				Trove.new():Add(Gradients.apply(overhead.Mutation, mutationData.GradientPreset))
			else
				overhead.Mutation.TextColor3 = mutationData.MainColor
			end

			overhead.Mutation.Visible = true
		end
	end

	prompt.Triggered:Connect(function(player)
		if PlotService:IsBaseFull(player) then
			NotificationService.Error(player, "You need more room in your base to steal a brainrot.")
			return
		end

		for _, part in ipairs(animalClone:GetDescendants()) do
			if part:IsA("BasePart") and part ~= animalClone.PrimaryPart then
				if part:GetAttribute("DefaultTransparency") == nil then
					part:SetAttribute("DefaultTransparency", part.Transparency)
				end
				if part.Transparency < 1 then
					part.Transparency = 0.5
				end
			end
		end

		if overhead then
			overhead.DisplayName.Visible = false
			overhead.Generation.Visible = true
			overhead.Mutation.Visible = false
			overhead.Price.Visible = false
			overhead.Rarity.Visible = false
			overhead.Stolen.Visible = true
		end

		if prompt then
			prompt.Enabled = false
		end

		local success = StealService:SimulateSteal(player.Name, animalName, animalClone, overhead, prompt, selectedMutation)

		if not success then
			for _, part in ipairs(animalClone:GetDescendants()) do
				if part:IsA("BasePart") and part ~= animalClone.PrimaryPart then
					local defaultTransparency = part:GetAttribute("DefaultTransparency")
					if defaultTransparency ~= nil and defaultTransparency < 1 then
						part.Transparency = defaultTransparency
					end
				end
			end

			if overhead then
				overhead.DisplayName.Visible = true
				overhead.Generation.Visible = true
				overhead.Mutation.Visible = selectedMutation ~= nil
				overhead.Price.Visible = true
				overhead.Rarity.Visible = true
				overhead.Stolen.Visible = false
			end

			if prompt then
				prompt.Enabled = true
			end
		end
	end)
end

local function shuffle<T>(tbl: {T})
	for i = #tbl, 2, -1 do
		local j = math.random(1, i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
end

local function baseSetup(base: Model)
	local podiums = base.AnimalPodiums:GetChildren()
	local totalPodiums = #podiums
	local totalAnimals = math.random(6, 11)
	local podiumIndices: {number} = {}
	local animalCounts: {[string]: number} = {}

	for i = 1, totalPodiums do
		table.insert(podiumIndices, i)
	end

	shuffle(podiumIndices)

	local animalsPlaced = 0
	local attemptIndex = 1

	while animalsPlaced < totalAnimals and attemptIndex <= totalPodiums do
		local podiumIndex = podiumIndices[attemptIndex]
		local animalName = getRandomAnimalByChance()

		animalCounts[animalName] = animalCounts[animalName] or 0

		if animalCounts[animalName] < 2 then
			addAnimal(base, podiumIndex, animalName)
			animalCounts[animalName] = animalCounts[animalName] + 1
			animalsPlaced = animalsPlaced + 1
		end

		attemptIndex = attemptIndex + 1
	end
end

function Phase.OnStart()
	if isActive then
		return
	end

	isActive = true
	for _, player in game:GetService("Players"):GetPlayers() do
		NotificationService.Notify(player, "Admin spawned his <font color='#b8504a'>base</font>!", 10, "Sounds.Sfx.Success")
	end
	clonedSteps = script.Steps:Clone()
	clonedBase = script.SammyBase:Clone()
	clonedSteps.Parent = Workspace
	clonedBase.Parent = Workspace

	baseSetup(clonedBase)

	for _, border in ipairs(Workspace.Map.Borders:GetChildren()) do
		border.CanCollide = false
	end
end

function Phase.OnStop()
	if not isActive then
		return
	end

	isActive = false

	for _, conn in pairs(activeConnections) do
		if conn then
			conn:Disconnect()
		end
	end

	activeConnections = {}

	for _, border in ipairs(Workspace.Map.Borders:GetChildren()) do
		border.CanCollide = true
	end

	if clonedSteps then
		clonedSteps:Destroy()
	end
	if clonedBase then
		clonedBase:Destroy()
	end
end

return Phase