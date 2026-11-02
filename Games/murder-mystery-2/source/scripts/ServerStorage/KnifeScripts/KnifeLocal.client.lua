-- Decompiled with the Synapse X Luau decompiler.

local v1 = nil;
local l__Parent__2 = script.Parent;
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://13784415560"
local PlayedAnimation = l__Parent__2.Parent.Parent.Character.Humanoid:LoadAnimation(Animation)
wait(0.5);
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local v4 = l__LocalPlayer__3.Character or l__LocalPlayer__3.CharacterAdded:wait();
local l__UserInputService__5 = game:GetService("UserInputService");
local v6 = require(script.CheckTapPosition);
local v7 = l__UserInputService__5.TouchEnabled and not l__UserInputService__5.KeyboardEnabled;
while true do
	v1 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainGUI");
	wait();
	if v1 then
		break;
	end;
end;
if v7 and v1.Game:FindFirstChild("Knife") then
	v1.Game.Knife.Visible = true;
	v1.Game.Throw.Visible = true;
end;
local l__mouse__8 = l__LocalPlayer__3:GetMouse();
if l__Parent__2:FindFirstChild("DualEffect") then
	l__Parent__2.Animations.Slash.AnimationId = l__Parent__2.Animations.Dual.DualSlash.AnimationId;
	l__Parent__2.Animations.Down.AnimationId = l__Parent__2.Animations.Dual.DualStab.AnimationId;
end;
local u1 = {};
local function v9(p1)
	u1[p1.Name] = {};
	u1[p1.Name].Name = p1.Name;
	u1[p1.Name].Track = l__LocalPlayer__3.Character:WaitForChild("Humanoid"):LoadAnimation(p1);
	u1[p1.Name].Object = p1;
	u1[p1.Name].Play = function(p2, p3)
		p2.Track:Play();
	end;
	u1[p1.Name].Stop = function(p4, p5)
		p4.Track:Stop();
	end;
	u1[p1.Name].Speed = function(p6, p7)
		p6.Track:AdjustSpeed(p7);
	end;
	u1[p1.Name].Track.KeyframeReached:connect(function(p8)
		if p8 == "End" then
			u1[p1.Name]:Stop();
		end;
	end);
end;
for v10, v11 in pairs(l__Parent__2:GetDescendants()) do
	if v11:IsA("Animation") then
		v9(v11);
	end;
end;
if l__Parent__2:FindFirstChild("CustomAnimations") and l__Parent__2.CustomAnimations:FindFirstChild("CustomIdle") then
	local v12 = l__Parent__2.CustomAnimations.CustomIdle:Clone();
	v12.Name = "Override";
	v12.Parent = l__LocalPlayer__3.Character.Animate;
end;
local u2 = false;
local u3 = false;
local u4 = 0;
local u5 = 0;
local u6 = false;
local l__FakeGun__7 = game.ReplicatedStorage.Remotes.Gameplay.FakeGun;
local l__Stealth__8 = game.ReplicatedStorage.Remotes.Gameplay.Stealth;
local u9 = 1;
local function v13()
	if not u2 then
		return;
	end;
	if u3 then
		return;
	end;
	if time() - u4 >= 1 and time() - u5 >= 2 and not u6 then
		l__FakeGun__7:FireServer(false);
		l__Stealth__8:FireServer(false);
		u6 = false;
		u1.ThrowCharge:Speed(u9);
		u4 = time();
		local v14 = math.random(1, 2) == 1 and u1.Slash or u1.Down;
		v14:Play();
		script.Parent.KnifeServer.SlashStart:FireServer(1);
	end;
end;
local u10 = false;
local u11 = 1;
local l__Handle__12 = l__Parent__2.Handle;
if not v7 then
	l__mouse__8.Button1Down:connect(v13);
