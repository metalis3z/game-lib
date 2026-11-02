local MainFrame = script.Parent.Parent["MainFrame"]
local MainFrame2 = script.Parent.Parent["MainFrame2"]

function OnClicked()
	if MainFrame.Visible == true then
		MainFrame.Visible = false
		MainFrame2.Visible = true
	end
end

script.Parent.MouseButton1Click:Connect(OnClicked)