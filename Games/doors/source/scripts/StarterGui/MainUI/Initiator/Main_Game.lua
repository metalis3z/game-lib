-- Script GUID: {DF19C323-8062-449F-9FBA-C521075152B8}
-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = script:FindFirstAncestor("MainUI");
local v3 = require(v2.Modules.Spring);
print("Look behind you");
print("PATCH: 8/22 A2");
while true do
	wait();
	if game.Players.LocalPlayer.Character then
		break;
	end;
end;
v1.char = game.Players.LocalPlayer.Character;
v1.hum = v1.char:WaitForChild("Humanoid");
workspace.CurrentCamera:Destroy();
wait();
local l__TweenService__4 = game:GetService("TweenService");
v1.ax_t = 0;
v1.ay_t = 0;
v1.az_t = 0;
v1.ax = 0;
v1.ay = 0;
v1.az = 0;
v1.cam = workspace.CurrentCamera;
v1.basecamcf = v1.cam.CFrame;
v1.cam.CameraSubject = v1.char:WaitForChild("Humanoid");
v1.cam.CameraType = Enum.CameraType.Scriptable;
v1.remotes = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
v1.s = {
	reducemotion = true
};
v1.ce = {};
v1.spring = v3.new(Vector3.new(0, 0, 0));
v1.spring:__newindex("Damper", 0.5);
v1.spring:__newindex("Speed", 8);
v1.recoil_spring = v3.new(Vector3.new(0, 0, 0));
v1.recoil_spring:__newindex("Damper", 0.7);
v1.recoil_spring:__newindex("Speed", 9);
v1.hrc = false;
v1.bobspring = v3.new(Vector3.new(0, 0, 0));
v1.bobspring:__newindex("Damper", 0.9);
v1.bobspring:__newindex("Speed", 10);
v1.crouching = false;
v1.sprinting = false;
v1.aiming = false;
v1.holdclick = false;
v1.holdjump = false;
v1.freemouse = false;
v1.stunned = false;
v1.viewmodel = script.ViewModel;
v1.spectarget = nil;
v1.finalCamCFrame = nil;
v1.tool = nil;
v1.an = nil;
v1.dead = false;
v1.fakeTool = nil;
v1.sightui = nil;
v1.aimph = 0;
v1.fovspring = 90;
v1.fovtarget = 70;
v1.ti = nil;
v1.camlock = nil;
v1.camlockHead = 0;
v1.stopcam = false;
v1.deathtick = tick();
v1.hideplayers = 0;
v1.hotbarenabled = true;
v1.tooloffset = Vector3.new(0, 0, 0);
v1.chase = false;
v1.hiding = false;
v1.camlockedoffset = { 0, 0 };
v1.camShakerModule = require(game:GetService("ReplicatedStorage"):WaitForChild("CameraShaker"));
v1.csgo = CFrame.new(0, 0, 0);
v1.gd = game:GetService("ReplicatedStorage"):WaitForChild("GameData");
v1.platform = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"))();
v1.camShaker = v1.camShakerModule.new(200, function(p1)
	v1.csgo = p1;
end);
v1.camShaker:Start();
v1.camShaker:StartShake(2, 0.5, 2, Vector3.new(0, 0, 0));
v1.camShaker:StartShake(0.5, 1, 2, Vector3.new(0, 0, 0));
for v5, v6 in pairs(script:GetChildren()) do
	if v6:IsA("LocalScript") then
		v6.Disabled = false;
	end;
end;
local l__StarterGui__7 = game:GetService("StarterGui");
l__StarterGui__7:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
l__StarterGui__7:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false);
l__StarterGui__7:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
v1.mouse = game.Players.LocalPlayer:GetMouse();
v1.mouse.Icon = "rbxassetid://7767604747";
if v1.char:FindFirstChild("Shirt") then
	v1.char.Shirt:Clone().Parent = v1.viewmodel;
end;
for v8, v9 in pairs(v1.viewmodel:GetChildren()) do
	if v9:IsA("BasePart") and v1.char:FindFirstChild(v9.Name) then
		v9.Color = v1.char:FindFirstChild(v9.Name).Color;
	end;
end;
for v10, v11 in pairs(script:GetChildren()) do
	if v11:IsA("BindableEvent") then
		v1.ce[v11.Name] = v11;
	end;
