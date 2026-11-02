-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("TweenService")

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local SoundController = require(Controllers.SoundController)
local FFlags = require(ReplicatedStorage.Packages.FFlags)

require(ReplicatedStorage.Packages.Gradients)

local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)
local PlayerGui = Players.LocalPlayer.PlayerGui
local Notification = PlayerGui:WaitForChild("Notification").Notification
local Template = Notification.Template
local v16 = Net:RemoteEvent("NotificationService/Notify")
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
local NotificationController = {}

function NotificationController.Error(_: {[any]: any}, s1: string)
	local v22 = `<font color="#FA0103">{ s1 }</font>`

	NotificationController:Notify(v22, 5, "Sounds.Sfx.Error")
end
function NotificationController.Success(_: {[any]: any}, s2: string)
	local v25 = `<font color="#92FF67">{ s2 }</font>`

	NotificationController:Notify(v25, 5, "Sounds.Sfx.Success")
end

local t4 = {}

function NotificationController.Notify(_: {[any]: any}, s3: string, n1: number?, s4: string?, s5: string?, n2: number | string?, s6: string?, b1: boolean?)
	task.spawn(function()
		n1 = n1 or 5

		if b1 and (s6 ~= nil and t4[s6]) then
			t4[s6]:Destroy()
			t4[s6] = nil

			return
		end

		if s3 == "" then
			if s4 then
				SoundController:PlaySound(s4)
			end

			return
		end

		local v39 = s6 ~= nil and t4[s6]

		if v39 then
			CustomRichTextController.apply(v39, s3)

			return
		end

		local clone = Template:Clone()

		if s6 ~= nil then
			t4[s6] = clone
		end

		if s4 then
			SoundController:PlaySound(s4)
		end

		clone.Visible = true

		if s5 == "Top" then
			clone.Size = UDim2.fromScale(1, 0.3)
		end

		if s5 == "Top" and n2 then
			local uDim2 = UDim2.fromScale(0, 0.4)
			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Size = UDim2.fromScale(1, 1)
			ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
			ImageLabel.Position = uDim2 + UDim2.fromOffset(-12, 0)
			ImageLabel.AnchorPoint = Vector2.new(1, 0.5)

			if type(n2) == "string" then
				ImageLabel.Image = n2
			else
				ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={ n2 }&w=420&h=420`
			end

			ImageLabel.Parent = clone

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0.12, 0)
			UICorner.Parent = ImageLabel
			clone.AutomaticSize = Enum.AutomaticSize.X
			clone.Size = UDim2.fromScale(0, clone.Size.Y.Scale)
		end

		CustomRichTextController.apply(clone, s3)
		clone.Parent = if s5 ~= "Top" then Notification else PlayerGui:WaitForChild("TopNotification").TopNotification
		task.wait(n1)

		if not clone:IsDescendantOf(PlayerGui) then
			if s6 ~= nil then
				t4[s6] = nil
			end

			return
		end

		for _, child in clone:GetChildren() do
			if child:IsA("TextLabel") then
				CreateTween(clone, tweenInfo, {
					TextTransparency = 1
				})
				CreateTween(clone.UIStroke, tweenInfo, {
					Transparency = 1
				})
			end
		end

		task.wait(tweenInfo.Time)
		clone:Destroy()

		if s6 ~= nil then
			t4[s6] = nil
		end
	end)
end
function NotificationController.Start(_)
	task.spawn(function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		if not UserInputService:GetLastInputType() then
			UserInputService.LastInputTypeChanged:Wait()
		end

		if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
			return
		end

		local n3 = 60

		if GuiService:IsTenFootInterface() then
			n3 = 100
		end

		local v47 = n3 + 5 + 5

		Notification.AnchorPoint = Vector2.new(0.5, 1)
		Notification.Position = UDim2.fromScale(0.5, 1) - UDim2.fromOffset(0, v47)
	end)
	v16.OnClientEvent:Connect(function(...)
		NotificationController:Notify(...)
	end)

	local Poll = PlayerGui:WaitForChild("TopUI").Frame.Poll
	local Countdown = PlayerGui:WaitForChild("TopUI").Frame.Countdown

	local function onTopbarInsetUpdate()
		local n4 = 0

		if Poll.Visible then
			n4 += Poll.AbsoluteSize.Y - Poll.Template.AbsoluteSize.Y
		end

		if Countdown.Visible then
			n4 += Countdown.AbsoluteSize.Y
		end

		PlayerGui:WaitForChild("TopNotification").TopNotification.Position = UDim2.fromScale(0.5, 0.075) + UDim2.fromOffset(0, n4)
	end

	GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(onTopbarInsetUpdate)
	Countdown:GetPropertyChangedSignal("AbsoluteSize"):Connect(onTopbarInsetUpdate)
	Countdown:GetPropertyChangedSignal("Visible"):Connect(onTopbarInsetUpdate)
	Poll:GetPropertyChangedSignal("AbsoluteSize"):Connect(onTopbarInsetUpdate)
	Poll:GetPropertyChangedSignal("Visible"):Connect(onTopbarInsetUpdate)
	onTopbarInsetUpdate()
end

return NotificationController