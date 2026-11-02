wait(1)
l = script.Parent
function A ()
	if l.PointLight.Enabled == true then
	l.PointLight.Enabled = false else
	l.PointLight.Enabled = true
	end
end
l.ClickDetector.MouseClick:connect(A)