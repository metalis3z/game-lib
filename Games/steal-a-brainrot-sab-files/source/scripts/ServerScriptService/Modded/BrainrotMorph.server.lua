
local Players             = game:GetService("Players")
local RunService          = game:GetService("RunService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local AnimalsData          = require(ReplicatedStorage.Datas.Animals)
local MutationsData        = require(ReplicatedStorage.Datas.Mutations)
local TraitsData           = require(ReplicatedStorage.Datas.Traits)
local SharedAnimals        = require(ReplicatedStorage.Shared.Animals)
local RaritiesData         = require(ReplicatedStorage.Datas.Rarities)
local NumberUtils          = require(ReplicatedStorage.Utils.NumberUtils)
local SpeedService         = require(ServerScriptService.Services.SpeedService)
local Net                  = require(ReplicatedStorage.Packages.Net)
local GameData = require(ReplicatedStorage.GameData)
local Gradients = require(ReplicatedStorage.Packages.Gradients)

local Animations = ReplicatedStorage:WaitForChild("Animations").Animals

local Morph   = Net:RemoteFunction("AdminService/Morph")
local UnMorph = Net:RemoteFunction("AdminService/UnMorph")
local SpawnCameraEvent    = Net:RemoteEvent("SpawnFakeBrainrot/Camera")
local EarlyDestroyEvent   = Net:RemoteEvent("SpawnFakeBrainrot/EarlyDestroy")
local MorphBrainrotEvent  = Net:RemoteEvent("MorphBrainrot")

local ActiveMorphs = {}

local CROSSFADE_TIME = 0.2


local function CleanupMorph(Player: Player)
	local MorphData = ActiveMorphs[Player.UserId]
	if not MorphData then return end

	if MorphData.isSpectating then
		ActiveMorphs[Player.UserId] = nil

		if MorphData.fakeModel and MorphData.fakeModel.Parent then
			MorphData.fakeModel:Destroy()
		end

		pcall(function() SpawnCameraEvent:FireClient(Player, nil) end)

		local Character = Player.Character
		if Character then
			local hrp = Character:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Anchored = false end

			for _, Part in pairs(Character:GetDescendants()) do
				if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
					Part.Transparency = 0
				elseif Part:IsA("Decal") then
					Part.Transparency = 0
				end
			end
		end
		return
	end

	if MorphData.speedConnection then MorphData.speedConnection:Disconnect() end

	pcall(function() MorphBrainrotEvent:FireClient(Player, nil) end)

	if MorphData.overheadCleanup then
		MorphData.overheadCleanup()
	end

	if MorphData.gradientCleanups then
		for _, fn in MorphData.gradientCleanups do
			if type(fn) == "function" then fn() end
		end
	end

	if MorphData.model and MorphData.model.Parent then
		MorphData.model:Destroy()
	end

	local Character = Player.Character
	if Character then
		for _, Part in pairs(Character:GetDescendants()) do
			if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
				Part.Transparency = 0
			elseif Part:IsA("Decal") then
				Part.Transparency = 0
			end
		end
	end

	ActiveMorphs[Player.UserId] = nil
end


local function GetFloorY(hrp: Part, humanoid: Humanoid, ignoreList: {Instance}): number
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = ignoreList
	params.FilterType = Enum.RaycastFilterType.Exclude

	local castLength = humanoid.HipHeight + hrp.Size.Y + 5
	local result = workspace:Raycast(hrp.Position, Vector3.new(0, -castLength, 0), params)

	if result then
		return result.Position.Y
	end

	return hrp.Position.Y - humanoid.HipHeight - hrp.Size.Y * 0.5
end


local function GetFloorYFromPosition(position: Vector3, ignoreList: {Instance}): number
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = ignoreList
	params.FilterType = Enum.RaycastFilterType.Exclude

	local castStart = Vector3.new(position.X, position.Y + 10, position.Z)
	local castLength = 50
	local result = workspace:Raycast(castStart, Vector3.new(0, -castLength, 0), params)

	if result then
		return result.Position.Y
	end

	return position.Y
end


local function PlaceOnGround(
	model     : Model,
	hrp       : Part,
	humanoid  : Humanoid,
	character : Model
)
	local floorY    = GetFloorY(hrp, humanoid, {character, model})
	local _, yaw, _ = hrp.CFrame:ToEulerAnglesYXZ()

	model:PivotTo(
		CFrame.new(hrp.Position.X, floorY - 0.15, hrp.Position.Z)
			* CFrame.fromEulerAnglesYXZ(0, yaw, 0)
	)
end


local function PlaceOnGroundAtPosition(
	model     : Model,
	position  : Vector3,
	yaw       : number,
	ignoreList: {Instance}
)
	local floorY = GetFloorYFromPosition(position, ignoreList)
	model:PivotTo(
		CFrame.new(position.X, floorY, position.Z)
			* CFrame.fromEulerAnglesYXZ(0, yaw, 0)
	)

	return floorY
end


local function WeldTo(model: Model, hrp: Part)
	local wc  = Instance.new("WeldConstraint")
	wc.Part0  = hrp
	wc.Part1  = model.PrimaryPart
	wc.Parent = model.PrimaryPart
end


local function GetAnimation(animalName: string, animType: string): Animation?
	local animalAnimFolder = Animations:FindFirstChild(animalName)
	if not animalAnimFolder then 
		return nil 
	end

	return animalAnimFolder:FindFirstChild(animType)
end


local function StopAllAnimations(model: Model)
	for _, desc in model:GetDescendants() do
		if desc:IsA("Animator") then
			for _, track in desc:GetPlayingAnimationTracks() do
				track:Stop(0)
			end
		end
	end
end


local function SetupAnimations(model: Model, animalName: string): (AnimationTrack?, AnimationTrack?)
	local animator = model:FindFirstChildOfClass("Animator", true)

	if not animator then
		local animController = model:FindFirstChild("AnimationController")
		if animController then
			animator = animController:FindFirstChildOfClass("Animator")
			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = animController
			end
		end
	end

	if not animator then
		warn("No Animator found on model for: " .. animalName)
		return nil, nil
	end

	local idleAnim = GetAnimation(animalName, "Idle")
	local walkAnim = GetAnimation(animalName, "Walk")

	local idleTrack, walkTrack

	if idleAnim then
		idleTrack = animator:LoadAnimation(idleAnim)
		idleTrack.Looped = true
		idleTrack.Priority = Enum.AnimationPriority.Idle
	end

	if walkAnim then
		walkTrack = animator:LoadAnimation(walkAnim)
		walkTrack.Looped = true
		walkTrack.Priority = Enum.AnimationPriority.Movement
	end

	return idleTrack, walkTrack
end


local function ParseTraits(Traits: string): (boolean, any)
	if Traits == "All" then
		local t = {}
		for name in pairs(TraitsData) do
			table.insert(t, name)
		end
		return true, t
	end

	if Traits == "None" or Traits == "" then
		return true, nil
	end

	local TraitTable = string.split(Traits, ", ")
	local Removed, Seen = {}, {}

	for i, Trait in pairs(TraitTable) do
		if Seen[Trait] then
			return false, string.format("Duplicate trait: %s", Trait)
		end
		Seen[Trait] = true
		if not TraitsData[Trait] then
			table.insert(Removed, Trait)
			TraitTable[i] = nil
		end
	end

	if #Removed > 0 then
		return false, string.format("These traits do not exist: %s", table.concat(Removed, ", "))
	end

	return true, TraitTable
end


local function SetupOverhead(AnimalModel, Name, MutationValue, TraitsValue, Player)
	local animalData = AnimalsData[Name]
	if not animalData then return nil, nil end
	if animalData.HideOverhead then return nil, nil end

	local gradientCleanups = {}

	local OverheadTemplate = script:FindFirstChild("Overhead")
	if not OverheadTemplate then
		warn("[Morph] No Overhead template found in script")
		return nil, gradientCleanups
	end

	local attachmentTemplate = OverheadTemplate:FindFirstChild("Attachment")
	if not attachmentTemplate then
		warn("[Morph] No Attachment found in Overhead template")
		return nil, gradientCleanups
	end

	local existingAttach = AnimalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true)

	local clonedAttachment = attachmentTemplate:Clone()
	clonedAttachment.Name = "MorphOverheadAttachment"

	if existingAttach and existingAttach:IsA("Attachment") then
		clonedAttachment.CFrame = existingAttach.CFrame
		clonedAttachment.Parent = existingAttach.Parent
	else
		local _, boundingSize = AnimalModel:GetBoundingBox()
		local overheadYOffset = boundingSize.Y * 0.4 * (animalData.OverheadYOffsetModifier or 1)
		clonedAttachment.CFrame = CFrame.new(0, overheadYOffset, 0)
		clonedAttachment.Parent = AnimalModel.PrimaryPart
	end

	local gui = clonedAttachment:FindFirstChild("AnimalOverhead")
	if not gui then
		warn("[Morph] No AnimalOverhead found in cloned attachment")
		clonedAttachment:Destroy()
		return nil, gradientCleanups
	end

	if gui:FindFirstChild("DisplayName") then
		gui.DisplayName.Text = animalData.DisplayName or Name
	end

	if gui:FindFirstChild("Generation") then
		local genValue = SharedAnimals.GetGeneration(nil, Name, MutationValue, TraitsValue, nil)
		gui.Generation.Text = string.format("$%*/s", NumberUtils:ToString(genValue))
		gui.Generation.Visible = true
	end

	if gui:FindFirstChild("Price") then
		gui.Price.Text = string.format("$%*", NumberUtils:ToString(animalData.Price))
	end

	local rarityLabel = gui:FindFirstChild("Rarity")
	if rarityLabel then
		local rarityName = animalData.Rarity
		local rarityData = RaritiesData[rarityName]

		rarityLabel.Text = rarityName

		for _, child in ipairs(rarityLabel:GetChildren()) do
			if child:IsA("UIGradient") then
				child:Destroy()
			end
		end

		rarityLabel.TextColor3 = rarityData.Color

		if rarityData.StrokeColor then
			local stroke = rarityLabel:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = rarityData.StrokeColor
			end
		end

		if rarityData.GradientPreset then
			rarityLabel.TextColor3 = Color3.new(1, 1, 1)
			local cleanup = Gradients.apply(rarityLabel, rarityData.GradientPreset)
			if cleanup then
				table.insert(gradientCleanups, cleanup)
			end
		else
			local cleanup = Gradients.apply(rarityLabel, nil)
			if cleanup then
				table.insert(gradientCleanups, cleanup)
			end
		end

		local easyVisualsPreset = rarityData.EasyVisualsPresset
		if easyVisualsPreset then
			local visuals = rarityLabel:FindFirstChild("Visuals")
			if visuals then
				visuals:SetAttribute("Preset", easyVisualsPreset)
				visuals.Enabled = true
			end
		end
	end

	local mutationLabel = gui:FindFirstChild("Mutation")
	if mutationLabel then
		mutationLabel.Visible = MutationValue ~= nil
		if MutationValue then
			local mutData = MutationsData[MutationValue]
			if mutData then
				if mutData.UseRichText then
					mutationLabel.RichText = true
					mutationLabel.Text = mutData.DisplayWithRichText or MutationValue
				else
					mutationLabel.RichText = false
					mutationLabel.Text = mutData.DisplayText or MutationValue
				end

				if mutData.GradientPreset then
					mutationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					local cleanup = Gradients.apply(mutationLabel, mutData.GradientPreset)
					if cleanup then
						table.insert(gradientCleanups, cleanup)
					end
				else
					mutationLabel.TextColor3 = mutData.MainColor
				end

				local easyVisualMutation = mutData.EasyVisual
				if easyVisualMutation then
					local visuals = mutationLabel:FindFirstChild("Visuals")
					if visuals then
						visuals:SetAttribute("Preset", easyVisualMutation)
						visuals.Enabled = true
					end
				end
			end
		end
	end

	local traitsFrame = gui:FindFirstChild("Traits")
	if traitsFrame then
		if TraitsValue and #TraitsValue > 0 then
			local template = traitsFrame:FindFirstChild("Template")
			if template then
				for _, traitName in ipairs(TraitsValue) do
					local traitData = TraitsData[traitName]
					if traitData then
						local icon = template:Clone()
						icon.Image = traitData.Icon
						icon.Visible = true
						icon.Parent = traitsFrame
					end
				end
			end
			traitsFrame.Visible = true
		else
			traitsFrame.Visible = false
		end
	end

	local function cleanup()
		clonedAttachment:Destroy()
	end

	return cleanup, gradientCleanups
