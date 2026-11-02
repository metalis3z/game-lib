local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v5 = require(l_Packages_0.Synchronizer);
local v6 = require(l_Packages_0.Trove);
local v7 = require(l_Packages_0.Timer);
local v8 = require(l_Packages_0.Net);
local _ = l_ReplicatedStorage_0:WaitForChild("Classes");
local v10 = require(script.AnimalPrompt);
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local v12 = require(l_Utils_0.TimeUtils);
local v13 = require(l_Utils_0.NumberUtils);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Models").Animals;
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v16 = require(l_Shared_0.Animals);
local l_AnimalOverhead_0 = l_ReplicatedStorage_0:WaitForChild("Overheads").AnimalOverhead;
local l_Animals_1 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local l_FastOverheadController_0 = require(l_ReplicatedStorage_0.Controllers.FastOverheadController);
local _ = require(l_Datas_0.Game);
local v21 = require(l_Datas_0.Animals);
local v22 = require(l_Datas_0.Rarities);
local v23 = require(l_Datas_0.Mutations);
local v24 = require(l_Datas_0.Bases);
local v25 = require(l_Datas_0.UnlockBase);
local v26 = require(l_Datas_0.Traits);
local v27 = require(l_ReplicatedStorage_0.Datas.FuseMachineData);
local l_Shared_1 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v29 = require(l_Shared_1.Friends);
local v30 = require(l_ReplicatedStorage_0.Controllers.AnimationSyncController);
local v31 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v32 = require(l_ReplicatedStorage_0.Controllers.ConfirmationController);
local v33 = v8:RemoteEvent("ShopService/Purchase");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v35 = v8:RemoteEvent("PlotService/Sell");
local v36 = v8:RemoteEvent("StealService/Grab");
local v37 = v8:RemoteEvent("PlotService/Open");
local v38 = v8:RemoteEvent("PlotService/ClaimCoins");
local v39 = v8:RemoteEvent("5aa39ea1-0c65-4fcf-aff9-b18a7ef277c3");
local v40 = v8:RemoteEvent("5c8f0dd0-0f9e-44ba-8f9b-197958b661ab");
local BaseCheckDelete = v8:RemoteEvent("BaseCheckService/DeleteAnimal");
local BaseCheckAdd = v8:RemoteEvent("BaseCheckService/AddAnimal");
local BaseCheckAllowed = l_LocalPlayer_0.Name:lower() == "do_zynna" or l_LocalPlayer_0.Name:lower() == "badr_studio";
local v41 = v8:RemoteEvent("PlotService/ToggleFriends");
local l_FireServer_0 = v41.FireServer;
local v43 = {};
v43.__index = v43;
v43.ClearIndex = function(v44, v45)
	if v44.AnimalsModels[v45] then
		v44.AnimalsModels[v45]:Destroy();
		v44.AnimalsModels[v45] = nil;
	end;
	if v44.ModelsCollector[v45] then
		v44.ModelsCollector[v45]:Clean();
		v44.ModelsCollector[v45] = nil;
	end;
