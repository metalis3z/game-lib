-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local EggState = require(ReplicatedStorage.Client.EggState)
local Hud = require(ReplicatedStorage.Client.Hud)
local Save = require(ReplicatedStorage.Shared.Save)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Trails = require(ReplicatedStorage.Data.Trails)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local SpeedValue = Hud.Get("SpeedValue")
local Treadmill = Hud.Find("SpeedValue", "Treadmill")
local TextColor3 = SpeedValue.TextColor3
local TextColor3_2 = Treadmill and Treadmill.TextColor3 or TextColor3
local v1 = 1

local function formatPower(v2) -- line 19
    local v3 = tonumber(v2) or 0
    local v4 = math.max(0, v3)
    local v5 = {
        { 1000000000000, "T" },
        { 1000000000, "B" },
        { 1000000, "M" },
        { 1000, "K" }
    }
    for v6, v7 in ipairs(v5) do
        if v7[1] <= v4 then
            return string.format("%.1f", v4 / v7[1]):gsub("%.0$", "") .. v7[2]
        end
    end
    local v8 = math.floor(v4)
    return (tostring(v8))
end

local function refresh() -- line 36 | captures: v1, Workspace, AdminBoosts, Save, SpeedPowerProjection, Trails, TreadmillUtil, SpeedValue, Treadmill, TextColor3, TextColor3_2, formatPower
    local v9 = Save.Get()
    if v9 == nil then
        return
    end
    local v10 = SpeedPowerProjection.ReadProjected()
    local v11 = TreadmillUtil.ResolveEffectiveSpeedPower(v10, v1) * AdminBoosts.ReadMultiplier(AdminBoosts.SPEED)
    local v12 = formatPower((math.floor(v11)))
    local v13 = TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(v9)
    local v14 = TreadmillUtil.ResolveTemporarySpeedBoostSpeedStepMultiplier(v9, Workspace:GetServerTimeNow())
    local v15 = TreadmillUtil.ResolveAdditiveSpeedStepMultiplier(v13, v14)
    if TreadmillUtil.DEFAULT_SPEED_STEP_MULTIPLIER < v15 then
        v12 ..= (" <font color=\"#00FF00\">(%s)</font>"):format(TreadmillUtil.FormatSpeedMultiplierValue(v15))
    end
    local v16 = TextColor3
    local v17 = TextColor3_2
    local EquippedTrail = v9.EquippedTrail
    if EquippedTrail ~= nil then
        local TrailInventory = v9.TrailInventory
        if type(TrailInventory) == "table" and v9.TrailInventory[EquippedTrail] == true and Trails.TrailNameExists(EquippedTrail) then
            v16 = Trails.Directory[EquippedTrail].Rarity.Color
            v17 = v16
        end
    end
    SpeedValue.Text = v12
    SpeedValue.TextColor3 = v16
    if Treadmill ~= nil then
        Treadmill.Text = v12
        Treadmill.TextColor3 = v17
    end
end

EggState.CarryChanged:Connect(function(v18) -- line 82 | captures: v1, refresh
    local SpeedMultiplier = v18.SpeedMultiplier
    local v19 = tonumber(SpeedMultiplier)
    if v19 ~= nil and v19 > 0 and v19 <= 1 then
        v1 = v19
    else
        v1 = 1
    end
    refresh()
end)
SpeedPowerProjection.Changed:Connect(refresh)
Save.FieldSignal("SpeedPower"):Connect(refresh)
Save.WatchFields({ "SpeedBoostTierIndex", "TemporarySpeedBoostRemainingSeconds", "TemporarySpeedBoostActiveStartedAt", "EquippedTrail", "TrailInventory" }, refresh)
AdminBoosts.Observe(AdminBoosts.SPEED):Connect(refresh)
Save.ProfileReady:Connect(refresh)
refresh()
local v20 = 0
RunService.Heartbeat:Connect(function(v21) -- line 101 | captures: v20, refresh
    v20 += v21
    if v20 >= 0.25 then
        v20 = 0
        refresh()
    end
end)