end;
v2:WaitForChild("MainFrame");
v2:WaitForChild("LobbyFrame").Visible = false;
function v1.update()
	pcall(function()
		if v1.freemouse == true then
			v1.mouse.Icon = "";
		else
			v1.mouse.Icon = "rbxassetid://2833720882";
		end;
		if v1.freemouse or v1.dead then
			v2.MainFrame.Visible = false;
		else
			v2.MainFrame.Visible = true;
		end;
		if v1.dead then
			v1.hideplayers = -1;
		end;
		if v1.hideplayers > 1 then
			pcall(function()
				if v1.char.PrimaryPart.LocalTransparencyModifier < 1 then
					for v12, v13 in pairs(v1.char:GetDescendants()) do
						if v13:IsA("BasePart") then
							l__TweenService__4:Create(v13, TweenInfo.new(1), {
								LocalTransparencyModifier = 1
							}):Play();
						end;
					end;
				end;
			end);
			return;
		end;
		if v1.hideplayers < -0.1 and v1.char:FindFirstChild("Head") then
			if v1.char.Head.LocalTransparencyModifier > 0 then
				for v14, v15 in pairs(v1.char:GetDescendants()) do
					if v15:IsA("BasePart") then
						l__TweenService__4:Create(v15, TweenInfo.new(0.05), {
							LocalTransparencyModifier = 0
						}):Play();
					end;
				end;
				return;
			end;
		elseif v1.dead == false then
			for v16, v17 in pairs(v1.char:GetDescendants()) do
				if v17:IsA("BasePart") then
					v17.LocalTransparencyModifier = 1;
					if v17.Parent == v1.char or not (not v17:FindFirstAncestorOfClass("Tool")) or v17:FindFirstChildOfClass("WrapLayer") then
						if v17.Name == "Torso" or v17.Name == "Head" then
							v17.LocalTransparencyModifier = 1;
						else
							v17.LocalTransparencyModifier = 0;
						end;
					end;
				end;
			end;
			return;
		else
			for v18, v19 in pairs(v1.char:GetDescendants()) do
				if v19:IsA("BasePart") then
					v19.LocalTransparencyModifier = 0;
				end;
			end;
		end;
	end);
end;
function v1.playaudio(p2, p3, p4, p5, p6)
	local u1 = p6;
	local u2 = p5;
	local u3 = p2;
	local v20, v21 = pcall(function()
		if not u1 then
			u1 = 1;
		end;
		local v22 = nil;
		if p3 ~= nil then
			if p3:IsA("Attachment") then
				v22 = p3.WorldPosition;
			else
				v22 = p3.Position;
			end;
		end;
		pcall(function()
			if u2 then
				u3.RollOffMaxDistance = u2;
				if not (u2 < 50) then
					return;
				end;
			else
				u2 = u3.RollOffMaxDistance;
				return;
			end;
			u3.RollOffMinDistance = 2;
		end);
		if p3 and u3 and v22 and (v1.cam.CFrame.p - v22).Magnitude < math.clamp(u2, 0, 500) then
			u3 = u3:Clone();
			u3.Parent = p3;
			if p4 and p4 == true then
				local l__Magnitude__23 = (v1.cam.CFrame.p - v22).Magnitude;
				if l__Magnitude__23 > 5 then
					local v24 = RaycastParams.new();
					v24.CollisionGroup = "NoPlayer";
					v24.FilterDescendantsInstances = { p3, v1.char };
					local v25 = workspace:Raycast(v1.cam.CFrame.p, (v22 - v1.cam.CFrame.p).unit * l__Magnitude__23, v24);
					if v25 then
						local l__Position__26 = v25.Position;
						if l__Position__26 and (l__Position__26 - v1.cam.CFrame.p).Magnitude < l__Magnitude__23 - 4 then
							local v27 = l__Magnitude__23 + math.abs(l__Position__26.Y - v1.cam.CFrame.p.y) * 3;
							local v28 = Instance.new("EqualizerSoundEffect");
							v28.HighGain = -l__Magnitude__23 * 0.25 / u1;
							v28.MidGain = -l__Magnitude__23 * 0.125 / u1;
							v28.LowGain = -l__Magnitude__23 * 0.025 / u1;
							v28.Parent = u3;
						end;
					end;
				end;
			end;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 4000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
			return;
		end;
		if u3 and p3 then
			return;
		end;
		if u3 then
			u3 = u3:Clone();
			u3.Parent = v1.char;
			u3.Pitch = u3.Pitch + math.random(-100, 100) / 4000;
			u3:Play();
			game.Debris:AddItem(u3, u3.TimeLength * u3.Pitch + 2);
		end;
	end);
	if v21 then
		warn(v21);
	end;
