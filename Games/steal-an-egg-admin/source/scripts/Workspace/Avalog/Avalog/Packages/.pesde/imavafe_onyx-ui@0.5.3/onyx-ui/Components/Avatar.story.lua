-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek
local v1 = {
    Frame = require(script.Parent.Frame),
    Avatar = require(script.Parent.Avatar)
}
local v2 = {
    Util.Colors.Red["500"],
    Util.Colors.Green["400"],
    Util.Colors.Orange["500"],
    Util.Colors.Stone["600"]
}
local v3 = {}

function v3.story(v4) -- line 22 | captures: Fusion, Themer, Util, Children, peek, v1, v2
    local v5 = Fusion.innerScope(v4.scope, Fusion, v1)
    local v6 = Themer.Theme:now()
    local v7 = v5:Value(v2[2])
    local v8 = v5:Value(peek(v6.StrokeThickness["2"]))
    local v9 = task.spawn(function() -- line 29 | captures: v6, v7, v8, peek, v2
        while true do
            if task.wait(1) then
                v7:set(v2[math.random(1, #v2)])
                if peek(v8) == peek(v6.StrokeThickness["2"]) then
                    v8:set(peek(v6.StrokeThickness["3"]))
                else
                    v8:set(peek(v6.StrokeThickness["2"]))
                end
            else
                break
            end
        end
    end)
    v5:innerScope({
        function() -- line 42 | captures: v9
            task.cancel(v9)
        end
    })
    local v10 = { Parent = v4.target }
    v10.Padding = v5:Computed(function(v11) -- line 49 | captures: v6
        return UDim.new(0, v11(v6.StrokeThickness["4"]))
    end)
    v10.ListEnabled = true
    v10.ListPadding = v5:Computed(function(v12) -- line 53 | captures: v6
        return UDim.new(0, v12(v6.Spacing["1"]))
    end)
    v10.ListFillDirection = Enum.FillDirection.Horizontal
    local v13 = v5:Avatar({ Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150" })
    local v14 = { Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150" }
    v14.CornerRadius = v5:Computed(function(v15) -- line 64 | captures: v6
        return UDim.new(0, v15(v6.CornerRadius.Full))
    end)
    local v16 = v5:Avatar(v14)
    local v17 = {
        Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
        RingEnabled = true
    }
    v17.CornerRadius = v5:Computed(function(v18) -- line 70 | captures: v6
        return UDim.new(0, v18(v6.CornerRadius.Full))
    end)
    v17.RingColor = v7
    local v19 = v5:Avatar(v17)
    local v20 = {
        Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
        IndicatorEnabled = true
    }
    v20.CornerRadius = v5:Computed(function(v21) -- line 78 | captures: v6
        return UDim.new(0, v21(v6.CornerRadius.Full))
    end)
    v20.IndicatorColor = v7
    local v22 = v5:Avatar(v20)
    local v23 = {
        Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
        RingEnabled = true
    }
    v23.CornerRadius = v5:Computed(function(v24) -- line 86 | captures: v6
        return UDim.new(0, v24(v6.CornerRadius.Full))
    end)
    v23.RingColor = Util.Colors.Green["400"]
    v23.RingThickness = v8
    local v25 = v5:Avatar(v23)
    local v26 = {
        Image = "rbxthumb://type=AvatarHeadShot&id=144146784&w=150&h=150",
        IndicatorEnabled = true,
        IndicatorIcon = "rbxassetid://13805569043"
    }
    v26.CornerRadius = v5:Computed(function(v27) -- line 95 | captures: v6
        return UDim.new(0, v27(v6.CornerRadius.Full))
    end)
    v26.IndicatorColor = Util.Colors.Sky["500"]
    v10[Children] = {
        v13,
        v16,
        v19,
        v22,
        v25,
        v5:Avatar(v26)
    }
    v5:Frame(v10)
end

v3.fusion = Fusion
return v3
