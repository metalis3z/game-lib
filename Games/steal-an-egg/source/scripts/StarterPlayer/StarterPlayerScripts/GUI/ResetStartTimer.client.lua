-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Library.Audio)
local AreaEggResetCycle = require(ReplicatedStorage.Directory.AreaEggResetCycle)

require(ReplicatedStorage.Library.Types.AreaEggResetCycle)

local AreaEggResetTimeUtil = require(ReplicatedStorage.Library.Util.AreaEggResetTimeUtil)
local ChatMsg = require(ReplicatedStorage.Library.Client.ChatMsg)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local NotificationCmds = require(ReplicatedStorage.Library.Client.NotificationCmds)
local AreaEggResetWall = require(ReplicatedStorage.Library.Client.AreaEggResetWall)
local PreloadSounds = require(ReplicatedStorage.Library.Functions.PreloadSounds)
local v1 = TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local TeleportFadeHoldSeconds = AreaEggResetCycle.TeleportFadeHoldSeconds
local v2 = TweenInfo.new(AreaEggResetCycle.TeleportFadeSeconds, Enum.EasingStyle.Linear)
local v3 = TweenInfo.new(AreaEggResetCycle.SleepIconFadeSeconds, Enum.EasingStyle.Quad)
local v4 = TweenInfo.new(AreaEggResetCycle.NightIconFadeOutSeconds, Enum.EasingStyle.Quad)
local v5 = Log.new()
local v6 = GUI.FadeFrame()
local v7 = GUI.ResetStartTimer()
local TextLabel = v7.Frame.TextLabel
local NightTimer = v7.Frame.NightTimer
local UIStroke = NightTimer.UIStroke
local SleepIcon = v7.Frame.SleepIcon
local v8 = GUI.ResetStartTimerLabelScale()
local count = 0
local v9 = nil
local v10 = 0
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = nil
local v17 = (-1 / 0)

v7.Adornee = AreaEggResetWall.GetVisualWallPart()
task.spawn(PreloadSounds, 117751546358455, 136029417452204)

local function stopActiveTween() --[[ stopActiveTween | Line: 75 | Upvalues: v9 (ref) ]]
	if v9 == nil then
		return
	end

	v9:Cancel()
	v9 = nil
end

local function stopActiveFadeTween() --[[ stopActiveFadeTween | Line: 82 | Upvalues: v11 (ref) ]]
	if v11 == nil then
		return
	end

	v11:Cancel()
	v11 = nil
end

local function stopActiveNightVisualTweens() --[[ stopActiveNightVisualTweens | Line: 89 | Upvalues: v12 (ref), v13 (ref), v14 (ref) ]]
	if v12 ~= nil then
		v12:Cancel()
		v12 = nil
	end

	if v13 ~= nil then
		v13:Cancel()
		v13 = nil
	end

	if v14 == nil then
		return
	end

	v14:Cancel()
	v14 = nil
end

local function tweenFadeFrame(p1, p2) --[[ tweenFadeFrame | Line: 104 | Upvalues: v11 (ref), TweenService (copy), v6 (copy), v2 (copy), v10 (ref) ]]
	if v11 ~= nil then
		v11:Cancel()
		v11 = nil
	end

	local v1 = TweenService:Create(v6, v2, {
		BackgroundTransparency = p2
	})

	v11 = v1
	v1:Play()
	v1.Completed:Wait()

	if p1 == v10 then
		v11 = nil

		return true
	end

	return false
end

local function runTeleportFade(p1) --[[ runTeleportFade | Line: 119 | Upvalues: tweenFadeFrame (copy), TeleportFadeHoldSeconds (copy), v10 (ref) ]]
	if not tweenFadeFrame(p1, 0) then
		return
	end

	task.wait(TeleportFadeHoldSeconds)

	if p1 == v10 then
		tweenFadeFrame(p1, 1)
	end
end

