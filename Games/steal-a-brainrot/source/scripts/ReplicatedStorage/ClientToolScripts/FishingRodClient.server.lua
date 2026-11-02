local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("ServerScriptService");
local l_SoundService_0 = game:GetService("SoundService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v7 = require(l_ReplicatedStorage_0.Packages.Trove);
local v8 = require(l_ReplicatedStorage_0.Shared.RegisterTool);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.FishingController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Shared.PID);
local v13 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v14 = require(l_ReplicatedStorage_0.Packages.Net);
local v15 = require(l_ReplicatedStorage_0.Packages.Spring);
local _ = workspace.CurrentCamera;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Fishing_0 = l_LocalPlayer_0.PlayerGui.ToolGuis.Fishing;
local v19 = v14:RemoteEvent("FishingRod.Cast");
local v20 = v14:RemoteEvent("FishingRod.Cancel");
local v21 = v14:RemoteEvent("FishingRod.SetupBobber");
local v22 = v14:RemoteEvent("FishingRod.MinigameClick");
local v23 = v14:RemoteEvent("FishingRod.Reward");
local v24 = v14:RemoteEvent("FishingRod.BiteGot");
local _ = Random.new();
local v26 = v15.new();
v26.Speed = 45;
v26.Damper = 0.8;
local v27 = v15.new(0.1);
v27.Speed = 2;
v27.Damper = 1;
local v28 = v15.new(70);
v28.Speed = 30;
v28.Damper = 1;
local l_Mover_0 = l_Fishing_0.Fillbar.Mover;
local v30 = false;
local v31 = false;
l_RunService_0.Heartbeat:Connect(function()
	if v30 then
		l_Mover_0.Rotation = v26.p;
		v28.t = 80 + 10 * v27.p;
		v31 = true;
		return;
	else
		if v31 then
			v31 = false;
			v28.t = 70;
			v28.p = 70;
			v28.v = 0;
		end;
		return;
	end;
end);
local function _(v32)
	if v32 >= 0.85 then
		return 1;
	else
		local v33 = v32 / 0.85;
		if v33 < 0.5 then
			return 2 * v33 * v33;
		else
			return -1 + (4 - 2 * v33) * v33;
		end;
	end;
