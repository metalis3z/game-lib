local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
drum = model.Drum



math.randomseed(math.floor(tick()))
math.random()

local debounce = false
function onMouseClick(player)
	if not debounce then
		debounce = true
	
		workspace.Main.FurnitureSound:FireAllClients(drum.Note,model,"Play")
		
		wait(.1)
		debounce = false
	end
	
end
model.ClickDetector.MouseClick:connect(onMouseClick)

