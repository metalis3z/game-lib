script.Parent.HealthChanged:connect(function() 
		script.Parent.Parent.Torso.Splatter.Enabled = true
wait(0.8)
script.Parent.Parent.Torso.Splatter.Enabled = false
end)