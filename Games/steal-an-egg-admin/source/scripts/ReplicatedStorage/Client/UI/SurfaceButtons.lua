-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.instanceIsA("BasePart"))
local v2 = t.strict(t.string)
local v3 = {}

local function buttonWithin(v4, v5) -- line 11
    local v6 = v4:FindFirstChild(v5, true)
    if v6 and v6:IsA("GuiButton") then
        return v6
    end
    return nil
end

function v3.Find(v7, v8) -- line 21 | captures: v1, v2
    v1(v7)
    v2(v8)
    local v9 = v7:GetChildren()
    local v10 = 1
    local v11
    while true do
        local v12, v13
        if v11 == nil then
            if #v9 < v10 then
                v13 = true
            else
                local v14 = v9[v10]
                if v14:IsA("SurfaceGui") then
                    v12 = v14:FindFirstChild(v8, true)
                    if v12 then
                        if not v12:IsA("GuiButton") then
                            v12 = v11
                        end
                    else
                        v12 = nil
                    end
                end
                v13 = false
            end
        else
            v13 = true
        end
        if v13 then
            break
        end
        v10 += 1
        v11 = v12
    end
    return v11
end

return v3
