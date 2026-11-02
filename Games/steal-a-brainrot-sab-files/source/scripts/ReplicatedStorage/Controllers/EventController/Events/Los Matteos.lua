local _ = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v11 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v13 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v14 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v15 = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v16 = require(l_ReplicatedStorage_0.Packages.EvLightning);
local v17 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v18 = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v19 = require(l_ReplicatedStorage_0.Shared.MapInformation);
local v20 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Shared.Snapshot);
local _ = require(script.TreeRootAnimator);
local v24 = require(l_ReplicatedStorage_0.Packages.Shake);
local v25 = require(l_ReplicatedStorage_0.Packages.Trove);
local v26 = require(l_ReplicatedStorage_0.Packages.Net);
local v27 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local l_Children_0 = script.Clouds:GetChildren();
local v30 = if v13.IsBiggerServer() then workspace.Events["Los Matteos"].CloudsStartBigger else workspace.Events["Los Matteos"].CloudsStart;
local v31 = if v13.IsBiggerServer() then workspace.Events["Los Matteos"].CloudsEndBigger else workspace.Events["Los Matteos"].CloudsEnd;
local v32 = v26:RemoteEvent("EventService/Los Matteos/CreateLightningBolt");
local v33 = v13.IsTsunamiServer();
local v34 = RaycastParams.new();
v34.FilterDescendantsInstances = {
	if v13.IsBiggerServer() then workspace.Events["Los Matteos"].AreasBigger else workspace.Events["Los Matteos"].Areas
};
v34.FilterType = Enum.RaycastFilterType.Include;
local v35 = v25.new();
local l_Part_0 = Instance.new("Part");
l_Part_0.Anchored = true;
l_Part_0.CanCollide = false;
l_Part_0.TopSurface = Enum.SurfaceType.Smooth;
l_Part_0.BottomSurface = Enum.SurfaceType.Smooth;
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Color = Color3.fromRGB(96, 234, 255);
local v37 = v24.new();
v37.Amplitude = 3;
v37.Frequency = 0.1;
v37.FadeInTime = 0;
v37.FadeOutTime = 0.6;
v37.PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0);
v37.RotationInfluence = Vector3.new(2.5, 0.5, 0.5, 0);
local function v54()
	local v38 = v35:Extend();
	local v39 = table.create(4);
	v38:Add(function()
		table.clear(v39);
	end);
	local v40 = 0;
	v38:Add(l_RunService_0.PreRender:Connect(function(v41)
		debug.profilebegin("Los Matteos Event");
		v40 = v40 + v41;
		for v42, v43 in v39 do
			if v43.target and v43.targetAttachment then
				v43.beam.First.Enabled = true;
				v43.beam.Second.Enabled = true;
				local v44 = math.clamp(v40 - v42 + 1, 0, 1);
				local l_WorldPosition_0 = v43.beam.WorldPosition;
				v43.targetAttachment.Position = l_WorldPosition_0 + (v43.target:GetPivot().Position - l_WorldPosition_0) * v44;
			end;
		end;
		debug.profileend();
	end));
	v38:Add(v20.observeTag("LosMatteosPlayerVFX", function(v46)
		local v47 = script.PlayerVFX.Beam:Clone();
		v47.Parent = v46;
		local v48 = script.PlayerVFX.Torso:Clone();
		v48.Parent = v46;
		local l_v46_Attribute_0 = v46:GetAttribute("LosMatteosIndex");
		v39[l_v46_Attribute_0] = {
			beam = v47, 
			target = nil
		};
		local v53 = v20.observeTag("LosMatteosPlayerVFX", function(v50)
			if v50 == v46 then
				return nil;
			elseif v50:GetAttribute("LosMatteosIndex") ~= v46:GetAttribute("LosMatteosIndex") % 3 + 1 then
				return nil;
			else
				local l_Attachment_0 = Instance.new("Attachment");
				l_Attachment_0.Position = v47.WorldPosition;
				l_Attachment_0.Parent = workspace.Terrain;
				local v52 = v39[v46:GetAttribute("LosMatteosIndex")];
				v52.target = v50;
				v52.beam.First.Attachment0 = l_Attachment_0;
				v52.beam.Second.Attachment0 = l_Attachment_0;
				v52.targetAttachment = l_Attachment_0;
				return function()
					l_Attachment_0:Destroy();
				end;
			end;
		end);
		return function()
			v48:Destroy();
			v47:Destroy();
			v53();
			v39[l_v46_Attribute_0] = nil;
		end;
	end));
