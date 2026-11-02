local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local bubble = model.Bubble

down = false
function touch(hit)
	if not down and hit and hit.Parent and hit.Parent:FindFirstChild("HumanoidRootPart") then
		down = true
		bubble.Mesh.Scale = Vector3.new(2,5,2)
		workspace.Main.FurnitureSound:FireAllClients(bubble.Down,model,"Play")
		
		
		
		
		local torso = hit.Parent.HumanoidRootPart
		while torso and ((torso.Position * Vector3.new(1,0,1)) - (bubble.Position * Vector3.new(1,0,1))).magnitude < 4 do wait(.1)  end
		
		bubble.Mesh.Scale = Vector3.new(1,20,1)
		workspace.Main.FurnitureSound:FireAllClients(bubble.Up,model,"Play")
		down = false
	end
end





local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent ==  model then
		touch(hit)
	end
end)

