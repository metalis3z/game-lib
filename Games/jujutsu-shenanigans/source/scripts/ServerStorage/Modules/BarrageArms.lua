--// Variables \\--

local TS = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local bezierModule = require(replicatedStorage:FindFirstChild("Modules"):FindFirstChild("bezierCurve"))
local effectCreator = {}

local effectFolder = workspace.Thrown

--// Create Effect \\--

local function raycast(origin, direction, filterType, filterTable)
	
	--// Creating raycast \\--
	
	local raycastParameters = RaycastParams.new()
	raycastParameters.FilterType = filterType
	raycastParameters.FilterDescendantsInstances = filterTable
	raycastParameters.RespectCanCollide = true
	
	local raycastResult = game:GetService("Workspace"):Raycast(origin, direction, raycastParameters)
	
	--// Returning result \\--
	
	if raycastResult ~= nil then		
		return raycastResult	
	else		
		return "Nothing was hit"
	end
	
end

local function createShockwave(position, Orientation)
	
	local newShockwave = script:FindFirstChild("Arm Shockwave"):Clone()
	newShockwave.Position = position + Vector3.new(math.random(-10,10) / 10, math.random(-10,10) / 10, math.random(-10,10) / 10)
	newShockwave.Orientation = Orientation + Vector3.new(-90,0,0)
	newShockwave.Parent = effectFolder
	game.Debris:AddItem(newShockwave, 0.75)
	
	TS:Create(newShockwave, TweenInfo.new(0.3, Enum.EasingStyle.Sine),{
		Size = Vector3.new(3,0.35,3),
		Transparency = 1
	}):Play()
	
end

