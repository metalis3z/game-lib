local u1 = -30;
local l_Player_0 = game.Players.LocalPlayer;
local l_Perk_0 = script.Parent;
game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("PerkService").PerkActivated.Event:Connect(function()
	if l_Player_0 ~= nil and l_Perk_0 ~= nil then
		if time() - u1 >= l_Perk_0:GetAttribute("Cooldown") then
			if l_Player_0:GetAttribute("EquippedPerk") == "Xray" then
				u1 = time();
				l_Perk_0:SetAttribute("LastUse", os.clock());
				local v2 = nil;
				for v3, v4 in pairs(game.Workspace:GetChildren()) do
					if v4:FindFirstChild("Spawns") then
						v2 = v4;
					end;
				end;
				if v2 ~= nil then
					for v5, v6 in pairs(v2:GetDescendants()) do
						if v6:IsA("BasePart") and v6.Transparency == 0 then
							v6.Transparency = 0.912;
						end;
					end;
					task.wait(l_Perk_0:GetAttribute("ActiveTime"));
					for v7, v8 in pairs(v2:GetDescendants()) do
						if v8:IsA("BasePart") and v8.Transparency < 0.913 and v8.Transparency > 0.911 then
							v8.Transparency = 0;
						end;
					end;
				end;
			end;
		end;
	end;
end);