-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local HoverHighlight = require(ReplicatedStorage.Library.Client.WorldFX.HoverHighlight)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local SurfaceTracker = require(ReplicatedStorage.Library.Client.SmartProximityPrompt.SurfaceTracker)
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local t = {}
local t2 = {}
local v1 = nil
local v2 = nil
local v3 = ""
local v4 = nil
local v5 = 0
local v6 = nil
local v7 = nil
local t3 = {}

local function getKey(p1, p2) --[[ getKey | Line: 76 ]]
	return ("%*:%*"):format(p1, p2)
end

local function bindGui() --[[ bindGui | Line: 80 | Upvalues: v2 (ref), GUI (copy) ]]
	local v1 = v2

	if v1 == nil then
		local v22 = GUI.AssetEggData()

		assert(v22:IsA("ScreenGui"), "PlayerGui.AssetEggData must be a ScreenGui")

		local Frame = v22.Frame

		assert(Frame:IsA("GuiObject"), "AssetEggData.Frame must be a GuiObject")

		local CanvasGroup = Frame.CanvasGroup

		assert(CanvasGroup:IsA("GuiObject"), "AssetEggData.Frame.CanvasGroup must be a GuiObject")

		local DisplayName = CanvasGroup.DisplayName

		assert(DisplayName:IsA("TextLabel"), "AssetEggData.Frame.CanvasGroup.DisplayName must be a TextLabel")

		local RemainingHatchTime = CanvasGroup.RemainingHatchTime

		assert(RemainingHatchTime:IsA("TextLabel"), "AssetEggData.Frame.CanvasGroup.RemainingHatchTime must be a TextLabel")

		local t = {
			Root = v22,
			Frame = Frame,
			CanvasGroup = CanvasGroup,
			DisplayName = DisplayName,
			RemainingHatchTime = RemainingHatchTime
		}

		v2 = t
		Frame.Visible = false
		RemainingHatchTime.RichText = true

		return t
	end

	return v1
end

local function getRemainingSeconds(p1) --[[ getRemainingSeconds | Line: 111 | Upvalues: EggItemUtil (copy), Workspace (copy) ]]
	local Record = p1.Record
	local Placement = Record.Placement

	if Placement == nil or Placement.ReadyAt ~= nil then
		return 0
	end

	local TimeSkipSeconds = p1.TimeSkipSeconds
	local v1 = if TimeSkipSeconds == nil then 0 else TimeSkipSeconds.Value

	return math.max(0, EggItemUtil.GetRemainingGrowthSeconds(Record, Workspace:GetServerTimeNow(), Record.GrowthSpeedMultiplier) - v1)
end

local function getEntryScreenPosition(p1) --[[ getEntryScreenPosition | Line: 127 | Upvalues: Workspace (copy), BBFromModelVisibleOnly (copy) ]]
	local CurrentCamera = Workspace.CurrentCamera

	if CurrentCamera == nil then
		return false, Vector2.zero
	end

	local v1, v2 = CurrentCamera:WorldToViewportPoint(BBFromModelVisibleOnly(p1.Model).Position)

	if v2 then
		return true, Vector2.new(v1.X, v1.Y)
	end

	return false, Vector2.zero
end

local function isEntryInRange(p1) --[[ isEntryInRange | Line: 143 | Upvalues: Players (copy) ]]
	local Character = Players.LocalPlayer.Character

	if Character == nil then
		return false
	end

	local PrimaryPart = Character.PrimaryPart

	if PrimaryPart == nil then
		return false
	end

	local _, v1 = p1.Tracker:GetClosestSurfacePoint(PrimaryPart.Position, 0)

	return if v1 == nil then false else v1 <= 7
end

local function selectNearestEntry() --[[ selectNearestEntry | Line: 158 | Upvalues: Players (copy), t (copy) ]]
	local Character = Players.LocalPlayer.Character

	if Character == nil or Character.PrimaryPart == nil then
		return nil
	end

	local Position = Character.PrimaryPart.Position
	local v1 = (1 / 0)
	local v2 = nil

	for k, v in pairs(t) do
		if v.Model.Parent ~= nil then
			local _, v3 = v.Tracker:GetClosestSurfacePoint(Position, 0)

			if v3 ~= nil and (v3 <= 7 and v3 < v1) then
				v1 = v3
				v2 = v
			end
		end
	end

	return v2
