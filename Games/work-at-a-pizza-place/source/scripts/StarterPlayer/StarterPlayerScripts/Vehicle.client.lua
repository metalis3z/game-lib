local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	script:Destroy()
	return
end

local myVehicle = nil
local connector = nil
local debounceTime = 0
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local HatsVisible = false
local vehicle = nil
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local Menu =  MainGui:WaitForChild("Menu"):WaitForChild("Menu")
local VirtualCarControlls = MainGui:WaitForChild("Other"):WaitForChild("VirtualCarControlls")
local CAS = game:GetService("ContextActionService")
local TouchEnabled = game:GetService("UserInputService").TouchEnabled


local JumpButton
local ContextActionFrame
local joyStickMovement, jumpConnection
local OriginalJumpVisible = true



debounce = false
function honkHorn(name,InputState,InputObject)
	if not debounce and InputState == Enum.UserInputState.Begin then
		debounce = true
		myVehicle.LightMain.Horn:Play()
		wait(debounceTime)
		debounce = false
	end
end

function ChangeHatVisiblity(visible)
	for _,obj in ipairs(player.Character:GetChildren()) do
		if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
			obj.Handle.Transparency = (visible and 0 ) or (not visible and 1)
		end
	end
end

local FirstPerson = false
function ToggleFirstPerson(name,InputState,InputObject)
	if InputState == Enum.UserInputState.Begin then
		
		if not FirstPerson  then
			FirstPerson = true
			camera.CameraType = Enum.CameraType.Scriptable
			
			RunService:BindToRenderStep("FirstPerson", Enum.RenderPriority.Camera.Value, function()
				camera.CoordinateFrame = player.Character.Head.CFrame + Vector3.new(0,.5,0)
			end)
			ChangeHatVisiblity(false)
			
		else
			FirstPerson = false
			RunService:UnbindFromRenderStep("FirstPerson")
			camera.CameraType = Enum.CameraType.Custom
			if myVehicle.Name == "Car" then
				workspace.Main.RealignCamera.RealignCamera:Fire(20,13)
			else
				workspace.Main.RealignCamera.RealignCamera:Fire(25,50)
			end
			ChangeHatVisiblity(true)
		end
	end
end

local CAS = game:GetService("ContextActionService")
local goPressed,goReleased,reversePressed,reverseReleased

local sittingInCar = false

function removing(obj)
	if obj.Name == "SeatWeld" then
		sittingInCar = false
		CAS:UnbindAction("View")
		CAS:UnbindAction("Horn")
		CAS:UnbindAction("Jump")
		RunService:UnbindFromRenderStep("FirstPerson")
		camera.CameraType = Enum.CameraType.Custom
		if connector then connector:disconnect() end
		connector = nil
		ChangeHatVisiblity(true)
		if joyStickMovement then joyStickMovement:disconnect() end
		if JumpButton then --is mobile
			JumpButton.Visible = true 
			goPressed:disconnect()
			goReleased:disconnect()
			reversePressed:disconnect()
			reverseReleased:disconnect()
		end
		VirtualCarControlls.Visible = false
		CAS:UnbindAction("RTCar")
		CAS:UnbindAction("LTCar")
		
	
	end
end


