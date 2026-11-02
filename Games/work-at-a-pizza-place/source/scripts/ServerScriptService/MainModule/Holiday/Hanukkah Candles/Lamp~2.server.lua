local model = script:WaitForChild("ObjectPointer").Value

function onMouseClick(Player)
    local light = model.Lamp.PointLight
    if light.Enabled then
        light.Enabled = false
	else
	  	light.Enabled = true
    end
end
model.ClickDetector.MouseClick:connect(onMouseClick)
