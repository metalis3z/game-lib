local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Admin user IDs - must match AdminService on the server
local ADMIN_USER_IDS = {
	7719529089,
}
local t2 = {}

for _, v5 in require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceUtils).getTierMultipliers() do
	if v5 > 1 then
		table.insert(t2, v5)
	end
end

local adminLookup = {}
for _, uid in ADMIN_USER_IDS do
	adminLookup[uid] = true
end

return {
	isAdmin = function(userId: number)
		return adminLookup[userId] == true
	end,
	getAdminUserIds = function()
		return table.clone(ADMIN_USER_IDS)
	end,
	getServerLuckMultipliers = function() --[[ getServerLuckMultipliers ]] -- line: 37
		-- upvalues: t2 (copy)
		return table.clone(t2)
	end,
	isValidServerLuckMultiplier = function(n2: number) --[[ isValidServerLuckMultiplier ]] -- line: 41
		-- upvalues: t2 (copy)
		for _, v12 in t2 do
			if v12 == n2 then
				return true
			end
		end

		return false
	end,
	sanitizeWholeNumber = function(p1, n3: number?, n4: number?) --[[ sanitizeWholeNumber ]] -- line: 51
		if type(p1) ~= "number" or (p1 ~= p1 or p1 == 1e999 or p1 == -1e999) then
			return nil
		end

		local v16 = n3 == nil and -1e999 or n3
		local v17 = n4 == nil and 1e999 or n4

		return (math.clamp(math.floor(p1), v16, v17))
	end,
	sanitizeNumber = function(p2, n5: number?, n6: number?) --[[ sanitizeNumber ]] -- line: 61
		if type(p2) ~= "number" or p2 ~= p2 or p2 == 1e999 or p2 == -1e999 then
			return nil
		end

		return (math.clamp(p2, n5 == nil and -1e999 or n5, n6 == nil and 1e999 or n6))
	end,
	getServerLuckDurationRange = function() --[[ getServerLuckDurationRange ]] -- line: 71
		return 60, 86400
	end,
	getAdminLuckDurationRange = function() --[[ getAdminLuckDurationRange ]] -- line: 75
		return 60, 86400
	end,
	getAdminLuckMultiplierRange = function() --[[ getAdminLuckMultiplierRange ]] -- line: 79
		return 1.01, 16384
	end,
	getCountdownDurationRange = function() --[[ getCountdownDurationRange ]] -- line: 83
		return 30, 43200
	end
}