function effectCreator.Create(Parameters)
	
	--// Variables \\--
	
	local localPlayer = players.LocalPlayer
	
	local barrageSubject = Parameters.Subject
	local Finisher = Parameters.Finisher

	local subjectHRP = barrageSubject:FindFirstChild("HumanoidRootPart")
	local subjectHumanoid = barrageSubject:FindFirstChildOfClass("Humanoid")
	
	local allBarrageArms = Instance.new("Model")
	allBarrageArms.Name = "All ".. barrageSubject.Name .. " Barrage Arms"
	allBarrageArms.Parent = effectFolder
	
	--// Creating arm preset \\--
	
	local armPreset = script:FindFirstChild("Barrage Arms"):Clone()
	armPreset.Name = tostring(barrageSubject.Name .. " Barrage Arms")
	
	for i, v in pairs(armPreset:GetChildren()) do
		if v:IsA("BasePart") and barrageSubject:FindFirstChild(v.Name) then
			
			v.Color = barrageSubject:FindFirstChild(v.Name).Color
			
		elseif v:IsA("Shirt") then
			if barrageSubject:FindFirstChildOfClass("Shirt") then
				
				local shirtId = barrageSubject:FindFirstChildOfClass("Shirt").ShirtTemplate
				v.ShirtTemplate = shirtId
				
			end
		end
	end
	
	--// Making subjects arms dissappear \\--
	
	for i, v in pairs(barrageSubject:GetChildren()) do
		if v.Name == "Left Arm" or v.Name == "Right Arm" then
			
			TS:Create(v, TweenInfo.new(0.3),{
				Transparency = 1
			}):Play()
			
		end
	end
	
	--// Creating effect \\--
	
	local createEffect = coroutine.wrap(function()
		
		local tweenConnections = {}
		local armOrder = 0
		
		local creatingArms
		
		creatingArms = game["Run Service"].Heartbeat:Connect(function()
			
			local canCreate = true
			
			--// Checking \\--
			
			if barrageSubject.Parent == nil or subjectHumanoid.Health <= 0 or not barrageSubject:FindFirstChild("HumanoidRootPart") or barrageSubject:GetAttribute("Barraging") == false then
				
				--// Disconnecting all connections \\--
				
				canCreate = false
				creatingArms:Disconnect()

				game.Debris:AddItem(allBarrageArms, 1.5)
				armPreset:Destroy()

				--// Making arms appear \\--

				for i, v in pairs(barrageSubject:GetChildren()) do
					if v.Name == "Left Arm" or v.Name == "Right Arm" then

						TS:Create(v, TweenInfo.new(0.35),{
							Transparency = 0
						}):Play()

					end
				end
				
			end
			
			--// Creating \\--
			
			if canCreate == true then
				
				--// Performing \\\--

				local create = coroutine.wrap(function()

				--// Creating arms \\--
					local barrageArms = armPreset:Clone()
					barrageArms:SetPrimaryPartCFrame(subjectHRP.CFrame)

					--// Tweening arms \\--

					for i, v in pairs(barrageArms:GetChildren()) do
						if v:IsA("BasePart") and v:FindFirstChild("Arm") then

							armOrder += 1

							--// Creating curve \\--

							local bezierProgress = 0

							local sideOffset = math.random(50,160)

							if Finisher == true then
								sideOffset =  math.random(0,400)
							end

							local startPoint = v.CFrame * CFrame.new(math.random(-10,10) / 10, math.random(-10,10) / 10, math.random(4,8) / 10)
							local endPoint = subjectHRP.CFrame * CFrame.new(math.random(-15,15) / 10, math.random(-25,25) / 10, -6 * (math.random(75,125) / 100))
							local middlePoint = v.CFrame * CFrame.new(
								v:FindFirstChild("sideOffset").Value * (sideOffset / 100),
								math.random(-40,40) / 10,
								-2.5 * (math.random(75,125) / 100)
							)

							local armCurve = bezierModule.new(
								startPoint.Position,
								middlePoint.Position,
								endPoint.Position
							)

							--// Tweening arm \\--

							local tweenArm = coroutine.wrap(function()

								local currConnection = tostring("Barrage Arms ".. armOrder)

								local armDissappeared = false
								local armCreatedShockwave = false
								local armMadeSound = false

								local transparency = 0.5

								local start = tick()

								v.Position = armCurve:Get(bezierProgress)
								v.CFrame = CFrame.lookAt(v.Position, armCurve:Get(0.05)) * CFrame.Angles(math.rad(90), 0, 0)

								barrageArms.Parent = barrageSubject

								tweenConnections[currConnection] = game["Run Service"].Heartbeat:Connect(function()

									--// Disconnecting \\--

									if bezierProgress >= 1 or v.Parent == nil then
										tweenConnections[currConnection]:Disconnect()
									end

									--// Adding progress \\--

									bezierProgress += 0.125

									--// Arm Effects \\--

									if bezierProgress >= 0.25 and armMadeSound == false then
										
										local barragesound = script.Barraging:Clone()
										barragesound.Parent = barrageSubject.HumanoidRootPart
										barragesound.PlaybackSpeed = math.random(75,125) / 100
										barragesound:Play()
										
										game:GetService("Debris"):AddItem(barragesound,barragesound.TimeLength)
										
										armMadeSound = true
										
									end

									if bezierProgress >= 0.85 and armCreatedShockwave == false then

										armCreatedShockwave = true							
										createShockwave(v.Position, subjectHRP.Orientation)

									end

									if bezierProgress >= 0.85 and armDissappeared == false then

										armDissappeared = true

										--[[TS:Create(v, TweenInfo.new(0.175, Enum.EasingStyle.Sine),{
											Transparency = 1
										}):Play()]]
										
										v.Transparency = 1

										--// Tweening trails \\--

										for i, trail in pairs(v:GetDescendants()) do
											if trail:IsA("Trail") then

											    trail.Transparency = 1

											end
										end

									end

									--// Positioning arm \\--

									if bezierProgress <= 1 then

										local offset = -25

										if v.Name == "Left Arm" then
											offset = 25
										end

										v.Position = armCurve:Get(bezierProgress)
										v.CFrame = CFrame.lookAt(v.Position, armCurve:Get(bezierProgress + 0.05)) * CFrame.Angles(math.rad(90), 0, math.rad(offset))

									else
										v.Transparency = 1

									end

									--// Disconnecting \\--

									if bezierProgress >= 1 or v.Parent == nil then
										tweenConnections[currConnection]:Disconnect()
									end

								end)

							end)

							tweenArm()

						end
					end

					game.Debris:AddItem(barrageArms, 0.35)
				end)

				create()
				
			end
			
		end)

	end)
	
	createEffect()
	
end

--// Returning \\--

return effectCreator