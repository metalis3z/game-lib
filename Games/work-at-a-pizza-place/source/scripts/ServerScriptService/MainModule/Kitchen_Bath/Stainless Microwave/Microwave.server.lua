local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

micro = model.Window


is_on = false
function onMouseClick(player)
	if not is_on then
		is_on = true
		micro.BrickColor = BrickColor.new(106)
		wait(10)
		micro.BrickColor = BrickColor.new(1002)
		workspace.Main.FurnitureSound:FireAllClients(model.Window.Sound,model,"Play")
		is_on = false
	end
end
model.ClickDetector.MouseClick:connect(onMouseClick)
