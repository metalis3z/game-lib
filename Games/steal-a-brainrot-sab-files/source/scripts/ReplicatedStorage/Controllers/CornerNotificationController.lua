-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Spr = require(ReplicatedStorage.Packages.Spr)
local PlayerGui = Players.LocalPlayer.PlayerGui
local t1 = {}
local CurrentCamera = workspace.CurrentCamera
local DuelsMachinePrompt = PlayerGui:WaitForChild("DuelsMachinePrompt").DuelsMachinePrompt
local t2 = {}

local function reconcileAll()
	local AbsoluteSizeY = DuelsMachinePrompt.AbsoluteSize.Y

	if AbsoluteSizeY <= 0 then
		return
	end

	local n1 = 0.01

	for _, v14 in t2 do
		if v14.frame then
			local AbsoluteSizeY2 = v14.frame.AbsoluteSize.Y

			Spr.target(v14.frame, 1, 5, {
				Position = UDim2.fromScale(1, 1 - n1)
			})
			n1 += AbsoluteSizeY2 / AbsoluteSizeY + 0.01
		end
	end
end

function t1.Add(_: {[any]: any}, p1)
	local u18 = false
	local t4 = {
		frame = p1
	}

	table.insert(t2, t4)
	p1.Parent = DuelsMachinePrompt
	p1.Position = UDim2.fromScale(1.3, 1)
	reconcileAll()

	return function()
		if u18 then
			return
		end

		u18 = true

		local v24 = table.find(t2, t4)

		if not v24 then
			return
		end

		table.remove(t2, v24)
		Spr.target(p1, 1, 5, {
			Position = UDim2.fromScale(1, 1.2)
		})
		task.delay(1, function()
			p1:Destroy()
		end)
		reconcileAll()
	end
end
function t1.Start(_)
	local u21 = nil

	local function updateHolderPosition()
		if u21 then
			DuelsMachinePrompt.AnchorPoint = Vector2.new(0.5, 1)
			DuelsMachinePrompt.Position = UDim2.fromScale(0.5, 1) + UDim2.fromOffset(0, u21.Position.Y.Offset)

			return
		end

		DuelsMachinePrompt.AnchorPoint = Vector2.new(0.5, 0.5)
		DuelsMachinePrompt.Position = UDim2.fromScale(0.5, 1)
	end

	Observers.observeTag("JumpButton", function(p3)
		u21 = p3

		local connection = p3:GetPropertyChangedSignal("Position"):Connect(updateHolderPosition)

		updateHolderPosition()

		return function()
			connection:Disconnect()

			if u21 == p3 then
				u21 = nil
				updateHolderPosition()
			end
		end
	end)

	local u23 = nil

	CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		if u23 and coroutine.status(u23) == "suspended" then
			task.cancel(u23)
		end

		u23 = task.delay(0.1, function()
			u23 = nil
			reconcileAll()
		end)
	end)
end

return t1
