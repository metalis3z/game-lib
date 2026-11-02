local Tool = script.Parent;

enabled = true

function onButton1Down(mouse)
	
	x2 = math.random(1, 7)
	
	if x2 == 1 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Snake"
	end
	
	if x2 == 2 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Turtle"
	end
	
	if x2 == 3 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Leopard"
	end
	
	if x2 == 4 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Falcon"
	end
	
	if x2 == 5 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Giraffe"
	end
	
	if x2 == 6 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Bison"
	end
	
	if x2 == 7 then
		game.Players.LocalPlayer.Data.DevilFruit.Value = "Wolf"
	end
	
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
