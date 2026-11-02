-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Library.Audio)
local Normal = require(ReplicatedStorage.Directory.Sounds.Languages.Alphabet._Index.Normal)
local t = {}

t.__index = t
t.__class = "TutorialMessageAnimator"
function t.new(p1, p2, p3, p4) --[[ new | Line: 39 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._textLabel = p1
	v2._animationId = 0
	v2._typingSoundId = p2 or "rbxassetid://91414159854126"
	v2._typingSoundsEnabled = if p4 == false then false else true
	v2._typingSpeed = p3 or 0.09
	v2._typingValue = nil
	v2._typingConnection = nil
	v2._typingTween = nil

	return v2
end
function t._playAlphabetSound(p1, p2, p3) --[[ _playAlphabetSound | Line: 61 | Upvalues: Normal (copy), Audio (copy), ReplicatedFirst (copy) ]]
	if p2 == " " then
		return
	end

	local v1 = Normal[string.lower(p2)]

	if v1 then
		Audio.ScheduleAndPlay(v1.Sound:Clone(), function() --[[ Line: 72 ]]
			return nil
		end, v1.Sound.Parent)
	else
		Audio.Play(p3, ReplicatedFirst)
	end
end
function t._getVisibleGraphemes(p1, p2) --[[ _getVisibleGraphemes | Line: 81 ]]
	local v1 = string.gsub(p2, "<.->", "")
	local t = {}

	for v2, v3 in utf8.graphemes(v1) do
		t[#t + 1] = string.sub(v1, v2, v3)
	end

	return t
end
function t.Stop(p1) --[[ Stop | Line: 95 ]]
	p1._animationId = p1._animationId + 1

	if p1._typingTween then
		p1._typingTween:Cancel()
		p1._typingTween = nil
	end

	if p1._typingConnection then
		p1._typingConnection:Disconnect()
		p1._typingConnection = nil
	end

	if p1._typingValue then
		p1._typingValue:Destroy()
		p1._typingValue = nil
	end

	p1._textLabel.MaxVisibleGraphemes = -1
end
function t.SetInstant(p1, p2, p3) --[[ SetInstant | Line: 116 ]]
	if p1._textLabel.Text == p2 and (p1._textLabel.TextColor3 == p3 and p1._textLabel.MaxVisibleGraphemes == -1) then
		return
	end

	p1:Stop()
	p1._textLabel.RichText = true
	p1._textLabel.Text = p2
	p1._textLabel.TextColor3 = p3
	p1._textLabel.MaxVisibleGraphemes = -1
end
function t.SetAnimated(p1, p2, p3) --[[ SetAnimated | Line: 132 | Upvalues: TweenService (copy) ]]
	if p1._textLabel.Text == p2 and p1._textLabel.TextColor3 == p3 then
		return
	end

	p1:Stop()
	p1._animationId = p1._animationId + 1

	local _animationId = p1._animationId

	p1._textLabel.RichText = true
	p1._textLabel.Text = p2
	p1._textLabel.TextColor3 = p3

	local v1 = p1:_getVisibleGraphemes(p2)
	local v2 = #v1

	if v2 <= 0 then
		p1._textLabel.MaxVisibleGraphemes = -1
	else
		p1._textLabel.MaxVisibleGraphemes = 0

		local v3 = Instance.new("NumberValue")

		v3.Value = 0
		p1._typingValue = v3

		local v4 = 0

		p1._typingConnection = v3:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 159 | Upvalues: _animationId (copy), p1 (copy), v3 (copy), v2 (copy), v4 (ref), v1 (copy) ]]
			if _animationId ~= p1._animationId then
				return
			end

			local v42 = math.clamp(math.floor(v3.Value + 0.5), 0, v2)

			if v42 == v4 then
				return
			end

			p1._textLabel.MaxVisibleGraphemes = v42

			if p1._typingSoundsEnabled then
				for i = v4 + 1, v42 do
					local v5 = v1[i]

					if v5 then
						p1:_playAlphabetSound(v5, p1._typingSoundId)
					end
				end
			end

			v4 = v42
		end)

		local v5 = TweenService:Create(v3, TweenInfo.new(v2 * p1._typingSpeed), {
			Value = v2
		})

		p1._typingTween = v5
		v5.Completed:Connect(function() --[[ Line: 187 | Upvalues: _animationId (copy), p1 (copy) ]]
			if _animationId ~= p1._animationId then
				return
			end

			p1._textLabel.MaxVisibleGraphemes = -1

			if p1._typingConnection then
				p1._typingConnection:Disconnect()
				p1._typingConnection = nil
			end

			if p1._typingValue then
				p1._typingValue:Destroy()
				p1._typingValue = nil
			end

			p1._typingTween = nil
		end)
		v5:Play()
	end
end
function t.Clear(p1) --[[ Clear | Line: 209 ]]
	p1:Stop()
	p1._textLabel.Text = ""
end

return t