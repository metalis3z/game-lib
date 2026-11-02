-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local Hud = require(ReplicatedStorage.Client.Hud)
local NightTimer = Hud.Every("NightTimer")
local NightTimerValue = Hud.Every("NightTimerValue")
local NightTimerIcon = Hud.Every("NightTimerIcon")
local v1 = {}
for v2, v3 in ipairs(NightTimerValue) do
    v1[v3] = v3.TextColor3
end
local v4 = Color3.fromRGB(255, 64, 64)

local function setVisible(v5) -- line 21 | captures: NightTimer
    for v6, v7 in ipairs(NightTimer) do
        v7.Visible = v5
    end
end

local function setIcon(v8) -- line 27 | captures: AreaEggResetCycle, NightTimerIcon
    local v9 = if v8 then AreaEggResetCycle.MoonIcon else AreaEggResetCycle.SunIcon
    for v10, v11 in ipairs(NightTimerIcon) do
        if v11:IsA("ImageLabel") or v11:IsA("ImageButton") then
            v11.Visible = true
            v11.Image = v9
        end
    end
end

local function refresh() -- line 37 | captures: Workspace, AreaEggCycle, Elapsed, NightTimer, NightTimerValue, v1, v4, setIcon
    if AreaEggCycle.IsRunning() then
        for v12, v13 in ipairs(NightTimer) do
            v13.Visible = true
        end
        local v14 = Workspace:GetServerTimeNow()
        local v15 = AreaEggCycle.IsNightPhase(v14)
        local v16 = AreaEggCycle.SecondsUntilPhaseEnd(v14)
        local v17 = math.ceil(v16)
        local v18 = math.max(0, v17)
        local v19 = if v15 then "ends in " else "in "
        local v20 = v19 .. Elapsed(v18)
        local v21 = AreaEggCycle.IsInFinalBlink(v18) and AreaEggCycle.IsBlinkOnRedFrame(v18)
        setIcon(v15)
        for v22, v23 in ipairs(NightTimerValue) do
            v23.Text = v20
            if v21 then
                v23.TextColor3 = v4
            else
                v23.TextColor3 = v1[v23]
            end
        end
    else
        for v24, v25 in ipairs(NightTimer) do
            v25.Visible = false
        end
    end
end

refresh()
local v26 = 0
RunService.Heartbeat:Connect(function(v27) -- line 61 | captures: v26, refresh
    v26 += v27
    if v26 >= 0.2 then
        v26 = 0
        refresh()
    end
end)
