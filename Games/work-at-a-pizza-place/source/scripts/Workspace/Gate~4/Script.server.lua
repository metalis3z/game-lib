--created by Dued1, for kindgom forge
--change the color of script.Parent.Color to specify the team you would like to pass though the gate

debounce = false
 loop = nil
gate_open = false
lockGate = false
function openGate()
	if not lockGate then
		lockGate = true
		local pos = script.Parent.Position
		local size = script.Parent.Size
		local frame = script.Parent.CFrame
		loop = script.Parent.Size.y
			
		for i=0,loop,1.2 do
			wait(.1)--wait(.03)
			script.Parent.Size = Vector3.new(size.x,size.y-i,size.z)
			script.Parent.CFrame = frame + Vector3.new(0,i/2,0)
		end
		
	
		while trucksNearby() do
			wait(3)
	
		end
		closeGate()
	end
end
function distance(to,from)
		if to == nil or from == nil then return 10000 end

	return (to.Position - from.Position).magnitude
end
function trucksNearby()
	if workspace:FindFirstChild("Trucks") == nil then return true end
	local trucks = workspace.Trucks:GetChildren()
	if (#trucks >= 1 and distance(script.Parent,trucks[1]:FindFirstChild("Bottom")) < 60) or (#trucks == 2 and distance(script.Parent,trucks[2]:FindFirstChild("Bottom")) < 60) then
		return true
	else
		return false
	end
end
function closeGate()
		
		pos = script.Parent.Position
		size = script.Parent.Size
		frame = script.Parent.CFrame
		
		
		for i=0,loop,1.2 do
			wait(.1)
			script.Parent.Size = Vector3.new(size.x,size.y+i,size.z)
			script.Parent.CFrame = frame + Vector3.new(0,-i/2,0)
		end
		lockGate = false
		debounce = false

end

function touch(hit)
	
	if not debounce and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then--and hit.Parent.Torso.BrickColor == script.Parent.Parent.Color.BrickColor then
		debounce = true
		openGate()
	end
end


script.Parent.Touched:connect(touch)



script.Parent.ClickDetector.Detector.Event:connect(function() openGate() end)

while true do
	wait(1)
	if trucksNearby() then
		openGate()
	end
end
	
	
	
	
