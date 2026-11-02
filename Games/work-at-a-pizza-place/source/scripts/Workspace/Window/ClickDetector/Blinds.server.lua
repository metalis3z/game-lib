local detector = script.Parent
function onMouseClick(Player)
	if Player.TeamColor == BrickColor.new(37) then

	   if detector.Parent.Transparency == 0 then
			detector.Parent.Transparency = 0.8
			detector.Parent.Reflectance = .6
		else
			detector.Parent.Transparency = 0
			detector.Parent.Reflectance = 1
		end
	end
end
detector.Detector.Event:connect(onMouseClick)
