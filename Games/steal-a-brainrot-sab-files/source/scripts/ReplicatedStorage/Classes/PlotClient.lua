local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v5 = require(l_Packages_0.Synchronizer);
local v6 = require(l_Packages_0.Trove);
local v7 = require(l_Packages_0.Timer);
local v8 = require(l_Packages_0.Net);
local v9 = l_ReplicatedStorage_0.Packages:FindFirstChild("FFlags") and require(l_ReplicatedStorage_0.Packages.FFlags) or nil;
local _ = l_ReplicatedStorage_0:WaitForChild("Classes");
local v10 = require(script.AnimalPrompt);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v12 = require(l_Utils_0.TimeUtils);
local v13 = require(l_Utils_0.NumberUtils);
local l_BrainrotAssets_0 = require(l_ReplicatedStorage_0:WaitForChild("Shared").BrainrotAssets);
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v16 = require(l_Shared_0.Animals);
local l_AnimalOverhead_0 = l_ReplicatedStorage_0:WaitForChild("Overheads").AnimalOverhead;
local l_Animals_1 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local _ = require(l_Datas_0.Game);
local v21 = require(l_Datas_0.Animals);
local v22 = require(l_Datas_0.Rarities);
local v23 = require(l_Datas_0.Mutations);
local v24 = require(l_Datas_0.Bases);
local v25 = require(l_Datas_0.UnlockBase);
local v26 = require(l_Datas_0.Traits);
local v27 = require(l_ReplicatedStorage_0.Datas.FuseMachineData);
local v28 = l_Datas_0:FindFirstChild("ServerData") and require(l_Datas_0.ServerData) or nil;
local v30 = l_ReplicatedStorage_0.Shared:FindFirstChild("VirtualInstance") and require(l_ReplicatedStorage_0.Shared.VirtualInstance) or nil;
local l_Shared_1 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v29 = require(l_Shared_1.Friends);
local v30ctrl = require(l_ReplicatedStorage_0.Controllers.AnimationSyncController);
local v31 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v32 = require(l_ReplicatedStorage_0.Controllers.ConfirmationController);
local v36 = l_ReplicatedStorage_0.Controllers:FindFirstChild("FastOverheadController") and require(l_ReplicatedStorage_0.Controllers.FastOverheadController) or nil;
local AnimalOverheadController = require(l_ReplicatedStorage_0.Controllers.AnimalOverheadController);

local function IsDuelsServer()
	return v28 and v28.IsDuelsServer and v28.IsDuelsServer() or false
end
local function IsTsunamiServer()
	return v28 and v28.IsTsunamiServer and v28.IsTsunamiServer() or false
end
local function IsNewPlayersServer()
	return v28 and v28.IsNewPlayersServer and v28.IsNewPlayersServer() or false
end

local v33 = v8:RemoteEvent("ShopService/Purchase");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v35 = v8:RemoteEvent("PlotService/Sell");
local v36rem = v8:RemoteEvent("StealService/Grab");
local v37 = v8:RemoteEvent("PlotService/Open");
local v38 = v8:RemoteEvent("PlotService/ClaimCoins");
local v39 = v8:RemoteEvent("3ba148c9-7ed6-4675-93f8-9f7c356a2c54");
local v40 = v8:RemoteEvent("07205405-20ce-4948-b0dd-36b680f698e9")
local v41 = v8:RemoteEvent("PlotService/ToggleFriends");
local botUnlockRemote = v8:RemoteEvent("BotBaseService/Unlock");
local FakePurchase = require(l_ReplicatedStorage_0:WaitForChild("FakePurchase"));
local l_FireServer_0 = v41.FireServer;

local exclusive_animals = require(game.ReplicatedStorage.Exclusive);

local v43 = {};
v43.__index = v43;

local DEBUG_PLOTCLIENT = false
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
local function dbg(fmt, ...)
	if not DEBUG_PLOTCLIENT then return end
	print(("[PlotClient] " .. fmt):format(...))
end

local function resolveLivePlot(self)
	local plotsFolder = workspace:FindFirstChild("Plots")
	if plotsFolder then
		local live = plotsFolder:FindFirstChild(self.UID)
		if live then
			if live ~= self.PlotModel then
				dbg("resolveLivePlot: PlotModel reference was stale for UID=%s, refreshing (old.Parent=%s, new.Parent=%s)",
					tostring(self.UID),
					tostring(self.PlotModel and self.PlotModel.Parent),
					tostring(live.Parent))
				self.PlotModel = live
			end
			return live
		end
	end
	if self.PlotModel and self.PlotModel:IsDescendantOf(workspace) then
		return self.PlotModel
	end
	return nil
end

local function normalizeAnimalList(t)
	if type(t) ~= "table" then return t end
	local needsRebuild = false
	for k in pairs(t) do
		if type(k) == "string" and tonumber(k) then
			needsRebuild = true
			break
		end
	end
	if not needsRebuild then return t end
	local out = {}
	for k, v in pairs(t) do
		local nk = tonumber(k)
		if nk then out[nk] = v else out[k] = v end
	end
	return out
end

v43.ClearIndex = function(v44, v45)
	if v44.AnimalsModels[v45] then
		v44.AnimalsModels[v45]:Destroy();
		v44.AnimalsModels[v45] = nil;
	end;

	local livePlotForSweep = resolveLivePlot(v44) or v44.PlotModel
	if livePlotForSweep then
		for _, stray in livePlotForSweep:GetChildren() do
			if stray:IsA("Model") and stray:GetAttribute("__PodiumSlot") == v45 then
				pcall(function() stray:Destroy() end)
			end
		end
	end

	if v44.ModelsCollector[v45] then
		v44.ModelsCollector[v45]:Clean();
		v44.ModelsCollector[v45] = nil;
	end;

	local animalPodiumsFolder = v44.PlotModel and v44.PlotModel:FindFirstChild("AnimalPodiums")
	if animalPodiumsFolder then
		local podiumInstance = animalPodiumsFolder:FindFirstChild(tostring(v45))
		if podiumInstance then
			local guiEntry = v44.CollectGuis[podiumInstance]
			if guiEntry then
				if guiEntry.gui then
					pcall(function() guiEntry.gui:Destroy() end)
				end
				v44.CollectGuis[podiumInstance] = nil
			end
		end
	end
end;

