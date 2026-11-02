-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:30
-- Luau version 6, Types version 3
-- Time taken: 0.005206 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "SoundController";
	_loadedSounds = {};
})
local var4_upvw
local SoundService_upvr = game:GetService("SoundService")
local Debris_upvr = game:GetService("Debris")
local TweenService_upvr = game:GetService("TweenService")
local var8_upvw
local var9_upvw
local SFX_upvr = SoundService_upvr.SFX
local Ambience_upvr = SFX_upvr.Ambience
local tbl_3_upvr = {"rbxassetid://73782583417578", "rbxassetid://80536481080698", "rbxassetid://116506322339418"}
function any_CreateController_result1.play(arg1, arg2, arg3) -- Line 41
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: SFX_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: SoundService_upvr (readonly)
		[5]: Debris_upvr (readonly)
	]]
	local var13 = arg3
	if not var13 then
		var13 = {}
	end
	local var14_upvw = var13
	local any_getData_result1 = var4_upvw:getData()
	if not any_getData_result1 then return end
	if not _G.dataLoaded then return end
	if any_getData_result1.settings.muteSounds and not var14_upvw.overrideMute then return end
	local tbl = {}
	tbl[1] = arg2
	arg1:preloadSounds(tbl)
	local SOME = SFX_upvr:FindFirstChild(arg2, true)
	if not SOME then
		var8_upvw.print(`Ljud '{arg2}' finns inte!`, warn)
		return
	end
	local clone_upvr = SOME:Clone()
	local parent = var14_upvw.parent
	if not parent then
		parent = SoundService_upvr.Playing
	end
	clone_upvr.Parent = parent
	clone_upvr.Name = var14_upvw.name or arg2
	local rollOffMode = var14_upvw.rollOffMode
	if not rollOffMode then
		rollOffMode = clone_upvr.RollOffMode
	end
	clone_upvr.RollOffMode = rollOffMode
	rollOffMode = var14_upvw.rollOffMinDistance
	local var21 = rollOffMode
	if not var21 then
		var21 = clone_upvr.RollOffMinDistance
	end
	clone_upvr.RollOffMinDistance = var21
	var21 = var14_upvw.rollOffMaxDistance
	local var22 = var21
	if not var22 then
		var22 = clone_upvr.RollOffMaxDistance
	end
	clone_upvr.RollOffMaxDistance = var22
	clone_upvr.Looped = var14_upvw.looped or false
	clone_upvr.PlaybackSpeed = var14_upvw.playbackSpeed or 1
	clone_upvr.TimePosition = var14_upvw.timePosition or 0
	local volume = var14_upvw.volume
	if not volume then
		volume = clone_upvr.Volume
	end
	clone_upvr.Volume = volume
	if var14_upvw.pitchShift then
		Instance.new("PitchShiftSoundEffect", clone_upvr).Octave = var14_upvw.pitchOctave or 1
	end
	if clone_upvr:IsDescendantOf(workspace) then
		clone_upvr:AddTag("soundInWorkspace")
		clone_upvr:SetAttribute("volume", clone_upvr.Volume)
	end
	task.spawn(function() -- Line 89
		--[[ Upvalues[3]:
			[1]: clone_upvr (readonly)
			[2]: var14_upvw (read and write)
			[3]: Debris_upvr (copied, readonly)
		]]
		clone_upvr:Play()
		if not var14_upvw.dontDestroy then
			if not clone_upvr.IsLoaded then
				clone_upvr.Loaded:Wait()
			end
			Debris_upvr:AddItem(clone_upvr, clone_upvr.TimeLength * (var14_upvw.playbackSpeed or 1) or 1)
		end
	end)
	return clone_upvr
end
local ContentProvider_upvr = game:GetService("ContentProvider")
function any_CreateController_result1.preloadSounds(arg1, arg2) -- Line 102
	--[[ Upvalues[3]:
		[1]: var9_upvw (read and write)
		[2]: SFX_upvr (readonly)
		[3]: ContentProvider_upvr (readonly)
	]]
	task.spawn(function() -- Line 103
		--[[ Upvalues[5]:
			[1]: arg2 (readonly)
			[2]: arg1 (readonly)
			[3]: var9_upvw (copied, read and write)
			[4]: SFX_upvr (copied, readonly)
			[5]: ContentProvider_upvr (copied, readonly)
		]]
		for _, v in arg2 do
			if arg1._loadedSounds[v] then return end
			if not var9_upvw[v] then return end
			arg1._loadedSounds[v] = true
			local Sound = Instance.new("Sound", SFX_upvr)
			Sound.SoundId = var9_upvw[v]
			Sound.Name = v
			ContentProvider_upvr:PreloadAsync({Sound}, function(arg1_2, arg2_2) -- Line 120
			end)
		end
	end)
