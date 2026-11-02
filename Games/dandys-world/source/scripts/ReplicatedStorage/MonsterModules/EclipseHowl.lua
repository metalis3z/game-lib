--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQNIB3JlcXVpcmUHTW9kdWxlcwVBdWRpbxFTb3VuZEdyb3VwTWFuYWdlcgxzZXRtZXRhdGFibGUJY2hhcmFjdGVyBmNvbmZpZxtyYnhhc3NldGlkOi8vNzMzNzc2OTI1MjMxMTYLSG93bFRleHR1cmULaG93bFRleHR1cmUbcmJ4YXNzZXRpZDovLzkxMzAzOTg0MjkxMzM1CUhvd2xTb3VuZAlob3dsU291bmQbcmJ4YXNzZXRpZDovLzc3MjAzNjI2NTE0MzU3DUhvd2xBbmltYXRpb24NaG93bEFuaW1hdGlvbgxIb3dsRHVyYXRpb24MaG93bER1cmF0aW9uEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQQaHVtYW5vaWRSb290UGFydARIZWFkBGhlYWQISHVtYW5vaWQIaHVtYW5vaWQOc2V0dXBIb3dsU291bmQSc2V0dXBIb3dsQW5pbWF0aW9uA25ldwtFY2xpcHNlSG93bAdEZXN0cm95CEluc3RhbmNlBVNvdW5kBE5hbWUHU291bmRJZAZWb2x1bWUFUGl0Y2gGUGFyZW50C0Fzc2lnblNvdW5kDE1vbnN0ZXJTdGF0ZQVzb3VuZAhBbmltYXRvchVGaW5kRmlyc3RDaGlsZE9mQ2xhc3MJQW5pbWF0aW9uC0FuaW1hdGlvbklkDUxvYWRBbmltYXRpb24JaG93bFRyYWNrBEVudW0RQW5pbWF0aW9uUHJpb3JpdHkGQWN0aW9uCFByaW9yaXR5BGZhY2UFRGVjYWwPb3JpZ2luYWxUZXh0dXJlB1RleHR1cmUOc2V0SG93bFRleHR1cmUOcmVzdG9yZVRleHR1cmUGRXZlbnRzDE1hY2hpbmVFdmVudARGaXJlDWFsZXJ0TW9uc3RlcnMEUGxheQRTdG9wBHRhc2sFZGVsYXkLcGVyZm9ybUhvd2wHY2xlYW51cARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2URQ29sbGVjdGlvblNlcnZpY2UFcGNhbGwHX19pbmRleAALAgACAAAADKQAAQAAAABA+wEBAE0BAegCAAAATQEB0gMAAABNAQHUBAAAAJ8AAgLeAAAAggABAAUDAQQAAABAAwIDAwMEAAkAARgAAAAAAAAAAAAAAAEKAAAAAAYCAQAAAEX/AwUA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

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("CollectionService")

local v1 = nil

pcall(function() --[[ Line: 9 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	v1 = require(ReplicatedStorage.Modules.Audio.SoundGroupManager)
end)

local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 22 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.character = p1
	v2.config = if p2 then p2 else {}
	v2.howlTexture = v2.config.HowlTexture or "rbxassetid://73377692523116"
	v2.howlSound = v2.config.HowlSound or "rbxassetid://91303984291335"
	v2.howlAnimation = v2.config.HowlAnimation or "rbxassetid://77203626514357"
	v2.howlDuration = v2.config.HowlDuration or 2.5
	v2.humanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
	v2.head = p1:FindFirstChild("Head")
	v2.humanoid = p1:FindFirstChild("Humanoid")
	v2:setupHowlSound()
	v2:setupHowlAnimation()

	return v2
end
function t.setupHowlSound(p1) --[[ setupHowlSound | Line: 47 | Upvalues: v1 (ref) ]]
	if not p1.humanoidRootPart then
		return
	end

	local EclipseHowl = p1.humanoidRootPart:FindFirstChild("EclipseHowl")

	if EclipseHowl then
		EclipseHowl:Destroy()
	end

	local EclipseHowl2 = Instance.new("Sound")

	EclipseHowl2.Name = "EclipseHowl"
	EclipseHowl2.SoundId = p1.howlSound
	EclipseHowl2.Volume = 0.7
	EclipseHowl2.Pitch = 1
	EclipseHowl2.Parent = p1.humanoidRootPart

	if v1 then
		v1.AssignSound(EclipseHowl2, "MonsterState")
	end

	p1.sound = EclipseHowl2
end
function t.setupHowlAnimation(p1) --[[ setupHowlAnimation | Line: 73 ]]
	if not p1.humanoid then
		return
	end

	local Animator = p1.humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = p1.humanoid
		Animator = Animator2
	end

	local Animation = Instance.new("Animation")

	Animation.AnimationId = p1.howlAnimation
	p1.howlTrack = Animator:LoadAnimation(Animation)
	p1.howlTrack.Priority = Enum.AnimationPriority.Action
end
function t.setHowlTexture(p1) --[[ setHowlTexture | Line: 93 ]]
	if not p1.head then
		return
	end

	local v1 = p1.head:FindFirstChild("face") or p1.head:FindFirstChildOfClass("Decal")

	if not v1 then
		return
	end

	if not p1.originalTexture then
		p1.originalTexture = v1.Texture
	end

	v1.Texture = p1.howlTexture
end
function t.restoreTexture(p1) --[[ restoreTexture | Line: 108 ]]
	if not (p1.head and p1.originalTexture) then
		return
	end

	local v1 = p1.head:FindFirstChild("face") or p1.head:FindFirstChildOfClass("Decal")

	if not v1 then
		return
	end

	v1.Texture = p1.originalTexture
end
function t.alertMonsters(p1, p2) --[[ alertMonsters | Line: 118 | Upvalues: ReplicatedStorage (copy) ]]
	local Events = ReplicatedStorage:FindFirstChild("Events")

	if not Events then
		return
	end

	local MachineEvent = Events:FindFirstChild("MachineEvent")

	if MachineEvent then
		MachineEvent:Fire(p2, nil)
	end
end
function t.performHowl(p1, p2) --[[ performHowl | Line: 132 ]]
	if p1.howlTrack then
		p1.howlTrack:Play()
	end

	if p1.sound then
		p1.sound:Stop()
		p1.sound:Play()
	end

	p1:setHowlTexture()
	p1:alertMonsters(p2)
	task.delay(p1.howlDuration, function() --[[ Line: 151 | Upvalues: p1 (copy) ]]
		if not (p1.character and p1.character.Parent) then
			return
		end

		p1:restoreTexture()
	end)
end
function t.cleanup(p1) --[[ cleanup | Line: 159 ]]
	if p1.sound then
		p1.sound:Destroy()
	end

	p1:restoreTexture()
end

return t