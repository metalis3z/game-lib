blueCount = 0
redCount = 0
cframes = {}
local model = script:WaitForChild("ObjectPointer").Value

ball = model.Ball





function reset()

	for _,i in ipairs(model:GetChildren()) do
		if i.Name == "Pin" or i.Name == "Ball" then
			--i.Anchored = true
			i.Velocity = Vector3.new(0,0,0)
			i.RotVelocity = Vector3.new(0,0,0)
			i.CFrame = cframes[i]
		end
	end
end

function anchored(a)
	for _,i in ipairs(model:GetChildren()) do
		if i.Name == "Pin" or i.Name == "Ball" then
			i.Anchored = a
		end
	end
end


--[[function kick(hit)
	
	if  hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		
		anchored(false)
		wait()
		ball.Velocity = hit.Parent.Torso.CFrame.lookVector * 100
		wait(5)
		reset()
	--elseif hit.Name == "Pin" then
		--hit.Velocity = Vector3.new(hit.Velocity.x ,hit.Velocity.y + 20,hit.Velocity.z)
	end
end
ball.Touched:connect(kick)]]





for _,i in ipairs(model:GetChildren()) do
	if i.Name == "Pin" or i.Name == "Ball" then
		cframes[i] = i.CFrame
		i.Anchored = false
	end
end


local debounce = false
function touch(hit)
	if not debounce and hit ~= nil and hit.Parent ~= nil then
		if hit.Parent:FindFirstChild("Humanoid") ~= nil then
			debounce = true
			ball.Velocity = hit.Parent.HumanoidRootPart.CFrame.lookVector * 200
			reset()
			debounce = false
		end
	end
end
	



local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object.Parent == model then
		touch(hit)
	end
end)

