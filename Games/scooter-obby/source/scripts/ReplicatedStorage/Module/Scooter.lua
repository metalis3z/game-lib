--TODO:MAIN-VARIABLES
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local PhysicsService = game:GetService("PhysicsService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Spring = require(ReplicatedStorage.Shared:WaitForChild("Spring"))

local Module = {}
--TODO:CONFIGURATION

local zoomEffectThreshold = 50

local SPEED	= 110
local noCoilSpeed = 110
local coilSpeed = 165

local ACCELERATION = 0.6

local JUMPING_HEIGHT = 50

local FLOOR_HEIGHT = 2.5

local DefaultSpringVelocity = 5

--TODO:FUNCTIONS

function Module.new(FakeChar)
	if FakeChar.Name == LocalPlayer.Name then
		local turboID = 261748378
		local MarketplaceService = game:GetService("MarketplaceService")
		local TweenService = game:GetService("TweenService")
		local hasTurbo = false

		local Character	= LocalPlayer.Character

		ReplicatedStorage.RemoteEvents.ScooterEvent:FireServer("bwue281ms")
		wait(0.25)
		local ScooterModel	= workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter", 30)
		ScooterModel:WaitForChild("UIName", 20)
		local speedIncrement
		if ScooterModel:FindFirstChild("SpeedMultiplier") then
			speedIncrement = ScooterModel:FindFirstChild("SpeedMultiplier").Value
			SPEED *= speedIncrement
			noCoilSpeed = SPEED
			coilSpeed = noCoilSpeed * 1.5
		end
		local charSpring	= Spring:Create(
			1, 
			10, 
			2, 
			DefaultSpringVelocity
		)

		local grounded	= false
		local floor	= Vector3.new(0, 1, 0)

		local orientation = CFrame.new()
		local wheelRotation	= 0

		local tilt = 0

		local lastVelocity	= Vector3.new()
		if ScooterModel == nil or not ScooterModel:FindFirstChild("Frame") then
			ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
		end
		local lastPosition	= ScooterModel.Frame.Seat.WorldPosition
		local lastGroundState = false
		local timeSinceGround = os.clock()

		local FORCE = FakeChar:WaitForChild("VectorForce")
		local targetVelocity = Vector3.new()

		local jumping = false
		
		UserInputService.JumpRequest:Connect(function()
			if grounded then
				jumping = true
				FakeChar.Jump:Play()
			else
				jumping = false
			end
		end)
		
		local MasterControl = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 1).ControlModule
		local GetMoveVector = nil
		if MasterControl then
			local ControlModule = require(MasterControl)
			GetMoveVector = function()
				return ControlModule:GetMoveVector()
			end
		end	
		
		
		RunService:BindToRenderStep(FakeChar.Name .. "Scooter", Enum.RenderPriority.Character.Value, function(deltaTime)
			if workspace.Ignore:FindFirstChild(LocalPlayer.Name) and FakeChar == nil then
				FakeChar = workspace.Ignore:FindFirstChild(LocalPlayer.Name)
			end
			if ReplicatedStorage.ClientVariables.speedCoilOn.Value then
				SPEED = coilSpeed
			else
				SPEED = noCoilSpeed
			end
			if FakeChar and Character then
				if not ScooterModel then
					ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
				end
				--workspace.CurrentCamera.CameraSubject = FakeChar
				--workspace.CurrentCamera.CFrame += Vector3.new(0, 3, 0)

				local Humanoid: Humanoid = Character.Humanoid
				Humanoid.PlatformStand = true
				for i, v in pairs(Character:GetDescendants()) do
					if v.Name ~= "LowerTorso" then
						if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("BasePart") then
							v.EnableFluidForces = false
							if not v.Parent:IsA("Accessory") then
								v.Anchored = true
							end
							v.CanCollide = false
							v.CanQuery = false
							v.CanTouch = false
						end
					else
						if v:IsA("BasePart") then
							v.CanCollide = false
							v.CanQuery = false
							v.CanTouch = false
						end
					end
				end
				
				-- zoom effect
				if FakeChar.Velocity.Magnitude >= zoomEffectThreshold then
					LocalPlayer.PlayerGui.AnimeZoom.Frame.TransparencyValue.Value -= (FakeChar.Velocity.Magnitude - zoomEffectThreshold) / 100
				end
				
				for i, v in pairs(LocalPlayer.PlayerGui.AnimeZoom.Frame:GetChildren()) do
					if v:IsA("ImageLabel") then
						v.ImageTransparency = LocalPlayer.PlayerGui.AnimeZoom.Frame.TransparencyValue.Value
					end
				end
				LocalPlayer.PlayerGui.AnimeZoom.Frame.TransparencyValue.Value = 1
				
				local floorRay = Ray.new(FakeChar.Position, -floor.Unit * 10)
				local hit, position, normal	= Workspace:FindPartOnRayWithIgnoreList(floorRay, {FakeChar, workspace.Ignore})
				local floorDistance = (position - FakeChar.Position).Magnitude

				if floorDistance <= FLOOR_HEIGHT then
					grounded = true
				else
					grounded	= false
				end
				
				if (UserInputService:IsKeyDown(Enum.KeyCode.Space)) and jumping == false and grounded == true then
					jumping = true
				elseif grounded == false and jumping == true then
					jumping = false
				end

				if hit then
					if grounded then
						floor	= floor:Lerp(normal, math.min(deltaTime * 20, 1))
					else
						floor	= floor:Lerp(normal, math.min(deltaTime * 5, 1))
					end
				else
					floor	= floor:Lerp(Vector3.new(0, 1, 0), math.min(deltaTime, 1))
				end

				local floorCFrame	= CFrame.new()
				local localFloor	= floorCFrame:vectorToObjectSpace(floor)

				local x, y	= math.atan2(-localFloor.X, localFloor.Y), math.atan2(localFloor.Z, localFloor.Y)
				local cfA	= CFrame.Angles(y, 0, 0) * CFrame.Angles(0, 0, x)
				local cfB	= CFrame.Angles(0, 0, x) * CFrame.Angles(y, 0, 0)

				floorCFrame	= floorCFrame * cfA:Lerp(cfB, 0.5)

				local localVelocity	= floorCFrame:vectorToObjectSpace(FakeChar.Velocity)
				localVelocity		= Vector3.new(localVelocity.X, 0, localVelocity.Z)

				if localVelocity.Magnitude > 1 then
					orientation = orientation:Lerp(CFrame.new(Vector3.new(), localVelocity), math.min(deltaTime * 10, 1))
				end

				local CurrentCamera = Workspace.CurrentCamera

				local lookVector = CurrentCamera.CFrame.lookVector
				lookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
				local DriverDirection	= CFrame.new(Vector3.new(), lookVector)
				local DrivingSpace	= DriverDirection:vectorToObjectSpace(floor)

				local x2, y2	= math.atan2(-DrivingSpace.X, localFloor.Y), math.atan2(DrivingSpace.Z, DrivingSpace.Y)
				local cfA2	= CFrame.Angles(y2, 0, 0) * CFrame.Angles(0, 0, x2)
				local cfB2	= CFrame.Angles(0, 0, x2) * CFrame.Angles(y2, 0, 0)

				DriverDirection	= DriverDirection * cfA2:Lerp(cfB2, 0.5)

				local input	= Vector3.new()
				local hasFireParticle = false
				local anyKeysDown = false
				local tweenInf = TweenInfo.new(0.15)

				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					input	= input + Vector3.new(0, 0, -1)
					anyKeysDown = true
					if ScooterModel and not ScooterModel:FindFirstChild("UIName") then
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
					if ScooterModel and ScooterModel.UIName.Value == "THRUSTER" then
						hasTurbo = true
					else
						hasTurbo = false
					end
					if hasTurbo and not hasFireParticle then
						if ScooterModel:FindFirstChild("NormalFire") then
							ScooterModel.NormalFire.ParticleEmitter:Emit(1)
							hasFireParticle = true
							if hasTurbo and ScooterModel.NormalFire.Sound.Playing == false then
								game:GetService("TweenService"):Create(ScooterModel.NormalFire.Sound, tweenInf, {Volume = 0.03}):Play()
								ScooterModel.NormalFire.Sound:Play()
							end
						end
					else
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					input	= input + Vector3.new(0, 0, 1)
					anyKeysDown = true
					if ScooterModel and not ScooterModel:FindFirstChild("UIName") then
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
					if ScooterModel and ScooterModel.UIName.Value == "THRUSTER" then
						hasTurbo = true
					else
						hasTurbo = false
					end
					if hasTurbo and not hasFireParticle then
						if ScooterModel:FindFirstChild("NormalFire") then
							ScooterModel.NormalFire.ParticleEmitter:Emit(1)
							hasFireParticle = true
							if hasTurbo and ScooterModel.NormalFire.Sound.Playing == false then
								game:GetService("TweenService"):Create(ScooterModel.NormalFire.Sound, tweenInf, {Volume = 0.03}):Play()
								ScooterModel.NormalFire.Sound:Play()
							end
						end
					else
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					input	= input + Vector3.new(-1, 0, 0)
					anyKeysDown = true
					if ScooterModel and not ScooterModel:FindFirstChild("UIName") then
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
					if ScooterModel and ScooterModel.UIName.Value == "THRUSTER" then
						hasTurbo = true
					else
						hasTurbo = false
					end
					if hasTurbo and not hasFireParticle then
						if ScooterModel:FindFirstChild("NormalFire") then
							ScooterModel.NormalFire.ParticleEmitter:Emit(1)
							hasFireParticle = true
							if hasTurbo and ScooterModel.NormalFire.Sound.Playing == false then
								game:GetService("TweenService"):Create(ScooterModel.NormalFire.Sound, tweenInf, {Volume = 0.03}):Play()
								ScooterModel.NormalFire.Sound:Play()
							end
						end
					else
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					input	= input + Vector3.new(1, 0, 0)
					anyKeysDown = true
					if ScooterModel and not ScooterModel:FindFirstChild("UIName") then
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
					if ScooterModel and ScooterModel.UIName.Value == "THRUSTER" then
						hasTurbo = true
					else
						hasTurbo = false
					end
					if hasTurbo and not hasFireParticle then
						if ScooterModel:FindFirstChild("NormalFire") then
							ScooterModel.NormalFire.ParticleEmitter:Emit(1)
							hasFireParticle = true
							if hasTurbo and ScooterModel.NormalFire.Sound.Playing == false then
								game:GetService("TweenService"):Create(ScooterModel.NormalFire.Sound, tweenInf, {Volume = 0.03}):Play()
								ScooterModel.NormalFire.Sound:Play()
							end
						end
					else
						ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
					end
				end

				if not anyKeysDown then
					if not ScooterModel:FindFirstChild("NormalFire") then
						print(ScooterModel.Name)
						print("changed 2")
						ScooterModel = workspace.Ignore:FindFirstChild(Character.Name .. "Scooter")
						print(ScooterModel.Name)
					end
					if ScooterModel:FindFirstChild("NormalFire") and ScooterModel:FindFirstChild("NormalFire"):FindFirstChild("Sound") then
						game:GetService("TweenService"):Create(ScooterModel:FindFirstChild("NormalFire").Sound, tweenInf, {Volume = 0}):Play()
						ScooterModel.NormalFire.Sound:Stop()
					end
				end

				if input.Magnitude > 0 then
					input = input.Unit
				end

				if UserInputService.TouchEnabled and GetMoveVector then
					local MovementDirection = GetMoveVector()
					input = MovementDirection
				end

				targetVelocity	= DriverDirection:vectorToWorldSpace(input * SPEED)

				FORCE.Force	= (targetVelocity - FakeChar.Velocity) * FakeChar:GetMass() * ACCELERATION

				if jumping and grounded then
					FakeChar.Velocity = Vector3.new(FakeChar.Velocity.X, JUMPING_HEIGHT, FakeChar.Velocity.Z)
				end

				local newCFrame	= floorCFrame * orientation
				local localVelocity	= newCFrame:vectorToObjectSpace(FakeChar.Velocity)
				local speed = FakeChar.Velocity.Magnitude

				if grounded then					
					wheelRotation	= wheelRotation + ((speed * deltaTime) / 1.65) % (math.pi * 2)
					FakeChar.Sound.Volume = speed / 1000
					FakeChar.WindLoop.Volume = 0
					if lastGroundState == false then
						FakeChar.Hit.Volume = (os.clock() - timeSinceGround) / 3
						FakeChar.Hit:Play()
					end
					lastGroundState = true
				else					
					FakeChar.WindLoop.Volume = speed / 1250
					FakeChar.Sound.Volume = 0
					if lastGroundState == true then
						timeSinceGround = os.clock()
					end
					lastGroundState = false
				end

				local function Lerp(a, b, d) 
					return a + (b - a) * d 
				end

				tilt	= Lerp(tilt, -localVelocity.X / 15, math.min(deltaTime * 5, 1))
				if ScooterModel:FindFirstChild("Frame") then
					ScooterModel.Frame.CFrame	= CFrame.new(FakeChar.Position) * newCFrame * CFrame.new(0, -1, 0)

					ScooterModel.BackWheel.CFrame	= ScooterModel.Frame.CFrame * ScooterModel.Frame.BackWheel.CFrame * CFrame.Angles(-wheelRotation, 0, 0)
					ScooterModel.FrontWheel.CFrame	= ScooterModel.Frame.CFrame * ScooterModel.Frame.FrontWheel.CFrame * CFrame.Angles(-wheelRotation, 0, 0)

					Character.RightHand.CFrame	= ScooterModel.Grips.CFrame * CFrame.new(1, 0, 0.5) * CFrame.Angles(math.pi / 4, 0, 0)
					Character.LeftHand.CFrame	= ScooterModel.Grips.CFrame * CFrame.new(-1, 0, 0.5) * CFrame.Angles(math.pi / 4, 0, 0)
				end
				local RightFootAtt 
				local CurrentSpeed : number = localVelocity.Magnitude
				if ScooterModel:FindFirstChild("Frame") then
					RightFootAtt  = ScooterModel.Frame.RightFoot
				else
					ScooterModel = workspace.Ignore:WaitForChild(FakeChar.Name .. "Scooter")
				end

				local DurationTransition : number = 0.5

				local BackPosRight = CFrame.new(0.191, 0.024, 0.136)
				local FrontPosRight = CFrame.new(0.967, -0.411, -1)

				local speedPositionMappings = {
					{ speedRange = {0, 10}, position = BackPosRight },
					{ speedRange = {10, 40}, position = FrontPosRight },
					{ speedRange = {40, 80}, position = BackPosRight },
					{ speedRange = {80, 120}, position = FrontPosRight },
					{ speedRange = {120, 160}, position = BackPosRight },
				}

				local CurrentFootPosition : CFrame

				for _, mapping in ipairs(speedPositionMappings) do
					local minSpeed, maxSpeed = unpack(mapping.speedRange)
					if CurrentSpeed >= minSpeed and CurrentSpeed < maxSpeed then
						local t = (CurrentSpeed - minSpeed) / (maxSpeed - minSpeed)
						CurrentFootPosition = mapping.position
						break
					end
				end

				if input == Vector3.new() then
					game:GetService("TweenService"):Create(RightFootAtt, TweenInfo.new(DurationTransition, Enum.EasingStyle.Sine), {CFrame = CFrame.new(0.191, 0.024, 0.757)}):Play()
				else
					game:GetService("TweenService"):Create(RightFootAtt, TweenInfo.new(DurationTransition, Enum.EasingStyle.Sine), {CFrame = CurrentFootPosition}):Play()
				end

				Character.LeftFoot.CFrame = ScooterModel.Frame.LeftFoot.WorldCFrame * CFrame.new(0, 0.1, 0)
				Character.RightFoot.CFrame = ScooterModel.Frame.RightFoot.WorldCFrame * CFrame.new(0, 0.1, 0)

				local seatVelocity = (ScooterModel.Frame.Seat.WorldPosition - lastPosition) / deltaTime
				local acceleration = (seatVelocity - lastVelocity)
				lastPosition = ScooterModel.Frame.Seat.WorldPosition

				charSpring:Shove(-acceleration)
				charSpring:Update(deltaTime)
				
				if charSpring.Velocity.Magnitude >= 100 then
					charSpring:Shove(-(charSpring.Velocity))
				end
				
				local position = ScooterModel.Frame.Seat.WorldCFrame:vectorToObjectSpace(charSpring.Position)

				local desiredPosition = Vector3.new(-position.X, math.max(position.Y, -0.8 / 0.1), position.Z) * 0.1			

				Character.LowerTorso.CFrame = ScooterModel.Frame.Seat.WorldCFrame * CFrame.new(desiredPosition)
				Character.UpperTorso.CFrame = Character.LowerTorso.CFrame * CFrame.new(0, Character.LowerTorso.Size.Y / 2, 0) * CFrame.Angles(-math.pi / 16 - position.Z * 0.05, 0, tilt * 0.2) * CFrame.new(0, Character.UpperTorso.Size.Y / 2, 0)
				Character.Head.CFrame = Character.UpperTorso.CFrame * CFrame.new(0, 1.4, 0) * CFrame.Angles(0, tilt * 2, 0)

				do
					local leg, foreleg, foot = Character.RightUpperLeg, Character.RightLowerLeg, Character.RightFoot
					local hipCFrame		= Character.LowerTorso.CFrame * CFrame.new(0.6, -0.3, 0)
					local footCFrame	= foot.CFrame * CFrame.new(0, 0.1, 0.2)

					local distance		= (hipCFrame.p - footCFrame.p).Magnitude

					local a, b, c	= foreleg.Size.Y, leg.Size.Y, math.min(distance, leg.Size.Y + foreleg.Size.Y)
					local A			= math.acos((-a^2 + b^2 + c^2) / (2 * b * c))
					local C			= math.acos((a^2 + b^2 - c^2) / (2 * a * b))

					local offsetA	= hipCFrame:toObjectSpace(footCFrame)
					local x			= math.atan2(offsetA.X, -offsetA.Y)
					hipCFrame		= hipCFrame * CFrame.Angles(0, 0, x)
					local offsetB	= hipCFrame:toObjectSpace(footCFrame)
					local y			= math.atan2(-offsetB.Z, -offsetB.Y)
					hipCFrame		= hipCFrame * CFrame.Angles(y, 0, 0)

					leg.CFrame		= hipCFrame * CFrame.Angles(A, 0, 0) * CFrame.new(0, -leg.Size.Y / 2, 0)
					foreleg.CFrame	= leg.CFrame * CFrame.new(0, -leg.Size.Y / 2, 0) * CFrame.Angles(C - math.pi, 0, 0) * CFrame.new(0, -foreleg.Size.Y / 2, 0)
				end

				do
					local leg, foreleg, foot	= Character.LeftUpperLeg, Character.LeftLowerLeg, Character.LeftFoot
					local hipCFrame		= Character.LowerTorso.CFrame * CFrame.new(-0.6, -0.3, 0)
					local footCFrame	= foot.CFrame * CFrame.new(0, 0.1, 0.2)

					local distance		= (hipCFrame.p - footCFrame.p).Magnitude

					local a, b, c	= foreleg.Size.Y, leg.Size.Y, math.min(distance, leg.Size.Y + foreleg.Size.Y)
					local A			= math.acos((-a^2 + b^2 + c^2) / (2 * b * c))
					local C			= math.acos((a^2 + b^2 - c^2) / (2 * a * b))

					if A ~= A then
						A = 0
					end
					if C ~= C then
						C = 0
					end

					local offsetA	= hipCFrame:toObjectSpace(footCFrame)
					local x			= math.atan2(offsetA.X, -offsetA.Y)
					hipCFrame		= hipCFrame * CFrame.Angles(0, 0, x)
					local offsetB	= hipCFrame:toObjectSpace(footCFrame)
					local y			= math.atan2(-offsetB.Z, -offsetB.Y)
					hipCFrame		= hipCFrame * CFrame.Angles(y, 0, 0)

					leg.CFrame		= hipCFrame * CFrame.Angles(A, 0, 0) * CFrame.new(0, -leg.Size.Y / 2, 0)
					foreleg.CFrame	= leg.CFrame * CFrame.new(0, -leg.Size.Y / 2, 0) * CFrame.Angles(C - math.pi, 0, 0) * CFrame.new(0, -foreleg.Size.Y / 2, 0)
				end

				do
					local arm, forearm, hand	= Character.RightUpperArm, Character.RightLowerArm, Character.RightHand
					local shoulderCFrame	= Character.UpperTorso.CFrame * CFrame.new(0.9, 1, 0)
					local handCFrame		= hand.CFrame * CFrame.new(0, hand.Size.Y / 2, 0)

					local distance		= (shoulderCFrame.p - handCFrame.p).Magnitude

					local a, b, c	= forearm.Size.Y, arm.Size.Y, math.min(distance, arm.Size.Y + forearm.Size.Y)
					local A			= math.acos((-a^2 + b^2 + c^2) / (2 * b * c))
					local C			= math.acos((a^2 + b^2 - c^2) / (2 * a * b))

					if A ~= A then
						A = 0
					end
					if C ~= C then
						C = 0
					end

					local offsetB	= shoulderCFrame:toObjectSpace(handCFrame)
					local y			= math.atan2(-offsetB.Z, -offsetB.Y)
					shoulderCFrame		= shoulderCFrame * CFrame.Angles(y, 0, 0)
					local offsetA	= shoulderCFrame:toObjectSpace(handCFrame)
					local x			= math.atan2(offsetA.X, -offsetA.Y)
					shoulderCFrame		= shoulderCFrame * CFrame.Angles(0, 0, x)

					shoulderCFrame	= shoulderCFrame * CFrame.Angles(0, math.abs(position.X * 0.1), 0)

					arm.CFrame		= shoulderCFrame * CFrame.Angles(-A, 0, 0) * CFrame.new(0, -arm.Size.Y / 2, 0)
					forearm.CFrame	= arm.CFrame * CFrame.new(0, -arm.Size.Y / 2, 0) * CFrame.Angles(math.pi - C, 0, 0) * CFrame.new(0, -forearm.Size.Y / 2, 0)
				end

				do
					local arm, forearm, hand	= Character.LeftUpperArm, Character.LeftLowerArm, Character.LeftHand
					local shoulderCFrame	= Character.UpperTorso.CFrame * CFrame.new(-0.9, 1, 0)
					local handCFrame		= hand.CFrame * CFrame.new(0, hand.Size.Y / 2, 0)

					local distance		= (shoulderCFrame.p - handCFrame.p).Magnitude

					local a, b, c	= forearm.Size.Y, arm.Size.Y, math.min(distance, arm.Size.Y + forearm.Size.Y)
					local A			= math.acos((-a^2 + b^2 + c^2) / (2 * b * c))
					local C			= math.acos((a^2 + b^2 - c^2) / (2 * a * b))

					if A ~= A then
						A = 0
					end
					if C ~= C then
						C = 0
					end

					local offsetB	= shoulderCFrame:toObjectSpace(handCFrame)
					local y			= math.atan2(-offsetB.Z, -offsetB.Y)
					shoulderCFrame		= shoulderCFrame * CFrame.Angles(y, 0, 0)
					local offsetA	= shoulderCFrame:toObjectSpace(handCFrame)
					local x			= math.atan2(offsetA.X, -offsetA.Y)
					shoulderCFrame		= shoulderCFrame * CFrame.Angles(0, 0, x)

					shoulderCFrame	= shoulderCFrame * CFrame.Angles(0, -math.abs(position.X * 0.1), 0)

					arm.CFrame		= shoulderCFrame * CFrame.Angles(-A, 0, 0) * CFrame.new(0, -arm.Size.Y / 2, 0)
					forearm.CFrame	= arm.CFrame * CFrame.new(0, -arm.Size.Y / 2, 0) * CFrame.Angles(math.pi - C, 0, 0) * CFrame.new(0, -forearm.Size.Y / 2, 0)
				end

				lastVelocity	= seatVelocity
			else
				ScooterModel:Destroy()
				Character:Destroy()
				RunService:UnbindFromRenderStep(FakeChar.Name .. "Scooter")
			end
		end)
	end
end

return Module