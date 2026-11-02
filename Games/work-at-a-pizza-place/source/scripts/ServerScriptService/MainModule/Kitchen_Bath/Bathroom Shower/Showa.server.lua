
local model = script:WaitForChild("ObjectPointer").Value
local water = model.Water


on = false
function click(player)
	 if on then
		on = false
		water.Transparency = 1
		workspace.Main.FurnitureSound:FireAllClients(water.Sound,model,"Pause")
	else
		on = true
		water.Transparency = 0.5
		workspace.Main.FurnitureSound:FireAllClients(water.Sound,model,"Play")
	end
end

model.ClickDetector.MouseClick:connect(click)

