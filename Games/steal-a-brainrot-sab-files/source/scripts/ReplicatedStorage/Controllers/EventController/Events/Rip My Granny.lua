
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v5 = {};
local v6 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v9 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v11 = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v12 = require(l_ReplicatedStorage_0.Packages.Observers);
local v13 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v14 = require(l_ReplicatedStorage_0.Packages.Trove);
local v15 = require(l_ReplicatedStorage_0.Packages.Net);
local v16 = require(l_ReplicatedStorage_0.Packages.Spr);
local l_Name_0 = script.Name;
local l_RipMyGranny_0 = workspace.Sounds.RipMyGranny;
local v20 = v15:RemoteEvent((("EventService/RipMyGranny/Projectile"):format(l_Name_0)));
local v21 = v15:RemoteEvent((("EventService/RipMyGranny/Burst"):format(l_Name_0)));
local v22 = v14.new();
local _ = workspace.CurrentCamera;
local function v26()
	local v24 = l_ReplicatedStorage_0:GetAttribute("RipMyGrannySharedPhase") or workspace:GetServerTimeNow();
	v7:Activate("Blink");
	v22:Add(function()
		v7:Activate("Blink");
	end);
	(if v13.IsBiggerServer() then v22:Clone(script.BiggerGrannyMap) else if v13.IsTsunamiServer() then v22:Clone(script.TsunamiGrannyMap) else v22:Clone(script.GrannyMap)).Parent = workspace;
	v9:Update();
	v8:UpdateOST();
	v22:Add(task.spawn(function()
		l_RipMyGranny_0.Looped = true;
		local v25 = workspace:GetServerTimeNow() - v24;
		if l_RipMyGranny_0.TimeLength > 0 then
			l_RipMyGranny_0.TimePosition = v25 % 108.173;
		end;
		if v25 < 216.346 then
			l_RipMyGranny_0:Play();
		end;
		v22:Add(task.delay(v24 + 216.346 - workspace:GetServerTimeNow(), function()
			l_RipMyGranny_0.Looped = false;
			l_RipMyGranny_0:Stop();
		end));
		v22:Add(function()
			l_RipMyGranny_0.Looped = false;
			l_RipMyGranny_0:Stop();
		end);
	end));
	v7:Run("RipMyGrannyEvent", "GrassRecolor");
	v22:Add(function()
		v7:Stop("RipMyGrannyEvent", "GrassRecolor");
	end);
