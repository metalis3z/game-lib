-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local ScaleLimits = require(Parent.SourceCode.Shared.ScaleLimits)
local StretchNumber = require(Parent.SourceCode.Shared.Utils.StretchNumber)
local States = require(Parent.SourceCode.Client.UI.States)
local Children = Fusion.Children
local SliderSetting = require(script.Parent.SliderSetting)
return function(v1, v2) -- line 16 | captures: OnyxUI, Fusion, ServiceProvider, ScaleLimits, StretchNumber, States, Children, SliderSetting
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { SliderSetting = SliderSetting })
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = ServiceProvider:GetAvatarManager()
    local v6 = OnyxUI.Util.Fallback(v2.Shown, false)
    local v7 = {
        {
            Name = "BodyType",
            Value = v3:Value(1)
        },
        {
            Name = "Proportion",
            Value = v3:Value(1)
        },
        {
            Name = "Height",
            Value = v3:Value(1)
        },
        {
            Name = "Width",
            Value = v3:Value(1)
        },
        {
            Name = "Depth",
            Value = v3:Value(1)
        },
        {
            Name = "Head",
            Value = v3:Value(1)
        }
    }
    for v8, v9 in ipairs(v7) do
        local v10 = v3:Observer(v9.Value)
        local v11 = v9
        v10:onChange(function() -- line 35 | captures: v5, v11, Fusion
            v5:UpdateScale(v11.Name, Fusion.peek(v11.Value))
        end)
    end
    v5.Updated:Connect(function() -- line 40 | captures: v5, v7, ScaleLimits, StretchNumber
        if v5.HumanoidDescriber ~= nil then
            local v12 = v5.HumanoidDescriber:GetData()
            for v13, v14 in ipairs(v7) do
                local v15 = v12.Scale[v14.Name]
                local v16 = ScaleLimits[v14.Name]
                if v15 then
                    v14.Value:set(StretchNumber(v15, v16.Min, v16.Max))
                end
            end
        end
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v17 = {
        Name = script.Name,
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        Visible = v6,
        CanvasSize = UDim2.new()
    }
    v17.PaddingRight = v3:Computed(function(v18) -- line 60 | captures: v4
        return UDim.new(0, v18(v4.Spacing["1"]))
    end)
    v17.Padding = v3:Computed(function(v19) -- line 63 | captures: v4
        return UDim.new(0, v19(v4.Spacing["0"]))
    end)
    v17[Children] = {
        v3:ForValues(v7, function(v20, v21, v22) -- line 68 | captures: OnyxUI, Fusion, States
            return OnyxUI.Themer.Theme:is(Fusion.peek(States.Theme)):during(function() -- line 69 | captures: v21, v22
                return v21:SliderSetting({
                    Label = v22.Name,
                    Value = v22.Value
                })
            end)
        end)
    }
    return v3:Scroller(CombineProps(v2, v17))
end
