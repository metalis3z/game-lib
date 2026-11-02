wait(0.1)
local Human = script.Parent:WaitForChild("Humanoid")
local LastHealth = Human.Health

Human.Changed:Connect(function()
if Human.Health > LastHealth then
LastHealth = Human.Health
end
if Human.Health < LastHealth and LastHealth > 30 then
LastHealth = Human.Health
		local RandomSound = math.random(1,9)
		if RandomSound == 1 then
			script.Parent.Head.Hurt1:Play()
	    elseif RandomSound == 2 then
			script.Parent.Head.Hurt2:Play()
		elseif RandomSound == 3 then
			script.Parent.Head.Hurt3:Play()	
		elseif RandomSound == 4 then
			script.Parent.Head.Hurt4:Play()	
		elseif RandomSound == 5 then
			script.Parent.Head.Hurt5:Play()	
		elseif RandomSound == 6 then
			script.Parent.Head.Hurt6:Play()	
		elseif RandomSound == 7 then
			script.Parent.Head.Hurt7:Play()	
		elseif RandomSound == 8 then
			script.Parent.Head.Hurt8:Play()	
		elseif RandomSound == 9 then
			script.Parent.Head.Hurt9:Play()	
end
end
end)