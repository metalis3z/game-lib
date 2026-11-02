local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

config = model.Config


local player = house.Owner.Value



colors = {1004,1020,1019,1010,1032,1017,1009,1003}

function click(clicker)

	if clicker == player then
			print(clicker,player)
		for i=1,#colors do
			if model.Config.Value == colors[i] then
				print("BRAH")
				model.Config.Value = colors[((i) % #colors)+1]
				
				break
			end
		end
	end
end
model.ClickDetector.MouseClick:connect(click)

function change()
	print("Changed")
	model.Light.PointLight.Color = BrickColor.new(model.Config.Value).Color
end
model.Config.Changed:connect(change)
wait(1)
change()

