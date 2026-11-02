if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player and Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local UserInputService = game:FindService('UserInputService')
local TweenService = game:GetService("TweenService")

local RightAnimation = Humanoid:LoadAnimation(script:WaitForChild('Right'))
local LeftAnimation = Humanoid:LoadAnimation(script:WaitForChild('Left'))

local Cooldown = false

local AnimationPlay = function(Value, Seat, Extra)
	if Value == true and Seat then
		local Animation
		if Seat.Name == 'BackR' or Seat.Name == 'Front' then
			Animation = RightAnimation
		elseif Seat.Name == 'BackL' then
			Animation = LeftAnimation
		end
		Animation:Play()
		task.wait(.35)
		game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, Extra)
	elseif Value == false and Seat then
		local Animation
		if Seat.Name == 'BackR' or Seat.Name == 'Front' then
			Animation = RightAnimation
		elseif Seat.Name == 'BackL' then
			Animation = LeftAnimation
		end
		Animation:Stop()
		Humanoid:UnequipTools()
		game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, Extra)
	end
end

local ProxsChange = function(Arg)
	for _,v in next, workspace:FindFirstChild('CivCars'):GetDescendants() do
		if v:IsA('Seat') or v:IsA('VehicleSeat') then
			if v:FindFirstChildOfClass('ProximityPrompt') then
				v:FindFirstChildOfClass('ProximityPrompt').Enabled = Arg
			end
		end
	end
end
ProxsChange(true)

local DSeat = nil
local Driveby = nil
Humanoid.Seated:Connect(function(Seated, Seat)
	if Seat then
		if Seat:IsA('VehicleSeat') and Seat.Parent:FindFirstChild('CarType') then
			if Seat.Parent:FindFirstChild('CarType').Value == 'DirtBike' then
				if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
					PlayerGui:FindFirstChild('WheelieMobile').Enabled = not PlayerGui:FindFirstChild('WheelieMobile').Enabled
				end
			end
		else
			PlayerGui:FindFirstChild('WheelieMobile').Enabled = false
		end
	else
		PlayerGui:FindFirstChild('WheelieMobile').Enabled = false
	end
	if Seated then
		Humanoid.JumpPower = .1
		ProxsChange(false)
		if (Seat and Seat:IsA('Seat')) or (Seat and Seat:IsA('VehicleSeat') and Seat:FindFirstChildOfClass('BoolValue')) then
			if Seat:FindFirstChildOfClass('BoolValue') then
				DSeat = Seat
				Driveby = Seat.Parent[Seat:FindFirstChildOfClass('BoolValue').Name]
				game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				Humanoid:UnequipTools()
				if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
					PlayerGui:FindFirstChild('DrivebyMobile').Enabled = true
				end
			end
		elseif Seat and Seat:IsA('VehicleSeat') then
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			Humanoid:UnequipTools()
		end
	else
		Humanoid.JumpPower = 0
		ProxsChange(true)
		PlayerGui:FindFirstChild('DrivebyMobile').Enabled = false
		if Driveby ~= nil and DSeat ~= nil then
			DSeat:FindFirstChildOfClass('BoolValue').Value = false
			AnimationPlay(false, Driveby, true)
			Driveby = nil
			DSeat = nil
			PlayerGui:FindFirstChild('DrivebyMobile').Enabled = false
		else
			game:FindService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
	end
end)

UserInputService.InputBegan:Connect(function(Input, Processed)
	if not Processed and not Cooldown then
		if Input.KeyCode == Enum.KeyCode.X or Input.KeyCode == Enum.KeyCode.ButtonL3 then
			if Driveby ~= nil and DSeat ~= nil then
				if not DSeat:FindFirstChildOfClass('BoolValue').Value then
					Cooldown = true
					DSeat:FindFirstChildOfClass('BoolValue').Value = true
					AnimationPlay(true, Driveby, true)
					task.wait(1)
					Cooldown = false
				else
					Cooldown = true
					DSeat:FindFirstChildOfClass('BoolValue').Value = false
					AnimationPlay(false, Driveby, false)
					task.wait(1)
					Cooldown = false
				end
			end
		end
	end
end)

PlayerGui:FindFirstChild('DrivebyMobile').TextButton.InputBegan:Connect(function(Input, Processed)
	if not Processed and not Cooldown then
		if Driveby ~= nil and DSeat ~= nil then
			if not DSeat:FindFirstChildOfClass('BoolValue').Value then
				Cooldown = true
				DSeat:FindFirstChildOfClass('BoolValue').Value = true
				AnimationPlay(true, Driveby, true)
				task.wait(1)
				Cooldown = false
			else
				Cooldown = true
				DSeat:FindFirstChildOfClass('BoolValue').Value = false
				AnimationPlay(false, Driveby, false)
				task.wait(1)
				Cooldown = false
			end
		end
	end
end)

while task.wait(5) do
	pcall(function()
		if Humanoid.Sit == true then
			Humanoid.JumpPower = .1
		end
	end)
end