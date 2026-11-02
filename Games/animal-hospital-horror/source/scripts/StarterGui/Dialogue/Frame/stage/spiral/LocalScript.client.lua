while true do
	script.Parent.Rotation = (script.Parent.Rotation + 1) % 360
	game:GetService("RunService").RenderStepped:wait()
end