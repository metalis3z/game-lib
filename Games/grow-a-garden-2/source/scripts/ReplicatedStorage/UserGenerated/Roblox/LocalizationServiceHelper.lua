--credit to quartz games studio
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Cache = require(ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Cache.new({
	Callback = function(p1) --[[ Callback | Line: 29 | Upvalues: Players (copy), LocalizationService (copy) ]]
		local v1 = Players:GetPlayerByUserId(p1)

		assert(v1, "PlayerNotOnline")

		return LocalizationService:GetCountryRegionForPlayerAsync(v1)
	end,
	AssertKey = Asserts.Integer
})

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 36 | Upvalues: Players (copy), v1 (copy) ]]
	local UserId = p1.UserId

	task.delay(60, function() --[[ Line: 39 | Upvalues: Players (ref), UserId (copy), v1 (ref) ]]
		if Players:GetPlayerByUserId(UserId) then
			return
		end

		v1:Delete(UserId)
	end)
end)

if RunService:IsServer() then
	Players.PlayerAdded:Connect(function(p1) --[[ Line: 46 | Upvalues: v1 (copy) ]]
		v1:GetAsync(p1.UserId)
	end)
else
	task.spawn(function() --[[ Line: 50 | Upvalues: v1 (copy), Players (copy) ]]
		v1:GetAsync(Players.LocalPlayer.UserId)
	end)
end

return table.freeze({
	GetCountryRegionForPlayerAsync = function(p1, p2) --[[ GetCountryRegionForPlayerAsync | Line: 57 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.Player(p1)
		Asserts.Optional(Asserts.Boolean)(p2)

		if p2 then
			return v1:Get(p1.UserId)
		end

		return v1:GetAsync(p1.UserId)
	end
})