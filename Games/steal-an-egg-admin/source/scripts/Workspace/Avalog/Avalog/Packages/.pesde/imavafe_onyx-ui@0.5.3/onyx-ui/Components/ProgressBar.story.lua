-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local ColorUtils = require(Parent.Parent.ColorUtils)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek
local v1 = {
    Frame = require(script.Parent.Frame),
    ProgressBar = require(script.Parent.ProgressBar),
    Text = require(script.Parent.Text)
}
local v2 = {}

function v2.story(v3) -- line 22 | captures: Fusion, ColorUtils, Themer, Util, Children, peek, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:Value(0)
    local v7 = v4:Value(Color3.fromRGB(255, 0, 0))
    local v8 = task.spawn(function() -- line 29 | captures: v6, v7, ColorUtils, peek
        while task.wait(1) do
            v6:set(math.random(0, 1000) / 1000)
            v7:set(ColorUtils.Rotate(peek(v7), 100))
        end
    end)
    v4:innerScope({
        function() -- line 37 | captures: v8
            task.cancel(v8)
        end
    })
    local v9 = {
        Parent = v3.target,
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v9.ListPadding = v4:Computed(function(v10) -- line 46 | captures: v5
        return UDim.new(0, v10(v5.Spacing["1.5"]))
    end)
    local v11 = {
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v11.ListPadding = v4:Computed(function(v12) -- line 54 | captures: v5
        return UDim.new(0, v12(v5.Spacing["0.5"]))
    end)
    v11[Children] = {
        v4:Text({ Text = "Horizontal" }),
        v4:ProgressBar({ Progress = 0.75 }),
        v4:ProgressBar({
            Progress = v6,
            Color = v7
        })
    }
    local v13 = v4:Frame(v11)
    local v14 = {
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v14.ListPadding = v4:Computed(function(v15) -- line 74 | captures: v5
        return UDim.new(0, v15(v5.Spacing["0.5"]))
    end)
    local v16 = v4:Text({ Text = "With text" })
    local v17 = {
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v17.ListPadding = v4:Computed(function(v18) -- line 86 | captures: v5
        return UDim.new(0, v18(v5.Spacing["0.5"]))
    end)
    v17[Children] = {
        v4:Text({ Text = "HP" }),
        v4:ProgressBar({
            Progress = v6,
            Color = Util.Colors.Red["500"],
            FlexMode = Enum.UIFlexMode.Fill
        })
    }
    v14[Children] = {
        v16,
        v4:Frame(v17)
    }
    local v19 = v4:Frame(v14)
    local v20 = {
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v20.ListPadding = v4:Computed(function(v21) -- line 106 | captures: v5
        return UDim.new(0, v21(v5.Spacing["0.5"]))
    end)
    v20[Children] = {
        v4:Text({ Text = "Inverted" }),
        v4:ProgressBar({
            Inverted = true,
            Progress = v6
        })
    }
    local v22 = v4:Frame(v20)
    local v23 = {
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v23.ListPadding = v4:Computed(function(v24) -- line 123 | captures: v5
        return UDim.new(0, v24(v5.Spacing["0.5"]))
    end)
    local v25 = v4:Text({ Text = "Vertical" })
    local v26 = {
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal
    }
    v26.ListPadding = v4:Computed(function(v27) -- line 134 | captures: v5
        return UDim.new(0, v27(v5.Spacing["0.5"]))
    end)
    v26[Children] = {
        v4:ProgressBar({
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Inverted = true,
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Inverted = true,
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Inverted = true,
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Inverted = true,
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        }),
        v4:ProgressBar({
            Inverted = true,
            Direction = Enum.FillDirection.Vertical,
            Progress = v6,
            Color = v7
        })
    }
    v23[Children] = {
        v25,
        v4:Frame(v26)
    }
    v9[Children] = {
        v13,
        v19,
        v22,
        v4:Frame(v23)
    }
    v4:Frame(v9)
end

v2.fusion = Fusion
return v2
