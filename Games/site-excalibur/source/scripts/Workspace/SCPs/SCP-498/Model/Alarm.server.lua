function on()
	script.Parent.SoundPart.AlarmSound:Play()
	script.on.Value = true
	wait(0.1)
	repeat script.Parent.SoundPart.AlarmSound.Volume = script.Parent.SoundPart.AlarmSound.Volume + 0.1 wait(1)
	until script.on.Value == false
end

script.Parent.Play.ClickDetector.MouseClick:connect(on)

function off()
	script.Parent.SoundPart.AlarmSound:Stop()
	script.Parent.SoundPart.AlarmSound = 1
	script.on.Value = false
end

script.Parent.Snooze.ClickDetector.MouseClick:connect(off)