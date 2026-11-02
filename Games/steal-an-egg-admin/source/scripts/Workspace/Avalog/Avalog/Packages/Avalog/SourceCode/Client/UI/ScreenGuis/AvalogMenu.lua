-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local Manifest = require(Parent.SourceCode.Shared.Manifest)
local PromoPopout = require(script.Parent.Parent.Components.PromoPopout)
local CatalogMenu = require(script.Parent.Parent.Components.CatalogMenu)
local AvatarViewport = require(script.Parent.Parent.Components.AvatarViewport)
local Children = Fusion.Children
return function(v1, v2) -- line 17 | captures: OnyxUI, Fusion, States, ServiceProvider, Manifest, PromoPopout, CatalogMenu, AvatarViewport, Children
    local v3 = Fusion.innerScope(v1, OnyxUI.Util, OnyxUI.Components, {
        CatalogMenu = CatalogMenu,
        AvatarViewport = AvatarViewport,
        PromoPopout = PromoPopout
    })
    local v4 = OnyxUI.Themer.Theme:now()
    local v5 = ServiceProvider:GetAvatarManager()
    local ScreenGui = v3:New("ScreenGui")
    local v6 = {
        Name = script.Name,
        Parent = v2.Parent,
        DisplayOrder = 9,
        Enabled = States.Open
    }
    local ScreenGui_2 = v3:New("ScreenGui")
    local v7 = {
        Name = "Backdrop",
        DisplayOrder = 8,
        ScreenInsets = Enum.ScreenInsets.None
    }
    v7[Children] = {
        v3:Frame({
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = v4.Colors.Base.Main,
            BackgroundTransparency = v3:Spring(v3:Computed(function(v8) -- line 46 | captures: States
                if v8(States.Open) then
                    return 0
                end
                return 1
            end), v4.SpringSpeed["1.5"], v4.SpringDampening["1.5"]),
            Active = States.Open,
            Interactable = States.Open
        })
    }
    local v9 = ScreenGui_2(v7)
    local v10 = {
        Name = "Menu",
        AnchorPoint = Vector2.new(0.5, 0.5)
    }
    v10.Position = v3:Spring(v3:Computed(function(v11) -- line 61 | captures: v4, States
        if v11(States.Open) then
            return UDim2.fromScale(0.5, 0.5)
        end
        return UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(0, v11(v4.Spacing["4"]))
    end), v4.SpringSpeed["0.5"], v4.SpringDampening["1.5"])
    v10.Size = UDim2.fromScale(1, 1)
    v10.AutomaticSize = Enum.AutomaticSize.None
    v10.ListEnabled = true
    v10.ListFillDirection = Enum.FillDirection.Horizontal
    v10.ListVerticalFlex = Enum.UIFlexAlignment.Fill
    v10.ListHorizontalFlex = Enum.UIFlexAlignment.Fill
    v10.ListPadding = v3:Computed(function(v12) -- line 77 | captures: v4
        return UDim.new(0, v12(v4.Spacing["0"]))
    end)
    v10.Active = States.Open
    v10.Interactable = States.Open
    local v13 = {}

    function v13.OnExit() -- line 85 | captures: v5, Fusion, States
        v5:UpdateServer(Fusion.peek(States.Avatar.Data))
        States.Open:set(false)
    end

    v10[Children] = {
        v3:CatalogMenu(v13),
        v3:AvatarViewport({})
    }
    local v14 = v3:Frame(v10)
    local v15 = {
        Link = "devforum.roblox.com/t/3513102",
        Logo = "rbxassetid://109049301067448",
        UpdateAvailable = v3:Computed(function(v16) -- line 97 | captures: States, Manifest
            return Manifest.Version ~= v16(States.CloudConfig).latestVersion
        end),
        AnchorPoint = Vector2.new(0, 1)
    }
    v15.Position = v3:Computed(function(v17) -- line 101 | captures: v4
        return UDim2.fromScale(0, 1) + UDim2.fromOffset(v17(v4.Spacing["1"]), -v17(v4.Spacing["1"]))
    end)
    v6[Children] = {
        v9,
        v14,
        v3:PromoPopout(v15)
    }
    return ScreenGui(v6)
end
