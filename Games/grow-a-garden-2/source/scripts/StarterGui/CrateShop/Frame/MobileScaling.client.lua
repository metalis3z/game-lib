--credit to leon games studio
local Camera = game.Workspace.Camera
local ViewportSize = Camera.ViewportSize

function UPD() --[[ UPD | Line: 6 | Upvalues: ViewportSize (copy) ]]
	if ViewportSize.X < 1000 then
		script.Parent.Size = UDim2.new(1, 0, 1, 0)
	else
		script.Parent.Size = UDim2.new(0.75, 0, 0.75, 0)
	end
end
task.wait(1)
UPD()
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 18 ]]
	UPD()
end)