v43.UpdateModel = function(v46, v47)
	local v48 = normalizeAnimalList(v46.Channel:Get("AnimalList") or {});

	if DEBUG_PLOTCLIENT then
		local sd = v48[v47]
		local existing = v46.AnimalsModels[v47]
		dbg("UM-slot%d ENTRY: dataIndex=%s curIdx=%s existing=%s exParent=%s",
			v47,
			tostring(type(sd) == "table" and sd.Index),
			tostring(v46.AnimalsIndex[v47]),
			tostring(existing),
			tostring(existing and existing.Parent and existing.Parent.Name))
	end

	if v48[v47] and v46.AnimalsIndex[v47] ~= v48[v47].Index then
		v46:ClearIndex(v47);
		v46.AnimalsIndex[v47] = v48[v47].Index;
	end;
	local v49 = v46.AnimalsModels[v47];
	local v50 = not v49 and type(v48[v47]) == "table";
	local rebuildReason = v50 and "no-existing-model" or nil
	if not v50 and v49 then
		if v49:GetAttribute("Mutation") ~= v48[v47].Mutation then
			v50 = true; rebuildReason = "mutation-changed"
		end;
		if type(v48[v47].Traits) == "table" and v49:GetAttribute("Traits") ~= table.concat(v48[v47].Traits, ",") then
			v50 = true; rebuildReason = "traits-changed"
		end;
		if type(v48[v47].Traits) ~= "table" and v49:GetAttribute("Traits") ~= nil then
			v50 = true; rebuildReason = "traits-cleared"
		end;
	end;
	if DEBUG_PLOTCLIENT then
		dbg("UM-slot%d: rebuild=%s reason=%s", v47, tostring(v50), tostring(rebuildReason))
	end
	if v50 then
		v46:ClearIndex(v47);
		v46.AnimalsIndex[v47] = v48[v47].Index;
	end;
	if v50 then
		v46.AnimalsBuildGen = v46.AnimalsBuildGen or {}
		local myBuildGen = (v46.AnimalsBuildGen[v47] or 0) + 1
		v46.AnimalsBuildGen[v47] = myBuildGen

		local v51 = v46.ModelsCollector[v47];
		if v51 then
			v51:Clean();
		else
			v51 = v6.new();
			v46.ModelsCollector[v47] = v51;
		end;
		local l_l_Animals_0_FirstChild_0 = l_BrainrotAssets_0.getModel(v48[v47].Index);
		if v46.AnimalsBuildGen[v47] ~= myBuildGen then
			return;
		end
		if not l_l_Animals_0_FirstChild_0 then
			return;
		else
			local v53 = l_l_Animals_0_FirstChild_0:Clone();
			v53:SetAttribute("__PodiumSlot", v47);
			local prevModel = v46.AnimalsModels[v47]
			if prevModel and prevModel ~= v53 then
				pcall(function() prevModel:Destroy() end)
			end
			v46.AnimalsModels[v47] = v53;

			local function forceCollisionOff(model)
				for _, part in model:GetDescendants() do
					if part:IsA("BasePart") then
						part.CanCollide = false
						part.CanQuery = false
						part.CanTouch = false
						part.LocalTransparencyModifier = 0
					end
				end
			end

			local function configureHumanoid(hum, model)
				hum.EvaluateStateMachine = false
				hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
				hum.PlatformStand = true

				forceCollisionOff(model)

				v51:Add(hum.StateChanged:Connect(function()
					forceCollisionOff(model)
				end))

				v51:Add(model.DescendantAdded:Connect(function(desc)
					if desc:IsA("BasePart") then
						task.defer(function()
							if desc and desc.Parent then
								desc.CanCollide = false
								desc.CanQuery = false
								desc.CanTouch = false
								desc.LocalTransparencyModifier = 0
							end
						end)
					end
				end))
			end

			local preExistingHumanoid = v53:FindFirstChildOfClass("Humanoid")
			if preExistingHumanoid then
				configureHumanoid(preExistingHumanoid, v53)
			end

			for _, v55 in v53:GetDescendants() do
				if v55:IsA("BasePart") then
					v55.CanCollide = false;
					v55.CanQuery = false;
					v55.CanTouch = false;
					v55.Massless = true;
					v55.LocalTransparencyModifier = 0;
				end;
			end;

			local livePlot = resolveLivePlot(v46)
			if not livePlot then
				dbg("UpdateModel: no live plot for UID=%s, slot=%s — aborting render", tostring(v46.UID), tostring(v47))
				if v46.AnimalsModels[v47] == v53 then v46.AnimalsModels[v47] = nil end
				v53:Destroy()
				return
			end

			local liveAnimalPodiums = livePlot:FindFirstChild("AnimalPodiums")
			local targetPodium = liveAnimalPodiums and liveAnimalPodiums:FindFirstChild(tostring(v47))
			dbg("UpdateModel: UID=%s slot=%s livePlot.Name=%s livePlot.Parent=%s podium=%s",
				tostring(v46.UID), tostring(v47),
				tostring(livePlot.Name), tostring(livePlot.Parent),
				tostring(targetPodium))

			if not targetPodium and liveAnimalPodiums then
				targetPodium = liveAnimalPodiums:WaitForChild(tostring(v47), 5)
				dbg("UpdateModel: waited for podium slot=%s, found=%s", tostring(v47), tostring(targetPodium))
			end

			if v46.AnimalsBuildGen[v47] ~= myBuildGen then
				if v46.AnimalsModels[v47] == v53 then v46.AnimalsModels[v47] = nil end
				pcall(function() v53:Destroy() end)
				return
			end

			if not targetPodium or not targetPodium:FindFirstChild("Base") or not targetPodium.Base:FindFirstChild("Spawn") then
				dbg("UpdateModel: target podium incomplete for slot=%s — aborting render", tostring(v47))
				if v46.AnimalsModels[v47] == v53 then v46.AnimalsModels[v47] = nil end
				v53:Destroy()
				return
			end

			v53.Parent = livePlot;
			v53.PrimaryPart.Anchored = true;

			forceCollisionOff(v53)
			for _, part in v53:GetDescendants() do
				if part:IsA("BasePart") then
					part.LocalTransparencyModifier = 0
				end
			end

			for _, stray in livePlot:GetChildren() do
				if stray ~= v53 and stray:IsA("Model") and stray:GetAttribute("__PodiumSlot") == v47 then
					pcall(function() stray:Destroy() end)
				end
			end

			local l_Mutation_0 = v48[v47].Mutation;

			if DEBUG_PLOTCLIENT then
				dbg("UM-slot%d: PARENTED clone=%s parentNow=%s clonePivotPos=%s",
					v47,
					tostring(v53.Name),
					tostring(v53.Parent and v53.Parent.Name),
					tostring(v53:GetPivot().Position))
			end

			if v9 and v28 and v9:GetInstant("Optimisation.HumanoidBrainrotModels") or require(game.ReplicatedStorage.Shared.GetServerType):IsPublicServer() then
				local existingHum = v53:FindFirstChildOfClass("Humanoid")
				if not existingHum then
					local existingAC = v53:FindFirstChild("AnimationController");
					if existingAC then existingAC:Destroy(); end;

					local hum = Instance.new("Humanoid");
					Instance.new("Animator", hum);
					hum.Name = "AnimationController";
					hum.Parent = v53;

					configureHumanoid(hum, v53)
				else
					if existingHum.Name ~= "AnimationController" then
						existingHum.Name = "AnimationController"
					end
					if not existingHum:FindFirstChildOfClass("Animator") then
						Instance.new("Animator", existingHum)
					end
				end
			end;

			if l_Mutation_0 then
				if exclusive_animals[v48[v47].Index] then
					for _, child in v53:GetChildren() do
						if child:IsA("Model") then
							local mutationCleanup = v16:ApplyMutation(child, child.Name, l_Mutation_0)
							if mutationCleanup then v51:Add(mutationCleanup) end
						end
					end
				else
					local mutationCleanup = v16:ApplyMutation(v53, v48[v47].Index, l_Mutation_0)
					if mutationCleanup then v51:Add(mutationCleanup) end
				end
				v53:SetAttribute("Mutation", l_Mutation_0)
			end

			local l_v53_ExtentsSize_0 = v53:GetExtentsSize();
			local l_Traits_0 = v48[v47].Traits;

			if l_Traits_0 then
				if exclusive_animals[v48[v47].Index] then
					for _, child in v53:GetChildren() do
						if child:IsA("Model") then
							local traitsCleanup = v16:ApplyTraits(child, child.Name, l_Traits_0)
							if traitsCleanup then v51:Add(traitsCleanup) end
						end
					end
				else
					local traitsCleanup = v16:ApplyTraits(v53, v48[v47].Index, l_Traits_0)
					if traitsCleanup then v51:Add(traitsCleanup) end
				end
				v53:SetAttribute("Traits", table.concat(l_Traits_0, ","))
			end

			for _, part in v53:GetDescendants() do
				if part:IsA("BasePart") then
					part.LocalTransparencyModifier = 0
				end
			end

			local spawnPart = targetPodium.Base.Spawn
			local customModelScale = spawnPart:GetAttribute("CustomModelScale")
				or v48[v47].CustomModelScale
			local applyScale = type(customModelScale) == "number"
				and customModelScale > 0
				and customModelScale ~= 1

			local pivotToBottom = 0
			if applyScale then
				local okBB, oldCf, oldSize = pcall(function() return v53:GetBoundingBox() end)
				if okBB and oldCf and oldSize then
					pivotToBottom = v53:GetPivot().Position.Y - (oldCf.Position.Y - oldSize.Y * 0.5)
				end

				if exclusive_animals[v48[v47].Index] then
					for _, child in v53:GetChildren() do
						if child:IsA("Model") then
							local ok, cur = pcall(function() return child:GetScale() end)
							if ok and cur then
								pcall(function() child:ScaleTo(cur * customModelScale) end)
							end
						end
					end
				else
					local ok, cur = pcall(function() return v53:GetScale() end)
					if ok and cur then
						pcall(function() v53:ScaleTo(cur * customModelScale) end)
					end
				end
				l_v53_ExtentsSize_0 = v53:GetExtentsSize()
			end
			local animators = {}
			local animalIndex = v48[v47].Index

			if exclusive_animals[animalIndex] then
				for _, child in v53:GetChildren() do
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
				local animator, ctrlType = getAnimatorInfo(v53)
				if animator then
					table.insert(animators, {
						Animator       = animator,
						ControllerType = ctrlType,
						Name           = animalIndex,
						ModelRef       = v53,
					})
				end
			end

			local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(animalIndex)
			for _, data in ipairs(animators) do
				local targetAnimator = data.Animator
				local idleAnim

				if exclusive_animals[animalIndex] then
					local childAnimFolder = l_Animals_1:FindFirstChild(data.Name)
					idleAnim = childAnimFolder and childAnimFolder:FindFirstChild("Idle")
				else
					idleAnim = l_l_Animals_1_FirstChild_0 and l_l_Animals_1_FirstChild_0:FindFirstChild("Idle")
				end

				if idleAnim and targetAnimator then
					local track = targetAnimator:LoadAnimation(idleAnim)
					track.Looped = true
					track:AdjustSpeed(idleAnim:GetAttribute("Speed") or 1)
					track:Play()
					local syncCleanup = v30ctrl:Add(track)
					v51:Add(function()
						syncCleanup()
						track:Stop(0)
						track:Destroy()
					end)
				end
			end
			local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(animalIndex)
			for _, data in ipairs(animators) do
				local targetAnimator = data.Animator
				local idleAnim

				if exclusive_animals[animalIndex] then
					local childAnimFolder = l_Animals_1:FindFirstChild(data.Name)
					idleAnim = childAnimFolder and childAnimFolder:FindFirstChild("Idle")
				else
					idleAnim = l_l_Animals_1_FirstChild_0 and l_l_Animals_1_FirstChild_0:FindFirstChild("Idle")
				end

				if idleAnim and targetAnimator then
					local track = targetAnimator:LoadAnimation(idleAnim)
					track.Looped = true
					track:AdjustSpeed(idleAnim:GetAttribute("Speed") or 1)
					track:Play()
					local syncCleanup = v30ctrl:Add(track)
					v51:Add(function()
						syncCleanup()
						track:Stop(0)
						track:Destroy()
					end)
				end
			end

			local controllerType = animators[1] and animators[1].ControllerType or "AnimationController"
			local yOffset = getControllerYOffset(v53, controllerType, animalIndex)

			local basePivot = spawnPart:GetPivot()
			if yOffset ~= 0 then
				basePivot = basePivot * CFrame.new(0, yOffset, 0)
			end
			v53:PivotTo(basePivot);

			for _, part in v53:GetDescendants() do
				if part:IsA("BasePart") then
					part.LocalTransparencyModifier = 0
				end
			end

	
			if applyScale and math.abs(pivotToBottom) > 0.001 then
				local lift = (customModelScale - 1) * pivotToBottom
				if math.abs(lift) > 0.001 then
					v53:PivotTo(v53:GetPivot() * CFrame.new(0, lift, 0))
				end
			end
			
			if DEBUG_PLOTCLIENT then
				dbg("UM-slot%d: PIVOTED targetPivot=%s clonePivot=%s descendantOfWS=%s",
					v47,
					tostring(targetPodium.Base.Spawn:GetPivot().Position),
					tostring(v53:GetPivot().Position),
					tostring(v53:IsDescendantOf(workspace)))
			end

			local v67 = v21[v48[v47].Index];
			local l_v53_FirstChild_0 = v53:FindFirstChild("OVERHEAD_ATTACHMENT", true);
			if not l_v53_FirstChild_0 then
				local v69 = v51:Add(Instance.new("Attachment"));
				v69.CFrame = CFrame.new(0, l_v53_ExtentsSize_0.Y * 0.75 * (v67 and v67.OverheadYOffsetModifier or 1), 0);
				v69.Parent = targetPodium.Base.Spawn;
				l_v53_FirstChild_0 = v69;
			end;

			local v70 = v22[v67.Rarity];

			local v71
			if v36 then
				local gui, cleanup = v36.createFastOverhead({
					adornee = l_v53_FirstChild_0,
					guiTemplate = v36.GuiTemplates.AnimalOverhead
				});
				v71 = gui;
				v51:Add(function()
					pcall(cleanup)
					if gui and gui.Parent then
						pcall(function() gui:Destroy() end)
					end
				end)
			else
				v71 = v51:Clone(l_AnimalOverhead_0);
			end

			local l_Generation_0 = v71.Generation;

			local function v75()
				local v73 = v46.Channel:Get((("AnimalList.%*"):format(v47)));

				if v48[v47].Index == "Coffin Tung Tung Tung Sahur" then
					l_Generation_0.Text = "";
					l_Generation_0.Visible = false;
					return;
				end;

				local animalEntry = v21[v48[v47].Index]
				if animalEntry and animalEntry.Egg then
					local timer = (v73 and v73.Timer) or v48[v47].Timer
					if timer ~= nil then
						l_Generation_0.Text = timer <= 0 and "READY!" or v12:E(timer)
					else
						l_Generation_0.Text = "READY!"
					end
					return
				end

				if type(v73) ~= "table" then v73 = nil; end;
				if v73 and v73.Timer ~= nil then

					l_Generation_0.Text = v73.Timer <= 0 and "READY!" or v12:E(v73.Timer);
					return;
				elseif v73 and v73.Machine and (v73.Machine.Type == "Crafting" or v73.Machine.Type == "OGCrafting" or v73.Machine.Type == "Fuse") and v73.Machine.Active then
					local v74 = (v73.Machine.FinishTime or 0) - workspace:GetServerTimeNow();
					l_Generation_0.Text = v74 <= 0 and "READY!" or v12:E(v74);
					return;
				else
					local customGen = v48[v47].CustomGeneration
					if customGen then
						local gen = AnimalOverheadController:CalculateGenerationWithMultipliers(customGen, v48[v47].Traits, v48[v47].Mutation)
						l_Generation_0.Text = ("$%*/s"):format(v13:ToString(gen))
					else
						l_Generation_0.Text = ("$%*/s"):format((v13:ToString(v16:GetGeneration(v48[v47].Index, v48[v47].Mutation, v48[v47].Traits, nil))));
					end
					if l_Generation_0.SetAttribute then
						l_Generation_0.Visible = l_Generation_0.Text ~= "";
					end
					return;
				end;
			end;

			local customRarity = v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47))
				and v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47)).Base.Spawn:GetAttribute("CustomRarity")
				or v48[v47].CustomRarity

			local customPrice = v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47))
				and v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47)).Base.Spawn:GetAttribute("CustomPrice")
				or v48[v47].CustomPrice

			local customDisplayName = v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47))
				and v46.PlotModel.AnimalPodiums:FindFirstChild(tostring(v47)).Base.Spawn:GetAttribute("CustomDisplayName")
				or v48[v47].CustomDisplayName

			AnimalOverheadController:Populate({
				Overhead          = v71,
				Index             = v48[v47].Index,
				Traits            = l_Traits_0,
				Mutation          = l_Mutation_0,
				Player            = l_LocalPlayer_0,
				Trove             = v51,
				CustomRarity      = customRarity,
				CustomPrice       = customPrice,
				CustomDisplayName = customDisplayName,
			});
			task.spawn(v75);
			v51:Add(v46.Channel:OnChanged("AnimalList", v75));
			v51:Add(v7.Simple(1, v75));

			v51:Add(v46.PlotModel:GetAttributeChangedSignal("Nuked"):Connect(function()
				if v46.PlotModel:GetAttribute("Nuked") then
					v71:Destroy();
				end;
			end));

			local function v91()
				task.spawn(v75);
				local v82 = v46.Channel:Get((("AnimalList.%*"):format(v47)));
				if type(v82) ~= "table" then v82 = nil; end;
				local l_v46_Owner_0 = v46:GetOwner();
				local v84 = l_v46_Owner_0 and v82 and v82.Steal == l_v46_Owner_0.UserId;
				for _, v86 in v53:GetDescendants() do
					if v86:IsA("BasePart") then
						local l_v86_Attribute_0 = v86:GetAttribute("DefaultTransparency");
						if l_v86_Attribute_0 == nil then
							l_v86_Attribute_0 = v86.Transparency;
							v86:SetAttribute("DefaultTransparency", l_v86_Attribute_0);
						end;
						if v82 and (v82.Steal or v82.Machine) and v86.Transparency < 1 then
							v86.Transparency = 0.5;
						else
							v86.Transparency = l_v86_Attribute_0;
						end;
					end;
				end;
				for _, v89 in v71:GetChildren() do
					if v89:IsA("TextLabel") then
						if not v89:GetAttribute("DefaultState") then
							v89:SetAttribute("DefaultState", v89.Visible);
						end

						if v89.Name == "Stolen" then
							local v90 = v82 and v82.Machine
							if v90 then
								if v90.Type == "Crafting" and v90.Active then
									v89.Text = "CRAFTING"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								elseif v90.Type == "OGCrafting" and v90.Active then
									v89.Text = "CRAFTING"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								elseif v90.Type == "Fuse" and v90.Active then
									v89.Text = "FUSING"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								elseif v90.Type == "Fuse" then
									v89.Text = "IN FUSE"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255);
								elseif v90.Type == "Duel" then
									v89.Text = "IN DUEL"
									v89.TextColor3 = Color3.fromRGB(255, 94, 78)
								elseif v90.Type == "Trade" then
									v89.Text = "IN TRADE"
									v89.TextColor3 = Color3.fromRGB(255, 165, 0)
								elseif v90.Type == "BrainrotTrader" then
									v89.Text = "IN MACHINE"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								elseif v90.Type == "Taco" or v90.Type == "Taco2" then
									v89.Text = "IN MACHINE"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								else
									v89.Text = "IN MACHINE"
									v89.TextColor3 = Color3.fromRGB(0, 140, 255)
								end
							else
								local stealerId = v82 and v82.Steal
								local owner = v46:GetOwner()
								if owner and stealerId == owner.UserId then
									v89.Text = ""
									v89.Visible = false
								else
									v89.Text = "STOLEN"
									v89.TextColor3 = Color3.fromRGB(255, 0, 4)
									v89.Visible = true
								end
							end
						end

						if v82 and (v82.Steal or v82.Machine) then
							if v89.Name == "Stolen" then
								v89.Visible = not v84;
							elseif v89.Name == "Generation" then
								v89.Visible = v82.Machine and v82.Machine.Active;
							else
								v89.Visible = false;
							end
						elseif v89.Name == "Stolen" then
							v89.Visible = false;
						else
							v89.Visible = v89:GetAttribute("DefaultState");
						end
					end
				end
			end

			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Steal"):format(v47), v91, true));
			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Machine"):format(v47), v91));

			v51:Add(v46.Channel:OnChanged(string.format("AnimalList.%d", v47), function(slotData)
				if type(slotData) == "table" then
					local animalEntry = v21[slotData.Index]
					if animalEntry and animalEntry.LuckyBlock then
						v46.AnimalsIndex[v47] = nil
					end
					v91();
				else
					v46:ClearIndex(v47)
					v46:HideClaim(v47)
				end
			end));

			v51:Add(v46.Channel:OnChanged("AnimalList", function(v92)
				v92 = normalizeAnimalList(typeof(v92) == "table" and v92 or {})
				if type(v92[v47]) == "table" then
					local podiumData = v92[v47]
					local animalEntry = podiumData and v21[podiumData.Index]
					if animalEntry and animalEntry.LuckyBlock then
						v46.AnimalsIndex[v47] = nil
					end
					v91();
				else
					v46:ClearIndex(v47)
					v46:HideClaim(v47)
				end
			end));
		end;
	end;
