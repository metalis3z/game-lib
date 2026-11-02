repeat wait() until game.Players.LocalPlayer
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Torso = Character:findFirstChild("Torso")
local Humanoid = Character:findFirstChild("Humanoid")
-------------------------------------------------
local Seated = true
-------------------------------------------------
if Torso and Humanoid then
	Humanoid.Sit,Humanoid.Jump = true,false
	coroutine.resume(coroutine.create(function()
		while true do
			if Seated then
				Humanoid.Sit,Humanoid.Jump = true,false
			elseif (not Seated) then
				Humanoid.Sit,Humanoid.Jump = false,true
				break
			end
			wait()
		end
	end))
	local Model = Instance.new("Model")
	Model.Parent = Character
	Model.Name = "EjectorSeat"
	-------------------------------------------------------------------------------------------
	local Seat = Instance.new("Part")
	Seat.Parent = Model
	Seat.Name = "Seat"
	Seat.CanCollide = false
	Seat.FormFactor = "Custom"
	Seat.Size = Vector3.new(2.5,1,2)
	Seat.BottomSurface = "Smooth"
	Seat.TopSurface = "Smooth"
	local Weld1 = Instance.new("Weld")
	Weld1.Parent = Seat
	Weld1.Part0 = Seat
	Weld1.Part1 = Torso
	Weld1.C0 = CFrame.new(0,2,0)
	-------------------------------------------------------------------------------------------
	local Part1 = Instance.new("Part")
	Part1.Parent = Model
	Part1.CanCollide = false
	Part1.FormFactor = "Symmetric"
	Part1.Size = Vector3.new(3,1,1)
	Part1.BottomSurface = "Smooth"
	Part1.TopSurface = "Smooth"
	local Weld2 = Instance.new("Weld")
	Weld2.Parent = Part1
	Weld2.Part0 = Part1
	Weld2.Part1 = Seat
	Weld2.C0 = CFrame.new(0,0,-1.5)
	-------------------------------------------------------------------------------------------
	local Part2 = Instance.new("Part")
	Part2.Parent = Model
	Part2.CanCollide = false
	Part2.FormFactor = "Symmetric"
	Part2.Size = Vector3.new(2,3,1)
	Part2.BottomSurface = "Smooth"
	Part2.TopSurface = "Smooth"
	local Weld3 = Instance.new("Weld")
	Weld3.Parent = Part2
	Weld3.Part0 = Part2
	Weld3.Part1 = Part1
	Weld3.C0 = CFrame.new(0,-2,0)
	-------------------------------------------------------------------------------------------
	local Wedge1 = Instance.new("WedgePart")
	Wedge1.Parent = Model
	Wedge1.CanCollide = false
	Wedge1.FormFactor = "Custom"
	Wedge1.Size = Vector3.new(1,3,0.5)
	Wedge1.BottomSurface = "Smooth"
	Wedge1.TopSurface = "Smooth"
	local Weld4 = Instance.new("Weld")
	Weld4.Parent = Wedge1
	Weld4.Part0 = Wedge1
	Weld4.Part1 = Part2
	Weld4.C0 = CFrame.new(0,0,1.25) * CFrame.Angles(0,math.rad(90),0)
	-------------------------------------------------------------------------------------------
	local Wedge2 = Instance.new("WedgePart")
	Wedge2.Parent = Model
	Wedge2.CanCollide = false
	Wedge2.FormFactor = "Custom"
	Wedge2.Size = Vector3.new(1,3,0.5)
	Wedge2.BottomSurface = "Smooth"
	Wedge2.TopSurface = "Smooth"
	local Weld5 = Instance.new("Weld")
	Weld5.Parent = Wedge2
	Weld5.Part0 = Wedge2
	Weld5.Part1 = Part2
	Weld5.C0 = CFrame.new(0,0,1.25) * CFrame.Angles(0,math.rad(-90),0)
	-------------------------------------------------------------------------------------------
	local Wedge3 = Instance.new("WedgePart")
	Wedge3.Parent = Model
	Wedge3.CanCollide = false
	Wedge3.FormFactor = "Custom"
	Wedge3.Size = Vector3.new(1,2,0.25)
	Wedge3.BottomSurface = "Smooth"
	Wedge3.TopSurface = "Smooth"
	local Weld6 = Instance.new("Weld")
	Weld6.Parent = Wedge3
	Weld6.Part0 = Wedge3
	Weld6.Part1 = Seat
	Weld6.C0 = CFrame.new(0,0,1.375) * CFrame.Angles(math.rad(90),0,math.rad(90))
	-------------------------------------------------------------------------------------------
	local Wedge4 = Instance.new("WedgePart")
	Wedge4.Parent = Model
	Wedge4.CanCollide = false
	Wedge4.FormFactor = "Custom"
	Wedge4.Size = Vector3.new(1,2,0.25)
	Wedge4.BottomSurface = "Smooth"
	Wedge4.TopSurface = "Smooth"
	local Weld7 = Instance.new("Weld")
	Weld7.Parent = Wedge4
	Weld7.Part0 = Wedge4
	Weld7.Part1 = Seat
	Weld7.C0 = CFrame.new(0,0,1.375) * CFrame.Angles(math.rad(90),0,math.rad(-90))
	-------------------------------------------------------------------------------------------
	local Part3 = Instance.new("Part")
	Part3.Parent = Model
	Part3.Name = "Main"
	Part3.CanCollide = false
	Part3.FormFactor = "Symmetric"
	Part3.Size = Vector3.new(1,4,1)
	Part3.BottomSurface = "Smooth"
	Part3.TopSurface = "Smooth"
	local Mesh1 = Instance.new("CylinderMesh")
	Mesh1.Parent = Part3
	local BV = Instance.new("BodyVelocity")
	BV.Parent = Part3
	BV.maxForce = Vector3.new(7e3,math.huge,7e3)
	BV.velocity = Vector3.new(0,700.15,0)
	local BG = Instance.new("BodyGyro")
	BG.Parent = Part3
	BG.maxTorque = Vector3.new(math.huge,0,math.huge)
	BG.cframe = CFrame.Angles(0,0,0)
	local Weld8 = Instance.new("Weld")
	Weld8.Parent = Part3
	Weld8.Part0 = Part3
	Weld8.Part1 = Part2
	Weld8.C0 = CFrame.new(0,0.5,-0.5)
	-------------------------------------------------------------------------------------------
	local Visual = Instance.new("Part")
	Visual.Parent = Model
	Visual.Transparency = 1
	Visual.Name = "Visual"
	Visual.CanCollide = false
	Visual.FormFactor = "Symmetric"
	Visual.Size = Vector3.new(1,1,1)
	Visual.BottomSurface = "Smooth"
	Visual.TopSurface = "Smooth"
	local Weld9 = Instance.new("Weld")
	Weld9.Parent = Visual
	Weld9.Part0 = Visual
	Weld9.Part1 = Part3
	Weld9.C0 = CFrame.new(0,-2.5,0) * CFrame.Angles(0,0,math.rad(180))
	local Fire = Instance.new("Fire")
	Fire.Parent = Visual
	Fire.Heat = 25
	Fire.Size = 10
	-------------------------------------------------------------------------------------------
	local Wire1 = Instance.new("Part")
	Wire1.Parent = Model
	Wire1.BrickColor = BrickColor.new("White")
	Wire1.Transparency = 1
	Wire1.Name = "Wire"
	Wire1.CanCollide = false
	Wire1.FormFactor = "Symmetric"
	Wire1.Size = Vector3.new(1,13,1)
	Wire1.BottomSurface = "Smooth"
	Wire1.TopSurface = "Smooth"
	local Mesh2 = Instance.new("CylinderMesh")
	Mesh2.Parent = Wire1
	Mesh2.Scale = Vector3.new(0.2,1,0.2)
	local Weld10 = Instance.new("Weld")
	Weld10.Parent = Wire1
	Weld10.Part0 = Wire1
	Weld10.Part1 = Part3
	Weld10.C0 = CFrame.new(-0.5,-8.3,0.5)
	Weld10.C1 = CFrame.Angles(math.rad(20),0,math.rad(20))
	-------------------------------------------------------------------------------------------
	local Wire2 = Instance.new("Part")
	Wire2.Parent = Model
	Wire2.BrickColor = BrickColor.new("White")
	Wire2.Transparency = 1
	Wire2.Name = "Wire"
	Wire2.CanCollide = false
	Wire2.FormFactor = "Symmetric"
	Wire2.Size = Vector3.new(1,13,1)
	Wire2.BottomSurface = "Smooth"
	Wire2.TopSurface = "Smooth"
	local Mesh3 = Instance.new("CylinderMesh")
	Mesh3.Parent = Wire2
	Mesh3.Scale = Vector3.new(0.2,1,0.2)
	local Weld11 = Instance.new("Weld")
	Weld11.Parent = Wire2
	Weld11.Part0 = Wire2
	Weld11.Part1 = Part3
	Weld11.C0 = CFrame.new(0.5,-8.3,0.5)
	Weld11.C1 = CFrame.Angles(math.rad(20),0,math.rad(-20))
	-------------------------------------------------------------------------------------------
	local Wire3 = Instance.new("Part")
	Wire3.Parent = Model
	Wire3.BrickColor = BrickColor.new("White")
	Wire3.Transparency = 1
	Wire3.Name = "Wire"
	Wire3.CanCollide = false
	Wire3.FormFactor = "Symmetric"
	Wire3.Size = Vector3.new(1,13,1)
	Wire3.BottomSurface = "Smooth"
	Wire3.TopSurface = "Smooth"
	local Mesh4 = Instance.new("CylinderMesh")
	Mesh4.Parent = Wire3
	Mesh4.Scale = Vector3.new(0.2,1,0.2)
	local Weld12 = Instance.new("Weld")
	Weld12.Parent = Wire3
	Weld12.Part0 = Wire3
	Weld12.Part1 = Part3
	Weld12.C0 = CFrame.new(-0.5,-8.3,-0.5)
	Weld12.C1 = CFrame.Angles(math.rad(-20),0,math.rad(20))
	-------------------------------------------------------------------------------------------
	local Wire4 = Instance.new("Part")
	Wire4.Parent = Model
	Wire4.BrickColor = BrickColor.new("White")
	Wire4.Transparency = 1
	Wire4.Name = "Wire"
	Wire4.CanCollide = false
	Wire4.FormFactor = "Symmetric"
	Wire4.Size = Vector3.new(1,13,1)
	Wire4.BottomSurface = "Smooth"
	Wire4.TopSurface = "Smooth"
	local Mesh5 = Instance.new("CylinderMesh")
	Mesh5.Parent = Wire4
	Mesh5.Scale = Vector3.new(0.2,1,0.2)
	local Weld13 = Instance.new("Weld")
	Weld13.Parent = Wire4
	Weld13.Part0 = Wire4
	Weld13.Part1 = Part3
	Weld13.C0 = CFrame.new(0.5,-8.3,-0.5)
	Weld13.C1 = CFrame.Angles(math.rad(-20),0,math.rad(-20))
	-------------------------------------------------------------------------------------------
	local Parachute = Instance.new("Part")
	Parachute.Parent = Model
	Parachute.BrickColor = BrickColor.new("Bright orange")
	Parachute.Transparency = 1
	Parachute.Name = "Parachute"
	Parachute.CanCollide = false
	Parachute.FormFactor = "Symmetric"
	Parachute.Size = Vector3.new(1,1,1)
	Parachute.BottomSurface = "Smooth"
	Parachute.TopSurface = "Smooth"
	local Mesh6 = Instance.new("SpecialMesh")
	Mesh6.Parent = Parachute
	Mesh6.MeshId = "http://www.roblox.com/asset/?id=1038653"
	Mesh6.MeshType = "FileMesh"
	Mesh6.Scale = Vector3.new(11,9,11)
	local Weld14 = Instance.new("Weld")
	Weld14.Parent = Parachute
	Weld14.Part0 = Parachute
	Weld14.Part1 = Part3
	Weld14.C0 = CFrame.new(0,-15,0)
	-------------------------------------------------------------------------------------------
	wait(3)
	BV.maxForce = Vector3.new(7e3,15e3,7e3)
	BV.velocity = Vector3.new(0,0.15,0)
	Fire.Enabled = false
	local SeatPos = Seat.CFrame.p
	local SeatDir = (Seat.CFrame.p - Vector3.new(0,1,0)).unit
	local Ray1 = Ray.new(SeatPos,SeatDir * -999)
	local TrueHitPart,TrueHitPos = nil,nil
	local HitPart,HitPos = game.Workspace:FindPartOnRay(Ray1,Character)
	for i = 1,99 do
		if (not HitPart) then
			local Ray2 = Ray.new(HitPos,SeatDir * -999)
			local HitPart2,HitPos2 = game.Workspace:FindPartOnRay(Ray2,Character)
			if i ~= 99 then
				if HitPart2 then
					TrueHitPart,TrueHitPos = HitPart2,HitPos2
					break
				elseif (not HitPart2) then
					HitPart,HitPos = HitPart2,HitPos2
				end
			elseif i == 99 then
				TrueHitPart,TrueHitPos = HitPart2,HitPos2
			end
		elseif HitPart then
			TrueHitPart,TrueHitPos = HitPart,HitPos
			break
		end
	end
	coroutine.resume(coroutine.create(function()
		while true do
			if (Seat.Position.Y - TrueHitPos.Y) <= 1000 then
				break
			end
			wait()
		end
		BV.maxForce = Vector3.new(7e3,35e3,7e3)
		BV.velocity = Vector3.new(0,-100.15,0)
		Wire1.Transparency,Wire2.Transparency,Wire3.Transparency,Wire4.Transparency = 0,0,0,0
		Parachute.Transparency = 0
		while true do
			if (Seat.Position.Y - TrueHitPos.Y) <= 50 then
				break
			end
			wait()
		end
		Seated = false
		Humanoid.Jump = true
		Humanoid.Sit = false
		Model:Destroy()
		game:GetService("Debris"):AddItem(script,0.1)
	end))
end