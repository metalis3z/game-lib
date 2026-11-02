-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local u1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u2 = script:FindFirstAncestor("MainUI");
local l__TweenService__3 = game:GetService("TweenService");
game.ReplicatedStorage.EntityInfo.AchievementUnlock.OnClientEvent:Connect(function(p2)
	local v2 = u1[p2]:GetInfo();

	if script:GetAttribute(p2) == true then
		print("camel already have this badge")
		return
	end

	print("MUHAHAHA")
	if v2 then
		script:SetAttribute(p2, true)
		local v3 = u2.AchievementsHolder.Achievement:Clone();
		v3.Size = UDim2.new(0, 0, 0, 0);
		v3.Frame.Position = UDim2.new(1.1, 0, 0, 0);
		v3.Name = "LiveAchievement";
		v3.Visible = true;
		for v4, v5 in pairs(v2) do
			local v6 = v3.Frame.Details:FindFirstChild(v4);
			if v6 then
				v6.Text = v5;
			end;
		end;
		--if v2.Image then
		--	v3.Frame.ImageLabel.Image = v2.Image;
		if v2.BadgeId then
			v3.Frame.ImageLabel.Image = "rbxassetid://" .. game.BadgeService:GetBadgeInfoAsync(v2.BadgeId).IconImageId;
		end;
		v3.Parent = u2.AchievementsHolder;
		v3.Sound:Play();
		v3:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.8, true);
		wait(0.8);
		v3.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
		l__TweenService__3:Create(v3.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			ImageTransparency = 1
		}):Play();
		wait(8);
		v3.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true);
		wait(0.5);
		v3:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true);
		wait(0.5);
		v3:Destroy();
	end;
end)