end;
v7.OnStart = function(_)
	local l_v12_ActiveEventData_0 = v12:GetActiveEventData(l_Name_0);
	assert(l_v12_ActiveEventData_0);
	local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("LosMatteosSpawn");
	if not l_l_ReplicatedStorage_0_Attribute_0 then
		l_l_ReplicatedStorage_0_Attribute_0 = v19.MapCenter.Position;
		local v58 = workspace:Raycast(l_l_ReplicatedStorage_0_Attribute_0, Vector3.new(-0, -25, -0, -0), v34);
		if v58 then
			l_l_ReplicatedStorage_0_Attribute_0 = Vector3.new(l_l_ReplicatedStorage_0_Attribute_0.X, v58.Position.Y, l_l_ReplicatedStorage_0_Attribute_0.Z);
		end;
	end;
	l_ReplicatedStorage_0:SetAttribute("LosMatteosEvent", true);
	v35:Add(function()
		l_ReplicatedStorage_0:SetAttribute("LosMatteosEvent", nil);
		v8:Activate("Blink");
		v11:Update();
		v10:UpdateOST();
		v10:UpdateAmbience();
	end);
	local function _(v59)
		return l_v12_ActiveEventData_0.startedAt + v59 - workspace:GetServerTimeNow();
	end;
	local function v87(v61, v62, v63)
		local function v74(v64, v65, v66, v67)
			local l_CFrame_0 = v64.CFrame;
			local v69 = Vector3.new(v67 and 0 or v65.X, 0, v67 and 0 or v65.Z);
			local v70 = l_CFrame_0 * CFrame.new(0, -(v65.Y - v69.Y) / 2, 0);
			v64.Size = v69;
			v64.CFrame = v70;
			local l_Transparency_0 = v64.Transparency;
			v64.Transparency = 1;
			v35:Add(task.delay(if v63 then v63(v66) else v66, function()
				v64.Transparency = l_Transparency_0;
				local v72 = if v63 then v63(v66 + 1) else 1;
				local v73 = TweenInfo.new(v72, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
				v17(v64, v73, {
					Size = v65
				});
				v17(v64, v73, {
					CFrame = l_CFrame_0
				});
			end));
		end;
		local v75 = {};
		local v76 = 1e999;
		local v77 = -1e999;
		for _, v79 in v61:GetDescendants() do
			if v79:IsA("BasePart") and v79.Transparency < 1 then
				table.insert(v75, v79);
				v76 = math.min(v76, v79.Position.Y);
				v77 = math.max(v77, v79.Position.Y);
			end;
		end;
		table.sort(v75, function(v80, v81)
			return v80.Position.Y < v81.Position.Y;
		end);
		local v82 = v77 - v76;
		for _, v84 in v75 do
			local v85 = v84.Color.R * 255 < 90;
			local v86 = (v84.Position.Y - v76) / v82 * v62;
			if v85 then
				v86 = v86 + 0.2;
			end;
			v74(v84, v84.Size, v86, v85);
		end;
	end;
	if not v33 then
		v35:Add(task.spawn(function()
			v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Grow, l_l_ReplicatedStorage_0_Attribute_0, false);
		end));
	end;
	local v88 = v33 and 1 or 3;
	v35:Add(task.delay(l_v12_ActiveEventData_0.startedAt + v88 - workspace:GetServerTimeNow(), function()
		l_ReplicatedStorage_0:SetAttribute("LosMatteosEventNightTime", true);
		v35:Add(function()
			l_ReplicatedStorage_0:SetAttribute("LosMatteosEventNightTime", nil);
		end);
		v11:Update();
		v10:UpdateOST();
		v10:UpdateAmbience();
		if not v33 then
			local v89 = v35:Clone(script.Tree);
			v89:PivotTo(CFrame.new(l_l_ReplicatedStorage_0_Attribute_0));
			if l_ReplicatedStorage_0:GetAttribute("LosMatteosEventIsRainbow") then
				for _, v91 in v89.Leaves:GetDescendants() do
					v91:SetAttribute("RainbowIgnoreTransparency", true);
					v91:AddTag("RainbowModel");
				end;
			end;
			v89.Parent = workspace;
			v87(v89, 5, function(v92)
				local v93 = v92 + 3;
				return l_v12_ActiveEventData_0.startedAt + v93 - workspace:GetServerTimeNow();
			end);
		end;
	end));
	if not v33 then
		v35:Add(task.delay(l_v12_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function()
			l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots:Play();
		end));
		v35:Add(function()
			l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots:Stop();
		end);
		v35:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("LosMatteosGrowing"):Connect(function()
			l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Roots.Looped = l_ReplicatedStorage_0:GetAttribute("LosMatteosGrowing") ~= false;
		end));
		v35:Add(v20.observeTag("LosMatteos_Tree", function(v94)
			v87(v94, 1);
			return nil;
		end));
		v35:Add(v20.observeCharacter(l_Players_0.LocalPlayer, function(_, v96)
			return v35:Add(v20.observeAttribute(v96, "Matteo_CollectedTree", function(v97)
				if not v97 then
					return nil;
				else
					return v35:Add(v20.observeTag("LosMatteos_TreePrompt", function(v98)
						v98.Enabled = false;
						return function()
							v98.Enabled = true;
						end;
					end, {
						workspace
					}));
				end;
			end));
		end));
	end;
	local v99 = {};
	local v100 = nil;
	if v33 then
		local l_Areas_0 = workspace.Map:FindFirstChild("Areas");
		if l_Areas_0 then
			local v102 = 1e999;
			local v103 = -1e999;
			local v104 = 1e999;
			local v105 = -1e999;
			local v106 = 0;
			local v107 = 0;
			for _, v109 in l_Areas_0:GetChildren() do
				if v109:IsA("BasePart") then
					local l_v109_Pivot_0 = v109:GetPivot();
					local v111 = v109.Size.X / 2;
					local v112 = v109.Size.Z / 2;
					v102 = math.min(v102, l_v109_Pivot_0.Position.X - v111);
					v103 = math.max(v103, l_v109_Pivot_0.Position.X + v111);
					v104 = math.min(v104, l_v109_Pivot_0.Position.Z - v112);
					v105 = math.max(v105, l_v109_Pivot_0.Position.Z + v112);
					v106 = v106 + l_v109_Pivot_0.Position.Y;
					v107 = v107 + 1;
				end;
			end;
			local l_Ground_0 = workspace.Map:FindFirstChild("Ground");
			if l_Ground_0 then
				local l_l_Ground_0_Pivot_0 = l_Ground_0:GetPivot();
				local v115 = l_Ground_0.Size.X / 2;
				local v116 = l_Ground_0.Size.Z / 2;
				v102 = math.min(v102, l_l_Ground_0_Pivot_0.Position.X - v115);
				v103 = math.max(v103, l_l_Ground_0_Pivot_0.Position.X + v115);
				v104 = math.min(v104, l_l_Ground_0_Pivot_0.Position.Z - v116);
				v105 = math.max(v105, l_l_Ground_0_Pivot_0.Position.Z + v116);
				v106 = v106 + l_l_Ground_0_Pivot_0.Position.Y;
				v107 = v107 + 1;
			end;
			v106 = v106 / math.max(1, v107);
			v100 = {
				StartPos = Vector3.new((v102 + v103) / 2, v106 + 150, v104), 
				StartSize = Vector3.new(v103 - v102, 0, v105 - v104), 
				EndPos = Vector3.new((v102 + v103) / 2, v106 + 150, v105 + 100)
			};
		end;
	end;
	local function v142()
		local function v128(v117, v118)
			local v119 = if v33 and v100 then v100.StartPos else v30.Position;
			local v120 = if v33 and v100 then v100.StartSize else v30.Size;
			local v121 = if v33 and v100 then v100.EndPos else v31.Position;
			local v122 = v35:Clone(l_Children_0[math.random(1, #l_Children_0)]);
			v122.Transparency = 1;
			local v123 = nil;
			v123 = if v33 and v100 then v119.Z + math.random(0, v120.Z) else v119.Z + (v117 or 0) * 30 + (v118 or 0);
			v122.CFrame = CFrame.new(v119.X + math.random(-v120.X * 0.5, v120.X * 0.5), v119.Y, v123);
			local v124 = Vector3.new(v122.Position.X, v119.Y, v121.Z);
			if vector.dot(v121 - v119, v124 - v122.Position) < 0 then
				return;
			else
				v122.Parent = workspace.Camera;
				local v125 = math.clamp(50 / v122.Size.Magnitude, 5, 15) * (math.random(80, 120) / 100);
				local v126 = {
					instance = v122, 
					speed = v125, 
					startPos = v122.Position, 
					endPos = v124
				};
				local v127 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, (v118 or 0) * 0.1 + (math.abs(v117 or 0) + 1) * 0.5);
				v35:Add(v17(v122, v127, {
					Transparency = 0
				}));
				table.insert(v99, v126);
				return v126;
			end;
		end;
		if v33 then
			v35:Add(task.spawn(function()
				local v129 = 0;
				local v130 = 0;
				while v130 < 250 do
					for _ = 1, math.random(1, 3) do
						if v130 < 250 then
							v128(v129, v130);
							v130 = v130 + 1;
							if v130 % 3 == 1 then
								v129 = v129 + 1;
							end;
						else
							break;
						end;
					end;
					task.wait(0.08);
				end;
			end));
		else
			local v132 = 0;
			for v133 = 1, 50 do
				v128(v132, v133);
				if v133 % 3 == 1 then
					v132 = v132 + 1;
				end;
			end;
		end;
		v35:Add(l_RunService_0.PostSimulation:Connect(function(v134)
			debug.profilebegin("Los Matteos:Clouds");
			for v135 = #v99, 1, -1 do
				local v136 = v99[v135];
				local l_instance_0 = v136.instance;
				local l_Position_0 = l_instance_0.Position;
				local v139 = vector.normalize(v136.endPos - l_Position_0);
				local v140 = vector.magnitude(v136.endPos - l_Position_0);
				local v141 = v136.speed * v134;
				if v140 < v141 then
					l_Position_0 = v136.endPos;
					table.remove(v99, v135);
					v35:Add(v17(l_instance_0, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						Transparency = 1
					})).Completed:Once(function()
						v35:Remove(l_instance_0);
					end);
					v128();
				else
					l_Position_0 = l_Position_0 + v139 * v141;
				end;
				v15.pushPartCFrame(l_instance_0, CFrame.lookAt(l_Position_0, l_Position_0 + v139));
			end;
			debug.profileend();
		end));
	end;
	local v143 = v33 and 3 or 8;
	v35:Add(task.delay(l_v12_ActiveEventData_0.startedAt + v143 - workspace:GetServerTimeNow(), function()
		local v144 = v35:Clone(script.RainWeather);
		v144.Parent = workspace;
		if v13.IsBiggerServer() then
			v14.resizeEffects(v144, 2);
		end;
	end));
	v35:Add(v32.OnClientEvent:Connect(function(v145, v146, v147)
		local v148 = Random.new(v145);
		local l_Magnitude_0 = (workspace.CurrentCamera.CFrame.Position - v146).Magnitude;
		if l_Magnitude_0 <= 75 then
			local v150 = v37:Clone();
			local v151 = (1 - l_Magnitude_0 / 75 * 0.5) ^ 2;
			v150.Amplitude = v150.Amplitude * v151;
			v150.RotationInfluence = v150.RotationInfluence * v151;
			v35:Add(v18.BindShakeToCamera(v150));
			v150:Start();
		end;
		local v152 = {};
		for _, v154 in v99 do
			if ((v154.instance.Position - v146) * Vector3.new(1, 0, 1, 0)).Magnitude < 100 then
				table.insert(v152, v154.instance);
			end;
		end;
		local v155 = nil;
		if #v152 > 0 then
			local v156 = v152[v148:NextInteger(1, #v152)];
			v155 = v156.Position;
			v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"]["Lightning Strike"], v156.Position, false);
			local l_Color_0 = v156.Color;
			v156.Color = Color3.fromRGB(90, 109, 161);
			v17(v156, TweenInfo.new(1, Enum.EasingStyle.Sine), {
				Color = l_Color_0
			});
			for _, v159 in script.CloudParticles:GetChildren() do
				local v160 = v159:Clone();
				v160.Parent = v156;
				v27.emit(v160);
				l_Debris_0:AddItem(v160, 2);
			end;
		else
			v155 = v146 + Vector3.new(0, 70, 0, 0);
		end;
		local v161 = v16.create(v155, v146, {
			bends = 4, 
			thickness = 1, 
			max_depth = 1, 
			fork_bends = 1, 
			fork_chance = 30, 
			decay = 3, 
			material = Enum.Material.Neon
		});
		local l_Model_0 = Instance.new("Model");
		v161.model = l_Model_0;
		l_Model_0.Name = "LightningBolt";
		local l_v161_Lines_0 = v161:GetLines();
		table.sort(l_v161_Lines_0, function(v164, v165)
			return v164.origin.Y > v165.origin.Y;
		end);
		local l_Y_0 = l_v161_Lines_0[#l_v161_Lines_0].origin.Y;
		local l_Y_1 = l_v161_Lines_0[1].origin.Y;
		local v168 = l_Y_1 - l_Y_0;
		local v169 = v161.random:NextInteger(10, 20) / 100;
		local v170 = table.create(#l_v161_Lines_0);
		for v171, v172 in l_v161_Lines_0 do
			if v172.goal.Y >= v146.Y then
				local v173 = math.max((l_Y_1 - v172.origin.Y) / v168 * v169, 0);
				local v174 = l_Part_0:Clone();
				v174.Size = Vector3.new(v161.thickness - v172.depth * 2 * 0.1, v161.thickness - v172.depth * 2 * 0.1, (v172.origin - v172.goal).Magnitude + 0.5);
				v174.CFrame = CFrame.new((v172.goal + v172.origin) / 2, v172.goal);
				v174.Transparency = 1;
				v174.Parent = l_Model_0;
				v170[v171] = v174;
				v17(v174, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, v173), {
					Transparency = v172.transparency
				});
			end;
		end;
		task.delay(v169 + 0.05, function()
			local v175 = if v147 then script.StrikeBrainrot:Clone() else script.Strike:Clone();
			v175.Position = v146;
			v175.Parent = workspace;
			v27.emit(v175);
			if v147 then
				v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Hit, v146, false);
			else
				v10:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].HitNothing, v146, false);
			end;
			for _, v177 in v170 do
				task.spawn(function()
					v177.Transparency = 0;
					task.wait(0.1);
					v177.Transparency = 1;
					task.wait(0.1);
					v17(v177, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
						Transparency = 0.4
					});
				end);
			end;
			task.delay(v161.options.decay or 1, function()
				v175:Destroy();
				l_Model_0:Destroy();
				v161.destroyed = true;
			end);
		end);
		l_Model_0.Parent = workspace.CurrentCamera;
		v161.drew = true;
	end));
	v142();
	if not v33 then
		v35:Add(task.spawn(function()
			v54();
		end));
	end;
end;
v7.OnStop = function(_)
	v35:Destroy();
end;
v7.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
end;
return v7;