workspace.Main.SittingInCar.OnClientEvent:connect(function(vehicle,maxSpeed,turnSpeed)	
	sittingInCar = true
	--if workspace.CurrentCamera.ViewportSize.X >= 960 then
		CAS:BindAction("View", ToggleFirstPerson, true, Enum.KeyCode.V,Enum.KeyCode.ButtonX)
		CAS:SetImage ("View", "rbxassetid://520212839")
		
		CAS:BindAction("Horn", honkHorn, true, Enum.KeyCode.H,Enum.KeyCode.ButtonB)
		CAS:SetImage ("Horn", "rbxassetid://520212899")
		
		CAS:BindAction("Jump", function() pcall(function() game.Players.LocalPlayer.Character.Humanoid.Jump = true end) end, true, Enum.KeyCode.H,Enum.KeyCode.Tab)
		CAS:SetImage ("Jump", "rbxassetid://773407760")
		
		

		
		connector = vehicle.Driver.ChildRemoved:connect(removing)
	
		debounceTime = vehicle.LightMain.Horn.TimeLength
		
		if _G.GamepadEnabled or TouchEnabled then
			
				local seat = vehicle:FindFirstChild("Driver")

			
			local maxSpeed = maxSpeed
			local maxTurnSpeed = turnSpeed + ((_G.GamepadEnabled and .5) or (_G.TouchEnabled and -.3) or 0) --gamepads feel better with a little more turning speed
			local ThrottleDown = false
			local ReverseDown = false
			local speed = 0  -- 1 = max speed
			
			--for gamepad and mobile joystick
			joyStickMovement = game:GetService("RunService").RenderStepped:connect(function()
				seat.TurnSpeed = math.abs(seat.SteerFloat) * maxTurnSpeed
				seat.MaxSpeed = math.abs(speed) * maxSpeed
				if seat.SteerFloat > .1 then seat.Steer = 1 end
				if seat.SteerFloat < -.1 then  seat.Steer = -1 end
				if ThrottleDown then  seat.Throttle = 1 
				elseif ReverseDown then  seat.Throttle = -1 end
				
			end)
			
			
			wait()	
			
			if _G.GamepadEnabled then	
						
				CAS:BindAction("RTCar", function(action,state,inputObject)
					if not ReverseDown then --brake override throttel
						speed = inputObject.Position.Z
					end
					
					if state == Enum.UserInputState.End then
						ThrottleDown = false
					elseif state == Enum.UserInputState.Begin then
						ThrottleDown = true
					end
				end , true, Enum.KeyCode.ButtonR2)
	
	
	
				CAS:BindAction("LTCar", function(action,state,inputObject)
					
				
					if inputObject.Position.Z > .3 then --start brake after button has been press down a certain disatnce
						ReverseDown = true
						speed = -inputObject.Position.Z/2  --reverse at half speed
	
					else --stopped reversing
						ReverseDown = false
						if ThrottleDown then 
							speed = 1 --RT is probably all the way down (at max speed) when the player has lifted the LT button
						end
					end
	
					
				end , true, Enum.KeyCode.ButtonL2)
			
			
			
			else  --mobile
				
				VirtualCarControlls.Visible = true
				
				JumpButton.Visible = false
				
				goPressed = VirtualCarControlls.Throttle.InputBegan:connect(function(inputObject) 
					if not ReverseDown then 
						speed = 1
					end
					ThrottleDown = true
				end)
				
				goReleased = VirtualCarControlls.Throttle.InputEnded:connect(function(inputObject) 
					ThrottleDown = false
					if not ReverseDown then 
						speed = 0
					end
				end)
				
				reversePressed = VirtualCarControlls.Reverse.InputBegan:connect(function(inputObject) 
					speed = -.5
					ReverseDown = true
				end)
				
				reverseReleased = VirtualCarControlls.Reverse.InputEnded:connect(function(inputObject) 
					ReverseDown = false
					if not ThrottleDown then 
						speed = 0
					end
				end)
				
			
				
			end
			
		
		end
	

	
	
end)





--replace context touch buttons
if TouchEnabled then
	
	
	
	JumpButton = PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
	
	local ContextActionGui = PlayerGui:WaitForChild("ContextActionGui")
	ContextActionFrame = ContextActionGui:WaitForChild("ContextButtonFrame")
	ContextActionFrame.AnchorPoint = Vector2.new(1,1)
	ContextActionFrame.Position = UDim2.new(1,0,0,JumpButton.AbsolutePosition.Y)
	ContextActionFrame.Size = UDim2.new(0.09,0,1,0)
	
	local listLayout = Instance.new("UIListLayout",ContextActionFrame)
	listLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	listLayout.Padding = UDim.new(.03,0)
	
	local function AdjustButton(actionButton)
		actionButton.Size = UDim2.new(1,0,1,0)
		--actionButton.ImageColor3 = Color3.new(216/255, 216/255, 216/255)
		Instance.new("UIAspectRatioConstraint",actionButton)
		
	end
	
	ContextActionFrame.ChildAdded:connect(function(actionButton)
		 AdjustButton(actionButton)
	end)
	
	for _,button in ipairs(ContextActionFrame:GetChildren()) do
		if button:IsA("GuiButton") then
			AdjustButton(button)
		end
	end
	--[[spawn(function()
		while true do 
			wait(5)
			if JumpButton.Visible == false and player.Character.Humanoid.Sit == false then  ---incase jump button dosent reappear after jumping
				JumpButton.Visible = true

			elseif sittingInCar and player.Character.Humanoid.Sit == true and #ContextActionFrame:GetChildren() == 1 then --if case control pannel dissapear
				JumpButton.Visible = true
			
			end
		end
	end)]]
end
