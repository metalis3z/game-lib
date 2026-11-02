-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local States = require(script.Parent.Parent.States)
local Categories = require(Parent.SourceCode.Shared.Categories)
local Fusion = require(Parent.Parent.Fusion)
local Config = require(Parent.Config)
local v1 = {}
local v2 = Fusion.scoped(Fusion)

v1.Mode = v2:Computed(function(v3) -- line 11 | captures: States, Config
    return Config:Get().EditModes[v3(States.Catalog.Mode)]
end)
v1.Category = v2:Computed(function(v4) -- line 14 | captures: States, Categories, v1
    local v5 = v4(v1.Mode)
    local v6 = v4(States.Catalog.Category)
    return Categories[v5][v6]
end)
v1.SubCategory = v2:Computed(function(v7) -- line 20 | captures: States, v1
    local v8 = v7(v1.Category)
    local v9 = v7(States.Catalog.SubCategory)
    if not (v8 and v8.SubCategories) then
        return nil
    end
    return v8.SubCategories[v9]
end)
return v1
