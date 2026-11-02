-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(ReplicatedStorage.Library.Types.AreaEggs)

local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local FormatDurationSymbol = require(ReplicatedStorage.Library.Functions.FormatDurationSymbol)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Save = require(ReplicatedStorage.Library.Client.Save)
local SettingsCmds = require(ReplicatedStorage.Library.Client.SettingsCmds)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)
local Trails = require(ReplicatedStorage.Directory.Trails)
local UpdateTextAndShadow = require(ReplicatedStorage.Library.Functions.UpdateTextAndShadow)
local SpeedGainAnimation = require(ReplicatedStorage.Library.Client.GUIFX.SpeedGainAnimation)
local SpeedPowerProjection = require(ReplicatedStorage.Library.Client.SpeedPowerProjection)
local TreadmillCharacterPresentationController = require(script.Parent.Parent.Game.Plots.TreadmillCharacterPresentationController)
local TreadmillVideoController = require(ReplicatedStorage.Library.Client.TreadmillVideoController)

require(ReplicatedStorage.Library.Client.TreadmillVideoController.Types.Interface)

local Visibility = require(script.Visibility)
local Treadmills3 = Constants.NETWORK_MAP.Treadmills
local v1 = GUI.Money()
local CurrentBoost = v1.Bottom.Frame.SpeedValue.CurrentBoost
local TextColor3 = CurrentBoost.Shadow.TextColor3
local TemporarySpeedBoost = v1.Bottom.Frame.TemporarySpeedBoost
local CurrentBoost2 = TemporarySpeedBoost.CurrentBoost
local v2 = false
local v3 = nil
local v4 = 0
local count = 0
local v5 = nil
local v6 = 1

local function updateSpeedPower() --[[ updateSpeedPower | Line: 64 | Upvalues: Save (copy), SpeedPowerProjection (copy), TreadmillUtil (copy), v6 (ref), Workspace (copy), TextColor3 (copy), Trails (copy), UpdateTextAndShadow (copy), CurrentBoost (copy) ]]
	local v1 = Save.Get()
	local projectedSpeedPower = SpeedPowerProjection.GetSpeedPower()
	local mirroredSpeedPower = Players.LocalPlayer:GetAttribute("SpeedPower")
	if typeof(mirroredSpeedPower) == "number" then
		projectedSpeedPower = math.max(projectedSpeedPower, mirroredSpeedPower)
	end
	local displayedSpeedPower = TreadmillUtil.ResolveEffectiveSpeedPower(projectedSpeedPower, v6)
	local trailMultiplier = if v1
		then TreadmillUtil.ResolveEquippedTrailWalkSpeedMultiplier(v1)
		else math.max(1, tonumber(Players.LocalPlayer:GetAttribute("TrailSpeedMultiplier")) or 1)
	displayedSpeedPower *= trailMultiplier
	local v4 = TreadmillUtil.FormatSpeedPower(math.floor(displayedSpeedPower))
	if not v1 then
		UpdateTextAndShadow(CurrentBoost, v4, TextColor3)
		return
	end
	local v7 = TreadmillUtil.ResolveAdditiveSpeedStepMultiplier(TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(v1), (TreadmillUtil.ResolveTemporarySpeedBoostSpeedStepMultiplier(v1, Workspace:GetServerTimeNow())))
	local v8 = TextColor3
	local EquippedTrail = v1.EquippedTrail

	if EquippedTrail ~= nil and (Trails.Types.TrailNameExists(EquippedTrail) and v1.TrailInventory[EquippedTrail]) then
		v8 = Trails.Directory[EquippedTrail].Rarity.Color
	end

	local v9

	if TreadmillUtil.DEFAULT_SPEED_STEP_MULTIPLIER < v7 then
		local v10 = TreadmillUtil.FormatSpeedMultiplierValue(v7)

		v9 = v4 .. (" (%*)"):format(v10)
		v4 = v4 .. (" <font color=\"#00FF00\">(%*)</font>"):format(v10)
	else
		v9 = nil
	end

	UpdateTextAndShadow(CurrentBoost, v4, v8, v9)
