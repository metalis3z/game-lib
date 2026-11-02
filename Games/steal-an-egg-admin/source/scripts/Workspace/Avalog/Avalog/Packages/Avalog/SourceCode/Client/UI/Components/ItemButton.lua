-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local CatalogItems = require(Parent.SourceCode.Client.UI.StateExtensions.CatalogItems)
local Future = require(Parent.Parent.Future)
local Children = Fusion.Children
local v1 = {}

v1[Enum.AvatarItemType.Asset] = Enum.InfoType.Asset
v1[Enum.AvatarItemType.Bundle] = Enum.InfoType.Bundle

local CustomButton = require(script.Parent.CustomButton)
return function(v2, v3) -- line 28 | captures: MarketplaceService, Players, OnyxUI, Fusion, States, ServiceProvider, CatalogItems, Future, Children, v1, CustomButton
    local v4 = Fusion.innerScope(v2, Fusion, OnyxUI.Util, OnyxUI.Components, { CustomButton = CustomButton })
    local v5 = OnyxUI.Themer.Theme:now()
    local v6 = ServiceProvider:GetAvatarManager()
    local v7 = v4:EnsureValue(OnyxUI.Util.Fallback(v3.Id, nil))
    local v8 = OnyxUI.Util.Fallback(v3.Type, Enum.AvatarItemType.Asset)
    local v9 = OnyxUI.Util.Fallback(v3.Owned, false)
    local v10 = OnyxUI.Util.Fallback(v3.Featured, false)
    local v11 = v4:Value(nil)

    local function UpdateItemInfo() -- line 41 | captures: v7, v8, v11, Fusion, CatalogItems, v1
        local v12 = Fusion.peek(v7)
        local v13 = Fusion.peek(v8)
        task.spawn(function() -- line 45 | captures: v12, v13, v11, CatalogItems, v1
            local v14 = CatalogItems:GetItem(v12, v1[v13])
            if v14 then
                v11:set(v14)
            end
        end)
    end

    v4:Observer(v7):onChange(function() -- line 52 | captures: v7, v8, v11, Fusion, CatalogItems, v1
        local v15 = Fusion.peek(v7)
        local v16 = Fusion.peek(v8)
        task.spawn(function() -- line 45 | captures: v15, v16, v11, CatalogItems, v1
            local v17 = CatalogItems:GetItem(v15, v1[v16])
            if v17 then
                v11:set(v17)
            end
        end)
    end)
    local v18 = Fusion.peek(v7)
    local v19 = Fusion.peek(v8)
    task.spawn(function() -- line 45 | captures: v11, v18, v19, CatalogItems, v1
        local v20 = CatalogItems:GetItem(v18, v1[v19])
        if v20 then
            v11:set(v20)
        end
    end)
    local v21 = v4:Computed(function(v22) -- line 57 | captures: v7, v11
        local v23 = v22(v11)
        local v24 = v22(v7)
        return v23 or
        {
            Name = "Name",
            Price = 0,
            Offsale = false,
            Id = v24,
            Type = Enum.AvatarItemType.Asset,
            AssetType = Enum.AvatarAssetType.Hat
        }
    end)
    local v25 = v4:Computed(function(v26) -- line 74 | captures: v6, v7, v21, States
        local v27 = v26(States.Avatar.AssetIds)
        local v28 = v26(v7)
        local v29 = v26(v21)
        if v29.AssetType == Enum.AvatarAssetType.EmoteAnimation and v6.HumanoidDescriber then
            return v6.HumanoidDescriber:GetEquippedEmote(v29.Name) ~= nil
        end
        return table.find(v27, v28) ~= nil
    end)
    local v30 = v4:Value(Fusion.peek(v25))
    v4:Observer(v25):onChange(function() -- line 87 | captures: v25, v30, Fusion
        v30:set(Fusion.peek(v25))
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v31 = {
        Name = script.Name,
        StrokeEnabled = v25,
        StrokeThickness = v5.StrokeThickness["2"],
        StrokeColor = v5.Colors.Primary.Main,
        ListEnabled = false
    }

    function v31.OnActivated() -- line 98 | captures: v6, v11, Fusion
        local v32 = Fusion.peek(v11)
        if v32 then
            v6:ToggleCatalogItem(v32)
        end
    end

    local v33 = {
        Name = "Details",
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Vertical,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v33.ListPadding = v4:Computed(function(v34) -- line 112 | captures: v5
        return UDim.new(0, v34(v5.Spacing["0.5"]))
    end)
    v33.Padding = v4:Computed(function(v35) -- line 115 | captures: v5
        return UDim.new(0, v35(v5.Spacing["0.5"]))
    end)
    v33.Size = UDim2.fromScale(1, 0)
    local v36 = { BackgroundTransparency = 1 }
    v36.Image = v4:Computed(function(v37) -- line 123 | captures: v21
        local v38 = v37(v21)
        local v39 = {}
        v39[Enum.AvatarItemType.Bundle] = "BundleThumbnail"
        v39[Enum.AvatarItemType.Asset] = "Asset"
        return (("rbxthumb://id=%*&type=%*&w=150&h=150"):format(v38.Id, v39[v38.Type] or "Asset"))
    end)
    v36.ScaleType = Enum.ScaleType.Fit
    v36.CornerRadius = v4:Computed(function(v40) -- line 133 | captures: v5
        return UDim.new(0, v40(v5.CornerRadius["1"]))
    end)
    v36.Size = v4:Computed(function(v41) -- line 136 | captures: v5
        local v42 = v41(v5.TextSize["1"]) * 5
        return UDim2.fromOffset(v42, v42)
    end)
    local v43 = v4:Image(v36)
    local v44 = {
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Vertical,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    }
    v44.ListPadding = v4:Computed(function(v45) -- line 145 | captures: v5
        return UDim.new(0, v45(v5.Spacing["0.5"]))
    end)
    local v46 = {
        ClipsDescendants = true,
        RichText = false,
        AutoLocalize = false
    }
    v46.Text = v4:Computed(function(v47) -- line 151 | captures: v21
        return v47(v21).Name
    end)
    v46.Size = v4:Computed(function(v48) -- line 155 | captures: v5
        return UDim2.fromOffset(0, v48(v5.TextSize["1"]) * 2)
    end)
    v46.AutomaticSize = Enum.AutomaticSize.None
    local v49 = v4:Text(v46)
    local v50 = {
        ListWraps = false,
        ContentWrapped = false,
        AutoLocalize = false
    }
    v50.Content = v4:Computed(function(v51) -- line 164 | captures: v11
        local v52 = v51(v11)
        if not (v52 and v52.Price) then
            return { "Offsale" }
        end
        return {
            "rbxassetid://102562927562320",
            v52.Price
        }
    end)
    v50.ListPadding = v4:Computed(function(v53) -- line 175 | captures: v5
        return UDim.new(0, v53(v5.Spacing["0.25"]))
    end)
    v44[Children] = {
        v49,
        v4:IconText(v50)
    }
    v33[Children] = {
        v43,
        v4:Frame(v44)
    }
    local v54 = v4:Frame(v33)
    local v55 = {
        Content = { "Buy" },
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromScale(1, 0),
        Color = OnyxUI.Util.Colors.Green["500"]
    }
    v55.Scale = v4:Spring(v4:Computed(function(v56) -- line 193 | captures: v9, v25
        local v57 = v56(v25)
        local v58 = v56(v9)
        if not v57 or v58 then
            return 0
        end
        return 1
    end), v5.SpringSpeed["2"], v5.SpringDampening["1.5"])

    function v55.OnActivated() -- line 207 | captures: v7, MarketplaceService, Players, Fusion, Future
        Future.Try(function() -- line 208 | captures: v7, MarketplaceService, Players, Fusion
            local v59 = Fusion.peek(v7)
            return MarketplaceService:PromptPurchase(Players.LocalPlayer, v59)
        end)
    end

    local v60 = v4:Button(v55)
    v31[Children] = {
        v54,
        v60,
        v4:Computed(function(v61) -- line 215 | captures: v4, v5, v10
            if v61(v10) then
                return v4:Icon({
                    Image = "rbxassetid://13850331560",
                    Size = v4:Computed(function(v62) -- line 219 | captures: v5
                        return UDim2.fromOffset(v62(v5.TextSize["1.25"]), v62(v5.TextSize["1.25"]))
                    end)
                })
            end
        end)
    }
    return v4:CustomButton(CombineProps(v3, v31))
end