end;
local v27 = nil;
v5.OnStart = function(_)
	local l_v10_ActiveEventData_0 = v10:GetActiveEventData(l_Name_0);
	assert(l_v10_ActiveEventData_0);
	l_ReplicatedStorage_0:SetAttribute("RipMyGrannyEventMusic", true)
	v9:Update();
	v8:UpdateOST();
	local v30 = typeof(l_ReplicatedStorage_0:GetAttribute("RipMyGrannySharedPhase")) == "number";
	local v31 = v22:Extend();
	if not v30 then
		local v32 = v31:Clone(script.RipMyGrannySammyRig);
		local l_v32_Pivot_0 = v32:GetPivot();
		if v13.IsBiggerServer() then
			l_v32_Pivot_0 = l_v32_Pivot_0 + Vector3.new(0, 0, -251, 0);
		end;
		v32:PivotTo(CFrame.new(0, 100000, 100000));
		v32.Parent = workspace;
		local v34 = v11.loadAnimation(v31, v32.Humanoid.Animator, script.SammySpawn);
		v34.Looped = false;
		v34.Priority = Enum.AnimationPriority.Action;
		v27 = v11.loadAnimation(v31, v32.Humanoid.Animator, script.SammyShoot);
		assert(v27);
		v27.Looped = false;
		v27.Priority = Enum.AnimationPriority.Action4;
		v22:Add(function()
			v27 = nil;
		end);
		local v35 = v11.loadAnimation(v31, v32.Humanoid.Animator, script.SammyIdle);
		v35.Priority = Enum.AnimationPriority.Idle;
		do
			local l_l_v32_Pivot_0_0 = l_v32_Pivot_0;
			v31:Add(task.spawn(function()
				while v34.Length == 0 do
					task.wait();
				end;
				local v37 = workspace:GetServerTimeNow() - l_v10_ActiveEventData_0.startedAt;
				if v34.Length < v37 then
					return;
				else
					v34.TimePosition = v37;
					v34:Play(0);
					v34.TimePosition = v37;
					v35:Play(0);
					while true do
						if not v34.IsPlaying then
							if v34.Length < v37 then
								v32:PivotTo(l_l_v32_Pivot_0_0);
								return;
							else
								task.wait();
							end;
						else
							v34.TimePosition = v37;
							v32:PivotTo(l_l_v32_Pivot_0_0);
							return;
						end;
					end;
				end;
			end));
		end;
	end;
	v22:Add(v12.observeTag("FlyingGrannyEvent", function(v38)
		local v39 = v14.new();
		local v40 = v39:Clone(script.FlyingGranny);
		v40.Parent = workspace;
		local l_Weld_0 = Instance.new("Weld");
		l_Weld_0.Part0 = v40.PrimaryPart;
		l_Weld_0.Part1 = v38;
		l_Weld_0.C0 = v40.PrimaryPart.PivotOffset;
		l_Weld_0.Parent = v40.PrimaryPart;
		local v42 = v11.loadAnimation(v39, v40.AnimationController.Animator, script.FlyingGrannyIdle);
		v42.Priority = Enum.AnimationPriority.Idle;
		v42.Looped = true;
		v42:Play();
		local v43 = v11.loadAnimation(v39, v40.AnimationController.Animator, script.FlyingGrannyWalk);
		v43.Priority = Enum.AnimationPriority.Action;
		v43.Looped = true;
		local v44 = v11.loadAnimation(v39, v40.AnimationController.Animator, script.FlyingGrannyAttack);
		v44.Priority = Enum.AnimationPriority.Action2;
		v44.Looped = false;
		v39:Add(v38:GetAttributeChangedSignal("Attack"):Connect(function()
			v44:Play();
		end));
		v39:Add(v12.observeAttribute(v38, "Flying", function(v45)
			if v45 then
				v43:Play();
			else
				v43:Stop();
			end;
			return nil;
		end));
		v39:Add(v38:GetAttributeChangedSignal("Attack"):Connect(function()

		end));
		return v39:WrapClean();
	end, {
		workspace
	}));
	v22:Add(v12.observeTag("HideInRipMyGranny", function(v46)
		local l_Parent_0 = v46.Parent;
		v46.Parent = script;
		return function()
			pcall(function()
				v46.Parent = l_Parent_0;
			end);
		end;
	end, {
		workspace, 
		script
	}));
	if l_ReplicatedStorage_0:GetAttribute("RipMyGrannySharedPhase") then
		v31:Clean();
		v26();
		return;
	else
		v22:Add(l_ReplicatedStorage_0:GetAttributeChangedSignal("RipMyGrannySharedPhase"):Connect(function()
			if l_ReplicatedStorage_0:GetAttribute("RipMyGrannySharedPhase") then
				v31:Clean();
				v26();
			end;
		end));
		return;
	end;
end;
v5.OnStop = function(_)
	l_ReplicatedStorage_0:SetAttribute("RipMyGrannyEventMusic", nil)
	v22:Destroy();
