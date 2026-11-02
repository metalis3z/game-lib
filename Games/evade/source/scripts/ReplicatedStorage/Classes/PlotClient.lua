local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v4 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v5 = require(l_Packages_0.Synchronizer);
local v6 = require(l_Packages_0.Trove);
local v7 = require(l_Packages_0.Timer);
local v8 = require(l_Packages_0.Net);
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
local v21 = require(l_Datas_0.Animals);
local v22 = require(l_Datas_0.Rarities);
local v23 = require(l_Datas_0.Mutations);
local v24 = require(l_Datas_0.Bases);
local v25 = require(l_Datas_0.UnlockBase);
local v26 = require(l_Datas_0.Traits);
local v27 = require(l_ReplicatedStorage_0.Datas.FuseMachineData);
local v29 = require(l_ReplicatedStorage_0:WaitForChild("Shared").Friends);
local v30 = require(l_ReplicatedStorage_0.Controllers.AnimationSyncController);
local v31 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v32 = require(l_ReplicatedStorage_0.Controllers.ConfirmationController);
-- FAST OVERHEAD CONTROLLER
local v_u_FastOverhead = require(l_ReplicatedStorage_0.Controllers.FastOverheadController);

local v33 = v8:RemoteEvent("ShopService/Purchase");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v35 = v8:RemoteEvent("PlotService/Sell");
local v36 = v8:RemoteEvent("StealService/Grab");
local v37 = v8:RemoteEvent("PlotService/Open");
local v38 = v8:RemoteEvent("PlotService/ClaimCoins");
local v39 = v8:RemoteEvent("5aa39ea1-0c65-4fcf-aff9-b18a7ef277c3");
local v40 = v8:RemoteEvent("5c8f0dd0-0f9e-44ba-8f9b-197958b661ab");
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
		if v49:GetAttribute("Mutation") ~= v48[v47].Mutation then v50 = true; end;
		if type(v48[v47].Traits) == "table" and v49:GetAttribute("Traits") ~= table.concat(v48[v47].Traits, ",") then v50 = true; end;
		if type(v48[v47].Traits) ~= "table" and v49:GetAttribute("Traits") ~= nil then v50 = true; end;
	end;
	if v50 then
		v46:ClearIndex(v47);
		v46.AnimalsIndex[v47] = v48[v47].Index;
		v37.OnClientEvent:Connect(function(podiumIndex, animalIndex)
			local podium = v46.PlotModel.AnimalPodiums:FindFirstChild(podiumIndex)
			if not podium then return end
			local blockModel = v46.AnimalsModels[podiumIndex]
			if blockModel then
				for i = 1, 10 do
					blockModel:PivotTo(blockModel:GetPivot() * CFrame.new(math.random(-1,1)/5, 0, math.random(-1,1)/5))
					task.wait(0.05)
				end
			end
			v46:UpdateModel(podiumIndex)
		end)
	end;
	if v50 then
		local v51 = v46.ModelsCollector[v47];
		if v51 then v51:Clean(); else v51 = v6.new(); v46.ModelsCollector[v47] = v51; end;

		local l_l_Animals_0_FirstChild_0 = l_Animals_0:FindFirstChild(v48[v47].Index);
		if not l_l_Animals_0_FirstChild_0 then return; end;

		local v53 = l_l_Animals_0_FirstChild_0:Clone();
		v46.AnimalsModels[v47] = v53;
		for _, v55 in v53:GetDescendants() do
			if v55:IsA("BasePart") then
				v55.CanCollide = false; v55.CanQuery = false; v55.CanTouch = false;
				v55.Massless = true; v55.Anchored = true;
			end;
		end;
		v53.Parent = v46.PlotModel;
		if v53.PrimaryPart then v53.PrimaryPart.Anchored = true; end;

		local l_Mutation_0 = v48[v47].Mutation;
		if l_Mutation_0 then
			v51:Add(v16:ApplyMutation(v53, v48[v47].Index, l_Mutation_0));
			v53:SetAttribute("Mutation", l_Mutation_0);
		end;

		local l_v53_ExtentsSize_0 = v53:GetExtentsSize();
		local l_Traits_0 = v48[v47].Traits;
		if l_Traits_0 then
			v51:Add(v16:ApplyTraits(v53, v48[v47].Index, l_Traits_0));
			v53:SetAttribute("Traits", table.concat(l_Traits_0, ","));
		end;
		v53:PivotTo(v46.PlotModel.AnimalPodiums:FindFirstChild(v47).Base.Spawn:GetPivot());

		local v59 = v53:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController", v53);
		local v60 = v59:FindFirstChildOfClass("Animator") or Instance.new("Animator", v59);
		local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(v48[v47].Index);
		local v62 = l_l_Animals_1_FirstChild_0 and l_l_Animals_1_FirstChild_0:FindFirstChild("Idle");
		if v62 and v60 then
			local v63 = v60:LoadAnimation(v62);
			v63.Looped = true; v63:Play();
			local v64 = v30:Add(v63);
			v51:Add(function() v64(); v63:Stop(0); v63:Destroy(); end);
		end;

		local v67 = v21[v48[v47].Index];

		-- FAST OVERHEAD ATTACHMENT LOGIC (HEIGHT 0.40)
		local l_v53_FirstChild_0 = v53:FindFirstChild("OVERHEAD_ATTACHMENT", true);
		if not l_v53_FirstChild_0 then
			local v69 = Instance.new("Attachment");
			v69.Name = "OVERHEAD_ATTACHMENT";
			-- SET HEIGHT TO 0.40
			v69.CFrame = CFrame.new(0, l_v53_ExtentsSize_0.Y * 0.40 * (v67 and v67.OverheadYOffsetModifier or 1), 0);
			v69.Parent = v53.PrimaryPart or v53:FindFirstChildWhichIsA("BasePart");
			l_v53_FirstChild_0 = v69;
			v51:Add(v69)
		end;

		-- CREATE FAST OVERHEAD
		local uiSuccess, v71, cleanup = pcall(function()
			return v_u_FastOverhead.createFastOverhead({
				["adornee"] = l_v53_FirstChild_0,
				["animal"] = v48[v47].Index
			})
		end)

		if uiSuccess and v71 then
			v51:Add(cleanup)
			local l_Generation_0 = v71.Generation;

			local function v75()
				local v73 = v46.Channel:Get((("AnimalList.%*"):format(v47)));
				if v73 and v73.Timer ~= nil then
					l_Generation_0.Text = v73.Timer <= 0 and "READY!" or v12:E(v73.Timer);
					l_Generation_0.Visible = true;
				elseif v48[v47].Index == "Coffin Tung Tung Tung Sahur" then
					l_Generation_0.Text = ""; l_Generation_0.Visible = false;
				elseif v73 and v73.Machine and v73.Machine.Active then
					local v74 = (v73.Machine.FinishTime or 0) - workspace:GetServerTimeNow();
					l_Generation_0.Text = v74 <= 0 and "READY!" or v12:E(v74);
					l_Generation_0.Visible = true;
				else
					l_Generation_0.Text = ("$%*/s"):format((v13:ToString(v16:GetGeneration(v48[v47].Index, v48[v47].Mutation, v48[v47].Traits, nil))));
					l_Generation_0.Visible = true;
				end;
			end;

			v71.DisplayName.Text = tostring(v67.DisplayName);
			v71.Price.Text = ("$%*"):format((v13:ToString(v16:GetPrice(v48[v47].Index, l_LocalPlayer_0))));
			v71.Rarity.Text = tostring(v67.Rarity);

			local v70 = v22[v67.Rarity];
			if v70 then
				v71.Rarity.TextColor3 = v70.Color;
				if v71.Rarity:FindFirstChild("UIStroke") then
					v71.Rarity.UIStroke.Color = v70.StrokeColor or Color3.new(0,0,0);
				end;
				if v70.GradientPreset then v51:Add(v4.apply(v71.Rarity, v70.GradientPreset)); end;
			end

			if l_Mutation_0 then
				local v76 = v23[l_Mutation_0];
				if v76.UseRichText then
					v71.Mutation.RichText = true; v71.Mutation.Text = v76.DisplayWithRichText;
				else
					v71.Mutation.Text = v76.DisplayText;
				end;
				if v76.GradientPreset then v51:Add(v4.apply(v71.Mutation, v76.GradientPreset)); else v71.Mutation.TextColor3 = v76.MainColor; end;
				v71.Mutation.Visible = true;
			else
				v71.Mutation.Visible = false;
			end;

			if l_Traits_0 and v71:FindFirstChild("Traits") then
				local l_Template_0 = v71.Traits.Template;
				for _, v79 in l_Traits_0 do
					local v80 = v26[v79];
					if v80 then
						local v81 = l_Template_0:Clone();
						v81.Parent = l_Template_0.Parent; v81.Image = v80.Icon; v81.Visible = true;
					end;
				end;
				v71.Traits.Visible = true;
			end;

			task.spawn(v75);
			v51:Add(v46.Channel:OnChanged("AnimalList", v75));
			v51:Add(v7.Simple(1, v75));

			local function v91()
				task.spawn(v75);
				local v82 = v46.Channel:Get((("AnimalList.%*"):format(v47)));
				local l_v46_Owner_0 = v46:GetOwner();
				local v84 = l_v46_Owner_0 and v82 and v82.Steal == l_v46_Owner_0.UserId;

				for _, v86 in v53:GetDescendants() do
					if v86:IsA("BasePart") then
						local curTrans = v86:GetAttribute("DefaultTransparency") or v86.Transparency
						v86:SetAttribute("DefaultTransparency", curTrans)
						v86.Transparency = (v82 and (v82.Steal or v82.Machine)) and 0.5 or curTrans;
					end;
				end;

				for _, v89 in v71:GetChildren() do
					if v89:IsA("TextLabel") then
						if v89.Name == "Stolen" then
							if v82 and v82.Machine then
								v89.Text = (v82.Machine.Type == "Crafting") and "CRAFTING" or "MACHINE";
								v89.TextColor3 = Color3.fromRGB(0, 140, 255);
							else
								v89.Text = "STOLEN"; v89.TextColor3 = Color3.fromRGB(255, 0, 4);
							end
							v89.Visible = (v82 and (v82.Steal or v82.Machine)) and not v84;
						elseif v89.Name == "Generation" then
							v89.Visible = not (v82 and v82.Steal) or (v82 and v82.Machine and v82.Machine.Active);
						else
							v89.Visible = not (v82 and (v82.Steal or v82.Machine));
						end;
					end;
				end;
			end;
			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Steal"):format(v47), v91, true));
			v51:Add(v46.Channel:OnChanged(("AnimalList.%*.Machine"):format(v47), v91));
		end;
	end;