end;

v43.HideClaim = function(v93, v94)
	local animalPodiumsFolder = v93.PlotModel and v93.PlotModel:FindFirstChild("AnimalPodiums")
	if not animalPodiumsFolder then return end

	local l_FirstChild_0 = animalPodiumsFolder:FindFirstChild(tostring(v94));
	if l_FirstChild_0 then
		if v93.CollectGuis then
			local guiEntry = v93.CollectGuis[l_FirstChild_0]
			if guiEntry then
				if guiEntry.conn then
					pcall(function() guiEntry.conn:Disconnect() end)
					guiEntry.conn = nil
				end
				if guiEntry.cleanup then
					pcall(guiEntry.cleanup)
					guiEntry.cleanup = nil
				end
				if guiEntry.gui then
					pcall(function() guiEntry.gui.Enabled = false end)
					pcall(function() guiEntry.gui:Destroy() end)
				end
				v93.CollectGuis[l_FirstChild_0] = nil
				return;
			end
		end
		if l_FirstChild_0:FindFirstChild("Claim") then
			local collect = l_FirstChild_0.Claim:FindFirstChild("Main")
				and l_FirstChild_0.Claim.Main:FindFirstChild("Collect")
			if collect then
				collect.Enabled = false;
			end
		end;
	end;
end;

