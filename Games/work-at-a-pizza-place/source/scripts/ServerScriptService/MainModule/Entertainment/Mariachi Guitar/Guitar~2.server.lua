local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
guitar = model.Guitar

pitch = {.89,1,1.13,1.19,1.35,1.5,1.7}
--d=1, e=1.130, f=1.19, g=1.35, a=1.500, b=1.7, c=.89

is_on = false
note = 1

last_minute = 0
math.randomseed(math.floor(tick()))
	math.random()
local debounce = false
function onMouseClick(player)
	if not debounce then
		debounce = true
	
		workspace.Main.FurnitureSound:FireAllClients(guitar.Note,model,"Play",{Pitch = pitch[math.random(1,7)]})
	
		wait(.1)
		debounce = false
	end
end
model.ClickDetector.MouseClick:connect(onMouseClick)