end

local function updateTemporarySpeedBoostDisplay() --[[ updateTemporarySpeedBoostDisplay | Line: 97 | Upvalues: Save (copy), TreadmillUtil (copy), Workspace (copy), TemporarySpeedBoost (copy), CurrentBoost2 (copy), FormatDurationSymbol (copy) ]]
	local v2 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())

	if v2 <= 0 then
		TemporarySpeedBoost.Visible = false

		return false
	end

	TemporarySpeedBoost.Visible = true
	CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v2)))

	return true
end

local function startTemporarySpeedBoostCountdown() --[[ startTemporarySpeedBoostCountdown | Line: 111 | Upvalues: count (ref), Save (copy), TreadmillUtil (copy), Workspace (copy), TemporarySpeedBoost (copy), CurrentBoost2 (copy), FormatDurationSymbol (copy), updateSpeedPower (copy) ]]
	count = count + 1

	local v1 = count
	local v2 = Save.Get()
	local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(v2, Workspace:GetServerTimeNow())
	local v4

	if v3 <= 0 then
		TemporarySpeedBoost.Visible = false
		v4 = false
	else
		TemporarySpeedBoost.Visible = true
		CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
		v4 = true
	end

	if v4 then
		task.spawn(function() --[[ Line: 119 | Upvalues: v1 (copy), count (ref), Save (ref), TreadmillUtil (ref), Workspace (ref), TemporarySpeedBoost (ref), CurrentBoost2 (ref), FormatDurationSymbol (ref), updateSpeedPower (ref) ]]
			while v1 == count do
				local v12

				task.wait(1)

				local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())

				if v3 <= 0 then
					TemporarySpeedBoost.Visible = false
					v12 = false
				else
					TemporarySpeedBoost.Visible = true
					CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
					v12 = true
				end

				updateSpeedPower()
			end
		end)
	end
end

local function stopActiveTreadmillVisualSimulation() --[[ stopActiveTreadmillVisualSimulation | Line: 131 | Upvalues: v5 (ref), SpeedPowerProjection (copy), v4 (ref) ]]
	local v1 = v5

	if v1 == nil then
		v4 = v4 + 1
		v5 = nil

		return
	end

	SpeedPowerProjection.EndSession(v1.Token)
	v4 = v4 + 1
	v5 = nil
end

local function applyTreadmillVideoSetting(p1) --[[ applyTreadmillVideoSetting | Line: 140 | Upvalues: v3 (ref), SettingsCmds (copy), TreadmillVideoController (copy), Save (copy) ]]
	local v1 = v3

	if v1 == nil or SettingsCmds.IsEnabled("DisableVideos") then
		TreadmillVideoController.Stop()

		return
	end

	if p1 ~= nil then
		TreadmillVideoController.Start(v1, p1)

		return
	end

	local v2 = Save.Get()

	assert(v2 ~= nil, "Save data must be loaded before enabling treadmill videos")
	TreadmillVideoController.Start(v1, v2.TreadmillMediaFeedState)
end

local function resolveCurrentSpeedPowerPerStep(p1, p2) --[[ resolveCurrentSpeedPowerPerStep | Line: 157 | Upvalues: TreadmillUtil (copy), Save (copy) ]]
	return TreadmillUtil.ResolveSpeedPowerPerStep(Save.Get(), p1, p2)
end

