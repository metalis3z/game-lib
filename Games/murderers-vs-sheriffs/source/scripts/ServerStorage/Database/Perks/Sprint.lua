-- Decompiled with the Synapse X Luau decompiler.

local GameGUI = script.Parent.Parent.Parent.Game;
local PerkButton = (game:GetService("UserInputService").TouchEnabled and GameGUI.PerkTouch) or GameGUI.Perk;

local u1 = -30;
return function(p1)
	local l__Character__1 = game.Players.LocalPlayer.Character;
	if time() - u1 >= 33 then
		u1 = time();
		l__Character__1.Humanoid.WalkSpeed = 24;
		game.ReplicatedStorage.EnableSprintTrail:InvokeServer()
		for v2 = 1, 3 do
			PerkButton.Cooldown.TextColor3 = Color3.new(0.01568627450980392, 0.7098039215686275, 0.06274509803921569);
			PerkButton.Cooldown.Text = 3 - v2 + 1;
			wait(1);
			PerkButton.Cooldown.Text = 3 - v2 + 1;
		end;
		l__Character__1.Humanoid.WalkSpeed = 16;
		for v3 = 1, 30 do
			PerkButton.Cooldown.TextColor3 = Color3.new(0.8862745098039215, 0.1568627450980392, 0.17254901960784313);
			PerkButton.Cooldown.Text = 30 - v3 + 1;
			wait(1);
			PerkButton.Cooldown.Text = 30 - v3 + 1;
		end;
		PerkButton.Cooldown.Text = "";
	end;
end;
