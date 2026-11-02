local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local PackagesFolder = ReplicatedStorage:WaitForChild("Packages");
local Trove = require(PackagesFolder.Trove);
local Gradients = require(ReplicatedStorage.Packages.Gradients);
local Observers = require(ReplicatedStorage.Packages.Observers);
local ServerData = require(ReplicatedStorage.Datas.ServerData);
local FFlags = require(ReplicatedStorage.Packages.FFlags);
local FastOverheadController = require(ReplicatedStorage.Controllers.FastOverheadController);
local AnimalOverheadController = require(ReplicatedStorage.Controllers.AnimalOverheadController);
local DatasFolder = ReplicatedStorage:WaitForChild("Datas");
local AnimalsData = require(DatasFolder.Animals);
local GameData = require(DatasFolder.Game);
local RaritiesData = require(DatasFolder.Rarities);
local MutationsData = require(DatasFolder.Mutations);
local TraitsData = require(DatasFolder.Traits);
local AnimalTemplate = ReplicatedStorage:WaitForChild("Others").AnimalTemplate;
local SharedFolder = ReplicatedStorage:WaitForChild("Shared");
local SharedAnimals = require(SharedFolder.Animals);
local AnimalOverhead = ReplicatedStorage:WaitForChild("Overheads").AnimalOverhead;
local BrainrotAssets = require(ReplicatedStorage.Shared.BrainrotAssets);
local UtilsFolder = ReplicatedStorage:WaitForChild("Utils");
local NumberUtils = require(UtilsFolder.NumberUtils);
local TimeUtils = require(UtilsFolder.TimeUtils);
local AnimationAnimals = ReplicatedStorage:WaitForChild("Animations").Animals;
local RenderedMovingAnimals = workspace:WaitForChild("RenderedMovingAnimals");
local exclusive_animals = require(game.ReplicatedStorage.Exclusive)

local function disablePartCollision(part)
	part.CanCollide = false
	part.CanQuery   = false
	part.CanTouch   = false
	part.LocalTransparencyModifier = 0
end

