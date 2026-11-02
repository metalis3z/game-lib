local model = script:WaitForChild("ObjectPointer").Value

local currentObject = nil
model.Seat.ChildAdded:connect(function(obj)
	if obj.Name == "SeatWeld" then
		currentObject = obj.Part1.Parent
		--currentObject["Left Arm"].Transparency = 1
		--currentObject["Right Arm"].Transparency = 1
		workspace.Main.FurnitureSound:FireAllClients(model.Explosion.Fuse,model,"Play")
		wait(1.747)
		
		if obj and obj.Parent then
			
			
			workspace.Main.FurnitureSound:FireAllClients(model.Explosion.Boom,model,"Play")


			
			--currentObject["Left Arm"].Transparency = 0
			--currentObject["Right Arm"].Transparency = 0
		
			local ex = Instance.new("Explosion")
			ex.Parent = model.Explosion
			ex.Position = model.Explosion.Position
			ex.BlastPressure = 0
			ex.BlastRadius = 0
			ex.ExplosionType = "NoCraters"
			delay(2,function() ex:Destroy() end)
			
			obj:Destroy()
			

			
		end
	end
end)

model.Seat.ChildRemoved:connect(function(obj)
	if obj.Name == "SeatWeld" then
		if currentObject then
			--currentObject["Left Arm"].Transparency = 0
			--currentObject["Right Arm"].Transparency = 0
			currentObject.HumanoidRootPart.Velocity =  model.Explosion.CFrame.lookVector * 300 --(model.Tube.CFrame * CFrame.Angles(math.pi/2,0,0)).lookVector
			currentObject = nil
		end
	end
end)


