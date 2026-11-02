local Tool = script.Parent;

enabled = true

function onButton1Down(mouse)
	
	if not enabled then
		return
	end
	
	x = game.Workspace:FindFirstChild(script.Parent.Value.Value)
	x.Humanoid.Health = x.Humanoid.Health - 70

	enabled = false
	script.Parent.Part.BrickColor = BrickColor.new("Bright red")
	script.Parent.Part.Transparency = 0.1
	script.Parent.Heart.Animate.Disabled = true
	script.Parent.Heart.Mesh.Scale = Vector3.new(0.3, 0.27, 0.3)
	script.Parent.Part.Mesh.Scale = Vector3.new(0.75, 0.75, 0.75)
	wait(1)
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
