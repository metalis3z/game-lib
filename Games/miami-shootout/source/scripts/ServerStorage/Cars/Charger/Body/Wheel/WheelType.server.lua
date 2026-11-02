wait(1)
local sound = math.random(1, 2)
		if sound == 1 then--Rim1
	script.Parent.Parent.Wheels.FL.Parts.Rim2:Destroy()
	script.Parent.Parent.Wheels.FR.Parts.Rim2:Destroy()
	script.Parent.Parent.Wheels.RR.Parts.Rim2:Destroy()
	script.Parent.Parent.Wheels.RL.Parts.Rim2:Destroy()	
	end

if sound == 2 then--Rim2
	script.Parent.Parent.Wheels.FL.Parts.Rim1:Destroy()
	script.Parent.Parent.Wheels.FR.Parts.Rim1:Destroy()
	script.Parent.Parent.Wheels.RR.Parts.Rim1:Destroy()
	script.Parent.Parent.Wheels.RL.Parts.Rim1:Destroy()
end