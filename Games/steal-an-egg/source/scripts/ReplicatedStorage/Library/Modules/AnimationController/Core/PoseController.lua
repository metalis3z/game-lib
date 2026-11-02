-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Utility = script.Parent.Parent.Utility

require(script.Parent.Parent.Types)

local SimpleSignal = require(Utility.SimpleSignal)

require(Utility.Preload)

local Switch = require(Utility.Switch)
local RandomWeighted = require(Utility.RandomWeighted)

local function isAction(p1) --[[ isAction | Line: 13 ]]
	return p1.Priority.Name:find("Action") ~= nil
end

local t = {}
local t2 = {
	__index = t
}

function t.SetCoreActive(p1, p2) --[[ SetCoreActive | Line: 26 ]]
	p1._active = p2
end
function t.GetCoreActive(p1) --[[ GetCoreActive | Line: 34 ]]
	return p1._active
end
function t.GetCurrentTrack(p1) --[[ GetCurrentTrack | Line: 42 ]]
	return p1._track
end
function t.GetPose(p1) --[[ GetPose | Line: 50 ]]
	return p1._lastPose
end
function t.SetPoseEnabled(p1, p2, p3) --[[ SetPoseEnabled | Line: 59 ]]
	p1._disabled[p2] = not p3
end
function t.GetCoreAnimInfos(p1, p2) --[[ GetCoreAnimInfos | Line: 68 ]]
	return p1._anims[p2]
end
function t.ChangeCoreAnim(p1, p2, p3, p4) --[[ ChangeCoreAnim | Line: 82 ]]
	local v1 = nil

	if type(p4) == "table" then
		p1._anims[p2][p3] = p4
	elseif type(p4) == "string" then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = p4

		local core = p1._animator:LoadAnimation(Animation)

		core.Name = "core"
		core.Looped = true
		core.Priority = Enum.AnimationPriority.Core
		p1._anims[p2][p3].anim = core
		v1 = core
	elseif typeof(p4) == "Instance" and p4:IsA("Animation") then
		local core = p1._animator:LoadAnimation(p4)

		core.Name = "core"
		core.Looped = true
		core.Priority = Enum.AnimationPriority.Core
		p1._anims[p2][p3].anim = core
		v1 = core
	elseif typeof(p4) == "Instance" and p4:IsA("AnimationTrack") then
		p1._anims[p2][p3].anim = p4
		v1 = p4
	else
		error((("Invalid value for :ChangeCoreAnim (%*)"):format(p4)))
	end

	if p1._lastPose ~= p2 then
		return v1
	end

	p1._track:Stop()
	p1:PlayAnimation(p2)

	return v1
end
function t.GetRandomCoreAnim(p1, p2) --[[ GetRandomCoreAnim | Line: 131 | Upvalues: RandomWeighted (copy) ]]
	return RandomWeighted(p1._anims[p2])
end
function t.StopCore(p1, p2) --[[ StopCore | Line: 140 ]]
	if not p1._animator then
		return
	end

	for v1, v2 in p1._animator:GetPlayingAnimationTracks() do
		if not (if v2.Priority.Name:find("Action") == nil then false else true) or v2.Name == "emote" then
			v2:Stop(p2)
		end
	end
end
function t.PlayAnimation(p1, p2, p3, p4) --[[ PlayAnimation | Line: 159 ]]
	if not p1._animator then
		return
	end

	local v1 = p3 or 1
	local v2, v3, v4 = p1:GetRandomCoreAnim(p2)

	p1:StopCore(p1._lastInfo.stopFadeTime or 0.1)
	v2:Play(v4.fadeTime or 0.1, 1, v4.speed or v1)
	p1._track = v2

	if not (v3 > 1) then
		return v4
	end

	v2.DidLoop:Once(function() --[[ Line: 176 | Upvalues: p1 (copy), p2 (copy), v1 (ref) ]]
		if not p1._active or p1._lastPose ~= p2 then
			return
		end

		p1:PlayAnimation(p2, v1)
	end)

	return v4
end
function t.Destroy(p1) --[[ Destroy | Line: 188 ]]
	p1:StopCore()
	p1.PoseChanged:Destroy()
	p1._active = false
	setmetatable(p1, nil)
	table.clear(p1)
end
function t.ChangePose(p1, p2, p3, p4) --[[ ChangePose | Line: 205 ]]
	if p1._disabled[p2] then
		return
	end

	if p4 and not p1._active then
		return
	end

	p1._switch:Switch(p2, p3 or 1)
end

return {
	new = function(p1, p2) --[[ new | Line: 229 | Upvalues: SimpleSignal (copy), t2 (copy), Switch (copy) ]]
		local v1 = p1:FindFirstChildWhichIsA("Animator", true)

		if not v1 then
			error((("Animator not found for rig %*"):format(p1)))
		end

		local v3 = setmetatable({
			_active = true,
			_lastPose = "",
			_track = false,
			_animator = v1,
			_anims = p2,
			_rig = p1,
			_lastInfo = {},
			_disabled = {},
			PoseChanged = SimpleSignal.new()
		}, t2)

		v3._switch = Switch.new("", function(p1, p2) --[[ Line: 250 | Upvalues: v3 (copy) ]]
			local v1 = v3:PlayAnimation(p1, p2)

			v3.PoseChanged:Fire(v3._lastPose, p1, v3._track)
			v3._lastPose = p1
			v3._lastInfo = v1
		end)
		v3:ChangePose("Idle")

		return v3
	end
}