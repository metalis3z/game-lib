--[[
	This script creates sounds which are placed under the character head.
	These sounds are used by the "LocalSound" script.
]]--
--humanoidSoundNewLocal.rbxmx--

function CreateNewSound(name, id, looped, pitch)
	local sound = Instance.new("Sound")
	sound.SoundId = id
	sound.Name = name
	sound.archivable = false
	sound.Parent = script.Parent.Head
	sound.Pitch = pitch
	sound.Looped = looped	
	
	return sound
end

CreateNewSound("GettingUp", 	"rbxasset://sounds/action_get_up.mp3",					false, 	1)
CreateNewSound("Died", 		"rbxasset://sounds/uuhhh.mp3",								false, 	1) 
CreateNewSound("FreeFalling", 	"rbxasset://sounds/action_falling.mp3",					true,	1)
CreateNewSound("Jumping", 		"rbxasset://sounds/action_jump.mp3",					false,	1)
CreateNewSound("Landing", 		"rbxasset://sounds/action_jump_land.mp3",				false,	1)
CreateNewSound("Splash", 		"rbxasset://sounds/impact_water.mp3",					false, 	1)
CreateNewSound("Running", 		"rbxasset://sounds/action_footsteps_plastic.mp3",		true, 	1.85)
CreateNewSound("Swimming", 	"rbxasset://sounds/action_swim.mp3",						true,	1.6)
CreateNewSound("Climbing", 	"rbxasset://sounds/action_footsteps_plastic.mp3",			true,	1)