end
function any_CreateController_result1.playAmbience(arg1, arg2) -- Line 127
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Ambience_upvr (readonly)
		[3]: TweenService_upvr (readonly)
	]]
	local any_getData_result1_2 = var4_upvw:getData()
	if not any_getData_result1_2 then
	else
		for i_4, v_4_upvr in Ambience_upvr:GetChildren() do
			TweenService_upvr:Create(v_4_upvr, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
				Volume = 0;
			}):Play()
			task.delay(1, function() -- Line 135
				--[[ Upvalues[1]:
					[1]: v_4_upvr (readonly)
				]]
				if v_4_upvr.Volume == 0 then
					v_4_upvr:Pause()
				end
			end)
		end
		if arg2 then
			local var42 = Ambience_upvr[arg2]
			var42:Resume()
			local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
			local targetVolume = any_getData_result1_2.settings.muteSounds and 0 or 0.02
			TweenService_upvr:Create(var42, tweenInfo, { Volume = targetVolume }):Play()
		end
	end
end
function any_CreateController_result1.createSoundHost(arg1, arg2, arg3) -- Line 151
	--[[ Upvalues[1]:
		[1]: Debris_upvr (readonly)
	]]
	local Part = Instance.new("Part", workspace)
	Part.Transparency = 1
	Part.Anchored = true
	Part.CanCollide = false
	Part.Name = "_soundHost"
	Part.Position = arg2
	Debris_upvr:AddItem(Part, arg3)
	return Part
end
local CollectionService_upvr = game:GetService("CollectionService")
function any_CreateController_result1.toggleSounds(arg1, arg2) -- Line 164
	--[[ Upvalues[2]:
		[1]: Ambience_upvr (readonly)
		[2]: CollectionService_upvr (readonly)
	]]
	local var58
	for _, v_2 in Ambience_upvr:GetChildren() do
		if arg2 then
			var58 = 0.02
		else
			var58 = 0
		end
		v_2.Volume = var58
	end
	for _, v_3 in CollectionService_upvr:GetTagged("soundInWorkspace") do
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var58 = v_3:GetAttribute("volume")
			return var58
		end
		if not arg2 or not INLINED() then
			var58 = 0
		end
		v_3.Volume = var58
	end
end
function any_CreateController_result1.toggleMusic(arg1, arg2, arg3) -- Line 174
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: SoundService_upvr (readonly)
		[3]: TweenService_upvr (readonly)
	]]
	local Music = SoundService_upvr.Music:FindFirstChild("Music")
	if not Music then
	else
		if not arg2 then
			TweenService_upvr:Create(Music, TweenInfo.new(0.5), {
				Volume = 0;
			}):Play()
			return
		end
		if var4_upvw:getData().settings.muteMusic and not arg3 then return end
		TweenService_upvr:Create(Music, TweenInfo.new(0.5), {
			Volume = 0.3;
		}):Play()
	end
end
function any_CreateController_result1.music(arg1) -- Line 194
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: tbl_3_upvr (readonly)
		[3]: SoundService_upvr (readonly)
	]]
	local Sound_upvr = Instance.new("Sound")
	Sound_upvr.Parent = SoundService_upvr.Music
	Sound_upvr.Name = "Music"
	Sound_upvr.Volume = 0.3
	if var4_upvw.data.settings.muteMusic then
		Sound_upvr.Volume = 0
	end
	local randint_upvw = math.random(1, #tbl_3_upvr)
	task.spawn(function() -- Line 207
		--[[ Upvalues[3]:
			[1]: Sound_upvr (readonly)
			[2]: tbl_3_upvr (copied, readonly)
			[3]: randint_upvw (read and write)
		]]
		repeat
			task.wait()
		until _G.introFinished
		while true do
			Sound_upvr.SoundId = tbl_3_upvr[randint_upvw]
			Sound_upvr:Play()
			task.wait(1)
			task.wait(Sound_upvr.TimeLength or 5)
			if randint_upvw == #tbl_3_upvr then
				randint_upvw = 1
			else
				randint_upvw += 1
			end
		end
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 223
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	task.spawn(function() -- Line 224
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		var4_upvw:waitForData()
		arg1:music()
		arg1:preloadSounds({"Trade Request"})
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_CreateController_result1.KnitInit(arg1) -- Line 234
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var8_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: var9_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(script.SoundIds)
end
return any_CreateController_result1