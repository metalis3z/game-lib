--credit to prince games studio
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local RunService = game:GetService("RunService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Cache.new({
	MaxAge = (1 / 0),
	Callback = function(p1) --[[ Callback | Line: 38 | Upvalues: GroupService (copy) ]]
		return GroupService:GetGroupsAsync(p1)
	end,
	AssertKey = Asserts.Integer
})

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 44 | Upvalues: Players (copy), v1 (copy) ]]
	local UserId = p1.UserId

	task.delay(60, function() --[[ Line: 47 | Upvalues: Players (ref), UserId (copy), v1 (ref) ]]
		if Players:GetPlayerByUserId(UserId) then
			return
		end

		v1:Delete(UserId)
	end)
end)

if RunService:IsServer() then
	Players.PlayerAdded:Connect(function(p1) --[[ Line: 54 | Upvalues: v1 (copy) ]]
		v1:GetAsync(p1.UserId)
	end)
else
	task.spawn(function() --[[ Line: 58 | Upvalues: v1 (copy), Players (copy) ]]
		v1:GetAsync(Players.LocalPlayer.UserId)
	end)
end

return table.freeze({
	Cache = v1,
	GetGroupsAsync = function(p1, p2) --[[ GetGroupsAsync | Line: 67 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.Integer(p1)
		Asserts.Optional(Asserts.Boolean)(p2)

		if p2 then
			return v1:Get(p1)
		end

		return v1:GetAsync(p1)
	end
})