local model = script:WaitForChild("ObjectPointer").Value
print("Soccer started")
debounce = false
function touch(hit)
	print("Touched")
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		model.Soccer.Anchored = false
		last_kicked = 2
		model.Soccer.Velocity = hit.Parent.HumanoidRootPart.CFrame.lookVector * 50
	elseif not debounce and hit.Name == "Goal" then
		model.Soccer.Anchored = true
		model.Soccer.Velocity = Vector3.new(0,0,0)
		model.Soccer.RotVelocity = Vector3.new(0,0,0)
		debounce = true
		wait(3)
		debounce = false
		model.Soccer.Position = model.Spawn.Position
		model.Soccer.Anchored = false
		
	end
end
	
local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object == model.Soccer then
		touch(hit)
	end
end)




last_kicked = 1000
while true do
	wait(10)
	if last_kicked > 0 then
		last_kicked = last_kicked - 1
		if last_kicked == 0 then
			last_kicked = 10000
			model.Soccer.Position = model.Spawn.Position
			model.Soccer.Anchored = true
			debounce = false
		end
	end
end
