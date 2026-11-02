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
local Net = require(ReplicatedStorage.Packages.Net)
local SkinService = require(game.ServerScriptService.Services.SkinService)
local SoundService = require(game.ServerScriptService.Services.SoundService)
local listanimals: {string} = {
	"Admin Lucky Blocks", 
	"Los Lucky Blocks", 
	"Taco Lucky Blocks", 
	"Los Taco Blocks", 
	"Brainrot God Lucky Block", 
	"Secret Lucky Block",
	"Tartaruga Cisterna", 
	"Arcadopus", 
	"Sammyni Spyderini", 
	"Chicleteirina Bicicleteirina", 
	"Chicleteira Bicicleteira", 
	"Bisonte Giuppitere", 
	"67", 
	"Dul Dul Dul", 
	"La Grande Combinasion",
	"Money Money Puggy",
	"Garama and Madundung"
}
local Phase = {}
local SammyBaseState = require(game.ServerScriptService.SammyBaseState)
local activeConnections = {}
local timerThread = nil
local isActive = false

local clonedSteps: Model? = nil
local clonedBase: Model? = nil

local eventTrove: typeof(Trove.new())? = nil

local STEPS_NAME = "SammySteps"
local BASE_NAME = "SammyBase"
local BASE_TIER = 18

local pendingItemOverride: {string}? = nil

local ServerStorage = game:GetService("ServerStorage")
local setItemsBindable: BindableFunction = ServerStorage:FindFirstChild("SetSammyBaseItemsBindable")
	or Instance.new("BindableFunction", ServerStorage)
setItemsBindable.Name = "SetSammyBaseItemsBindable"

