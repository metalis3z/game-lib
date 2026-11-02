-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local NumberSpinner = require(script.NumberSpinner)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local peek = Fusion.peek
local innerScope = Fusion.innerScope
local v1 = { Text = require(script.Parent.Text) }
return function(v2, v3) -- line 47 | captures: Fusion, NumberSpinner, Util, Themer, peek, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.TextSize, v5.TextSize["1"])
    local v7 = Util.Fallback(v3.Value, 0)
    local v8 = Util.Fallback(v3.Prefix, "")
    local v9 = Util.Fallback(v3.Suffix, "")
    local v10 = Util.Fallback(v3.Decimals, 0)
    local v11 = Util.Fallback(v3.Duration, 0.3)
    local v12 = Util.Fallback(v3.Commas, false)
    local fromGuiObject = NumberSpinner.fromGuiObject
    local CombineProps = Util.CombineProps
    local v13 = {
        Name = "NumberSpinner",
        AutomaticSize = Enum.AutomaticSize.None,
        TextSize = v6,
        Font = Enum.Font.GothamBold
    }
    v13.Size = v4:Computed(function(v14) -- line 65 | captures: v6
        return UDim2.new(UDim.new(1, 0), UDim.new(0, v14(v6)))
    end)
    local v15 = fromGuiObject(v4:Text(CombineProps(v3, v13)))
    local v16 = {
        Value = v7,
        Prefix = v8,
        Suffix = v9,
        Decimals = v10,
        Duration = v11,
        Comas = v12
    }
    for v17, v18 in pairs(v16) do
        v15[v17] = peek(v18)
        local v19 = v4:Observer(v18)
        local v20 = v17
        local v21 = v18
        v19:onChange(function() -- line 75 | captures: v15, v20, v21, peek
            v15[v20] = peek(v21)
        end)
    end
    return v15.GuiObject
end