local function flushPendingScreenSpeedGain(p1) --[[ flushPendingScreenSpeedGain | Line: 161 | Upvalues: SpeedGainAnimation (copy), CurrentBoost (copy), SpeedPowerProjection (copy) ]]
	if not (p1.PendingScreenSpeedPowerDelta <= 0) then
		local PendingScreenSpeedPowerDelta = p1.PendingScreenSpeedPowerDelta

		SpeedGainAnimation.Play(CurrentBoost, PendingScreenSpeedPowerDelta, nil, function() --[[ Line: 167 | Upvalues: SpeedPowerProjection (ref), p1 (copy), PendingScreenSpeedPowerDelta (copy) ]]
			SpeedPowerProjection.RevealCompletedGain(p1.Token, PendingScreenSpeedPowerDelta)
		end)
		p1.PendingScreenSpeedPowerDelta = 0
	end
end

local function resetNextScreenPopupAt(p1, p2) --[[ resetNextScreenPopupAt | Line: 173 | Upvalues: TreadmillUtil (copy) ]]
	p1.NextScreenPopupAt = p2 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
end

local function handleTransparentModeSpeedGainPulse(p1, p2, p3) --[[ handleTransparentModeSpeedGainPulse | Line: 177 | Upvalues: SpeedGainAnimation (copy), CurrentBoost (copy), SpeedPowerProjection (copy), TreadmillUtil (copy) ]]
	p1.PendingScreenSpeedPowerDelta = p1.PendingScreenSpeedPowerDelta + p2

	if not (p1.NextScreenPopupAt <= p3) then
		return
	end

	if not (p1.PendingScreenSpeedPowerDelta <= 0) then
		local PendingScreenSpeedPowerDelta = p1.PendingScreenSpeedPowerDelta

		SpeedGainAnimation.Play(CurrentBoost, PendingScreenSpeedPowerDelta, nil, function() --[[ Line: 167 | Upvalues: SpeedPowerProjection (ref), p1 (copy), PendingScreenSpeedPowerDelta (copy) ]]
			SpeedPowerProjection.RevealCompletedGain(p1.Token, PendingScreenSpeedPowerDelta)
		end)
		p1.PendingScreenSpeedPowerDelta = 0
	end

	p1.NextScreenPopupAt = p3 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
end

local function handleVisibleModeSpeedGainPulse(p1, p2, p3) --[[ handleVisibleModeSpeedGainPulse | Line: 189 | Upvalues: TreadmillUtil (copy), SpeedGainAnimation (copy), CurrentBoost (copy), SpeedPowerProjection (copy) ]]
	p1.PendingScreenSpeedPowerDelta = 0
	p1.NextScreenPopupAt = p3 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
	SpeedGainAnimation.PlayWalk(CurrentBoost, p2, p1.RarityColor, function() --[[ Line: 196 | Upvalues: SpeedPowerProjection (ref), p1 (copy), p2 (copy) ]]
		SpeedPowerProjection.RevealCompletedGain(p1.Token, p2)
	end)
end

local function handleServerSpeedGain(p1, p2) --[[ handleServerSpeedGain | Line: 201 | Upvalues: v5 (ref), SpeedPowerProjection (copy), SpeedGainAnimation (copy), CurrentBoost (copy), updateSpeedPower (copy) ]]
	if p2 == "Treadmill" and v5 ~= nil then
		return
	end

	if p2 == "Instant" and v5 ~= nil then
		local v1 = v5

		v1.SimulatedSpeedPower = v1.SimulatedSpeedPower + p1
		assert(SpeedPowerProjection.RevealCompletedGain(v1.Token, p1), "Instant Speed Power gain must target the active treadmill projection")
		SpeedGainAnimation.Play(CurrentBoost, p1, nil, updateSpeedPower)

		return
	end

	updateSpeedPower()

	if p2 == "Walk" then
		SpeedGainAnimation.PlayWalk(CurrentBoost, p1, nil, updateSpeedPower)
	else
		SpeedGainAnimation.Play(CurrentBoost, p1, nil, updateSpeedPower)
	end
end

