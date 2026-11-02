wait(1)
cframes = {}
local model = script:WaitForChild("ObjectPointer").Value

ball = model.Ball
hole = model.Hole
cframe = ball.CFrame


function reset()
	last_kicked = 100000
	ball.CFrame = cframe
end

function anchored(a)
	ball.Anchored = a
end
anchored(true)

debounce = false
function kick(hit)
	
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		last_kicked = 2
		debounce = true
		anchored(false)
		
		ball:BreakJoints()
		wait()
	
		ball.Velocity = hit.Parent.HumanoidRootPart.CFrame.lookVector * ((ball.Position - hole.Position).magnitude * 2)
		
		wait(5)
		debounce = false
		anchored(true)
		
	elseif hit.Name == "Hole" then

			anchored(true)
			reset()
	
	end
end


local TouchEvent = Instance.new("RemoteEvent")
TouchEvent.Name = "TouchEvent"
TouchEvent.Parent = model
TouchEvent.OnServerEvent:connect(function(player,hit,object)
	if object == ball then
		kick(hit)
	end
end)

last_kicked = 1000
while true do
	wait(10)
	if last_kicked > 0 then
		last_kicked = last_kicked - 1
		if last_kicked == 0 then
			reset()
		end
	end
end
