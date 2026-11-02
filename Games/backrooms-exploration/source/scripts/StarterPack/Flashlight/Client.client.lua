local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local Tool = script.Parent
local Remote = Tool:WaitForChild("Remote")

function onMouseMove()
	Remote:FireServer("UpdateDirection", Mouse.Hit.p)
end

function onMouseClick()
	Remote:FireServer("ToggleLight")
end


Mouse.Button1Down:connect(onMouseClick)

