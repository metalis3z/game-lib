local button = script.Parent.Interactive
local running = false
local full = false
local stream = script.Parent.Stream
local fakeCoffee = script.Parent.FakeCoffee
local Coffee = script.Parent.Coffee
local pot = script.Parent.CoffeePot
local brewSound = pot.Brew

button.ClickDetector.MouseClick:Connect(function()
	if not running and not full then
		running = true
		brewSound:Play()
		fakeCoffee.Transparency = 0
		for i = 1, 10 do
			stream.Mesh.Scale = stream.Mesh.Scale + Vector3.new(0.04, 0, 0.04)
			fakeCoffee.Mesh.Scale = fakeCoffee.Mesh.Scale + Vector3.new(0, 0.03, 0)
			fakeCoffee.Mesh.Offset = fakeCoffee.Mesh.Offset + Vector3.new(0, 0.003, 0)
			wait(.05)
		end
		for i = 1, 72 do
			fakeCoffee.Mesh.Scale = fakeCoffee.Mesh.Scale + Vector3.new(0, 0.03, 0)
			fakeCoffee.Mesh.Offset = fakeCoffee.Mesh.Offset + Vector3.new(0, 0.003, 0)
			wait(.05)
		end
		for i = 1, 10 do
			stream.Mesh.Scale = stream.Mesh.Scale + Vector3.new(-0.04, 0, -0.04)
			fakeCoffee.Mesh.Scale = fakeCoffee.Mesh.Scale + Vector3.new(0, 0.03, 0)
			fakeCoffee.Mesh.Offset = fakeCoffee.Mesh.Offset + Vector3.new(0, 0.003, 0)
			wait(.05)
		end
		Coffee.Transparency = 0
		wait()
		fakeCoffee.Transparency = 1
		fakeCoffee.Mesh.Scale = Vector3.new(1,0,1)
		fakeCoffee.Mesh.Offset = Vector3.new(0, 0, 0)
		pot.ClickDetector.MaxActivationDistance = 12
		full = true
		running = false
	end
end)

pot.ClickDetector.MouseClick:Connect(function(player)
	if not running and full then
		full = false
		Coffee.Transparency = 1
		pot.ClickDetector.MaxActivationDistance = 0
		game:GetService("InsertService"):LoadAsset(32199868):GetChildren()[1].Parent = player.Backpack
	end	
end)