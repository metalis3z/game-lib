-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local OnyxUI = require(Parent.Parent.OnyxUI)
local Fusion = require(Parent.Parent.Fusion)
local States = require(Parent.SourceCode.Client.UI.States)
local ServiceProvider = require(Parent.SourceCode.Client.ServiceProvider)
local Navigation = require(Parent.SourceCode.Client.UI.StateExtensions.Navigation)
local v1 = require(Parent.Config):Get()
local Children = Fusion.Children
return function(v2, v3) -- line 18 | captures: MarketplaceService, RunService, OnyxUI, Fusion, States, ServiceProvider, Navigation, v1, Children
    local v4 = Fusion.innerScope(v2, Fusion, OnyxUI.Util, OnyxUI.Components)
    local v5 = OnyxUI.Themer.Theme:now()
    local v6 = ServiceProvider:GetAvatarManager()
    local v7 = v4:New("Camera")({
        CFrame = CFrame.lookAt(Vector3.new(4, 0, -8), (Vector3.new(0, 0, 0))),
        CameraType = Enum.CameraType.Scriptable
    })
    local v8 = 0
    local v9 = false
    local v10 = Vector2.new()
    local v11 = v4:New("UIDragDetector")({ DragStyle = Enum.UIDragDetectorDragStyle.Scriptable })
    v11.DragStart:Connect(function(v12) -- line 37 | captures: v9, v10
        v9 = true
        v10 = v12
    end)
    v11.DragEnd:Connect(function() -- line 41 | captures: v9
        v9 = false
    end)
    v11.DragContinue:Connect(function(v13) -- line 44 | captures: v8, v10
        v8 += (v13 - v10).X / 50
        v10 = v13
    end)
    RunService.RenderStepped:Connect(function(v14) -- line 49 | captures: v8, v9, v7
        if not v9 then
            v8 += v14 * 0.5235987755982988
        end
        local lookAt = CFrame.lookAt
        local v15 = v8
        local v16 = math.cos(v15) * 8
        local v17 = v8
        local v18 = math.sin(v17) * 8
        v7.CFrame = lookAt(Vector3.new(v16, 0, v18), (Vector3.new(0, 0, 0)))
    end)
    local CombineProps = OnyxUI.Util.CombineProps
    local v19 = {
        Name = script.Name,
        MaxSize = v4:Computed(function(v20) -- line 62 | captures: States
            local v21 = v20(States.Screen.Resolution)
            if v21.X < 800 then
                return Vector2.new(v21.X / 2.5, (1/0))
            end
            if v21.X > 1000 then
                return Vector2.new(v21.X / 3, (1/0))
            end
            return Vector2.new(384, (1/0))
        end),
        BackgroundTransparency = 0,
        BackgroundColor3 = v5.Colors.Base.Dark,
        Image = "rbxassetid://140363116814273",
        ScaleType = Enum.ScaleType.Crop,
        AutomaticSize = Enum.AutomaticSize.X,
        ListEnabled = true,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        ListVerticalFlex = Enum.UIFlexAlignment.Fill
    }
    local v22 = { Name = "Contents" }
    v22.Padding = v4:Computed(function(v23) -- line 85 | captures: v5
        return UDim.new(0, v23(v5.Spacing["0.25"]))
    end)
    v22.AutomaticSize = Enum.AutomaticSize.None
    local ViewportFrame = v4:New("ViewportFrame")
    local v24 = {
        Name = "Viewport",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        CurrentCamera = v7
    }
    v24[Children] = {
        v4:New("WorldModel")({
            [Children] = {
                v7,
                v4:Computed(function(v25) -- line 104 | captures: RunService, States
                    local v26 = v25(States.Avatar.Character)
                    if RunService:IsRunning() then
                        return v26
                    end
                    return nil
                end)
            }
        })
    }
    local v27 = ViewportFrame(v24)
    local v28 = {
        Name = "Controls",
        Size = UDim2.fromScale(1, 1),
        ListEnabled = true,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
        ListVerticalFlex = Enum.UIFlexAlignment.SpaceBetween
    }
    local v29 = {
        Name = "TopControls",
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center
    }
    v29.ListPadding = v4:Computed(function(v30) -- line 131 | captures: v5
        return UDim.new(0, v30(v5.Spacing["0.5"]))
    end)
    v29.CornerRadius = v4:Computed(function(v31) -- line 134 | captures: v5
        return UDim.new(0, v31(v5.CornerRadius["2"]))
    end)
    v29.Padding = v4:Computed(function(v32) -- line 137 | captures: v5
        return UDim.new(0, v32(v5.Spacing["0.5"]))
    end)
    v29.BackgroundColor3 = v5.Colors.Base.Main
    local v33 = {
        Name = "CheckoutButton",
        SizeVariant = "Large",
        Content = { "rbxassetid://13846738861", "Buy" },
        Disabled = States.Checkout.Loading
    }

    function v33.OnActivated() -- line 149 | captures: v6, MarketplaceService, States
        States.Checkout.Loading:set(true)
        local v34 = v6:GetUnownedItems()
        States.Checkout.Loading:set(false)
        local v35 = #v34 > 0
        local v36
        if v35 then
            v36 = v6:PromptCheckout(v34)
        else
            v6:SaveAvatar()
        end
        if (not v35 or v36) and v35 then
            MarketplaceService.PromptBulkPurchaseFinished:Once(function(v37, v38) -- line 158 | captures: v6
                if v38 == Enum.MarketplaceBulkPurchasePromptStatus.Completed then
                    task.wait(0.5)
                    v6:SaveAvatar()
                end
            end)
        end
    end

    local v39 = v4:Button(v33)
    local v40 = {
        SizeVariant = "Large",
        Content = { "rbxassetid://13846852950", "Done" },
        Color = v5.Colors.Success.Main,
        Visible = v1.AvatarSavingAllowed
    }

    function v40.OnActivated() -- line 180 | captures: v6, Fusion, States
        v6:UpdateServer(Fusion.peek(States.Avatar.Data))
        States.Open:set(false)
    end

    v29[Children] = {
        v39,
        v4:Button(v40)
    }
    local v41 = v4:Card(v29)
    local v42 = {
        Name = "BottomControls",
        ListEnabled = true,
        ListFillDirection = Enum.FillDirection.Horizontal,
        ListHorizontalFlex = Enum.UIFlexAlignment.Fill,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center
    }
    v42.ListPadding = v4:Computed(function(v43) -- line 194 | captures: v5
        return UDim.new(0, v43(v5.Spacing["0.75"]))
    end)
    v42.CornerRadius = v4:Computed(function(v44) -- line 197 | captures: v5
        return UDim.new(0, v44(v5.CornerRadius["2"]))
    end)
    v42.Padding = v4:Computed(function(v45) -- line 200 | captures: v5
        return UDim.new(0, v45(v5.Spacing["0.5"]))
    end)
    v42.BackgroundColor3 = v5.Colors.Base.Main
    local v46 = {
        SizeVariant = "Large",
        Content = { "rbxassetid://13846120661" },
        Disabled = v4:Computed(function(v47) -- line 209 | captures: States, Navigation
            local v48 = v47(States.Avatar.DataHistory)
            local v49 = v47(Navigation.Category)
            if #v48 <= 1 then
                return true
            end
            return v49.Name == "Equipped"
        end)
    }

    function v46.OnActivated() -- line 215 | captures: v6
        v6:Undo()
    end

    local v50 = v4:Button(v46)
    local v51 = {
        SizeVariant = "Large",
        Content = { "rbxassetid://13847364382" },
        Color = v5.Colors.Error.Main
    }

    function v51.OnActivated() -- line 224 | captures: v6
        v6:Reset()
    end

    local v52 = v4:Button(v51)
    local v53 = {
        SizeVariant = "Large",
        Content = { "rbxassetid://13846158505" },
        Disabled = v4:Computed(function(v54) -- line 231 | captures: States, Navigation
            local v55 = v54(States.Avatar.UndoHistory)
            local v56 = v54(Navigation.Category)
            if #v55 == 0 then
                return true
            end
            return v56 == "Equipped"
        end)
    }

    function v53.OnActivated() -- line 237 | captures: v6
        v6:Redo()
    end

    v42[Children] = {
        v50,
        v52,
        v4:Button(v53)
    }
    v28[Children] = {
        v41,
        v4:Card(v42)
    }
    v22[Children] = {
        v11,
        v27,
        v4:Frame(v28)
    }
    v19[Children] = { v4:Frame(v22) }
    return v4:Image(CombineProps(v3, v19))
end