end;
local v35 = {};
v8("FishingRod", function(v36)
	local v37 = v7.new();
	local v38 = v37:Extend();
	local v39 = false;
	local v40 = 0;
	local v41 = 0;
	local v42 = 0;
	local l_Humanoid_0 = (l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait()):WaitForChild("Humanoid");
	local v44 = {};
	local function v52()
		local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("EquippedFishingRod");
		local v46 = script:FindFirstChild(l_l_LocalPlayer_0_Attribute_0) or script["Ice Rod"];
		for _, v48 in v46:GetChildren() do
			local l_Name_0 = v48.Name;
			local v50 = l_Humanoid_0:LoadAnimation(v48);
			v50.Looped = v48:GetAttribute("Looped");
			v50.Priority = v48:GetAttribute("Priority");
			local v51 = v44[l_Name_0];
			if v51 then
				if v51.IsPlaying and v51.Looped then
					v50:Play();
				end;
				v51:Stop();
			end;
			v44[l_Name_0] = v50;
		end;
	end;
	v52();
	v37:Add(l_LocalPlayer_0:GetAttributeChangedSignal("EquippedFishingRod"):Connect(v52));
	v37:Add(l_RunService_0.Stepped:Connect(function()
		local l_v36_FirstChild_0 = v36:FindFirstChild("Reeling", true);
		if l_v36_FirstChild_0 then
			l_v36_FirstChild_0.PlaybackSpeed = 0.9 + v27.p * 0.1;
			l_v36_FirstChild_0.Volume = 0.3 + v27.p * 0.3;
		end;
		v44.Reeling:AdjustSpeed(v27.p);
	end));
	local function v56()
		if not v40 then
			return;
		else
			local v54 = v40 / v36:GetAttribute("minigameHP");
			if v42 < v40 then
				local v55 = 0.2 + 0.6 * v54;
				v27.p = math.clamp(v27.p + v55, 0.1, 1.3);
				v27.t = 0.1;
				l_SoundService_0:PlayLocalSound(l_Fishing_0.Click);
			end;
			l_TweenService_0:Create(l_Fishing_0.Fillbar.Fill, TweenInfo.new(0.2), {
				Size = UDim2.fromScale(v54, 1)
			}):Play();
			l_TweenService_0:Create(l_Fishing_0.Fillbar.Mover, TweenInfo.new(0.25), {
				Position = UDim2.fromScale(math.lerp(0, 0.875, v54), 0.5)
			}):Play();
			v42 = v40;
			return;
		end;
	end;
	local function v57()
		if not v41 then
			return;
		else
			if string.format("%.3d", v41) == 0 then
				l_Fishing_0.Fillbar.TextLabel.Text = "Click Anywhere!";
			else
				l_Fishing_0.Fillbar.TextLabel.Text = ("Click Anywhere! (x%*)"):format(v41);
			end;
			l_Fishing_0.Fillbar.TextLabel.Size = UDim2.fromScale(0.568, 0.75);
			l_TweenService_0:Create(l_Fishing_0.Fillbar.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
				Size = UDim2.fromScale(0.7, 0.85)
			}):Play();
			return;
		end;
	end;
	v37:Add(v36:GetAttributeChangedSignal("minigameHits"):Connect(function()
		v40 = v36:GetAttribute("minigameHits");
		v56();
	end));
	v37:Add(v36:GetAttributeChangedSignal("minigameTotalHits"):Connect(function()
		v41 = v36:GetAttribute("minigameTotalHits");
		v57();
	end));
	v37:Add(v36:GetAttributeChangedSignal("minigame"):Connect(function()
		if not v36:GetAttribute("minigame") then
			v44.Reeling:Stop();
			l_Fishing_0.Fillbar.Visible = false;
			v30 = false;
			return;
		else
			v30 = true;
			v44.Reeling:Play();
			l_Fishing_0.Fillbar.Visible = true;
			return;
		end;
	end));
	v37:Add(v36:GetAttributeChangedSignal("casted"):Connect(function()
		if v36:GetAttribute("casted") and not v36:GetAttribute("minigame") then
			v27.p = 0;
			v27.v = 0;
			v27.t = 0;
			v44.Reeling:Play();
			return;
		else
			if not v36:GetAttribute("casted") and not v36:GetAttribute("minigame") then
				v44.Reeling:Stop();
			end;
			return;
		end;
	end));
	v37:Add(v36.Equipped:Connect(function()
		v39 = true;
		l_Fishing_0.Enabled = true;
		l_Fishing_0.Fillbar.Visible = false;
		l_Fishing_0.CastBar.Enabled = false;
		v44.Idle:Play();
	end));
	v37:Add(v36.Unequipped:Connect(function()
		v39 = false;
		l_Fishing_0.Enabled = false;
		v38:Destroy();
		for _, v59 in v44 do
			v59:Stop();
		end;
	end));
	local v60 = false;
	local v61 = -1;
	local function v68()
		local l_HumanoidRootPart_0 = l_LocalPlayer_0.Character:FindFirstChild("HumanoidRootPart");
		if v36:GetAttribute("minigame") then
			if time() - v61 < 0.1 then
				return;
			else
				v61 = time();
				v40 = v40 + 1;
				v41 = v41 + 1;
				v57();
				v56();
				v22:FireServer();
				return;
			end;
		elseif v36:GetAttribute("casted") then
			v20:FireServer();
			return;
		elseif v36:GetAttribute("castCooldown") then
			return;
		elseif v60 then
			return;
		else
			v60 = true;
			l_Fishing_0.CastBar.Enabled = true;
			l_Fishing_0.CastBar.Adornee = l_HumanoidRootPart_0;
			v38:Add(function()
				l_Fishing_0.CastBar.Enabled = false;
			end);
			local v63 = time();
			local v64 = nil;
			local v65 = v36:GetAttribute("Luck") or 1;
			v38:Add(v36:GetAttributeChangedSignal("Luck"):Connect(function()
				v65 = v36:GetAttribute("Luck") or 1;
			end));
			v44.HoldingCast:Play();
			v44.HoldingCast:AdjustSpeed(1);
			v38:Add(function()
				v44.HoldingCast:Stop();
			end);
			while v60 and v39 do
				v64 = (time() - v63) % 1;
				if v64 > 0.5 then
					v64 = 1 - v64;
				end;
				local v66 = v64 / 0.5;
				if v66 >= 0.85 then
					v64 = 1;
				else
					local v67 = v66 / 0.85;
					v64 = if v67 < 0.5 then 2 * v67 * v67 else -1 + (4 - 2 * v67) * v67;
				end;
				l_Fishing_0.CastBar.Bar.Bar.Fill.Size = UDim2.fromScale(1, v64);
				l_Fishing_0.CastBar.Bar.Luck.Size = UDim2.fromScale(8, 0.14 + 0.05 * v64);
				l_Fishing_0.CastBar.Bar.Luck.Text = ("LUCK: %*x"):format(math.floor(math.lerp(1, v65, v64) * 100) / 100);
				if not v44.HoldingCast.IsPlaying then
					v44.HoldingCast:Play();
					v44.HoldingCast.TimePosition = v44.HoldingCast.Length - 0.01;
					v44.HoldingCast:AdjustSpeed(0);
				end;
				task.wait();
			end;
			v38:Destroy();
			if not v39 then
				return;
			else
				v44.Cast:Play();
				v19:FireServer(v64);
				return;
			end;
		end;
	end;
	local function v69()
		v60 = false;
		v38:Destroy();
	end;
	v37:Add(v36.Activated:Connect(v68));
	v37:Add(v36.Deactivated:Connect(v69));
	v37:Add(l_UserInputService_0.InputBegan:Connect(function(v70, v71)
		if v71 then
			return;
		else
			if v70.UserInputType == Enum.UserInputType.Touch then
				v68();
			end;
			return;
		end;
	end));
	v37:Add(l_UserInputService_0.InputEnded:Connect(function(v72, v73)
		if v73 then
			return;
		else
			if v72.UserInputType == Enum.UserInputType.Touch then
				v60 = false;
				v38:Destroy();
			end;
			return;
		end;
	end));
	v35[v36] = {
		animTracks = v44
	};
	v37:Add(function()
		v30 = false;
		v39 = false;
		l_Fishing_0.Enabled = false;
		v35[v36] = nil;
		for _, v75 in v44 do
			v75:Stop();
		end;
	end);
	return v37:WrapClean();
