--[[
	Novena Constraint Type: Motorcycle
			The Bike Chassis
	
	
					RikOne2 | Enjin
--]]

--Tune
local WheelieButton = "T"
local DeadZone = 70

--Wheelie tune
local WheelieD = 5
local WheelieTq = 90
local WheelieP = 10
local WheelieMultiplier = 1.5
local WheelieDivider = 2

--Stoppie tune
local StoppieD = 15
local StoppieTq = 65
local StoppieP = 10
local StoppieMultiplier = 1
local StoppieDivider = 2

local clock = .0667 --How fast your wheelie script refreshes

--Dont touch
local bike = script.Parent.Bike.Value
local UserInputService = game:GetService("UserInputService")
local _InControls = false
local wheelie = false
local WheelieInput = 0
local KeyWhel = false

function DealWithInput(input)
	if (UserInputService:GetFocusedTextBox()==nil) and not _InControls then
		if (input.KeyCode == Enum.KeyCode[WheelieButton]) and input.UserInputState == Enum.UserInputState.Begin then
			KeyWhel = true
			WheelieInput = 1
		elseif (input.KeyCode == Enum.KeyCode[WheelieButton]) and input.UserInputState == Enum.UserInputState.End then
			KeyWhel = false
			WheelieInput = 0
		end
		
		if input.UserInputType.Name:find("Gamepad") then
			if input.KeyCode == Enum.KeyCode.ButtonL3 then
				if input.Position.Y>= 0 then
					local cDZone = math.min(.99,DeadZone/100)
					if math.abs(input.Position.Y)>cDZone then
						KeyWhel = false
						WheelieInput = (input.Position.Y-cDZone)/(1-cDZone)
					else
						KeyWhel = false
						WheelieInput = 0
					end
				else
					local cDZone = math.min(.99,DeadZone/100)
					if math.abs(input.Position.Y)>cDZone then
						KeyWhel = false
						WheelieInput = (input.Position.Y+cDZone)/(1-cDZone)
					else
						KeyWhel = false
						WheelieInput = 0
					end
				end
			end
		end
	end
end

UserInputService.InputBegan:connect(DealWithInput)
UserInputService.InputChanged:connect(DealWithInput)
UserInputService.InputEnded:connect(DealWithInput)

local Player = game:FindService('Players').LocalPlayer
local UI = Player.PlayerGui:FindFirstChild('WheelieMobile')
UI:FindFirstChildOfClass('TextButton').MouseButton1Click:Connect(function()
	if KeyWhel == true then
		KeyWhel = false
		WheelieInput = 0
	else
		KeyWhel = true
		WheelieInput = 1
	end
end)

if not bike.Body.Weight:FindFirstChild("wheelie") then
	gyro = Instance.new("BodyGyro")
	gyro.Name = "wheelie"
	gyro.Parent = bike.Body.Weight
else
	gyro = bike.Body.Weight.wheelie
end

bike.Body.Weight:WaitForChild("wheelie")

bike.DriveSeat.ChildRemoved:connect(function(child)
	gyro.D = 0
	gyro.MaxTorque = Vector3.new(0,0,0)
	gyro.P = 0
	gyro.cframe = CFrame.new(bike.Body.Weight.CFrame.p,bike.Body.Weight.CFrame.p+bike.Body.Weight.CFrame.lookVector)*CFrame.Angles(0,0,0)
end)

WheelieDivider = math.max(1,WheelieDivider)

StoppieDivider = math.max(1,StoppieDivider)

while wait(clock) do
	_InControls = script.Parent.ControlsOpen.Value

	if KeyWhel then
		WheelieOutput = -WheelieInput*(script.Parent.Values.Throttle.Value-script.Parent.Values.Brake.Value)
	else
		WheelieOutput = WheelieInput
	end
	
	if script.Parent.Values.Throttle.Value > .1 then
		gyro.D = WheelieD*(-(math.min(WheelieOutput,0))*script.Parent.Values.Throttle.Value)
		gyro.MaxTorque = Vector3.new(WheelieTq*(-(math.min(WheelieOutput,0))*script.Parent.Values.Throttle.Value),0,0)
		gyro.P = WheelieP*(-(math.min(WheelieOutput,0))*script.Parent.Values.Throttle.Value)
		gyro.cframe = CFrame.new(bike.Body.Weight.CFrame.p,bike.Body.Weight.CFrame.p+bike.Body.Weight.CFrame.lookVector)*CFrame.Angles((-(math.min(WheelieOutput,0)*WheelieMultiplier/WheelieDivider)*script.Parent.Values.Throttle.Value)-bike.Body.Weight.CFrame.lookVector.Y,0,0)
	elseif script.Parent.Values.Brake.Value > .1 then
		gyro.D = StoppieD*((math.min(-WheelieOutput,0))*script.Parent.Values.Brake.Value)
		gyro.MaxTorque = Vector3.new(StoppieTq*((math.min(-WheelieOutput,0))*script.Parent.Values.Brake.Value),0,0)
		gyro.P = StoppieP*((math.min(-WheelieOutput,0))*script.Parent.Values.Brake.Value)
		gyro.cframe = CFrame.new(bike.Body.Weight.CFrame.p,bike.Body.Weight.CFrame.p+bike.Body.Weight.CFrame.lookVector)*CFrame.Angles(((math.min(-WheelieOutput,0)*StoppieMultiplier/StoppieDivider)*script.Parent.Values.Brake.Value)-bike.Body.Weight.CFrame.lookVector.Y,0,0)
	else
		gyro.D = 0
		gyro.MaxTorque = Vector3.new(0,0,0)
		gyro.P = 0
		gyro.cframe = CFrame.new(bike.Body.Weight.CFrame.p,bike.Body.Weight.CFrame.p+bike.Body.Weight.CFrame.lookVector)*CFrame.Angles(0,0,0)
	end

end