end;
v43.HideClaim = function(v93, v94)
	local l_FirstChild_0 = v93.PlotModel.AnimalPodiums:FindFirstChild(v94);
	if l_FirstChild_0 then l_FirstChild_0.Claim.Main.Collect.Enabled = false; end;
end;

v43.UpdateClaim = function(v96, v97)
	local v98 = (v96.Channel:Get("AnimalList") or {})[v97];
	if not v98 then return end
	local v99 = v21[v98.Index];
	local v100 = math.floor(workspace:GetServerTimeNow() - v98.LastCollect) * v16:GetGeneration(v98.Index, v98.Mutation, v98.Traits, l_LocalPlayer_0);
	local l_Collect_0 = v96.PlotModel.AnimalPodiums:FindFirstChild(v97).Claim.Main.Collect;
	if v99 and v99.LuckyBlock or v98.Index == "Coffin Tung Tung Tung Sahur" or v98.Machine then
		l_Collect_0.Enabled = false;
	else
		l_Collect_0.Collect.Text = ("Collect <br/><font color=\"#73ff00\">$%*</font>"):format((v13:ToString(v100)));
		if v98.OfflineGain then
			l_Collect_0.Offline.Text = ("(Offline Cash: <font color=\"#73ff00\">$%*</font>)"):format((v13:ToString(v98.OfflineGain * v16:GetGeneration(v98.Index, v98.Mutation, v98.Traits, l_LocalPlayer_0))));
		end;
		l_Collect_0.Offline.Visible = v98.OfflineGain ~= nil;
		l_Collect_0.Enabled = true;
	end;
