-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v11 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v13 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v14 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local _ = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v16 = require(l_ReplicatedStorage_0.Packages.Observers);
local v17 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v18 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v19 = require(l_ReplicatedStorage_0.Packages.Trove);
local v20 = require(l_ReplicatedStorage_0.Packages.Net);
local v21 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v23 = v20:RemoteEvent("EventService/St Patricks/DestroyGoldCoin");
local v24 = v20:RemoteEvent("EventService/St Patricks/SpawnGoldCoin");
local v25 = v20:RemoteEvent("EventService/St Patricks/ClaimGoldCoin");
local v26 = v20:RemoteEvent("EventService/St Patricks/Hit");
local v27 = v19.new();
local v28 = RaycastParams.new();
v28.FilterType = Enum.RaycastFilterType.Include;
v28.FilterDescendantsInstances = {
	workspace.Map
};
v7.OnStart = function(_) --[[ Line: 41 ]] --[[ Name: OnStart ]]
	-- upvalues: v12 (copy), l_Name_0 (copy), l_ReplicatedStorage_0 (copy), v27 (copy), v17 (copy), v10 (copy), v16 (copy), v13 (copy), v11 (copy), v21 (copy)
	assert((v12:GetActiveEventData(l_Name_0)));
	l_ReplicatedStorage_0:SetAttribute("StPatricksEvent", true);
	v27:Add(function() --[[ Line: 46 ]]
		-- upvalues: l_ReplicatedStorage_0 (ref)
		l_ReplicatedStorage_0:SetAttribute("StPatricksEvent", nil);
	end);
	(if v17.IsTsunamiServer() then v27:Clone(script.MapTsunami) else if v17.IsBiggerServer() then v27:Clone(script.MapBigger) else v27:Clone(script.Map)).Parent = workspace;
	v10:Activate("Blink");
	v27:Add(function() --[[ Line: 57 ]]
		-- upvalues: v10 (ref)
		v10:Activate("Blink");
	end);
	v27:Add(v16.observeTag("HideInStPatricks", function(v30) --[[ Line: 61 ]]
		local l_Parent_0 = v30.Parent;
		v30.Parent = script;
		return function() --[[ Line: 64 ]]
			-- upvalues: v30 (copy), l_Parent_0 (copy)
			pcall(function() --[[ Line: 65 ]]
				-- upvalues: v30 (ref), l_Parent_0 (ref)
				v30.Parent = l_Parent_0;
			end);
		end;
	end, {
		workspace, 
		script
	}));
	v13:Update();
	v11:UpdateOST();
	v11:UpdateAmbience();
	v10:Run("StPatricksEvent", "GrassRecolor");
	v27:Add(function() --[[ Line: 76 ]]
		-- upvalues: v10 (ref)
		v10:Stop("StPatricksEvent", "GrassRecolor");
	end);
	v10:Run("StPatricksEvent", "WallRecolor");
	v27:Add(function() --[[ Line: 81 ]]
		-- upvalues: v10 (ref)
		v10:Stop("StPatricksEvent", "WallRecolor");
	end);
	v10:Run("StPatricksEvent", "WallBottomRecolor");
	v27:Add(function() --[[ Line: 86 ]]
		-- upvalues: v10 (ref)
		v10:Stop("StPatricksEvent", "WallBottomRecolor");
	end);
	local l_StPatricksPot_0 = workspace.StPatricksPot;
	v27:Add(task.spawn(function() --[[ Line: 91 ]]
		-- upvalues: v21 (ref), l_StPatricksPot_0 (copy)
		v21.emit(l_StPatricksPot_0.RainbowEmit);
	end));
	v27:Add(task.spawn(function() --[[ Line: 95 ]]
		-- upvalues: v11 (ref), l_StPatricksPot_0 (copy)
		v11:PlaySound("Sounds.Sfx.RainbowActivatedEffect", l_StPatricksPot_0.Rainbow.SoundParts.RainbowActivatedEffect.Position);
	end));
	v27:Add(task.spawn(function() --[[ Line: 99 ]]
		-- upvalues: v11 (ref), l_StPatricksPot_0 (copy)
		v11:PlaySound("Sounds.Sfx.RainbowMachineEnabled", l_StPatricksPot_0.Rainbow.SoundParts.RainbowMachineEnabled.Position);
	end));
	v27:Add(v16.observeTag("StPatricksRainbowEventAttachment", function(v33) --[[ Line: 103 ]]
		local v34 = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1), 
			NumberSequenceKeypoint.new(1, 1)
		});
		local l_v33_Children_0 = v33:GetChildren();
		for _, v37 in l_v33_Children_0 do
			v37.Transparency = v34;
			v37.Enabled = true;
		end;
		local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
		while v33:IsDescendantOf(workspace) do
			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
			local v40 = (l_workspace_ServerTimeNow_1 - l_workspace_ServerTimeNow_0) % 3.5 / 3.5;
			v34 = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1), 
				NumberSequenceKeypoint.new(1 - v40, 1), 
				NumberSequenceKeypoint.new(1, 0)
			});
			if l_workspace_ServerTimeNow_1 - l_workspace_ServerTimeNow_0 >= 3.5 then
				for _, v42 in l_v33_Children_0 do
					v42.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0), 
						NumberSequenceKeypoint.new(1, 0)
					});
				end;
				break;
			else
				for _, v44 in l_v33_Children_0 do
					v44.Transparency = v34;
				end;
				task.wait();
			end;
		end;
		return nil;
	end, {
		workspace
	}));
	v27:Add(v16.observeChildren(l_StPatricksPot_0.Rainbow.Enabled, function(v45) --[[ Line: 147 ]]
		-- upvalues: v21 (ref)
		v21.enable(v45);
		return function() --[[ Line: 150 ]]
			-- upvalues: v21 (ref), v45 (copy)
			v21.disable(v45);
		end;
	end));
