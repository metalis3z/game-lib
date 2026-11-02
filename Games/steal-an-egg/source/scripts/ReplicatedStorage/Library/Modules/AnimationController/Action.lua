-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Utility = script.Parent.Utility

require(script.Parent.Types)

local Preload = require(Utility.Preload)
local RandomWeighted = require(Utility.RandomWeighted)
local t = {}

local function resume(p1, p2) --[[ resume | Line: 9 | Upvalues: t (copy) ]]
	p2:Stop()

	for v1, v2 in t do
		v2:Disconnect()
	end

	local _controller = p1._controller

	if not _controller:GetCoreActive() then
		_controller:SetCoreActive(true)
		_controller:PlayAnimation("Idle")
	end
end

local function setupAnimEndTrigger(p1, p2) --[[ setupAnimEndTrigger | Line: 25 | Upvalues: t (copy), resume (copy) ]]
	local function f2() --[[ Line: 29 | Upvalues: resume (ref), p1 (copy), p2 (copy) ]]
		resume(p1, p2)
	end

	table.insert(t, p2.Stopped:Once(f2))

	local function f4() --[[ Line: 35 | Upvalues: resume (ref), p1 (copy), p2 (copy) ]]
		resume(p1, p2)
	end

	table.insert(t, p1._humanoid.StateChanged:Once(f4))

	local function f6() --[[ Line: 41 | Upvalues: resume (ref), p1 (copy), p2 (copy) ]]
		resume(p1, p2)
	end

	table.insert(t, p1._humanoid.Running:Once(f6))
end

local function v1(p1) --[[ deepCopy | Line: 47 | Upvalues: v1 (copy) ]]
	local t = {}

	for v12, v2 in p1 do
		if type(v2) == "table" then
			t[v12] = v1(v2)

			continue
		end

		t[v12] = v2
	end

	return t
end

local t2 = {}
local t3 = {
	__index = t2
}

function t2.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 74 | Upvalues: Preload (copy) ]]
	if p4 == nil then
		p4 = true
	end

	local v2 = p4 and Preload.preloadAnimArray(p1._animator, p3, p2, if p5 then p5 else Enum.AnimationPriority.Action) or p3

	p1._actions[p2] = v2

	return v2
end
function t2.BulkCreate(p1, p2, p3, p4) --[[ BulkCreate | Line: 99 ]]
	local t = {}

	for v1, v2 in p2 do
		table.insert(t, p1:Create(v1, v2, p3, p4))
	end

	return t
end
function t2.Remove(p1, p2) --[[ Remove | Line: 117 ]]
	local v1 = p1._actions[p2]

	if not v1 then
		warn((("Action %* has not been created yet. (:Remove)"):format(p2)))

		return
	end

	for v2, v3 in v1 do
		v3.anim:Stop()
		v3.anim:Destroy()
	end

	p1._actions[p2] = nil
end
function t2.StopAll(p1, p2) --[[ StopAll | Line: 139 ]]
	local v1 = p1._actions[p2]

	if not v1 then
		warn((("Action %* has not been created yet. (:StopAll)"):format(p2)))

		return
	end

	for i = 1, #v1 do
		v1[i].anim:Stop()
	end
end
function t2.GetAction(p1, p2) --[[ GetAction | Line: 161 ]]
	return p1._actions[p2]
end
function t2.GetRandomActionAnim(p1, p2) --[[ GetRandomActionAnim | Line: 172 | Upvalues: RandomWeighted (copy) ]]
	local v1 = p1._actions[p2]

	if v1 then
		return RandomWeighted(v1)
	end

	warn((("Action %* has not been created yet. (:GetRandomActionAnim)"):format(p2)))
end
function t2.SetEmoteBindable(p1, p2) --[[ SetEmoteBindable | Line: 191 | Upvalues: t (copy), RandomWeighted (copy), setupAnimEndTrigger (copy) ]]
	function p2.OnInvoke(p12) --[[ OnInvoke | Line: 192 | Upvalues: t (ref), p1 (copy), RandomWeighted (ref), setupAnimEndTrigger (ref) ]]
		for v1, v2 in t do
			v2:Disconnect()
		end

		local _controller = p1._controller

		if _controller:GetPose() ~= "Idle" then
			return false
		end

		_controller:SetCoreActive(false)

		local v3 = typeof(p12) == "Instance" and p12.Name or p12

		if p1._emotes[v3] ~= nil then
			local v4, _, v5 = RandomWeighted(p1._emotes[v3])

			_controller:StopCore(v5.fadeTime or 0.1)
			v4:Play(0.1, 1, v5.speed or 1)
			setupAnimEndTrigger(p1, v4)

			return true, v4
		end

		if typeof(p12) == "Instance" and p12:IsA("Animation") then
			_controller:StopCore()

			local v6 = p1._animator:LoadAnimation(p12)

			v6.Looped = false
			v6.Priority = Enum.AnimationPriority.Action2
			v6:Play(0.1, 1, 1)
			setupAnimEndTrigger(p1, v6)
			p1._emotes[p12.Name] = {
				weight = 10,
				id = p12.AnimationId,
				anim = v6
			}

			return true, v6
		end

		return false
	end
end
function t2.Destroy(p1) --[[ Destroy | Line: 242 ]]
	for v1, v2 in p1._actions do
		v2:Destroy()
	end

	setmetatable(p1, nil)
	table.clear(p1)
end

return {
	new = function(p1, p2, p3, p4) --[[ new | Line: 263 | Upvalues: t3 (copy) ]]
		local v1 = p2:FindFirstChildWhichIsA("Animator", true)

		if not v1 then
			error((("Animator not found for rig %*"):format(p2)))
		end

		local v2 = if p4 then p4 else p2:FindFirstChildWhichIsA("Humanoid", true)

		if v2 then
			local v3

			v3 = t3

			return setmetatable({
				_controller = p1,
				_animator = v1,
				_humanoid = v2,
				_emotes = p3,
				_actions = {}
			}, t3)
		end

		error((("Humanoid not found for rig %*"):format(p2)))
	end
}