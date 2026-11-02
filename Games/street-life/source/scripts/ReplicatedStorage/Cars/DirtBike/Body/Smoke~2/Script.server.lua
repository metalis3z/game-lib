local pe = script.Parent.Smoke

while wait()do		
	if script.Parent.Parent.Parent.DriveSeat.Throttle == 1 then	
		pe.Enabled = true
	elseif script.Parent.Parent.Parent.DriveSeat.Throttle == 0 then
		pe.Enabled = false
	end														
end