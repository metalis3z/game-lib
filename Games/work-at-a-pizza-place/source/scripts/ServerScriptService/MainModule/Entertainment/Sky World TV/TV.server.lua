local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local screen = model.Screen.SurfaceGui
local owner = house.Owner.Value


local function onMouseClick(Player)
	workspace.Main.ShowVideoCollection:FireClient(Player,owner,model)
end
screen.ClickDetector.MouseClick:connect(onMouseClick)