end

local function ApplyMorph(Player: Player, Name: string, MutationValue: string?, TraitsValue: any, Speed: string, AnimalOverhead: string, SpawnCFrame: CFrame?)
	local Character = Player.Character
	if not Character then return false, "Failed to grab character." end

	local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid
	if not Humanoid then return false, "Failed to grab Humanoid." end

	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: Part
	if not HumanoidRootPart then return false, "Failed to grab HRP." end

	local AnimalModel = SharedAnimals:GetAnimatedModel(Name, "Idle")

	if not AnimalModel or not AnimalModel.PrimaryPart then
		return false, "Failed to get brainrot model."
	end

	StopAllAnimations(AnimalModel)

	if MutationValue then
		SharedAnimals:ApplyMutation(AnimalModel, Name, MutationValue)
	end
	if TraitsValue then
		SharedAnimals:ApplyTraits(AnimalModel, Name, TraitsValue)
	end

	local SpeedConnection
	if Speed:lower() == "yes" then
		SpeedConnection = RunService.Heartbeat:Connect(function()
			Humanoid.WalkSpeed = 10
		end)
	else
		SpeedService:Update(Player)
	end

	local overheadCleanup, gradientCleanups
	if AnimalOverhead:lower() == "yes" then
		overheadCleanup, gradientCleanups = SetupOverhead(AnimalModel, Name, MutationValue, TraitsValue, Player)
	end

	AnimalModel:SetAttribute("AnimalName", Name)

	AnimalModel.Name = "MorphBrainrot"

	if SpawnCFrame then
		local pos = SpawnCFrame.Position
		local _, yaw, _ = SpawnCFrame:ToEulerAnglesYXZ()
		local rotation = CFrame.fromEulerAnglesYXZ(0, yaw, 0)

		local floorY = PlaceOnGroundAtPosition(AnimalModel, pos, yaw, {Character, AnimalModel})

		local hrpHalfY = HumanoidRootPart.Size.Y * 0.5
		local hipH = math.max(Humanoid.HipHeight, 0)
		HumanoidRootPart.CFrame = CFrame.new(pos.X, floorY + hipH + hrpHalfY, pos.Z) * rotation
	else
		PlaceOnGround(AnimalModel, HumanoidRootPart, Humanoid, Character)
	end

	WeldTo(AnimalModel, HumanoidRootPart)

	for _, Part in pairs(Character:GetDescendants()) do
		if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
			Part.Transparency = 1
		elseif Part:IsA("Decal") then
			Part.Transparency = 1
		end
	end

	AnimalModel.Parent = Character

	local animController = AnimalModel:FindFirstChildOfClass("AnimationController")
		or AnimalModel:FindFirstChild("AnimationController", true)
	if animController then
		if not animController:FindFirstChildOfClass("Animator") then
			Instance.new("Animator", animController)
		end
	else
		local newAC = Instance.new("AnimationController", AnimalModel)
		Instance.new("Animator", newAC)
	end

	MorphBrainrotEvent:FireClient(Player, Name)

	Humanoid.AncestryChanged:Once(function()
		CleanupMorph(Player)
	end)

	ActiveMorphs[Player.UserId] = {
		model            = AnimalModel,
		speedConnection  = SpeedConnection,
		overheadCleanup  = overheadCleanup,
		gradientCleanups = gradientCleanups,
	}

	return true
