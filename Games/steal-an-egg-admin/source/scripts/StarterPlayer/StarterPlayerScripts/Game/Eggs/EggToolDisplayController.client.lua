-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EggState = require(ReplicatedStorage.Client.EggState)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Log.new()
local v2 = {}

local function destroyActiveDisplay(v3) -- line 10
    v3.ActiveDisplayVersion += 1
    if v3.ActiveDisplay ~= nil then
        v3.ActiveDisplay:Destroy()
        v3.ActiveDisplay = nil
    end
    v3.ActiveTool = nil
end

local function attachTool(v4, v5) -- line 18 | captures: Players, EggState, EggToolDisplay, v1
    if v4.ActiveTool == v5 then
        return
    end
    v4.ActiveDisplayVersion += 1
    if v4.ActiveDisplay ~= nil then
        v4.ActiveDisplay:Destroy()
        v4.ActiveDisplay = nil
    end
    v4.ActiveTool = nil
    local v6 = EggToolDisplay.GetToolUid(v5)
    if v6 == nil then
        v1:AtError():Log((("Egg tool %* is missing an egg UID"):format((v5:GetFullName()))))
    else
        local v7 = EggState.ReadOwnedEgg(v4.Owner.UserId, v6)
        if v7 == nil and v4.Owner == Players.LocalPlayer then
            v7 = EggState.FetchEggRecord(v6)
        end
        if v7 == nil then
            local v8 = v5:GetFullName()
            v1:AtDebug():Log((("Egg tool %* has no record for owner %*"):format(v8, v4.Owner.UserId)))
        else
            v4.ActiveTool = v5
            v4.ActiveDisplayVersion += 1
            local v9 = EggToolDisplay.new(v5, {
                OwnerUserId = v4.Owner.UserId,
                UID = v6,
                ModelName = ("%*_%*"):format(v4.Owner.UserId, v6),
                Record = v7
            })
            if v4.ActiveTool == v5 and v4.ActiveDisplayVersion == v4.ActiveDisplayVersion and v5.Parent ~= nil then
                v4.ActiveDisplay = v9
            else
                v9:Destroy()
            end
        end
    end
end

local function refreshActiveTool(v10) -- line 51 | captures: EggToolDisplay, attachTool
    local Character = v10.Owner.Character
    if Character ~= nil then
        for v11, v12 in ipairs(Character:GetChildren()) do
            if v12.ClassName == "Tool" and EggToolDisplay.IsEggTool(v12) then
                attachTool(v10, v12)
                return
            end
        end
    end
end

local function bindCharacter(v13, v14) -- line 63 | captures: EggToolDisplay, Trove, attachTool, refreshActiveTool
    if v13.CharacterTrove ~= nil then
        v13.CharacterTrove:Destroy()
    end
    v13.ActiveDisplayVersion += 1
    if v13.ActiveDisplay ~= nil then
        v13.ActiveDisplay:Destroy()
        v13.ActiveDisplay = nil
    end
    v13.ActiveTool = nil
    local v15 = Trove.new()
    v13.CharacterTrove = v15
    v15:Connect(v14.ChildAdded, function(v16) -- line 75 | captures: v13, EggToolDisplay, attachTool
        if v16.ClassName == "Tool" and EggToolDisplay.IsEggTool(v16) then
            attachTool(v13, v16)
        end
    end)
    v15:Connect(v14.ChildRemoved, function(v17) -- line 80 | captures: v13
        if v17 ~= v13.ActiveTool then
            return
        end
        v13.ActiveDisplayVersion += 1
        if v13.ActiveDisplay ~= nil then
            v13.ActiveDisplay:Destroy()
            v13.ActiveDisplay = nil
        end
        v13.ActiveTool = nil
    end)
    refreshActiveTool(v13)
end

local function syncActiveParasite(v18) -- line 93 | captures: EggState, EggToolDisplay
    local ActiveTool = v18.ActiveTool
    local ActiveDisplay = v18.ActiveDisplay
    if ActiveTool ~= nil and ActiveDisplay ~= nil then
        local v19 = EggToolDisplay.GetToolUid(ActiveTool)
        if v19 ~= nil then
            local v20 = EggState.ReadOwnedEgg(v18.Owner.UserId, v19)
            if v20 ~= nil then
                ActiveDisplay:SyncParasite(v20.HasParasite)
            end
        end
    end
end

local function trackPlayer(v21) -- line 109 | captures: Trove, v2, bindCharacter
    local v22 = v2[v21]
    if v22 ~= nil then
        v22.ActiveDisplayVersion += 1
        if v22.ActiveDisplay ~= nil then
            v22.ActiveDisplay:Destroy()
            v22.ActiveDisplay = nil
        end
        v22.ActiveTool = nil
        if v22.CharacterTrove ~= nil then
            v22.CharacterTrove:Destroy()
        end
        v22.Trove:Destroy()
        v2[v21] = nil
    end
    local v23 = {
        ActiveDisplayVersion = 0,
        Owner = v21,
        Trove = Trove.new()
    }
    v2[v21] = v23
    v23.Trove:Connect(v21.CharacterAdded, function(v24) -- line 126 | captures: v23, bindCharacter
        bindCharacter(v23, v24)
    end)
    v23.Trove:Connect(v21.CharacterRemoving, function() -- line 129 | captures: v23
        v23.ActiveDisplayVersion += 1
        if v23.ActiveDisplay ~= nil then
            v23.ActiveDisplay:Destroy()
            v23.ActiveDisplay = nil
        end
        v23.ActiveTool = nil
        if v23.CharacterTrove ~= nil then
            v23.CharacterTrove:Destroy()
            v23.CharacterTrove = nil
        end
    end)
    if v21.Character ~= nil then
        bindCharacter(v23, v21.Character)
    end
end

Players.PlayerAdded:Connect(function(v25) -- line 146 | captures: trackPlayer
    task.defer(trackPlayer, v25)
end)
Players.PlayerRemoving:Connect(function(v26) -- line 149 | captures: v2
    local v27 = v2[v26]
    if v27 == nil then
        return
    end
    v27.ActiveDisplayVersion += 1
    if v27.ActiveDisplay ~= nil then
        v27.ActiveDisplay:Destroy()
        v27.ActiveDisplay = nil
    end
    v27.ActiveTool = nil
    if v27.CharacterTrove ~= nil then
        v27.CharacterTrove:Destroy()
    end
    v27.Trove:Destroy()
    v2[v26] = nil
end)
for v28, v29 in ipairs(Players:GetPlayers()) do
    task.defer(trackPlayer, v29)
end
EggState.OwnerRefreshed:Connect(function(v30) -- line 169 | captures: Players, EggState, EggToolDisplay, v2, syncActiveParasite
    for v31, v32 in v2 do
        if v32.Owner.UserId == v30 then
            if v32.Owner == Players.LocalPlayer then
                task.defer(syncActiveParasite, v32)
            else
                local ActiveTool = v32.ActiveTool
                local ActiveDisplay = v32.ActiveDisplay
                if ActiveTool ~= nil and ActiveDisplay ~= nil then
                    local v33 = EggToolDisplay.GetToolUid(ActiveTool)
                    if v33 ~= nil then
                        local v34 = EggState.ReadOwnedEgg(v32.Owner.UserId, v33)
                        if v34 ~= nil then
                            ActiveDisplay:SyncParasite(v34.HasParasite)
                        end
                    end
                end
            end
        end
    end
end)
