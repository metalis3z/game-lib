local u1 = -30;
local l_Player_0 = game.Players.LocalPlayer;
local l_Perk_0 = script.Parent;
game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("PerkService").PerkActivated.Event:Connect(function()
	if l_Player_0 ~= nil and l_Perk_0 ~= nil then
		if time() - u1 >= l_Perk_0:GetAttribute("Cooldown") then
			if l_Player_0:GetAttribute("EquippedPerk") == "Ghost" then
				u1 = time();
				l_Perk_0:SetAttribute("LastUse", os.clock());
				game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(true);
				task.wait(l_Perk_0:GetAttribute("ActiveTime"));
				game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(false);
			end;
		end;
	end;
end);