end;
local u13 = 0;
l__mouse__8.Button2Down:connect(function()
	u13 = time();
end);
local function u14()
	if not u2 then
		return;
	end;
	if time() - u4 >= 1 and time() - u5 >= 2 then
		l__FakeGun__7:FireServer(false);
		l__Stealth__8:FireServer(false);
		u10 = true;
		u5 = time();
		u1.ThrowCharge:Speed(u9);
		u1.ThrowCharge:Play();
		wait(u11);
		local v15 = { game.Players.LocalPlayer.Character };
		local v16 = game.Workspace.CurrentCamera:ScreenPointToRay(l__mouse__8.X, l__mouse__8.Y);
		local v17 = Ray.new(v16.Origin, v16.Direction * 900);
		local v18, v19 = game.Workspace:FindPartOnRayWithIgnoreList(v17, v15);
		local v20 = v18;
		local v21 = v19;
		if v20 and v20:IsA("BasePart") and v20.Transparency == 1 then
			while true do
				table.insert(v15, v20);
				local v22, v23 = game.Workspace:FindPartOnRayWithIgnoreList(v17, v15);
				v20 = v22;
				v21 = v23;
				if v20 == nil then
					break;
				end;
				if v20 ~= nil and v20.Transparency ~= 1 then
					break;
				end;			
			end;
		end;
		if u10 then
			script.Parent.KnifeServer.FlingKnifeEvent:FireServer(CFrame.new(v21), l__Handle__12.Position);
			script.Parent.KnifeServer.SetKnifeGoneTime:FireServer(1)
			u1.ThrowCharge:Stop()
			u1.Throw:Play();
		end;
		wait(1);
	end;
