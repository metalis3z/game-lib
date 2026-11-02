local Type = script.Parent
local TypeS = Type.Parent.Keys.Typing

Type.Triggered:Connect(function()
	TypeS:Play()
end)