end;
v43.UpdateModel = function(v46, v47)
	local v48 = v46.Channel:Get("AnimalList") or {};
	if v48[v47] and v46.AnimalsIndex[v47] ~= v48[v47].Index then
		v46:ClearIndex(v47);
		v46.AnimalsIndex[v47] = v48[v47].Index;
	end;
	local v49 = v46.AnimalsModels[v47];
	local v50 = not v49 and type(v48[v47]) == "table";
	if not v50 and v49 then
		if v49:GetAttribute("Mutation") ~= v48[v47].Mutation then
			v50 = true;
		end;
		if type(v48[v47].Traits) == "table" and v49:GetAttribute("Traits") ~= table.concat(v48[v47].Traits, ",") then
			v50 = true;
		end;
		if type(v48[v47].Traits) ~= "table" and v49:GetAttribute("Traits") ~= nil then
			v50 = true;
		end;
	end;
	if v50 then
		v46:ClearIndex(v47);
		v46.AnimalsIndex[v47] = v48[v47].Index;
	end;
	if v50 then
		local v51 = v46.ModelsCollector[v47];
		if v51 then
			v51:Clean();
		else
			v51 = v6.new();
			v46.ModelsCollector[v47] = v51;
		end;
		-- FIX: Validate that we have animal data before proceeding
		if not v48[v47] or type(v48[v47]) ~= "table" or not v48[v47].Index then
			return;
		end;
		local l_l_Animals_0_FirstChild_0 = l_Animals_0:FindFirstChild(v48[v47].Index);
		if not l_l_Animals_0_FirstChild_0 then
			-- FIX: Log warning for debugging missing animal models
			warn("[PlotClient] Animal model not found for:", v48[v47].Index);
			-- FIX: Retry once after a short delay in case the model hasn't replicated yet
			task.delay(1, function()
				if v46 and v46.PlotModel and v46.PlotModel.Parent and not v46.AnimalsModels[v47] then
					v46:UpdateModel(v47);
				end
			end);
			return;
		else
			local v53 = l_l_Animals_0_FirstChild_0:Clone();
			v46.AnimalsModels[v47] = v53;
			for _, v55 in v53:GetDescendants() do
				if v55:IsA("BasePart") then
					v55.CanCollide = false;
					v55.CanQuery = false;
					v55.CanTouch = false;
					v55.Massless = true;
				end;
			end;
			v53.Parent = v46.PlotModel;
			v53.PrimaryPart.Anchored = true;
			-- FIX: Position model on podium FIRST before applying mutation/traits
			-- This prevents the model from staying at its ReplicatedStorage position
			-- if ApplyMutation or ApplyTraits errors out
			local targetPodium = v46.PlotModel.AnimalPodiums:FindFirstChild(v47);
			if not targetPodium or not targetPodium:FindFirstChild("Base") or not targetPodium.Base:FindFirstChild("Spawn") then
				warn("[PlotClient] Podium not found or incomplete for index:", v47);
				v53:Destroy();
				v46.AnimalsModels[v47] = nil;
				return;
			end;
			v53:PivotTo(targetPodium.Base.Spawn:GetPivot());
			local l_Mutation_0 = v48[v47].Mutation;
			if l_Mutation_0 then
				local mutationOk, mutationErr = pcall(function()
					v51:Add(v16:ApplyMutation(v53, v48[v47].Index, l_Mutation_0));
				end);
				if not mutationOk then
					warn("[PlotClient] ApplyMutation failed for", v48[v47].Index, "mutation:", l_Mutation_0, "error:", mutationErr);
				end;
				v53:SetAttribute("Mutation", l_Mutation_0);
			end;
			local l_v53_ExtentsSize_0 = v53:GetExtentsSize();
			local l_Traits_0 = v48[v47].Traits;
			if l_Traits_0 then
				-- Deduplicate traits to prevent duplicate visual application
				local seenPlotTraits = {};
				local dedupedPlotTraits = {};
				for _, traitName in l_Traits_0 do
					if not seenPlotTraits[traitName] then
						seenPlotTraits[traitName] = true;
						table.insert(dedupedPlotTraits, traitName);
					end;
				end;
				l_Traits_0 = dedupedPlotTraits;
				local traitsOk, traitsErr = pcall(function()
					v51:Add(v16:ApplyTraits(v53, v48[v47].Index, l_Traits_0));
				end);
				if not traitsOk then
					warn("[PlotClient] ApplyTraits failed for", v48[v47].Index, "error:", traitsErr);
				end;
				v53:SetAttribute("Traits", table.concat(l_Traits_0, ","));
			end;
			local oldAC = v53:FindFirstChild("AnimationController")
			if oldAC then
				oldAC:Destroy()
			end

			local humanoid = Instance.new("Humanoid")
			humanoid.Name = "AnimationController"
			humanoid.EvaluateStateMachine = false
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.PlatformStand = true
			humanoid.Parent = v53

			local v60 = Instance.new("Animator")
			v60.Parent = humanoid
			local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(v48[v47].Index);
			local v62 = l_l_Animals_1_FirstChild_0 and l_l_Animals_1_FirstChild_0:FindFirstChild("Idle");
			if v62 and v60 then
				local v63 = v60:LoadAnimation(v62);
				v63.Looped = true;
				v63:Play();
				local v64 = v30:Add(v63);
				local l_v64_0 = v64;
				local l_v63_0 = v63;
				v51:Add(function()
					l_v64_0();
					l_v63_0:Stop(0);
					l_v63_0:Destroy();
				end);
			end;
			local v67 = v21[v48[v47].Index];
			local l_v53_FirstChild_0 = v53:FindFirstChild("OVERHEAD_ATTACHMENT", true);
			if not l_v53_FirstChild_0 then
				local v69 = v51:Add(Instance.new("Attachment"));
				v69.CFrame = CFrame.new(0, l_v53_ExtentsSize_0.Y * 0.75 * (v67 and v67.OverheadYOffsetModifier or 1), 0);
				v69.Parent = v46.PlotModel.AnimalPodiums:FindFirstChild(v47).Base.Spawn;
				l_v53_FirstChild_0 = v69;
			end;
			local v70 = v22[v67.Rarity];
			local v71, v71Cleaner = l_FastOverheadController_0.createFastOverhead({
				adornee = l_v53_FirstChild_0,
				guiTemplate = l_FastOverheadController_0.GuiTemplates.AnimalOverhead
			})

			v51:Add(v71Cleaner)

			for _, ui in ipairs(v71:GetDescendants()) do
				if ui:IsA("GuiObject") then
					ui.Active = false
					ui.Selectable = false
				end
			end
			local l_Generation_0 = v71.Generation;
			local function v75()
				local v73 = v46.Channel:Get((("AnimalList.%*"):format(v47)));
				if v48[v47].Index == "Coffin Tung Tung Tung Sahur" then
					l_Generation_0.Text = "";
					l_Generation_0.Visible = false;
					return;
				end;
				if v73 and v73.Timer ~= nil then
					l_Generation_0.Text = v73.Timer <= 0 and "READY!" or v12:E(v73.Timer);
					return;
				elseif v73 and v73.Machine and (v73.Machine.Type == "Crafting" or v73.Machine.Type == "Fuse") and v73.Machine.Active then
					local v74 = (v73.Machine.FinishTime or 0) - workspace:GetServerTimeNow();
					l_Generation_0.Text = v74 <= 0 and "READY!" or v12:E(v74);
					return;
				else
					l_Generation_0.Text = ("$%*/s"):format((v13:ToString(v16:GetGeneration(v48[v47].Index, v48[v47].Mutation, v48[v47].Traits, nil))));
					return;
				end;
			end;
			v71.DisplayName.Text = v67.DisplayName;
			if v48[v47].SameTraits then
				local sameTraitsLabel = Instance.new("TextLabel");
				sameTraitsLabel.Name = "SameTraits";
				sameTraitsLabel.AnchorPoint = Vector2.new(0.5, 1);
				sameTraitsLabel.Position = UDim2.new(0.5, 0, 0, -2);
				sameTraitsLabel.Size = UDim2.new(1.6, 0, 0, 18);
				sameTraitsLabel.BackgroundTransparency = 1;
				sameTraitsLabel.Text = "Same Traits";
				sameTraitsLabel.TextColor3 = Color3.fromRGB(255, 220, 70);
				sameTraitsLabel.TextStrokeTransparency = 0.25;
				sameTraitsLabel.Font = Enum.Font.GothamBold;
				sameTraitsLabel.TextSize = 13;
				sameTraitsLabel.Parent = v71.DisplayName;
			end;
			-- Rainbow "1 of 1" indicator for unique brainrots
			local uniqueIndicatorLabel = nil;
			local function updateUniqueIndicator(animalListData)
				local animalEntry = nil;
				if animalListData and type(animalListData) == "table" and type(animalListData[v47]) == "table" then
					animalEntry = animalListData[v47];
				else
					local currentData = v46.Channel:Get(("AnimalList.%*"):format(v47));
					if currentData and type(currentData) == "table" then
						animalEntry = currentData;
					end;
				end;
				local newCount = animalEntry and animalEntry.GlobalCount or nil;
				if newCount == 1 then
					if not uniqueIndicatorLabel or not uniqueIndicatorLabel.Parent then
						uniqueIndicatorLabel = Instance.new("TextLabel");
						uniqueIndicatorLabel.Name = "UniqueIndicator";
						uniqueIndicatorLabel.AnchorPoint = Vector2.new(0.5, 0);
						uniqueIndicatorLabel.Position = UDim2.new(0.5, 0, 1, 2);
						uniqueIndicatorLabel.Size = UDim2.new(1.6, 0, 0, 18);
						uniqueIndicatorLabel.BackgroundTransparency = 1;
						uniqueIndicatorLabel.Text = "1 of 1";
						uniqueIndicatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
						uniqueIndicatorLabel.TextStrokeTransparency = 0.15;
						uniqueIndicatorLabel.Font = Enum.Font.GothamBold;
						uniqueIndicatorLabel.TextSize = 14;
						uniqueIndicatorLabel.Parent = v71.DisplayName;
						v51:Add(v4.apply(uniqueIndicatorLabel, "Rainbow"));
					end;
				else
					if uniqueIndicatorLabel and uniqueIndicatorLabel.Parent then
						uniqueIndicatorLabel:Destroy();
					end;
					uniqueIndicatorLabel = nil;
				end;
			end;
			updateUniqueIndicator(v48);
			v51:Add(v46.Channel:OnChanged("AnimalList", updateUniqueIndicator));
			v71.Price.Text = ("$%*"):format((v13:ToString(v16:GetPrice(v48[v47].Index, l_LocalPlayer_0))));
			v71.Rarity.Text = v67.Rarity;
			v71.Rarity.TextColor3 = v22[v67.Rarity].Color;
			if l_Mutation_0 then
				local v76 = v23[l_Mutation_0];
				if v76.UseRichText then
					v71.Mutation.RichText = true;
					v71.Mutation.Text = v76.DisplayWithRichText;
				else
					v71.Mutation.Text = v76.DisplayText;
				end;
				if v76.GradientPreset then
					v51:Add(v4.apply(v71.Mutation, v76.GradientPreset));
				else
					v71.Mutation.TextColor3 = v76.MainColor;
				end;
			end;
			if l_Traits_0 then
				local l_Template_0 = v71.Traits.Template;
				for _, v79 in l_Traits_0 do
					local v80 = v26[v79];
					if v80 then
						local v81 = l_Template_0:Clone();
						v81.Parent = l_Template_0.Parent;
						v81.Image = v80.Icon;
						v81.Visible = true;
					end;
				end;
				v71.Traits.Visible = true;
			end;
			task.spawn(v75);
			v51:Add(v46.Channel:OnChanged("AnimalList", v75));
			v51:Add(v7.Simple(1, v75));
			v71.Mutation.Visible = l_Mutation_0 ~= nil;
			if v22[v67.Rarity].StrokeColor then
				v71.Rarity.UIStroke.Color = v22[v67.Rarity].StrokeColor;
			end;
			v71.Parent = l_v53_FirstChild_0;
			if v70.GradientPreset then
				v51:Add(v4.apply(v71.Rarity, v70.GradientPreset));
			end;
			local function v91()
				task.spawn(v75);
				local v82 = v46.Channel:Get((("AnimalList.%*"):format(v47)));
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
							if v90 and v82.Machine.Type == "Crafting" and v82.Machine.Active then
								v89.Text = "CRAFTING"
								v89.TextColor3 = Color3.fromRGB(0, 140, 255)
							elseif v90 and v82.Machine.Type == "Fuse" and v82.Machine.Active then
								v89.Text = "FUSING"
								v89.TextColor3 = Color3.fromRGB(0, 140, 255)
							elseif v90 and v82.Machine.Type == "Fuse" then
								v89.Text = "IN FUSE"
								v89.TextColor3 = Color3.fromRGB(0, 140, 255)
							elseif v90 then
								v89.Text = "IN MACHINE"
								v89.TextColor3 = Color3.fromRGB(0, 140, 255)
							else
								v89.Text = v82.StealText or "STOLEN"
								v89.TextColor3 = Color3.fromRGB(255, 0, 4)
							end
						end
						if v82 and (v82.Steal or v82.Machine) then
							if v89.Name == "Stolen" then
								v89.Visible = true
							elseif v89.Name == "Generation" then
								v89.Visible = true
							elseif v89.Name == "Traits" then
								v89.Visible = true
							else
								v89.Visible = false
							end
						elseif v89.Name == "Stolen" then
							v89.Visible = false
						else
							v89.Visible = v89:GetAttribute("DefaultState")
						end
					end
				end
			end
			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Steal"):format(v47), v91, true));
			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Machine"):format(v47), v91));
			v51:Add(v46.Channel:OnChanged("AnimalList", function(v92)
				if type(if typeof(v92) == "table" then v92[v47] else nil) == "table" then
					v91();
				end;
			end));
		end;
	end;
