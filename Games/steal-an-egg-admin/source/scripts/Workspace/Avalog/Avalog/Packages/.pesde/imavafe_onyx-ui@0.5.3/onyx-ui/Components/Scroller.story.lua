-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Fusion = require(script.Parent.Parent.Parent.Fusion)
local scoped = Fusion.scoped
local v1 = { Scroller = require(script.Parent.Scroller) }
local v2 = {}

function v2.story(v3) -- line 12 | captures: Fusion, v1
    Fusion.innerScope(v3.scope, Fusion, v1):Scroller({
        Parent = v3.target,
        Size = UDim2.fromOffset(200, 200),
        CanvasSize = UDim2.new(UDim.new(1, 0), UDim.new(0, 1000)),
        AutomaticCanvasSize = Enum.AutomaticSize.None
    })
end

v2.fusion = Fusion
return v2
