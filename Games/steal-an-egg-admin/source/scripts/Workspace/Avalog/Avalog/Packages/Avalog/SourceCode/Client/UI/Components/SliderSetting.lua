-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Children = Fusion.Children
return function(v1, v2) -- line 12 | captures: OnyxUI, Fusion, Children
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v4 = OnyxUI.Themer.Theme:now()
    local Setting = OnyxUI.Util.Fallback(v2.Label, "Setting")
    local v5 = OnyxUI.Util.Fallback(v2.Value, 1)
    local CombineProps = OnyxUI.Util.CombineProps
    local v6 = {
        Name = script.Name,
        ListEnabled = true
    }
    v6.ListPadding = v3:Computed(function(v7) -- line 22 | captures: v4
        return UDim.new(0, v7(v4.Spacing["0.75"]))
    end)
    v6.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v6[Children] = {
        v3:Heading({
            HeadingSize = 1.25,
            TextWrapped = false,
            Text = Setting
        }),
        v3:Slider({ Value = v5 })
    }
    return v3:Frame(CombineProps(v2, v6))
end
