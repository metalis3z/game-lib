function onClick(hit)		
	script.Parent.Transparency = 0
	script.Parent.CanCollide = true
	wait(2)
	script.Parent.Transparency = 0.5
	script.Parent.CanCollide = false
   end
script.Parent.ClickDetector.MouseClick:connect(onClick)