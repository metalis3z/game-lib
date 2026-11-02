-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SpeedPower = require(ReplicatedStorage.Client.RewardFeedback.SpeedPower)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = Color3.fromRGB(150, 150, 150)
local v2 = ColorSequence.new(v1, Color3.fromRGB(110, 110, 110))
local v3 = Log.new()
local LocalPlayer = Players.LocalPlayer
local BuyCash = GUI.GroupReward().Frame.BuyCash
local Price = BuyCash:FindFirstChild("Price")
local UIGradient = BuyCash:FindFirstChildOfClass("UIGradient")
local ProximityPrompt = Workspace.__OBJECTS.GroupReward.ProximityPrompt
local Text = Price.Text
local Color

if UIGradient == nil then
else
    Color = UIGradient.Color
end
local v4 = TryLock()
local ProximityPrompt_2 = ProximityPrompt:IsA("ProximityPrompt")
assert(ProximityPrompt_2, "Expected GroupReward.ProximityPrompt to be a ProximityPrompt")
local v5

if Price == nil then
    v5 = false
else
    v5 = Price:IsA("TextLabel")
end
assert(v5, "FreeGift.Frame.BuyCash.Price must be a TextLabel")

local function renderClaimState(v6) -- line 42 | captures: Color, t, v2, Price, UIGradient, Text
    t.strict(t.boolean)(v6)
    local v7 = if v6 then "CLAIMED!" else Text
    Price.Text = v7
    if UIGradient ~= nil and Color ~= nil then
        local v8 = if v6 then v2 else Color
        UIGradient.Color = v8
    end
end

local function updateView() -- line 61 | captures: Color, t, Save, v2, Price, UIGradient, Text
    local v9 = Save.Get()
    if v9 == nil then
        return
    end
    local v10 = v9.ClaimedGroupReward == true
    t.strict(t.boolean)(v10)
    local v11 = if v10 then "CLAIMED!" else Text
    Price.Text = v11
    if UIGradient ~= nil and Color ~= nil then
        local v12 = if v10 then v2 else Color
        UIGradient.Color = v12
    end
end

local function invokeClaim(v13) -- line 85 | captures: Color, t, Confetti, Message, Remotes, SpeedPower, Tabs, v2, Price, UIGradient
    t.strict(t.boolean)(v13)
    local v14, v15, v16 = Remotes.GroupPerk.RedeemPerk:InvokeServer(v13)
    if v14 then
        t.strict(t.number)(v16)
        if Tabs.IsShowing("GroupReward") then
            Tabs.Dismiss()
        end
        t.strict(t.boolean)(true)
        Price.Text = "CLAIMED!"
        if UIGradient ~= nil and Color ~= nil then
            UIGradient.Color = v2
        end
        Message.Prompt("REWARD CLAIMED!")
        Confetti.Burst()
        SpeedPower.Announce(v16)
        return true
    end
    Message.Prompt(v15 or "Failed to claim reward!")
    return false
end

local function resolveClientMembership() -- line 110 | captures: GroupService, Constants, Message, LocalPlayer
    local v17, v18 = pcall(function() -- line 112 | captures: Constants, LocalPlayer
        return LocalPlayer:IsInGroupAsync(Constants.GROUP_ID)
    end)
    if v17 then
        if v18 then
            return true, true
        end
        local v19, v20 = pcall(function() -- line 122 | captures: GroupService, Constants
            return GroupService:PromptJoinAsync(Constants.GROUP_ID)
        end)
        if v19 then
            if v20 == Enum.GroupMembershipStatus.Joined or v20 == Enum.GroupMembershipStatus.AlreadyMember then
                return true, true
            end
            if v20 == Enum.GroupMembershipStatus.JoinRequestPending then
                Message.Prompt("Your request to join the group is pending approval.")
            else
                Message.Prompt("You must join the group to claim this reward!")
            end
            return false, false
        end
        Message.Prompt("Failed to open the group join prompt!")
    else
        Message.Prompt("Failed to verify your group membership!")
    end
    return false, false
end

local function onClaimActivated() -- line 139 | captures: Message, Save, invokeClaim, resolveClientMembership
    local v21 = Save.Get()
    if v21 == nil then
        Message.PromptGenericFailure()
    elseif v21.ClaimedGroupReward == true then
        Message.Prompt("You already claimed this reward!")
    else
        local v22, v23 = resolveClientMembership()
        if v22 then
            invokeClaim(v23)
        end
    end
end

ButtonFX(BuyCash, 1.08, function() -- line 156 | captures: v4, onClaimActivated
    v4(onClaimActivated)
end)
ProximityPrompt.Triggered:Connect(function() -- line 159 | captures: Tabs
    Tabs.Toggle("GroupReward")
end)

if Save.IsLocalDataLoaded() then
    local v24 = Save.Get()
    if v24 ~= nil then
        local v25 = v24.ClaimedGroupReward == true
        t.strict(t.boolean)(v25)
        local v26 = if v25 then "CLAIMED!" else Text
        Price.Text = v26
        if UIGradient ~= nil and Color ~= nil then
            local v27 = if v25 then v2 else Color
            UIGradient.Color = v27
        end
    end
else
    Save.ProfileReady:Connect(updateView)
end
Save.WatchFields({ "ClaimedGroupReward" }, updateView)
v3:AtInfo():Log("Group rewards client initialized")
