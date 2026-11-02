--//AviGaTro - AviGaTro#8430

local Buttons = script.Buttons
Buttons.Parent = script.Parent
local Mobile = game:GetService("UserInputService").TouchEnabled
game:GetService("RunService").Heartbeat:Connect(function()
	if Mobile then
		script.Parent.Buttons.Visible = true
	else return end
end)