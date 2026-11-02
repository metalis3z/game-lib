--local Light = script.Parent.Parent.Light;
local Sensor = script.Parent;
local Cooldown = 0;

local Door = Sensor.Parent.Door;
local Spinner = Door.Spinner;

local function Beep()
	Cooldown = time();
	Sensor.Beep:Play();
	Sensor.Parent.KeyCard.Access.Material = "Neon";
	
	for i = 1,45 do
		Spinner:SetPrimaryPartCFrame( Spinner.Spinner.CFrame * CFrame.Angles(0,0,math.rad(2)) )
		wait(0.03);
	end
	Door.Main.Air:Play();
	wait(0.5);
	Door.Main.Open:Play();
	for i = 1,90 do
		Door:SetPrimaryPartCFrame( Door.Hinge.CFrame * CFrame.Angles(math.rad(-1),0,0) )
		wait(0.03);
	end
	
	wait(180);
	
	for i = 1,45 do
		Spinner:SetPrimaryPartCFrame( Spinner.Spinner.CFrame * CFrame.Angles(0,0,math.rad(-2)) )
		wait(0.03);
	end
	Door.Main.Open:Play();
	for i = 1,90 do
		Door:SetPrimaryPartCFrame( Door.Hinge.CFrame * CFrame.Angles(math.rad(1),0,0) )
		wait(0.03);
	end
	Door.Main.Air:Play();
	
	wait(1);
	
	Sensor.Parent.KeyCard.Access.Material = "SmoothPlastic";

end


Sensor.Touched:connect(function(HitPart)
	if time()-Cooldown > 180 then
		
		for _,Part in pairs(HitPart.Parent:GetChildren()) do
			if Part:FindFirstChild("IsGun") then
				Beep();
			end
		end
		if game.Players:GetPlayerFromCharacter(HitPart.Parent) then
			for _,Tool in pairs(game.Players:GetPlayerFromCharacter(HitPart.Parent).Backpack:GetChildren()) do
				if Tool:FindFirstChild("IsGun") then
					Beep();
				end
			end 
		end	
			
	end;
end)