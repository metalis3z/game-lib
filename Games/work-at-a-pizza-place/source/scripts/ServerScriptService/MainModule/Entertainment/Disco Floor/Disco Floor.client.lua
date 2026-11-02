print("STARTED")
local colors = {Color3.new(0,255/255,0),Color3.new(255/255,0,0),Color3.new(0,0,255/255),Color3.new(255/255,255/255,0),Color3.new(0,255/255,255/255),Color3.new(255/255,0,255/255)}

local model = script:WaitForChild("ObjectPointer").Value
local floorBillboard = model.Tile.Disco
floorBillboard.Adornee = model.Tile
floorBillboard.Enabled = true
local tiles = floorBillboard:GetChildren()

while true do
	wait(1)
	for _,v in pairs(tiles) do
		v.BackgroundColor3 = colors[math.random(1,#colors)]--Color3.new(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
	end
end





