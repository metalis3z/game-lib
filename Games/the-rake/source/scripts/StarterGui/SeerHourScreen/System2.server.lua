local BloodHourText = workspace.SeerHourText

while wait(0.1) do
	if BloodHourText.Value == true then
		script.parent.Frame.Text.Visible = true
		script.Parent.Frame.Text2.Visible = true
end

	if BloodHourText.Value == false then
		script.parent.Frame.Text.Visible = false
		script.Parent.Frame.Text2.Visible = false
end

end