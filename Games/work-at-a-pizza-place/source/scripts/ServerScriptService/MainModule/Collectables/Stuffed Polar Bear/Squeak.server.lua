local model = script:WaitForChild("ObjectPointer").Value

debounce = false

function onMouseClick(player)
	if not debounce then
		debounce = true
		workspace.Main.FurnitureSound:FireAllClients(model.Squeaker.Sound,model,"Play")
		wait(.1)
		debounce = false
	end	
end
model.Squeaker.ClickDetector.MouseClick:connect(onMouseClick)
