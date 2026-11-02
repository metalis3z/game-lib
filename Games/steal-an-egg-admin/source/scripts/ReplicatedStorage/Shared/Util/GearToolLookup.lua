-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local GearTools = ReplicatedStorage.GearTools
local v1 = {}
local v2 = table.freeze(v1)
local v3 = t.strict(t.string)

local function toolNamed(v4, v5) -- line 12
    if v4 ~= nil and v4.Name == v5 and v4:IsA("Tool") then
        return v4
    end
    return nil
end

return function(v6) -- line 22 | captures: GearTools, v2, v3
    v3(v6)
    local v7 = GearTools:FindFirstChild(v6, true)
    if not (v7 ~= nil and v7.Name == v6 and v7:IsA("Tool")) then
        v7 = nil
    end
    local v8
    if v7 == nil then
        v8 = GearTools:GetDescendants()
    else
        v8 = v2
    end
    for v9, v10 in v8 do
        if not v7 then
            if v10 ~= nil and v10.Name == v6 then
                if v10:IsA("Tool") then
                    v7 = v10
                end
            else
                v7 = nil
            end
        end
    end
    return v7
end
