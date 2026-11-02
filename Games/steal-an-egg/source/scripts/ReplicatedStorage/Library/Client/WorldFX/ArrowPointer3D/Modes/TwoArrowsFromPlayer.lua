-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local v1 = require(script.Parent.Parent)
local ArrowPointerFromPlayer = require(script.Parent.ArrowPointerFromPlayer)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v2 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local v3 = Vector3.new(0, 1, 0) * (v1.__constants.ARROW_SIZE + v1.__constants.DEFAULT_CONFIG.Amplitude + v1.__constants.DEFAULT_CONFIG.Radius)
local v4 = t.union(t.instanceIsA("Model"), t.instanceIsA("BasePart"), t.Vector3)
local t2 = {}

t2.__index = t2
t2.__class = "TwoArrowsFromPlayer"
function t2.new(p1, p2, p3) --[[ new | Line: 48 | Upvalues: v4 (copy), v1 (copy), t2 (copy), Trove (copy), ArrowPointerFromPlayer (copy) ]]
	assert(v4(p1))
	assert(v1.__types.OptionalConfig(p3))

	local v2 = if p3 then p3 else {}

	v2.ProximityThreshold = 0

	local v42 = setmetatable({}, t2)

	v42._trove = Trove.new()
	v42._originOrModelToTrack = p1
	v42.Started = false
	v42.StaticArrow = v42._trove:Add((v1.new(nil, nil, v2)))
	v42.PlayerArrow = v42._trove:Add((ArrowPointerFromPlayer.new(nil, p2)))
	v42:_init()

	return v42
end
function t2.Start(p1) --[[ Start | Line: 77 ]]
	if not p1.Started then
		p1.Started = true
		p1.PlayerArrow:Start()
		p1.StaticArrow:Start()
	end
end
function t2.Stop(p1) --[[ Stop | Line: 87 ]]
	if p1.Started then
		p1.Started = false
		p1.PlayerArrow:Stop()
		p1.StaticArrow:Stop()
	end
end
function t2.ChangeOrigin(p1, p2) --[[ ChangeOrigin | Line: 97 | Upvalues: v4 (copy) ]]
	assert(v4(p2))
	p1._originOrModelToTrack = p2
	p1:_init()
end
function t2.Destroy(p1) --[[ Destroy | Line: 104 ]]
	p1._trove:Destroy()
	table.clear(p1)
	setmetatable(p1, nil)
end
function t2._init(p1) --[[ _init | Line: 115 | Upvalues: v3 (copy), v2 (copy) ]]
	local v1 = nil
	local v22 = nil
	local v32 = nil

	if typeof(p1._originOrModelToTrack) == "Vector3" then
		v1 = p1._originOrModelToTrack
		v32 = v1 + v3 * 1.8
		v22 = v1
	elseif p1._originOrModelToTrack:IsA("BasePart") then
		v22 = p1._originOrModelToTrack.Position
		v1 = v22 + Vector3.new(0, 1, 0) * (p1._originOrModelToTrack.Size.Y / 2)
		v32 = v1 + v3
	elseif p1._originOrModelToTrack:IsA("Model") then
		local v5, v6 = p1._originOrModelToTrack:GetBoundingBox()

		v22 = v5.Position
		v1 = v22 + Vector3.new(0, 1, 0) * (v6.Y / 2)
		v32 = v1 + v3
	end

	v2:AtTrace():Log("TwoArrowsFromPlayer tracked center:", v1, "origin:", v32)
	p1.StaticArrow:ChangeOrigin(v32)
	p1.StaticArrow:ChangeTarget(v1)
	p1.PlayerArrow:ChangeTarget(v22)

	return p1
end

return t2