v43.UpdateClaim = function(v96, v97)
	local v98 = normalizeAnimalList(v96.Channel:Get("AnimalList") or {})[v97];
	local v99 = v21[v98.Index];
	local timeElapsed = math.floor(workspace:GetServerTimeNow() - v98.LastCollect)
	local generation
	if v98.CustomGeneration then
		generation = AnimalOverheadController:CalculateGenerationWithMultipliers(v98.CustomGeneration, v98.Traits, v98.Mutation)
	else
		generation = v16:GetGeneration(v98.Index, v98.Mutation, v98.Traits, l_LocalPlayer_0)
	end
	local v100 = timeElapsed * generation

	local l_FirstChild_1 = v96.PlotModel.AnimalPodiums:FindFirstChild(tostring(v97));
	if not l_FirstChild_1 then return; end;

	local legacyClaim = l_FirstChild_1:FindFirstChild("Claim") and l_FirstChild_1.Claim:FindFirstChild("Main") and l_FirstChild_1.Claim.Main:FindFirstChild("Collect")
	if legacyClaim then
		legacyClaim.Enabled = false
	end

	if v96.CollectGuis and v36 then
		local guiEntry = v96.CollectGuis[l_FirstChild_1];
		if not guiEntry then
			local gui, cleanup = v36.createFastOverhead({
				adornee = l_FirstChild_1.Claim.Main,
				guiTemplate = v36.GuiTemplates.CashPad
			});
			local conn;
			conn = l_FirstChild_1.AncestryChanged:Connect(function()
				if not l_FirstChild_1:IsDescendantOf(workspace) then
					cleanup();
					conn:Disconnect();
					v96.CollectGuis[l_FirstChild_1] = nil;
				end;
			end);
			if v30 then
				guiEntry = {
					gui = gui,
					cleanup = cleanup,
					conn = conn,
					collect = v30.wrap(gui.Collect),
					collectAmount = v30.wrap(gui.CollectAmount),
					offline = v30.wrap(gui.Offline)
				};
			else
				guiEntry = { gui = gui, cleanup = cleanup, conn = conn };
			end
			v96.CollectGuis[l_FirstChild_1] = guiEntry;
		end

		if v98.Index == "Coffin Tung Tung Tung Sahur"
			or (v99 and v99.LuckyBlock)
			or (v99 and v99.Egg)
			or v98.Machine
			or IsDuelsServer()
		then
			guiEntry.gui.Enabled = false;
		else
			local collectLabel = guiEntry.collectAmount or (guiEntry.gui:FindFirstChild("CollectAmount") or guiEntry.gui:FindFirstChild("Collect"))
			if collectLabel then
				collectLabel.Text = ("$%s"):format(v13:ToString(v100));
			end
			if v98.OfflineGain then
				local offlineLabel = guiEntry.offline or guiEntry.gui:FindFirstChild("Offline")
				if offlineLabel then
					offlineLabel.Text = ("(Offline Cash: <font color=\"#73ff00\">$%s</font>)"):format(v13:ToString(v98.OfflineGain * generation));
					offlineLabel.Visible = true;
				end
			else
				local offlineLabel = guiEntry.offline or (guiEntry.gui and guiEntry.gui:FindFirstChild("Offline"))
				if offlineLabel then
					offlineLabel.Visible = false
				end
			end
			guiEntry.gui.Enabled = true;
		end
		return;
	end

	local l_Collect_0 = l_FirstChild_1:FindFirstChild("Claim") and l_FirstChild_1.Claim.Main.Collect;
	if not l_Collect_0 then return; end;

	if v98.Index == "Coffin Tung Tung Tung Sahur" then
		l_Collect_0.Enabled = false;
		return;
	end;
	if v99 and v99.LuckyBlock then
		l_Collect_0.Enabled = false;
		return;
	elseif v98.Machine then
		l_Collect_0.Enabled = false;
		return;
	else
		l_Collect_0.Collect.Text = ("Collect <br/><font color=\"#73ff00\">$%s</font>"):format(v13:ToString(v100));
		if v98.OfflineGain then
			l_Collect_0.Offline.Text = ("(Offline Cash: <font color=\"#73ff00\">$%s</font>)"):format(v13:ToString(v98.OfflineGain * generation));
		end;
		l_Collect_0.Offline.Visible = v98.OfflineGain ~= nil;
		l_Collect_0.Enabled = true;
		return;
	end;
end;

