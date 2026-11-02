local MainFrame = script.Parent.Parent["MainFrame"]
local MainFrame2 = script.Parent.Parent["MainFrame2"]

function OnClicked()
	if MainFrame2.Visible == true then
		MainFrame.Visible = false
		MainFrame.Visible = true
	end
end

script.Parent.MouseButton1Click:Connect(OnClicked)