--credit to quartz games studio
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local t = {
	Discord = 0,
	Facebook = 1,
	Twitch = 2,
	YouTube = 3,
	X = 4,
	GitHub = 5,
	Guilded = 6
}

table.freeze(t)

local v1 = Cache.new({
	Callback = function(p1) --[[ Callback | Line: 50 | Upvalues: Players (copy), PolicyService (copy) ]]
		local v1 = Players:GetPlayerByUserId(p1)

		assert(v1, "PlayerNotOnline")

		return PolicyService:GetPolicyInfoForPlayerAsync(v1)
	end,
	AssertKey = Asserts.Integer
})

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 57 | Upvalues: Players (copy), v1 (copy) ]]
	local UserId = p1.UserId

	task.delay(60, function() --[[ Line: 60 | Upvalues: Players (ref), UserId (copy), v1 (ref) ]]
		if Players:GetPlayerByUserId(UserId) then
			return
		end

		v1:Delete(UserId)
	end)
end)

if RunService:IsServer() then
	Players.PlayerAdded:Connect(function(p1) --[[ Line: 67 | Upvalues: v1 (copy) ]]
		v1:GetAsync(p1.UserId)
	end)
end

return table.freeze({
	ExternalLinkReference = t,
	ExternalLinkReferencesToInts = function(p1) --[[ ExternalLinkReferencesToInts | Line: 77 | Upvalues: t (copy) ]]
		local t2 = {}

		for i, v in ipairs(p1) do
			local v1 = t[v]

			if v1 then
				table.insert(t2, v1)
			end
		end

		return t2
	end,
	GetPolicyInfoForPlayerAsync = function(p1, p2) --[[ GetPolicyInfoForPlayerAsync | Line: 90 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.Player(p1)
		Asserts.Optional(Asserts.Boolean)(p2)

		if p2 then
			return v1:Get(p1.UserId)
		end

		return v1:GetAsync(p1.UserId)
	end
})