v43.UpdatePrompt = function(v102, v103)
	local l_FirstChild_1 = v102.PlotModel.AnimalPodiums:FindFirstChild(tostring(v103));
	local v105 = normalizeAnimalList(v102.Channel:Get("AnimalList") or {});
	local v106 = v105[v103];
	if l_FirstChild_1:GetAttribute("DeferDisplay") then
		v106 = nil;
	elseif type(v106) ~= "table" then
		v106 = nil;
	end;
	local v107 = if v106 then v106.Index else ("None_%*"):format((tostring(v103)));
	local l_Spawn_0 = l_FirstChild_1.Base.Spawn;
	local v109 = v102.AnimalsPrompts[v103];
	if v109 and v109.AnimalIndex ~= v107 then
		for _, v111 in v109.Prompts do
			v111:Destroy();
		end;
		v109 = nil;
	end;
	if not v109 then
		local v112 = {
			AnimalIndex = v107,
			Prompts = {
				v10.new(v103, v107, l_Spawn_0.PromptAttachment),
				v10.new(v103, v107, l_Spawn_0.PromptAttachment, {
					KeyboardKeyCode = Enum.KeyCode.F,
					GamepadKeyCode = Enum.KeyCode.ButtonY,
					UIOffset = Vector2.new(0, -72)
				})
			}
		};
		local v113 = {};
		local l_v113_0 = v113;
		local function _()
			local l_l_FirstChild_1_FirstChild_0 = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
			if l_l_FirstChild_1_FirstChild_0 and l_l_FirstChild_1_FirstChild_0:IsA("BillboardGui") then
				l_l_FirstChild_1_FirstChild_0.AlwaysOnTop = next(l_v113_0) ~= nil;
			end;
		end;
		for _, v118 in pairs(v112.Prompts) do
			v118.Collector:Add(v118.ProximityPrompt.PromptShown:Connect(function()
				v113[v118.ProximityPrompt] = true;
				local gui = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if gui and gui:IsA("BillboardGui") then gui.AlwaysOnTop = next(v113) ~= nil; end;
			end));
			v118.Collector:Add(v118.ProximityPrompt.PromptHidden:Connect(function()
				v113[v118.ProximityPrompt] = nil;
				local gui = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if gui and gui:IsA("BillboardGui") then gui.AlwaysOnTop = next(v113) ~= nil; end;
			end));
			v118.Collector:Add(function()
				v113[v118.ProximityPrompt] = nil;
				local gui = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if gui and gui:IsA("BillboardGui") then gui.AlwaysOnTop = next(v113) ~= nil; end;
			end);
			v118.Collector:Add(v118.ProximityPrompt.PromptButtonHoldBegan:Connect(function()
				for _, v123 in v112.Prompts do
					if v123 ~= v118 then v123.ProximityPrompt.Enabled = false; end;
				end;
			end));
			v118.Collector:Add(v118.ProximityPrompt.PromptButtonHoldEnded:Connect(function()
				for _, v125 in v112.Prompts do
					if v125 ~= v118 then
						v125.ProximityPrompt.Enabled = true;
						v125:SetState(v125.State);
					end;
				end;
			end));
		end;
		v109 = v112;
		v102.AnimalsPrompts[v103] = v109;
	end;
	assert(v109);
	local v126 = v109.Prompts[1];
	local v127 = v109.Prompts[2];

	if v102:GetOwner() == l_LocalPlayer_0 then
		local isTrading = l_LocalPlayer_0:GetAttribute("IsTrading") == true;
		local v128 = false;
		if l_LocalPlayer_0:GetAttribute("Stealing") then
			for _, v130 in v105 do
				if v130.Steal == l_LocalPlayer_0.UserId then
					v128 = true;
					break;
				end;
			end;
		end;
		if (not v106 and not v128) or (v106 and v106.Machine and v106.Machine.Active) or isTrading then
			if v126.State ~= "None" then v126:SetState("None"); end;
			if v127.State ~= "None" then v127:SetState("None"); end;
			return;
		elseif v128 then
			if v126.State ~= "Place" then
				v126:SetState("Place", function()
					v36rem:FireServer("Place", v103);
				end);
			end;
			if v127.State ~= "None" then v127:SetState("None"); end;
			return;
		elseif v106 and v106.Machine and not v106.Machine.Active and not IsDuelsServer() then
			if v126.State ~= "Return" then
				v126:SetState("Return", function()
					local v131 = v106.Machine and v106.Machine.Type;
					if v131 == "Fuse" then
						local v132, v133 = v27.Remotes.RemoveBrainrot:InvokeServer(v103);
						if not v132 then
							v31:Error(v133 or "Something went wrong!");
							return;
						end;
					elseif v131 == "Crafting" then
						v8:RemoteEvent("CraftingMachineService/Return"):FireServer(v103);
						return;
					elseif v131 == "OGCrafting" then
						v8:RemoteEvent("CraftingMachineService/Return"):FireServer(v103);
						return;
					elseif v131 == "BrainrotTrader" then
						v8:RemoteEvent("BrainrotTraderService/Return"):FireServer(v103);
						return;
					elseif v131 == "Taco2" or v131 == "Taco" then
						v8:RemoteEvent("StockEventService/Return"):FireServer(v103)
					else
						v8:RemoteEvent("StockEventService/Return"):FireServer(v131, v103)
					end;
				end);
			end;
			if v127.State ~= "None" then v127:SetState("None"); end;
			return;
		else
			local v134 = v106 and v106.Timer or 1;
			if v107 == "Coffin Tung Tung Tung Sahur" then v134 = 0; end;
			local animalEntryCheck = v21[v107]
			if animalEntryCheck and animalEntryCheck.Egg then
				if v106.Timer ~= nil then
					v134 = v106.Timer
				else
					v134 = 0
				end
			end

			if v106 and v106.Steal then
				if v126.State ~= "None" then v126:SetState("None"); end;
			elseif v126.State ~= "Grab" and v134 > 0 then
				v126:SetState("Grab", function()
					v36rem:FireServer("Grab", v103);
				end);
			elseif v126.State ~= "Open" and v134 <= 0 then
				v126:SetState("Open", function()
					v37:FireServer(v103);
				end);
			end;

			if v106 and v106.Steal then
				if v127.State ~= "None" then v127:SetState("None"); end;
			elseif v127.State ~= "Sell" then
				v127:SetState("Sell", function()
					local l_AnimalIndex_0 = v102.AnimalsPrompts[v103].AnimalIndex;
					local l_Rarity_0 = v21[l_AnimalIndex_0].Rarity;
					local needsConfirm = false;
					if v16.GetRarityWeight then
						needsConfirm = v16:GetRarityWeight(l_Rarity_0) >= 5;
					else
						needsConfirm = l_Rarity_0 == "OG" or l_Rarity_0 == "Admin"
							or l_Rarity_0 == "Taco" or l_Rarity_0 == "Secret"
							or l_Rarity_0 == "Brainrot God";
					end
					if needsConfirm then
						local v138 = ("Do you want to sell %*?"):format(l_AnimalIndex_0);
						if not (not v32:IsInPrompt() and (v32:Show(v138) or false)) then
							return;
						end;
					end;
					v35:FireServer(v103);
				end);
			end;
		end;
	elseif v106 and v106.Steal and v106.Steal ~= "FuseMachine" then
		if v126.State ~= "None" then v126:SetState("None"); end;
		if v127.State ~= "None" then v127:SetState("None"); end;
	elseif IsTsunamiServer() or l_LocalPlayer_0:GetAttribute("IsTrading") then
		if v126.State ~= "None" then v126:SetState("None"); end;
		if v127.State ~= "None" then v127:SetState("None"); end;
	elseif v106 and (not v106.Machine or v106.Machine.Active ~= true) then
		if v126.State ~= "Steal" then
			v126:SetState("Steal", function()
				v39:FireServer(workspace:GetServerTimeNow() + 67, "579e6c26-5a80-407d-9488-0f84752e8f1f", v102.PlotModel.Name, v103);
			end);
		end;
		if v127.State ~= "None" then v127:SetState("None"); end;
	else
		if v126.State ~= "None" then v126:SetState("None"); end;
		if v127.State ~= "None" then v127:SetState("None"); end;
	end;
end;

