-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Categories = require(Parent.SourceCode.Shared.Categories)
local AvatarAssetTypes = require(Parent.SourceCode.Shared.AvatarAssetTypes)
local Children = Fusion.Children

if RunService:IsStudio() and Categories.Marketplace[1].Name ~= "Featured" then
    local Marketplace = Categories.Marketplace
    local v1 = {
        Name = "Featured",
        CategoryFilter = Enum.CatalogCategoryFilter.Recommended,
        AssetTypes = AvatarAssetTypes.Types.All,
        BundleTypes = {
            Enum.BundleType.Animations,
            Enum.BundleType.BodyParts,
            Enum.BundleType.DynamicHead,
            Enum.BundleType.DynamicHeadAvatar,
            Enum.BundleType.Shoes
        }
    }
    table.insert(Marketplace, 1, v1)
end
return function(v2, v3) -- line 34 | captures: OnyxUI, Fusion, States, Children
    local v4 = Fusion.innerScope(v2, Fusion, OnyxUI.Util, OnyxUI.Components, {
        CategoryBar = require(script.Parent.CategoryBar),
        NavigationBar = require(script.Parent.NavigationBar),
        TabDisplay = require(script.Parent.TabDisplay)
    })
    local v5 = OnyxUI.Themer.Theme:now()
    local CombineProps = OnyxUI.Util.CombineProps
    local v6 = {
        Name = "CatalogMenu",
        BackgroundTransparency = 0,
        BackgroundColor3 = v5.Colors.Base.Main,
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v6.ListPadding = v4:Computed(function(v7) -- line 48 | captures: v5
        return UDim.new(0, v7(v5.Spacing["0"]))
    end)
    local v8 = v4:NavigationBar({ OnExit = v3.OnExit })
    local v9 = v4:CategoryBar({})
    v6[Children] = {
        v8,
        v9,
        v4:Computed(function(v10, v11) -- line 57 | captures: v5, OnyxUI, States
            if v10(States.Open) then
                return OnyxUI.Themer.Theme:is(v5):during(function() -- line 60 | captures: v11
                    return v11:TabDisplay({})
                end)
            end
        end)
    }
    return v4:Frame(CombineProps(v3, v6))
end