end

function Morph.OnServerInvoke(
	Player        : Player,
	Name          : string,
	Mutation      : string,
	Traits        : string,
	Speed         : string,
	AnimalOverhead: string,
	SpawnOnRoad   : any
): (boolean, string?)

	CleanupMorph(Player)

	local Animal = AnimalsData[Name]
	if not Animal then return false, "Could not find brainrot." end

	if GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[Name] then
		return false, "You cannot morph into this brainrot."
	end
	if Mutation ~= "" and not MutationsData[Mutation] then
		return false, "Could not find this mutation."
	end

	local traitOk, TraitResult = ParseTraits(Traits)
	if not traitOk then return false, TraitResult end

	local Character = Player.Character
	if not Character then return false, "Failed to grab character." end

	local MutationValue = Mutation ~= "" and Mutation or nil
	local TraitsValue   = TraitResult

	local shouldSpawnOnRoad = false
	if type(SpawnOnRoad) == "boolean" then
		shouldSpawnOnRoad = SpawnOnRoad
	elseif type(SpawnOnRoad) == "string" then
		shouldSpawnOnRoad = SpawnOnRoad:lower() == "yes" or SpawnOnRoad:lower() == "true"
	end

	if shouldSpawnOnRoad then
		local AnimalService = require(ServerScriptService.Services.AnimalService)

		local animalId = AnimalService.spawnAnimalCustom(Animal, MutationValue, TraitsValue, nil, nil, nil, false, true)

		local FakeAnimalModel = workspace:WaitForChild(animalId, 120)
		if not FakeAnimalModel then
			return false, "Fake brainrot failed to spawn on road."
		end

		FakeAnimalModel:SetAttribute("IsMorphAnimal", true)

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		if HumanoidRootPart then
			HumanoidRootPart.Anchored = true
		end

		for _, Part in pairs(Character:GetDescendants()) do
			if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
				Part.Transparency = 1
			elseif Part:IsA("Decal") then
				Part.Transparency = 1
			end
		end

		ActiveMorphs[Player.UserId] = {
			isSpectating = true,
			fakeModel = FakeAnimalModel
		}

		SpawnCameraEvent:FireClient(Player, FakeAnimalModel)

		local connection
		connection = FakeAnimalModel.AncestryChanged:Connect(function(_, parent)
			if not parent then
				connection:Disconnect()

				local currentMorph = ActiveMorphs[Player.UserId]
				if currentMorph and currentMorph.isSpectating then
					ActiveMorphs[Player.UserId] = nil 

					local lastCFrame = FakeAnimalModel:GetPivot()

					if Character and HumanoidRootPart then
						HumanoidRootPart.CFrame = lastCFrame
						HumanoidRootPart.Anchored = false
					end

					pcall(function() SpawnCameraEvent:FireClient(Player, nil) end)

					ApplyMorph(Player, Name, MutationValue, TraitsValue, Speed, AnimalOverhead, lastCFrame)
				end
			end
		end)

		return true
	else
		return ApplyMorph(Player, Name, MutationValue, TraitsValue, Speed, AnimalOverhead)
	end
end


function UnMorph.OnServerInvoke(Player: Player): (boolean, string?)
	CleanupMorph(Player)
	SpeedService:Update(Player)
	return true
end


Players.PlayerRemoving:Connect(function(Player)
	CleanupMorph(Player)
end)