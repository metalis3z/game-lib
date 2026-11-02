local BloodHourText = workspace.NightmareHourText

while wait(0.1) do
	if BloodHourText.Value == true then
	script.parent.Frame.Text.Visible = true
end

	if BloodHourText.Value == false then
		script.parent.Frame.Text.Visible = false
end

end