end;
v1.update();
task.spawn(function()
	for v29 = 1, 30 do
		v1.update();
		wait(0.1);
	end;
end);

function v1.titlelocation(p1)
	coroutine.wrap(function()
		local v6 = script.Parent.Parent.MainFrame.Intro:Clone();
		if script.Parent.Parent.MainFrame:FindFirstChild("LiveIntro") then
			script.Parent.Parent.MainFrame:FindFirstChild("LiveIntro"):Destroy();
		end;
		local v7 = game:GetService("ReplicatedStorage").Sounds:FindFirstChild("LA_" .. p1);
		if v7 then
			v7:Play();
		end;
		v6.Name = "LiveIntro";
		v6.Visible = true;
		v6.Text = p1;
		v6.Parent = script.Parent.Parent.MainFrame;
		game:GetService("TweenService"):Create(v6, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0, 
			TextStrokeTransparency = 1
		}):Play();
		game:GetService("TweenService"):Create(v6.Underline, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Size = UDim2.new(0.5, 0, 0, 6)
		}):Play();
		wait(1);
		game:GetService("TweenService"):Create(v6, TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			BackgroundTransparency = 1, 
			TextTransparency = 1, 
			TextStrokeTransparency = 2
		}):Play();
		game:GetService("TweenService"):Create(v6.Underline, TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Size = UDim2.new(0.25, 0, 0, 6), 
			ImageTransparency = 1
		}):Play();
		game.Debris:AddItem(v6, 10);
	end)();
end;
local u3 = {};
local u4 = 0;
function v1.remind(p2, p3)
	coroutine.wrap(function()
		if table.find(u3, p2) ~= nil then
			return;
		end;
		table.insert(u3, p2);
		if u4 >= 1 then
			u4 = u4 + 1;
			wait((u4 - 1) * 6);
		end;
		u4 = u4 + 1;
		local v8 = script.Parent.Parent.MainFrame.Tip:Clone();
		if p3 == true then
			v8 = script.Parent.Parent.MainFrame.Warning:Clone();
		end;
		v8.Name = "LiveTip";
		v8.Visible = true;
		v8.Text = p2;
		v8.Parent = script.Parent.Parent.MainFrame;
		game:GetService("TweenService"):Create(v8, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.9, 0)
		}):Play();
		game:GetService("TweenService"):Create(v8.Glow, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
			Size = UDim2.new(2, 0, 10, 0), 
			ImageTransparency = 0
		}):Play();
		wait(6);
		game:GetService("TweenService"):Create(v8, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			TextTransparency = 1, 
			TextStrokeTransparency = 1
		}):Play();
		game.Debris:AddItem(v8, 10);
		u4 = u4 - 1;
	end)();
end;
function v1.caption(p4, p5, p6)
	local u5 = p6;
	coroutine.wrap(function()
		local v9 = script.Parent.Parent.MainFrame.Caption:Clone();
		if script.Parent.Parent:FindFirstChild("LiveCaption") then
			script.Parent.Parent:FindFirstChild("LiveCaption"):Destroy();
		end;
		if p5 == true then
			v9 = script.Parent.Parent.MainFrame.Caption:Clone();
		end;
		v9.Name = "LiveCaption";
		v9.Visible = true;
		v9.Text = p4;
		v9.Parent = script.Parent.Parent;
		if not u5 then
			u5 = 7;
		end;
		game:GetService("TweenService"):Create(v9, TweenInfo.new(u5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			BackgroundTransparency = 1, 
			TextTransparency = 1, 
			TextStrokeTransparency = 2
		}):Play();
		game:GetService("TweenService"):Create(v9, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			BackgroundColor3 = Color3.new(0, 0, 0)
		}):Play();
		script.Caption:Play();
		game.Debris:AddItem(v9, 10);
	end)();
end;
return v1; 