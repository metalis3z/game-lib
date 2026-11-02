if not game:IsLoaded() then game.Loaded:Wait() end

local Check = function()
	local childNames = {}

	for _, existingChild in ipairs(script.Parent.Frame:GetChildren()) do
		if childNames[existingChild.Name] then
			existingChild:Destroy()
		else
			childNames[existingChild.Name] = true
		end
	end
end

script.Parent.Frame.ChildAdded:Connect(function(Child)
	for _ = 1, 25 do
		Check()
		task.wait(.025)
	end
end)

if game:FindService('UserInputService').GamepadEnabled then
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('UpdateDevice', 'Controller')
elseif game:FindService('UserInputService').TouchEnabled and not game:FindService('UserInputService').MouseEnabled then
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('UpdateDevice', 'Mobile')
elseif game:FindService('UserInputService').KeyboardEnabled and game:FindService('UserInputService').MouseEnabled then
	game:FindService('ReplicatedStorage'):FindFirstChild('ControllerRemote'):FireServer('UpdateDevice', 'Keyboard')
end