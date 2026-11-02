-- Styled buttons show their text in a child "Label" (so the button's gradient does not tint the text).
-- Scripts keep writing button.Text; this mirrors it into the label.
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local function bind(label)
	if not (label:IsA("TextLabel") and label:GetAttribute("MirrorText")) then return end
	local button = label.Parent
	if not (button and button:IsA("TextButton")) then return end
	label.Text = button.Text
	button:GetPropertyChangedSignal("Text"):Connect(function() label.Text = button.Text end)
end

playerGui.DescendantAdded:Connect(bind)
for _, descendant in playerGui:GetDescendants() do bind(descendant) end
