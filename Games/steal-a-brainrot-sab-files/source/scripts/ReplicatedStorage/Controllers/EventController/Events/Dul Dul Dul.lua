
local _ = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v13 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v14 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v15 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Shared.Snapshot);
local v18 = require(l_ReplicatedStorage_0.Packages.Trove);
local v19 = require(l_ReplicatedStorage_0.Packages.Net);
local v20 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v22 = v14.IsBiggerServer() and -251 or 0;
local v23 = v19:RemoteEvent("EventService/Dul Dul Dul/Burst");
local v24 = v18.new();
local function v50(v25, v26, v27)
	local function v38(v28, v29, v30, v31)
		local l_CFrame_0 = v28.CFrame;
		local v33 = Vector3.new(v31 and 0 or v29.X, 0, v31 and 0 or v29.Z);
		local v34 = l_CFrame_0 * CFrame.new(0, -(v29.Y - v33.Y) / 2, 0);
		v28.Size = v33;
		v28.CFrame = v34;
		local l_Transparency_0 = v28.Transparency;
		v28.Transparency = 1;
		v28.CanCollide = false;
		v24:Add(function()
			v28.Transparency = l_Transparency_0;
			v28.CanCollide = true;
			v28.Size = v29;
			v28.CFrame = l_CFrame_0;
		end);
		v24:Add(task.delay(if v27 then v27(v30) else v30, function()
			v28.Transparency = l_Transparency_0;
			v28.CanCollide = true;
			local v36 = if v27 then v27(v30 + 1) else 1;
			local v37 = TweenInfo.new(v36, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
			v13(v28, v37, {
				Size = v29
			});
			v13(v28, v37, {
				CFrame = l_CFrame_0
			});
		end));
	end;
	local v39 = {};
	local v40 = 1e999;
	local v41 = -1e999;
	for _, v43 in v25:GetDescendants() do
		if v43:IsA("BasePart") and v43.Transparency < 1 then
			table.insert(v39, v43);
			v40 = math.min(v40, v43.Position.Y);
			v41 = math.max(v41, v43.Position.Y);
		end;
	end;
	table.sort(v39, function(v44, v45)
		return v44.Position.Y < v45.Position.Y;
	end);
	local v46 = v41 - v40;
	for _, v48 in v39 do
		local v49 = (v48.Position.Y - v40) / v46 * v26 + 0.25;
		v38(v48, v48.Size, v49);
	end;
end;
local function v67()
	local v51 = v24:Extend();
	local v52 = table.create(4);
	v51:Add(function()
		table.clear(v52);
	end);
	local v53 = 0;
	v51:Add(l_RunService_0.PreRender:Connect(function(v54)
		debug.profilebegin("Dul Dul Dul Event");
		v53 = v53 + v54;
		for v55, v56 in v52 do
			if v56.target and v56.targetAttachment then
				v56.beam.First.Enabled = true;
				v56.beam.Second.Enabled = true;
				local v57 = math.clamp(v53 - v55 + 1, 0, 1);
				local l_WorldPosition_0 = v56.beam.WorldPosition;
				v56.targetAttachment.Position = l_WorldPosition_0 + (v56.target:GetPivot().Position - l_WorldPosition_0) * v57;
			end;
		end;
		debug.profileend();
	end));
	v51:Add(v15.observeTag("DulDulDulPlayerVFX", function(v59)
		local v60 = script.PlayerVFX.Beam:Clone();
		v60.Parent = v59;
		local v61 = script.PlayerVFX.Torso:Clone();
		v61.Parent = v59;
		local l_v59_Attribute_0 = v59:GetAttribute("DulDulDulIndex");
		v52[l_v59_Attribute_0] = {
			beam = v60, 
			target = nil
		};
		local v66 = v15.observeTag("DulDulDulPlayerVFX", function(v63)
			if v63 == v59 then
				return nil;
			elseif v63:GetAttribute("DulDulDulIndex") ~= v59:GetAttribute("DulDulDulIndex") % 4 + 1 then
				return nil;
			else
				local l_Attachment_0 = Instance.new("Attachment");
				l_Attachment_0.Position = v60.WorldPosition;
				l_Attachment_0.Parent = workspace.Terrain;
				local v65 = v52[v59:GetAttribute("DulDulDulIndex")];
				v65.target = v63;
				v65.beam.First.Attachment0 = l_Attachment_0;
				v65.beam.Second.Attachment0 = l_Attachment_0;
				v65.targetAttachment = l_Attachment_0;
				return function()
					l_Attachment_0:Destroy();
				end;
			end;
		end);
		return function()
			v61:Destroy();
			v60:Destroy();
			v66();
			v52[l_v59_Attribute_0] = nil;
		end;
	end));
end;
v6.OnStart = function(_)
	local l_v11_ActiveEventData_0 = v11:GetActiveEventData(l_Name_0);
	assert(l_v11_ActiveEventData_0);
	v24:Add(function()
		v7:Activate("Blink");
		v10:Update();
		v9:UpdateOST();
		v9:UpdateAmbience();
	end);
	v10:Update();
	v9:UpdateOST();
	v9:UpdateAmbience();
	v24:Add(task.spawn(function()
		v67();
	end));
	v24:Add(v15.observeTag("DulDulDul", function(v70)
		local v71 = v18.new();
		local l_HumanoidRootPart_0 = v70:WaitForChild("HumanoidRootPart");
		local v73 = v71:Clone(script["Dul Dul Dul"]);
		local v74 = v71:Add(Instance.new("Weld"));
		v74.Part0 = v73.PrimaryPart;
		v74.Part1 = l_HumanoidRootPart_0;
		v74.C0 = CFrame.Angles(0, 0, 0);
		v74.Parent = v73.PrimaryPart;
		v73.Parent = v70;
		local l_Animator_0 = v73.AnimationController.Animator;
		local v76 = l_Animator_0:LoadAnimation(script.Idle);
		v76.Priority = Enum.AnimationPriority.Idle;
		v76.Looped = true;
		v76:Play();
		local v77 = l_Animator_0:LoadAnimation(script.Walk);
		v77.Priority = Enum.AnimationPriority.Movement;
		local l_v70_Attribute_0 = v70:GetAttribute("Index");
		local v79 = l_Animator_0:LoadAnimation(script[(not (l_v70_Attribute_0 ~= 1) or l_v70_Attribute_0 == 4) and "Build2" or "Build1"]);
		v79.Priority = Enum.AnimationPriority.Action;
		local v80 = l_Animator_0:LoadAnimation(script.Gesture);
		v80.Priority = Enum.AnimationPriority.Action2;
		local v81 = l_Animator_0:LoadAnimation(script.Attack);
		v81.Priority = Enum.AnimationPriority.Action3;
		local v82 = nil;
		v71:Add(v81:GetMarkerReachedSignal("CreateTie"):Connect(function()
			if v82 then
				return;
			else
				local v83 = v24:Clone(script.Tie);
				v83.RigidConstraint.Attachment1 = v73:FindFirstChild("HandAttachment", true);
				v83.Parent = v73;
				v82 = v83;
				return;
			end;
		end));
		v71:Add(v81:GetMarkerReachedSignal("DestroyTie"):Connect(function()
			if v82 then
				v24:Remove(v82);
				v82 = nil;
			end;
		end));
		v71:Add(v81:GetMarkerReachedSignal("Freeze"):Connect(function()
			if not v70:GetAttribute("FinishAttackAnimation") then
				v81:AdjustSpeed(0)
			end;
		end));
		v71:Add(task.defer(function()
			if v70:GetAttribute("IsRunning") then
				v77:Play();
			end;
		end));
		v71:Add(v15.observeAttribute(v70, "IsBuilding", function(v84)
			if not v84 then
				return nil;
			else
				local v85 = script.Hammer:Clone();
				v85["Cube.010"].RigidConstraint.Attachment1 = v73:FindFirstChild("HandAttachment", true);
				v85.Parent = v73;
				v79:Play();
				return function()
					v79:Stop();
					v85:Destroy();
				end;
			end;
		end));
		local v86 = nil;
		v71:Add(v15.observeAttribute(v70, "Gesture", function(v87)
			if not v87 then
				return nil;
			else
				local v88 = l_ReplicatedStorage_0.Sounds.Events["Dul Dul Dul"].Yap:Clone();
				v88.Parent = v73.PrimaryPart;
				v88:Play();
				v86 = v88;
				v80:Play();
				return function()
					v88:Destroy();
					v88:Stop();
					v80:Stop();
					if v86 == v88 then
						v86 = nil;
					end;
				end;
			end;
		end));
		v71:Add(v70:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			if v82 then
				v24:Remove(v82);
				v82 = nil;
			end;
			if v86 then
				v86:Pause();
			end;
			v81:Play();
		end));
		v71:Add(v81.Ended:Connect(function()
			if v86 then
				v86:Resume();
			end;
		end));
		v71:Add(v70:GetAttributeChangedSignal("FinishAttackAnimation"):Connect(function()
			if v70:GetAttribute("FinishAttackAnimation") then
				v81:AdjustSpeed(1);
			end;
		end));
		v71:Add(v70:GetAttributeChangedSignal("IsRunning"):Connect(function()
			if v70:GetAttribute("IsRunning") then
				v77:Play();
				return;
			else
				v77:Stop();
				return;
			end;
		end));
		return v71:WrapClean();
	end));
	v24:Add(task.delay(l_v11_ActiveEventData_0.startedAt + 4 - workspace:GetServerTimeNow(), function()
		v7:Activate("Blink");
		local v89 = if v14.IsBiggerServer() then script.SchoolMapBigger else script.SchoolMap;
		v24:Clone(v89).Parent = workspace;
		v24:Add(v15.observeTag("HideInDulDulDul", function(v90)
			local l_Parent_0 = v90.Parent;
			v90.Parent = script;
			return function()
				pcall(function()
					v90.Parent = l_Parent_0;
				end);
			end;
		end, {
			workspace, 
			script
		}));
		v7:Run("DulDulDulEvent", "GrassRecolor");
		v24:Add(function()
			v7:Stop("DulDulDulEvent", "GrassRecolor");
		end);
		v7:Run("DulDulDulEvent", "WallRecolor");
		v24:Add(function()
			v7:Stop("DulDulDulEvent", "WallRecolor");
		end);
		v7:Run("DulDulDulEvent", "WallBottomRecolor");
		v24:Add(function()
			v7:Stop("DulDulDulEvent", "WallBottomRecolor");
		end);
	end));
	v24:Add(task.spawn(function()
		while not l_ReplicatedStorage_0:GetAttribute("DulDulDulConstructionStart") do
			task.wait();
		end;
		local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("DulDulDulConstructionStart");
		if not l_l_ReplicatedStorage_0_Attribute_0 then
			return;
		else
			local v93 = v24:Clone(script.Machine);
			v93:PivotTo(v93:GetPivot() + Vector3.new(0, 0, v22));
			v93.Parent = workspace;
			v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Dul Dul Dul"].Building, v93.Root.Position, false);
			local v94 = v24:Clone(script.BuildingVFX);
			v94:PivotTo(v94:GetPivot() + Vector3.new(0, 0, v22));
			v94.Parent = workspace;
			v50(v93.Animate.AnimateObjects, 6, function(v95)
				return l_l_ReplicatedStorage_0_Attribute_0 + v95 + 3 - workspace:GetServerTimeNow();
			end);
			v24:Add(task.delay(l_l_ReplicatedStorage_0_Attribute_0 + 3 - workspace:GetServerTimeNow(), function()
				v20.enable(v94);
				v24:Add(task.delay(l_l_ReplicatedStorage_0_Attribute_0 + 6 + 3 - workspace:GetServerTimeNow(), function()
					v20.disable(v94);
				end));
			end));
			return;
		end;
	end));
end;
v6.OnStop = function(_)
	v24:Destroy();
end;
v6.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(l_ReplicatedStorage_0.Sounds.Events["Dul Dul Dul"]:GetChildren());
	end);
	v23.OnClientEvent:Connect(function(v98)
		v12.playBurst(script.Burst, v98, {
			l_ReplicatedStorage_0.Sounds.Events["Dul Dul Dul"].Burst
		});
	end);
end;
return v6;