local Remote = game.ReplicatedStorage.WeaponEvent
local Decline = script.Parent.Decline
local accept = script.Parent.Accept

accept.MouseButton1Click:Connect(function()
	Remote:FireServer()
	script.Parent.Visible = false
end)

Decline.MouseButton1Click:Connect(function()
	script.Parent.Visible = false
end)