local function setCountdownVisible(p1) --[[ setCountdownVisible | Line: 130 | Upvalues: TextLabel (copy) ]]
	TextLabel.Visible = p1
end

local function tweenNightVisuals(p1, p2) --[[ tweenNightVisuals | Line: 134 | Upvalues: v12 (ref), v13 (ref), v14 (ref), v4 (copy), v3 (copy), TweenService (copy), SleepIcon (copy), NightTimer (copy), UIStroke (copy), count (ref) ]]
	if v12 ~= nil then
		v12:Cancel()
		v12 = nil
	end

	if v13 ~= nil then
		v13:Cancel()
		v13 = nil
	end

	if v14 ~= nil then
		v14:Cancel()
		v14 = nil
	end

	local v1 = if p2 == 1 then v4 else v3
	local v2 = TweenService:Create(SleepIcon, v1, {
		ImageTransparency = p2
	})
	local v32 = TweenService:Create(NightTimer, v1, {
		TextTransparency = p2
	})
	local v42 = TweenService:Create(UIStroke, v1, {
		Transparency = p2
	})

	v12 = v2
	v13 = v32
	v14 = v42
	v2:Play()
	v32:Play()
	v42:Play()
	v2.Completed:Wait()

	if p1 == count then
		v12 = nil
		v13 = nil
		v14 = nil

		return true
	end

	return false
end

local function animateCount(p1) --[[ animateCount | Line: 162 | Upvalues: v9 (ref), TextLabel (copy), v8 (copy), TweenService (copy), v1 (copy) ]]
	local v12

	if v9 == nil then
		TextLabel.Text = tostring(p1)
		v8.Scale = 1.3
		v12 = TweenService:Create(v8, v1, {
			Scale = 1
		})
		v9 = v12
		v12:Play()

		return
	end

	v9:Cancel()
	v9 = nil
	TextLabel.Text = tostring(p1)
	v8.Scale = 1.3
	v12 = TweenService:Create(v8, v1, {
		Scale = 1
	})
	v9 = v12
	v12:Play()
end

local function announceRareSpawns(p1) --[[ announceRareSpawns | Line: 173 | Upvalues: ChatMsg (copy), NotificationCmds (copy), EggCmds (copy) ]]
	for i, v in ipairs(p1) do
		ChatMsg.New(v.Message, nil, nil, nil, true, nil)
		NotificationCmds.Message.Top({
			Time = 4,
			Message = v.Message,
			Color = Color3.new(255/255, 255/255, 255/255),
			Sound = v.SoundId
		})
	end

	EggCmds.AreaEggRareSpawnsPresented:Fire(p1)
end

local function v18(p1) --[[ requestJoinRareSpawnPresentations | Line: 186 | Upvalues: EggCmds (copy), announceRareSpawns (copy), v5 (copy), v18 (copy) ]]
	local v1, v2 = EggCmds.RequestAreaEggRareSpawnPresentations()

	if v1 then
		announceRareSpawns((assert(v2, "Ready rare spawn response must include presentations")))

		return
	end

	if p1 >= 30 then
		v5:AtError():Log("Area egg rare spawn join presentation request exhausted profile-readiness retries")
	else
		task.delay(1, function() --[[ Line: 197 | Upvalues: v18 (ref), p1 (copy) ]]
			v18(p1 + 1)
		end)
	end
end

