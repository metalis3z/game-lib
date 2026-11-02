-- Define the walk speed when the tool is not in use
local originalWalkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

-- Define the walk speed when the tool is in use
local newWalkSpeed = originalWalkSpeed / 3  -- Adjust this value to change the new walk speed

-- Function to lower the walk speed when the tool is activated
local function onActivated()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = newWalkSpeed
end

-- Function to restore the original walk speed when the tool is deactivated
local function onDeactivated()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalWalkSpeed
end

-- Function to check if the input is a touch event
local function isTouchEvent(inputObject)
	return inputObject.UserInputType == Enum.UserInputType.Touch
end

-- Function to check if the input is a left mouse button click
local function isLeftClickEvent(inputObject)
	return inputObject.UserInputType == Enum.UserInputType.MouseButton1
end

-- Connect the functions to the tool's events
tool = script.Parent
tool.Activated:Connect(onActivated)
tool.Deactivated:Connect(onDeactivated)

-- Check if the user is on mobile or PC and connect the appropriate input events
if game:GetService("UserInputService").TouchEnabled then
	tool.TouchStarted:Connect(function(inputObject)
		if isTouchEvent(inputObject) then
			onActivated()
		end
	end)
	tool.TouchEnded:Connect(function(inputObject)
		if isTouchEvent(inputObject) then
			onDeactivated()
		end
	end)
else
	tool.InputBegan:Connect(function(inputObject)
		if isLeftClickEvent(inputObject) then
			onActivated()
		end
	end)
	tool.InputEnded:Connect(function(inputObject)
		if isLeftClickEvent(inputObject) then
			onDeactivated()
		end
	end)
end
