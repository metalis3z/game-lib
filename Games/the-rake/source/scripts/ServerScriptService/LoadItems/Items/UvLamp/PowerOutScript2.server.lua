while true do
	wait()
	if workspace.PowerOutValue.Value == 1 then
		script.Parent.PowerOutScript.Disabled = true
		script.Parent.Script2.Disabled = true
		script.Parent.Script.Disabled = true
		--script.Parent.OnScript.Disabled = true
		script.Parent.MainScript.Disabled = true
		script.Parent.On.Value=3
		script.Parent.UsePower.Disabled=true
		script.Parent.PowerRecharge.Disabled = true
		script.Parent.PowerRecharge2.Disabled = true
		wait()
		script.Parent.Power.Value = 1		
	elseif workspace.PowerOutValue.Value == 0 then
		script.Parent.PowerRecharge.Disabled = false
		script.Parent.PowerOutScript.Disabled = false
		script.Parent.Script2.Disabled = false
		script.Parent.Script.Disabled = false
		--script.Parent.OnScript.Disabled = false
		script.Parent.MainScript.Disabled = false
	end
end