wait()
script.Parent.Parent.HomePodSoundMain.Audio.Changed:connect(function()
	repeat wait()
		script.Parent.SurfaceGui.ImageLabel.ImageTransparency = script.Parent.SurfaceGui.ImageLabel.ImageTransparency - 0.05
	until script.Parent.SurfaceGui.ImageLabel.ImageTransparency == 0
	wait(2)
	repeat wait()
		script.Parent.SurfaceGui.ImageLabel.ImageTransparency = script.Parent.SurfaceGui.ImageLabel.ImageTransparency + 0.05
	until script.Parent.SurfaceGui.ImageLabel.ImageTransparency >= 1
end)