end;
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
	if v102:GetOwner() == l_LocalPlayer_0 then
		local v128 = false;
		if l_LocalPlayer_0:GetAttribute("Stealing") then
			for _, v130 in v105 do
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
			if v126.State ~= "Place" then
				v126:SetState("Place", function()
					v36:FireServer("Place", v103);
				end);
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
			return;
		elseif v106 and v106.Machine and not v106.Machine.Active then
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
					elseif v131 == "Winter Hour " then
						v8:RemoteEvent("StockEventService/Return"):FireServer(v106.Machine.Type, v103);
					end;
				end);
			end;
			if v127.State ~= "None" then
				v127:SetState("None");
			end;
			return;
		else
			local v134 = v107 == "Coffin Tung Tung Tung Sahur" and 0 or (v106.Timer or 1);
			if v106 and v106.Steal then
				if v126.State ~= "None" then
					v126:SetState("None");
				end;
			elseif v126.State ~= "Grab" and v134 > 0 then
				v126:SetState("Grab", function()
					v36:FireServer("Grab", v103);
				end);
			elseif v126.State ~= "Open" and v134 <= 0 then
				v126:SetState("Open", function()
					v37:FireServer(v103);
				end);
			end;


			if v106 and v106.Steal then
				if v127.State ~= "None" then
					v127:SetState("None");
				end;
			elseif v127.State ~= "Sell" then
				v127:SetState("Sell", function()
					local l_AnimalIndex_0 = v102.AnimalsPrompts[v103].AnimalIndex;
					local l_Rarity_0 = v21[l_AnimalIndex_0].Rarity;
					local v137 = true;
					if l_Rarity_0 ~= "OG" then
						v137 = true;
						if l_Rarity_0 ~= "Admin" then
							v137 = true;
							if l_Rarity_0 ~= "Spooky" then
								v137 = true;
								if l_Rarity_0 ~= "Taco" then
									v137 = true;
									if l_Rarity_0 ~= "Secret" then
										v137 = l_Rarity_0 == "Brainrot God";
									end;
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
		if v126.State ~= "None" then
			v126:SetState("None");
		end;
		if v127.State ~= "None" then
			v127:SetState("None");
		end;
	elseif v106 and (not v106.Machine or not v106.Machine.Active) then
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
	local v140 = v139.Channel:Get("AnimalList") or {};
	for v141 = 1, v24[v139.PlotModel:GetAttribute("Tier")].MaxAnimals do
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
		for v195 = 1, v24[v186:GetAttribute("Tier")].MaxAnimals do
			if v187:GetOwner() == l_LocalPlayer_0 then
				local l_FirstChild_3 = v187.PlotModel.AnimalPodiums:FindFirstChild(v195);
				local v197 = l_FirstChild_3 and l_FirstChild_3.Claim.Hitbox;
				v187.OwnerCollector:Add(v197.Touched:Connect(function(v198)
					if v198.Name ~= "HumanoidRootPart" then
						return;
					else
						local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v198.Parent);
						if not l_l_Players_0_PlayerFromCharacter_0 or l_l_Players_0_PlayerFromCharacter_0 ~= v187:GetOwner() then
							return;
						else
							v38:FireServer(v195);
							return;
						end;
					end;
				end));
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