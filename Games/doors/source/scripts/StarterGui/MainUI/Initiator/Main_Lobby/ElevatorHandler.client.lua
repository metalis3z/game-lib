-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(script.Parent);
local v4 = game["Run Service"];
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Humanoid__6 = v3.char:WaitForChild("Humanoid");
local l__LobbyElevators__7 = workspace:WaitForChild("Lobby"):WaitForChild("LobbyElevators");
v3.cam.FieldOfView = 80;
local u1 = nil;
local u2 = nil;
local l__TweenService__3 = game:GetService("TweenService");
local l__Parent__4 = script.Parent.Parent.Parent;
local u5 = { v1:WaitForChild("LobbyFrame"):WaitForChild("SideButtons"), v1:WaitForChild("LobbyFrame"):WaitForChild("Shop"), v1:WaitForChild("LobbyFrame"):WaitForChild("Achievements") };
local l__GuiService__6 = game:GetService("GuiService");
local u7 = CFrame.new(0, 0, 0);
l__Humanoid__6:GetAttributeChangedSignal("InGameElevator"):Connect(function()
	local v8 = l__Humanoid__6:GetAttribute("InGameElevator");
	if v8 == nil then
		u1 = nil;
		if u2 then
			u2:Cancel();
		end;
		l__TweenService__3:Create(v3.cam, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			FieldOfView = 80
		}):Play();
		v3.cam.CameraType = Enum.CameraType.Custom;
		l__Parent__4.LobbyFrame.ExitElevator.Visible = false;
		script.Sound_Leave:Play();
		u5[1].Visible = true;
		l__GuiService__6.SelectedObject = nil;
		return;
	end;
	if v8 == 999 then
		l__Parent__4.LobbyFrame.ExitElevator.Visible = false;
		u2 = l__TweenService__3:Create(v3.cam, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			CFrame = u7, 
			FieldOfView = 30
		});
		u2:Play();
		l__Parent__4.LobbyFrame.LoadingUI.Visible = true;
		l__TweenService__3:Create(l__Parent__4.LobbyFrame.LoadingUI, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			BackgroundTransparency = 0, 
			TextTransparency = 0
		}):Play();
		l__TweenService__3:Create(script.Parent.Music, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		l__TweenService__3:Create(game.SoundService.Main, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		script.Parent.MusicEnd:Play();
		return;
	end;
	for v9, v10 in pairs(workspace:WaitForChild("Lobby"):WaitForChild("LobbyElevators"):GetChildren()) do
		if v10:GetAttribute("ID") == l__Humanoid__6:GetAttribute("InGameElevator") then
			for v11, v12 in pairs(u5) do
				v12.Visible = false;
				l__GuiService__6.SelectedObject = nil;
			end;
			l__Parent__4.LobbyFrame.ExitElevator.Warning.Visible = false;
			u1 = v10.DoorHitbox;
			l__Parent__4.LobbyFrame.ExitElevator.Visible = true;
			script.Sound_Enter:Play();
			v3.cam.CameraType = Enum.CameraType.Scriptable;
			v3.cam.CFrame = v3.cam.CFrame;
			u7 = CFrame.new(v10.DoorHitbox.Position + v10.DoorHitbox.CFrame.LookVector * -14 + Vector3.new(0, 2, 0), v10.DoorHitbox.Position + Vector3.new(0, 1, 0));
			u2 = l__TweenService__3:Create(v3.cam, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				CFrame = u7, 
				FieldOfView = 50
			});
			u2:Play();
		end;
	end;
end);
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("ElevatorMaxWarning").OnClientEvent:Connect(function()
	l__Parent__4.LobbyFrame.ExitElevator.Warning.Visible = true;
end);
l__Parent__4.LobbyFrame.ExitElevator.MouseButton1Down:Connect(function()
	v3.remotes.LobbyElevatorExit:FireServer();
end);
l__UserInputService__5.InputBegan:Connect(function(p1, p2)
	if p2 then
		return;
	end;
	if p1.KeyCode == Enum.KeyCode.ButtonB then
		v3.remotes.LobbyElevatorExit:FireServer();
	end;
end);
