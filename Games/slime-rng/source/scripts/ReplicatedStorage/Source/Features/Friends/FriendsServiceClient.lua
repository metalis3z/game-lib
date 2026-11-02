-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FriendsServiceClient, time of decompilation: Sun May  3 10:11:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)

return {
	init = function(p1) --[[ init ]] -- line: 16
		-- upvalues: Vide (copy), client (copy)
		if not p1.friendCount then
			p1.friendCount = Vide.source((math.max(client:get("friendsInServer") or 0, 0)))
		end

		local friendCount = p1.friendCount

		if p1.friendCountChangedConn then
			p1.friendCountChangedConn:Disconnect()
		end

		p1.friendCountChangedConn = client:getChangedSignal("friendsInServer"):Connect(function(p2) -- line: 22
			-- upvalues: friendCount (copy)
			friendCount((math.max(p2 or 0, 0)))
		end)
	end,
	getFriendCount = function(p3) --[[ getFriendCount ]] -- line: 27
		-- upvalues: Vide (copy), client (copy)
		if not p3.friendCount then
			p3.friendCount = Vide.source((math.max(client:get("friendsInServer") or 0, 0)))
		end

		return p3.friendCount()
	end,
	getFriendCountSource = function(p4) --[[ getFriendCountSource ]] -- line: 31
		-- upvalues: Vide (copy), client (copy)
		if not p4.friendCount then
			p4.friendCount = Vide.source((math.max(client:get("friendsInServer") or 0, 0)))
		end

		return p4.friendCount
	end
}