local function startActiveTreadmillVisualSimulation(p1, p2, p3) --[[ startActiveTreadmillVisualSimulation | Line: 223 | Upvalues: v5 (ref), SpeedPowerProjection (copy), v4 (ref), Workspace (copy), Save (copy), TreadmillUtil (copy), TreadmillCharacterPresentationController (copy), SpeedGainAnimation (copy), CurrentBoost (copy) ]]
	local v1 = v5

	if v1 ~= nil then
		SpeedPowerProjection.EndSession(v1.Token)
	end

	v4 = v4 + 1
	v5 = nil

	local v2 = Workspace:GetServerTimeNow()
	local v3 = Save.Get()

	assert(if v3 == nil then false else true, "Save data must be loaded before starting treadmill simulation")

	local v52 = v4

	v5 = {
		PendingScreenSpeedPowerDelta = 0,
		NextScreenPopupAt = v2 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL,
		NextSpeedAwardAt = p2,
		RarityColor = p3,
		SimulatedSpeedPower = TreadmillUtil.NormalizeSpeedPower(v3.SpeedPower),
		SpeedMultiplier = p1,
		Token = v52
	}
	SpeedPowerProjection.BeginSession(v52)
	task.spawn(function() --[[ Line: 245 | Upvalues: v5 (ref), v52 (copy), Workspace (ref), TreadmillUtil (ref), Save (ref), TreadmillCharacterPresentationController (ref), SpeedGainAnimation (ref), CurrentBoost (ref), SpeedPowerProjection (ref) ]]
		while true do
			local v1 = v5

			if v1 == nil or v1.Token ~= v52 then
				break
			end

			local v4 = math.max(v1.NextSpeedAwardAt - Workspace:GetServerTimeNow(), 0)

			if v4 > 0 then
				task.wait(v4)
			end

			local v53 = v5

			if v53 == nil or v53.Token ~= v52 then
				break
			end

			while true do
				local v6 = Workspace:GetServerTimeNow()

				if v6 < v53.NextSpeedAwardAt then
					break
				end

				local NextSpeedAwardAt = v53.NextSpeedAwardAt
				local v7 = TreadmillUtil.ResolveSpeedPowerPerStep(Save.Get(), v53.SpeedMultiplier, NextSpeedAwardAt)

				v53.SimulatedSpeedPower = v53.SimulatedSpeedPower + v7

				if TreadmillCharacterPresentationController.IsLocalCharacterFullyTransparent() then
					local v8 = v53

					v8.PendingScreenSpeedPowerDelta = v8.PendingScreenSpeedPowerDelta + v7

					if v8.NextScreenPopupAt <= v6 then
						if not (v8.PendingScreenSpeedPowerDelta <= 0) then
							local PendingScreenSpeedPowerDelta = v8.PendingScreenSpeedPowerDelta

							SpeedGainAnimation.Play(CurrentBoost, PendingScreenSpeedPowerDelta, nil, function() --[[ Line: 167 | Upvalues: SpeedPowerProjection (ref), v8 (copy), PendingScreenSpeedPowerDelta (copy) ]]
								SpeedPowerProjection.RevealCompletedGain(v8.Token, PendingScreenSpeedPowerDelta)
							end)
							v8.PendingScreenSpeedPowerDelta = 0
						end

						v8.NextScreenPopupAt = v6 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
					end
				else
					local v9 = v53

					v9.PendingScreenSpeedPowerDelta = 0
					v9.NextScreenPopupAt = v6 + TreadmillUtil.TREADMILL_SPEED_GAIN_INTERVAL
					SpeedGainAnimation.PlayWalk(CurrentBoost, v7, v9.RarityColor, function() --[[ Line: 196 | Upvalues: SpeedPowerProjection (ref), v9 (copy), v7 (copy) ]]
						SpeedPowerProjection.RevealCompletedGain(v9.Token, v7)
					end)
				end

				v53 = v5

				if v5 == nil or v5.Token ~= v52 then
					return
				end

				v5.NextSpeedAwardAt = NextSpeedAwardAt + TreadmillUtil.ResolveWalkSpeedPowerAwardInterval((TreadmillUtil.SpeedPowerToProgressionWalkSpeed(v5.SimulatedSpeedPower)))
			end
		end
	end)
