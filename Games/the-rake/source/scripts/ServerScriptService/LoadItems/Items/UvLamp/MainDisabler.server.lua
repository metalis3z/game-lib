while true do
	wait()
	if script.Parent.Power.Value == 0 then
		repeat
			wait()
			script.Parent.UsePower.Disabled = true
			script.Parent.On.Value = 0
			script.Parent.PowerEnabler.Disabled = true
			script.Parent.MainScript.Disabled=true
			script.Parent.OnScript.Disabled=true
		until  script.Parent.Power.Value == 200
	elseif script.Parent.Power.Value == 200 then
		script.Parent.MainScript.Disabled=false
		script.Parent.OnScript.Disabled=false
	end
end