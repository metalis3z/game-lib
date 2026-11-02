-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {}
local t2 = {
	CacheUpdated = Signal.new()
}

local function updateFriendCache(p1) --[[ updateFriendCache | Line: 32 | Upvalues: Players (copy), Constants (copy), t (copy), v1 (copy), t2 (copy) ]]
	local ok, result = pcall(function() --[[ Line: 33 | Upvalues: Players (ref), p1 (copy), Constants (ref) ]]
		local v1 = Players:GetFriendsAsync(p1.UserId)
		local t = {}

		while true do
			repeat
				for i, v in ipairs(v1:GetCurrentPage()) do
					table.insert(t, v.Id)
				end

				if v1.IsFinished then
					return t
				end

				v1:AdvanceToNextPageAsync()
			until Constants.IS_CLIENT

			task.wait(0.05)
		end

		return t
	end)
	local v12 = if ok then result else {} or result

	if p1.Parent then
		local t3 = {}

		for i, v in ipairs(v12) do
			t3[v] = true
		end

		t[p1] = {
			List = v12,
			Set = t3
		}
	end

	if not ok then
		v1:AtWarning():Log(("Failed to get friends for %*: %*, cache:"):format(p1.Name, result), t)
	end

	t2.CacheUpdated:Fire(p1)
end

Players.PlayerAdded:Connect(updateFriendCache)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 73 | Upvalues: t (copy) ]]
	t[p1] = nil
end)

for i, v in ipairs(Players:GetPlayers()) do
	task.spawn(updateFriendCache, v)
end

function t2.GetCountByPlayer(p1) --[[ GetCountByPlayer | Line: 85 | Upvalues: t (copy), Players (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return 0
	end

	local count = 0

	for i, v in ipairs(v1.List) do
		if Players:GetPlayerByUserId(v) ~= nil then
			count = count + 1
		end
	end

	return count
end
function t2.GetFriendIdsByPlayer(p1) --[[ GetFriendIdsByPlayer | Line: 99 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 then
		return table.clone(v1.List)
	end

	return {}
end
function t2.GetFriendIdSetByPlayer(p1) --[[ GetFriendIdSetByPlayer | Line: 108 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 then
		return table.clone(v1.Set)
	end

	return {}
end

return t2