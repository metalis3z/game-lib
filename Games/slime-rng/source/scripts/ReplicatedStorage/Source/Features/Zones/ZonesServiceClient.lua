-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ZonesServiceClient, time of decompilation: Sun May  3 10:11:53 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local Vide = require(ReplicatedStorage.Packages.Vide)
local ZonePurchase = require(script.Parent.Components.ZonePurchase)
local ZoneHudState = require(script.Parent.ZoneHudState)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local t1 = {}
local t2 = {
	["Not enough coins"] = true,
	["Zone does not exist"] = true,
	["Zone not unlocked"] = true
}

function t1.init(p1) -- line: 49
	-- upvalues: Networker (copy), Players (copy), Vide (copy), ZonePurchase (copy)
	p1.networker = Networker.client.new("ZonesService", p1)

	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

	p1.zonePurchaseGui = Vide.mount(function() -- line: 53
		-- upvalues: ZonePurchase (copy), p1 (copy)
		return ZonePurchase({
			OnBuy = function() --[[ OnBuy ]] -- line: 55
				-- upvalues: p1 (copy)
				p1:purchaseZone()
			end
		})
	end, PlayerGui)
end
function t1.zoneEntered(_, n1: number) -- line: 62
	-- upvalues: Zones (copy), ZoneHudState (copy)
	local v19 = Zones.getZone(n1)

	ZoneHudState.notifyZoneEntered(n1, v19.name)
end
function t1.getZone(_) -- line: 67
	-- upvalues: client (copy)
	return (math.max(client:get("zone") or 1, 1))
end
function t1.getMaxZone(_) -- line: 71
	-- upvalues: client (copy)
	return (math.max(client:get("maxZone") or 1, 1))
end
function t1.getFurthestZone(p5) -- line: 75
	-- upvalues: client (copy)
	return (math.max(client:get("furthestZone") or 1, p5:getMaxZone()))
end
function t1.ownsZone(p6, n2: number) -- line: 79
	return n2 >= 1 and n2 <= p6:getMaxZone()
end
function t1.getZoneInfo(p7, n3: number?) -- line: 83
	-- upvalues: Zones (copy)
	return Zones.getZone(n3 or p7:getZone())
end
function t1.purchaseZone(p8) -- line: 87
	-- upvalues: TutorialServiceClient (copy), ErrorMessages (copy), t2 (copy)
	local v28 = p8:getMaxZone() + 1

	if not TutorialServiceClient:canPurchaseZone(v28) then
		ErrorMessages.add("That zone is locked during the tutorial.")

		return false
	end

	local v29, v30 = p8.networker:fetch("requestPurchaseZone")

	if not v29 then
		if v30 == "Not enough coins" then
			ErrorMessages.add("You need more coins to unlock the next zone.")
		elseif v30 == "Zone does not exist" then
			ErrorMessages.add("There isn't another zone to unlock yet.")
		else
			ErrorMessages.add(v30 or "Failed to unlock the next zone.")
		end

		if not t2[v30] then
			warn("Failed to purchase zone:", v30)
		end
	end

	return v29
end
function t1.teleportToZone(p9, n4: number) -- line: 105
	-- upvalues: ErrorMessages (copy), t2 (copy)
	local v33, v34 = p9.networker:fetch("requestTeleportZone", n4)

	if not v33 then
		if v34 == "Zone not unlocked" then
			ErrorMessages.add("You haven't unlocked that zone yet.")
		elseif v34 == "Zone does not exist" then
			ErrorMessages.add("That zone isn't available right now.")
		else
			ErrorMessages.add(v34 or "Failed to teleport.")
		end

		if not t2[v34] then
			warn("Failed to teleport to zone:", v34)
		end
	end

	return v33
end

return t1
