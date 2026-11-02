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

while wait(1) do
	if game.Players.LocalPlayer:FindFirstChild("stored"):FindFirstChild("Bank") then
		script.Parent.Text = "Balance: $"..comma_value(game.Players.LocalPlayer:FindFirstChild("stored"):FindFirstChild("Bank").Value)
	else
		script.Parent.Text = "Balance: Unknown"
	end
end