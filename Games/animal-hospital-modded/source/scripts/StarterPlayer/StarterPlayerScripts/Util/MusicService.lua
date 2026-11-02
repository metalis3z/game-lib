local t = {}
local Lib = require(game.ReplicatedStorage.Lib)
local t2 = {}
local t3 = {}

t3.__index = t3

local v1 = nil

function t3.new(p1) --[[ new | Line: 13 | Upvalues: t3 (copy), t2 (copy) ]]
	local t = {
		Name = p1.Name,
		sound = p1,
		Sound = p1,
		Ended = p1.Ended,
		Volume = p1.Volume
	}

	setmetatable(t, t3)
	t2[p1.Name] = t

	local NumberValue = p1:FindFirstChildOfClass("NumberValue")

	t.limit = if NumberValue then NumberValue.Value else NumberValue
	t.duration = (t.limit or p1.TimeLength) / p1.PlaybackSpeed

	return t
end

local function _switch(p1, p2) --[[ _switch | Line: 31 | Upvalues: v1 (ref), Lib (copy) ]]
	if v1 then
		v1:FadeOut(p2)
		Lib.wait(0.1)
	end

	p1:FadeIn(p2)
	v1 = p1
end

function t.GetCurrent() --[[ GetCurrent | Line: 38 | Upvalues: v1 (ref) ]]
	return v1
end
function t.FadeOutCurrent() --[[ FadeOutCurrent | Line: 42 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:FadeOut()
end
function t3.Play(p1, p2, ...) --[[ Play | Line: 46 | Upvalues: Lib (copy), v1 (ref) ]]
	p1.sound:Play(...)

	if p1.limit then
		Lib.spawn(function() --[[ Line: 49 | Upvalues: p1 (copy), Lib (ref) ]]
			while p1.sound.TimePosition < p1.limit do
				Lib.wait(0.05)
			end

			p1.sound:Stop()
		end)
	end

	if p2 then
		v1 = p1
	end

	return p1.duration
end
function t3.PlayUnique(p1) --[[ PlayUnique | Line: 60 ]]
	task.spawn(function() --[[ Line: 61 | Upvalues: p1 (copy) ]]
		local v1 = p1.sound:Clone()

		v1.Parent = game.SoundService
		v1:Play()
		task.wait(v1.TimeLength)
		v1:Destroy()
	end)
end
function t3.PlayAtPosition(p1, p2, p3, ...) --[[ PlayAtPosition | Line: 70 ]]
	local Attachment = Instance.new("Attachment")

	Attachment.Parent = workspace.Terrain
	Attachment.WorldPosition = p2

	local v1 = p1.sound.Parent

	p1.sound.Parent = Attachment
	task.spawn(function() --[[ Line: 76 | Upvalues: p1 (copy), p3 (copy), v1 (copy), Attachment (copy) ]]
		task.wait(p1:Play(p3) + 0.1)
		p1.sound.Parent = v1
		Attachment:Destroy()
	end)
end
function t3.Stop(p1, p2) --[[ Stop | Line: 83 | Upvalues: v1 (ref) ]]
	p1.sound:Stop()

	if v1 ~= p1 or not p2 then
		return
	end

	v1 = nil
end
function t3.FadeIn(p1, p2) --[[ FadeIn | Line: 89 | Upvalues: Lib (copy) ]]
	local v1 = p2 or 2.5
	local Volume = p1.Volume

	p1.sound.Volume = 0
	p1:Play()

	if not p1.fadingIn then
		task.spawn(function() --[[ Line: 95 | Upvalues: p1 (copy), Lib (ref), v1 (ref), Volume (copy) ]]
			p1.fadingIn = true
			Lib.TS:Create(p1.sound, TweenInfo.new(v1), {
				Volume = Volume
			}):Play()
			task.wait(v1)
			p1.fadingIn = false
		end)
	end
end
function t3.FadeOut(p1, p2) --[[ FadeOut | Line: 103 | Upvalues: Lib (copy), v1 (ref) ]]
	local v12 = p2 or 2.5

	p1.fadingIn = false
	Lib.spawn(function() --[[ Line: 106 | Upvalues: Lib (ref), p1 (copy), v12 (ref) ]]
		Lib.TS:Create(p1.sound, TweenInfo.new(v12), {
			Volume = 0
		}):Play()
		task.wait(v12)

		if not (p1.sound.Volume > 0.01) then
			p1:Stop()
		end
	end)

	if v1 == p1 then
		v1 = nil
	end
end
function t3.Broadcast(p1, p2) --[[ Broadcast | Line: 115 | Upvalues: v1 (ref), Lib (copy) ]]
	if v1 then
		v1:FadeOut(p2)
		Lib.wait(0.1)
	end

	p1:FadeIn(p2)
	v1 = p1
end
function t.Get(p1, p2) --[[ Get | Line: 119 | Upvalues: t2 (copy), t3 (copy) ]]
	if t2[p1] or not p2 then
		return t2[p1]
	end

	return t3.new(game.SoundService:FindFirstChild(p2):FindFirstChild(p1))
end

for i, v in ipairs(game.SoundService.sfx:GetChildren()) do
	t3.new(v)
end

for i, v in ipairs(game.SoundService.music:GetChildren()) do
	t3.new(v)
end

game["Run Service"]:IsStudio()
Lib.Network:BindEvents({
	PlaySong = function(p1, p2) --[[ PlaySong | Line: 139 | Upvalues: t (copy) ]]
		local v1 = t.Get(p1)

		if not v1 then
			return
		end

		v1:Broadcast(p2)
	end,
	PlayAmbience = function(p1, p2) --[[ PlayAmbience | Line: 143 | Upvalues: t (copy) ]]
		local v1 = t.Get(p1)

		if not v1 then
			return
		end

		v1:FadeIn(p2)
	end,
	PlaySound = function(p1, ...) --[[ PlaySound | Line: 147 | Upvalues: t (copy) ]]
		local v1 = t.Get(p1)

		if not v1 then
			return
		end

		v1:Play(...)
	end,
	StopSong = function(p1, ...) --[[ StopSong | Line: 151 | Upvalues: t (copy) ]]
		local v1 = t.Get(p1)

		if not v1 then
			return
		end

		v1:FadeOut(...)
	end
})

return t