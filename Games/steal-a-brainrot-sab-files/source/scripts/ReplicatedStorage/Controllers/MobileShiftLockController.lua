-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

game:GetService("RunService")

local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer

return {
	Start = function(_)
		local MobileShiftLock = LocalPlayer.PlayerGui:WaitForChild("RightBottom"):WaitForChild("MobileShiftLock")
		local PlayerScripts = LocalPlayer.PlayerScripts
		local CameraModule = require(PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"))

		MobileShiftLock.Activated:Connect(function()
			if CameraModule.activeMouseLockController then
				CameraModule.activeMouseLockController:OnMouseLockToggled()
			end
		end)

		local v12 = Trove.new()
		local u13 = nil

		local function updateVisibility()
			local v15 = Synchronizer:Get(LocalPlayer)

			if not v15 then
				return
			end

			local v16 = UserInputService.PreferredInput == Enum.PreferredInput.Touch and v15:Get("Settings.Mobile Shift Lock")

			if v16 == u13 then
				return
			end

			u13 = v16
			v12:Clean()
			MobileShiftLock.Visible = v16

			if v16 then
				v12:Add(Observers.observeTag("JumpButton", function(p2)
					local function update()
						local AbsoluteSize = p2.AbsoluteSize
						local AbsolutePosition = p2.AbsolutePosition

						MobileShiftLock.Size = UDim2.fromOffset(AbsoluteSize.X * 0.5, AbsoluteSize.Y * 0.5)
						MobileShiftLock.Position = UDim2.fromOffset(AbsolutePosition.X - AbsoluteSize.X * 0.4, AbsolutePosition.Y - AbsoluteSize.Y * 0.4 * 0.5)
					end

					local connection = p2:GetPropertyChangedSignal("AbsolutePosition"):Connect(update)

					p2:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)

					local AbsoluteSize = p2.AbsoluteSize
					local AbsolutePosition = p2.AbsolutePosition

					MobileShiftLock.Size = UDim2.fromOffset(AbsoluteSize.X * 0.5, AbsoluteSize.Y * 0.5)
					MobileShiftLock.Position = UDim2.fromOffset(AbsolutePosition.X - AbsoluteSize.X * 0.4, AbsolutePosition.Y - AbsoluteSize.Y * 0.4 * 0.5)

					return function()
						connection:Disconnect()
					end
				end))

				return
			end

			if UserInputService.PreferredInput == Enum.PreferredInput.Touch and CameraModule.activeMouseLockController and CameraModule.activeMouseLockController.isMouseLocked then
				CameraModule.activeMouseLockController:OnMouseLockToggled()
			end
		end

		Synchronizer:WaitAndCall(LocalPlayer, function(p3)
			UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateVisibility)
			p3:OnChanged("Settings.Mobile Shift Lock", updateVisibility)
			task.spawn(updateVisibility)
		end)

		if CameraModule.activeMouseLockController and CameraModule.activeMouseLockController.mouseLockToggledEvent then
			CameraModule.activeMouseLockController.mouseLockToggledEvent.Event:Connect(function()
				MobileShiftLock.Image = not CameraModule.activeMouseLockController.isMouseLocked and "rbxasset://textures/ui/mouseLock_off.png" or "rbxasset://textures/ui/mouseLock_on.png"
			end)
			MobileShiftLock.Image = not CameraModule.activeMouseLockController.isMouseLocked and "rbxasset://textures/ui/mouseLock_off.png" or "rbxasset://textures/ui/mouseLock_on.png"
		end
	end
}
