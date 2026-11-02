-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Children = Fusion.Children
local SliderSetting = require(script.Parent.SliderSetting)
return function(v1, v2) -- line 15 | captures: ServiceProvider, OnyxUI, Fusion, States, Children, SliderSetting
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components, { SliderSetting = SliderSetting })
    OnyxUI.Themer.Theme:now()
    local v4 = ServiceProvider:GetAvatarManager()
    local v5 = OnyxUI.Util.Fallback(v2.Shown, false)
    local v6 = v3:Value(1)
    local v7 = v3:Value(1)
    local v8 = v3:Value(1)

    local function UpdateColor() -- line 28 | captures: v4, v6, v7, v8, Fusion
        local v9 = Fusion.peek(v6)
        local v10 = Fusion.peek(v7)
        local v11 = Fusion.peek(v8)
        v4:SetColor(Color3.fromHSV(v9, v10, v11))
    end

    v3:Observer(v6):onChange(function() -- line 35 | captures: v4, v6, v7, v8, Fusion
        local v12 = Fusion.peek(v6)
        local v13 = Fusion.peek(v7)
        local v14 = Fusion.peek(v8)
        v4:SetColor(Color3.fromHSV(v12, v13, v14))
    end)
    v3:Observer(v7):onChange(function() -- line 38 | captures: v4, v6, v7, v8, Fusion
        local v15 = Fusion.peek(v6)
        local v16 = Fusion.peek(v7)
        local v17 = Fusion.peek(v8)
        v4:SetColor(Color3.fromHSV(v15, v16, v17))
    end)
    v3:Observer(v8):onChange(function() -- line 41 | captures: v4, v6, v7, v8, Fusion
        local v18 = Fusion.peek(v6)
        local v19 = Fusion.peek(v7)
        local v20 = Fusion.peek(v8)
        v4:SetColor(Color3.fromHSV(v18, v19, v20))
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v21 = {
        Name = script.Name,
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        Visible = v5
    }
    local v22 = OnyxUI.Themer.Theme:is(Fusion.peek(States.Theme))
    v21[Children] = {
        v22:during(function() -- line 52 | captures: v3, v6, v7, v8
            return {
                v3:SliderSetting({
                    Label = "Hue",
                    Value = v6
                }),
                v3:SliderSetting({
                    Label = "Saturation",
                    Value = v7
                }),
                v3:SliderSetting({
                    Label = "Brightness",
                    Value = v8
                })
            }
        end)
    }
    return v3:Frame(CombineProps(v2, v21))
end
