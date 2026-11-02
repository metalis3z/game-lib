local OpenP = script.Parent
local Opener = script.Parent.Parent.Parent.Constraint
local OpenS = script.Parent.Parent.Parent.Main.Open
local CloseS = script.Parent.Parent.Parent.Main.Close

OpenP.Triggered:Connect(function()
	Opener.TargetPosition = 0
	script.Enabled = false
	script.Parent.Open.Enabled = true
	CloseS:Play()
end)
