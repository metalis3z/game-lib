local Cooldown = 30;
local ActiveTime = 4;
local LastUse = -Cooldown;

local GameGUI = script.Parent.Parent.Parent.Game;
local PerkButton = GameGUI.Perk;

return function()
	if time()-LastUse >= Cooldown+ActiveTime then
		LastUse = time();
		
		local FindMap;
		for i,Part in pairs(game.Workspace:GetChildren()) do
			if Part:FindFirstChild("Spawns") then
				FindMap = Part;
			end
		end
		if FindMap ~= nil then
			local function SpreadInvis(Part)
				for _,Child in pairs(Part:GetChildren()) do
					if Child:IsA("BasePart") then
						if Child.Transparency == 0 then
							Child.Transparency = 0.912;
						end
					end
					SpreadInvis(Child);
				end
			end
			SpreadInvis(FindMap);
			
			for i = 1,ActiveTime do
				PerkButton.Cooldown.TextColor3 = Color3.new(4/255,181/255,16/255);
				PerkButton.Cooldown.Text = (ActiveTime-i)+1;
				wait(1);
				PerkButton.Cooldown.Text = (ActiveTime-i)+1;
			end
						
			local function SpreadNormal(Part)
				for _,Child in pairs(Part:GetChildren()) do
					if Child:IsA("BasePart") then
						if Child.Transparency < 0.913 and Child.Transparency > 0.911 then
							Child.Transparency = 0;
						end
					end
					SpreadNormal(Child);
				end
			end
			SpreadNormal(FindMap);
			
			for i = 1,Cooldown do
				PerkButton.Cooldown.TextColor3 = Color3.new(226/255,40/255,44/255);
				PerkButton.Cooldown.Text = (Cooldown-i)+1;
				wait(1);
				PerkButton.Cooldown.Text = (Cooldown-i)+1;
			end
		end		
		PerkButton.Cooldown.Text = "";
	end
end