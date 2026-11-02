local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end
function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local enabled = true

script.Parent.ProximityPrompt.Triggered:Connect(function(p)
	if GetDistance(p.Character.PrimaryPart, script.Parent) > 7 then
		return print("too far")
	end
	
	if p.Character.Humanoid.Health == 0 then return print("bro dead") end
	
	if not enabled then return end
	enabled = false
	
	local whoDrop = script.Parent:FindFirstChild("From").Value
	local whoDropName = "Unknown"
	if whoDrop then
		if whoDrop.Name then whoDropName = whoDrop.Name end
	end
	
	if not script.Parent:FindFirstChild("DROPPED") then
		whoDropName = whoDropName.. " (DEATH)"
	end
	
	local amt = script.Parent.Amount.Value

	game.ReplicatedStorage.MoneyLog:Fire(p.Name.. " picked up $"..comma_value(amt),"Dropped by "..whoDropName)
	
	
	p:FindFirstChild("stored"):FindFirstChild("Money").Value += amt
	game.ReplicatedStorage.server:FireClient(p,"money","+$"..tostring(comma_value(amt)).."!")
	
	return script.Parent:Destroy()
end)