end;
l__mouse__8.Button2Up:connect(function()
	if time() - u13 <= 0.3 then
		u14();
	end;
end);
l__mouse__8.KeyDown:connect(function(p9)
	if p9 == "e" then
		u14();
	end;
end);
game:GetService("UserInputService").InputBegan:connect(function(p10)
	if p10.KeyCode == Enum.KeyCode.ButtonR2 and not l__Parent__2:FindFirstChild("DisableMelee") then
		v13();
		return;
	end;
	if p10.KeyCode == Enum.KeyCode.ButtonL2 and not l__Parent__2:FindFirstChild("DisableThrowing") and u2 then
		u14();
	end;
end);
if v7 then
	v1.Game.Throw.MouseButton1Click:connect(function()
		if not u2 then
			return;
		end;
		if time() - u4 >= 1 and time() - u5 >= 2 and not u6 then
			l__FakeGun__7:FireServer(false);
			l__Stealth__8:FireServer(false);
			u5 = time();
			u1.ThrowCharge:Speed(u9);
			u1.ThrowCharge:Play();
			wait(u11);
			u1.ThrowCharge:Speed(0);
			u6 = true;
		end;
	end);
	local function u15(p11)
		if u6 and u2 then
			l__FakeGun__7:FireServer(false);
			l__Stealth__8:FireServer(false);
			u6 = false;
			u1.ThrowCharge:Stop();
			u1.ThrowCharge:Speed(u9);
			script.Parent.KnifeServer.FlingKnifeEvent:FireServer(CFrame.new(p11), l__Handle__12.Position)
			u5 = time() - 1;
			wait(0.95);
		end;
	end;
	l__UserInputService__5.TouchTap:connect(function(p12)
		local v24 = v6(p12);
		if v24 then
			local v25 = game.Workspace.CurrentCamera:ScreenPointToRay(v24.X, v24.Y);
			local v26 = Ray.new(v25.Origin, v25.Direction * 900);
			local v27 = { game.Players.LocalPlayer.Character };
			for v28, v29 in pairs(game.Workspace:GetChildren()) do
				if not game.Players:GetPlayerFromCharacter(v29) then
					table.insert(v27, v29);
				end;
			end;
			local v30, v31 = game.Workspace:FindPartOnRayWithIgnoreList(v26, v27);
			game.Workspace:FindPartOnRay(v26, game.Players.LocalPlayer.Character);
			if v30 and v30.Parent and v30.Parent.Parent then
				local v32 = game.Players:GetPlayerFromCharacter(v30.Parent) or game.Players:GetPlayerFromCharacter(v30.Parent.Parent);
				if v32 and v32 ~= l__LocalPlayer__3 then
					u15(v32.Character.HumanoidRootPart.Position);
					return;
				end;
			end;
		end;
	end);
	for v33, v34 in pairs(game.Workspace:GetChildren()) do
		if v34:FindFirstChild("Humanoid") and v34:FindFirstChild("UpperTorso") and v34.Name ~= l__LocalPlayer__3.Name then
			script.Target:Clone().Parent = v34.UpperTorso;
			v34.UpperTorso.Target.Icon.ImageColor3 = Color3.new(0, 1, 0);
		end;
	end;
	game:GetService("RunService"):BindToRenderStep("Thrower", 1, function()
		for v35, v36 in pairs(game.Workspace:GetChildren()) do
			if v36:FindFirstChild("Humanoid") and v36:FindFirstChild("UpperTorso") and (v36.UpperTorso:FindFirstChild("Target") and v36.Name ~= l__LocalPlayer__3.Name) and game.Players:GetPlayerFromCharacter(v36) then
				v36.UpperTorso.Target.Enabled = false;
				v36.UpperTorso.Target.AlwaysOnTop = false;
				if u6 then
					local v37, v38 = game.Workspace.CurrentCamera:WorldToScreenPoint(v36.UpperTorso.Position);
					if v38 then
						local l__Position__39 = l__LocalPlayer__3.Character.Head.Position;
						local v40 = game.Workspace:FindPartOnRay(Ray.new(l__Position__39, (v36.UpperTorso.Position - l__Position__39).unit * 300), l__LocalPlayer__3.Character);
						if v40.Parent == v36 or v40.Parent.Parent == v36 then
							v36.UpperTorso.Target.Enabled = true;
							v36.UpperTorso.Target.AlwaysOnTop = true;
						end;
					end;
				end;
			elseif v36:FindFirstChild("UpperTorso") and v36:FindFirstChild("UpperTorso"):FindFirstChild("Target") then
				v36.UpperTorso.Target:Destroy();
			end;
		end;
	end);
	game:GetService("RunService"):BindToRenderStep("Stabber", 1, function()
		if u2 then
			for v41, v42 in pairs(game.Workspace:GetChildren()) do
				if v42:FindFirstChild("Humanoid") and v42:FindFirstChild("HumanoidRootPart") and v42.Name ~= l__LocalPlayer__3.Name and v42.Humanoid.Health > 0 and l__LocalPlayer__3:DistanceFromCharacter(v42.HumanoidRootPart.Position) <= 7 then
					v13();
				end;
			end;
		end;
	end);
end;
local v43 = script.HasteTrail:Clone();
v43.Parent = v4.UpperTorso;
v43.Attachment0 = v4.UpperTorso.NeckAttachment;
v43.Attachment1 = v4.UpperTorso.WaistRigAttachment;
l__Parent__2.Equipped:connect(function()
	if l__Parent__2:FindFirstChild("DualEffect") then
		PlayedAnimation:Play()
		end
	u2 = true;
	if _G.Sleight then
		u9 = 1.53;
		u11 = 0.6;
	end;
	if _G.Haste then
		v43.Enabled = true;
		l__LocalPlayer__3.Character.Humanoid.WalkSpeed = 18;
	end;
end);
l__Parent__2.Unequipped:connect(function()
	if l__Parent__2:FindFirstChild("DualEffect") then
		PlayedAnimation:Stop()
	end
	if _G.Haste then
		l__LocalPlayer__3.Character.Humanoid.WalkSpeed = 16;
		v43.Enabled = false;
	end;
	u2 = false;
	u6 = false;
	u1.ThrowCharge:Stop();
	u1.ThrowCharge:Speed(u9);
	spawn(function()
		wait(0.1);
		u10 = false;
	end);
end);
