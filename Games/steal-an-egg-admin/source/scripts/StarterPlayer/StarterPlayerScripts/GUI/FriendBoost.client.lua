-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Hud = require(ReplicatedStorage.Client.Hud)
local PlayerUtils = require(ReplicatedStorage.Shared.Utils.PlayerUtils)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SetLabelWithShadow = require(ReplicatedStorage.Shared.Utils.Layout).SetLabelWithShadow
local LocalPlayer = Players.LocalPlayer
local FriendBoost = Hud.Find("FriendBoost")
local v1

if FriendBoost == nil then
else
    v1 = FriendBoost:FindFirstChild("CurrentBoost")
end

if FriendBoost ~= nil then
    FriendBoost.Visible = false
end

local function setBoostVisible(v2) -- line 25 | captures: FriendBoost
    if FriendBoost ~= nil then
        FriendBoost.Visible = v2
    end
end

local function onFriendsInGame() -- line 30 | captures: FriendBoost
    if FriendBoost ~= nil then
        FriendBoost.Visible = true
    end
end

local function onNoFriends() -- line 35 | captures: FriendBoost
    if FriendBoost ~= nil then
        FriendBoost.Visible = false
    end
end

local function updateBoostsDisplay() -- line 40 | captures: v1, GameFlags, PlayerUtils, SetLabelWithShadow, LocalPlayer, FriendBoost
    local v3 = PlayerUtils.CountPresent(LocalPlayer)
    if not v3 or v3 <= 0 then
        if FriendBoost ~= nil then
            FriendBoost.Visible = false
        end
    else
        local v4 = GameFlags.FriendBoostPercentPerFriend:Get()
        local v5 = GameFlags.FriendBoostCap:Get()
        local v6 = v4 * math.clamp(v3, 0, v5)
        local v7 = math.floor(v6)
        if v7 <= 0 then
            if FriendBoost ~= nil then
                FriendBoost.Visible = false
            end
        else
            if FriendBoost ~= nil then
                FriendBoost.Visible = true
            end
            if v1 ~= nil then
                SetLabelWithShadow(v1, string.format("Friend Boost: +%d%%", v7))
            end
        end
    end
end

PlayerUtils.RosterUpdated:Connect(function(v8) -- line 63 | captures: LocalPlayer, updateBoostsDisplay
    if v8 == LocalPlayer then
        updateBoostsDisplay()
    end
end)
updateBoostsDisplay()
Players.PlayerAdded:Connect(updateBoostsDisplay)
Players.PlayerRemoving:Connect(updateBoostsDisplay)
GameFlags.FriendBoostPercentPerFriend.Changed:Connect(updateBoostsDisplay)
GameFlags.FriendBoostCap.Changed:Connect(updateBoostsDisplay)
Remotes.Referrals.InviteLanded.OnClientEvent:Connect(function() -- line 73 | captures: Confetti
    Confetti.Burst()
end)
return {}
