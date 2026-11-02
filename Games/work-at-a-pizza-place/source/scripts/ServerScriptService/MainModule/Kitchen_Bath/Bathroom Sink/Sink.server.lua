local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
water = model.Water1
water2 = model.Water2






on = false
function click(player)
	 if on then
		on = false
		water.Transparency = .5
		water2.Transparency = .5
	else
		on = true
		water.Transparency = 1
		water2.Transparency = 1
	end
end

model.ClickDetector.MouseClick:connect(click)

