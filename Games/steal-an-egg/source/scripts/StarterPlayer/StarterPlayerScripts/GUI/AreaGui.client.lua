-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Areas)

local AreaNotificationTracker = require(script.Parent.Parent:WaitForChild("Game"):WaitForChild("GuardAreas"):WaitForChild("AreaNotificationTracker"))
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local GuiTransitionGroup = require(ReplicatedStorage.Library.Client.GUIFX.GuiTransitionGroup)
local v1 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v3 = GUI.AreaGui()
local Frame = v3.Frame
local Main = Frame.Texts.Main
local Emoji = Frame.Texts.Emoji
local t = {}
local v4 = 0
local v5 = nil

local function applyRarityGradient(p1) --[[ applyRarityGradient | Line: 48 | Upvalues: GradientSwap (copy), Main (copy) ]]
	GradientSwap(Main, p1.Rarity.Gradient)
end

local function renderArea(p1) --[[ renderArea | Line: 53 | Upvalues: Main (copy), Emoji (copy), GradientSwap (copy) ]]
	Main.Text = ("%*"):format(p1.DisplayName)
	Emoji.Text = ("%*"):format(p1.Emoji)
	GradientSwap(Main, p1.Rarity.Gradient)
end

local function showArea(p1) --[[ showArea | Line: 59 | Upvalues: v4 (ref), v5 (ref), Main (copy), Emoji (copy), GradientSwap (copy), v3 (copy), v1 (copy), v2 (copy) ]]
	v4 = v4 + 1

	local v12 = v4
	local v22 = v5

	assert(if v22 == nil then false else true, "AreaGui transition group must be initialized before show")
	v22:Cancel()
	Main.Text = ("%*"):format(p1.DisplayName)
	Emoji.Text = ("%*"):format(p1.Emoji)
	GradientSwap(Main, p1.Rarity.Gradient)
	v22:PrepareHidden()
	v3.Enabled = true
	v22:TweenVisible(v1)
	task.delay(1, function() --[[ Line: 71 | Upvalues: v12 (copy), v4 (ref), v22 (copy), v2 (ref), v3 (ref) ]]
		if v12 == v4 then
			v22:Cancel()
			v22:TweenHidden(v2)
			task.delay(v2.Time, function() --[[ Line: 79 | Upvalues: v12 (ref), v4 (ref), v3 (ref), v22 (ref) ]]
				if v12 == v4 then
					v3.Enabled = false
					v22:RestorePositions()
				end
			end)
		end
	end)
end

local function start() --[[ start | Line: 90 | Upvalues: v5 (ref), GuiTransitionGroup (copy), v3 (copy), AreaNotificationTracker (copy), showArea (copy) ]]
	v5 = GuiTransitionGroup.new(v3, v3, 0.02)
	v3.Enabled = false
	AreaNotificationTracker.Start(showArea)
end

function t.Start() --[[ Start | Line: 100 | Upvalues: v5 (ref), GuiTransitionGroup (copy), v3 (copy), AreaNotificationTracker (copy), showArea (copy) ]]
	v5 = GuiTransitionGroup.new(v3, v3, 0.02)
	v3.Enabled = false
	AreaNotificationTracker.Start(showArea)
end
t.Start()