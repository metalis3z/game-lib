-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Core = require(script.Core)
local Action = require(script.Action)
local DefaultAnims = require(script.DefaultAnims)

require(script.Types)

local Preload = require(script.Utility.Preload)
local LoadPackage = require(script.Utility.LoadPackage)
local LoadAnimPackage = script.Async.LoadAnimPackage
local LoadEmotePackage = script.Async.LoadEmotePackage
local t = {}
local t2 = {}

local function v1(p1) --[[ deepCopy | Line: 19 | Upvalues: v1 (copy) ]]
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

local t3 = {}
local t4 = {
	__index = t3
}

function t3.Destroy(p1) --[[ Destroy | Line: 42 | Upvalues: t (copy) ]]
	p1.Action:Destroy()
	p1.Core:Destroy()
	p1._destroying:Disconnect()
	t[p1._rig] = nil
	setmetatable(p1, nil)
	table.clear(p1)
end

return {
	new = function(p1, p2, p3, p4, p5) --[[ new | Line: 70 | Upvalues: v1 (copy), DefaultAnims (copy), Preload (copy), Core (copy), Action (copy), t4 (copy), t (copy), t2 (copy) ]]
		local v12 = if p2 == nil then true else p2
		local v2 = p1:FindFirstChildWhichIsA("Animator", true)

		if not v2 then
			error((("Animator not found for rig %*"):format(p1)))
		end

		local v4

		if p3 == nil then
			v4 = v1(DefaultAnims.R15.Animations)
		else
			v4 = v1(p3)

			if not v4 then
				v4 = v1(DefaultAnims.R15.Animations)
			end
		end

		local v5 = if p4 == nil then v1(DefaultAnims.R15.Emotes) else v1(p4) or v1(DefaultAnims.R15.Emotes)
		local v6 = v4
		local v7, v8

		if v12 then
			v7 = Preload.preloadAnimList(v2, v6, "core", Enum.AnimationPriority.Core)

			if v7 then
				v8 = v5
			else
				v7 = v6
				v8 = v5
			end
		else
			v7 = v6
			v8 = v5
		end

		local v9, v10

		if v12 then
			v9 = Preload.preloadAnimList(v2, v8, "emote", Enum.AnimationPriority.Action)

			if v9 then
				v10 = v7
			else
				v9 = v8
				v10 = v7
			end
		else
			v9 = v8
			v10 = v7
		end

		local v11 = Core.new(p1, v10, p5)
		local v13 = setmetatable({
			Core = v11,
			Action = Action.new(v11.PoseController, p1, v9, p5),
			_rig = p1
		}, t4)

		v13._destroying = p1.Destroying:Connect(function() --[[ Line: 107 | Upvalues: v13 (copy) ]]
			v13:Destroy()
		end)
		t[p1] = v13

		local v14 = t2[p1]

		if v14 then
			for v15, v16 in v14 do
				task.spawn(v16, v13)
			end
		end

		return v13
	end,
	fromExisting = function(p1) --[[ fromExisting | Line: 129 | Upvalues: t (copy) ]]
		return t[p1]
	end,
	waitForController = function(p1, p2) --[[ waitForController | Line: 141 | Upvalues: t (copy), t2 (copy) ]]
		if t[p1] then
			return t[p1]
		end

		t2[p1] = t2[p1] or {}

		local v4 = t2[p1]
		local v5 = coroutine.running()

		v4[#v4 + 1] = v5
		task.delay(p2 or 5, function() --[[ Line: 154 | Upvalues: v5 (copy), v4 (copy), p1 (copy) ]]
			if coroutine.status(v5) == "suspended" then
				table.remove(v4, table.find(v4, v5))
				warn((("Infinite yield possible while waiting for %* controller."):format(p1)))
			end
		end)

		return coroutine.yield()
	end,
	getCopyOfAnimsList = function(p1, p2) --[[ getCopyOfAnimsList | Line: 173 | Upvalues: DefaultAnims (copy), v1 (copy) ]]
		local v12 = DefaultAnims[p1]

		if not v12 then
			error((("%* is not a valid default animation list."):format(p1)))
		end

		local v2 = v12[p2]

		if v2 then
			return v1(v2)
		end

		error((("%* is not a valid default animation list specifier."):format(p2)))
	end,
	getCopyOfAnims = function(p1) --[[ getCopyOfAnims | Line: 194 | Upvalues: DefaultAnims (copy), v1 (copy) ]]
		local v12 = DefaultAnims[p1]

		if v12 then
			return v1(v12.Animations), v1(v12.Emotes)
		end

		error((("%* is not a valid default animation list."):format(p1)))
	end,
	getAnimPackageAsync = function(p1, p2) --[[ getAnimPackageAsync | Line: 203 | Upvalues: RunService (copy), v1 (copy), DefaultAnims (copy), LoadAnimPackage (copy), LoadPackage (copy) ]]
		if typeof(p1) ~= "Instance" and RunService:IsServer() then
			error("When calling getAnimPackageAsync from the server, the first argument must be a player.")
		end

		local v12 = if p2 then p2 else v1(DefaultAnims.R15.Animations)
		local v2 = if RunService:IsClient() then LoadAnimPackage:InvokeServer() else LoadPackage.getPlayerAnimPackage(p1)

		for v3, v4 in v12 do
			if v2[v3] == nil then
				v2[v3] = v4
			end
		end

		return v2
	end,
	getEmotePackageAsync = function(p1, p2) --[[ getEmotePackageAsync | Line: 228 | Upvalues: RunService (copy), v1 (copy), DefaultAnims (copy), LoadEmotePackage (copy), LoadPackage (copy) ]]
		if typeof(p1) ~= "Instance" and RunService:IsServer() then
			error("When calling getEmotePackageAsync from the server, the first argument must be a player.")
		end

		local v12 = if p2 then p2 else v1(DefaultAnims.R15.Animations)
		local v2 = if RunService:IsClient() then LoadEmotePackage:InvokeServer() else LoadPackage.getPlayerEmotePackage(p1)

		for v3, v4 in v12 do
			if v2[v3] == nil then
				v2[v3] = v4
			end
		end

		return v2
	end,
	Preload = Preload,
	default = DefaultAnims
}