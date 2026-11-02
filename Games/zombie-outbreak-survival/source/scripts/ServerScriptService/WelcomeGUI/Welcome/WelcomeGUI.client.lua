local Gui = script.Parent
local Warning = Gui:WaitForChild("Warning")
local closeButton = Warning:WaitForChild("Close")

---------
-- Setup --
---------

-- Hide all contents initially
for _, child in ipairs(Warning:GetChildren()) do
	if child:IsA("GuiObject") then
		child.Visible = false
	end
end

Warning.Visible = true
task.wait(1)

-- Show all contents
for _, child in ipairs(Warning:GetChildren()) do
	if child:IsA("GuiObject") then
		child.Visible = true
	end
end

--------
-- Main --
--------

closeButton.MouseButton1Click:Connect(function()
	-- Hide all elements inside the frame first
	for _, child in ipairs(Warning:GetChildren()) do
		if child:IsA("GuiObject") then
			child.Visible = false
		end
	end
	

	task.wait(0.5)
	Gui:Destroy()
end)