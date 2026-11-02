local Tool = script.Parent;

enabled = true

function onButton1Down(mouse)
	
	game.Players.LocalPlayer.Data.DevilFruit.Value = "Bomb"
	
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(-0,-0,1)
	Tool.GripPos = Vector3.new(-1.5, -0.7, 0.5)
	Tool.GripRight = Vector3.new(-1, 0, 0)
	Tool.GripUp = Vector3.new(0, 1, 0)
	wait(1)
	game.Players.LocalPlayer.Character.Humanoid.Health = 0
	script.Parent:remove()

end

function onEquippedLocal(mouse)

	if mouse == nil then
		print("Mouse not found")
		return 
	end

	mouse.Icon = "rbxasset://textures\\ArrowCursor.png"
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end


Tool.Equipped:connect(onEquippedLocal)
