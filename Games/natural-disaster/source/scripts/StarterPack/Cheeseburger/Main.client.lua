local Player=game.Players.LocalPlayer
local Mouse=Player:GetMouse()
local Deb=false
local Tool=script.Parent
Mouse.Button1Down:connect(function()
	if script.Parent.Enabled==false then return end
	if Deb==true then return end
	Deb=true
	Tool.GripForward = Vector3.new(-.981, .196, 0)
	Tool.GripPos = Vector3.new(-.5, -0.6, -1.5)
	Tool.GripRight = Vector3.new(0, -0, -1)
	Tool.GripUp = Vector3.new(0.196, .981, 0)
	script.Parent.Handle.DrinkSound:Play()
	wait(2)
	Tool.GripForward = Vector3.new(-1, 0, 0)
	Tool.GripPos = Vector3.new(-.5, -.1, 0)
	Tool.GripRight = Vector3.new(0, 0, 1)
	Tool.GripUp = Vector3.new(0,1,0)
	Deb=false
end)

script.Parent.Equipped:connect(function()
	script.Parent.Handle.OpenSound:Play()
	script.Parent.Enabled=true
end)
script.Parent.Unequipped:connect(function()
	script.Parent.Enabled=false
end)