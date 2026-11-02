while true do
	wait()
	if script.Parent.Configuration.StunTime.Value > 0 then
		script.Parent.Stunning.Value = 1
		workspace.Blinded.Value = true
	elseif script.Parent.Configuration.StunTime.Value == 0 then
		script.Parent.Stunning.Value = 0
	end
end