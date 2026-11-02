local Tool = script.Parent;

enabled = true

function onButton1Down(mouse)
	
	game.Players.LocalPlayer.Data.DevilFruit.Value = "Smoke"
	
	if not enabled  then
		return
	end

	enabled = false
	Tool.GripForward = Vector3.new(0.164, -0.986, 0)
	Tool.GripPos = Vector3.new(-1.5, -0.8, -0.9)
	Tool.GripRight = Vector3.new(-0.986, -0.164, 0)
	Tool.GripUp = Vector3.new(0, 0, 1)
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
