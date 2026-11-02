local gem2 = require(game.ReplicatedStorage.ClientModules.Module_Events)

--[[workspace.Rooms.AttributeChanged:Connect(function()
	if game.Workspace:FindFirstChild("Rooms"):GetAttribute("Seek1Room1", true) then
		wait(0.5)	
		local rooms2dif = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms:GetAttribute("Seek1Room2Number")):FindFirstChild("SeekPathwayAdd"):GetChildren()
		for Room=1, #rooms2dif do
			print("moved to seek pathway "..rooms2dif[Room].Name)
			wait(0.1)
			rooms2dif[Room].Parent = game.Workspace:FindFirstChild("Rooms"):FindFirstChild("SeekPathWay1")
		end
	end
end)--]]

function spawneyes(times, flicker)
	gem2.flickerLights(script.Parent.Parent, flicker)
	for i = 1, times do
		wait(0.05)
		local rep = game.ReplicatedStorage.Misc.EyesR
		local eye = rep:GetChildren()[math.random(1, #rep:GetChildren())]
		local pos = script.Parent.Parent.Spawn
		local poc = pos:GetChildren()[math.random(1, #pos:GetChildren())]
		local cloned = eye:Clone()
		cloned.Parent = script.Parent.Parent
		cloned.Part.Splat:Play()
		cloned:PivotTo(poc.CFrame)
	end
end

local randomz = math.random(40, 80)

spawneyes(27, 4)