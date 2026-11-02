
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

game.ReplicatedStorage.GiveMoney.OnClientEvent:Connect(function(plr, amount)
	script.Parent.Text = plr.." has gave you "..comma_value(amount).." money!"
	script.ching:Play()
	wait(3)
	script.Parent.Text = ""
end)