local function runCountdown(p1, p2) --[[ runCountdown | Line: 202 | Upvalues: AreaEggResetWall (copy), v7 (copy), TextLabel (copy), NightTimer (copy), Workspace (copy), tweenNightVisuals (copy), count (ref), AreaEggResetCycle (copy), NotificationCmds (copy), v16 (ref), announceRareSpawns (copy), Audio (copy), animateCount (copy), v9 (ref), v8 (copy), v17 (ref), v15 (ref) ]]
	AreaEggResetWall.PrepareReveal()
	v7.Enabled = true
	TextLabel.Visible = false
	task.spawn(AreaEggResetWall.Reveal)
	NightTimer.Text = ("%*s"):format((math.max(math.ceil(p2.DayStartsAt - Workspace:GetServerTimeNow()), 1)))

	if not tweenNightVisuals(p1, 0) then
		return
	end

	repeat
		local v4 = Workspace:GetServerTimeNow()
		local v5 = p2.DayStartsAt - v4

		if v5 <= 0 then
			AreaEggResetWall.SetCollisionEnabled(false)
			if tweenNightVisuals(p1, 1) then
				task.wait((math.max(p2.DayStartsAt + AreaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds - Workspace:GetServerTimeNow(), 0)))

				if p1 == count then
					NotificationCmds.Message.Top({
						Message = "ALL EGG RESET!",
						Time = 3.5
					})
					announceRareSpawns(assert(v16, "Active reset sequence payload must exist when day countdown starts").RareSpawns)

					local v10 = AreaEggResetWall.GetVisualWall()
					local v11 = v10.Position + v10.CFrame.LookVector * (v10.Size.Z / 2)

					for i = AreaEggResetCycle.WallCountdownSeconds, 1, -1 do
						if p1 ~= count then
							return
						end

						Audio.Play(117751546358455, v11, 1, 2, 220)
						animateCount(i)

						if i == AreaEggResetCycle.WallCountdownSeconds then
							TextLabel.Visible = true
						end

						task.wait(1)
					end

					if p1 == count then
						if v9 ~= nil then
							v9:Cancel()
							v9 = nil
						end

						v8.Scale = 1
						Audio.Play(136029417452204, v11, 1, 1.5, 220)
						TextLabel.Visible = false
						AreaEggResetWall.Collapse()

						if p1 == count then
							v7.Enabled = false
							v17 = p2.DayStartsAt
							v15 = nil
							v16 = nil
						else
							break
						end
					end

					return
				end

				break
			end

			break
		end

		local v12 = math.ceil(v5)

		NightTimer.Text = ("%*s"):format(v12)
		task.wait((math.max(p2.DayStartsAt - (v12 - 1) - v4, 0.05)))
	until p1 ~= count
end

local function startSequence(p1) --[[ startSequence | Line: 271 | Upvalues: v17 (ref), v15 (ref), v16 (ref), count (ref), runCountdown (copy) ]]
	if p1.DayStartsAt <= v17 then
		return
	end

	local v1 = v15

	if v1 ~= nil and p1.DayStartsAt < v1 then
		return
	end

	if p1.DayStartsAt == v1 then
		v16 = p1
	else
		v15 = p1.DayStartsAt
		v16 = p1
		count = count + 1
		task.spawn(runCountdown, count, p1)
	end
end

v5:AtDebug():Log("Reset start timer controller initialized")
v7.Enabled = false
TextLabel.Visible = false
SleepIcon.ImageTransparency = 1
NightTimer.TextTransparency = 1
UIStroke.Transparency = 1
AreaEggResetWall.Reset()
EggCmds.AreaEggResetTeleportFade:Connect(function() --[[ Line: 303 | Upvalues: v10 (ref), runTeleportFade (copy) ]]
	v10 = v10 + 1
	task.spawn(runTeleportFade, v10)
end)
EggCmds.AreaEggResetStartCountdown:Connect(startSequence)
task.spawn(v18, 1)

if not AreaEggResetTimeUtil.IsNight(Workspace:GetServerTimeNow()) then
	return
end

local t = {
	DayStartsAt = AreaEggResetTimeUtil.GetNextResetAt(Workspace:GetServerTimeNow()),
	RareSpawns = {}
}

if t.DayStartsAt <= v17 then
	return
end

local v19 = v15

if v19 ~= nil and t.DayStartsAt < v19 then
	return
end

if t.DayStartsAt == v19 then
	v16 = t
else
	v15 = t.DayStartsAt
	v16 = t
	count = count + 1
	task.spawn(runCountdown, count, t)
end