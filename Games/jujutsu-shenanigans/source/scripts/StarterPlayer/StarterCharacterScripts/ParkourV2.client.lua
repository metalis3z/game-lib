local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local cas = game:GetService("ContextActionService")
local rs = game:GetService("RunService")

local userGameSettings = UserSettings():GetService("UserGameSettings")

local remotes = game.ReplicatedStorage.Remotes
local assets = game.ReplicatedStorage.Assets
local modules = game.ReplicatedStorage.Modules

local cam = workspace.CurrentCamera

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = plr.PlayerGui

local hum:Humanoid = char:WaitForChild("Humanoid")
local animator = hum:WaitForChild("Animator")
local hrp:BasePart = char:WaitForChild("HumanoidRootPart")

local rollAnim = animator:LoadAnimation(assets.Animations.Global.Roll)
local leftHopAnim = animator:LoadAnimation(assets.Animations.Global.WallHopLeft)
local rightHopAnim = animator:LoadAnimation(assets.Animations.Global.WallHopRight)
local vault1Anim = animator:LoadAnimation(assets.Animations.Global.Vaults.Vault1)
local vault2Anim = animator:LoadAnimation(assets.Animations.Global.Vaults.Vault2)
local vault3Anim = animator:LoadAnimation(assets.Animations.Global.Vaults.Vault3)

hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)

--local Cooldowns = {}

local debounce = false
local running = false
local lastTick = tick()

local totalHops = 0
local hopTime = os.clock()

local mapParams = RaycastParams.new()
mapParams.FilterType = Enum.RaycastFilterType.Include
mapParams.FilterDescendantsInstances = {workspace.Map}

local rolling = false
local vaulting = false


local idkConnection
idkConnection = rs.Heartbeat:Connect(function()
	if not char:WaitForChild("Stuns"):FindFirstChild("Stunned") and not char:WaitForChild("Ragdolls"):FindFirstChild("Ragdolled") and not rolling and not vaulting and hum.MoveDirection.Magnitude > 0 and not (hum.Health <= 0) then
		local ray = workspace:Raycast(hrp.Position,hrp.CFrame.LookVector*2,mapParams)
		local ray2 = workspace:Raycast(char:WaitForChild("Head").Position,char:WaitForChild("Head").CFrame.LookVector*2,mapParams)
		
		--local StunHandler = require(game:GetService("ServerStorage").Modules.StunHandler)
		
		if ray and ray.Instance and not ray2 and not vaulting and not ray.Instance:IsA("TrussPart") and ray.Instance.CanCollide  then --and not (ray.Instance.Size.Y > 5.7)
			local chance = math.random(1,3)
			
			if chance == 1 then
				vault1Anim:Play()
			elseif chance == 2 then
				vault2Anim:Play()
			else
				vault3Anim:Play()
			end
			
			userGameSettings.RotationType = Enum.RotationType.CameraRelative
			vaulting = true
			
			--local stunned = StunHandler:Stun(char, 0.5, nil,true,0,0,true)

			hum.WalkSpeed = 0
			hum.JumpHeight = 0

			local bv = assets.Effects.Global.BodyVelocity:Clone()
			bv.MaxForce = Vector3.new(100000,100000,100000)
			bv.Velocity =  hrp.CFrame.LookVector * 15 + Vector3.new(0, 20, 0)
			bv.Parent = hrp
			game.Debris:AddItem(bv, .2)
			
			hrp.Vault:Play()
			
			
			
			bv.Destroying:Connect(function()
				userGameSettings.RotationType = Enum.RotationType.MovementRelative
				--StunHandler:Unstun(char, stunned)  --stunned:Destroy()
				vaulting = false

				if not char:WaitForChild("Stuns"):FindFirstChild("Stunned") and not char:WaitForChild("Ragdolls"):FindFirstChild("Ragdolled") and not (hum.Health <= 0) then
					hum.WalkSpeed = 16
					hum.JumpHeight = 7.2
				end
			end)
		end
	end

	if uis.TouchEnabled then
		if cam.CFrame:vectorToObjectSpace(hum.MoveDirection).Unit.Z < -.5 then
			if not running and hum:GetState() ~= Enum.HumanoidStateType.Climbing then
				debounce = true
				running = true
				hum.WalkSpeed = 24
				lastTick = tick()
			elseif running and hum:GetState() == Enum.HumanoidStateType.Climbing then
				hum.WalkSpeed = 24
			end
		else
			if running then
				running = false
				if hum then
					hum.WalkSpeed = 16
				end
				wait(.1)
				debounce = false
			end		
		end
	end
end)

