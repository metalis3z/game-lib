
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Synchronizer = require(Packages.Synchronizer)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Rebirth = require(Datas.Rebirth)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Friends = require(Shared.Friends)
local Index = require(Shared.Index)

require(Shared.Updates)

return {
	GetPlayerCashMultiplayer = function(_: {[any]: any}, p1)
		local v12 = p1 or Players.LocalPlayer
		local n1 = 1
		local v14 = Synchronizer:Get(v12)

		if v14 then
			local v15 = v14:Get("Rebirth")

			if v15 > 0 then
				local v16 = Rebirth[v15]

				if v16 then
					n1 += v16.Rewards.Multiplier
				end
			end

			if v14:Get("Gamepass.VIP") == true then
				n1 += 0.5
			end

			if v14:Get("Gamepass.2x Money") == true then
				n1 += 2
			end

			local v17 = v14:Get("BoostExpiration.2xMoney")

			if typeof(v17) == "number" and v17 > 0 and v17 > DateTime.now().UnixTimestamp then
				n1 += 2
			end

			n1 = n1 + Friends:GetFriendBoostModifier(v12) + Index:GetMultipliers(v12)
		end

		return n1
	end
}
