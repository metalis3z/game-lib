-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = { "LocalTransparencyModifier", "CanCollide", "CanQuery", "CanTouch" }
local v2 = {
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    LocalTransparencyModifier = 1
}
local v3 = { "Decal", "Texture" }
local v4 = { "Transparency" }
local v5 = { Transparency = 1 }
local v6 = { "Enabled" }
local v7 = { Enabled = false }
local v8 = { "ParticleEmitter", "Beam", "Trail", "BillboardGui", "SurfaceGui", "Highlight", "Light", "ProximityPrompt" }
local v9 = {}

local function anyClassMatches(v10, v11) -- line 26
    for v12, v13 in v11 do
        if v10:IsA(v13) then
            return true
        end
    end
    return false
end

local function muteFields(v14, v15, v16, v17) -- line 37
    local v18 = table.create(#v16)
    for v19, v20 in v16 do
        v18[v19] = v15[v20]
        v15[v20] = v17[v20]
    end
    v14:Add(function() -- line 46 | captures: v15, v16, v18
        if v15.Parent ~= nil then
            for v21, v22 in v16 do
                v15[v22] = v18[v21]
            end
        end
    end)
end

local function mute(v23, v24) -- line 58 | captures: v1, v2, v3, v4, v5, muteFields
    if v24:IsA("BasePart") then
        muteFields(v23, v24, v1, v2)
    else
        for v25, v26 in v3 do
            if v24:IsA(v26) then
                muteFields(v23, v24, v4, v5)
                return
            end
        end
    end
end

function v9.Conceal(v27) -- line 95 | captures: Trove, mute
    local v28 = Trove.new()
    for v29, v30 in v27:GetDescendants() do
        mute(v28, v30)
    end
    local DescendantAdded = v27.DescendantAdded
    v28:Add(DescendantAdded:Connect(function(v31) -- line 100 | captures: v28, mute
        mute(v28, v31)
    end))
    return v28
end

return table.freeze(v9)
