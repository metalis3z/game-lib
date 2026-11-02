-- // Tung tung tung sahur
-- // Hi

local Players = game:GetService('Players');
local playerList = script.Parent.Screen.Board.PlayerList.ScrollingFrame

Players.PlayerAdded:Connect(function()
	for _, frame in playerList:GetChildren() do
		if frame:IsA("Frame") then
			frame:Destroy()
		end
	end
	for _, plr:Player in Players:GetChildren() do
		local playerIcon = script.Player:Clone()
		if plr.DisplayName ~= plr.Name then
			playerIcon.NameText.Text = plr.DisplayName .. ` <font color="rgb(120,120,120)"><font size="11">@{plr.Name}</font></font>`
		else
			playerIcon.NameText.Text = `@{plr.Name}`
		end
		playerIcon.Parent = playerList
	end
end)