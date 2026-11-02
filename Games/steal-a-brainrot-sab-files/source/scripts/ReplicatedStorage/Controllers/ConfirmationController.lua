-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Signal = require(ReplicatedStorage.Packages.Signal)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

local PlayerGui = Players.LocalPlayer.PlayerGui

local confirmationServiceShow
local Confirmation
local Template

local function init()
	if confirmationServiceShow then
		return
	end

	confirmationServiceShow = Net:RemoteEvent("ConfirmationService/Show")
	Confirmation = PlayerGui:WaitForChild("Confirmation")
	Template = Confirmation:WaitForChild("Template")
end

local data = {}

local val2 = false

data.IsInPrompt = function(_)

	return val2
end

data.Show = function(_, text, flag, val3)

	init()

	while val2 do
		task.wait()
	end
	val2 = true
	text = text or "Do you really want to do this?"
	local remoteObj = Signal.new()
	local managedObj = val3 and Confirmation:FindFirstChild(val3) and Confirmation[val3]:Clone() or Template:Clone()
	managedObj.Name = "Confirmation"
	managedObj.Visible = true
	managedObj.Parent = Confirmation
	local Description = managedObj.Content.Description
	local Close = managedObj.Close
	local Yes = managedObj.Yes
	local val1 = managedObj.No
	Description.Text = text

	local function _()

		managedObj:Destroy()
	end

	local function _(val4)

		remoteObj:Fire(val4)
	end
	local animateObj = AnimatedButton.new(Yes)
	animateObj:Animate()
	animateObj.OnActivated:Connect(function()

		remoteObj:Fire(true)
	end)
	local animateObj_2 = AnimatedButton.new(val1)
	animateObj_2:Animate()
	animateObj_2.OnActivated:Connect(function()

		remoteObj:Fire(false)
	end)
	local animateObj_3 = AnimatedButton.new(Close)
	animateObj_3:Animate()
	animateObj_3.OnActivated:Connect(function()

		remoteObj:Fire(false)
	end)
	local flag_2 = nil
	if flag then
		flag_2 = task.delay(flag, function()

			remoteObj:Fire(false)
		end)
	end
	local val5 = remoteObj:Wait()
	managedObj:Destroy()
	remoteObj:Destroy()
	if flag_2 and coroutine.status(flag_2) == "suspended" then
		pcall(task.cancel, flag_2)
	end
	val2 = false

	return val5
end

data.Start = function(_)

	task.spawn(init)

	confirmationServiceShow.OnClientEvent:Connect(function(val6, val7, val8)

		local serverTimeNow = data:Show(val7, val8 - workspace:GetServerTimeNow())
		confirmationServiceShow:FireServer(val6, serverTimeNow)
	end)
end

return data