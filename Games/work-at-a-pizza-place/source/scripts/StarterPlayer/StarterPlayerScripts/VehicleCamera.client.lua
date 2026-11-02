local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	script:Destroy()
	return
end

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local CameraLock = PlayerGui:WaitForChild("WorkTool"):WaitForChild("CameraLock")
local Prompts = MainGui:WaitForChild("Prompts",20)
local TouchEnabled = game:GetService("UserInputService").TouchEnabled
if Prompts == nil then
	error("Prompts folder is gone")
end


--while not _G["StartedPlaying"] do wait(.1) end



---Useful code
	--get angle of camera
	--[[spawn(function()
	while true do
		wait(1)

	local radius = (camera.CoordinateFrame.p - player.Character.Head.Position).magnitude
	
	local y = camera.CoordinateFrame.p.Y - player.Character.Head.Position.Y
	


 	local currentAngle = math.deg(math.asin(y/radius))

	print(currentAngle,radius)
	
	end
	end)]]
	
	
	
		


local collisionBumperTouched = nil
local collecting = false
local inVehicleSeat = false
local boxes = {}
local boxDestroyed = nil
local collisionDebounce = false
--//////////////when player sits in supply truck, create clones of each box so dosent interfer with camera\\\\\\\\\\\\\\\\\\\\\\\\
function PlayerSat(active,seat)
	if active and seat and seat.Parent  then
		if seat:IsA("VehicleSeat") then
			inVehicleSeat = true
		end
		if seat.Name == "Driver" and seat.Parent:FindFirstChild("Truck") then
			
			Realign(25,50)
			
			collecting = true 
			
			--update the box clones
			game:GetService("RunService"):BindToRenderStep("SupplyBoxes", Enum.RenderPriority.First.Value, function()
				for box,clone in pairs(boxes) do
					clone.CFrame = box.CFrame
				end
			end)
			
			--remove clone when box is destroyed
			boxDestroyed = workspace.AllSupplyBoxes.ChildRemoved:connect(function(box)
				if boxes[box] then
					boxes[box]:Destroy()
					boxes[box] = nil
				end
			end)
			
			--find supply boxes in truck, create clone of box and make box transparent
			while collecting do
				
				local InTruck = workspace.Main.GetBoxesInTruck:InvokeServer(seat.Parent) or {}
				for _,box in ipairs(InTruck) do
					
					if not boxes[box] then
						
						local newBox = Instance.new("Part",workspace)
						newBox.Name = "Clone"
						newBox.BrickColor = box.BrickColor
						newBox.FormFactor = "Custom"
						newBox.Size = Vector3.new(.2,.2,.2)
						newBox.Anchored = true
						newBox.CanCollide = false
						newBox.TopSurface = "Smooth"
						newBox.BottomSurface = "Smooth"
						newBox.Locked = true
						
						
						local mesh = Instance.new("BlockMesh")
						mesh.Scale = Vector3.new(box.Size.X/.2,box.Size.Y/.2,box.Size.Z/.2)
						mesh.Parent = newBox
						
						boxes[box] = newBox
						
						box.Transparency = 1
					
					end
				end
				wait(3)
			end
			
		elseif seat.Name == "Driver" and seat.Parent:FindFirstChild("Car") then
			
			Realign(20,13)

			
			--find the car bumper
			local bumper = nil
			for _,part in ipairs(seat.Parent:GetChildren()) do
				if part:FindFirstChild("Bumper") then
					bumper = part
					break
				end
			end
			if not bumper then return end
			
			collisionDebounce = false
			
			--send player flying when hit
			collisionBumperTouched = bumper.Touched:connect(function(hit)
				if not collisionDebounce and hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and bumper.Velocity.Magnitude > 10 then
					collisionDebounce = true
					local player = game.Players:GetPlayerFromCharacter(hit.Parent)
					if player then
						
						game.Workspace.Main.TripPlayer:FireServer(player,bumper.Velocity)
						
					end
					wait(15)
					collisionDebounce = false
				end
			end)
			
		end
	
	
	elseif not active then--player jumped out of seat

		if inVehicleSeat then
			inVehicleSeat = false
			Realign(25,12)
		else
			return
		end
		
		if collisionBumperTouched then collisionBumperTouched:disconnect() collisionBumperTouched = nil end
		
		
		if collecting then --if truck
			
			collecting = false
			
			game:GetService("RunService"):UnbindFromRenderStep("SupplyBoxes")
		
			for box,clone in pairs(boxes) do
				box.Transparency = 0
				clone:Destroy()
				boxes[box] = nil
			end
			
			boxDestroyed:disconnect()
			boxDestroyed = nil
		end
		
	end
end




		
--realign camera after the game takes control of the camera - cars, after tutorial, after choose job
		
function Realign(angle,zoomOutDistance,driveGuiEnabled)	
	
		if CameraLock.Value then return end --dont align camera while mobile player is dragging somthing
		
	
		if not player.Character or not player.Character:FindFirstChild("Head") then return end

		
		local zoom = zoomOutDistance or  (camera.CoordinateFrame.p - player.Character.Head.Position).magnitude
		
		
		player.CameraMaxZoomDistance = zoom
		player.CameraMinZoomDistance = zoom
		
		if not player.Character then return end

		local direction = player.Character.Head.CFrame.lookVector
		

		
		local x = zoom * math.cos(math.rad(angle))
		local y = zoom * math.sin(math.rad(angle))
		
		
		
		local coord = player.Character.Head.Position + (direction * -x)
		local coordX =  coord.X
		local coordZ = coord.Z
	
		local coordY = player.Character.Head.Position.Y + y

		
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CoordinateFrame = CFrame.new(Vector3.new(coordX,coordY,coordZ),player.Character.Head.Position)
		
		camera.CameraType = Enum.CameraType.Custom
		player.CameraMaxZoomDistance = 50
		player.CameraMinZoomDistance = 0.5
	

end



workspace.Main.RealignCamera.OnClientEvent:connect(Realign)
workspace.Main.RealignCamera.RealignCamera.Event:connect(Realign)



--put player camera at a better angle when spawn
--[[local function SpawnCameraAlign()
	local CameraUtil = require(game.ReplicatedStorage.Utilities.CameraUtil)
	player.Character:WaitForChild("Head")
	for i=1,500 do
		if math.abs(12.5 - CameraUtil:GetPitchAngle(player.Character.Head)) < .6 then
			Realign(25,12)	
			camera.CameraSubject = player.Character.Humanoid
			break
		end
		wait()
	end
end]]


local connection

local function UpdateConnections(character)
	if connection then connection:disconnect() end
	local humanoid = character:WaitForChild("Humanoid",5)
	if humanoid then
		connection = humanoid.Seated:connect(PlayerSat)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
	end 
end

player.CharacterAdded:connect(function(character)
	UpdateConnections(character)
end)

if player.Character then
	UpdateConnections(player.Character)
end





