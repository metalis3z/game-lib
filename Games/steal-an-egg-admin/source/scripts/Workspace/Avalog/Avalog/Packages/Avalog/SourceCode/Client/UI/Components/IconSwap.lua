-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
return function(v1, v2) -- line 11 | captures: OnyxUI, Fusion
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = OnyxUI.Util.Fallback(v2.Options, {})
    local v6 = v3:EnsureValue(OnyxUI.Util.Fallback(v2.Selection, 1))
    local v7 = OnyxUI.Util.Fallback(v2.OnSwap, function() -- line 17
    end)

    local function RotateSelection(v8) -- line 19 | captures: v5, v6, Fusion
        local v9 = Fusion.peek(v5)
        local v10 = Fusion.peek(v6) + v8
        if #v9 < v10 then
            v10 = 1
        elseif v10 < 1 then
            v10 = #v9
        end
        v6:set(v10)
    end

    local CombineProps = OnyxUI.Util.CombineProps
    local v11 = {
        Style = "Ghost",
        Name = script.Name,
        Color = v4.Colors.BaseContent.Main
    }
    v11.Image = v3:Computed(function(v12) -- line 37 | captures: v5, v6
        return v12(v5)[v12(v6)]
    end)

    function v11.OnActivated() -- line 41 | captures: v5, v6, v7, Fusion
        local v13 = Fusion.peek(v6)
        local v14 = Fusion.peek(v7)
        local v15 = Fusion.peek(v5)
        local v16 = Fusion.peek(v6) + 1
        if #v15 < v16 then
            v16 = 1
        elseif v16 < 1 then
            v16 = #v15
        end
        v6:set(v16)
        v14(v13, v13 + 1)
    end

    return v3:IconButton(CombineProps(v2, v11))
end
