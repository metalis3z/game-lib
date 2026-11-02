-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent.Parent
Core = require(Tool.Core)

local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = {}

v2.__index = v2

function v2.new() -- line 11 | captures: v1, v2
    local v3 = {}
    local v4 = setmetatable(v3, v2)
    v4.Selection = v1.CloneTable(Core.Selection.Items)
    v4.Parts = v1.CloneTable(Core.Selection.Parts)
    v4.InitialColor = v1.GetMemberMap(v4.Parts, "Color")
    v4.TargetColor = nil
    v4.InitialUnionColoring = {}
    for v5, v6 in pairs(v4.Parts) do
        if v6:IsA("UnionOperation") then
            v4.InitialUnionColoring[v6] = v6.UsePartColor
        end
    end
    return v4
end

local function Unapply(v7) -- line 34
    local v8 = {}
    for v9, v10 in ipairs(v7.Parts) do
        local v11 = {
            Part = v10,
            Color = v7.InitialColor[v10],
            UnionColoring = v7.InitialUnionColoring[v10]
        }
        table.insert(v8, v11)
    end
    Core.SyncAPI:Invoke("SyncColor", v8)
    Core.Selection.Replace(v7.Selection)
end

v2.Unapply = Unapply

local function Apply(v12, v13) -- line 53
    local v14 = {}
    for v15, v16 in ipairs(v12.Parts) do
        local v17 = {
            UnionColoring = true,
            Part = v16,
            Color = v12.TargetColor
        }
        table.insert(v14, v17)
    end
    Core.SyncAPI:Invoke("SyncColor", v14)
    if not v13 then
        Core.Selection.Replace(v12.Selection)
    end
end

v2.Apply = Apply
return v2
