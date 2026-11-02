-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AdminLuckServiceUtils, time of decompilation: Sun May  3 10:12:20 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local t2 = {
	getDefaultState = function() --[[ getDefaultState ]] -- line: 49
		return {
			multiplier = 1,
			expirationTime = 0,
			startedByName = nil
		}
	end,
	reconcileState = function(p1) --[[ reconcileState ]] -- line: 57
		local v9 = if type(p1) ~= "table" then {} else p1
		local t1 = {}
		local multiplier = v9.multiplier

		t1.multiplier = if type(multiplier) == "number" and (multiplier == multiplier and (multiplier ~= 1e999 and multiplier ~= -1e999)) then math.clamp(multiplier, 1, 16384) else 1

		local expirationTime = v9.expirationTime

		t1.expirationTime = if type(expirationTime) == "number" and expirationTime == expirationTime then math.max(math.floor(expirationTime + 0.5), 0) else 0
		t1.startedByName = if type(v9.startedByName) ~= "string" then nil else v9.startedByName

		return t1
	end
}

function t2.isActive(p2, n1: number) -- line: 67
	-- upvalues: t2 (copy)
	local v15 = t2.reconcileState(p2)

	return v15.multiplier > 1 and n1 < v15.expirationTime
end
function t2.getTimeRemaining(p3, n2: number) -- line: 72
	-- upvalues: t2 (copy)
	local v18 = t2.reconcileState(p3)

	if not t2.isActive(v18, n2) then
		return 0
	end

	return (math.max(v18.expirationTime - n2, 0))
end
function t2.getCurrentMultiplier(p4, n3: number) -- line: 81
	-- upvalues: t2 (copy)
	local v21 = t2.reconcileState(p4)

	if t2.isActive(v21, n3) then
		return v21.multiplier
	end

	return 1
end
function t2.getRollStatModifier(p5, n4: number) -- line: 90
	-- upvalues: t2 (copy)
	local v24 = t2.getCurrentMultiplier(p5, n4)

	if v24 <= 1 then
		return nil
	end

	return {
		id = "adminLuck.global",
		stat = "luck",
		mode = "multiply",
		applyToFinalLuck = true,
		value = v24
	}
end
function t2.formatMultiplier(n5: number) -- line: 108
	local v26 = math.round(((if type(n5) == "number" and (n5 == n5 and (n5 ~= 1e999 and n5 ~= -1e999)) then math.clamp(n5, 1, 16384) else 1)) * 100) / 100

	return "x" .. if v26 % 1 ~= 0 then string.gsub(string.format("%.2f", v26), "%.?0+$", "") else tostring(v26)
end
function t2.getStartAnnouncementMessage(s1: string?, n6: number) -- line: 112
	local v29 = math.max(math.floor(n6 / 60), 1)
	local v30 = v29 ~= 1 and "minutes" or "minute"

	if s1 and s1 ~= "" then
		return `{ s1 } started Admin Luck for { v29 } { v30 }!`
	end

	return `Admin Luck started for { v29 } { v30 }!`
end
function t2.getActiveAnnouncementMessage(p6, n7: number) -- line: 122
	-- upvalues: t2 (copy), FormatTime (copy)
	local v33 = t2.reconcileState(p6)

	if not t2.isActive(v33, n7) then
		return nil
	end

	local v34 = FormatTime(t2.getTimeRemaining(v33, n7))
	local v35 = t2.formatMultiplier(v33.multiplier)

	if v33.startedByName and v33.startedByName ~= "" then
		return `{ v33.startedByName } has Admin Luck active at { v35 }! { v34 } left.`
	end

	return `Admin Luck is active at { v35 }! { v34 } left.`
end
function t2.getDescription(p7, _: number) -- line: 137
	-- upvalues: t2 (copy)
	local v38 = t2.reconcileState(p7)

	return `Global { t2.formatMultiplier(v38.multiplier) } luck multiplier for every server.`
end

return t2
