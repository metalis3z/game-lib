function change()
	wait(.02)
	if script.Parent.Parent.Parent.Parent.Parent.Buttons["Purchase a Nuclear Generator - $19,000"].Head.Transparency == 1 then
		script.Parent.PointLight.Enabled = false
	elseif 
		script.Parent.Parent.Parent.Parent.Parent.Buttons["Purchase a Nuclear Generator - $19,000"].Head.Transparency == 0 then
		script.Parent.PointLight.Enabled = true
	end
end
script.Parent.Parent.Parent.Parent.Parent.Buttons["Purchase a Nuclear Generator - $19,000"].Changed:connect(change)