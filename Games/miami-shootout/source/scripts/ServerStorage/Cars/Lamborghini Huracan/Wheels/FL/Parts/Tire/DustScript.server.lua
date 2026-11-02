while wait(0.25) do
function onTouched(part)		
	
	if part.Name == "Sand" and script.Parent.Velocity.Magnitude > 15 then
		script.Parent.Dust.Enabled = true
	else
		script.Parent.Dust.Enabled = false
	end
	
end

script.Parent.Touched:connect(onTouched)

end