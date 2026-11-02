local ServerStorage	= game:GetService("ServerStorage")
local Workspace		= game:GetService("Workspace")
local Players		= game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")
local TweenService = game:GetService("TweenService")
local Spring = require(ReplicatedStorage.Shared.Spring)

Players.PlayerAdded:connect(function(player)
	local character	= game.ReplicatedStorage.Resource.Character:Clone()
	character.Name		= player.Name
	character.Parent	= Workspace.Ignore

	character:SetNetworkOwner(player)
end)

Players.PlayerRemoving:connect(function(player)
	local character	= Workspace.Ignore:FindFirstChild(player.Name)
	local scooter = workspace.Ignore:FindFirstChild(player.Name .. "Scooter")
	if character then
		character:Destroy()
	end
	if scooter then
		scooter:Destroy()
	end
end)

local DefaultSpringVelocity = 4
local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
local ih = require(game.ServerScriptService.InventoryHandler)

function scooterEvent(LocalPlayer, EventName)
	if EventName == "bwue281ms" then
		local Character	= LocalPlayer.Character
		for i, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CollisionGroup = "Character"
			end
		end
		local FakeChar = workspace.Ignore:WaitForChild(Character.Name)
		local equipped = ih.GetEquippedItem(LocalPlayer)
		repeat
			if workspace.Ignore:FindFirstChild(FakeChar.Name .. "Scooter") then
				workspace.Ignore:FindFirstChild(FakeChar.Name .. "Scooter"):Destroy()
			end
			task.wait(0.01)
		until not workspace.Ignore:FindFirstChild(FakeChar.Name .. "Scooter")
		local ScooterModel
		if equipped == "default" then
			ScooterModel = ReplicatedStorage.Resource.Scooter:Clone()
			ScooterModel.Name = FakeChar.Name .. "Scooter"
			ScooterModel.Parent	= workspace.Ignore
			ScooterModel.Frame.CFrame = (FakeChar.CFrame)

			local color = math.random(1,12)
			local crimson = Color3.fromRGB(67, 0, 0)
			local red = Color3.fromRGB(255, 0, 0)
			local orange = Color3.fromRGB(255, 128, 0)
			local yelloworange = Color3.fromRGB(255, 200, 0)
			local yellow = Color3.fromRGB(255, 255, 0)
			local yellowgreen = Color3.fromRGB(200, 255, 0)
			local green = Color3.fromRGB(0, 128, 0)
			local lime = Color3.fromRGB(0, 255, 0)
			local teal = Color3.fromRGB(0, 255, 200)
			local blue = Color3.fromRGB(0, 0, 255)
			local indigo = Color3.fromRGB(64, 0, 255)
			local purple = Color3.fromRGB(128, 0, 255)
			local colors = {crimson, red, orange, yelloworange, yellow, yellowgreen, green, lime, teal, blue, indigo, purple}

			for i, v in pairs(ScooterModel:GetChildren()) do
				if v:GetAttribute("Colorable") then
					if v:IsA("BasePart") then
						v.Color = colors[color]
					end
				end
			end
		else
			ScooterModel = ReplicatedStorage.Resource.SkinnedScooters[equipped]:Clone()
			for i,v in pairs(workspace.Ignore:GetChildren()) do
				if v.Name == FakeChar.Name .. "Scooter" then
					v:Destroy()
				end
			end
			ScooterModel.Name = FakeChar.Name .. "Scooter"
			ScooterModel.Parent	= workspace.Ignore
			ScooterModel.Frame.CFrame = (FakeChar.CFrame)
		end

		local floor	= Vector3.new(0, 1, 0)
		local orientation = CFrame.new()
		local grounded = false

		local lastVelocity	= Vector3.new()
		local lastPosition	= ScooterModel.Frame.Seat.WorldPosition

		local charSpring = Spring:Create(
			1, 
			10, 
			2, 
			DefaultSpringVelocity
		)

		local tilt = 0
		script.ScooterEventServer2Server.Event:Connect(function(player, arg1)
			equipped = arg1
			if player.Name == FakeChar.Name then
				if equipped == "default" then
					ScooterModel = ReplicatedStorage.Resource.Scooter:Clone()
					ScooterModel.Name = FakeChar.Name .. "Scooter"
					for i,v in pairs(workspace.Ignore:GetChildren()) do
						if v.Name == FakeChar.Name .. "Scooter" then
							v:Destroy()
						end
					end
					ScooterModel.Parent	= workspace.Ignore
					ScooterModel.Frame.CFrame = (FakeChar.CFrame)

					local color = math.random(1,12)
					local crimson = Color3.fromRGB(67, 0, 0)
					local red = Color3.fromRGB(255, 0, 0)
					local orange = Color3.fromRGB(255, 128, 0)
					local yelloworange = Color3.fromRGB(255, 200, 0)
					local yellow = Color3.fromRGB(255, 255, 0)
					local yellowgreen = Color3.fromRGB(200, 255, 0)
					local green = Color3.fromRGB(0, 128, 0)
					local lime = Color3.fromRGB(0, 255, 0)
					local teal = Color3.fromRGB(0, 255, 200)
					local blue = Color3.fromRGB(0, 0, 255)
					local indigo = Color3.fromRGB(64, 0, 255)
					local purple = Color3.fromRGB(128, 0, 255)
					local colors = {crimson, red, orange, yelloworange, yellow, yellowgreen, green, lime, teal, blue, indigo, purple}

					for i, v in pairs(ScooterModel:GetChildren()) do
						if v:GetAttribute("Colorable") then
							if v:IsA("BasePart") then
								v.Color = colors[color]
							end
						end
					end
				else
					ScooterModel = ReplicatedStorage.Resource.SkinnedScooters[equipped]:Clone()
					for i,v in pairs(workspace.Ignore:GetChildren()) do
						if v.Name == FakeChar.Name .. "Scooter" then
							v:Destroy()
						end
					end
					ScooterModel.Name = LocalPlayer.Name .. "Scooter"
					ScooterModel.Parent	= workspace.Ignore
					ScooterModel.Frame.CFrame = (FakeChar.CFrame)
				end
				local hasTurbo = false
				if ScooterModel and ScooterModel.UIName.Value == "THRUSTER" then
					hasTurbo = true
				end
				local MarketplaceService = game:GetService("MarketplaceService")
				local turboID = 261748378
			end
		end)
		--RunService:BindToRenderStep(FakeChar.Name .. "Scooter", Enum.RenderPriority.Character.Value, function(deltaTime)
		local connection
		
		local function endConnection(event)
			event:Disconnect(connection)
		end
		
		game.Players.PlayerRemoving:Connect(function(plr)
			if plr == LocalPlayer then
				endConnection(connection)
			end
		end)
		
		connection = RunService.Heartbeat:Connect(function(deltaTime)
			if not ScooterModel then
				if workspace.Ignore:FindFirstChild(LocalPlayer.Name .. "Scooter") then
					ScooterModel = workspace.Ignore:FindFirstChild(LocalPlayer.Name .. "Scooter")
				else
					return
				end
			end
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
						v.CanTouch = false
						v.CanQuery = false
					end
				else
					if v:IsA("BasePart") then
						v.CanCollide = false
						v.CanTouch = false
						v.CanQuery = false
					end
				end
			end


			local floorRay = Ray.new(FakeChar.Position, -floor.Unit * 10)
			local hit, position, normal	= Workspace:FindPartOnRayWithIgnoreList(floorRay, {FakeChar, workspace.Ignore})
			local floorDistance = (position - FakeChar.Position).Magnitude

			if floorDistance <= 2.5 then
				grounded = true
			else
				grounded	= false
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

			local function Lerp(a, b, d) 
				return a + (b - a) * d 
			end

			tilt	= Lerp(tilt, -localVelocity.X / 15, math.min(deltaTime * 5, 1))

			local newCFrame	= floorCFrame * orientation
			if not ScooterModel:FindFirstChild("Frame") then
				ScooterModel = workspace.Ignore:FindFirstChild(Character.Name .. "Scooter")
			end
			if ScooterModel == nil then
				return
			end
			if not LocalPlayer.Character then
				endConnection()
			end
			ScooterModel.Frame.CFrame	= CFrame.new(FakeChar.Position) * newCFrame * CFrame.new(0, -1, 0)

			ScooterModel.BackWheel.CFrame	= ScooterModel.Frame.CFrame * ScooterModel.Frame.BackWheel.CFrame * CFrame.Angles(0, 0, 0)
			ScooterModel.FrontWheel.CFrame	= ScooterModel.Frame.CFrame * ScooterModel.Frame.FrontWheel.CFrame * CFrame.Angles(0, 0, 0)

			Character.RightHand.CFrame	= ScooterModel.Grips.CFrame * CFrame.new(1, 0, 0.5) * CFrame.Angles(math.pi / 4, 0, 0)
			Character.LeftHand.CFrame	= ScooterModel.Grips.CFrame * CFrame.new(-1, 0, 0.5) * CFrame.Angles(math.pi / 4, 0, 0)

			Character.LeftFoot.CFrame = ScooterModel.Frame.LeftFoot.WorldCFrame * CFrame.new(0, 0.1, 0)
			Character.RightFoot.CFrame = ScooterModel.Frame.RightFoot.WorldCFrame * CFrame.new(0, 0.1, 0)

			Character.LeftFoot.CFrame = ScooterModel.Frame.LeftFoot.WorldCFrame * CFrame.new(0, 0.1, 0)
			Character.RightFoot.CFrame = ScooterModel.Frame.RightFoot.WorldCFrame * CFrame.new(0, 0.1, 0)
			local seatVelocity = (ScooterModel.Frame.Seat.WorldPosition - lastPosition) / deltaTime
			local acceleration = (seatVelocity - lastVelocity)
			lastPosition = ScooterModel.Frame.Seat.WorldPosition

			charSpring:Shove(-acceleration)
			charSpring:Update(deltaTime)

			local position = ScooterModel.Frame.Seat.WorldCFrame:vectorToObjectSpace(charSpring.Position)

			Character.LowerTorso.CFrame	= ScooterModel.Frame.Seat.WorldCFrame * CFrame.new(Vector3.new(-position.X, math.max(position.Y, -0.8 / 0.1), position.Z) * 0.1)
			Character.UpperTorso.CFrame = Character.LowerTorso.CFrame * CFrame.new(0, Character.LowerTorso.Size.Y / 2, 0) * CFrame.Angles(-math.pi / 16 - position.Z * 0.05, 0, tilt * 0.2) * CFrame.new(0, Character.UpperTorso.Size.Y / 2, 0)
			Character.Head.CFrame = Character.UpperTorso.CFrame * CFrame.new(0, 1.4, 0) * CFrame.Angles(0, tilt * 2, 0)

			lastVelocity = seatVelocity

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

		end)
	end
end

task.spawn(function()
	while true do
		wait(0.1)
		for _, character in pairs(Workspace.Ignore:GetChildren()) do
			if not character:IsA("Model") and character.Position.Y < -250 then
				if Players:FindFirstChild(character.Name) then
					local stageObjects = {}

					local CollectionService = game:GetService("CollectionService")

					for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
						local stage = cp:GetAttribute("Stage")

						if not stageObjects[stage] then
							stageObjects[stage] = {}
						end

						table.insert(stageObjects[stage], cp)
					end
					game.Players:FindFirstChild(character.Name):SetAttribute("Safe", true)
					game.Players:FindFirstChild(character.Name):SetAttribute("Safe2", .5)
					ReplicatedStorage.RemoteEvents.clientTP:FireClient(game.Players:FindFirstChild(character.Name), stageObjects[game.Players:FindFirstChild(character.Name).leaderstats.Stage.Value])
				end
			end
		end
	end
end)

ReplicatedStorage.RemoteEvents.ScooterEvent.OnServerEvent:Connect(function(player, arg1)
	scooterEvent(player, arg1)
end)