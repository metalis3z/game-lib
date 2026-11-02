local tool = script.Parent
tool.Equipped:Connect(function()
	local character = tool.Parent
	local grip = character:FindFirstChild("Humanoid") and character:FindFirstChild("Right Arm") and character["Right Arm"]:WaitForChild("RightGrip", 5)
	if (grip) then
		grip:Destroy()
		tool.Motor.Part0 = character["Right Arm"]
	end
end)