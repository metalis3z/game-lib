local Cooldown = 20;
local ActiveTime = 5;
local LastUse = -Cooldown;

local GameGUI = script.Parent.Parent.Parent;
local PerkButton = GameGUI.Perk;

return function()
	if time()-LastUse >= Cooldown+ActiveTime then
		LastUse = time();
		game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(true);
		
		for i = 1,ActiveTime do
			PerkButton.Cooldown.TextColor3 = Color3.new(4/255,181/255,16/255);
			PerkButton.Cooldown.Text = (ActiveTime-i)+1;
			wait(1);
			PerkButton.Cooldown.Text = (ActiveTime-i)+1;
		end
		
		game.ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(false);
		
		for i = 1,Cooldown do
			PerkButton.Cooldown.TextColor3 = Color3.new(226/255,40/255,44/255);
			PerkButton.Cooldown.Text = (Cooldown-i)+1;
			wait(1);
			PerkButton.Cooldown.Text = (Cooldown-i)+1;
		end;
		PerkButton.Cooldown.Text = "";
	end
end