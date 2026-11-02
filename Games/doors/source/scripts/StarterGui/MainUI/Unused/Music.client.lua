-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(script.Parent.Main);
local v2 = require(script.Parent.Modules.Spring);
local v3 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v4 = game["Run Service"];
local l__UserInputService__5 = game:GetService("UserInputService");
local l__TweenService__6 = game:GetService("TweenService");
local l__Music_Calm__7 = script:WaitForChild("Music_Calm");
local l__Music_Stress__8 = script:WaitForChild("Music_Stress");
l__Music_Calm__7:Play();
l__Music_Stress__8:Play();
local v9 = 0;
local u1 = 0;
script.Parent.Event_Stress.Event:Connect(function(p1)
	u1 = u1 + p1;
end);
while true do
	wait(1);
	local u2 = v9;
	pcall(function()
		l__Music_Stress__8.TimePosition = l__Music_Calm__7.TimePosition;
		u1 = math.clamp(u1 - 1, 0, 20);
		local v10 = math.clamp(u1 / 25, 0, 0.5);
		if u2 == v10 then
			u2 = v10;
			return;
		end;
		local v11 = l__TweenService__6:Create(l__Music_Stress__8, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
			Volume = v10 * 0.4, 
			Pitch = 1 + v10 / 5
		});
		l__TweenService__6:Create(l__Music_Calm__7, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
			Volume = (0.5 - v10) * 0.2, 
			Pitch = 1 + v10 / 5
		}):Play();
		v11:Play();
		u2 = v10;
	end);
end;
