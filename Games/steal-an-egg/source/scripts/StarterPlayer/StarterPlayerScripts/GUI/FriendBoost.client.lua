-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local GetFriendCountInServer = require(ReplicatedStorage.Library.Functions.GetFriendCountInServer)
local FriendBoosts = require(ReplicatedStorage.Library.Shared.Variables.FriendBoosts)
local Confetti = require(ReplicatedStorage.Library.Client.GUIFX.Confetti)
local UpdateTextAndShadow = require(ReplicatedStorage.Library.Functions.UpdateTextAndShadow)
local Network = require(game.ReplicatedStorage.Library.Client.Network)
local LocalPlayer = Players.LocalPlayer
local FriendBoost = GUI.Money().Bottom.Frame.FriendBoost
local CurrentBoost = FriendBoost.CurrentBoost

FriendBoost.Visible = false

local function onFriendsInGame() --[[ onFriendsInGame | Line: 24 | Upvalues: FriendBoost (copy) ]]
	FriendBoost.Visible = true
end

local function onNoFriends() --[[ onNoFriends | Line: 28 | Upvalues: FriendBoost (copy) ]]
	FriendBoost.Visible = false
end

local function updateBoostsDisplay() --[[ updateBoostsDisplay | Line: 32 | Upvalues: GetFriendCountInServer (copy), LocalPlayer (copy), FriendBoost (copy), FriendBoosts (copy), UpdateTextAndShadow (copy), CurrentBoost (copy) ]]
	local v1 = GetFriendCountInServer.GetCountByPlayer(LocalPlayer)

	if not v1 or v1 <= 0 then
		FriendBoost.Visible = false

		return
	end

	local v3 = math.floor(FriendBoosts.BaseBoostPercent * math.clamp(v1, 0, FriendBoosts.MaxPlayers))

	if v3 <= 0 then
		FriendBoost.Visible = false
	else
		FriendBoost.Visible = true
		UpdateTextAndShadow(CurrentBoost, string.format("Friend Boost: +%d%%", v3))
	end
end

GetFriendCountInServer.CacheUpdated:Connect(function(p1) --[[ Line: 49 | Upvalues: LocalPlayer (copy), updateBoostsDisplay (copy) ]]
	if p1 ~= LocalPlayer then
		return
	end

	updateBoostsDisplay()
end)
updateBoostsDisplay()
Players.PlayerAdded:Connect(updateBoostsDisplay)
Players.PlayerRemoving:Connect(updateBoostsDisplay)
Network.Fired(Network.NET_MAP.InviteFriends.ON_INVITE_SUCCESS):Connect(function() --[[ Line: 59 | Upvalues: Confetti (copy) ]]
	Confetti.Play()
end)

return {}