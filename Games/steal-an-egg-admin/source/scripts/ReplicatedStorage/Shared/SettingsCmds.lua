-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SettingsInfo = require(ReplicatedStorage.Shared.SettingsInfo)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Save = require(ReplicatedStorage.Shared.Save)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local v2 = {}
local v3 = Signal.new()

v1.Changed = v3

local v4 = t.strict(t.string)
local v5 = t.strict(t.boolean)

local function entryFor(v6) -- line 22 | captures: SettingsInfo, v4
    v4(v6)
    local v7 = SettingsInfo[v6]
    if not v7 then
        local v8 = ("no such setting: %*"):format(v6)
        v7 = error(v8, 3)
    end
    return v7
end

local function fallbackFor(v9) -- line 31 | captures: SettingsInfo
    local v10 = SettingsInfo[v9]
    local v11 = v10 and v10.Fallback
    if typeof(v11) == "boolean" then
        return v11
    end
    return true
end

local function adopt(v12, v13) -- line 42 | captures: SettingsInfo, v2, v3
    local v14
    if typeof(v13) == "boolean" then
        v14 = v13
    else
        local v15 = SettingsInfo[v12]
        v14 = v15 and v15.Fallback
        if typeof(v14) ~= "boolean" then
            v14 = true
        end
    end
    local v16 = v2[v12]
    v2[v12] = v14
    if v16 ~= v14 then
        v3:Fire(v12, v14)
    end
end

local function adoptAll(v17) -- line 64 | captures: SettingsInfo, v2, v3
    local v18 = v17 or {}
    for v19 in SettingsInfo do
        local v20 = v18[v19]
        if typeof(v20) ~= "boolean" then
            local v21 = SettingsInfo[v19]
            v20 = v21 and v21.Fallback
            if typeof(v20) ~= "boolean" then
                v20 = true
            end
        end
        local v22 = v2[v19]
        v2[v19] = v20
        if v22 ~= v20 then
            v3:Fire(v19, v20)
        end
    end
end

function v1.Flag(v23) -- line 96 | captures: SettingsInfo, v2, v4
    v4(v23)
    if not SettingsInfo[v23] then
        local v24 = ("no such setting: %*"):format(v23)
        error(v24, 3)
    end
    local v25 = v2[v23]
    if v25 == nil then
        local v26 = SettingsInfo[v23]
        local v27 = v26 and v26.Fallback
        if typeof(v27) == "boolean" then
            return v27
        end
        return true
    end
    return v25
end

function v1.Allows(v28) -- line 116 | captures: v1
    return v1.Flag(v28) ~= false
end

function v1.Projected(v29) -- line 120 | captures: SettingsInfo, v1, v4
    v4(v29)
    local v30 = SettingsInfo[v29]
    if not v30 then
        local v31 = ("no such setting: %*"):format(v29)
        v30 = error(v31, 3)
    end
    local Projection = v30.Projection
    local v32 = v1.Flag(v29)
    if typeof(Projection) == "table" then
        return Projection[v32]
    end
    return v32
end

function v1.Write(v33, v34) -- line 135 | captures: SettingsInfo, Remotes, TryCall, v2, v3, v4, v5, adoptAll
    v4(v33)
    if not SettingsInfo[v33] then
        local v35 = ("no such setting: %*"):format(v33)
        error(v35, 3)
    end
    v5(v34)
    local v36, v37, v38 = TryCall(function() -- line 143 | captures: v33, v34, Remotes
        return Remotes.Preferences.AskWrite:InvokeServer(v33, v34)
    end)
    if v36 and v37 then
        if typeof(v38) == "table" then
            adoptAll(v38)
        else
            local v39
            if typeof(v34) == "boolean" then
                v39 = v34
            else
                local v40 = SettingsInfo[v33]
                v39 = v40 and v40.Fallback
                if typeof(v39) ~= "boolean" then
                    v39 = true
                end
            end
            local v41 = v2[v33]
            v2[v33] = v39
            if v41 ~= v39 then
                v3:Fire(v33, v39)
            end
        end
        return true
    end
    return false
end

function v1.Flip(v42) -- line 174 | captures: v1
    return v1.Write(v42, not v1.Allows(v42))
end

local function onRemoteSettingChanged(v43, v44) -- line 177 | captures: SettingsInfo, v2, v3
    if not (typeof(v43) == "string" and SettingsInfo[v43]) then
        return
    end
    local v45
    if typeof(v44) == "boolean" then
        v45 = v44
    else
        local v46 = SettingsInfo[v43]
        v45 = v46 and v46.Fallback
        if typeof(v45) ~= "boolean" then
            v45 = true
        end
    end
    local v47 = v2[v43]
    v2[v43] = v45
    if v47 ~= v45 then
        v3:Fire(v43, v45)
    end
end

adoptAll(nil)

if LocalPlayer then
    Save.ProfileReady:Connect(function(v48) -- line 203 | captures: Save, LocalPlayer, adoptAll
        if v48 ~= LocalPlayer then
            return
        end
        local v49 = Save.Get()
        local v50 = v49 and v49.Settings
        if v49 then
            local v51 = if typeof(v50) == "table" then v50 else nil
            adoptAll(v51)
        end
    end)
end
Save.FieldSignal("Settings"):Connect(function() -- line 222 | captures: Save, adoptAll
    local v52 = Save.Get()
    if not v52 then
        return
    end
    v52 = v52.Settings
    local v53 = if typeof(v52) == "table" then v52 else nil
    adoptAll(v53)
end)

if Save.IsLocalDataLoaded() then
    local v54 = Save.Get()
    local v55 = v54 and v54.Settings
    if v54 then
        local v56 = if typeof(v55) == "table" then v55 else nil
        adoptAll(v56)
    end
end
Remotes.Preferences.PreferenceShifted.OnClientEvent:Connect(onRemoteSettingChanged)
return v1
