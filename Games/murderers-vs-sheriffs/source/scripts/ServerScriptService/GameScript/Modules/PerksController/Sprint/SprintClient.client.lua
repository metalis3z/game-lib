local u1 = -30;
local l_Player_0 = game.Players.LocalPlayer;
local l_Perk_0 = script.Parent;
game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("PerkService").PerkActivated.Event:Connect(function()
	if l_Player_0 ~= nil and l_Perk_0 ~= nil then
		if time() - u1 >= l_Perk_0:GetAttribute("Cooldown") then
			if l_Player_0:GetAttribute("EquippedPerk") == "Sprint" then
				u1 = time();
				l_Perk_0:SetAttribute("LastUse", os.clock());
				script.Parent.Activate:FireServer(true);
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 24;
				task.wait(l_Perk_0:GetAttribute("ActiveTime"));
				script.Parent.Activate:FireServer(false);
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16;
			end;
		end;
	end;
end);