-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("ServerStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v5 = require(l_ReplicatedStorage_0.Packages.ReplicatorClient);
local v6 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v7 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v8 = require(l_ReplicatedStorage_0.Packages.Observers);
local v9 = require(l_ReplicatedStorage_0.Packages.Debounce);
local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
local v11 = require(l_ReplicatedStorage_0.Packages.Timer);
local v12 = require(l_ReplicatedStorage_0.Packages.Spr);
local v13 = require(l_ReplicatedStorage_0.Packages.Net);
local v14 = require(l_ReplicatedStorage_0.Controllers.FastOverheadController);
local v15 = require(l_ReplicatedStorage_0.Controllers.ConfirmationController);
local v16 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v17 = require(l_ReplicatedStorage_0.Controllers.CharacterController);
local v18 = require(l_ReplicatedStorage_0.Controllers.ShopController);
local v19 = require(l_ReplicatedStorage_0.Shared.TsunamiEventDebug);
local v20 = require(l_ReplicatedStorage_0.Shared.TsunamiEventData);
local v21 = require(l_ReplicatedStorage_0.Shared.Animals);
local v22 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v23 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v24 = require(l_ReplicatedStorage_0.Datas.Animals);
local v25 = require(l_ReplicatedStorage_0.Datas.Mutations);
local v26 = require(l_ReplicatedStorage_0.Datas.Traits);
local v27 = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local v28 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v29 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v30 = v13:RemoteEvent("TsunamiEventService/BuySpeedUpgrade");
local v31 = v13:RemoteEvent("TsunamiEventService/ToggleSlowmode");
local v32 = v13:RemoteEvent("TsunamiEventService/Teleport");
local v33 = v13:RemoteEvent("TsunamiEventService/Drop");
local v34 = v13:RemoteEvent("TsunamiEventService/Grab");
local v35 = v13:RemoteEvent("TsunamiEventService/Kill");
local v36 = v13:RemoteEvent("ShopService/Purchase");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Slowmode_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("RightBottom").Slowmode;
local l_TsunamiSpeedUpgrade_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("TsunamiSpeedUpgrade").TsunamiSpeedUpgrade;
local v40 = {};
local v41 = nil;
v40.StartWaves = function(_) --[[ Line: 60 ]] --[[ Name: StartWaves ]]
	-- upvalues: v5 (copy), l_ReplicatedStorage_0 (copy), v20 (copy), l_RunService_0 (copy), v19 (copy), v17 (copy), l_LocalPlayer_0 (copy), v28 (copy), v35 (copy)
	local v43 = v5.get("TsunamiEvent/Waves");
	local l_Folder_0 = Instance.new("Folder");
	l_Folder_0.Name = "Waves";
	l_Folder_0.Parent = workspace;
	local v45 = {};
	local function _(v46) --[[ Line: 69 ]] --[[ Name: removeWave ]]
		-- upvalues: v45 (copy)
		local v47 = v45[v46];
		if v47 then
			v47.model:Destroy();
			v45[v46] = nil;
		end;
	end;
	local function v59() --[[ Line: 77 ]] --[[ Name: reconcileWaves ]]
		-- upvalues: v43 (copy), v45 (copy), l_ReplicatedStorage_0 (ref), v20 (ref), l_Folder_0 (copy)
		local v49 = v43:TryIndex({
			"waves"
		});
		if not v49 then
			return;
		else
			local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
			for v51, v52 in v49 do
				if not v45[v51] then
					local v53 = l_ReplicatedStorage_0.Models.TsunamiWaves[v52.name]:Clone();
					v53.Name = v51;
					v53:PivotTo(v20.getWavePositionAtTime(v52, l_workspace_ServerTimeNow_0));
					local l_v53_FirstChild_0 = v53:FindFirstChild("WavesLoop", true);
					if l_v53_FirstChild_0 then
						l_v53_FirstChild_0.Looped = true;
						l_v53_FirstChild_0:Play();
					end;
					local v55 = v53.Main.CFrame:Inverse() * v53:GetPivot();
					local l_Motor6D_0 = Instance.new("Motor6D");
					l_Motor6D_0.Part0 = workspace.Terrain;
					l_Motor6D_0.Part1 = v53.Main;
					l_Motor6D_0.C1 = v55;
					l_Motor6D_0.Parent = v53.Main;
					v53.Main.Anchored = false;
					v53.Parent = l_Folder_0;
					v45[v51] = {
						model = v53, 
						motor = l_Motor6D_0
					};
				end;
			end;
			for v57 in v45 do
				if not v49[v57] then
					local v58 = v45[v57];
					if v58 then
						v58.model:Destroy();
						v45[v57] = nil;
					end;
				end;
			end;
			return;
		end;
	end;
	local v60 = 0;
	l_RunService_0.PostSimulation:Connect(function(_) --[[ Line: 123 ]]
		-- upvalues: v43 (copy), v19 (ref), v45 (copy), v20 (ref), v17 (ref), l_LocalPlayer_0 (ref), v60 (ref), v28 (ref), v35 (ref)
		local v62 = v43:TryIndex({
			"waves"
		});
		if not v62 then
			return;
		else
			v19.clear();
			debug.profilebegin("updateWaves");
			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
			local v64 = {};
			local v65 = {};
			for v66, v67 in v45 do
				local v68 = v62[v66];
				if v68 then
					if v68.despawnsAt <= l_workspace_ServerTimeNow_1 then
						local v69 = v45[v66];
						if v69 then
							v69.model:Destroy();
							v45[v66] = nil;
						end;
					else
						local v70 = v20.getWavePositionAtTime(v68, l_workspace_ServerTimeNow_1);
						local l_Transform_0 = v67.motor.Transform;
						if l_Transform_0 == CFrame.identity then
							l_Transform_0 = v70;
						end;
						v64[v66] = l_Transform_0;
						v65[v66] = v70;
						v67.motor.Transform = v70;
					end;
				end;
			end;
			debug.profileend();
			debug.profilebegin("playerKill");
			local l_v17_Character_0, v73 = v17:GetCharacter(l_LocalPlayer_0);
			if not l_v17_Character_0 or not v73 or v73.Health <= 0 then
				debug.profileend();
				return;
			else
				local l_Position_0 = l_v17_Character_0:GetPivot().Position;
				local v75 = RaycastParams.new();
				v75.FilterType = Enum.RaycastFilterType.Include;
				v75.FilterDescendantsInstances = {
					(l_v17_Character_0:FindFirstChild("HumanoidRootPart"))
				};
				v19.drawHitbox(l_Position_0);
				for v76, v77 in v62 do
					if v77.despawnsAt > l_workspace_ServerTimeNow_1 and l_workspace_ServerTimeNow_1 - v60 > 1 then
						local v78 = v45[v76];
						if v78 then
							local v79 = v64[v76];
							local v80 = v65[v76];
							if (v80.Position - l_Position_0).Magnitude < 300 then
								local l_ExtentsSize_0 = v78.model:GetExtentsSize();
								v79 = v79 + Vector3.new(0, l_ExtentsSize_0.Y * 0.5, -l_ExtentsSize_0.Z * 0.5);
								v80 = v80 + Vector3.new(0, l_ExtentsSize_0.Y * 0.5, -l_ExtentsSize_0.Z * 0.5);
								local v82, v83 = v28.getSweptAABB(v79.Position, v80.Position, l_ExtentsSize_0);
								local v84 = CFrame.new(v82) * v80.Rotation;
								v19.drawTsunami(v84, v83);
								if v28.isPointInVolume(l_Position_0, v84, v83) then
									v60 = l_workspace_ServerTimeNow_1;
									v35:FireServer();
								end;
							end;
						end;
					end;
				end;
				debug.profileend();
				return;
			end;
		end;
	end);
	v43:Observe({
		"waves"
	}, v59);
	task.spawn(v59);
end;
v40.StartSpeedHandling = function(_) --[[ Line: 212 ]] --[[ Name: StartSpeedHandling ]]
	-- upvalues: v6 (copy), l_LocalPlayer_0 (copy), l_Slowmode_0 (copy), v31 (copy), v20 (copy), l_TsunamiSpeedUpgrade_0 (copy), v29 (copy), v30 (copy), v18 (copy), v36 (copy), v27 (copy), v12 (copy)
	local v86 = v6:Wait(l_LocalPlayer_0);
	if not v86 then
		return;
	else
		local function v88() --[[ Line: 218 ]] --[[ Name: updateSlowmode ]]
			-- upvalues: l_LocalPlayer_0 (ref), l_Slowmode_0 (ref)
			local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("TsunamiSlowmode");
			l_Slowmode_0.Function.Text = l_l_LocalPlayer_0_Attribute_0 and "ON" or "OFF";
			l_Slowmode_0.Image = l_l_LocalPlayer_0_Attribute_0 and "rbxassetid://137163242046829" or "rbxassetid://117563252724415";
		end;
		l_LocalPlayer_0:GetAttributeChangedSignal("TsunamiSlowmode"):Connect(v88);
		local l_l_LocalPlayer_0_Attribute_1 = l_LocalPlayer_0:GetAttribute("TsunamiSlowmode");
		l_Slowmode_0.Function.Text = l_l_LocalPlayer_0_Attribute_1 and "ON" or "OFF";
		l_Slowmode_0.Image = l_l_LocalPlayer_0_Attribute_1 and "rbxassetid://137163242046829" or "rbxassetid://117563252724415";
		l_Slowmode_0.Visible = true;
		l_Slowmode_0.Activated:Connect(function() --[[ Line: 229 ]]
			-- upvalues: v31 (ref)
			v31:FireServer();
		end);
		l_l_LocalPlayer_0_Attribute_1 = {};
		for v90, v91 in v20.upgrades do
			local v92 = l_TsunamiSpeedUpgrade_0.Content.List.Template:Clone();
			v92.Name = tostring(v90);
			v92.LayoutOrder = v90;
			v92.Frame.Label.Text = ("+%* Speed"):format(v91);
			v92.Frame.Tip.Text = ("+%*"):format(v91);
			v92.Visible = true;
			v92.Parent = l_TsunamiSpeedUpgrade_0.Content.List;
			l_l_LocalPlayer_0_Attribute_1[v90] = v92;
			local v93 = v29.new(v92.Frame.Buy);
			v93:Animate();
			v93.OnActivated:Connect(function() --[[ Line: 247 ]]
				-- upvalues: v30 (ref), v90 (copy)
				v30:FireServer(v90);
			end);
			local v94 = v20.products[v91];
			local v95 = v29.new(v92.Frame.BuyRobux);
			v18:BindLabelToProductPrice(v92.Frame.BuyRobux.Price, v94, "Product");
			v95:Animate();
			v95.OnActivated:Connect(function() --[[ Line: 255 ]]
				-- upvalues: v36 (ref), v94 (copy)
				v36:FireServer(v94);
			end);
		end;
		local function v101() --[[ Line: 260 ]] --[[ Name: updateSpeedUpgrades ]]
			-- upvalues: v86 (copy), v20 (ref), l_l_LocalPlayer_0_Attribute_1 (copy), v27 (ref), v12 (ref)
			local v96 = v86:Get({
				"TsunamiEvent", 
				"SpeedUpgrades"
			});
			for v97, v98 in v20.upgrades do
				local v99 = l_l_LocalPlayer_0_Attribute_1[v97];
				local v100 = v20.getUpgradeCost(v96, v98);
				v99.Frame.Buy.Price.Text = ("Buy ($%*)"):format((v27:ToString(v100)));
				v99.Frame.PreviousAmount.Text = v27:Comma(v20.getTotalSpeed(v96));
				v99.Frame.TargetAmount.Text = v27:Comma(v20.getTotalSpeed(v96 + v98));
				v12.target(v99.Frame.Buy, 1, 5, {
					BackgroundColor3 = if v100 <= v86:Get("Coins") then Color3.fromRGB(81, 158, 86) else Color3.fromRGB(158, 158, 158)
				});
			end;
		end;
		v86:OnChanged({
			"TsunamiEvent", 
			"SpeedUpgrades"
		}, v101);
		v86:OnChanged("Coins", v101);
		task.spawn(v101);
		return;
	end;
end;
v40.StartVIPAreas = function(_) --[[ Line: 281 ]] --[[ Name: StartVIPAreas ]]
	-- upvalues: v6 (copy), l_LocalPlayer_0 (copy), v8 (copy), l_Players_0 (copy), v9 (copy), v36 (copy)
	local v103 = v6:Wait(l_LocalPlayer_0);
	if not v103 then
		return;
	else
		local v104 = nil;
		local function v109() --[[ Line: 288 ]] --[[ Name: updateVIPAreas ]]
			-- upvalues: v104 (ref), v103 (copy), v8 (ref), l_Players_0 (ref), l_LocalPlayer_0 (ref), v9 (ref), v36 (ref)
			if typeof(v104) == "function" then
				v104();
				v104 = nil;
			end;
			local v105 = v103:Get("Gamepass.VIP") == true;
			v104 = v8.observeTag("VIPAreas", function(v106) --[[ Line: 296 ]]
				-- upvalues: v105 (copy), l_Players_0 (ref), l_LocalPlayer_0 (ref), v9 (ref), v36 (ref)
				v106.CanCollide = not v105;
				v106.CanTouch = not v105;
				local v107 = nil;
				if not v105 then
					v107 = v106.Touched:Connect(function(v108) --[[ Line: 302 ]]
						-- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v9 (ref), v36 (ref)
						if l_Players_0:GetPlayerFromCharacter(v108.Parent) == l_LocalPlayer_0 and not v9("VIPAreaTouch", 1) then
							v36:FireServer(1652975595);
						end;
					end);
				end;
				return function() --[[ Line: 309 ]]
					-- upvalues: v106 (copy), v107 (ref)
					v106.CanCollide = true;
					v106.CanTouch = true;
					v107:Disconnect();
				end;
			end);
		end;
		v103:OnChanged("Gamepass.VIP", v109);
		v103:OnDictionaryInserted("Gamepass", v109);
		task.spawn(v109);
		return;
	end;
end;
local v110 = {};
v40.StartBrainrotRendering = function(_) --[[ Line: 329 ]] --[[ Name: StartBrainrotRendering ]]
	-- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v110 (copy), v10 (copy), v21 (copy), v24 (copy), v22 (copy), v8 (copy), v14 (copy), v27 (copy), v25 (copy), v7 (copy), v26 (copy), v11 (copy), v34 (copy), v33 (copy)
	local v112 = v5.get("TsunamiEvent/Brainrots");
	v112:WaitForLoaded();
	local l_Drop_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("ToolsFrames").Drop;
	local function v117() --[[ Line: 335 ]] --[[ Name: getDropButtonVisibility ]]
		-- upvalues: v112 (copy), l_LocalPlayer_0 (ref)
		local v114 = v112:TryIndex({
			"brainrots"
		});
		if not v114 then
			return false;
		else
			for _, v116 in v114 do
				if v116.grabbed == l_LocalPlayer_0.UserId then
					return true;
				end;
			end;
			return false;
		end;
	end;
	local function _() --[[ Line: 350 ]] --[[ Name: updateDropButtonVisibility ]]
		-- upvalues: l_Drop_0 (copy), v117 (copy)
		l_Drop_0.Visible = v117();
	end;
	local function _(v119) --[[ Line: 354 ]] --[[ Name: destroyBrainrot ]]
		-- upvalues: v110 (ref)
		local v120 = v110[v119];
		if v120 then
			v120.trove:Destroy();
			v110[v119] = nil;
		end;
	end;
	local function v153(v122) --[[ Line: 362 ]] --[[ Name: renderBrainrot ]]
		-- upvalues: v110 (ref), v112 (copy), v10 (ref), v21 (ref), v24 (ref), v22 (ref), v8 (ref), l_LocalPlayer_0 (ref), v14 (ref), v27 (ref), v25 (ref), v7 (ref), v26 (ref), v11 (ref), v34 (ref)
		if v110[v122] then
			return;
		else
			local v123 = v112:Path({
				"brainrots", 
				v122
			});
			local v124 = v10.new();
			local v125 = v124:Extend();
			local v126 = v124:Extend();
			v110[v122] = {
				trove = v124, 
				model = nil
			};
			local function v152() --[[ Line: 378 ]] --[[ Name: updateBrainrotModel ]]
				-- upvalues: v125 (copy), v112 (ref), v123 (copy), v21 (ref), v110 (ref), v122 (copy), v24 (ref), v22 (ref), v126 (copy), v8 (ref), l_LocalPlayer_0 (ref), v14 (ref), v27 (ref), v25 (ref), v7 (ref), v26 (ref), v11 (ref), v34 (ref)
				v125:Destroy();
				local v127 = v112:TryIndex(v123());
				if not v127 then
					return;
				else
					local l_v21_AnimatedModel_0 = v21:GetAnimatedModel(v127.brainrot, "Idle");
					assert(l_v21_AnimatedModel_0);
					v125:Add(l_v21_AnimatedModel_0);
					v110[v122].model = l_v21_AnimatedModel_0;
					v125:Add(function() --[[ Line: 391 ]]
						-- upvalues: v110 (ref), v122 (ref)
						if v110[v122] then
							v110[v122].model = nil;
						end;
					end);
					assert(l_v21_AnimatedModel_0.PrimaryPart, (("%* has no PrimaryPart"):format(v127)));
					local v129 = v24[v127.brainrot];
					local v130 = v22[v129.Rarity];
					local function v131() --[[ Line: 402 ]] --[[ Name: updateCFrame ]]
						-- upvalues: v127 (copy), l_v21_AnimatedModel_0 (copy)
						if v127.grabbed then
							l_v21_AnimatedModel_0:PivotTo(CFrame.new(10000, 10000, 10000));
							return;
						else
							l_v21_AnimatedModel_0:PivotTo(v127.cframe);
							return;
						end;
					end;
					v125:Add(v112:Listen(v123("cframe"), v131));
					v125:Add(v112:Listen(v123("grabbed"), v131));
					v125:Add(task.defer(v131));
					l_v21_AnimatedModel_0.PrimaryPart.Anchored = true;
					local function v135() --[[ Line: 416 ]] --[[ Name: updateTag ]]
						-- upvalues: v126 (ref), v112 (ref), v123 (ref), v127 (copy), v8 (ref), l_v21_AnimatedModel_0 (copy), l_LocalPlayer_0 (ref)
						v126:Clean();
						local v132 = v112:TryIndex(v123({
							"grabbed"
						}));
						if v132 then
							return;
						elseif not v112:TryIndex(v123({
							"tag"
							})) then
							return;
						else
							local v133 = v126:Clone(script.BillboardGui);
							v133.TextLabel.Text = v127.brainrot;
							if v132 then
								v126:Add(v8.observeTag("Held_" .. v132, function(v134) --[[ Line: 433 ]]
									-- upvalues: v133 (copy)
									v133.Adornee = v134;
									return function() --[[ Line: 435 ]]
										-- upvalues: v133 (ref), v134 (copy)
										if v133.Adornee == v134 then
											v133.Adornee = nil;
										end;
									end;
								end));
							else
								v133.Adornee = l_v21_AnimatedModel_0.PrimaryPart;
							end;
							v133.Parent = l_LocalPlayer_0.PlayerGui;
							return;
						end;
					end;
					if v127.traits then
						v21:ApplyTraits(l_v21_AnimatedModel_0, v127.brainrot, v127.traits);
					end;
					if v127.mutation then
						v21:ApplyMutation(l_v21_AnimatedModel_0, v127.brainrot, v127.mutation);
					end;
					local l_l_v21_AnimatedModel_0_FirstChild_0 = l_v21_AnimatedModel_0:FindFirstChild("OVERHEAD_ATTACHMENT", true);
					if not l_l_v21_AnimatedModel_0_FirstChild_0 then
						local l_Attachment_0 = Instance.new("Attachment");
						local l_l_v21_AnimatedModel_0_ExtentsSize_0 = l_v21_AnimatedModel_0:GetExtentsSize();
						l_Attachment_0.CFrame = CFrame.new(0, l_l_v21_AnimatedModel_0_ExtentsSize_0.Y * 0.5, 0);
						l_Attachment_0.Parent = l_v21_AnimatedModel_0.PrimaryPart;
						l_l_v21_AnimatedModel_0_FirstChild_0 = l_Attachment_0;
					end;
					local v139, v140 = v14.createFastOverhead({
						adornee = l_l_v21_AnimatedModel_0_FirstChild_0, 
						guiTemplate = v14.GuiTemplates.AnimalOverhead
					});
					v125:Add(v140);
					v125:Add(v112:Observe(v123({
						"tag"
					}), v135));
					v125:Add(v112:Observe(v123({
						"grabbed"
					}), v135));
					local l_Generation_0 = v139.Generation;
					local l_Stolen_0 = v139.Stolen;
					l_Stolen_0.Visible = true;
					l_Stolen_0.LayoutOrder = -1;
					l_Stolen_0.Size = UDim2.fromScale(1, 0.25);
					local function v143() --[[ Line: 481 ]] --[[ Name: updateOverhead ]]
						-- upvalues: l_Generation_0 (copy), v27 (ref), v21 (ref), v127 (copy), l_Stolen_0 (copy)
						l_Generation_0.Text = ("$%*/s"):format((v27:ToString(v21:GetGeneration(v127.brainrot, v127.mutation, v127.traits, nil))));
						l_Stolen_0.Text = ("%*s"):format(v127.timer);
					end;
					v139.DisplayName.Text = v129.DisplayName;
					v139.Price.Text = ("$%*"):format((v27:ToString(v21:GetPrice(v127.brainrot))));
					v139.Rarity.Text = v129.Rarity;
					v139.Rarity.TextColor3 = v22[v129.Rarity].Color;
					if v127.mutation then
						local v144 = v25[v127.mutation];
						v139.Mutation.Text = v144.DisplayText;
						if v144.GradientPreset then
							v125:Add(v7.apply(v139.Mutation, v144.GradientPreset));
						else
							v139.Mutation.TextColor3 = v144.MainColor;
						end;
					end;
					if v127.traits then
						local l_Template_0 = v139.Traits.Template;
						for _, v147 in v127.traits do
							local v148 = v26[v147];
							if v148 then
								local v149 = l_Template_0:Clone();
								v149.Parent = l_Template_0.Parent;
								v149.Image = v148.Icon;
								v149.Visible = true;
							end;
						end;
						v139.Traits.Visible = true;
					end;
					task.spawn(v143);
					v125:Add(v11.Simple(1, v143));
					v125:Add(v112:Listen(v123("timer"), v143));
					v139.Mutation.Visible = v127.mutation ~= nil;
					if v22[v129.Rarity].StrokeColor then
						v139.Rarity.UIStroke.Color = v22[v129.Rarity].StrokeColor;
					end;
					if v130.GradientPreset then
						v125:Add(v7.apply(v139.Rarity, v130.GradientPreset));
					end;
					v139.Parent = l_l_v21_AnimatedModel_0_FirstChild_0;
					local v150 = v125:Add(Instance.new("ProximityPrompt"));
					v150.ActionText = "Grab";
					v150.ObjectText = v127.brainrot;
					v150.HoldDuration = 2;
					v150.RequiresLineOfSight = false;
					v150.MaxActivationDistance = 10;
					v150.Parent = l_v21_AnimatedModel_0.PrimaryPart;
					v125:Add(v150.Triggered:Connect(function(v151) --[[ Line: 540 ]]
						-- upvalues: v34 (ref), v122 (ref)
						if not v151.Character then
							return;
						else
							v34:FireServer(v122);
							return;
						end;
					end));
					return;
				end;
			end;
			v124:Add(v112:Listen(v123("mutation"), function() --[[ Line: 549 ]]
				-- upvalues: v152 (copy)
				v152();
			end));
			v124:Add(v112:Listen(v123("traits"), function() --[[ Line: 553 ]]
				-- upvalues: v152 (copy)
				v152();
			end));
			v124:Add(task.spawn(v152));
			return v124;
		end;
	end;
	v112:Observe({
		"brainrots"
	}, function(v154, v155) --[[ Line: 562 ]]
		-- upvalues: l_Drop_0 (copy), v117 (copy), v110 (ref), v153 (copy)
		l_Drop_0.Visible = v117();
		if v154 == nil then
			for v156 in v110 do
				local v157 = v110[v156];
				if v157 then
					v157.trove:Destroy();
					v110[v156] = nil;
				end;
			end;
			return;
		else
			for v158 in v154 do
				if not v110[v158] then
					v153(v158);
				end;
			end;
			if v155 ~= nil then
				for v159 in v110 do
					if not v154[v159] then
						local v160 = v110[v159];
						if v160 then
							v160.trove:Destroy();
							v110[v159] = nil;
						end;
					end;
				end;
			end;
			return;
		end;
	end);
	l_Drop_0.Activate.Activated:Connect(function() --[[ Line: 590 ]]
		-- upvalues: v33 (ref)
		v33:FireServer();
	end);
end;
v40.GetBrainrot = function(_, v162) --[[ Line: 595 ]] --[[ Name: GetBrainrot ]]
	-- upvalues: v5 (copy)
	return v5.get("TsunamiEvent/Brainrots"):TryIndex({
		"brainrots", 
		v162
	});
end;
v40.GetBrainrotCFrame = function(_, v164, v165) --[[ Line: 600 ]] --[[ Name: GetBrainrotCFrame ]]
	-- upvalues: v40 (copy), v110 (copy), l_CollectionService_0 (copy)
	local l_v40_Brainrot_0 = v40:GetBrainrot(v164);
	if not l_v40_Brainrot_0 then
		return nil, nil;
	elseif not v110[v164] then
		return nil, nil;
	else
		local l_model_0 = v110[v164].model;
		if not l_model_0 then
			return nil, nil;
		elseif not v165 then
			local v168 = l_v40_Brainrot_0.grabbed and l_CollectionService_0:GetTags((("Held_%*"):format(l_v40_Brainrot_0.grabbed)))[1];
			if not v168 then
				return l_v40_Brainrot_0.cframe, l_model_0;
			else
				local _ = nil;
				return (if v168.PrimaryPart then v168.PrimaryPart.CFrame else v168:GetPivot()) + Vector3.new(0, v168:GetExtentsSize().Y * 0.5, 0), l_model_0;
			end;
		else
			return l_v40_Brainrot_0.cframe, l_model_0;
		end;
	end;
end;
v40.StartNormalServer = function(_) --[[ Line: 634 ]] --[[ Name: StartNormalServer ]]
	-- upvalues: l_Slowmode_0 (copy), v8 (copy), v10 (copy), v15 (copy), v32 (copy), l_ReplicatedStorage_0 (copy)
	l_Slowmode_0.Visible = false;
	v8.observeTag("TsunamiLTMMachine", function(v171) --[[ Line: 637 ]]
		-- upvalues: v10 (ref), v15 (ref), v32 (ref), l_ReplicatedStorage_0 (ref)
		local v172 = v10.new();
		v172:Add(v171.Prompt.ProximityPrompt.Triggered:Connect(function() --[[ Line: 640 ]]
			-- upvalues: v15 (ref), v32 (ref)
			if v15:IsInPrompt() then
				return;
			elseif not v15:Show("Are you sure you want to join the <font color=\"rgb(255, 53, 56)\">Escape Tsunami LTM</font>?", 300, "JoinCancel") then
				return;
			else
				v32:FireServer();
				return;
			end;
		end));
		local l_Arcadopus_0 = l_ReplicatedStorage_0.Animations.Animals:FindFirstChild("Arcadopus");
		if l_Arcadopus_0 then
			local v174 = v171.Arcadopus.AnimationController.Animator:LoadAnimation(l_Arcadopus_0.Idle);
			v174.Looped = true;
			v174:Play();
		end;
		return v172:WrapClean();
	end);
end;
v40.Start = function(_) --[[ Line: 664 ]] --[[ Name: Start ]]
	-- upvalues: v23 (copy), v40 (copy), v41 (ref), v16 (copy), l_TsunamiSpeedUpgrade_0 (copy), v6 (copy), l_LocalPlayer_0 (copy)
	if not v23.IsTsunamiServer() then
		v40:StartNormalServer();
		return;
	else
		v41 = v16:Register("TsunamiSpeedUpgrade", l_TsunamiSpeedUpgrade_0, "TopQuint");
		v41:AttachCloseButton(l_TsunamiSpeedUpgrade_0.Header.Close);
		v41:Close();
		if not v6:Wait(l_LocalPlayer_0) then
			return;
		else
			task.spawn(v40.StartSpeedHandling, v40);
			task.spawn(v40.StartVIPAreas, v40);
			task.spawn(v40.StartWaves, v40);
			task.spawn(v40.StartBrainrotRendering, v40);
			return;
		end;
	end;
end;
return v40;