end;
v5.OnLoad = function(_)
	task.spawn(pcall, function()
		l_ContentProvider_0:PreloadAsync(script:GetChildren());
	end);
	task.spawn(function()
		l_ContentProvider_0:PreloadAsync({
			l_RipMyGranny_0
		});
	end);
	v20.OnClientEvent:Connect(function(v50, v51, v52, v53)
		local function _()
			local l_RipMyGrannySammyRig_0 = workspace:FindFirstChild("RipMyGrannySammyRig");
			return l_RipMyGrannySammyRig_0 and l_RipMyGrannySammyRig_0["Sammy Bazooka"].Ammo.CFrame or script.RipMyGrannySammyRig["Sammy Bazooka"].Ammo.CFrame;
		end;
		local function _()
			local l_RipMyGrannySammyRig_1 = workspace:FindFirstChild("RipMyGrannySammyRig");
			return l_RipMyGrannySammyRig_1 and l_RipMyGrannySammyRig_1.UpperTorso.Waist;
		end;
		local function _()
			local l_RipMyGrannySammyRig_2 = workspace:FindFirstChild("RipMyGrannySammyRig");
			return l_RipMyGrannySammyRig_2 and l_RipMyGrannySammyRig_2.HumanoidRootPart.CFrame;
		end;
		local v60 = false;
		local v61 = v22:Clone(script.Projectile);
		local v62 = v51 + v53;
		local v63 = v62 + v52;
		local v64 = nil;
		local v65 = nil;
		local v66 = nil;
		v66 = v22:Add(l_RunService_0.PreRender:Connect(function()
			debug.profilebegin("RipMyGranny:Projectile");
			local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
			local v68 = math.max(v63 - l_workspace_ServerTimeNow_0, 0);
			local v69 = l_workspace_ServerTimeNow_0 < v62 and 0 or 1 - v68 / v52;
			if v69 >= 0.95 then
				if v66 then
					v22:Remove(v66);
					v66 = nil;
				end;
				v22:Remove(v61);
				v6.playBurst(script.Explosion, v6.getAnimalPosition(v50, {
					top = true
				}), {});
				debug.profileend();
				return;
			else
				local v70 = v6.getAnimalPosition(v50);
				if v69 > 0 and not v60 then
					v60 = true;
					local l_RipMyGrannySammyRig_3 = workspace:FindFirstChild("RipMyGrannySammyRig");
					local l_Position_0 = (l_RipMyGrannySammyRig_3 and l_RipMyGrannySammyRig_3["Sammy Bazooka"].Ammo.CFrame or script.RipMyGrannySammyRig["Sammy Bazooka"].Ammo.CFrame).Position;
					v61:PivotTo(CFrame.lookAt(l_Position_0, l_Position_0 + (v70 - l_Position_0).Unit));
					v61.Parent = workspace;
					local l_l_Position_0_0 = l_Position_0 ;
					task.spawn(function()
						v8:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Rip My Granny"].EventShoot, l_l_Position_0_0, false);
					end);
					if v27 then
						v27:Play(0.05, 1, 1.5);
					end;
					l_RipMyGrannySammyRig_3 = workspace:FindFirstChild("RipMyGrannySammyRig");
					if l_RipMyGrannySammyRig_3 then
						l_RipMyGrannySammyRig_3["Sammy Bazooka"].Ammo.Transparency = 1;
					end;
				end;
				local l_RipMyGrannySammyRig_4 = workspace:FindFirstChild("RipMyGrannySammyRig");
				local v75 = l_RipMyGrannySammyRig_4 and l_RipMyGrannySammyRig_4.UpperTorso.Waist;
				local l_RipMyGrannySammyRig_5 = workspace:FindFirstChild("RipMyGrannySammyRig");
				l_RipMyGrannySammyRig_4 = l_RipMyGrannySammyRig_5 and l_RipMyGrannySammyRig_5.HumanoidRootPart.CFrame;
				if v75 and l_RipMyGrannySammyRig_4 then
					if not v64 then
						v64 = v75.C0;
					end;
					l_RipMyGrannySammyRig_5 = l_RipMyGrannySammyRig_4:VectorToObjectSpace((v70 - l_RipMyGrannySammyRig_4.Position).Unit);
					local v77 = math.clamp(math.atan2(-l_RipMyGrannySammyRig_5.X, -l_RipMyGrannySammyRig_5.Z), -1.0471975511965976, 1.0471975511965976);
					local v78 = math.clamp(math.asin((math.clamp(l_RipMyGrannySammyRig_5.Y, -1, 1))), -0.2617993877991494, 0.2617993877991494);
					v16.target(v75, 1, 2, {
						C0 = v64 * CFrame.Angles(v78, v77, 0)
					});
				end;
				if v69 <= 0 then
					debug.profileend();
					return;
				else
					l_RipMyGrannySammyRig_5 = l_TweenService_0:GetValue(v69, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
					if not v65 then
						local l_RipMyGrannySammyRig_6 = workspace:FindFirstChild("RipMyGrannySammyRig");
						v65 = l_RipMyGrannySammyRig_6 and l_RipMyGrannySammyRig_6["Sammy Bazooka"].Ammo.CFrame or script.RipMyGrannySammyRig["Sammy Bazooka"].Ammo.CFrame;
					end;
					local l_Position_1 = v65.Position;
					local v81 = l_Position_1:Lerp(v70, l_RipMyGrannySammyRig_5);
					local v82 = CFrame.lookAt(v81, v81 + (v70 - l_Position_1).Unit) * CFrame.Angles(0, 0, -l_RipMyGrannySammyRig_5 * 6 * 3.141592653589793);
					v61:PivotTo(v82);
					v61.Size = script.Projectile.Size:Lerp(script.Projectile.Size / 5, l_RipMyGrannySammyRig_5);
					debug.profileend();
					return;
				end;
			end;
		end));
	end);
	v21.OnClientEvent:Connect(function(_, v84)
		v22:Add(v6.playBurst(script.Burst, v84, {
			l_ReplicatedStorage_0.Sounds.Events["Rip My Granny"].Hit
		}));
	end);
end;
return v5;