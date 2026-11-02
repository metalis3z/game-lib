-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v2 = game["Run Service"];
local l__UserInputService__3 = game:GetService("UserInputService");
local l__TweenService__4 = game:GetService("TweenService");
local v5 = {};
local l__CollectionService__1 = game:GetService("CollectionService");
local u2 = require(script.Parent.Main);
spawn(function()
	for v6 = 1, math.huge do
		local v7 = 0;
		local v8 = 0;
		local v9 = game["Run Service"].RenderStepped:wait();
		for v10, v11 in pairs(l__CollectionService__1:GetTagged("ShadowLight")) do
			wait();
			if v11 and v11:IsA("Light") then
				v7 = v7 + 1;
				local l__Parent__12 = v11.Parent;
				if l__Parent__12:IsA("Attachment") then
					if (u2.cam.CFrame.p - l__Parent__12.WorldPosition).Magnitude < 100 then
						v11.Shadows = true;
						v8 = v8 + 1;
					else
						v11.Shadows = false;
					end;
				elseif l__Parent__12:IsA("BasePart") then
					if (u2.cam.CFrame.p - l__Parent__12.Position).Magnitude < 100 then
						v11.Shadows = true;
						v8 = v8 + 1;
					else
						v11.Shadows = false;
					end;
				else
					warn(v11:GetFullName() .. " parent is neither a part nor an attachment");
				end;
			end;
		end;
	end;
end);