setItemsBindable.OnInvoke = function(newItems: {string}): (boolean, string)
	if type(newItems) ~= "table" or #newItems == 0 then
		return false, "Invalid items table provided."
	end

	for _, name in ipairs(newItems) do
		if not animals[name] then
			return false, ("Unknown animal: '%s'"):format(name)
		end
	end

	pendingItemOverride = newItems
	return true, ("Override set with %d items. Will apply on next OnStart()."):format(#newItems)
end

local function getActiveAnimalList(): {string}
	if SammyBaseState.pendingOverride then
		local override = SammyBaseState.pendingOverride
		SammyBaseState.pendingOverride = nil
		return override
	end
	return listanimals
end

local function addoverhead(animalName: string, mutation:string?, spawnPart: BasePart, model: Model): Model
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
	overhead.Generation.Text = ("$%*/s"):format(NumberUtils:ToString(sharedAnimals:GetGeneration(animalName, mutation)))
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

	local animalTemplate = require(ReplicatedStorage.Shared.BrainrotAssets).getModel(animalName) :: Model?
	if not animalTemplate then
		return
	end

	local animalClone = animalTemplate:Clone()

	local animalDataEntry = animals[animalName]
	if animalDataEntry and animalDataEntry.LuckyBlock then
		animalClone:SetAttribute("LuckyBlock", true)
		animalClone:SetAttribute("LuckyBlockKey", animalName)
	end

	local spawnPart = podium:FindFirstChild("Base") and podium.Base:FindFirstChild("Spawn") 
		or podium:FindFirstChild("Spawn") 
		or podium:FindFirstChildWhichIsA("BasePart")

	if not spawnPart then
		animalClone:Destroy()
		return
	end

	for _, v55 in animalClone:GetDescendants() do
		if v55:IsA("BasePart") then
			v55.CanCollide = false;
			v55.CanQuery = false;
			v55.CanTouch = false;
			v55.Massless = true;
		end;
	end;

	animalClone.PrimaryPart.Anchored = true;

	local mutationList = {"Galaxy", "YinYang", "Gold", "Diamond", "Bloodrot", "Lava", "Candy","Rainbow", "Cursed", "Radioactive", "Divine", "Cyber"}
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
	animalClone.Parent = base

	local anim: Animation? = ReplicatedStorage.Animations.Animals:FindFirstChild(animalClone.Name) 
		and ReplicatedStorage.Animations.Animals[animalClone.Name]:FindFirstChild("Idle") :: Animation?

	if anim and animalClone:FindFirstChild("AnimationController") then
		local animator = animalClone.AnimationController:FindFirstChildWhichIsA("Animator")
		if animator then
			animator:LoadAnimation(anim):Play()
		end
	end

	local overhead = addoverhead(animalName, selectedMutation, spawnPart, animalClone)

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

	local connection
	connection = prompt.Triggered:Connect(function(player)
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
			overhead.Generation.Visible = false
			overhead.Mutation.Visible = false
			overhead.Price.Visible = false
			overhead.Rarity.Visible = false
			overhead.Stolen.Visible = true
		end

		if prompt then
			prompt.Enabled = false
		end

		local success = StealService:SimulateSteal(
			player.Name, animalName, animalClone, overhead, prompt, selectedMutation
		)

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

	table.insert(activeConnections, connection)
end

local function shuffle<T>(tbl: {T})
	for i = #tbl, 2, -1 do
		local j = math.random(1, i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
end

local function baseSetup(base: Model, animalList: {string})
	local podiums = base.AnimalPodiums:GetChildren()
	local totalPodiums = #podiums
	local totalAnimals = totalPodiums
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
		local animalName = animalList[math.random(1, #animalList)]

		animalCounts[animalName] = animalCounts[animalName] or 0

		if animalCounts[animalName] < 2 then
			addAnimal(base, podiumIndex, animalName)
			animalCounts[animalName] = animalCounts[animalName] + 1
			animalsPlaced = animalsPlaced + 1
		end

		attemptIndex = attemptIndex + 1
	end
end

local EventService = require(game.ServerScriptService.Services.EventService)


local function getPlotSignLabel(base: Model): TextLabel?
	local plotSign = base:FindFirstChild("SkinPlotSign") or base:FindFirstChild("PlotSign")
	if not plotSign then
		warn("[Phase] PlotSign not found on base model")
		return nil
	end
	local surfaceGui = plotSign:FindFirstChildWhichIsA("SurfaceGui")
	if not surfaceGui then
		warn("[Phase] SurfaceGui not found on PlotSign")
		return nil
	end
	surfaceGui.Face = "Left"
	local frame = surfaceGui:FindFirstChild("Frame")
	if not frame then
		warn("[Phase] Frame not found in SurfaceGui")
		return nil
	end
	local label = frame:FindFirstChild("TextLabel")
	if not label then
		warn("[Phase] TextLabel not found in Frame")
	end
	return label
end

local function applyOverrides(trove: typeof(Trove.new()), base: Model, skin: string?, displayName: string?)
	if skin and skin ~= "" then
		SkinService:Apply(skin, base, BASE_TIER, true)

		trove:Add(function()
			SkinService:CleanupPlot(base)
		end)

		print(("[Phase] Skin '%s' applied to base at tier %d"):format(skin, BASE_TIER))
	end

	if displayName and displayName ~= "" then
		local function applyToLabel(label: TextLabel)
			local originalText = label.Text
			label.Text = displayName
			label:SetAttribute("__OverrideName", displayName)

			local conn = label:GetPropertyChangedSignal("Text"):Connect(function()
				if label:GetAttribute("__OverrideName") and label.Text ~= displayName then
					label.Text = displayName
				end
			end)

			trove:Add(conn)
			trove:Add(function()
				if label.Parent then
					label:SetAttribute("__OverrideName", nil)
					label.Text = originalText
				end
			end)

			print(("[Phase] PlotSign name set to '%s' (was '%s')"):format(displayName, originalText))
		end

		local label = getPlotSignLabel(base)
		if label then
			applyToLabel(label)
		end

		local watchConn = base.DescendantAdded:Connect(function(desc)
			if desc.Name == "TextLabel" then
				local parent = desc.Parent
				if parent and parent.Name == "Frame" then
					local sg = parent.Parent
					if sg and sg.Name == "SurfaceGui" then
						local ps = sg.Parent
						if ps and (ps.Name == "SkinPlotSign" or ps.Name == "PlotSign") then
							applyToLabel(desc :: TextLabel)
						end
					end
				end
			end
		end)

		trove:Add(watchConn)
	end
end

local function cleanupEventTrove()
	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
		print("[Phase] eventTrove cleaned")
	end
end

local function cleanupBase()
	print("[Phase] cleanupBase() called")
	print("[Phase] clonedSteps reference:", clonedSteps)
	print("[Phase] clonedBase reference:", clonedBase)

	if clonedSteps then
		print("[Phase] Destroying clonedSteps via reference, Parent:", clonedSteps.Parent)
		pcall(function()
			clonedSteps:Destroy()
		end)
		clonedSteps = nil
	end

	if clonedBase then
		print("[Phase] Destroying clonedBase via reference, Parent:", clonedBase.Parent)
		pcall(function()
			clonedBase:Destroy()
		end)
		clonedBase = nil
	end

	local workspaceSteps = Workspace:FindFirstChild(STEPS_NAME)
	if workspaceSteps then
		print("[Phase] Found Steps in Workspace by name, destroying...")
		pcall(function()
			workspaceSteps:Destroy()
		end)
	end

	local workspaceBase = Workspace:FindFirstChild(BASE_NAME)
	if workspaceBase then
		print("[Phase] Found Base in Workspace by name, destroying...")
		pcall(function()
			workspaceBase:Destroy()
		end)
	end

	local stepsTemplate = script:FindFirstChild("Steps")
	local baseTemplate = script:FindFirstChild("SammyBase")

	if stepsTemplate then
		local templateName = stepsTemplate.Name
		local found = Workspace:FindFirstChild(templateName)
		if found then
			print("[Phase] Found Steps by template name:", templateName)
			pcall(function()
				found:Destroy()
			end)
		end
	end

	if baseTemplate then
		local templateName = baseTemplate.Name
		local found = Workspace:FindFirstChild(templateName)
		if found then
			print("[Phase] Found Base by template name:", templateName)
			pcall(function()
				found:Destroy()
			end)
		end
	end

	for _, child in ipairs(Workspace:GetChildren()) do
		if child.Name == "SammyBase" or child.Name == "Steps" or child.Name == STEPS_NAME or child.Name == BASE_NAME then
			print("[Phase] Nuclear cleanup - destroying:", child.Name)
			pcall(function()
				child:Destroy()
			end)
		end
	end

	print("[Phase] cleanupBase() complete")
end

function Phase.OnStart()
	print("[Phase] OnStart called, isActive:", isActive)

	if isActive then
		warn("[Phase] OnStart called but already active, ignoring")
		return
	end
	if EventService:IsEventActive("Brotinho's Base") then
		warn("[Phase] Brotinho's Base event is active, not starting Sammy's Base")
		return
	end

	cleanupBase()

	isActive = true

	local activeAnimalList = getActiveAnimalList()

	local pendingSkin = SammyBaseState.pendingSkin
	local pendingName = SammyBaseState.pendingName
	SammyBaseState.pendingSkin = nil
	SammyBaseState.pendingName = nil

	for _, player in game:GetService("Players"):GetPlayers() do
		NotificationService.Notify(player, "Steak spawned his <font color='#E12A34'>base</font>!", 10, "Sounds.Sfx.Success")
		SoundService:PlayAll(ReplicatedStorage.Sounds.Events["Sammy's Base"].Stairs)
	end

	local stepsTemplate = script:FindFirstChild("Steps")
	local baseTemplate = script:FindFirstChild("SammyBase")

	if not stepsTemplate then
		warn("[Phase] Steps template not found in script!")
		return
	end

	if not baseTemplate then
		warn("[Phase] SammyBase template not found in script!")
		return
	end

	clonedSteps = stepsTemplate:Clone()
	clonedSteps.Name = STEPS_NAME

	clonedBase = baseTemplate:Clone()
	clonedBase.Name = BASE_NAME

	clonedSteps.Parent = Workspace
	clonedBase.Parent = Workspace

	print("[Phase] Cloned Steps:", clonedSteps, "Parent:", clonedSteps.Parent)
	print("[Phase] Cloned Base:", clonedBase, "Parent:", clonedBase.Parent)

	eventTrove = Trove.new()
	applyOverrides(eventTrove, clonedBase, pendingSkin, pendingName)

	baseSetup(clonedBase, activeAnimalList)

	for _, border in ipairs(Workspace.Map.Borders:GetChildren()) do
		border.CanCollide = false
	end

	print("[Phase] Sammy's Base started successfully")
end

function Phase.OnStop()
	print("[Phase] OnStop called, isActive:", isActive)

	isActive = false

	print("[Phase] Disconnecting", #activeConnections, "connections")
	for _, conn in pairs(activeConnections) do
		if conn and typeof(conn) == "RBXScriptConnection" then
			pcall(function()
				conn:Disconnect()
			end)
		end
	end
	activeConnections = {}
	print("[Phase] Connections disconnected")

	print("[Phase] Restoring borders...")
	pcall(function()
		local mapFolder = Workspace:FindFirstChild("Map")
		if mapFolder then
			local borders = mapFolder:FindFirstChild("Borders")
			if borders then
				for _, border in ipairs(borders:GetChildren()) do
					border.CanCollide = true
				end
			end
		end
	end)
	print("[Phase] Borders restored")

	cleanupEventTrove()

	print("[Phase] Calling cleanupBase...")
	cleanupBase()

	print("[Phase] Sammy's Base stopped and cleaned up")
end

function Phase.ForceCleanup()
	print("[Phase] Force cleanup initiated")
	isActive = false

	cleanupEventTrove()
	cleanupBase()

	for _, conn in pairs(activeConnections) do
		if conn and typeof(conn) == "RBXScriptConnection" then
			pcall(function()
				conn:Disconnect()
			end)
		end
	end
	activeConnections = {}

	print("[Phase] Force cleanup complete")
end

function Phase.IsActive()
	return isActive
end

function Phase.DebugState()
	print("=== Phase Debug State ===")
	print("isActive:", isActive)
	print("clonedSteps:", clonedSteps)
	print("clonedBase:", clonedBase)
	print("activeConnections count:", #activeConnections)
	print("eventTrove active:", eventTrove ~= nil)

	print("Workspace children with matching names:")
	for _, child in ipairs(Workspace:GetChildren()) do
		if child.Name == "SammyBase" or child.Name == "Steps" or child.Name == STEPS_NAME or child.Name == BASE_NAME then
			print("  -", child.Name, child:GetFullName())
		end
	end
	print("=========================")
end

return Phase