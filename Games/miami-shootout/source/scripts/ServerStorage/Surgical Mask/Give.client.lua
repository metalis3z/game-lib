local P = game.Players.LocalPlayer
local M = P:GetMouse()

local Equ = false

script.Parent.Equipped:Connect(function()
	Equ = true
end)

script.Parent.Unequipped:Connect(function()
	Equ = false
end)

M.KeyDown:Connect(function(Key)
	if Key == "g" and Equ == true then
		if M.Target ~= nil and M.Target.Parent:FindFirstChild("Humanoid") then
			script.Parent.DropTool:FireServer(M.Target.Parent)
		end
	end
end)