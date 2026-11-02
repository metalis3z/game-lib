local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Controllers.TsunamiEventController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CameraController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v13 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v14 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v15 = require(l_ReplicatedStorage_0.Controllers.EventController);
local _ = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v17 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v19 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v20 = require(l_ReplicatedStorage_0.Packages.Signal);
local v21 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v22 = require(l_ReplicatedStorage_0.Packages.Trove);
local v23 = require(l_ReplicatedStorage_0.Packages.Net);
local v24 = require(l_ReplicatedStorage_0.Shared.VFX);
local v25 = v23:RemoteEvent("EventService/Crab Rave/Hit");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CrabRave_0 = workspace.Sounds.CrabRave;
local l_Name_0 = script.Name;
local v29 = v22.new();
v7.OnStart = function(_) --[[ Line: 43 ]] --[[ Name: OnStart ]]
	-- upvalues: v15 (copy), l_Name_0 (copy), l_ReplicatedStorage_0 (copy), v29 (copy), v14 (copy), v13 (copy), l_CrabRave_0 (copy), v19 (copy), l_TweenService_0 (copy), v24 (copy), v12 (copy), v17 (copy), v22 (copy), v21 (copy), l_RunService_0 (copy), v10 (copy), v20 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy)
	local l_v15_ActiveEventData_0 = v15:GetActiveEventData(l_Name_0);
	assert(l_v15_ActiveEventData_0);
	l_ReplicatedStorage_0:SetAttribute("CrabRave", true);
	v29:Add(function() --[[ Line: 48 ]]
		-- upvalues: l_ReplicatedStorage_0 (ref), v14 (ref), v13 (ref)
		l_ReplicatedStorage_0:SetAttribute("CrabRave", nil);
		v14:Update();
		v13:UpdateOST();
	end);
	v29:Add(task.spawn(function() --[[ Line: 55 ]]
		-- upvalues: l_CrabRave_0 (ref), l_v15_ActiveEventData_0 (copy)
		while not l_CrabRave_0.IsLoaded do
			task.wait();
		end;
		l_CrabRave_0.TimePosition = math.max(l_CrabRave_0.TimePosition, workspace:GetServerTimeNow() - l_v15_ActiveEventData_0.startedAt);
	end));
	v14:Update();
	v13:UpdateOST();
	local v32 = v19.IsTsunamiServer();
	local v33 = v29:Add(Instance.new("ColorCorrectionEffect"));
	v33.Parent = workspace.CurrentCamera;
	local function _(v34, v35) --[[ Line: 71 ]] --[[ Name: getTimeLeftForSync ]]
		-- upvalues: l_v15_ActiveEventData_0 (copy)
		return l_v15_ActiveEventData_0.startedAt + v34 - (v35 or workspace:GetServerTimeNow());
	end;
	local v37 = nil;
	local v38 = if v19.IsBiggerServer() then v29:Clone(script.OceanBigger) else v29:Clone(script.Ocean);
	local v39 = v19.IsBiggerServer() and 902 or 400;
	local v40 = 45;
	if v32 then
		local l_Areas_0 = workspace.Map:FindFirstChild("Areas");
		local v42 = l_Areas_0 and l_Areas_0:FindFirstChild("1");
		if v42 then
			local l_v42_Pivot_0 = v42:GetPivot();
			local v44 = l_v42_Pivot_0.Position.X + v42.Size.X / 2;
			v38:PivotTo(CFrame.new(v44, l_v42_Pivot_0.Position.Y + 0.2, l_v42_Pivot_0.Position.Z) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966));
			v39 = v42.Size.X;
			v40 = 45 * (v42.Size.X / 400);
			local l_Z_0 = v42.Size.Z;
			for _, v47 in v38:GetDescendants() do
				if v47:IsA("Beam") then
					v47.Width0 = l_Z_0;
					v47.Width1 = l_Z_0;
				end;
			end;
		end;
	end;
	v38.Parent = workspace;
	local l_ocean_0 = v38:FindFirstChild("ocean");
	local l_att1_0 = v38:FindFirstChild("att1");
	v37 = v38:FindFirstChild("oceanparticles");
	for _, v51 in v38:GetChildren() do
		if v51:IsA("Beam") then
			local l_TextureLength_0 = v51.TextureLength;
			v51.TextureLength = 0;
			if l_ocean_0 then
				l_TweenService_0:Create(l_ocean_0, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + v40 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
					TextureLength = l_TextureLength_0
				}):Play();
			end;
		end;
	end;
	if l_att1_0 then
		l_TweenService_0:Create(l_att1_0, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + v40 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			Position = Vector3.new(0, 0, v39)
		}):Play();
	end;
	local v53 = v29:Add(Instance.new("Highlight"));
	assert(v53);
	v53.DepthMode = Enum.HighlightDepthMode.Occluded;
	v53.FillColor = Color3.new(1, 1, 1);
	v53.FillTransparency = 1;
	v53.OutlineTransparency = 1;
	l_TweenService_0:Create(v33, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + 1.95 - workspace:GetServerTimeNow()), {
		Brightness = -1.2
	}):Play();
	if v37 then
		v29:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 45 - workspace:GetServerTimeNow(), function() --[[ Line: 152 ]]
			-- upvalues: v24 (ref), v37 (ref)
			v24.enable(v37);
		end));
	end;
	v12:Run("CrabRaveEvent", "GrassRecolor");
	v29:Add(function() --[[ Line: 158 ]]
		-- upvalues: v12 (ref)
		v12:Stop("CrabRaveEvent", "GrassRecolor");
	end);
	v29:Add(function() --[[ Line: 162 ]]
		-- upvalues: v12 (ref)
		v12:Activate("Blink");
	end);
	v29:Add(v17.observeTag("CrabRaveCrabFolder", function(v54) --[[ Line: 166 ]]
		-- upvalues: v53 (ref)
		if v53 then
			v53.Parent = v54;
		end;
		return nil;
	end));
	v29:Add(v17.observeTag("CrabRaveCrabs", function(v55) --[[ Line: 173 ]]
		-- upvalues: v22 (ref), l_v15_ActiveEventData_0 (copy), v21 (ref), v19 (ref), l_RunService_0 (ref)
		local v56 = v22.new();
		local l_Name_1 = v55.Parent.Name;
		local v58 = v56:Clone(script.Crab);
		local v59 = nil;
		local v60 = nil;
		local function _(v61) --[[ Line: 183 ]] --[[ Name: loadAnimation ]]
			-- upvalues: v58 (copy), v56 (copy)
			local v62 = v58.AnimationController:LoadAnimation(v61);
			v56:Add(function() --[[ Line: 185 ]]
				-- upvalues: v62 (copy)
				v62:Stop(0);
				v62:Destroy();
			end);
			return v62;
		end;
		v58["Cylinder.005"].Transparency = 1;
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 2 - workspace:GetServerTimeNow(), function() --[[ Line: 194 ]]
			-- upvalues: v58 (copy)
			v58["Cylinder.005"].Transparency = 0;
		end));
		local v64 = v56:Add(Instance.new("Weld"));
		v64.Part0 = v58["Cylinder.005"];
		v64.Part1 = v55.HumanoidRootPart;
		v64.C1 = CFrame.new(0, 3.6, 0);
		v64.Parent = v58;
		if v21:GetInstant("Optimisation.HumanoidBrainrotModels", v19.IsNewPlayersServer()) then
			local l_AnimationController_0 = v55:FindFirstChild("AnimationController");
			if l_AnimationController_0 then
				l_AnimationController_0:Destroy();
			end;
			local v66 = Instance.new("Humanoid", v55);
			local _ = Instance.new("Animator", v66);
			v66.Name = "AnimationController";
			v66.EvaluateStateMachine = false;
			v66.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
			v66.PlatformStand = true;
			v66.Parent = v55;
		end;
		local v68 = 0;
		local v69 = 0;
		local v70 = CFrame.new(0, 3.6, 0);
		v56:Add(l_RunService_0.PostSimulation:Connect(function(v71) --[[ Line: 224 ]]
			-- upvalues: v69 (ref), v68 (ref), v64 (copy), v70 (copy)
			debug.profilebegin("Crab Rave:Crab:Rotate");
			if math.abs(v69 - v68) < 0.1 then
				return;
			else
				v68 = v69 + (v68 - v69) * math.exp(v71 * -1);
				v64.C1 = v70 * CFrame.Angles(0, v68, 0);
				debug.profileend();
				return;
			end;
		end));
		v58.Parent = v55;
		local l_Animation1_0 = script.Animation1;
		local v73 = v58.AnimationController:LoadAnimation(l_Animation1_0);
		local l_v73_0 = v73 --[[ copy: 13 -> 26 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v73_0 (copy)
			l_v73_0:Stop(0);
			l_v73_0:Destroy();
		end);
		local l_v73_1 = v73;
		v73 = script.Animation2;
		local v76 = v58.AnimationController:LoadAnimation(v73);
		local l_v76_0 = v76 --[[ copy: 14 -> 27 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v76_0 (copy)
			l_v76_0:Stop(0);
			l_v76_0:Destroy();
		end);
		l_Animation1_0 = v76;
		v76 = script.Animation3_Right;
		local v78 = v58.AnimationController:LoadAnimation(v76);
		local l_v78_0 = v78 --[[ copy: 15 -> 28 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v78_0 (copy)
			l_v78_0:Stop(0);
			l_v78_0:Destroy();
		end);
		v73 = v78;
		v78 = script.Animation3_Left;
		local v80 = v58.AnimationController:LoadAnimation(v78);
		local l_v80_0 = v80 --[[ copy: 16 -> 29 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v80_0 (copy)
			l_v80_0:Stop(0);
			l_v80_0:Destroy();
		end);
		v76 = v80;
		v76.Priority = Enum.AnimationPriority.Action;
		v80 = script.Animation4_Walk;
		local v82 = v58.AnimationController:LoadAnimation(v80);
		local l_v82_0 = v82 --[[ copy: 17 -> 30 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v82_0 (copy)
			l_v82_0:Stop(0);
			l_v82_0:Destroy();
		end);
		v78 = v82;
		v78.Priority = Enum.AnimationPriority.Action;
		v82 = script.Animation4_Attack;
		local v84 = v58.AnimationController:LoadAnimation(v82);
		local l_v84_0 = v84 --[[ copy: 18 -> 31 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v84_0 (copy)
			l_v84_0:Stop(0);
			l_v84_0:Destroy();
		end);
		v80 = v84;
		v80.Priority = Enum.AnimationPriority.Action4;
		v82 = v78;
		v84 = function(v86, v87) --[[ Line: 252 ]] --[[ Name: switchWalkAnimationTrack ]]
			-- upvalues: v82 (ref)
			if v82 == v86 then
				return;
			else
				local l_IsPlaying_0 = v82.IsPlaying;
				if l_IsPlaying_0 then
					v82:Stop();
				end;
				v82 = v86;
				if l_IsPlaying_0 and not v87 then
					v82:Play();
				end;
				return;
			end;
		end;
		l_v73_1:Play();
		v56:Add(v55:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 271 ]]
			-- upvalues: v55 (copy), v82 (ref), v59 (ref), v60 (ref)
			if v55:GetAttribute("IsRunning") then
				if not v82.IsPlaying then
					v82:Play();
				end;
				if v59 then
					v59.ParticleEmitter.Enabled = true;
				end;
				if v60 then
					v60.ParticleEmitter.Enabled = true;
					return;
				end;
			else
				if v82.IsPlaying then
					v82:Stop();
				end;
				if v59 then
					v59.ParticleEmitter.Enabled = false;
				end;
				if v60 then
					v60.ParticleEmitter.Enabled = false;
				end;
			end;
		end));
		v56:Add(v55:GetAttributeChangedSignal("Attack"):Connect(function() --[[ Line: 300 ]]
			-- upvalues: v80 (copy)
			v80:Play();
		end));
		local l_Animation5_0 = script.Animation5;
		local v90 = v58.AnimationController:LoadAnimation(l_Animation5_0);
		local l_v90_0 = v90 --[[ copy: 21 -> 32 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v90_0 (copy)
			l_v90_0:Stop(0);
			l_v90_0:Destroy();
		end);
		local l_v90_1 = v90;
		l_v90_1.Priority = Enum.AnimationPriority.Action2;
		v90 = script.Animation6;
		local v93 = v58.AnimationController:LoadAnimation(v90);
		local l_v93_0 = v93 --[[ copy: 22 -> 33 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v93_0 (copy)
			l_v93_0:Stop(0);
			l_v93_0:Destroy();
		end);
		l_Animation5_0 = v93;
		l_Animation5_0.Priority = Enum.AnimationPriority.Action2;
		v93 = script.Animation7;
		local v95 = v58.AnimationController:LoadAnimation(v93);
		local l_v95_0 = v95 --[[ copy: 23 -> 34 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v95_0 (copy)
			l_v95_0:Stop(0);
			l_v95_0:Destroy();
		end);
		v90 = v95;
		v90.Priority = Enum.AnimationPriority.Action2;
		v95 = script.Animation8;
		local v97 = v58.AnimationController:LoadAnimation(v95);
		local l_v97_0 = v97 --[[ copy: 24 -> 35 ]];
		v56:Add(function() --[[ Line: 185 ]]
			-- upvalues: l_v97_0 (copy)
			l_v97_0:Stop(0);
			l_v97_0:Destroy();
		end);
		v93 = v97;
		v93.Priority = Enum.AnimationPriority.Action2;
		v95 = {
			[1] = l_v90_1, 
			[2] = l_Animation5_0, 
			[3] = v90, 
			[4] = v93
		};
		v97 = nil;
		v56:Add(v55:GetAttributeChangedSignal("Dance"):Connect(function() --[[ Line: 321 ]]
			-- upvalues: l_v15_ActiveEventData_0 (ref), v55 (copy), v95 (copy), v97 (ref)
			local v99 = nil;
			local v100 = l_v15_ActiveEventData_0.startedAt + 85 - workspace:GetServerTimeNow();
			local v101 = l_v15_ActiveEventData_0.startedAt + 105 - workspace:GetServerTimeNow();
			v99 = v100 <= 0 and v101 > 0 and 4 or v55:GetAttribute("Dance");
			if v99 and v95[v99] and v97 == v95[v99] then
				return;
			else
				if v97 then
					v97:Stop();
					v97 = nil;
				end;
				if v99 ~= nil then
					v97 = v95[v99];
					assert(v97);
					v97:Play();
				end;
				return;
			end;
		end));
		local v102 = nil;
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function() --[[ Line: 349 ]]
			-- upvalues: l_v73_1 (copy), l_Animation1_0 (copy)
			l_v73_1:Stop();
			l_Animation1_0:Play();
		end));
		if l_Name_1 == "Ground" then
			v56:Add(v55:GetAttributeChangedSignal("ReachedFirstTarget"):Once(function() --[[ Line: 355 ]]
				-- upvalues: v102 (ref), v56 (copy), v58 (copy)
				v102 = v56:Clone(script.SanddrumRoll);
				local v103 = v56:Add(Instance.new("Weld"));
				v103.Part0 = v102;
				v103.Part1 = v58["Cylinder.005"];
				v103.C0 = CFrame.new(0.2, 3.629, 4.378);
				v103.Parent = v102;
				v102.Parent = v58;
			end));
		end;
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 27.5 - workspace:GetServerTimeNow(), function() --[[ Line: 369 ]]
			-- upvalues: l_Name_1 (copy), v55 (copy), v102 (ref), v56 (copy), v76 (copy), v82 (ref), v69 (ref)
			if l_Name_1 == "Ground" then
				local _ = v55:GetPivot();
				if v102 then
					local l_v102_0 = v102;
					l_v102_0.ParticleEmitter.Enabled = false;
					local l_l_v102_0_0 = l_v102_0 --[[ copy: 1 -> 2 ]];
					task.delay(3, function() --[[ Line: 376 ]]
						-- upvalues: v56 (ref), l_l_v102_0_0 (copy)
						v56:Remove(l_l_v102_0_0);
					end);
					v102 = nil;
				end;
				local l_v76_1 = v76;
				if v82 ~= l_v76_1 then
					if v82.IsPlaying then
						v82:Stop();
					end;
					v82 = l_v76_1;
				end;
				v76:Play(nil, nil, 0.3333333333333333);
				v69 = 1.5707963267948966;
			end;
		end));
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 31 - workspace:GetServerTimeNow(), function() --[[ Line: 389 ]]
			-- upvalues: l_Name_1 (copy), v76 (copy), v59 (ref), v56 (copy), v58 (copy), v60 (ref), l_Animation1_0 (copy), l_v73_1 (copy)
			if l_Name_1 == "Ground" then
				v76:AdjustSpeed(1);
				v59 = v56:Clone(script.WalkPart);
				assert(v59);
				local v108 = v56:Add(Instance.new("Weld"));
				v108.Part0 = v59;
				v108.Part1 = v58["Cylinder.005"];
				v108.C0 = CFrame.new(0.614, 3.129, 4.731) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
				v108.Parent = v59;
				v59.Parent = v58;
				v60 = v56:Clone(script.WalkPart);
				assert(v60);
				local v109 = v56:Add(Instance.new("Weld"));
				v109.Part0 = v60;
				v109.Part1 = v58["Cylinder.005"];
				v109.C0 = CFrame.new(0.414, 3.129, -4.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
				v109.Parent = v60;
				v60.Parent = v58;
				return;
			else
				if l_Name_1 == "Wall" then
					l_Animation1_0:Stop();
					l_v73_1:Play();
				end;
				return;
			end;
		end));
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 43 - workspace:GetServerTimeNow(), function() --[[ Line: 422 ]]
			-- upvalues: v73 (copy), v69 (ref)
			v73:Play(nil, nil, 0.3333333333333333);
			v69 = 0;
		end));
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function() --[[ Line: 427 ]]
			-- upvalues: v73 (copy), v78 (copy), v82 (ref), l_Name_1 (copy), l_Animation1_0 (copy), l_v73_1 (copy)
			v73:Stop();
			local l_v78_1 = v78;
			if v82 ~= l_v78_1 then
				local l_IsPlaying_1 = v82.IsPlaying;
				if l_IsPlaying_1 then
					v82:Stop();
				end;
				v82 = l_v78_1;
				if l_IsPlaying_1 then
					v82:Play();
				end;
			end;
			if l_Name_1 == "Wall" then
				l_Animation1_0:Stop();
				l_v73_1:Play();
			end;
		end));
		v56:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 141 - workspace:GetServerTimeNow(), function() --[[ Line: 437 ]]
			-- upvalues: l_v15_ActiveEventData_0 (ref), v56 (copy), l_RunService_0 (ref), l_v90_1 (copy), l_Animation5_0 (copy), v90 (copy), v93 (copy)
			local v112 = l_v15_ActiveEventData_0.startedAt + 161 - workspace:GetServerTimeNow();
			local v113 = 0;
			v56:Add(l_RunService_0.PreSimulation:Connect(function(v114) --[[ Line: 441 ]]
				-- upvalues: v113 (ref), v112 (copy), l_v90_1 (ref), l_Animation5_0 (ref), v90 (ref), v93 (ref)
				debug.profilebegin("Crab Rave:Crab:Adjust Dance Speed");
				v113 = v113 + v114;
				local v115 = math.lerp(1, 0.1, v113 / v112);
				l_v90_1:AdjustSpeed(v115);
				l_Animation5_0:AdjustSpeed(v115);
				v90:AdjustSpeed(v115);
				v93:AdjustSpeed(v115);
				debug.profileend();
			end));
		end));
		return function() --[[ Line: 455 ]]
			-- upvalues: v56 (copy)
			v56:Destroy();
		end;
	end));
	local _ = workspace.CurrentCamera;
	local v117 = 0;
	local v118 = 0;
	v29:Add(l_RunService_0.PostSimulation:Connect(function(v119) --[[ Line: 466 ]]
		-- upvalues: v118 (ref), v117 (ref), l_CrabRave_0 (ref), v53 (ref), l_TweenService_0 (ref), v10 (ref)
		debug.profilebegin("Crab Rave:Update");
		v118 = v118 - v119;
		v117 = v117 - v119;
		local v120 = math.clamp((l_CrabRave_0.PlaybackLoudness - 100) / 900, 0, 1);
		if v117 <= 0 and v53 then
			v117 = 0.5;
			v53.FillTransparency = 0;
			l_TweenService_0:Create(v53, TweenInfo.new(0.3), {
				FillTransparency = 1
			}):Play();
		end;
		if v120 >= 0.25 and v118 <= 0 then
			v118 = 0.1;
			v10:Fov((v120 - 0.25) * 20 + 70, 0.1);
		end;
		debug.profileend();
	end));
	v29:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function() --[[ Line: 490 ]]
		-- upvalues: v53 (ref), l_TweenService_0 (ref), v33 (copy)
		if v53 then
			v53:Destroy();
			v53 = nil;
		end;
		local v121 = l_TweenService_0:Create(v33, TweenInfo.new(1), {
			Brightness = 0
		});
		v121:Play();
		v121.Completed:Once(function() --[[ Line: 501 ]]
			-- upvalues: v121 (copy)
			v121:Cancel();
			v121:Destroy();
		end);
	end));
	v29:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function() --[[ Line: 507 ]]
		-- upvalues: v29 (ref), v20 (ref), v17 (ref), l_Players_0 (ref), v22 (ref), l_RunService_0 (ref), l_v15_ActiveEventData_0 (copy), l_LocalPlayer_0 (ref)
		local _ = v29:Add(v20.new());
		local v134 = v29:Add(v17.observeCharacter(l_Players_0.LocalPlayer, function(_, v124) --[[ Line: 511 ]]
			-- upvalues: v22 (ref), l_RunService_0 (ref), l_v15_ActiveEventData_0 (ref), l_LocalPlayer_0 (ref)
			local v125 = v22.new();
			v125:Add(task.spawn(function() --[[ Line: 514 ]]
				-- upvalues: v124 (copy), v125 (copy), l_RunService_0 (ref), l_v15_ActiveEventData_0 (ref), l_LocalPlayer_0 (ref)
				local l_Humanoid_0 = v124:WaitForChild("Humanoid");
				if not l_Humanoid_0 then
					return;
				else
					local l_Animator_0 = l_Humanoid_0:WaitForChild("Animator");
					if not l_Animator_0 then
						return;
					else
						local v128 = l_Animator_0:LoadAnimation(script.Dance);
						v128.Priority = Enum.AnimationPriority.Action;
						v128:Play(2);
						local v129 = 0;
						local v130 = 0;
						v125:Add(l_RunService_0.PostSimulation:Connect(function(v131) --[[ Line: 531 ]]
							-- upvalues: l_v15_ActiveEventData_0 (ref), v128 (copy), v130 (ref), l_Humanoid_0 (copy), l_LocalPlayer_0 (ref), v129 (ref)
							debug.profilebegin("Crab Rave:Player:Dance");
							local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
							if l_v15_ActiveEventData_0.startedAt + 66 - (l_workspace_ServerTimeNow_0 or workspace:GetServerTimeNow()) > 0 then
								if not v128.IsPlaying then
									v128:Play();
									v128.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % v128.Length;
								end;
								debug.profileend();
								return;
							else
								local l_Length_0 = v128.Length;
								if v130 ~= l_Length_0 and l_Length_0 > 0 then
									v130 = l_Length_0;
									v128.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % l_Length_0;
								end;
								if not (l_Humanoid_0.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not l_LocalPlayer_0:GetAttribute("Stealing") then
									if v129 < 3 then
										v129 = v129 + v131;
									elseif not v128.IsPlaying then
										v128:Play();
										v128.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % v128.Length;
									end;
								else
									v129 = 0;
									if v128.IsPlaying then
										v128:Stop();
									end;
								end;
								debug.profileend();
								return;
							end;
						end));
						v125:Add(function() --[[ Line: 569 ]]
							-- upvalues: v128 (copy)
							v128:Stop();
							v128:Destroy();
						end);
						return;
					end;
				end;
			end));
			return v125:WrapClean();
		end));
		v29:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 140 - workspace:GetServerTimeNow(), v134));
	end));
end;
v7.OnStop = function(_) --[[ Line: 582 ]] --[[ Name: OnStop ]]
	-- upvalues: v29 (copy)
	v29:Destroy();
end;
v7.OnLoad = function(_) --[[ Line: 586 ]] --[[ Name: OnLoad ]]
	-- upvalues: l_ContentProvider_0 (copy), v25 (copy), v7 (copy), v8 (copy)
	task.spawn(pcall, function() --[[ Line: 587 ]]
		-- upvalues: l_ContentProvider_0 (ref)
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
	v25.OnClientEvent:Connect(function(v137) --[[ Line: 591 ]]
		-- upvalues: v7 (ref), v8 (ref)
		if not v7.Active then
			return;
		else
			v8.playBurst(script.CrabHit, v137);
			return;
		end;
	end);
end;
return v7;