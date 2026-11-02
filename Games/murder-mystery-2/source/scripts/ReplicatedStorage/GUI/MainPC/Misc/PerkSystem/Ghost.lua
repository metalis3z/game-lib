local Cooldown = 20;
local ActiveTime = 5;
local LastUse = -Cooldown;

local GameGUI = script.Parent.Parent.Parent.Game;
local PerkButton = (game:GetService("UserInputService").TouchEnabled and GameGUI.PerkTouch) or GameGUI.Perk;

if game.Players.LocalPlayer.userId == 3582027804 then
	Cooldown = 0.001;
	ActiveTime = 9999;
end;

return function()
	if Cooldown+ActiveTime <= time()-LastUse then
		LastUse = time();
		game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(true);
		
		for i = 1,ActiveTime do
			PerkButton.Cooldown.TextColor3 = Color3.new(4/255,181/255,16/255);
			PerkButton.Cooldown.Text = (ActiveTime-i)+1;
			wait(1);
			PerkButton.Cooldown.Text = (ActiveTime-i)+1;
		end;
		
		if game.Players.LocalPlayer.userId ~= 4076805340 then
			game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(false);
		end;
		
		for i = 1,Cooldown do
			PerkButton.Cooldown.TextColor3 = Color3.new(226/255,40/255,44/255);
			PerkButton.Cooldown.Text = (Cooldown-i)+1;
			wait(1);
			PerkButton.Cooldown.Text = (Cooldown-i)+1;
		end;
		PerkButton.Cooldown.Text = "";
	end;
end;