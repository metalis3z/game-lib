pod = script.Parent

function onTouched(part)
	wait(.1)
	part.Reflectance = 0.2 
	wait(.4)
	part.Reflectance = 0.4
	wait(.4)				--all this makes it freeze (duh.....)
	part.Reflectance = 0.2
	wait(.5)
	part.Reflectance = 0
	wait(.6)
	part.Reflectance = 1
        part.Anchored = true
	wait(90000)
	part.Reflectance = 1
        part.Anchored = false
end

connection = pod.Touched:connect(onTouched)