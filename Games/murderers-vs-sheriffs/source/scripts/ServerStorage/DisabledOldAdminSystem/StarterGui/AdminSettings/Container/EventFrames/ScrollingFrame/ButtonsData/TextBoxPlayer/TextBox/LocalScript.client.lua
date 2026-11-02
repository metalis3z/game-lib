local Players = game:GetService("Players")
local TextBox = script.Parent
local MIN_INPUT_LENGTH = 2
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	local input = TextBox.Text:lower()
	if #input < MIN_INPUT_LENGTH then return end
	for _, player in pairs(Players:GetPlayers()) do
		local nameLower = player.Name:lower()
		if nameLower:find(input, 1, true) then
			TextBox.Text = player.Name
			TextBox.CursorPosition = #player.Name + 1
			break
		end
	end
end)