end

local function updateStaticContent(p1, p2) --[[ updateStaticContent | Line: 182 | Upvalues: Assets (copy), GradientSwap (copy) ]]
	local v1 = Assets.Directory[p2.Record.AssetCategory]

	assert(if v1 == nil then false else true, (("Missing asset config for category %*"):format(p2.Record.AssetCategory)))
	p1.DisplayName.Text = "Egg"
	GradientSwap(p1.DisplayName, if v1.Egg.HideRarity then nil else v1.Rarity.Gradient)
end

local function updateCountdown(p1, p2) --[[ updateCountdown | Line: 190 | Upvalues: Players (copy), v3 (ref), EggItemUtil (copy), Workspace (copy), FormatDurationSymbol (copy) ]]
	local v1 = if p2.OwnerUserId == Players.LocalPlayer.UserId then true else false

	p1.RemainingHatchTime.Visible = v1

	if not v1 then
		v3 = ""

		return
	end

	local Record = p2.Record
	local Placement = Record.Placement
	local v2

	if Placement == nil or Placement.ReadyAt ~= nil then
		v2 = 0
	else
		local TimeSkipSeconds = p2.TimeSkipSeconds
		local v32 = if TimeSkipSeconds == nil then 0 else TimeSkipSeconds.Value

		v2 = math.max(0, EggItemUtil.GetRemainingGrowthSeconds(Record, Workspace:GetServerTimeNow(), Record.GrowthSpeedMultiplier) - v32)
	end

	local v6 = if v2 <= 0 then "Ready!" else FormatDurationSymbol(v2)

	if v2 > 0 and p2.Record.GrowthSpeedMultiplier > 1 then
		v6 = v6 .. " <font color=\"#FFD700\">(x2)</font>"
	end

	if v6 ~= v3 then
		v3 = v6
		p1.RemainingHatchTime.Text = v6
	end
end

local function clearActiveHighlight() --[[ clearActiveHighlight | Line: 211 | Upvalues: v4 (ref), HoverHighlight (copy) ]]
	local v1 = v4

	v4 = nil

	if v1 == nil then
		return
	end

	HoverHighlight.FadeOut(v1, 0.25)
end

local function clearFadeTween() --[[ clearFadeTween | Line: 219 | Upvalues: v6 (ref), v7 (ref) ]]
	local v1 = v6

	v6 = nil
	v7 = nil

	if v1 == nil then
		return
	end

	v1:Cancel()
	v1:Destroy()
end

