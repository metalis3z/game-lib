local gui = script.ScreenGui
local colors = {
	[Enum.MessageType.MessageInfo] = Color3.new(0, 0.764706, 1),
	[Enum.MessageType.MessageError] = Color3.new(1, 0, 0),
	[Enum.MessageType.MessageOutput] = Color3.new(1, 1, 1),
	[Enum.MessageType.MessageWarning] = Color3.new(1, 0.85098, 0)
}
game.LogService.MessageOut:Connect(function(msg, msgType)
	if msg:find("The experience doesn't have access permission to use asset id") or msg:find("Failed to load sound") then return end
	local newmsg = script.TextLabel:Clone()
	newmsg.Text = msg
	newmsg.TextColor3 = colors[msgType]
	newmsg.Parent = gui.ScrollingFrame
end)

task.wait(15)
for _, plr in pairs(game.Players:GetPlayers()) do
	gui:Clone().Parent = plr.PlayerGui
end