v43.UpdateAnimalPodiums = function(v139)
	resolveLivePlot(v139)

	if not v139.PlotModel or not v139.PlotModel:IsDescendantOf(workspace) then
		dbg("UAP-ABORT: PlotModel missing/unparented UID=%s", tostring(v139.UID))
		return
	end
	if not v139.PlotModel:GetAttribute("Loaded") then
		dbg("UAP-ABORT: PlotModel.Loaded=false UID=%s", tostring(v139.UID))
		return
	end

	local nuked = v139.PlotModel:GetAttribute("Nuked");
	local rawList = v139.Channel:Get("AnimalList") or {}
	local v140 = normalizeAnimalList(rawList);

	local tierValue = v139.PlotModel:GetAttribute("Tier")
	if not tierValue then
		dbg("UAP-ABORT: no Tier attribute UID=%s", tostring(v139.UID))
		return
	end
	local tierData = v24[tierValue]
	if not tierData then
		dbg("UAP-ABORT: no tierData[%s] UID=%s", tostring(tierValue), tostring(v139.UID))
		return
	end
	local maxAnimals = tierData.MaxAnimals

	local animalPodiumsFolder = v139.PlotModel:FindFirstChild("AnimalPodiums")
	if not animalPodiumsFolder then
		animalPodiumsFolder = v139.PlotModel:WaitForChild("AnimalPodiums", 10)
	end
	if not animalPodiumsFolder then
		dbg("UAP-ABORT: no AnimalPodiums folder UID=%s", tostring(v139.UID))
		return
	end

	if DEBUG_PLOTCLIENT then
		local rawKeys = {}
		for k, _ in pairs(rawList) do
			table.insert(rawKeys, tostring(k) .. "(" .. type(k) .. ")")
		end
		local normKeys = {}
		for k, _ in pairs(v140) do
			table.insert(normKeys, tostring(k) .. "(" .. type(k) .. ")")
		end
		dbg("UAP-ENTRY: UID=%s Tier=%s max=%d nuked=%s | rawKeys={%s} | normKeys={%s} | folderChildren=%d",
			tostring(v139.UID), tostring(tierValue), maxAnimals, tostring(nuked),
			table.concat(rawKeys, ","),
			table.concat(normKeys, ","),
			#animalPodiumsFolder:GetChildren())
	end

	for v141 = 1, maxAnimals do
		if nuked then
			v139:HideClaim(v141);
			v139:ClearIndex(v141);
			local pEntry = v139.AnimalsPrompts[v141];
			if pEntry then
				for _, p in pEntry.Prompts do p:Destroy(); end;
				v139.AnimalsPrompts[v141] = nil;
			end
			if DEBUG_PLOTCLIENT then
				dbg("UAP-slot%d: nuked → cleared", v141)
			end
		else
			local l_FirstChild_2 = animalPodiumsFolder:FindFirstChild(tostring(v141))
			local podiumWasMissing = (l_FirstChild_2 == nil)
			if not l_FirstChild_2 and type(v140[v141]) == "table" then
				l_FirstChild_2 = animalPodiumsFolder:WaitForChild(tostring(v141), 5)
			end

			local slotData = v140[v141]
			local deferDisplay = l_FirstChild_2 and l_FirstChild_2:GetAttribute("DeferDisplay")
			local hasAnimal = type(slotData) == "table"
				and l_FirstChild_2
				and not deferDisplay

			if DEBUG_PLOTCLIENT then
				local dataDesc
				if type(slotData) == "table" then
					dataDesc = "table{Index=" .. tostring(slotData.Index)
						.. ",Mut=" .. tostring(slotData.Mutation)
						.. ",LastCollect=" .. tostring(slotData.LastCollect) .. "}"
				else
					dataDesc = type(slotData) .. "(" .. tostring(slotData) .. ")"
				end
				local existingModel = v139.AnimalsModels[v141]
				local existingDesc
				if existingModel then
					existingDesc = "Model{Parent=" .. tostring(existingModel.Parent and existingModel.Parent.Name)
						.. ",Anchored=" .. tostring(existingModel.PrimaryPart and existingModel.PrimaryPart.Anchored) .. "}"
				else
					existingDesc = "nil"
				end
				dbg("UAP-slot%d: data=%s podium=%s(wasMissing=%s) defer=%s existing=%s → %s",
					v141,
					dataDesc,
					tostring(l_FirstChild_2 ~= nil),
					tostring(podiumWasMissing),
					tostring(deferDisplay),
					existingDesc,
					hasAnimal and "UPDATE_MODEL" or "CLEAR")
			end

			if hasAnimal then
				v139:UpdateModel(v141);
				local freshList = normalizeAnimalList(v139.Channel:Get("AnimalList") or {})
				if type(freshList[v141]) == "table" and freshList[v141].LastCollect then
					v139:UpdateClaim(v141);
				end
			else
				v139:ClearIndex(v141);
				v139:HideClaim(v141);
			end;
			v139:UpdatePrompt(v141);
		end
	end;
end;
local function v152(v143)
	local v144 = false;
	local _ = v143:GetOwner();
	local v146 = v143.PlotModel:WaitForChild("Purchases", 5);
	if not v146 then return; end;
	if v143.Channel:Get("BlockEndTime") ~= nil then
		local v147 = math.clamp(math.round(v143.Channel:Get("BlockEndTime") - workspace:GetServerTimeNow()), 0, 1e999);
		for _, v149 in v146:GetChildren() do
			if v149:FindFirstChild("Main") then
				v149.Main.BillboardGui.RemainingTime.Text = v12:C(v147);
			end
		end;
		v144 = true;
	end;
	for _, v151 in v146:GetChildren() do
		if v151:FindFirstChild("Main") then
			v151.Main.BillboardGui.LockStudio.Visible = not v144;
			v151.Main.BillboardGui.RemainingTime.Visible = v144;
			v151.Main.BillboardGui.Locked.Visible = v144;
		end
	end;
end;

local function v162(v153)
	if v153.Channel:Get("BlockEndTime") == nil then
		local v154 = false;
		local _ = v153:GetOwner();
		local v156 = v153.PlotModel:WaitForChild("Purchases", 5);
		if not v156 then return; end;
		if v153.Channel:Get("BlockedDelayTime") ~= nil then
			local v157 = math.clamp(math.round(v153.Channel:Get("BlockedDelayTime") - workspace:GetServerTimeNow()), 0, 1e999);
			for _, v159 in v156:GetChildren() do
				if v159:FindFirstChild("Main") then
					v159.Main.BillboardGui.RemainingTime.Text = v12:C(v157);
				end
			end;
			v154 = true;
		end;
		for _, v161 in v156:GetChildren() do
			if v161:FindFirstChild("Main") then
				v161.Main.BillboardGui.LockStudio.Visible = not v154;
				v161.Main.BillboardGui.RemainingTime.Visible = v154;
				v161.Main.BillboardGui.Delay.Visible = v154;
			end
		end;
	end;
end;

local function v169(v163)
	if v163:GetOwner() == l_LocalPlayer_0 then return; end;
	if v163.PlotModel:FindFirstChild("Unlock") then
		for _, v165 in v163.PlotModel.Unlock:GetChildren() do
			local l_Attribute_0 = v165.UnlockBase:GetAttribute("Floor");
			if l_Attribute_0 then
				local v167 = "BlockEndTimeFirstFloor";
				if l_Attribute_0 == 2 then v167 = "BlockEndTimeSecondFloor";
				elseif l_Attribute_0 == 3 then v167 = "BlockEndTimeThirdFloor"; end;
				v165.UnlockBase.Enabled = v163.Channel:Get(v167) ~= nil;
			end;
		end;
	end;
end;

local function v182(v170)
	if not v170.Channel or not v170.Channel.Get then return; end;
	local v171 = v170:GetOwner() == l_LocalPlayer_0;
	local l_v170_Owner_0 = v170:GetOwner();
	local l_v29_InGameFriends_0 = v29:GetInGameFriends(l_LocalPlayer_0);
	local v174 = v170.Channel:Get("FriendsAllowed") == true;
	local v175 = v170.PlotModel:WaitForChild("LaserHitbox", 5);
	if not v175 then return; end;
	for _, v177 in v175:GetChildren() do
		local l_v177_Attribute_0 = v177:GetAttribute("Floor");
		if l_v177_Attribute_0 then
			local v179 = "BlockEndTimeFirstFloor";
			if l_v177_Attribute_0 == 2 then v179 = "BlockEndTimeSecondFloor";
			elseif l_v177_Attribute_0 == 3 then v179 = "BlockEndTimeThirdFloor"; end;
			local v180 = v170.Channel:Get(v179) ~= nil;
			local _ = true;
			v177.CanCollide = not v171 and not l_LocalPlayer_0:GetAttribute("IgnoreLasers") and
				if v180 then not table.find(l_v29_InGameFriends_0, l_v170_Owner_0) or not v174 or false else false;
		end;
	end;
end;

v43.GetOwner = function(v183)
	return v183.Channel:Get("Owner");
end;
v43.GetSpawn = function(v184)
	return v184.PlotModel.Spawn;
end;
v43.GetUID = function(v185)
	return v185.UID;
end;

v43.new = function(v186_initial)
	local v187 = setmetatable({}, v43);
	v187.UID = v186_initial.Name;
	v187.PlotModel = v186_initial;
	v187.Collector = v6.new();
	v187.OwnerCollector = v6.new();
	v187.Collector:Add(v187.OwnerCollector, "Destroy");
	v187.AnimalsModels = {};
	v187.AnimalsIndex = {};
	v187.AnimalsBuildGen = {};
	v187.AnimalsPrompts = {};
	v187.ModelsCollector = {};
	v187.CollectGuis = {};
	v187.Channel = v5:Wait(v187.UID);

	local v226_generation = 0;

	local function v194()
		for v188, v189 in v187.AnimalsPrompts do
			for _, v191 in v189.Prompts do v191:Destroy(); end;
			v187.AnimalsPrompts[v188] = nil;
		end;
		for v192, v193 in v187.AnimalsModels do
			v193:Destroy();
			v187.AnimalsModels[v192] = nil;
		end;
	end;

	local function flushAllClientState()
		for idx, model in pairs(v187.AnimalsModels) do
			model:Destroy()
			v187.AnimalsModels[idx] = nil
		end
		for idx in pairs(v187.AnimalsIndex) do
			v187.AnimalsIndex[idx] = nil
		end
		for idx, trove in pairs(v187.ModelsCollector) do
			trove:Clean()
			v187.ModelsCollector[idx] = nil
		end
		for podiumModel, guiEntry in pairs(v187.CollectGuis) do
			if guiEntry then
				if guiEntry.conn then
					pcall(function() guiEntry.conn:Disconnect() end)
					guiEntry.conn = nil
				end
				if guiEntry.cleanup then
					pcall(guiEntry.cleanup)
					guiEntry.cleanup = nil
				end
				if guiEntry.gui then
					pcall(function() guiEntry.gui:Destroy() end)
				end
			end
			v187.CollectGuis[podiumModel] = nil
		end
		v194()
	end

	local function v226()
		v226_generation = v226_generation + 1;
		local myGen = v226_generation;

		dbg("v226 ENTRY: UID=%s gen=%d PlotModel.Name=%s PlotModel.Parent=%s",
			tostring(v187.UID), myGen,
			tostring(v187.PlotModel and v187.PlotModel.Name),
			tostring(v187.PlotModel and v187.PlotModel.Parent))

		v187.OwnerCollector:Clean();

		flushAllClientState()

		local function isStale()
			return myGen ~= v226_generation
		end

		local currentPlotModel = resolveLivePlot(v187) or v187.PlotModel

		if not currentPlotModel or not currentPlotModel.Parent then
			warn("[PlotClient] v226: PlotModel is nil or unparented, aborting setup for UID: " .. v187.UID)
			return
		end

		local tierValue = currentPlotModel:GetAttribute("Tier")
		if not tierValue then
			local waited = 0
			repeat
				task.wait(0.1)
				waited += 0.1
				tierValue = currentPlotModel:GetAttribute("Tier")
			until tierValue ~= nil or waited >= 5
		end
		if isStale() then return end

		if not tierValue then
			warn("[PlotClient] v226: Tier attribute missing on plot: " .. currentPlotModel.Name)
			return
		end

		local maxAnimals = v24[tierValue] and v24[tierValue].MaxAnimals
		if not maxAnimals then
			warn("[PlotClient] v226: No BasesData entry for Tier: " .. tostring(tierValue))
			return
		end

		local podiums = currentPlotModel:FindFirstChild("AnimalPodiums")
		if not podiums then
			podiums = currentPlotModel:WaitForChild("AnimalPodiums", 15)
		end
		if isStale() then return end
		if not podiums then
			warn("[PlotClient] v226: AnimalPodiums not found for " .. currentPlotModel.Name)
			return
		end

		dbg("v226: scanning podiums for UID=%s, maxAnimals=%d, podiumsFolder children=%d",
			tostring(v187.UID), maxAnimals, #podiums:GetChildren())

		for i = 1, maxAnimals do
			if isStale() then return end
			local podium = podiums:FindFirstChild(tostring(i))
			if not podium then
				dbg("v226: podium slot=%d not present, WaitForChild...", i)
				podium = podiums:WaitForChild(tostring(i), 10)
			end
			if isStale() then return end
			if podium then
				if not podium:FindFirstChild("Claim") then
					podium:WaitForChild("Claim", 10)
				end
				if not podium:FindFirstChild("Base") then
					podium:WaitForChild("Base", 10)
				end
				if isStale() then return end
				local claim = podium:FindFirstChild("Claim")
				if claim and not claim:FindFirstChild("Hitbox") then
					claim:WaitForChild("Hitbox", 10)
				end
				dbg("v226: podium slot=%d ready (Claim=%s Base=%s)",
					i, tostring(podium:FindFirstChild("Claim") ~= nil),
					tostring(podium:FindFirstChild("Base") ~= nil))
			else
				dbg("v226: podium slot=%d NEVER replicated within 10s — high-index slot will fail to render!", i)
			end
			if isStale() then return end
		end

		for v195 = 1, maxAnimals do
			if v187:GetOwner() == l_LocalPlayer_0 then
				local podiumFolder = podiums:FindFirstChild(tostring(v195))
				local v197 = podiumFolder
					and podiumFolder:FindFirstChild("Claim")
					and podiumFolder.Claim:FindFirstChild("Hitbox")
				if v197 then
					v187.OwnerCollector:Add(v197.Touched:Connect(function(hit)
						if hit.Name == "HumanoidRootPart" then
							local player = l_Players_0:GetPlayerFromCharacter(hit.Parent)
							if player and player == v187:GetOwner() then
								v38:FireServer(v195)
							end
						end
					end))
				end
			end
		end

		local v200 = {};
		for _, v202 in currentPlotModel:GetChildren() do
			if v202.Name == "DeliveryHitbox" then table.insert(v200, v202); end;
		end;
		if IsTsunamiServer() then
			for _, v202 in currentPlotModel:GetChildren() do
				if v202.Name == "StealHitbox" then table.insert(v200, v202); end;
			end;
		end;

		local v203 = OverlapParams.new();
		v203.FilterDescendantsInstances = v200;
		v203.FilterType = Enum.RaycastFilterType.Include;
		v203.MaxParts = 1;

		if v187:GetOwner() == l_LocalPlayer_0 then
			local v204 = 0;
			do
				local l_v204_0 = v204;
				v187.OwnerCollector:Add(l_RunService_0.PostSimulation:Connect(function(v206)
					l_v204_0 = l_v204_0 + v206;
					if l_v204_0 < 0.05 then return; end;
					debug.profilebegin("PlotClient:Hitboxes");
					l_v204_0 = 0;
					if not l_LocalPlayer_0:GetAttribute("Stealing") then
						debug.profileend();
						return;
					end;
					local v207 = normalizeAnimalList(v187.Channel:Get("AnimalList") or {});
					for _, v209 in v207 do
						if type(v209) ~= "table" then continue end
						if v209.Steal == l_LocalPlayer_0.UserId then
							debug.profileend();
							return;
						end;
					end;
					local l_Character_0 = l_LocalPlayer_0.Character;
					if not l_Character_0 then debug.profileend(); return; end;
					local l_Position_0 = l_Character_0:GetPivot().Position;
					if #workspace:GetPartBoundsInBox(CFrame.new(l_Position_0), Vector3.new(4, 4, 2, 0), v203) <= 0 then
						debug.profileend();
						return;
					end;
					v40:FireServer("7799aa8a-03f9-4df1-ab0f-b6df84f6b36c");
					debug.profileend();
				end));
			end;
		end;

		v187.OneSecondTimer = v7.new(1);
		v187.OwnerCollector:Add(v187.OneSecondTimer, "Destroy");
		v187.OwnerCollector:Add(v187.OneSecondTimer.Tick:Connect(function()
			v152(v187);
			v169(v187);
			v187:UpdateAnimalPodiums();
			v162(v187);
		end));
		v187.OneSecondTimer:StartNow();

		local function onFloorBlockChange()
			v152(v187); v169(v187); v162(v187); v182(v187);
		end
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTime", onFloorBlockChange, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeFirstFloor", onFloorBlockChange, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeSecondFloor", onFloorBlockChange, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeThirdFloor", onFloorBlockChange, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockedDelayTime", onFloorBlockChange, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("AnimalList", function(newVal)
			if DEBUG_PLOTCLIENT then
				local count = 0
				local hasN, hasS
				if type(newVal) == "table" then
					for k, _ in pairs(newVal) do
						count = count + 1
						if type(k) == "number" then hasN = true else hasS = true end
					end
				end
				dbg("AL-LISTENER(inner) FIRED UID=%s type=%s count=%s numKeys=%s strKeys=%s",
					tostring(v187.UID),
					type(newVal),
					tostring(count),
					tostring(hasN),
					tostring(hasS))
			end
			v187:UpdateAnimalPodiums();
		end, true));

		v187.OwnerCollector:Add(v187.Channel:OnChanged("AnimalListVersion", function(newVer)
			if DEBUG_PLOTCLIENT then
				dbg("ALV-LISTENER(inner) FIRED UID=%s version=%s",
					tostring(v187.UID), tostring(newVer))
			end
			v187:UpdateAnimalPodiums();
		end));

		v187.OwnerCollector:Add(currentPlotModel:GetAttributeChangedSignal("Nuked"):Connect(function()
			if currentPlotModel:GetAttribute("Nuked") then
				for _, v235 in currentPlotModel:GetChildren() do
					if v235:IsA("Model") and v235.PrimaryPart then
						v235.PrimaryPart.Anchored = false;
						v235.PrimaryPart.CanCollide = true;
					end;
				end;
			end;
		end));

		local l_v187_Owner_0 = v187:GetOwner();
		if typeof(l_v187_Owner_0) == "Instance" and l_v187_Owner_0:IsA("Player") then
			v187.OwnerCollector:Add(l_v187_Owner_0:GetAttributeChangedSignal("Stealing"):Connect(function(_)
				v187:UpdateAnimalPodiums();
			end));
			v187.OwnerCollector:Add(l_v187_Owner_0:GetAttributeChangedSignal("IsTrading"):Connect(function()
				v187:UpdateAnimalPodiums();
			end));
		end;

		local l_UnlockFolder_0 = currentPlotModel:FindFirstChild("Unlock")
		if not l_UnlockFolder_0 then
			l_UnlockFolder_0 = currentPlotModel:WaitForChild("Unlock", 10)
		end
		if isStale() then return end

		if l_UnlockFolder_0 then
			for _, v216 in l_UnlockFolder_0:GetChildren() do
				if not v216:FindFirstChild("UnlockBase") then continue end
				v187.OwnerCollector:Add(v216.UnlockBase.Triggered:Connect(function(v217)
					if v217 and v217:IsA("Player") then
						if v187:GetOwner() == v217 then return; end;
						local l_ProductId_0 = v25[v216.UnlockBase:GetAttribute("Floor")].ProductId;
						if currentPlotModel:GetAttribute("IsBotBase") then
							if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil
								or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil
								or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil
							then
								local l_Floor_0 = v216.UnlockBase:GetAttribute("Floor");
								local l_PlotName_0 = currentPlotModel.Name;
								task.spawn(function()
									if FakePurchase:Create(l_ProductId_0, false, true, false) then
										botUnlockRemote:FireServer(l_PlotName_0, l_Floor_0);
									end;
								end);
							end;
							return;
						end;
						local l_Owner_0 = v187:GetOwner();
						local l_UserId_0 = (typeof(l_Owner_0) == "Instance" and l_Owner_0:IsA("Player")) and l_Owner_0.UserId or v217.UserId;
						if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil
							or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil
							or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil
						then
							v33:FireServer(l_ProductId_0, l_UserId_0);
						end;
					end;
				end));
			end;
			v187.OwnerCollector:Add(l_UnlockFolder_0.ChildAdded:Connect(function(v220)
				if not v220:FindFirstChild("UnlockBase") then return end
				v187.OwnerCollector:Add(v220.UnlockBase.Triggered:Connect(function(v221)
					if v221 and v221:IsA("Player") then
						if v187:GetOwner() == v221 then return; end;
						local l_ProductId_1 = v25[v220.UnlockBase:GetAttribute("Floor")].ProductId;
						if currentPlotModel:GetAttribute("IsBotBase") then
							if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil
								or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil
								or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil
							then
								local l_Floor_1 = v220.UnlockBase:GetAttribute("Floor");
								local l_PlotName_1 = currentPlotModel.Name;
								task.spawn(function()
									if FakePurchase:Create(l_ProductId_1, false, true, false) then
										botUnlockRemote:FireServer(l_PlotName_1, l_Floor_1);
									end;
								end);
							end;
							return;
						end;
						local l_Owner_1 = v187:GetOwner();
						local l_UserId_1 = (typeof(l_Owner_1) == "Instance" and l_Owner_1:IsA("Player")) and l_Owner_1.UserId or v221.UserId;
						if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil
							or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil
							or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil
						then
							v33:FireServer(l_ProductId_1, l_UserId_1);
						end;
					end;
				end));
				v182(v187);
			end));
		else
			warn("⚠️ Unlock folder not found for plot " .. currentPlotModel.Name);
		end;

		local friendPanel = currentPlotModel:FindFirstChild("FriendPanel")
		if friendPanel then
			local Main = friendPanel:WaitForChild("Main",10)
			if (currentPlotModel:GetAttribute("Tier") == 0 and v187:GetOwner()) or IsDuelsServer() then
				friendPanel:PivotTo(CFrame.new(Vector3.new(0, 1000000000, 0)));
			end;

			if Main then
				local l_ProximityPrompt_0 = Main.ProximityPrompt;
				v187.OwnerCollector:Add(v187.Channel:OnChanged("FriendsAllowed", function(v225)
					l_ProximityPrompt_0.ObjectText = v225 == true and "Disallow Friends" or "Allow Friends";
					local surfaceGui = Main:FindFirstChild("SurfaceGui");
					if surfaceGui and surfaceGui:FindFirstChild("ImageLabel") then
						surfaceGui.ImageLabel.Image = v225 == true
							and "rbxassetid://110507824065923"
							or "rbxassetid://110783679426495";
					end
					v182(v187);
				end, true));
			end
		end

		v187.OwnerCollector:Add(v29.OnFriendsUpdate:Connect(function()
			v182(v187);
		end));
		v187.OwnerCollector:Add(l_LocalPlayer_0:GetAttributeChangedSignal("IgnoreLasers"):Connect(function()
			v182(v187);
		end));

		local friendPanelPrompt = currentPlotModel:FindFirstChild("FriendPanel")
			and currentPlotModel.FriendPanel:FindFirstChild("Main") 
			and currentPlotModel.FriendPanel.Main:FindFirstChild("ProximityPrompt")
		if friendPanelPrompt then
			v187.OwnerCollector:Add(friendPanelPrompt.Triggered:Connect(function()
				if v187:GetOwner() ~= l_LocalPlayer_0 then return; end;
				v41:FireServer();
			end));
		end

		local plotSign = currentPlotModel:FindFirstChild("PlotSign")
		if plotSign then
			plotSign.YourBase.Enabled = v187:GetOwner() == l_LocalPlayer_0;
		end

		if not isStale() then
			task.spawn(function()
				if not isStale() then
					v187:UpdateAnimalPodiums()
				end
			end)
		end
	end;

	v187.Collector:Add(v187.Channel:OnChanged("Owner", v226, true));

	v187.Collector:Add(v187.Channel:OnChanged("AnimalList", function(newList)
		if DEBUG_PLOTCLIENT then
			local count = 0
			local hasN, hasS
			if type(newList) == "table" then
				for k, _ in pairs(newList) do
					count = count + 1
					if type(k) == "number" then hasN = true else hasS = true end
				end
			end
			dbg("AL-LISTENER(outer) FIRED UID=%s type=%s count=%s numKeys=%s strKeys=%s plotInWS=%s",
				tostring(v187.UID),
				type(newList),
				tostring(count),
				tostring(hasN),
				tostring(hasS),
				tostring(v187.PlotModel and v187.PlotModel:IsDescendantOf(workspace)))
		end
		if not v187.PlotModel or not v187.PlotModel:IsDescendantOf(workspace) then
			local plotsFolder = workspace:FindFirstChild("Plots")
			if plotsFolder then
				local replacement = plotsFolder:FindFirstChild(v187.UID)
				if replacement and replacement ~= v187.PlotModel then
					v187.PlotModel = replacement
					task.spawn(v226)
					return
				end
			end
		end
		v187:UpdateAnimalPodiums()
	end));

	v187.Collector:Add(v187.Channel:OnChanged("AnimalListVersion", function(newVer)
		if DEBUG_PLOTCLIENT then
			dbg("ALV-LISTENER(outer) FIRED UID=%s version=%s plotInWS=%s",
				tostring(v187.UID),
				tostring(newVer),
				tostring(v187.PlotModel and v187.PlotModel:IsDescendantOf(workspace)))
		end
		if not v187.PlotModel or not v187.PlotModel:IsDescendantOf(workspace) then
			local plotsFolder = workspace:FindFirstChild("Plots")
			if plotsFolder then
				local replacement = plotsFolder:FindFirstChild(v187.UID)
				if replacement and replacement ~= v187.PlotModel then
					v187.PlotModel = replacement
					task.spawn(v226)
					return
				end
			end
		end
		v187:UpdateAnimalPodiums()
	end));

	local plotsFolder = workspace:WaitForChild("Plots")
	v187.Collector:Add(plotsFolder.ChildAdded:Connect(function(newChild)
		if newChild.Name == v187.UID and newChild ~= v187.PlotModel then
			dbg("ChildAdded: replacement detected for UID=%s. old=(name=%s, parent=%s) new=(name=%s, parent=%s)",
				tostring(v187.UID),
				tostring(v187.PlotModel and v187.PlotModel.Name),
				tostring(v187.PlotModel and v187.PlotModel.Parent),
				tostring(newChild.Name),
				tostring(newChild.Parent))

			flushAllClientState()
			v187.PlotModel = newChild
			dbg("ChildAdded: PlotModel reference updated for UID=%s, Loaded=%s",
				tostring(v187.UID), tostring(newChild:GetAttribute("Loaded")))

			if not newChild:GetAttribute("Loaded") then
				local loadConn
				loadConn = newChild:GetAttributeChangedSignal("Loaded"):Connect(function()
					if newChild:GetAttribute("Loaded") then
						loadConn:Disconnect()
						dbg("ChildAdded: Loaded fired for UID=%s, spawning v226", tostring(v187.UID))
						task.spawn(v226)
					end
				end)
				v187.Collector:Add(loadConn)
			else
				dbg("ChildAdded: already Loaded for UID=%s, spawning v226", tostring(v187.UID))
				task.spawn(v226)
			end
		end
	end));

	return v187;
end;

v43.Destroy = function(v227)
	for v228, v229 in v227.AnimalsPrompts do
		for _, v231 in v229.Prompts do v231:Destroy(); end;
		v227.AnimalsPrompts[v228] = nil;
	end;
	for v232, v233 in v227.AnimalsModels do
		v233:Destroy();
		v227.AnimalsModels[v232] = nil;
	end;
	v227.Collector:Destroy();
end;

return v43;