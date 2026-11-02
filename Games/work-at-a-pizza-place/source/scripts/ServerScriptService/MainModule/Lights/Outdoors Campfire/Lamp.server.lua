local lamp = script:WaitForChild("ObjectPointer").Value
local detector = lamp.ClickDetector
local light = lamp.Log.PointLight
local fire = lamp.Log.Fire
local function onMouseClick(Player)

    if light.Enabled then
        light.Enabled = false
		 fire.Enabled = false
	else
	  	light.Enabled = true
		fire.Enabled = true
    end
end
detector.MouseClick:connect(onMouseClick)
