script.Parent.AncestryChanged:connect(function()
	script.Parent.Music:Play()
	script.Parent.Beep:Play()
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 15..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 14..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 13..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 12..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 11..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 10..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 9..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 8..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 7..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 6..."
	wait(1)
	script.Parent.Music.Volume = 0.25
	script.Parent.Text = "Respawning in 5..."
	wait(1)
	script.Parent.Music.Volume = 0.2
	script.Parent.Text = "Respawning in 4..."
	wait(1)
	script.Parent.Music.Volume = 0.15
	script.Parent.Text = "Respawning in 3..."
	wait(1)
	script.Parent.Music.Volume = 0.1
	script.Parent.Text = "Respawning in 2..."
	wait(1)
	script.Parent.Music.Volume = 0.05
	script.Parent.Text = "Respawning in 1..."
	wait(1)
	script.Parent.Music.Volume = 0
	script.Parent.Beep:Stop()
	script.Parent.Music:Stop()
end)