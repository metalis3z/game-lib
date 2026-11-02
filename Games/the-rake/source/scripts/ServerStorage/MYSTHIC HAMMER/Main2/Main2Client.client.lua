local uis = game:GetService("UserInputService")
local Clicked = false

function onKeyPressed(inputObject)
	if inputObject.KeyCode == Enum.KeyCode.E and script.Parent.Parent.Available.Value == true then
		script.Parent.RemoteEvent:FireServer()
	end
end
uis.InputBegan:Connect(onKeyPressed)