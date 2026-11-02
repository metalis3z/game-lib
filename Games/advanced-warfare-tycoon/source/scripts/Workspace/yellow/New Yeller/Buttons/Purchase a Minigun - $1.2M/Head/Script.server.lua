function change()
	wait(.02)
	if script.Parent.Transparency == 1 then
		script.Parent.PointLight.Enabled = false
	elseif
		script.Parent.Transparency == 0 then
		script.Parent.PointLight.Enabled = true
	end
end
script.Parent.Changed:connect(change)