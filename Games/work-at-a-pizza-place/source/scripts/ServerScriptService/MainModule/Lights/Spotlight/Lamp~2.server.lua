local lamp = script:WaitForChild("ObjectPointer").Value
local detector = lamp.ClickDetector
local light = lamp.Lamp.SpotLight
function onMouseClick(Player)
    if light.Enabled then
        light.Enabled = false
	else
	  	light.Enabled = true
    end
end
detector.MouseClick:connect(onMouseClick)