end

EggCmds.AreaEggCarryStateChanged:Connect(function(p1) --[[ Line: 290 | Upvalues: v6 (ref), updateSpeedPower (copy) ]]
	v6 = p1.SpeedMultiplier
	updateSpeedPower()
end)

if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

SpeedGainAnimation.HideTemplate()
TreadmillVideoController.Stop()
TreadmillCharacterPresentationController.StopCameraTransparency()
updateSpeedPower()
count = count + 1

local v7 = count
local v9 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())
local v10

if v9 <= 0 then
	TemporarySpeedBoost.Visible = false
	v10 = false
else
	TemporarySpeedBoost.Visible = true
	CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v9)))
	v10 = true
end

if v10 then
	task.spawn(function() --[[ Line: 119 | Upvalues: v7 (copy), count (ref), Save (copy), TreadmillUtil (copy), Workspace (copy), TemporarySpeedBoost (copy), CurrentBoost2 (copy), FormatDurationSymbol (copy), updateSpeedPower (copy) ]]
		while v7 == count do
			local v12

			task.wait(1)

			local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())

			if v3 <= 0 then
				TemporarySpeedBoost.Visible = false
				v12 = false
			else
				TemporarySpeedBoost.Visible = true
				CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
				v12 = true
			end

			updateSpeedPower()
		end
	end)
end

SpeedPowerProjection.Changed:Connect(updateSpeedPower)
Players.LocalPlayer:GetAttributeChangedSignal("SpeedPower"):Connect(updateSpeedPower)
Players.LocalPlayer:GetAttributeChangedSignal("TrailSpeedMultiplier"):Connect(updateSpeedPower)
Save.ConnectForDataChanged("SpeedBoostTierIndex", updateSpeedPower)
Save.ConnectForDataChanged({ "EquippedTrail", "TrailInventory" }, updateSpeedPower)
Save.ConnectForDataChanged("TemporarySpeedBoostRemainingSeconds", function() --[[ Line: 308 | Upvalues: updateSpeedPower (copy), count (ref), Save (copy), TreadmillUtil (copy), Workspace (copy), TemporarySpeedBoost (copy), CurrentBoost2 (copy), FormatDurationSymbol (copy) ]]
	updateSpeedPower()
	count = count + 1

	local v1 = count
	local v2 = Save.Get()
	local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(v2, Workspace:GetServerTimeNow())
	local v4

	if v3 <= 0 then
		TemporarySpeedBoost.Visible = false
		v4 = false
	else
		TemporarySpeedBoost.Visible = true
		CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
		v4 = true
	end

	if v4 then
		task.spawn(function() --[[ Line: 119 | Upvalues: v1 (copy), count (ref), Save (ref), TreadmillUtil (ref), Workspace (ref), TemporarySpeedBoost (ref), CurrentBoost2 (ref), FormatDurationSymbol (ref), updateSpeedPower (ref) ]]
			while v1 == count do
				local v12

				task.wait(1)

				local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())

				if v3 <= 0 then
					TemporarySpeedBoost.Visible = false
					v12 = false
				else
					TemporarySpeedBoost.Visible = true
					CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
					v12 = true
				end

				updateSpeedPower()
			end
		end)
	end
