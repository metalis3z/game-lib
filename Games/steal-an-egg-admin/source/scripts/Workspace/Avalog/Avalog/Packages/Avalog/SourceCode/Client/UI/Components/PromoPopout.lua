-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local Manifest = require(Parent.SourceCode.Shared.Manifest)
local Children = Fusion.Children
return function(v1, v2) -- line 18 | captures: MarketplaceService, Players, OnyxUI, Fusion, Manifest, Children
    local v3 = Fusion.innerScope(v1, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = v3:EnsureValue(OnyxUI.Util.Fallback(v2.Open, false))
    local v6 = OnyxUI.Util.Fallback(v2.Link, "https://devforum.com")
    local v7 = OnyxUI.Util.Fallback(v2.Logo, "")
    local v8 = OnyxUI.Util.Fallback(v2.UpdateAvailable, false)
    local v9 = OnyxUI.Util.Fallback(v2.Color, v4.Colors.Neutral.Dark)
    local CombineProps = OnyxUI.Util.CombineProps
    local v10 = {
        Name = script.Name,
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListVerticalAlignment = Enum.VerticalAlignment.Center
    }
    v10.ListPadding = v3:Computed(function(v11) -- line 33 | captures: v4
        return UDim.new(0, v11(v4.Spacing["0.25"]))
    end)
    v10.BackgroundColor3 = v9
    v10.BackgroundTransparency = 0
    v10.CornerRadius = v3:Computed(function(v12) -- line 38 | captures: v4
        return UDim.new(0, v12(v4.CornerRadius.Full))
    end)
    v10.Padding = v3:Computed(function(v13) -- line 41 | captures: v4
        return UDim.new(0, v13(v4.Spacing["0.25"]))
    end)
    local v14 = {
        StrokeEnabled = true,
        Image = v7,
        ContentSize = v4.TextSize["1.25"]
    }
    v14.Color = v3:Computed(function(v15) -- line 49 | captures: v4, v8
        if v15(v8) then
            return v15(v4.Colors.Warning.Main)
        end
        return v15(v4.Colors.Neutral.Main)
    end)
    v14.ContentColor = v3:Computed(function(v16) -- line 56 | captures: v8, OnyxUI
        if v16(v8) then
            return OnyxUI.Util.Colors.Black
        end
        return OnyxUI.Util.Colors.White
    end)
    v14.PaddingLeft = v3:Computed(function(v17) -- line 63 | captures: v4
        return UDim.new(0, v17(v4.Spacing["0.5"]))
    end)
    v14.PaddingRight = v3:Computed(function(v18) -- line 66 | captures: v4
        return UDim.new(0, v18(v4.Spacing["0.5"]))
    end)
    v14.PaddingTop = v3:Computed(function(v19) -- line 69 | captures: v4
        return UDim.new(0, v19(v4.Spacing["0.5"]))
    end)
    v14.PaddingBottom = v3:Computed(function(v20) -- line 72 | captures: v4
        return UDim.new(0, v20(v4.Spacing["0.5"]))
    end)
    v14.CornerRadius = v3:Computed(function(v21) -- line 75 | captures: v4
        return UDim.new(0, v21(v4.CornerRadius.Full))
    end)
    v14.StrokeThickness = v4.StrokeThickness["1"]
    v14.StrokeColor = v4.Colors.Neutral.Dark

    function v14.OnActivated() -- line 82 | captures: v5, Fusion
        local v22 = Fusion.peek(v5)
        v5:set(not v22)
    end

    local v23 = v3:IconButton(v14)
    local v24 = {
        BackgroundColor3 = v4.Colors.Neutral.Main,
        BackgroundTransparency = 0
    }
    v24.CornerRadius = v3:Computed(function(v25) -- line 91 | captures: v4
        return UDim.new(0, v25(v4.CornerRadius.Full))
    end)
    v24.Scale = v3:Spring(v3:Computed(function(v26) -- line 95 | captures: v5
        if v26(v5) == true then
            return 1
        end
        return 0
    end), v4.SpringSpeed["2"], v4.SpringDampening["1.5"])
    v24.ListEnabled = true
    v24.ListFillDirection = Enum.FillDirection.Horizontal
    v24.ListVerticalAlignment = Enum.VerticalAlignment.Center
    v24.ListPadding = v3:Computed(function(v27) -- line 110 | captures: v4
        return UDim.new(0, v27(v4.Spacing["0.25"]))
    end)
    v24.Padding = v3:Computed(function(v28) -- line 113 | captures: v4
        return UDim.new(0, v28(v4.Spacing["0.5"]))
    end)
    v24.Visible = v5
    local v29 = v3:Button({
        Style = "Ghost",
        SizeVariant = "Small",
        Content = { (("Avalog %*"):format(Manifest.Version)) },
        Color = v4.Colors.BaseContent.Main,
        OnActivated = function() -- OnActivated | line 125 | captures: MarketplaceService, Players, Manifest
            MarketplaceService:PromptPurchase(Players.LocalPlayer, Manifest.AssetId)
        end
    })
    local v30 = {
        TextTransparency = 0,
        TextEditable = false,
        Disabled = true,
        StrokeEnabled = false
    }
    v30.Text = v3:Computed(function(v31) -- line 130 | captures: v6
        return (("%*"):format((v31(v6))))
    end)
    v30.TextColor3 = v4.Colors.Info.Main
    v30.PaddingLeft = UDim.new()
    v30.PaddingRight = UDim.new()
    v30.PaddingTop = UDim.new()
    v30.PaddingBottom = UDim.new()
    v24[Children] = {
        v29,
        v3:TextInput(v30)
    }
    v10[Children] = {
        v23,
        v3:Frame(v24)
    }
    return v3:Frame(CombineProps(v2, v10))
end
