require(game.ReplicatedStorage:WaitForChild("Lib"))
task.wait(3)

if not game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled then
	return
end

script.Parent.Size = UDim2.new(0.75, 0, 0.625, 0)
script.Parent.Position = UDim2.new(0.5, 0, 0.38, 0)