local function playCanvasFade(p1, p2, p3) --[[ playCanvasFade | Line: 229 | Upvalues: v6 (ref), v7 (ref), v1 (ref), v5 (ref), Tween (copy) ]]
	if v6 ~= nil and v7 == p2 then
		return
	end

	local v12 = v6

	v6 = nil
	v7 = nil

	if v12 ~= nil then
		v12:Cancel()
		v12:Destroy()
	end

	v7 = p2

	if p2 < 1 then
		p1.Frame.Visible = true
	end

	if not (math.abs(p1.CanvasGroup.GroupTransparency - p2) <= 0.001) then
		local v3 = Tween(p1.CanvasGroup, {
			GroupTransparency = p2
		}, { 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

		v6 = v3
		v3.Completed:Once(function(p12) --[[ Line: 255 | Upvalues: v6 (ref), v3 (copy), v7 (ref), p1 (copy), p2 (copy), p3 (copy), v1 (ref), v5 (ref) ]]
			if v6 == v3 then
				v6 = nil
				v7 = nil
			end

			v3:Destroy()

			if p12 ~= Enum.PlaybackState.Completed then
				return
			end

			p1.CanvasGroup.GroupTransparency = p2

			if not (p2 >= 1) or (p3 == nil or (v1 ~= nil or v5 ~= p3)) then
				return
			end

			p1.Frame.Visible = false
		end)

		return
	end

	p1.CanvasGroup.GroupTransparency = p2
	v7 = nil

	if not (p2 >= 1) or (p3 == nil or (v1 ~= nil or v5 ~= p3)) then
		return
	end

	p1.Frame.Visible = false
end

local function setActiveEntry(p1) --[[ setActiveEntry | Line: 272 | Upvalues: v1 (ref), bindGui (copy), v3 (ref), v5 (ref), v4 (ref), HoverHighlight (copy), playCanvasFade (copy), Assets (copy), GradientSwap (copy), updateCountdown (copy) ]]
	v5 = v5 + 1

	if p1 == nil then
		if v1 == nil then
			return
		end

		local v12 = bindGui()

		v1 = nil
		v3 = ""

		local v32 = v4

		v4 = nil

		if v32 ~= nil then
			HoverHighlight.FadeOut(v32, 0.25)
		end

		if not v12.Frame.Visible then
			return
		end

		playCanvasFade(v12, 1, v5)
	else
		local v42 = bindGui()

		if not v42.Frame.Visible then
			v42.CanvasGroup.GroupTransparency = 1
		end

		playCanvasFade(v42, 0, nil)

		local v52 = ("%*:%*"):format(p1.OwnerUserId, p1.Uid)

		if v1 ~= v52 then
			v1 = v52
			v3 = ""

			local v6 = v4

			v4 = nil

			if v6 ~= nil then
				HoverHighlight.FadeOut(v6, 0.25)
			end

			v4 = HoverHighlight.FadeIn(p1.Model, "EggHoverHighlight", 0.25)

			local v7 = Assets.Directory[p1.Record.AssetCategory]

			assert(if v7 == nil then false else true, (("Missing asset config for category %*"):format(p1.Record.AssetCategory)))
			v42.DisplayName.Text = "Egg"
			GradientSwap(v42.DisplayName, if v7.Egg.HideRarity then nil else v7.Rarity.Gradient)
		end

		updateCountdown(v42, p1)
		v42.Frame.Visible = true
	end
end

local function updateBillboard() --[[ updateBillboard | Line: 310 | Upvalues: t2 (copy), v1 (ref), bindGui (copy), v3 (ref), v5 (ref), v4 (ref), HoverHighlight (copy), playCanvasFade (copy), selectNearestEntry (copy), Players (copy), Workspace (copy), BBFromModelVisibleOnly (copy), setActiveEntry (copy) ]]
	if next(t2) == nil then
		local v12 = selectNearestEntry()

		if v12 ~= nil then
			local Character = Players.LocalPlayer.Character
			local v2

			if Character == nil then
				v2 = false
			else
				local PrimaryPart = Character.PrimaryPart

				if PrimaryPart == nil then
					v2 = false
				else
					local _, v32 = v12.Tracker:GetClosestSurfacePoint(PrimaryPart.Position, 0)

					v2 = if v32 == nil then false elseif v32 <= 7 then true else false
				end
			end

			if v2 then
				local v42 = bindGui()
				local CurrentCamera = Workspace.CurrentCamera
				local v52, v6

				if CurrentCamera == nil then
					v52 = Vector2.zero
					v6 = false
				else
					local v7, v8 = CurrentCamera:WorldToViewportPoint(BBFromModelVisibleOnly(v12.Model).Position)

					if v8 then
						v6, v52 = true, Vector2.new(v7.X, v7.Y)
					else
						v52 = Vector2.zero
						v6 = false
					end
				end

				if v6 then
					setActiveEntry(v12)
					v42.Frame.Position = UDim2.fromOffset(v52.X, v52.Y)

					return
				end

				if v1 == nil then
					return
				end

				local v10 = bindGui()

				v1 = nil
				v3 = ""
				v5 = v5 + 1

				local v122 = v4

				v4 = nil

				if v122 ~= nil then
					HoverHighlight.FadeOut(v122, 0.25)
				end

				if not v10.Frame.Visible then
					return
				end

				playCanvasFade(v10, 1, v5)

				return
			end
		end

		if v1 == nil then
			return
		end

		local v13 = bindGui()

		v1 = nil
		v3 = ""
		v5 = v5 + 1

		local v15 = v4

		v4 = nil

		if v15 ~= nil then
			HoverHighlight.FadeOut(v15, 0.25)
		end

		if not v13.Frame.Visible then
			return
		end

		playCanvasFade(v13, 1, v5)
	else
		if v1 == nil then
			return
		end

		local v16 = bindGui()

		v1 = nil
		v3 = ""
		v5 = v5 + 1

		local v18 = v4

		v4 = nil

		if v18 ~= nil then
			HoverHighlight.FadeOut(v18, 0.25)
		end

		if not v16.Frame.Visible then
			return
		end

		playCanvasFade(v16, 1, v5)
	end
end

function t3.SetEntry(p1) --[[ SetEntry | Line: 337 | Upvalues: Asserts (copy), Eggs (copy), t (copy), SurfaceTracker (copy) ]]
	Asserts.number(p1.OwnerUserId)
	Asserts.string(p1.Uid)
	Asserts.Model(p1.Model)
	assert(Eggs.SchemaValidation.RuntimeEggRecord(p1.Record), "Invalid runtime egg record")

	local v2 = ("%*:%*"):format(p1.OwnerUserId, p1.Uid)
	local v3 = t[v2]
	local v4 = if v3 == nil or v3.Model ~= p1.Model then SurfaceTracker.new(p1.Model) else v3.Tracker

	if v3 ~= nil and v3.Model ~= p1.Model then
		v3.Tracker:Destroy()
	end

	t[v2] = {
		OwnerUserId = p1.OwnerUserId,
		Uid = p1.Uid,
		Record = p1.Record,
		Model = p1.Model,
		TimeSkipSeconds = p1.TimeSkipSeconds,
		Tracker = v4
	}
end
function t3.SetNightPresentationActive(p1, p2, p3) --[[ SetNightPresentationActive | Line: 362 | Upvalues: Asserts (copy), t2 (copy), v1 (ref), bindGui (copy), v3 (ref), v5 (ref), v4 (ref), HoverHighlight (copy), playCanvasFade (copy) ]]
	Asserts.number(p1)
	Asserts.string(p2)
	Asserts.boolean(p3)

	local v12 = ("%*:%*"):format(p1, p2)

	if p3 then
		t2[v12] = p1

		if v1 == nil then
			return
		end

		local v2 = bindGui()

		v1 = nil
		v3 = ""
		v5 = v5 + 1

		local v32 = v5
		local v42 = v4

		v4 = nil

		if v42 ~= nil then
			HoverHighlight.FadeOut(v42, 0.25)
		end

		if v2.Frame.Visible then
			playCanvasFade(v2, 1, v32)
		end
	else
		t2[v12] = nil
	end
end
function t3.RemoveEntry(p1, p2) --[[ RemoveEntry | Line: 376 | Upvalues: Asserts (copy), t (copy), t2 (copy), v1 (ref), bindGui (copy), v3 (ref), v5 (ref), v4 (ref), HoverHighlight (copy), playCanvasFade (copy) ]]
	Asserts.number(p1)
	Asserts.string(p2)

	local v12 = ("%*:%*"):format(p1, p2)
	local v2 = t[v12]

	if v2 ~= nil then
		v2.Tracker:Destroy()
	end

	t[v12] = nil
	t2[v12] = nil

	if v1 ~= v12 then
		return
	end

	if v1 == nil then
		return
	end

	local v32 = bindGui()

	v1 = nil
	v3 = ""
	v5 = v5 + 1

	local v52 = v4

	v4 = nil

	if v52 ~= nil then
		HoverHighlight.FadeOut(v52, 0.25)
	end

	if not v32.Frame.Visible then
		return
	end

	playCanvasFade(v32, 1, v5)
end
function t3.DestroyOwner(p1) --[[ DestroyOwner | Line: 392 | Upvalues: Asserts (copy), t (copy), v1 (ref), bindGui (copy), v3 (ref), v5 (ref), v4 (ref), HoverHighlight (copy), playCanvasFade (copy), t2 (copy) ]]
	Asserts.number(p1)

	for k, v in pairs(t) do
		if v.OwnerUserId == p1 then
			v.Tracker:Destroy()
			t[k] = nil

			if v1 == k and v1 ~= nil then
				local v12 = bindGui()

				v1 = nil
				v3 = ""
				v5 = v5 + 1

				local v2 = v5
				local v32 = v4

				v4 = nil

				if v32 ~= nil then
					HoverHighlight.FadeOut(v32, 0.25)
				end

				if v12.Frame.Visible then
					playCanvasFade(v12, 1, v2)
				end
			end
		end
	end

	for k, v in pairs(t2) do
		if v == p1 then
			t2[k] = nil
		end
	end
end
RenderStepped(function() --[[ Line: 415 | Upvalues: updateBillboard (copy) ]]
	updateBillboard()

	return nil
end)

return t3