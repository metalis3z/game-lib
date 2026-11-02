-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local v1 = GUI.Shop()
local v2 = GUI.Money()
local ScrollingFrame = v1.Frame.Main.ScrollingFrame
local SpeedTop = ScrollingFrame.SpeedTop
local ImageButton = v2.Bottom.Frame.SpeedValue.ImageLabel.ImageButton

assert(ImageButton:IsA("GuiButton"), "Expected Money.Bottom.Frame.SpeedValue.ImageLabel.ImageButton to be a GuiButton")

local function centerShopScrollingFrameAt(p1, p2) --[[ centerShopScrollingFrameAt | Line: 31 | Upvalues: Asserts (copy), ScrollingFrame (copy) ]]
	Asserts.number(p2)
	ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X, (math.clamp(p1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y + ScrollingFrame.CanvasPosition.Y + p2 - ScrollingFrame.AbsoluteWindowSize.Y / 2, 0, (math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteWindowSize.Y)))))
end

local function centerSpeedTopBottom() --[[ centerSpeedTopBottom | Line: 45 | Upvalues: centerShopScrollingFrameAt (copy), SpeedTop (copy) ]]
	centerShopScrollingFrameAt(SpeedTop, SpeedTop.AbsoluteSize.Y)
end

local function openShopThenCenter(p1) --[[ openShopThenCenter | Line: 49 | Upvalues: TabController (copy) ]]
	task.spawn(function() --[[ Line: 50 | Upvalues: TabController (ref), p1 (copy) ]]
		TabController.OpenTab("Shop")
		task.wait()
		task.wait()
		p1()
	end)
end

ButtonFX(ImageButton, nil, function() --[[ Line: 62 | Upvalues: centerSpeedTopBottom (copy), TabController (copy) ]]
	local v1 = centerSpeedTopBottom

	task.spawn(function() --[[ Line: 50 | Upvalues: TabController (ref), v1 (copy) ]]
		TabController.OpenTab("Shop")
		task.wait()
		task.wait()
		v1()
	end)
end)