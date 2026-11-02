local Light = script.Parent.Parent.Light;
local Sensor = script.Parent;
local Cooldown = 0;

local function Beep()
	Cooldown = time();
	Light.Material = "Neon";
	Light.BrickColor = BrickColor.new("Bright red");
	Light.SLight.Enabled = true;
	Sensor.Sound:Play();
	wait(1);
	Light.SLight.Enabled = false;
	Light.Material = "Plastic";
	Light.BrickColor = BrickColor.new("Dark stone grey");
end


Sensor.Touched:connect(function(HitPart)
	if time()-Cooldown > 1 then
		
		for _,Part in pairs(HitPart.Parent:GetChildren()) do
			if Part:FindFirstChild("KnifeServer") then
				Beep();
			end
		end
		if game.Players:GetPlayerFromCharacter(HitPart.Parent) then
			for _,Tool in pairs(game.Players:GetPlayerFromCharacter(HitPart.Parent).Backpack:GetChildren()) do
				if Tool:FindFirstChild("KnifeServer") then
					Beep();
				end
			end 
		end	
			
	end;
end)