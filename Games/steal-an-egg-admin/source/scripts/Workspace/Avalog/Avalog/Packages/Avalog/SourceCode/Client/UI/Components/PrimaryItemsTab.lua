-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local Sift = require(Parent.Parent.Sift)
local v1 = require(Parent.Config):Get()
local v2 = not RunService:IsStudio() and game.CreatorId ~= Players.LocalPlayer.UserId
local v3

function v3(v4) -- line 14 | captures: Sift, v3
    return Sift.Dictionary.map(v4, function(v5, v6) -- line 15 | captures: v3
        local v7
        if typeof(v5) == "table" then
            v7 = v3(v5)
        else
            v7 = v5
        end
        local v8
        if typeof(v6) == "string" then
            v8 = v6:gsub("(%l)(%w*)", function(v9, v10) -- line 20
                return v9:upper() .. v10
            end)
        else
            v8 = v6
        end
        return v7, v8
    end)
end

local Children = Fusion.Children
local CatalogItemsTab = require(script.Parent.CatalogItemsTab)
return function(v11, v12) -- line 35 | captures: OnyxUI, Fusion, States, Sift, v1, Children, CatalogItemsTab, v2
    local v13 = Fusion.innerScope(v11, Fusion, OnyxUI.Util, OnyxUI.Components, {
        ItemButton = require(script.Parent.ItemButton),
        CatalogItemsTab = CatalogItemsTab,
        CustomButton = require(script.Parent.CustomButton)
    })
    local v14 = OnyxUI.Themer.Theme:now()
    local v15 = v13:Computed(function(v16) -- line 43 | captures: States
        return v16(States.CloudConfig).latestVersion ~= "0.0.0"
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v17 = {
        Name = script.Name,
        PrefixItems = v13:Computed(function(v18) -- line 49 | captures: States, Sift, v1, v2
            if v2 then
                local pinnedItems = v18(States.CloudConfig).pinnedItems
                for v19, v20 in pinnedItems do
                    local itemId = v20.itemId
                    v20.Id = tonumber(itemId)
                    v20.ItemType = v20.itemType
                end
                return Sift.Array.map(Sift.Array.merge(v1.Featured.Items, pinnedItems), function(v21) -- line 58
                    v21.Featured = true
                    return v21
                end)
            end
            return {}
        end),
        LoadItems = v15
    }
    local v22 = v13:Computed(function(v23) -- line 69 | captures: v13, v14, v15, Children
        if v23(v15) then
            return
        end
        local v24 = {
            BackgroundColor3 = v14.Colors.Neutral.Main,
            ListEnabled = true,
            CornerRadius = v13:Computed(function(v25) -- line 79 | captures: v14
                return UDim.new(0, v25(v14.CornerRadius["1.5"]))
            end)
        }
        v24[Children] = {
            v13:Text({ Text = "Avalog requires access to HTTP requests to function properly." }),
            v13:TextInput({
                Text = "https://devforum.roblox.com/t/3513102/71",
                TextTransparency = 0,
                TextEditable = false,
                Color = v14.Colors.BaseContent.Main
            })
        }
        return v13:Card(v24)
    end)
    v17[Children] = {
        v22,
        v13:Computed(function(v26) -- line 96 | captures: v13, v14, States, Children, v2
            if not v2 then
                return
            end
            local v27 = {
                AutomaticSize = Enum.AutomaticSize.Y,
                Visible = States.Featured.MessageShown,
                ListHorizontalAlignment = Enum.HorizontalAlignment.Left,
                OnActivated = function() -- OnActivated | line 103 | captures: States
                    States.Featured.MessageShown:set(false)
                end
            }
            v27[Children] = {
                v13:IconText({
                    Content = { "rbxassetid://13850331560", "Contains exclusive, curated, and sponsored listings." },
                    ListPadding = v13:Computed(function(v28) -- line 113 | captures: v14
                        return UDim.new(0, v28(v14.Spacing["0.5"]))
                    end),
                    ListVerticalAlignment = Enum.VerticalAlignment.Center
                })
            }
            return v13:CustomButton(v27)
        end)
    }
    return v13:CatalogItemsTab(CombineProps(v12, v17))
end
