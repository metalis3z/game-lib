-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SoundService = game:GetService("SoundService")
local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local peek = Fusion.peek
local OnEvent = Fusion.OnEvent
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 55 | captures: SoundService, Fusion, Util, Themer, peek, OnEvent, innerScope, v1
    local v4 = innerScope(v2, Fusion, Util, v1)
    local v5 = Themer.Theme:now()
    local v6 = Util.Fallback(v3.Disabled, false)
    local v7 = v4:EnsureValue(Util.Fallback(v3.IsHovering, false))
    local v8 = v4:EnsureValue(Util.Fallback(v3.IsHolding, false))
    local v9 = Util.Fallback(v3.OnActivated, function() -- line 62
    end)
    local v10 = Util.Fallback(v3.OnMouseEnter, function() -- line 63
    end)
    local v11 = Util.Fallback(v3.OnMouseLeave, function() -- line 64
    end)
    local v12 = Util.Fallback(v3.OnMouseButton1Down, function() -- line 65
    end)
    local v13 = Util.Fallback(v3.OnMouseButton1Up, function() -- line 66
    end)
    local v14 = Util.Fallback(v3.HoverSound, v5.Sound.Hover)
    local v15 = Util.Fallback(v3.ClickSound, v5.Sound.Click)
    local v16 = Util.Fallback(v3.Active, v4:Computed(function(v17) -- line 71 | captures: v6
        return not v17(v6)
    end))
    local v18 = Util.Fallback(v3.Selectable, v4:Computed(function(v19) -- line 77 | captures: v6
        return not v19(v6)
    end))
    local v20 = v4:Hydrate(v4:Base(Util.CombineProps(v3, {
        ClassName = "TextButton",
        Name = "BaseButton",
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Selectable = v18
    })))
    local v21 = {
        Text = "",
        RichText = false,
        TextSize = 0
    }

    v21[OnEvent("Activated")] = function() -- line 93 | captures: v6, v9, v15, SoundService, peek
        if not peek(v6) then
            SoundService:PlayLocalSound(peek(v15))
            peek(v9)()
        end
    end

    v21[OnEvent("MouseEnter")] = function() -- line 99 | captures: v7, v10, v14, v16, SoundService, peek
        if peek(v16) then
            SoundService:PlayLocalSound(peek(v14))
        end
        v7:set(true)
        peek(v10)()
    end

    v21[OnEvent("SelectionGained")] = function() -- line 106 | captures: v7, v10, v14, v16, SoundService, peek
        if peek(v16) then
            SoundService:PlayLocalSound(peek(v14))
        end
        v7:set(true)
        peek(v10)()
    end

    v21[OnEvent("MouseLeave")] = function() -- line 113 | captures: v7, v8, v11, peek
        v7:set(false)
        v8:set(false)
        peek(v11)()
    end

    v21[OnEvent("MouseButton1Down")] = function() -- line 118 | captures: v6, v8, v12, peek
        if not peek(v6) then
            v8:set(true)
            peek(v12)()
        end
    end

    v21[OnEvent("MouseButton1Up")] = function() -- line 124 | captures: v8, v13, peek
        v8:set(false)
        peek(v13)()
    end

    return v20(v21)
end
