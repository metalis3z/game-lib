local uis = game:GetService("UserInputService")
local Clicked = false

function onKeyPressed(inputObject)
	if inputObject.KeyCode == Enum.KeyCode.E and script.Parent.Parent.Canbeused.Value == true and script.Parent.Parent.Attacking2.Value == false and script.Parent.Parent.equipped.Value == true then
		script.Parent.RemoteEvent:FireServer()
	end
end
uis.InputBegan:Connect(onKeyPressed)