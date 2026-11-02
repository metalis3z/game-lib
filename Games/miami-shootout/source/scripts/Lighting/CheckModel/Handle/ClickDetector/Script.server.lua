local loot = true
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

script.Parent.MouseClick:Connect(function(p)
	if tostring(p.Name) ~= tostring(script.Parent.Parent.Parent.For.Value) then return end
	if loot == false then return end
	loot = false
	
	p:FindFirstChild("stored"):FindFirstChild("Bank").Value = p:FindFirstChild("stored"):FindFirstChild("Bank").Value + script.Parent.Parent.Parent.Price.Value
	
	game.ReplicatedStorage.server:FireClient(p,"money","+$"..tostring(comma_value(script.Parent.Parent.Parent.Price.Value)).."!")
	
	script.Parent.MaxActivationDistance = 0
	script.Parent.Parent.Parent:Destroy()
end)