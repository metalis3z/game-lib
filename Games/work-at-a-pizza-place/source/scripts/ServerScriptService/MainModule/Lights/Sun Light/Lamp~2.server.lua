local lamp = script:WaitForChild("ObjectPointer").Value
local detector = lamp.ClickDetector
local light = lamp.Lamp.PointLight
local function onMouseClick(Player)
    local light = detector.Parent.Lamp.PointLight
    if light.Enabled then
		light.Parent.Material = Enum.Material.SmoothPlastic--"Smooth Plastic"
        light.Enabled = false
	else
		light.Parent.Material = "Neon"
	  	light.Enabled = true
    end
end
detector.MouseClick:connect(onMouseClick)
