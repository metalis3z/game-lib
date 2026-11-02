-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Variables = require(game.ReplicatedStorage.Library.Variables)

function EmitOne(p1, p2) --[[ EmitOne | Line: 15 | Upvalues: Asserts (copy), Constants (copy), Variables (copy) ]]
	local TimeScale = p1.TimeScale

	if TimeScale < 0 then
		return 0
	end

	local v1 = p1:GetAttribute("EmitCount") or p1.Rate

	Asserts.number(v1)

	local v2 = v1 - math.floor(v1)
	local count = math.floor(v1)

	if v2 > 0 and math.random() < v2 then
		count = count + 1
	end

	if (p2 and Constants.IS_MOBILE or Variables.PotatoMode) and count > 1 then
		count = math.max(count * (if typeof(p2) == "number" and p2 then p2 else 0.1), 1)
	end

	if count < 1 then
		return 0
	end

	local v4 = p1:GetAttribute("EmitDelay") or 0

	if v4 == (1 / 0) then
		return 0
	end

	Asserts.number(v4)

	local v5 = math.max(v4, 0)

	task.delay(v5, function() --[[ Line: 53 | Upvalues: p1 (copy), count (ref) ]]
		p1:Emit(count)
	end)

	return v5 + p1.Lifetime.Max / TimeScale
end

return EmitOne