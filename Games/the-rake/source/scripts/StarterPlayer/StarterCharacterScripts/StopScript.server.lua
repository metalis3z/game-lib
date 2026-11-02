while true do
	wait()
	if script.Stop.Value == true then
		script.Parent.Humanoid.WalkSpeed = 0
		script.Parent.RunScript.Disabled = true
		
	elseif script.Stop.Value == false then
			script.Parent.Humanoid.WalkSpeed = 10
			script.Parent.RunScript.Disabled = false
	end
end