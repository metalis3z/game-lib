-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = {
    Loading = true,
    InProgress = true,
    RoundEnd = true
}
local v2 = {}
local LocalPlayer = Players.LocalPlayer
local v3 = false

local function roundState() -- line 13 | captures: LocalPlayer
    return LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
end

local function recompute(v4) -- line 16 | captures: v3, LocalPlayer
    local v5 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if v4 == nil then
        if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then
            v3 = false
        else
            v3 = v5 ~= "Waiting"
        end
    else
        v3 = v4
    end
end

function v2.HoldsBack(v6) -- line 26 | captures: v3, v1, LocalPlayer
    local v7
    if v6 == true then
        v7 = v3
        if v7 then
            if v1[LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"] == true then
                return true
            end
            v7 = false
        end
    else
        v7 = false
    end
    return v7
end

function v2.TakeAdmissible(v8) -- line 40 | captures: v2
    for v9, v10 in v8 do
        if not v2.HoldsBack(v10.config.DelayInRound) then
            return table.remove(v8, v9)
        end
    end
    return nil
end

local v11 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"

if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then
    v3 = false
else
    v3 = v11 ~= "Waiting"
end
LocalPlayer:GetAttributeChangedSignal("MurderMysteryRoundState"):Connect(function() -- line 55 | captures: v3, LocalPlayer
    local v12
    if LocalPlayer:GetAttribute("MurderMysteryRoundState") then
    else
        v12 = false
    end
    local v13 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if v12 == nil then
        if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then
            v12 = false
        else
            v12 = v13 ~= "Waiting"
        end
    end
    v3 = v12
end)
LocalPlayer:GetAttributeChangedSignal("MurderMysteryRole"):Connect(function() -- line 71 | captures: v3, LocalPlayer
    local v14 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then
        v3 = false
    else
        v3 = v14 ~= "Waiting"
    end
end)
Remotes.Whodunnit.RoundShifted.OnClientEvent:Connect(function(v15) -- line 76 | captures: v3, LocalPlayer
    if typeof(v15) ~= "table" then
        return
    end
    local isParticipant = v15.isParticipant
    if typeof(isParticipant) ~= "boolean" then
        isParticipant = nil
    end
    local v16 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
    if isParticipant == nil then
        if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then
            isParticipant = false
        else
            isParticipant = v16 ~= "Waiting"
        end
    end
    v3 = isParticipant
end)
return v2