hum.StateChanged:Connect(function(oldState,newState)
	if newState == Enum.HumanoidStateType.Landed then
		local height = -hrp.AssemblyLinearVelocity.Y
		if height >= 125 and not char:WaitForChild("Stuns"):FindFirstChild("Stunned") and not char:WaitForChild("Ragdolls"):FindFirstChild("Ragdolled") and not (hum.Health <= 0) then
			userGameSettings.RotationType = Enum.RotationType.CameraRelative
			
			rolling = true

			hum.WalkSpeed = 0
			hum.JumpHeight = 0
			hum.AutoRotate = false

			local bv = assets.Effects.Global.BodyVelocity:Clone()
			bv.MaxForce = Vector3.new(10000,0,10000)
			bv.Velocity = CFrame.new(hrp.Position,hrp.Position + Vector3.new(cam.CFrame.LookVector.X,0,cam.CFrame.LookVector.Z)).LookVector*height/2
			bv.Parent = hrp
			game.Debris:AddItem(bv, .4)

			rollAnim:Play()

			bv.Destroying:Connect(function()
				userGameSettings.RotationType = Enum.RotationType.MovementRelative
				
				rolling = false

				if hum then
					hum.WalkSpeed = 16
					hum.JumpHeight = 7.2
					hum.AutoRotate = true
				end
			end)
		end
	end
end)

local keyDown = false

uis.JumpRequest:Connect(function()
	keyDown = true
	task.delay(.3,function()
		keyDown = false
	end)

	if not char:GetAttribute("Movement") and totalHops < 4 and not char:WaitForChild("Stuns"):FindFirstChild("Stunned") and not char:WaitForChild("Ragdolls"):FindFirstChild("Ragdolled") and not (hum.Health <= 0) then
		if hum:GetState() == Enum.HumanoidStateType.Freefall or hum.FloorMaterial == Enum.Material.Air then
			local ray
			local hop

			if cam.CFrame:VectorToObjectSpace(hum.MoveDirection).Unit.X < -.5 then
				ray = workspace:Raycast(hrp.Position,hrp.CFrame.LookVector*2+hrp.CFrame.RightVector*-2,mapParams)
				hop = "Left"
			elseif cam.CFrame:VectorToObjectSpace(hum.MoveDirection).Unit.X > .5 then
				ray = workspace:Raycast(hrp.Position,hrp.CFrame.LookVector*2+hrp.CFrame.RightVector*2,mapParams)
				hop = "Right"
			end

			if ray and ray.Instance and hop then
				userGameSettings.RotationType = Enum.RotationType.CameraRelative

				totalHops += 1
				char:SetAttribute("Movement", true)

				if totalHops >= 4 then
					task.delay(3.5, function()
						totalHops = 0
						char:SetAttribute("Movement", nil)
					end)
				else
					task.delay(0.5, function()
						char:SetAttribute("Movement", nil)
					end)
				end

				hum.WalkSpeed = 0
				hum.JumpHeight = 0
				hum.AutoRotate = false

				local bv = assets.Effects.Global.BodyVelocity:Clone()
				bv.MaxForce = Vector3.new(90000,90000,90000)

				if hop == "Left" then
					leftHopAnim:Play()

					bv.Velocity = hrp.CFrame.RightVector*35+Vector3.new(0,20,0)

					leftHopAnim.Stopped:Connect(function()
						if hum then
							hum.WalkSpeed = 16
							hum.JumpHeight = 7.2
							hum.AutoRotate = true
						end
					end)
				else
					rightHopAnim:Play()

					bv.Velocity = hrp.CFrame.RightVector*-35+Vector3.new(0,20,0)

					rightHopAnim.Stopped:Connect(function()
						if hum then
							hum.WalkSpeed = 16
							hum.JumpHeight = 7.2
							hum.AutoRotate = true
						end
					end)
				end

				bv.Parent = hrp
				game.Debris:AddItem(bv,.4)

				bv.Destroying:Connect(function()
					userGameSettings.RotationType = Enum.RotationType.MovementRelative
				end)
			end
		end
	end
end)


hum.Died:Connect(function()
	idkConnection:Disconnect()
	return
end)


