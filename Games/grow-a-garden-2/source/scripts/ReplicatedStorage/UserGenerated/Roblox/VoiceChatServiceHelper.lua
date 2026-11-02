--credit to prince games studio
local Players = game:GetService("Players")
local VoiceChatService = game:GetService("VoiceChatService")
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache)
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Cache.new({
	MaxAge = (1 / 0),
	Callback = function(p1) --[[ Callback | Line: 27 | Upvalues: VoiceChatService (copy) ]]
		return VoiceChatService:IsVoiceEnabledForUserIdAsync(p1)
	end,
	AssertKey = Asserts.Integer
})

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 34 | Upvalues: Players (copy), v1 (copy) ]]
	local UserId = p1.UserId

	task.delay(60, function() --[[ Line: 37 | Upvalues: Players (ref), UserId (copy), v1 (ref) ]]
		if Players:GetPlayerByUserId(UserId) then
			return
		end

		v1:Delete(UserId)
	end)
end)
task.spawn(function() --[[ Line: 43 | Upvalues: v1 (copy), Players (copy) ]]
	v1:GetAsync(Players.LocalPlayer.UserId)
end)

return table.freeze({
	IsVoiceEnabledForUserIdAsync = function(p1, p2) --[[ IsVoiceEnabledForUserIdAsync | Line: 49 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.Integer(p1)
		Asserts.Optional(Asserts.Boolean)(p2)

		if p2 then
			return v1:Get(p1)
		end

		return v1:GetAsync(p1)
	end
})