end);
v21.OnClientEvent:Connect(function(v76, v77)
	local l_PrimaryPart_0 = v76.PrimaryPart;
	l_PrimaryPart_0.AssemblyLinearVelocity = v77;
	local l_BodyVelocity_0 = Instance.new("BodyVelocity");
	l_BodyVelocity_0.MaxForce = Vector3.new(0, 0, 0, 0);
	l_BodyVelocity_0.Velocity = Vector3.new(0, 0, 0, 0);
	l_BodyVelocity_0.Parent = l_PrimaryPart_0;
	local _ = require(l_ReplicatedStorage_0.Shared.PID).new(-16, 16, 36, 1.5, 0.1);
	local v81 = workspace:FindFirstChild("FishingMap") and workspace:FindFirstChild("FishingMap"):QueryDescendants("#CatchZone") or {};
	local v82 = nil;
	v82 = l_RunService_0.Stepped:Connect(function(_)
		if not v76 or not v76:IsDescendantOf(workspace) then
			v82:Disconnect();
			return;
		else
			local v84 = nil;
			for _, v86 in v81 do
				if v13.isPointInVolume(l_PrimaryPart_0.CFrame.Position, v86.CFrame, v86.Size + Vector3.new(0, 1.5, 0, 0)) then
					v84 = v86;
					break;
				end;
			end;
			if v84 then
				l_BodyVelocity_0.MaxForce = Vector3.new(32 + l_PrimaryPart_0.AssemblyMass * 32, 1000000000, 32 + l_PrimaryPart_0.AssemblyMass * 32);
				local l_Y_0 = v10:WaterSurfacePoint(l_PrimaryPart_0.Position).Y;
				l_BodyVelocity_0.Velocity = Vector3.new(0, 0, 0, 0);
				l_RunService_0.RenderStepped:Once(function()
					l_PrimaryPart_0.CFrame = CFrame.new(l_PrimaryPart_0.Position.X, l_Y_0, l_PrimaryPart_0.Position.Z);
				end);
				return;
			else
				return;
			end;
		end;
	end);
end);
v23.OnClientEvent:Connect(function(v88, v89, v90, _, v92, _)
	if v88 == l_LocalPlayer_0 then
		v35[v89].animTracks.Catch:Play();
	end;
	local v94 = v88.Character and v88.Character:FindFirstChild("HumanoidRootPart");
	if not v94 then
		return;
	else
		local v95 = v94.Position - Vector3.new(0, 3, 0, 0);
		local v96 = v95:Lerp(v90, 0.3) + Vector3.new(0, 20, 0, 0);
		local v97 = l_ReplicatedStorage_0.Models.ToolsExtras.FishingCatch:Clone();
		v97.CFrame = CFrame.new(0, 10000, 0);
		v97.Transparency = 1;
		v97.Parent = workspace.Debris;
		local function _(v98, v99, v100, v101)
			local v102 = 1 - v101;
			return v98 * (v102 * v102) + v100 * (2 * v102 * v101) + v99 * (v101 * v101);
		end;
		local v104 = nil;
		local v105 = 0;
		local v106 = nil;
		v106 = l_RunService_0.PreRender:Connect(function(v107)
			v105 = v105 + v107;
			if v105 >= 0.5 then
				if v106 then
					v106:Disconnect();
				end;
				task.wait(2);
				v97:Destroy();
				return;
			else
				local l_v90_0 = v90;
				local l_v95_0 = v95;
				local l_v96_0 = v96;
				local v111 = v105 / 0.5;
				local v112 = 1 - v111;
				local v113 = l_v90_0 * (v112 * v112) + l_v96_0 * (2 * v112 * v111) + l_v95_0 * (v111 * v111);
				l_v95_0 = v90;
				l_v96_0 = v95;
				v111 = v96;
				v112 = v105 / 0.5 + 0.01;
				local v114 = 1 - v112;
				l_v90_0 = l_v95_0 * (v114 * v114) + v111 * (2 * v114 * v112) + l_v96_0 * (v112 * v112);
				v97.CFrame = CFrame.lookAt(v113, l_v90_0);
				l_v95_0 = v11.getAnimalModel(v92);
				if not l_v95_0 then
					return;
				else
					if not v104 then
						v104 = l_v95_0:GetScale();
					end;
					l_v95_0:ScaleTo((math.max(v104 * v105 / 0.5, 0.01)));
					l_v95_0:PivotTo(CFrame.new(v113));
					return;
				end;
			end;
		end);
		return;
	end;
end);
v24.OnClientEvent:Connect(function(v115, _)
	local l_Character_0 = v115.Character;
	assert(l_Character_0);
	local l_Head_0 = l_Character_0:FindFirstChild("Head");
	assert(l_Head_0);
	local v119 = script.FishingGotBite:Clone();
	v119.Adornee = l_Head_0;
	v119.Parent = l_Head_0;
	v119.Exclamation:Play();
	local l_TextLabel_0 = v119.TextLabel;
	l_TextLabel_0.Rotation = 15;
	l_TextLabel_0.Size = UDim2.fromScale(0, 0);
	l_TextLabel_0.Position = UDim2.fromScale(0.5, 1);
	l_TweenService_0:Create(l_TextLabel_0, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Rotation = 0, 
		Size = UDim2.fromScale(1, 1)
	}):Play();
	task.delay(2, function()
		if l_TextLabel_0:IsDescendantOf(game) then
			l_TweenService_0:Create(l_TextLabel_0, TweenInfo.new(2), {
				TextTransparency = 1
			}):Play();
			l_TweenService_0:Create(l_TextLabel_0.UIStroke, TweenInfo.new(2), {
				Transparency = 1
			}):Play();
		end;
		task.wait(2);
		v119:Destroy();
	end);
end);