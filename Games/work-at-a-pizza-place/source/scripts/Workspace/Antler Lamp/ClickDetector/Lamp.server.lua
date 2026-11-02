local detector = script.Parent
function onMouseClick(Player)
	if Player.TeamColor == BrickColor.new(37) then
	    local light = detector.Parent.Lamp.PointLight
	    if light.Enabled then
	        light.Enabled = false
		else
		  	light.Enabled = true
	    end
	end
end
script.Parent.Detector.Event:connect(onMouseClick)
