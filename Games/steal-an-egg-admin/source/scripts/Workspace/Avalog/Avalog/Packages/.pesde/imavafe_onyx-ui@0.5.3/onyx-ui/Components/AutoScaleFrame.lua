-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Workspace = game:GetService("Workspace")
local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Out = Fusion.Out
local innerScope = Fusion.innerScope
local v1 = {
    Base = require(script.Parent.Base),
    Frame = require(script.Parent.Frame)
}
return function(v2, v3) -- line 40 | captures: Workspace, Fusion, Util, Out, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Util.Fallback(v3.BaseResolution, Vector2.new())
    local v6 = Util.Fallback(v3.MinScale, 0.8)
    local v7 = Util.Fallback(v3.MaxScale, (1/0))
    local v8 = Util.Fallback(v3.ScaleMultiplier, 1)
    local v9 = v4:Value(Vector2.new())
    v4:Hydrate(Workspace.CurrentCamera)({ [Out("ViewportSize")] = v9 })
    local CombineProps = Util.CombineProps
    local v10 = { Name = "AutoScaleFrame" }
    v10.Scale = v4:Computed(function(v11) -- line 55 | captures: v5, v6, v7, v8, v9
        local v12 = v11(v8)
        local v13 = v11(v5).X / v11(v9).X
        local v14 = v11(v5).Y / v11(v9).Y
        local v15 = v12 / math.max(v13, v14)
        local v16 = v11(v6)
        local v17 = v11(v7)
        return (math.clamp(v15, v16, v17))
    end)
    return v4:Frame(CombineProps(v3, v10))
end
