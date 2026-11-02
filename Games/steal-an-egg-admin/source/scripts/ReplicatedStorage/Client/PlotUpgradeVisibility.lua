-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlotState = require(ReplicatedStorage.Client.PlotState)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

local function paintSubtree(v2, v3) -- line 6
    for v4, v5 in ipairs(v2:GetDescendants()) do
        if v5:IsA("BasePart") then
            if v3 then
                v5.LocalTransparencyModifier = 0
            else
                v5.LocalTransparencyModifier = 1
            end
        elseif v5:IsA("SurfaceGui") then
            v5.Enabled = v3
        elseif v5:IsA("BillboardGui") then
            if not v3 then
                v5.Enabled = false
            end
        elseif v5:IsA("BillboardGui") and v5.Name ~= "CanUpgrade" then
            v5.Enabled = true
        end
    end
end

function v1.Apply(v6, v7) -- line 28 | captures: PlotState, t, paintSubtree
    t.strict(t.string)(v6)
    t.strict(t.optional(t.boolean))(v7)
    local v8 = PlotState.ResolveFolder()
    local v9 = PlotState.ResolveLocalSlot()
    local v10
    if v9 == nil then
    else
        v10 = tostring(v9)
    end
    local v11
    if v8 == nil then
        v11 = {}
    else
        v11 = v8:GetDescendants()
    end
    for v12, v13 in v11 do
        local Parent = v13.Parent
        if v13.Name == v6 and Parent ~= nil then
            local v14
            if v10 == nil then
                v14 = false
            elseif Parent.Name == v10 then
                v14 = v7 ~= false
            else
                v14 = false
            end
            paintSubtree(v13, v14)
        end
    end
end

return v1
