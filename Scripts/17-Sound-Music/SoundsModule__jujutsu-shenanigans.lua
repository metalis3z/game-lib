-- Reference copy for study. Game: Jujutsu Shenanigans (jujutsu-shenanigans)
-- Original: ServerStorage/Modules/SoundsModule.luau  (luau, 51 lines)
-- Categories: sound-music 13.0
-- What it does: Tiny helper: clone a Sound, put it on a part or at a world position (via a Terrain attachment), route it to a SoundGroup, set speed and start time, optionally fade it out after a delay, and auto-clean with Debris.

local Debris = game.Debris
local module = {}

local getCF = {
	['CFrame'] = function(Value)
		return Value.Position
	end,
	
	['Vector3'] = function(Value)
		return Value
	end,
}

function module:PlaySound(Sound: Sound, Part: Part, PlaybackSpeed: number, Modifier: number, FadeOutParams: { any }, TimePosition: number)
	local partType = typeof(Part)
	local ParentPart
	local soundLifetime = Sound.TimeLength + (Modifier or 1)
	
	Sound = Sound:Clone()
	Sound.SoundGroup = game.SoundService.Sounds
	if partType == 'CFrame' or partType == 'Vector3' then
		local soundAttachment = Instance.new('Attachment')
		soundAttachment.Parent = workspace.Terrain
		soundAttachment.WorldPosition = getCF[partType](Part)
		Debris:AddItem(Sound, soundLifetime)
		
		ParentPart = soundAttachment
	else
		ParentPart = Part
	end
	Sound.Parent = ParentPart
	Sound.PlaybackSpeed = PlaybackSpeed or 1
	Sound.TimePosition = TimePosition or 0
	Sound:Play()
	if Sound.Looped == false then
		Debris:AddItem(Sound, soundLifetime)
		
		task.spawn(function()
			if FadeOutParams then
				task.delay(FadeOutParams.DelayTime, function()
					game.TweenService:Create(Sound, FadeOutParams.TweenInfo, { Volume = 0; }):Play()
				end)
			end
		end)
	end
	
	return Sound
end

return module
