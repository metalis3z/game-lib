-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BoostServiceClient, time of decompilation: Sun May  3 10:11:21 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local Vide = require(ReplicatedStorage.Packages.Vide)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local t1 = {}
local t2 = {
	["Invalid boost"] = true,
	["No boosts available"] = true
}

function t1.init(p1) -- line: 35
	-- upvalues: Networker (copy), Vide (copy), BoostServiceUtils (copy), client (copy)
	p1.networker = Networker.client.new("BoostService", p1)
	p1.boosts = Vide.source(BoostServiceUtils.reconcileBoosts(client:get("boosts")))
	p1.boostsChangedConn = client:getChangedSignal("boosts"):Connect(function(p2) -- line: 38
		-- upvalues: p1 (copy), BoostServiceUtils (copy)
		p1.boosts(BoostServiceUtils.reconcileBoosts(p2))
	end)
end
function t1.getBoosts(p3) -- line: 43
	-- upvalues: BoostServiceUtils (copy)
	local boosts = p3.boosts

	if not boosts then
		return BoostServiceUtils.reconcileBoosts(nil)
	end

	return BoostServiceUtils.reconcileBoosts(boosts())
end
function t1.requestUseBoost(p4, p5) -- line: 52
	-- upvalues: ErrorMessages (copy), t2 (copy)
	local v16, v17 = p4.networker:fetch("requestUseBoost", p5)

	if not v16 then
		if v17 == "No boosts available" then
			ErrorMessages.add("You don't have any boosts of that type.")
		elseif v17 == "Invalid boost" then
			ErrorMessages.add("That boost can't be used right now.")
		else
			ErrorMessages.add(v17 or "Failed to use boost.")
		end

		if not t2[v17] then
			warn("Failed to use boost:", v17)
		end
	end

	return v16, v17
end
function t1.isActive(p6, p7) -- line: 64
	-- upvalues: BoostServiceUtils (copy), serverTimeSource (copy)
	return BoostServiceUtils.isActive(BoostServiceUtils.getBoostData(p6:getBoosts(), p7), serverTimeSource())
end
function t1.getTimeRemaining(p8, p9) -- line: 68
	-- upvalues: BoostServiceUtils (copy), serverTimeSource (copy)
	return BoostServiceUtils.getTimeRemaining(BoostServiceUtils.getBoostData(p8:getBoosts(), p9), serverTimeSource())
end
function t1.getExpirationTime(p10, p11) -- line: 72
	-- upvalues: BoostServiceUtils (copy)
	return BoostServiceUtils.getExpirationTime(BoostServiceUtils.getBoostData(p10:getBoosts(), p11))
end
function t1.getActiveBoosts(p12) -- line: 76
	-- upvalues: serverTimeSource (copy), BoostServiceUtils (copy)
	local t3 = {}
	local v26 = p12:getBoosts()
	local v27 = serverTimeSource()

	for _, v29 in BoostServiceUtils.getKinds() do
		local v30 = v26[v29]

		if BoostServiceUtils.isActive(v30, v27) then
			t3[v29] = v30
		end
	end

	return t3
end
function t1.getRollStatModifiers(p13) -- line: 91
	-- upvalues: BoostServiceUtils (copy), serverTimeSource (copy)
	return BoostServiceUtils.getRollStatModifiers(p13:getBoosts(), serverTimeSource())
end

return t1