end)
Save.ConnectForDataChanged("TemporarySpeedBoostActiveStartedAt", function() --[[ Line: 312 | Upvalues: updateSpeedPower (copy), count (ref), Save (copy), TreadmillUtil (copy), Workspace (copy), TemporarySpeedBoost (copy), CurrentBoost2 (copy), FormatDurationSymbol (copy) ]]
	updateSpeedPower()
	count = count + 1

	local v1 = count
	local v2 = Save.Get()
	local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(v2, Workspace:GetServerTimeNow())
	local v4

	if v3 <= 0 then
		TemporarySpeedBoost.Visible = false
		v4 = false
	else
		TemporarySpeedBoost.Visible = true
		CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
		v4 = true
	end

	if v4 then
		task.spawn(function() --[[ Line: 119 | Upvalues: v1 (copy), count (ref), Save (ref), TreadmillUtil (ref), Workspace (ref), TemporarySpeedBoost (ref), CurrentBoost2 (ref), FormatDurationSymbol (ref), updateSpeedPower (ref) ]]
			while v1 == count do
				local v12

				task.wait(1)

				local v3 = TreadmillUtil.ResolveTemporarySpeedBoostRemainingSeconds(Save.Get(), Workspace:GetServerTimeNow())

				if v3 <= 0 then
					TemporarySpeedBoost.Visible = false
					v12 = false
				else
					TemporarySpeedBoost.Visible = true
					CurrentBoost2.Text = ("X2 Speed (%*)"):format((FormatDurationSymbol(v3)))
					v12 = true
				end

				updateSpeedPower()
			end
		end)
	end
end)
Network.Fired(Treadmills3.SPEED_GAIN_EVENT):Connect(handleServerSpeedGain)
SettingsCmds.Changed:Connect(function(p1) --[[ Line: 319 | Upvalues: v3 (ref), SettingsCmds (copy), TreadmillVideoController (copy), Save (copy) ]]
	if p1 ~= "DisableVideos" then
		return
	end

	local v1 = v3

	if v1 == nil or SettingsCmds.IsEnabled("DisableVideos") then
		TreadmillVideoController.Stop()

		return
	end

	local v2 = Save.Get()

	assert(v2 ~= nil, "Save data must be loaded before enabling treadmill videos")
	TreadmillVideoController.Start(v1, v2.TreadmillMediaFeedState)
end)
Network.Fired(Constants.NETWORK_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(p1, p2, p3, p4) --[[ Line: 326 | Upvalues: v3 (ref), v2 (ref), v5 (ref), SpeedPowerProjection (copy), v4 (ref), updateSpeedPower (copy), TreadmillVideoController (copy), TreadmillCharacterPresentationController (copy), Visibility (copy), Treadmills (copy), startActiveTreadmillVisualSimulation (copy), applyTreadmillVideoSetting (copy) ]]
	v3 = p1
	v2 = false

	if p1 == nil then
		local v1 = v5

		if v1 ~= nil then
			SpeedPowerProjection.EndSession(v1.Token)
		end

		v4 = v4 + 1
		v5 = nil
		updateSpeedPower()
		TreadmillVideoController.Stop()
		TreadmillCharacterPresentationController.StopCameraTransparency()
		Visibility.Apply(false)
	else
		assert(if typeof(p2) == "number" then true else false, "Active treadmill speed multiplier must be a number")
		assert(if typeof(p3) == "number" then true else false, "Active treadmill next award time must be a number")
		assert(if typeof(p4) == "table" then true else false, "Active treadmill media feed state must be a table")

		local v52, v6 = Treadmills.Types.TreadmillNameExists(p1)

		assert(v52, if v6 then v6 else ("Treadmill \"%*\" does not exist"):format(p1))
		updateSpeedPower()
		Visibility.Apply(true)
		startActiveTreadmillVisualSimulation(p2, p3, Treadmills.Directory[p1].Rarity.Color)
		TreadmillCharacterPresentationController.StartCameraTransparency(p1)
		applyTreadmillVideoSetting(p4)
	end
end)
UserInputService.JumpRequest:Connect(function() --[[ Line: 358 | Upvalues: v3 (ref), v2 (ref), Network (copy), Treadmills3 (copy) ]]
	if v3 == nil or v2 then
		return
	end

	v2 = true

	if Network.Invoke(Treadmills3.REQUEST_UNEQUIP) == true then
		return
	end

	v2 = false
end)