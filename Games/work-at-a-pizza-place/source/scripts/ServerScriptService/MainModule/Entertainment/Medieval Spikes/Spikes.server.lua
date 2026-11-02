local model = script:WaitForChild("ObjectPointer").Value

function touch(hit)


	if hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		hit.Parent.Humanoid.Health = 0
	end
end


local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object == model.Hurt then
		touch(hit)
	end
end)