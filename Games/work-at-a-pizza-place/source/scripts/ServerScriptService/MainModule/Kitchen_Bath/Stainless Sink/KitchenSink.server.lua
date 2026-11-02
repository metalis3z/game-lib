local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
flow = model.Flow
water = model.Water.Mesh
water2 = model.Water2.Mesh

flowing = false

function onMouseClick(player)
	water.Scale = Vector3.new(1,1,1)
	water.Offset = Vector3.new(0,0,0)
	water2.Scale = Vector3.new(1,1,1)
	if not flowing then
		flowing = true
		water.Parent.Transparency = 0.5
		water2.Parent.Transparency = 0.5
		flow.Transparency = 0.5
		
		for i=1,11.5,.5 do
			wait(1)
			if flowing == false then return end
			water.Scale = Vector3.new(1,i,1)
		end
		wait(1)
		if flowing == false then return end
		water.Offset = Vector3.new(0,-.5,0)
		water.Scale = Vector3.new(2.3, 17, 1.3)
		
		for i=1,12,.5 do
			wait(1)
			if flowing == false then return end
			water2.Scale = Vector3.new(i,1,i)
		end
		
	else
		flowing = false
		water.Parent.Transparency = 1
		water2.Parent.Transparency = 1
		flow.Transparency = 1
	end
	
	

end
model.ClickDetector.MouseClick:connect(onMouseClick)