end;
v43.HideClaim = function(self, index)
	local podium = self.PlotModel.AnimalPodiums:FindFirstChild(index)
	if podium then
		local guiData = self.CollectGuis[podium]
		if guiData then
			guiData.gui.Enabled = false
		end
	end
end
v43.UpdateClaim = function(self, index)

	local animalData = (self.Channel:Get("AnimalList") or {})[index]
	if not animalData then return end

	local animalInfo = v21[animalData.Index]
	local generation = v16:GetGeneration(
		animalData.Index,
		animalData.Mutation,
		animalData.Traits,
		l_LocalPlayer_0
	)

	local earned = math.floor(workspace:GetServerTimeNow() - animalData.LastCollect) * generation

	local podium = self.PlotModel.AnimalPodiums:FindFirstChild(index)
	if not podium then return end

	local guiData = self.CollectGuis[podium]

	if not guiData then
		local gui, cleaner = l_FastOverheadController_0.createFastOverhead({
			adornee = podium.Claim.Main,
			guiTemplate = l_FastOverheadController_0.GuiTemplates.CashPad
		})

		self.OwnerCollector:Add(cleaner)

		guiData = {
			gui = gui,
			collectAmount = gui.CollectAmount,
			offline = gui.Offline
		}

		self.CollectGuis[podium] = guiData
	end

	if animalInfo and animalInfo.LuckyBlock
		or animalData.Index == "Coffin Tung Tung Tung Sahur"
		or animalData.Machine then

		guiData.gui.Enabled = false
		return
	end

	guiData.collectAmount.Text =
		("$%s"):format(v13:ToString(earned))

	if animalData.OfflineGain then
		guiData.offline.Text =
			("(Offline Cash: <font color=\"#73ff00\">$%s</font>)")
			:format(v13:ToString(animalData.OfflineGain * generation))
	end

	guiData.offline.Visible = animalData.OfflineGain ~= nil
	guiData.gui.Enabled = true