end;
v7.OnStop = function(_) --[[ Line: 156 ]] --[[ Name: OnStop ]]
	-- upvalues: v27 (copy)
	v27:Destroy();
end;
v7.OnLoad = function(_) --[[ Line: 160 ]] --[[ Name: OnLoad ]]
	-- upvalues: v26 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), l_TweenService_0 (copy), l_Players_0 (copy), v14 (copy), v25 (copy), v27 (copy), l_RunService_0 (copy), v18 (copy), v11 (copy), v24 (copy), v28 (copy), v21 (copy), v23 (copy)
	v26.OnClientEvent:Connect(function(v48) --[[ Line: 161 ]]
		-- upvalues: v8 (ref), l_ReplicatedStorage_0 (ref)
		v8.playBurst(script.Burst, v48, {
			l_ReplicatedStorage_0.Sounds.Events["St Patricks"].Hit
		});
	end);
	local v49 = {};
	local function v55(v50, v51) --[[ Line: 167 ]] --[[ Name: playCharacterAnimation ]]
		-- upvalues: l_TweenService_0 (ref)
		local l_Character_0 = v50.Character;
		if not l_Character_0 then
			return;
		else
			local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
			if not l_HumanoidRootPart_0 then
				return;
			else
				local v54 = script.Reward:Clone();
				v54.CurrencyGoldCoins.Text = ("+%*"):format(v51);
				v54.Parent = l_HumanoidRootPart_0;
				l_TweenService_0:Create(v54, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					StudsOffset = Vector3.new(0, 2.5, 2.200000047683716, 0)
				}):Play();
				l_TweenService_0:Create(v54.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					ImageTransparency = 1
				}):Play();
				l_TweenService_0:Create(v54.CurrencyGoldCoins, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					TextTransparency = 1
				}):Play();
				l_TweenService_0:Create(v54.CurrencyGoldCoins.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					Transparency = 1
				}):Play();
				task.delay(5, function() --[[ Line: 198 ]]
					-- upvalues: v54 (copy)
					v54:Destroy();
				end);
				return;
			end;
		end;
	end;
	local function v61(v56) --[[ Line: 203 ]] --[[ Name: playScreenGoldAnimation ]]
		-- upvalues: l_Players_0 (ref), v14 (ref)
		local v57 = Random.new();
		for _ = 1, math.min(v56, 30) do
			local v59 = script.Image:Clone();
			v59.Position = UDim2.fromScale(v57:NextNumber(-0.25, 1.25), -(0.25 - v57:NextNumber(0, 0.125)));
			v59.Rotation = v57:NextNumber(-120, 120);
			local v60 = v57:NextNumber(0.15, 0.2);
			v59.Size = UDim2.fromScale(v60, v60);
			v59.Parent = l_Players_0.LocalPlayer.PlayerGui:FindFirstChild("Effects");
			v14(v59, TweenInfo.new(v57:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = v59.Position + UDim2.fromScale(0, 1.5), 
				Rotation = v59.Rotation + v57:NextInteger(-3, 3) * 10
			}, true).Completed:Once(function() --[[ Line: 223 ]]
				-- upvalues: v59 (copy)
				task.wait(1);
				v59:Destroy();
			end);
		end;
	end;
	v25.OnClientEvent:Connect(function(v62, v63, v64) --[[ Line: 230 ]]
		-- upvalues: v49 (copy), v27 (ref), l_RunService_0 (ref), l_TweenService_0 (ref), v18 (ref), v11 (ref), l_ReplicatedStorage_0 (ref), l_Players_0 (ref), v61 (copy), v55 (copy)
		local v65 = v49[v62];
		if not v65 then
			return;
		else
			local v66 = v65:Clone();
			v65:Destroy();
			v66.Parent = workspace;
			local l_Position_0 = v66:GetPivot().Position;
			local v68 = 0;
			local l_Size_0 = v66.Size;
			local v70 = nil;
			v70 = v27:Add(l_RunService_0.PostSimulation:Connect(function(v71) --[[ Line: 249 ]]
				-- upvalues: v68 (ref), v63 (copy), l_Position_0 (copy), l_TweenService_0 (ref), v66 (copy), v18 (ref), l_Size_0 (copy), v70 (ref), v27 (ref), v11 (ref), l_ReplicatedStorage_0 (ref), l_Players_0 (ref), v61 (ref), v64 (copy), v55 (ref)
				debug.profilebegin("St Patricks:UpdateCandyAnimation");
				v68 = v68 + v71;
				local v72 = v63.Character and v63.Character:GetPivot().Position or Vector3.new(0, 0, 0, 0);
				local v73 = l_Position_0 + (v72 - l_Position_0) * 0.25 + Vector3.new(0, 10, 0, 0);
				local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v68 / 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
				v66:PivotTo(CFrame.new(v18.quadBezier(l_l_TweenService_0_Value_0, l_Position_0, v73, v72)) * v66:GetPivot().Rotation);
				v66.Size = l_Size_0 * 0.5 + l_Size_0 * 0.5 * (1 - l_l_TweenService_0_Value_0);
				if l_l_TweenService_0_Value_0 >= 1 and v70 then
					v27:Remove(v70);
					v70 = nil;
					v66:Destroy();
					task.spawn(function() --[[ Line: 266 ]]
						-- upvalues: v11 (ref), l_ReplicatedStorage_0 (ref), v72 (copy)
						v11:PlaySound(l_ReplicatedStorage_0.Sounds.Events["St Patricks"].CoinPickup, v72);
					end);
					if v63 == l_Players_0.LocalPlayer then
						v61(v64);
					end;
					v55(v63, v64);
				end;
				debug.profileend();
			end));
			return;
		end;
	end);
	v24.OnClientEvent:Connect(function(v75, v76, v77, v78, v79) --[[ Line: 280 ]]
		-- upvalues: v49 (copy), v28 (ref), v11 (ref), l_ReplicatedStorage_0 (ref), v21 (ref), v18 (ref), l_RunService_0 (ref), l_TweenService_0 (ref), v25 (ref)
		local v80 = script.Drop:Clone();
		v80.Name = v75;
		v49[v75] = v80;
		local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
		l_ProximityPrompt_0.Name = "ProximityPrompt";
		l_ProximityPrompt_0.ActionText = "";
		l_ProximityPrompt_0.RequiresLineOfSight = false;
		l_ProximityPrompt_0.Enabled = false;
		l_ProximityPrompt_0.Style = Enum.ProximityPromptStyle.Custom;
		l_ProximityPrompt_0:SetAttribute("CustomStyleDisabled", true);
		l_ProximityPrompt_0.Parent = v80;
		local v82 = workspace:Raycast(v77 + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -30, -0, -0), v28);
		v77 = v82 and v82.Position or v77;
		local l_StPatricksPot_1 = workspace:FindFirstChild("StPatricksPot");
		local v84 = l_StPatricksPot_1 and l_StPatricksPot_1:FindFirstChild("Pot");
		local v85 = v84 and v84:FindFirstChild("RootPart");
		local v86 = v84 and v84:FindFirstChild("AnimationController");
		local v87 = v86 and v86:FindFirstChild("Animator");
		local l_Animation_0 = v84:FindFirstChild("Animation");
		local v89 = v85 and v85.Bone;
		local v90 = nil;
		if v87 then
			v90 = v87:LoadAnimation(l_Animation_0);
			v90.Looped = false;
			v90:Play();
		end;
		task.wait(0.25);
		local v91 = if v89 then v89.WorldPosition + Vector3.new(0, 2, 0, 0) else v76;
		local v92 = v91 + Vector3.new(0, 10, 0, 0);
		local l_v77_0 = v77;
		local v94 = v92 + (l_v77_0 - v92) * 0.5;
		if v89 then
			v94 = v94 + Vector3.new(0, math.clamp((v77 - v91).Magnitude, 25, 1000), 0);
		end;
		task.spawn(function() --[[ Line: 323 ]]
			-- upvalues: v11 (ref), l_ReplicatedStorage_0 (ref), v91 (copy), v21 (ref), v89 (copy)
			v11:PlaySound(l_ReplicatedStorage_0.Sounds.Events["St Patricks"].CoinSpawn, v91, false);
			v21.emit(v89.emit);
		end);
		local v95 = math.random(0, 10000);
		local v96 = false;
		local v97 = 0;
		local l_v91_0 = v91;
		local v99 = 0;
		local v100 = {
			0
		};
		for v101 = 1, 20 do
			local v102 = v18.cubicBezier(v101 / 20, v91, v92, v94, l_v77_0);
			v99 = v99 + vector.magnitude(v102 - l_v91_0);
			v100[v101 + 1] = v99;
			l_v91_0 = v102;
		end;
		local v103 = false;
		local v104 = (l_v77_0 - v91) * Vector3.new(1, 0, 1, 0);
		local v121 = l_RunService_0.PostSimulation:Connect(function(_) --[[ Line: 349 ]]
			-- upvalues: v78 (copy), v79 (copy), l_TweenService_0 (ref), v99 (ref), l_v77_0 (copy), v100 (copy), v18 (ref), v91 (copy), v92 (copy), v94 (ref), v95 (copy), v103 (ref), v80 (copy), v104 (copy), l_ProximityPrompt_0 (copy), v96 (ref), v97 (ref), v25 (ref), v75 (copy)
			local v106 = workspace:GetServerTimeNow() - (v78 + 0.25);
			local v107 = v79 == 0 and 1 or math.clamp(v106 / v79, 0, 1);
			local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v107, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			local v109 = l_l_TweenService_0_Value_1 * v99;
			local l_l_v77_0_0 = l_v77_0;
			for v111 = 1, #v100 do
				local v112 = v100[v111];
				if v109 <= v112 then
					local v113 = v100[v111 - 1];
					local v114 = (v109 - v113) / (v112 - v113);
					local v115 = (v111 - 2 + v114) / 20;
					l_l_v77_0_0 = v18.cubicBezier(v115, v91, v92, v94, l_v77_0);
					break;
				end;
			end;
			local v116 = os.clock() + v95;
			if not v103 then
				v103 = true;
				v80.Parent = workspace;
			end;
			local v117 = l_l_TweenService_0_Value_1 * l_l_TweenService_0_Value_1 * (3 - 2 * l_l_TweenService_0_Value_1);
			local v118 = l_l_v77_0_0 + Vector3.new(0, math.sin(v116 * 4) * 0.5 + 4, 0);
			local v119 = CFrame.lookAlong(v118, v104) * CFrame.Angles(-v117 * 4 * 3.141592653589793, math.max(v106 - v79 + 2, 0) * 0.7853981633974483, 0);
			v80:PivotTo(v119);
			if l_l_TweenService_0_Value_1 >= 1 then
				l_ProximityPrompt_0.Enabled = true;
				local v120 = os.clock();
				if v96 and v120 - v97 > 0.2 then
					v97 = v120;
					v25:FireServer(v75);
				end;
			end;
		end);
		v80.Destroying:Connect(function() --[[ Line: 395 ]]
			-- upvalues: v121 (copy), v90 (ref)
			v121:Disconnect();
			if v90 then
				v90:Stop();
				v90:Destroy();
			end;
		end);
		l_ProximityPrompt_0.PromptShown:Connect(function() --[[ Line: 404 ]]
			-- upvalues: v96 (ref)
			v96 = true;
		end);
		l_ProximityPrompt_0.PromptHidden:Connect(function() --[[ Line: 408 ]]
			-- upvalues: v96 (ref)
			v96 = false;
		end);
	end);
	v23.OnClientEvent:Connect(function(v122) --[[ Line: 413 ]]
		-- upvalues: v49 (copy)
		local v123 = v49[v122];
		if not v123 then
			return;
		else
			v123:Destroy();
			v49[v122] = nil;
			return;
		end;
	end);
end;
return v7;