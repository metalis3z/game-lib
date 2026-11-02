script.Parent:WaitForChild("Body")
script.Parent.Body:WaitForChild("HealthVal")
script.Parent.Body:WaitForChild("Bonnet")
local health = script.Parent.Body.HealthVal
local maxHealth = health.Value
local bonnet = script.Parent.Body.Bonnet
local radius = 25
local multiplier = 3
local deb = false

health.Changed:connect(function()
	if health.Value <= 0 then
		--script.Parent.Essentials.VehicleSeat:Destroy()
		if not deb then
			deb = true
			wait(2)
			local e = Instance.new("Explosion")
			e.Position = script.Parent:GetModelCFrame().p
			e.BlastPressure = 0
			e.BlastRadius = radius
			e.Parent = workspace
			e.Hit:connect(function(part,dist)
				if part.Parent:FindFirstChild("HealthVal") and ((part.Name == "Primary" and part.Parent ~= script.Parent.Body) or part.Parent.Name == "") then				
					part.Parent.HealthVal.Value = part.Parent.HealthVal.Value - ((multiplier*2*radius/dist)^2.5)
				elseif game.Players:GetPlayerFromCharacter(part.Parent) then
					part.Parent.Humanoid:TakeDamage((multiplier*radius/dist)^1.5)
				end
			end)
			script.Parent:BreakJoints()
			game:GetService("Debris"):AddItem(script.Parent,5)
		end
	elseif health.Value < 0.1*maxHealth then
		--Fire
		bonnet.Fire.Enabled = true
		bonnet.Smoke.Enabled = true
		bonnet.Smoke.Color = BrickColor.new("Black").Color
	elseif health.Value < 0.4*maxHealth then
		--Dark smoke
		bonnet.Fire.Enabled = false
		bonnet.Smoke.Enabled = true
		bonnet.Smoke.Color = BrickColor.new("Dark stone grey").Color
	elseif health.Value < 0.6*maxHealth then
		--Light smoke
		bonnet.Fire.Enabled = false
		bonnet.Smoke.Enabled = true
		bonnet.Smoke.Color = BrickColor.new("Mid gray").Color
	else
		--Fire
		bonnet.Fire.Enabled = false
		bonnet.Smoke.Enabled = false
	end
end)