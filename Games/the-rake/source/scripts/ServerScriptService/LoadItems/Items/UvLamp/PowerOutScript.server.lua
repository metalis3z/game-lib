while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.MainScript.Disabled = true
		script.Parent.On.Value=0
		script.Parent.UsePower.Disabled=true
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.MainScript.Disabled = false
	end
end