local function getAnimatorInfo(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator", humanoid)
		end
		return animator, "Humanoid", humanoid
	end

	local controller = model:FindFirstChildOfClass("AnimationController")
		or model:FindFirstChild("AnimationController")
	if controller then
		local animator = controller:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator", controller)
		end
		return animator, "AnimationController", controller
	end

	return nil, nil, nil
end

local function getControllerYOffset(model, controllerType, animalIndex)
	if animalIndex == "Casyni Fattini" then
		return 0
	end
	if controllerType == "Humanoid" then
		local humanoid = model:FindFirstChildOfClass("Humanoid")
		local rootPart = model:FindFirstChild("HumanoidRootPart")
		if humanoid and rootPart then
			return humanoid.HipHeight + rootPart.Size.Y * 0.5
		end
		local extents = model:GetExtentsSize()
		return extents.Y * 0.5
	end
	return 0
end


local AnimalClient = {};
AnimalClient.__index = AnimalClient;

local function playTrackByName(self, trackName)
	for name, track in self.AnimationTracks do
		if trackName == name then
			if not track.IsPlaying then
				track:Play();
			end;
		elseif track.IsPlaying then
			track:Stop();
		end;
	end;
end;

AnimalClient.GetUID = function(self)
	return self.UID;
end;

AnimalClient.new = function(instance)
	local self = setmetatable({}, AnimalClient);
	self.UID = instance.Name;
	self.Collector = Trove.new();
	self.Instance = instance;
	self.Index = self.Instance:GetAttribute("Index");
	self.Mutation = self.Instance:GetAttribute("Mutation");

	local animalDataEntry = AnimalsData[self.Index];
	if not animalDataEntry then
		warn("Failed to find animal data: " .. self.Index);
	end;

	local rarityEntry = RaritiesData[animalDataEntry.Rarity];
	local requestedIndex = self.Index;
	local modelTemplate = BrainrotAssets.getModel(self.Index);
	if not modelTemplate then
		warn("[AnimalClient] No model template for index '" .. tostring(self.Index) .. "' — skipping render.");
		self.Collector:Destroy();
		return nil;
	end;
	if self.Instance.Parent == nil or self.Instance:GetAttribute("Index") ~= requestedIndex then
		self.Collector:Destroy();
		return nil;
	end;
	self.AnimalModel = modelTemplate:Clone();
	local modelExtentsSize = self.AnimalModel:GetExtentsSize();

	for _, descendant in self.AnimalModel:GetDescendants() do
		if descendant:IsA("BasePart") then
			disablePartCollision(descendant)
			descendant.Massless = true;
			descendant.Anchored = true;
		end;
	end;

	self.Collector:Add(self.AnimalModel.DescendantAdded:Connect(function(desc)
		if desc:IsA("BasePart") then
			task.defer(function()
				if desc and desc.Parent then
					disablePartCollision(desc)
				end
			end)
		end
	end))

	self.Collector:Add(self.AnimalModel);
	self.AnimalModel:AddTag("RenderedMovingAnimal");
	self.AnimalModel.Parent = RenderedMovingAnimals;

	if self.Mutation then
		local function applyToModel(targetModel, specificIndex)
			local result = SharedAnimals:ApplyMutation(targetModel, specificIndex, self.Mutation)
			if typeof(result) == "Instance" and result:IsA("Model") and result ~= targetModel then
				result:PivotTo(targetModel:GetPivot())
				result.Parent = targetModel.Parent
				self.Collector:Add(result)
				task.defer(function() targetModel:Destroy() end)
				return result
			elseif typeof(result) == "function" then
				self.Collector:Add(result)
			end
			return targetModel
		end

		if exclusive_animals[self.Index] then
			for _, child in self.AnimalModel:GetChildren() do
				if child:IsA("Model") then
					applyToModel(child, child.Name)
				end
			end
		else
			self.AnimalModel = applyToModel(self.AnimalModel, self.Index)
		end
	end

	local customModelScale = self.Instance:GetAttribute("CustomModelScale")
	if type(customModelScale) == "number"
		and customModelScale > 0
		and customModelScale ~= 1
	then
		if exclusive_animals[self.Index] then
			for _, child in self.AnimalModel:GetChildren() do
				if child:IsA("Model") then
					local ok, currentScale = pcall(function() return child:GetScale() end)
					if ok and currentScale then
						pcall(function() child:ScaleTo(currentScale * customModelScale) end)
					end
				end
			end
		else
			local ok, currentScale = pcall(function() return self.AnimalModel:GetScale() end)
			if ok and currentScale then
				pcall(function() self.AnimalModel:ScaleTo(currentScale * customModelScale) end)
			end
		end
		modelExtentsSize = self.AnimalModel:GetExtentsSize()
	end

	local function updateGenerationText()
		if not self.Overhead then return end

		local generationText = nil
		local customGen = self.Instance:GetAttribute("CustomGeneration")

		generationText = if animalDataEntry.LuckyBlock then
			(animalDataEntry.LuckyBlock.RoadTimer or animalDataEntry.LuckyBlock.Timer) <= 0 and "READY!" or TimeUtils:E(animalDataEntry.LuckyBlock.RoadTimer or animalDataEntry.LuckyBlock.Timer)
			elseif animalDataEntry.Egg then
			animalDataEntry.Egg.Timer <= 0 and "READY!" or TimeUtils:E(animalDataEntry.Egg.Timer)
			elseif self.Index == "Coffin Tung Tung Tung Sahur" then ""
			elseif customGen then (function()
				local gen = AnimalOverheadController:CalculateGenerationWithMultipliers(customGen, self.Traits, self.Mutation)
				return ("$%*/s"):format(NumberUtils:ToString(gen))
			end)()
			else ("$%*/s"):format((NumberUtils:ToString(SharedAnimals:GetGeneration(self.Index, self.Mutation, self.Traits))));

		self.Overhead.Generation.Text = generationText;
		self.Overhead.Generation.Visible = generationText ~= "" and not animalDataEntry.HideGeneration;
	end;

	local traitsCollector = self.Collector:Extend();

	local function applyTraits()
		traitsCollector:Clean();
		local traitsAttribute = self.Instance:GetAttribute("Traits");
		self.Traits = if traitsAttribute then HttpService:JSONDecode(traitsAttribute) else nil;

		if self.Traits then
			if exclusive_animals[self.Index] then
				for _, child in self.AnimalModel:GetChildren() do
					if child:IsA("Model") then
						local traitCleanup = SharedAnimals:ApplyTraits(child, child.Name, self.Traits)
						if traitCleanup then traitsCollector:Add(traitCleanup) end
					end
				end
			else
				local traitCleanup = SharedAnimals:ApplyTraits(self.AnimalModel, self.Index, self.Traits);
				if traitCleanup then traitsCollector:Add(traitCleanup) end
			end

		end;
		if self.Overhead then
			AnimalOverheadController:PopulateTraits(self.Overhead, self.Traits, traitsCollector);
			local customDisplayName = self.Instance:GetAttribute("CustomDisplayName")
			self.Overhead.DisplayName.Text = customDisplayName
				or AnimalOverheadController:ResolveDisplayName(self.Index, self.Traits);
		end;
		updateGenerationText();
	end;

	local originalControllerType
	if exclusive_animals[self.Index] then
		for _, child in self.AnimalModel:GetChildren() do
			if child:IsA("Model") then
				local _, ctrlType = getAnimatorInfo(child)
				originalControllerType = ctrlType
				break
			end
		end
	else
		local _, ctrlType = getAnimatorInfo(self.AnimalModel)
		originalControllerType = ctrlType
	end
	originalControllerType = originalControllerType or "AnimationController"

	if FFlags:GetInstant("Optimisation.HumanoidBrainrotModels") or require(ReplicatedStorage.Shared.GetServerType):IsPublicServer() then
		local function upgradeModel(model)
			local existing = model:FindFirstChild("AnimationController")
			if existing then existing:Destroy() end
			local hum = Instance.new("Humanoid")
			Instance.new("Animator", hum)
			hum.Name = "AnimationController"
			hum.EvaluateStateMachine = false
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			hum.PlatformStand = true
			hum.Parent = model

			for _, part in model:GetDescendants() do
				if part:IsA("BasePart") then
					disablePartCollision(part)
				end
			end

			self.Collector:Add(hum.StateChanged:Connect(function()
				for _, part in model:GetDescendants() do
					if part:IsA("BasePart") then
						disablePartCollision(part)
					end
				end
			end))

			self.Collector:Add(model.DescendantAdded:Connect(function(desc)
				if desc:IsA("BasePart") then
					task.defer(function()
						if desc and desc.Parent then
							disablePartCollision(desc)
						end
					end)
				end
			end))
		end

		if exclusive_animals[self.Index] then
			for _, child in self.AnimalModel:GetChildren() do
				if child:IsA("Model") then upgradeModel(child) end
			end
		else
			upgradeModel(self.AnimalModel)
		end
	end
	local didUpgrade = FFlags:GetInstant("Optimisation.HumanoidBrainrotModels")
		or require(ReplicatedStorage.Shared.GetServerType):IsPublicServer()

	if not didUpgrade then
		local function guardExistingHumanoid(model)
			local hum = model:FindFirstChildOfClass("Humanoid")
			if not hum then return end

			for _, part in model:GetDescendants() do
				if part:IsA("BasePart") then
					disablePartCollision(part)
				end
			end

			hum.EvaluateStateMachine = false
			hum.PlatformStand = true
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff

			self.Collector:Add(hum.StateChanged:Connect(function()
				for _, part in model:GetDescendants() do
					if part:IsA("BasePart") then
						disablePartCollision(part)
					end
				end
			end))

			self.Collector:Add(model.DescendantAdded:Connect(function(desc)
				if desc:IsA("BasePart") then
					task.defer(function()
						if desc and desc.Parent then
							disablePartCollision(desc)
						end
					end)
				end
			end))
		end

		if exclusive_animals[self.Index] then
			for _, child in self.AnimalModel:GetChildren() do
				if child:IsA("Model") then
					guardExistingHumanoid(child)
				end
			end
		else
			guardExistingHumanoid(self.AnimalModel)
		end
	end

	local animators = {}
	local animalAnimFolder = AnimationAnimals:FindFirstChild(self.Index)

	if exclusive_animals[self.Index] then
		for _, child in self.AnimalModel:GetChildren() do
			if child and child:IsA("Model") then
				local animator, ctrlType = getAnimatorInfo(child)
				if animator then
					table.insert(animators, {
						Animator       = animator,
						ControllerType = ctrlType,
						Name           = child.Name,
						ModelRef       = child,
					})
				end
			end
		end
	else
		local animator, ctrlType = getAnimatorInfo(self.AnimalModel)
		if animator then
			table.insert(animators, {
				Animator       = animator,
				ControllerType = ctrlType,
				Name           = self.Index,
				ModelRef       = self.AnimalModel,
			})
		end
	end

	self.RootControllerType = originalControllerType

	self.WalkTracks = {}
	self.IdleTracks = {}

	for _, data in ipairs(animators) do
		local animator  = data.Animator
		local ctrlType  = data.ControllerType
		local walkAnim, idleAnim

		if exclusive_animals[self.Index] then
			local childAnimFolder = AnimationAnimals:FindFirstChild(data.Name)
			walkAnim = childAnimFolder and childAnimFolder:FindFirstChild("Walk")
			idleAnim = childAnimFolder and childAnimFolder:FindFirstChild("Idle")
		else
			walkAnim = animalAnimFolder and animalAnimFolder:FindFirstChild("Walk")
			idleAnim = animalAnimFolder and (
				animalAnimFolder:FindFirstChild("RoadBrainrotIdle") or
					animalAnimFolder:FindFirstChild("Idle")
			)
		end

		if walkAnim then
			local track = animator:LoadAnimation(walkAnim)
			track.Looped = true
			track:AdjustSpeed(walkAnim:GetAttribute("Speed") or 1)
			table.insert(self.WalkTracks, { Track = track, ControllerType = ctrlType })
		end
		if idleAnim then
			local track = animator:LoadAnimation(idleAnim)
			track.Looped = true
			track:AdjustSpeed(idleAnim:GetAttribute("Speed") or 1)
			table.insert(self.IdleTracks, { Track = track, ControllerType = ctrlType })
		end
	end

	local function updateAnimationState()
		local isIdle = self.Instance:GetAttribute("ForceIdle")

		self.AnimalModel:SetAttribute("Walking", not isIdle)

		for _, entry in ipairs(self.WalkTracks) do
			local track = entry.Track
			if isIdle then
				track:Stop()
			else
				if not track.IsPlaying then track:Play() end
			end
		end
		for _, entry in ipairs(self.IdleTracks) do
			local track = entry.Track
			if isIdle then
				if not track.IsPlaying then track:Play() end
			else
				track:Stop()
			end
		end
	end
	for _, part in self.AnimalModel:GetDescendants() do
		if part:IsA("BasePart") then
			part.LocalTransparencyModifier = 0
		elseif part:IsA("ParticleEmitter") then
			part.Enabled = false
			part:Clear()
		elseif part:IsA("Beam") then
			part.Enabled = false
		elseif part:IsA("Trail") then
			part.Enabled = false
		end
	end

	self.Collector:Add(self.Instance:GetAttributeChangedSignal("ForceIdle"):Connect(updateAnimationState))

	self.Collector:Add(task.spawn(function()
		updateAnimationState()
		local firstEntry = self.WalkTracks[1] or self.IdleTracks[1]
		local track = firstEntry and firstEntry.Track
		if track then
			while track.TimePosition <= 0 do
				game:GetService("RunService").Heartbeat:Wait()
			end
		else
			game:GetService("RunService").Heartbeat:Wait()
		end
		if self.AnimalModel and self.AnimalModel.Parent then
			for _, part in self.AnimalModel:GetDescendants() do
				if part:IsA("BasePart") then
					part.LocalTransparencyModifier = 0
				end
			end
			if self.Overhead then
				self.Overhead.Enabled = true
			end
		end
	end))

	local overheadAttachment = self.AnimalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true);
	if not overheadAttachment then
		local newAttachment = Instance.new("Attachment");
		newAttachment.Name = "Info";
		newAttachment.CFrame = CFrame.new(0, modelExtentsSize.Y * 0.75 * (animalDataEntry.OverheadYOffsetModifier or 1), 0);
		newAttachment.Parent = self.Instance.PrimaryPart;
		overheadAttachment = newAttachment;
	end;

	if not animalDataEntry.HideOverhead and not self.Instance:GetAttribute("HideOverhead") then
		local overheadGui, overheadCleanup = FastOverheadController.createFastOverhead({
			adornee    = overheadAttachment,
			guiTemplate = FastOverheadController.GuiTemplates.AnimalOverhead
		});
		self.Overhead = overheadGui;
		self.Collector:Add(overheadCleanup);

		local customRarity = self.Instance:GetAttribute("CustomRarity")
		local customPrice = self.Instance:GetAttribute("CustomPrice")
		local customDisplayName = self.Instance:GetAttribute("CustomDisplayName")

		AnimalOverheadController:Populate({
			Overhead          = self.Overhead,
			Index             = self.Index,
			Mutation          = self.Mutation,
			Trove             = self.Collector,
			CustomRarity      = customRarity,
			CustomPrice       = customPrice,
			CustomDisplayName = customDisplayName,
		});

		updateGenerationText();

		self.Collector:Add(self.Instance:GetAttributeChangedSignal("CustomDisplayName"):Connect(function()
			if not self.Overhead then return end
			local newName = self.Instance:GetAttribute("CustomDisplayName")
			if newName then
				self.Overhead.DisplayName.Text = newName
				return
			end
			self.Overhead.DisplayName.Text =
				AnimalOverheadController:ResolveDisplayName(self.Index, self.Traits)
		end))
	end;
	
	-- 1 OF 1 exist count banner
	local oneOfOneLabel = self.Overhead:FindFirstChild("OneOfOne")
	local lastOneOfOneVisible = false

	local function updateOneOfOne()
		if not oneOfOneLabel then return end

		local data = existsRep.Data
		if type(data) ~= "table" then
			oneOfOneLabel.Visible = false
			return
		end

		local animalEntry = data[self.Index]
		if type(animalEntry) ~= "table" or type(animalEntry.mutations) ~= "table" then
			oneOfOneLabel.Visible = false
			return
		end

		local mutationKey = self.Mutation or "None"
		local count = animalEntry.mutations[mutationKey] or 0
		local visible = (count == 1)

		if visible ~= lastOneOfOneVisible then
			lastOneOfOneVisible = visible
			-- Dump full animal entry for debugging
			local mutDump = "{}"
			if type(animalEntry.mutations) == "table" then
				local parts = {}
				for k, v in pairs(animalEntry.mutations) do
					table.insert(parts, tostring(k) .. "=" .. tostring(v))
				end
				mutDump = "{" .. table.concat(parts, ", ") .. "}"
			end
			warn(string.format("[OneOfOne] Index=%s | MutationAttr=%s | mutationKey=%s | count=%d | visible=%s | mutations=%s", tostring(self.Index), tostring(self.Mutation), mutationKey, count, tostring(visible), mutDump))
		end

		oneOfOneLabel.Visible = visible
	end

	local rootCtrlType = self.RootControllerType
	local yOffset = getControllerYOffset(self.AnimalModel, rootCtrlType, self.Index)

	local function getCompensatedPivot(sourceCFrame)
		if yOffset ~= 0 then
			return sourceCFrame * CFrame.new(0, yOffset, 0)
		end
		return sourceCFrame
	end

	self.AnimalModel:PivotTo(getCompensatedPivot(self.Instance:GetPivot()));

	local animalPrimaryPart = self.AnimalModel.PrimaryPart;
	if animalPrimaryPart then
		animalPrimaryPart.RootPriority = 100;
		local weldConstraint = self.Collector:Add(Instance.new("WeldConstraint"));
		weldConstraint.Part0 = animalPrimaryPart;
		weldConstraint.Part1 = self.Instance.PrimaryPart;
		weldConstraint.Parent = animalPrimaryPart;

		self.Collector:Add(task.spawn(function()
			RunService.Heartbeat:Wait()
			if not self.AnimalModel or not self.AnimalModel.Parent then return end
			for _, part in self.AnimalModel:GetDescendants() do
				if part:IsA("BasePart") then
					part.Anchored = false
				end
			end
		end))

		local function handleClientWeld(child)
			if child.Name ~= "CreateClientWeld" then return end

			local weld = Instance.new("Weld");
			weld.Name = "Weld";
			weld.Part0 = animalPrimaryPart;

			local baseC0 = if yOffset ~= 0 then CFrame.new(0, -yOffset, 0) else CFrame.identity

			local observerCleanups = {
				Observers.observeProperty(child, "Value", function(value)
					weld.Part1 = value;
					return nil;
				end),
				Observers.observeAttribute(child, "C0", function(c0Value)
					weld.C0 = baseC0 * c0Value;
					return nil;
				end),
				Observers.observeAttribute(child, "C1", function(c1Value)
					weld.C1 = c1Value;
					return nil;
				end)
			};
			weld.Parent = animalPrimaryPart;
			weldConstraint.Enabled = false;
			child.Destroying:Once(function()
				weld:Destroy();
				local hasOtherWeld = false;
				for _, sibling in self.Instance:GetChildren() do
					if sibling.Name == "CreateClientWeld" and sibling ~= child then
						hasOtherWeld = true;
						break;
					end;
				end;
				if not hasOtherWeld then
					self.AnimalModel:PivotTo(getCompensatedPivot(self.Instance:GetPivot()));
					weldConstraint.Enabled = true;
				end;
				for _, cleanup in observerCleanups do cleanup() end;
			end);
		end;

		self.Collector:Add(self.Instance.ChildAdded:Connect(function(child)
			handleClientWeld(child);
		end));
		for _, child in self.Instance:GetChildren() do
			self.Collector:Add(task.spawn(handleClientWeld, child));
		end;
	end;

	self.Collector:Add(self.Instance:GetAttributeChangedSignal("Traits"):Connect(applyTraits));
	task.spawn(applyTraits);

	self.Collector:Add(self.Instance:GetAttributeChangedSignal("Index"):Connect(function()
		self.Index = self.Instance:GetAttribute("Index")
	end))

	return self;
end;

AnimalClient.Destroy = function(self)
	self.Collector:Destroy();
end;

return AnimalClient;