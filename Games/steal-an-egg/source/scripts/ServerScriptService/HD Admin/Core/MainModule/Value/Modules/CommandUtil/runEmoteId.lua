--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Prompt = require(modules.Prompt)
local Task = require(modules.Objects.Task)
local EncodingService = game:GetService("EncodingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local getAnimator = require(modules.PlayerUtil.getAnimator)
local getHRP = require(modules.PlayerUtil.getHRP)
local bundleIdToAnimId: {[string]: number} = {}


-- LOCAL FUNCTIONS
local function setTorsoSoundSpeed(player: Player, speed: number)
	local hrp = getHRP(player)
	local torsoSound = hrp and hrp:FindFirstChild("HDTorsoSound")
	if torsoSound and torsoSound:IsA("Sound") then
		local difference = speed - 1
		local newSpeed = 1 + (difference/2)
		torsoSound.PlaybackSpeed = newSpeed or 1
	end
end

local function playAnimation(player: Player, animationId: number, customSpeed: number?, looped: boolean?): (AnimationTrack?, Animation?)
	local speed = customSpeed or 1
	local loadTrack = require(modules.PlayerUtil.loadTrack)
	local animTrack, animation = loadTrack(player, animationId)
	if not animTrack or not animation then
		return nil, nil
	end
	local weight = (looped and 98) or 99
	local isLooped = looped == true
	animTrack.Looped = isLooped
	animTrack.Priority = Enum.AnimationPriority.Core
	animTrack:Play(1, weight, speed)
	setTorsoSoundSpeed(player, speed)
	animation:SetAttribute("HDSpeed", speed)
	animation:GetAttributeChangedSignal("HDSpeed"):Connect(function()
		local newSpeed = animation:GetAttribute("HDSpeed")
		if typeof(newSpeed) == "number" then
			animTrack:AdjustSpeed(newSpeed)
			-- Re-pitch the torso sound to match slider-speed changes, etc
			setTorsoSoundSpeed(player, newSpeed)
		end
	end)
	local animator = getAnimator(player)
	if not isLooped and animator then
		local length
		for _ = 1, 200 do
			length = animTrack.Length
			if length and length > 0 then
				break
			end
			task.wait(0.02)
		end
		local fadeTime = 1
		if not length or length <= 0 then
			fadeTime = 0
		end
		local trackCount: any = animation:GetAttribute("TrackCount")
		if typeof(trackCount) ~= "number" then
			trackCount = 0
		end
		trackCount += 1
		animation:SetAttribute("TrackCount", trackCount)
		local function finishUp()
			if animation.Parent then
				animTrack:AdjustWeight(-1)
				animTrack.Priority = Enum.AnimationPriority.Core
				animTrack:Stop(fadeTime)
			end
			task.delay(fadeTime, function()
				local newCount: any = animation:GetAttribute("TrackCount") or 1
				newCount -= 1
				animation:SetAttribute("TrackCount", newCount)
				if newCount <= 0 then
					animation:Destroy()
				end
			end)
		end
		if fadeTime <= 0 then
			finishUp()
		else
			-- Watch the track's REMAINING real time, scaled by its live playback speed,
			-- instead of a fixed delay off the 1x length. a slowed emote (speed 0.5) takes
			-- twice as long, so a fixed delay would cut it off halfway
			local stopConnection
			stopConnection = RunService.Heartbeat:Connect(function()
				if not animation.Parent then
					stopConnection:Disconnect()
					return -- emote was stopped / cleaned up elsewhere so nothing to fade
				end
				local trackSpeed = animTrack.Speed
				if trackSpeed <= 0 then
					return -- paused, so don't count down while stationary
				end
				local remainingReal = (animTrack.Length - animTrack.TimePosition) / trackSpeed
				if not animTrack.IsPlaying or remainingReal <= fadeTime then
					stopConnection:Disconnect()
					finishUp()
				end
			end)
		end
	end
	local character = player.Character
	if character then
		animation.Parent = character
	end
	return animTrack, animation
end

local function getAnimIdFromEmoteIdAsync(emoteId: number): (boolean, number | string)
	local Emotes = require(modules.Parent.Services.Emotes)
	local emote = Emotes.getEmoteById(emoteId)
	local emoteAnimId = emote and emote.animationId
	if emoteAnimId then
		return true, emoteAnimId
	end
	local stringId = tostring(emoteId)
	local animId = bundleIdToAnimId[stringId]
	if animId then
		return true, animId
	end
	local success, model = pcall(function()
		local AssetService = game:GetService("AssetService")
		return AssetService:LoadAssetAsync(emoteId)
	end)
	if not success then
		return false, tostring(model)
	end
	local animation = success and model:FindFirstChildOfClass("Animation")
	if not animation then
		model:Destroy()
		return false, "No animation in asset"
	end
	local animationId = tonumber(animation.AnimationId:match("%d+"))
	if not animationId then
		model:Destroy()
		return false, "Invalid animation ID"
	end
	bundleIdToAnimId[stringId] = animationId
	animation:Destroy()
	return true, animationId
end

local function runEmoteId(task: Task.Class, emoteId: number, speed: number?, looped: boolean?)
	local success, animId = getAnimIdFromEmoteIdAsync(emoteId)
	if not success then
		Prompt.error(task.caller, `Failed to run emote ID {emoteId}: {animId}`)
		return
	end
	-- getAnimIdFromEmoteIdAsync yields, so a racing :end / :destroy may have already
	-- finished the task while we waited
	if not task.isActive then
		return
	end
	task:keep("UntilTargetRespawns")
	local target = task.target :: Player
	local animTrack, animation = playAnimation(target, animId :: number, speed, looped)
	-- Live references so the emote card's speed slider can retime without re-running
	task.extra.emoteAnimation = animation
	task.extra.emoteSpeed = speed or 1
	local janitor = task.janitor
	if not task.isActive or not janitor.add then
		if animTrack then
			animTrack:Stop()
			animTrack:Destroy()
		end
		if animation then
			animation:Destroy()
		end
		return
	end
	if animTrack then
		janitor:add(function()
			animTrack:Stop()
			animTrack:Destroy()
		end)
	end
	if animation then
		janitor:add(animation)
	end
	return true
end


return runEmoteId