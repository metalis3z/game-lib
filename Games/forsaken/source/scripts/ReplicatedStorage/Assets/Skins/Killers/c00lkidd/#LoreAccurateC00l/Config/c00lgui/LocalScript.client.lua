local screenGui = script.Parent
local textButton = screenGui:WaitForChild("Open / Close")
local frame = screenGui:WaitForChild("Frame")

local function toggleFrameVisibility()
	frame.Visible = not frame.Visible
	if frame.Visible then
		textButton.Text = "<"
	else
		textButton.Text = ">"
	end
end

textButton.MouseButton1Click:Connect(toggleFrameVisibility)