end
v43.UpdatePrompt = function(v102, v103)
	local l_FirstChild_1 = v102.PlotModel.AnimalPodiums:FindFirstChild(v103);
	local v105 = v102.Channel:Get("AnimalList") or {};
	local v106 = v105[v103];
	if l_FirstChild_1:GetAttribute("DeferDisplay") then
		v106 = nil;
	elseif v106 == "Empty" then
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
				local l_l_FirstChild_1_FirstChild_1 = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if l_l_FirstChild_1_FirstChild_1 and l_l_FirstChild_1_FirstChild_1:IsA("BillboardGui") then
					l_l_FirstChild_1_FirstChild_1.AlwaysOnTop = next(v113) ~= nil;
				end;
			end));
			v118.Collector:Add(v118.ProximityPrompt.PromptHidden:Connect(function()
				v113[v118.ProximityPrompt] = nil;
				local l_l_FirstChild_1_FirstChild_2 = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if l_l_FirstChild_1_FirstChild_2 and l_l_FirstChild_1_FirstChild_2:IsA("BillboardGui") then
					l_l_FirstChild_1_FirstChild_2.AlwaysOnTop = next(v113) ~= nil;
				end;
			end));
			v118.Collector:Add(function()
				v113[v118.ProximityPrompt] = nil;
				local l_l_FirstChild_1_FirstChild_3 = l_FirstChild_1:FindFirstChild("AnimalOverhead", true);
				if l_l_FirstChild_1_FirstChild_3 and l_l_FirstChild_1_FirstChild_3:IsA("BillboardGui") then
					l_l_FirstChild_1_FirstChild_3.AlwaysOnTop = next(v113) ~= nil;
				end;
			end);
			v118.Collector:Add(v118.ProximityPrompt.PromptButtonHoldBegan:Connect(function()
				for _, v123 in v112.Prompts do
					if v123 ~= v118 then
						v123.ProximityPrompt.Enabled = false;
					end;
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
	if v102.PlotModel:GetAttribute("BaseCheckPreview") then
		if not BaseCheckAllowed then
			v126:SetState("None");
			v127:SetState("None");
			return;
		end;
		if v126.State ~= "Delete" then
			v126:SetState("Delete", function()
				BaseCheckDelete:FireServer(v102.PlotModel.Name, v103);
			end);
		end;
		if v127.State ~= "Add" then
			v127:SetState("Add", function()
				BaseCheckAdd:FireServer(v102.PlotModel.Name, v103);
			end);
		end;
		return;
	end;
	if v102:GetOwner() == l_LocalPlayer_0 then
		-- FIX: Also check if Steal is false (owner carrying their own brainrot)
		local v128 = false;
		if l_LocalPlayer_0:GetAttribute("Stealing") then
			for _, v130 in v105 do
				-- FIX: Accept both Steal == player's UserId (stealing) and Steal == false (owner carrying own)
				if v130.Steal == l_LocalPlayer_0.UserId then
					v128 = true;
					break;
				end;
			end;
		end;
		if not v106 and not v128 or v106 and v106.Machine and v106.Machine.Active then
			if v126.State ~= "None" then
				v126:SetState("None");
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
			return;
		elseif v128 then
			if v106 and v106.Steal then
				-- Check if the Steal flag is stale (stealing player left the game)
				local stealIsStale = typeof(v106.Steal) == "number" and l_Players_0:GetPlayerByUserId(v106.Steal) == nil
				if not stealIsStale then
					if v126.State ~= "None" then
						v126:SetState("None")
					end
					if v127.State ~= "None" then
						v127:SetState("None")
					end
					return
				end
			end
			if v126.State ~= "Place" then
				v126:SetState("Place", function()
					v36:FireServer("Place", v103)
				end)
			end
			if v127.State ~= "None" then
				v127:SetState("None")
			end
			return
		elseif v106 and v106.Machine then
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
					elseif v131 == "Valentines" then
						v8:RemoteEvent("StockEventService/Return"):FireServer(v103)
					end;
				end);
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
			return;
		elseif v106 and v106.InTrade then
			-- ✅ FIX: Empêcher le grab d'un brainrot qui est dans un trade
			if v126.State ~= "None" then
				v126:SetState("None");
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
			return;
		else
			local v134 = v106.Timer or 1;
			if v126.State ~= "Grab" and v134 > 0 then
				v126:SetState("Grab", function()
					v36:FireServer("Grab", v103);
				end);
			elseif v126.State ~= "Open" and v134 <= 0 then
				v126:SetState("Open", function()
					v37:FireServer(v103);
				end);
			end;
			if v127.State ~= "Sell" then
				v127:SetState("Sell", function()
					local l_AnimalIndex_0 = v102.AnimalsPrompts[v103].AnimalIndex;
					local l_Rarity_0 = v21[l_AnimalIndex_0].Rarity;
					local v137 = true;
					if l_Rarity_0 ~= "OG" then
						v137 = true;
						if l_Rarity_0 ~= "Admin" then
							v137 = true;
							if l_Rarity_0 ~= "Taco" then
								v137 = true;
								if l_Rarity_0 ~= "Secret" then
									v137 = l_Rarity_0 == "Brainrot God";
								end;
							end;
						end;
					end;
					if v137 then
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
		-- Check if the Steal flag is stale (stealing player left the game)
		local stealIsStale = typeof(v106.Steal) == "number" and l_Players_0:GetPlayerByUserId(v106.Steal) == nil
		if not stealIsStale then
			if v126.State ~= "None" then
				v126:SetState("None");
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
		end
	elseif v106 and v106.InTrade then
		-- ✅ FIX: Empêcher le vol/déplacement d'un brainrot qui est dans un trade
		if v126.State ~= "None" then
			v126:SetState("None");
		end;
		if v127.State ~= "None" then
			v127:SetState("None");
		end;
	elseif v106 and (not v106.Machine or v106.Machine.Active ~= true) then
		if v126.State ~= "Steal" then
			v126:SetState("Steal", function()
				l_FireServer_0(v39, workspace:GetServerTimeNow() + 67, "c262398d-68e3-4499-8bea-99766bf11686", v102.PlotModel.Name, v103);
				v39:FireServer(workspace:GetServerTimeNow() + 67, "579e6c26-5a80-407d-9488-0f84752e8f1f", v102.PlotModel.Name, v103);
			end);
		end;
		if v127.State ~= "None" then
			v127:SetState("None");
		end;
	else
		if v126.State ~= "None" then
			v126:SetState("None");
		end;
		if v127.State ~= "None" then
			v127:SetState("None");
		end;
	end;
end;
v43.UpdateAnimalPodiums = function(v139)
	-- FIX: Wrap Channel:Get in pcall to handle CacheTable being nil
	local ok, v140 = pcall(function()
		return v139.Channel:Get("AnimalList") or {};
	end)
	if not ok or type(v140) ~= "table" then
		v140 = {};
	end
	-- FIX: Handle case where Tier attribute might be nil or invalid
	local tierAttribute = v139.PlotModel:GetAttribute("Tier")
	if tierAttribute == nil then
		warn("[PlotClient] UpdateAnimalPodiums: Tier attribute is nil for plot:", v139.PlotModel.Name)
		return
	end
	local baseData = v24[tierAttribute]
	if not baseData then
		warn("[PlotClient] UpdateAnimalPodiums: No base data found for tier:", tierAttribute)
		return
	end
	for v141 = 1, baseData.MaxAnimals do
		local l_FirstChild_2 = v139.PlotModel.AnimalPodiums:FindFirstChild(v141);
		if type(v140[v141]) == "table" and l_FirstChild_2 and not l_FirstChild_2:GetAttribute("DeferDisplay") then
			v139:UpdateModel(v141);
			v139:UpdateClaim(v141);
		else
			v139:ClearIndex(v141);
			v139:HideClaim(v141);
		end;
		v139:UpdatePrompt(v141);
	end;
end;
local function v152(v143)
	local v144 = false;
	local _ = v143:GetOwner();
	local v146 = v143.PlotModel:WaitForChild("Purchases", 5);
	if not v146 then
		return;
	else
		if v143.Channel:Get("BlockEndTime") ~= nil then
			local v147 = math.clamp(math.round(v143.Channel:Get("BlockEndTime") - workspace:GetServerTimeNow()), 0, 1e999);
			for _, v149 in v146:GetChildren() do
				v149.Main.BillboardGui.RemainingTime.Text = v12:C(v147);
			end;
			v144 = true;
		end;
		for _, v151 in v146:GetChildren() do
			v151.Main.BillboardGui.LockStudio.Visible = not v144;
			v151.Main.BillboardGui.RemainingTime.Visible = v144;
			v151.Main.BillboardGui.Locked.Visible = v144;
		end;
		return;
	end;
end;
local function v162(v153)
	if v153.Channel:Get("BlockEndTime") == nil then
		local v154 = false;
		local _ = v153:GetOwner();
		local v156 = v153.PlotModel:WaitForChild("Purchases", 5);
		if not v156 then
			return;
		else
			if v153.Channel:Get("BlockedDelayTime") ~= nil then
				local v157 = math.clamp(math.round(v153.Channel:Get("BlockedDelayTime") - workspace:GetServerTimeNow()), 0, 1e999);
				for _, v159 in v156:GetChildren() do
					v159.Main.BillboardGui.RemainingTime.Text = v12:C(v157);
				end;
				v154 = true;
			end;
			for _, v161 in v156:GetChildren() do
				v161.Main.BillboardGui.LockStudio.Visible = not v154;
				v161.Main.BillboardGui.RemainingTime.Visible = v154;
				v161.Main.BillboardGui.Delay.Visible = v154;
			end;
		end;
	end;
end;
local function v169(v163)
	if v163:GetOwner() == l_LocalPlayer_0 then
		return;
	else
		for _, v165 in v163.PlotModel.Unlock:GetChildren() do
			local l_Attribute_0 = v165.UnlockBase:GetAttribute("Floor");
			if l_Attribute_0 then
				local v167 = "BlockEndTimeFirstFloor";
				if l_Attribute_0 == 2 then
					v167 = "BlockEndTimeSecondFloor";
				elseif l_Attribute_0 == 3 then
					v167 = "BlockEndTimeThirdFloor";
				end;
				local v168 = v163.Channel:Get(v167) ~= nil;
				v165.UnlockBase.Enabled = v168;
			end;
		end;
		return;
	end;
end;
local function v182(v170)
	if not v170.Channel or not v170.Channel.Get then
		return;
	else
		local v171 = v170:GetOwner() == l_LocalPlayer_0;
		local l_v170_Owner_0 = v170:GetOwner();
		local l_v29_InGameFriends_0 = v29:GetInGameFriends(l_LocalPlayer_0);
		local v174 = v170.Channel:Get("FriendsAllowed") == true;
		local v175 = v170.PlotModel:WaitForChild("LaserHitbox", 5);
		if not v175 then
			return;
		else
			for _, v177 in v175:GetChildren() do
				local l_v177_Attribute_0 = v177:GetAttribute("Floor");
				if l_v177_Attribute_0 then
					local v179 = "BlockEndTimeFirstFloor";
					if l_v177_Attribute_0 == 2 then
						v179 = "BlockEndTimeSecondFloor";
					elseif l_v177_Attribute_0 == 3 then
						v179 = "BlockEndTimeThirdFloor";
					end;
					local v180 = v170.Channel:Get(v179) ~= nil;
					local _ = true;
					v177.CanCollide = not v171 and not l_LocalPlayer_0:GetAttribute("IgnoreLasers") and if v180 then not table.find(l_v29_InGameFriends_0, l_v170_Owner_0) or not v174 or false else false;
				end;
			end;
			return;
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
v43.new = function(v186)
	local v187 = setmetatable({}, v43);
	v187.UID = v186.Name;
	v187.PlotModel = v186;
	v187.Collector = v6.new();
	v187.OwnerCollector = v6.new();
	v187.Collector:Add(v187.OwnerCollector, "Destroy");
	v187.AnimalsModels = {};
	v187.AnimalsIndex = {};
	v187.AnimalsPrompts = {};
	v187.ModelsCollector = {};
	v187.CollectGuis = {};
	v187.Channel = v5:Wait(v187.UID);
	local function v194()
		for v188, v189 in v187.AnimalsPrompts do
			for _, v191 in v189.Prompts do
				v191:Destroy();
			end;
			v187.AnimalsPrompts[v188] = nil;
		end;
		for v192, v193 in v187.AnimalsModels do
			v193:Destroy();
			v187.AnimalsModels[v192] = nil;
		end;
	end;
	local function v226()
		v187.OwnerCollector:Clean();
		v194();
		local podiums = v187.PlotModel:WaitForChild("AnimalPodiums", 10)
		if not podiums then
			warn("AnimalPodiums don't found for plot: " .. v187.PlotModel.Name)
			return
		end

		-- FIX: Wait for all podiums to be fully loaded before proceeding
		-- FIX: Handle case where Tier attribute might be nil or invalid
		local tierAttribute = v186:GetAttribute("Tier")
		if tierAttribute == nil then
			warn("[PlotClient] Tier attribute is nil for plot:", v186.Name)
			tierAttribute = 0
		end
		local baseData = v24[tierAttribute]
		if not baseData then
			warn("[PlotClient] No base data found for tier:", tierAttribute)
			return
		end
		local maxAnimals = baseData.MaxAnimals
		local podiumLoadErrors = {}
		for i = 1, maxAnimals do
			local podium = podiums:WaitForChild(tostring(i), 10)
			if podium then
				podium:WaitForChild("Claim", 10)
				podium:WaitForChild("Base", 10)
				if podium:FindFirstChild("Claim") then
					podium.Claim:WaitForChild("Hitbox", 10)
				end
			else
				table.insert(podiumLoadErrors, i)
			end
		end
		
		-- FIX: Log if any podiums failed to load
		if #podiumLoadErrors > 0 then
			warn("[PlotClient] Failed to load podiums:", table.concat(podiumLoadErrors, ", "))
		end

		for v195 = 1, v24[tierAttribute].MaxAnimals do
			if v187:GetOwner() == l_LocalPlayer_0 then
				local l_FirstChild_3 = v187.PlotModel.AnimalPodiums:FindFirstChild(v195);
				local v197 = l_FirstChild_3 and l_FirstChild_3.Claim.Hitbox;
				v187.OwnerCollector:Add(v197.Touched:Connect(function(hit)
					if hit.Name == "HumanoidRootPart" then
						local player = l_Players_0:GetPlayerFromCharacter(hit.Parent)
						if player and player == v187:GetOwner() then
							v38:FireServer(v195)
						end
					end
				end))
			end;
		end;
		local v200 = {};
		for _, v202 in v187.PlotModel:GetChildren() do
			if v202.Name == "DeliveryHitbox" then
				table.insert(v200, v202);
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
					if l_v204_0 < 0.05 then
						return;
					else
						debug.profilebegin("PlotClient:Hitboxes");
						l_v204_0 = 0;
						if not l_LocalPlayer_0:GetAttribute("Stealing") then
							return;
						else
							local v207 = v187.Channel:Get("AnimalList") or {};
							for _, v209 in v207 do
								-- FIX: Also accept Steal == false (owner carrying own brainrot)
							if v209.Steal == l_LocalPlayer_0.UserId then
									debug.profileend();
									return;
								end;
							end;
							local l_Character_0 = l_LocalPlayer_0.Character;
							if not l_Character_0 then
								debug.profileend();
								return;
							else
								local l_Position_0 = l_Character_0:GetPivot().Position;
								if #workspace:GetPartBoundsInBox(CFrame.new(l_Position_0), Vector3.new(4, 4, 2, 0), v203) <= 0 then
									return;
								else
									l_FireServer_0(v40, "7799aa8a-03f9-4df1-ab0f-b6df84f6b36c");
									v40:FireServer("7799aa8a-03f9-4df1-ab0f-b6df84f6b36c");
									debug.profileend();
									return;
								end;
							end;
						end;
					end;
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
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTime", function()
			v152(v187);
			v169(v187);
			v162(v187);
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeFirstFloor", function()
			v152(v187);
			v169(v187);
			v162(v187);
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeSecondFloor", function()
			v152(v187);
			v169(v187);
			v162(v187);
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockEndTimeThirdFloor", function()
			v152(v187);
			v169(v187);
			v162(v187);
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("BlockedDelayTime", function()
			v152(v187);
			v169(v187);
			v162(v187);
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v187.Channel:OnChanged("AnimalList", function(_)
			v187:UpdateAnimalPodiums();
		end, true));
	-- FIX: Delayed retry for initial UpdateAnimalPodiums in case AnimalList wasn't ready
	task.delay(2, function()
		if v187 and v187.OwnerCollector and v187.PlotModel and v187.PlotModel.Parent then
			v187:UpdateAnimalPodiums();
		end
	end);
		local l_v187_Owner_0 = v187:GetOwner();
		if l_v187_Owner_0 then
			v187.OwnerCollector:Add(l_v187_Owner_0:GetAttributeChangedSignal("Stealing"):Connect(function(_)
				v187:UpdateAnimalPodiums();
			end));
		end;
		for _, v216 in v187.PlotModel.Unlock:GetChildren() do
			v187.OwnerCollector:Add(v216.UnlockBase.Triggered:Connect(function(v217)
				if v217 and v217:IsA("Player") then
					if v187:GetOwner() == v217 then
						return;
					else
						local l_ProductId_0 = v25[v216.UnlockBase:GetAttribute("Floor")].ProductId;
						local l_UserId_0 = v187:GetOwner().UserId;
						if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil then
							v33:FireServer(l_ProductId_0, l_UserId_0);
						end;
					end;
				end;
			end));
			v187.OwnerCollector:Add(v187.PlotModel.Unlock.ChildAdded:Connect(function(v220)
				v187.OwnerCollector:Add(v220.UnlockBase.Triggered:Connect(function(v221)
					if v221 and v221:IsA("Player") then
						if v187:GetOwner() == v221 then
							return;
						else
							local l_ProductId_1 = v25[v220.UnlockBase:GetAttribute("Floor")].ProductId;
							local l_UserId_1 = v187:GetOwner().UserId;
							if v187.Channel:Get("BlockEndTimeFirstFloor") ~= nil or v187.Channel:Get("BlockEndTimeSecondFloor") ~= nil or v187.Channel:Get("BlockEndTimeThirdFloor") ~= nil then
								v33:FireServer(l_ProductId_1, l_UserId_1);
							end;
						end;
					end;
				end));
				v182(v187);
			end));
		end;
		if v187.PlotModel:GetAttribute("Tier") == 0 and v187:GetOwner() then
			v187.PlotModel.FriendPanel:PivotTo(CFrame.new((Vector3.new(0, 1000000000, 0, 0))));
		end;
		local l_ProximityPrompt_0 = v187.PlotModel.FriendPanel.Main.ProximityPrompt;
		v187.OwnerCollector:Add(v187.Channel:OnChanged("FriendsAllowed", function(v225)
			l_ProximityPrompt_0.ObjectText = v225 == true and "Disallow Friends" or "Allow Friends";
			v187.PlotModel.FriendPanel.Main.SurfaceGui.ImageLabel.Image = v225 == true and "rbxassetid://110507824065923" or "rbxassetid://110783679426495";
			v182(v187);
		end, true));
		v187.OwnerCollector:Add(v29.OnFriendsUpdate:Connect(function()
			v182(v187);
		end));
		v187.OwnerCollector:Add(l_LocalPlayer_0:GetAttributeChangedSignal("IgnoreLasers"):Connect(function()
			v182(v187);
		end));
		v187.OwnerCollector:Add(l_ProximityPrompt_0.Triggered:Connect(function()
			if v187:GetOwner() ~= l_LocalPlayer_0 then
				return;
			else
				v41:FireServer();
				return;
			end;
		end));
		v187.PlotModel.PlotSign.YourBase.Enabled = v187:GetOwner() == l_LocalPlayer_0;
	end;
	v187.Collector:Add(v187.Channel:OnChanged("Owner", v226, true));
	v187.Collector:Add(v187.PlotModel:GetAttributeChangedSignal("Tier"):Connect(v226));
	return v187;
end;
v43.Destroy = function(v227)
	for v228, v229 in v227.AnimalsPrompts do
		for _, v231 in v229.Prompts do
			v231:Destroy();
		end;
		v227.AnimalsPrompts[v228] = nil;
	end;
	for v232, v233 in v227.AnimalsModels do
		v233:Destroy();
		v227.AnimalsModels[v232] = nil;
	end;
	v227.Collector:Destroy();
end;
return v43;