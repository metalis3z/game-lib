-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local Fusion = require(Parent.Parent.Fusion)
local peek = Fusion.peek
local innerScope = Fusion.innerScope
local v1 = {
    BaseButton = require(script.Parent.BaseButton),
    SwitchInput = require(script.Parent.SwitchInput)
}
return function(v2, v3) -- line 30 | captures: Util, Themer, Fusion, peek, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:EnsureValue(Util.Fallback(v3.Switched, false))
    v3.Switched = v6
    local CombineProps = Util.CombineProps
    local v7 = {
        Name = "SwitchGroup",
        ClickSound = v5.Sound.Switch,
        Disabled = v3.Disabled
    }

    function v7.OnActivated() -- line 43 | captures: v6, peek
        v6:set(not peek(v6))
    end

    return v4:BaseButton(CombineProps(v3, v7))
end
