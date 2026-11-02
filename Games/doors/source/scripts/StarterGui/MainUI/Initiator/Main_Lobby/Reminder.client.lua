-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local v2 = require(script.Parent);
local v3 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v4 = game["Run Service"];
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Parent__1 = script.Parent.Parent.Parent;
local l__TweenService__2 = game:GetService("TweenService");
function v2.titlelocation(p1)
	coroutine.wrap(function()
		local v6 = l__Parent__1.LobbyFrame.Intro:Clone();
		if l__Parent__1.LobbyFrame:FindFirstChild("LiveIntro") then
			l__Parent__1.LobbyFrame:FindFirstChild("LiveIntro"):Destroy();
		end;
		local v7 = game:GetService("ReplicatedStorage").Sounds:FindFirstChild("LA_" .. p1);
		if v7 then
			v7:Play();
		end;
		v6.Name = "LiveIntro";
		v6.Visible = true;
		v6.Text = p1;
		v6.Parent = l__Parent__1.LobbyFrame;
		l__TweenService__2:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0, 
			TextStrokeTransparency = 1
		}):Play();
		l__TweenService__2:Create(v6.Underline, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Size = UDim2.new(0.5, 0, 0, 6)
		}):Play();
		wait(1);
		l__TweenService__2:Create(v6, TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			BackgroundTransparency = 1, 
			TextTransparency = 1, 
			TextStrokeTransparency = 2
		}):Play();
		l__TweenService__2:Create(v6.Underline, TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Size = UDim2.new(0.25, 0, 0, 6), 
			ImageTransparency = 1
		}):Play();
		game.Debris:AddItem(v6, 10);
	end)();
end;
local u3 = {};
local u4 = 0;
function v2.remind(p2, p3)
	coroutine.wrap(function()
		if table.find(u3, p2) ~= nil then
			return;
		end;
		table.insert(u3, p2);
		if u4 >= 1 then
			u4 = u4 + 1;
			wait((u4 - 1) * 8);
		end;
		u4 = u4 + 1;
		local v8 = l__Parent__1.LobbyFrame.Tip:Clone();
		if p3 == true then
			v8 = l__Parent__1.LobbyFrame.Warning:Clone();
		end;
		v8.Name = "LiveTip";
		v8.Visible = true;
		v8.Text = p2;
		v8.Parent = l__Parent__1.LobbyFrame;
		l__TweenService__2:Create(v8, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.9, 0)
		}):Play();
		l__TweenService__2:Create(v8.Glow, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
			Size = UDim2.new(2, 0, 10, 0), 
			ImageTransparency = 0
		}):Play();
		wait(7.5);
		l__TweenService__2:Create(v8, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			TextTransparency = 1, 
			TextStrokeTransparency = 1
		}):Play();
		game.Debris:AddItem(v8, 10);
		u4 = u4 - 1;
		print(u4);
	end)();
end;
function v2.caption(p4, p5)
	coroutine.wrap(function()
		local v9 = l__Parent__1.LobbyFrame.Caption:Clone();
		if l__Parent__1.LobbyFrame:FindFirstChild("LiveCaption") then
			l__Parent__1.LobbyFrame:FindFirstChild("LiveCaption"):Destroy();
		end;
		if p5 == true then
			v9 = l__Parent__1.LobbyFrame.Caption:Clone();
		end;
		v9.Name = "LiveCaption";
		v9.Visible = true;
		v9.Text = p4;
		v9.Parent = l__Parent__1.LobbyFrame;
		l__TweenService__2:Create(v9, TweenInfo.new(7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			BackgroundTransparency = 1, 
			TextTransparency = 1, 
			TextStrokeTransparency = 2
		}):Play();
		l__TweenService__2:Create(v9, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			BackgroundColor3 = Color3.new(0, 0, 0)
		}):Play();
		script.Caption:Play();
		game.Debris:AddItem(v9, 10);
	end)();
end;
game:GetService("ReplicatedStorage").EntityInfo.Caption.OnClientEvent:Connect(function(p6, p7)
	v2.caption(p6, p7);
end);
game:GetService("ReplicatedStorage").EntityInfo.Remind.OnClientEvent:Connect(function(p8, p9)
	v2.remind(p8, p9);
end);
