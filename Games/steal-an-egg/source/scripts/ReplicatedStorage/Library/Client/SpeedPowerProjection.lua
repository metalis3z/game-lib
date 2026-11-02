-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local DEFAULT_BASE_SPEED_POWER = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local v1 = DEFAULT_BASE_SPEED_POWER
local v2 = false
local v3 = DEFAULT_BASE_SPEED_POWER
local v4 = 0
local v5 = nil
local t = {
	Changed = Signal.new()
}

local function readAuthoritativeSpeedPower() --[[ readAuthoritativeSpeedPower | Line: 28 | Upvalues: Save (copy), TreadmillUtil (copy) ]]
	local v1 = Save.Get()

	return TreadmillUtil.NormalizeSpeedPower(if v1 == nil then nil else v1.SpeedPower)
end

local function resolveProjectedSpeedPower() --[[ resolveProjectedSpeedPower | Line: 33 | Upvalues: v5 (ref), DEFAULT_BASE_SPEED_POWER (ref), v2 (ref), v3 (ref), v4 (ref) ]]
	if v5 == nil then
		return DEFAULT_BASE_SPEED_POWER
	end

	if v2 then
		return v3 + v4
	end

	return math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)
end

local function publishProjectedSpeedPower() --[[ publishProjectedSpeedPower | Line: 43 | Upvalues: v5 (ref), DEFAULT_BASE_SPEED_POWER (ref), v2 (ref), v3 (ref), v4 (ref), v1 (ref), t (copy) ]]
	local v12 = if v5 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

	if v12 ~= v1 then
		v1 = v12
		t.Changed:Fire(v12)
	end
end

local function reconcileAuthoritativeSpeedPower() --[[ reconcileAuthoritativeSpeedPower | Line: 52 | Upvalues: DEFAULT_BASE_SPEED_POWER (ref), Save (copy), TreadmillUtil (copy), v2 (ref), v5 (ref), v3 (ref), v4 (ref), v1 (ref), t (copy) ]]
	local v12 = Save.Get()

	DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v12 == nil then nil else v12.SpeedPower)

	if not v2 and (v5 ~= nil and v3 + v4 <= DEFAULT_BASE_SPEED_POWER) then
		v5 = nil
		v3 = DEFAULT_BASE_SPEED_POWER
		v4 = 0
	end

	local v32 = if v5 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

	if v32 ~= v1 then
		v1 = v32
		t.Changed:Fire(v32)
	end
end

function t.BeginSession(p1) --[[ BeginSession | Line: 70 | Upvalues: Asserts (copy), DEFAULT_BASE_SPEED_POWER (ref), Save (copy), TreadmillUtil (copy), v2 (ref), v5 (ref), v3 (ref), v1 (ref), v4 (ref), t (copy) ]]
	Asserts.number(p1)

	local v12 = Save.Get()

	DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v12 == nil then nil else v12.SpeedPower)
	v2 = true
	v5 = p1
	v3 = math.max(DEFAULT_BASE_SPEED_POWER, v1)
	v4 = 0

	local v52 = if p1 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

	if v52 ~= v1 then
		v1 = v52
		t.Changed:Fire(v52)
	end
end
function t.RevealCompletedGain(p1, p2) --[[ RevealCompletedGain | Line: 81 | Upvalues: Asserts (copy), v5 (ref), v4 (ref), DEFAULT_BASE_SPEED_POWER (ref), v2 (ref), v3 (ref), v1 (ref), t (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)

	if v5 ~= p1 or p2 <= 0 then
		return false
	end

	v4 = v4 + p2

	local v12 = if v5 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

	if v12 == v1 then
		return true
	end

	v1 = v12
	t.Changed:Fire(v12)

	return true
end
function t.EndSession(p1) --[[ EndSession | Line: 93 | Upvalues: Asserts (copy), v5 (ref), v2 (ref), DEFAULT_BASE_SPEED_POWER (ref), Save (copy), TreadmillUtil (copy), v3 (ref), v4 (ref), v1 (ref), t (copy) ]]
	Asserts.number(p1)

	if v5 ~= p1 then
		return
	end

	v2 = false

	local v12 = Save.Get()

	DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v12 == nil then nil else v12.SpeedPower)

	if not v2 and (v5 ~= nil and v3 + v4 <= DEFAULT_BASE_SPEED_POWER) then
		v5 = nil
		v3 = DEFAULT_BASE_SPEED_POWER
		v4 = 0
	end

	local v32 = if v5 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

	if v32 ~= v1 then
		v1 = v32
		t.Changed:Fire(v32)
	end
end
function t.GetSpeedPower() --[[ GetSpeedPower | Line: 103 | Upvalues: v1 (ref) ]]
	return v1
end

local v6 = Save.Get()

DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v6 == nil then nil else v6.SpeedPower)

if not v2 and (v5 ~= nil and v3 + v4 <= DEFAULT_BASE_SPEED_POWER) then
	v5 = nil
	v3 = DEFAULT_BASE_SPEED_POWER
	v4 = 0
end

local v8 = if v5 == nil then DEFAULT_BASE_SPEED_POWER elseif v2 then v3 + v4 else math.max(DEFAULT_BASE_SPEED_POWER, v3 + v4)

if v8 ~= v1 then
	v1 = v8
	t.Changed:Fire(v8)
end

Save.GetStatChangedSignal("SpeedPower"):Connect(reconcileAuthoritativeSpeedPower)

return t