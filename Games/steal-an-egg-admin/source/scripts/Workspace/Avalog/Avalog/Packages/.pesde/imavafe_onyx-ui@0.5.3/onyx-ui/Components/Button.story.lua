-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local scoped = Fusion.scoped
local Children = Fusion.Children
local v1 = {
    Button = require(script.Parent.Button),
    Frame = require(script.Parent.Frame),
    Divider = require(script.Parent.Divider)
}
local v2 = {}

function v2.story(v3) -- line 19 | captures: Fusion, Themer, Children, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = {
        Parent = v3.target,
        ListEnabled = true
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 26 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0.5"]))
    end)
    v6.Padding = v4:Computed(function(v8) -- line 29 | captures: v5
        return UDim.new(0, v8(v5.StrokeThickness["1"]))
    end)
    local v9 = v4:Button({ Content = { "Button" } })
    local v10 = v4:Button({
        Content = { "Button" },
        Color = v5.Colors.Primary.Main
    })
    local v11 = v4:Button({
        Style = "Outlined",
        Content = { "Button" },
        Color = v5.Colors.Primary.Main
    })
    local v12 = v4:Button({
        Content = { "rbxassetid://11560341132", "Purchase" },
        Color = Color3.fromRGB(86, 255, 70)
    })
    local v13 = v4:Button({
        Style = "Outlined",
        Content = { "rbxassetid://13405228418", "Delete" },
        Color = v5.Colors.Error.Main
    })
    local v14 = v4:Button({
        Style = "Ghost",
        Content = { "Ghost" },
        Color = v5.Colors.BaseContent.Main
    })
    local v15 = v4:Button({
        Disabled = true,
        Content = { "rbxassetid://11560341132", "Bobux" },
        Color = Color3.fromRGB(86, 255, 70)
    })
    local v16 = v4:Button({
        Disabled = true,
        Style = "Outlined",
        Content = { "Testing" },
        Color = Color3.fromRGB(86, 255, 70)
    })
    local v17 = v4:Divider({})
    local v18 = {
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v18.Padding = v4:Computed(function(v19) -- line 76 | captures: v5
        return UDim.new(0, v19(v5.Spacing["1"]))
    end)
    v18[Children] = {
        v4:Button({
            SizeVariant = "ExtraSmall",
            Content = { "Button (xs)" },
            Color = v5.Colors.Primary.Main
        }),
        v4:Button({
            SizeVariant = "Small",
            Content = { "Button (sm)" },
            Color = v5.Colors.Primary.Main
        }),
        v4:Button({
            SizeVariant = "Medium",
            Content = { "Button (md)" },
            Color = v5.Colors.Primary.Main
        }),
        v4:Button({
            SizeVariant = "Large",
            Content = { "Button (lg)" },
            Color = v5.Colors.Primary.Main
        }),
        v4:Button({
            SizeVariant = "ExtraLarge",
            Content = { "Button (xl)" },
            Color = v5.Colors.Primary.Main
        })
    }
    v6[Children] = {
        v9,
        v10,
        v11,
        v12,
        v13,
        v14,
        v15,
        v16,
        v17,
        v4:Frame(v18)
    }
    v4:Frame(v6)
end

v2.fusion = Fusion
return v2
