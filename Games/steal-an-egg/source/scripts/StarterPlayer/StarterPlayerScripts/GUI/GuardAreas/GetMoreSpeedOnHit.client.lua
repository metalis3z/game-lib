-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local Guards = Constants.NETWORK_MAP.Guards
local v1 = Color3.fromRGB(255, 64, 64)
local v2 = Color3.fromRGB(48, 255, 105)
local v3 = Log.new()
local v4 = GUI.GetMoreSpeedOnHit()
local Frame = v4.Frame

assert(Frame:IsA("Frame"), "PlayerGui.GetMoreSpeedOnHit.Frame must be a Frame")

local Button = Frame.Button

assert(Button:IsA("GuiButton"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button must be a GuiButton")

local Frame2 = Button.Frame

assert(Frame2:IsA("Frame"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame must be a Frame")

local Title = Frame2.Title

assert(Title:IsA("TextLabel"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame.Title must be a TextLabel")

local v9 = GetOrCreateUIScale(Frame2)
local Position = Frame.Position
local v10 = UDim2.new(Position.X.Scale, Position.X.Offset, -0.4, Position.Y.Offset)
local TextColor3 = Title.TextColor3
local Scale = v9.Scale
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = 0

local function playPositionTween(p1, p2) --[[ playPositionTween | Line: 55 | Upvalues: v11 (ref), Tween (copy), Frame (copy) ]]
	if v11 == nil then
		v11 = Tween(Frame, {
			Position = p1
		}, { 0.4, "Back", p2 })

		return v11
	end

	v11:Cancel()
	v11 = Tween(Frame, {
		Position = p1
	}, { 0.4, "Back", p2 })

	return v11
end

local function stopTitlePulse() --[[ stopTitlePulse | Line: 63 | Upvalues: v12 (ref) ]]
	local v1 = v12

	if v1 ~= nil then
		v12 = nil
		v1:Destroy()
	end
end

local function startTitlePulse() --[[ startTitlePulse | Line: 73 | Upvalues: v12 (ref), Title (copy), TextColor3 (copy), v9 (copy), Scale (copy), Trove (copy), Tween (copy), v2 (copy) ]]
	local v1 = v12
	local v22

	if v1 == nil then
		Title.TextColor3 = TextColor3
		v9.Scale = Scale
		v22 = Trove.new()
		v12 = v22
		v22:Add(function() --[[ Line: 80 | Upvalues: Title (ref), TextColor3 (ref), v9 (ref), Scale (ref) ]]
			Title.TextColor3 = TextColor3
			v9.Scale = Scale
		end)
		v22:Add(task.spawn(function() --[[ Line: 84 | Upvalues: v12 (ref), v22 (copy), Title (ref), TextColor3 (ref), v9 (ref), Scale (ref), Tween (ref), v2 (ref) ]]
			while v12 == v22 do
				Title.TextColor3 = TextColor3
				v9.Scale = Scale

				local v1 = Tween(Title, {
					TextColor3 = v2
				}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
				local v23 = Tween(v9, {
					Scale = Scale * 1.3
				}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

				v22:Add(v1)
				v22:Add(v23)
				v23.Completed:Wait()

				if v12 ~= v22 then
					break
				end

				local v3 = Tween(Title, {
					TextColor3 = TextColor3
				}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })
				local v4 = Tween(v9, {
					Scale = Scale
				}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

				v22:Add(v3)
				v22:Add(v4)
				v4.Completed:Wait()
				Title.TextColor3 = TextColor3
				v9.Scale = Scale
			end
		end))

		return
	end

	v12 = nil
	v1:Destroy()
	Title.TextColor3 = TextColor3
	v9.Scale = Scale
	v22 = Trove.new()
	v12 = v22
	v22:Add(function() --[[ Line: 80 | Upvalues: Title (ref), TextColor3 (ref), v9 (ref), Scale (ref) ]]
		Title.TextColor3 = TextColor3
		v9.Scale = Scale
	end)
	v22:Add(task.spawn(function() --[[ Line: 84 | Upvalues: v12 (ref), v22 (copy), Title (ref), TextColor3 (ref), v9 (ref), Scale (ref), Tween (ref), v2 (ref) ]]
		while v12 == v22 do
			Title.TextColor3 = TextColor3
			v9.Scale = Scale

			local v1 = Tween(Title, {
				TextColor3 = v2
			}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
			local v23 = Tween(v9, {
				Scale = Scale * 1.3
			}, { 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

			v22:Add(v1)
			v22:Add(v23)
			v23.Completed:Wait()

			if v12 ~= v22 then
				break
			end

			local v3 = Tween(Title, {
				TextColor3 = TextColor3
			}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })
			local v4 = Tween(v9, {
				Scale = Scale
			}, { 0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

			v22:Add(v3)
			v22:Add(v4)
			v4.Completed:Wait()
			Title.TextColor3 = TextColor3
			v9.Scale = Scale
		end
	end))
end

local function showOffer(p1, p2) --[[ showOffer | Line: 124 | Upvalues: v14 (ref), v13 (ref), Title (copy), Simple (copy), Frame (copy), v10 (copy), startTitlePulse (copy), v4 (copy), playPositionTween (copy), Position (copy), v12 (ref) ]]
	v14 = v14 + 1

	local v1 = v14

	v13 = p1
	Title.Text = ("+%*"):format((Simple.FormatCompact(p2, ".#")))
	Frame.Position = v10
	startTitlePulse()
	v4.Enabled = true
	playPositionTween(Position, "Out")
	task.delay(6, function() --[[ Line: 134 | Upvalues: v1 (copy), v14 (ref), playPositionTween (ref), v10 (ref), v12 (ref), v13 (ref), v4 (ref) ]]
		if v1 == v14 then
			playPositionTween(v10, "In").Completed:Once(function() --[[ Line: 139 | Upvalues: v1 (ref), v14 (ref), v12 (ref), v13 (ref), v4 (ref) ]]
				if v1 ~= v14 then
					return
				end

				local v15 = v12

				if v15 ~= nil then
					v12 = nil
					v15:Destroy()
				end

				v13 = nil
				v4.Enabled = false
			end)
		end
	end)
end

v4.Enabled = false
Title.TextColor3 = TextColor3
v9.Scale = Scale
ButtonFX(Button, nil, function() --[[ Line: 157 | Upvalues: v13 (ref), v3 (copy), PromptPurchase (copy) ]]
	local v1 = v13

	if v1 == nil then
		v3:AtWarning():Log("GetMoreSpeedOnHit button activated without an active product")
	else
		PromptPurchase.Prompt(v1, true)
	end
end)
Network.Fired(Guards.SPEED_HIT_WARNING):Connect(function() --[[ Line: 166 | Upvalues: Message (copy), v1 (copy) ]]
	Message.Bottom({
		Message = "You don\'t have enough speed!",
		Time = 2,
		Color = v1
	})
end)
Network.Fired(Guards.SPEED_HIT_OFFER):Connect(showOffer)