-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Assets = require(ReplicatedStorage.Data.Assets)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = UDim2.fromScale(0.5, 0.5)
local v2 = Vector2.new(0.5, 0.5)
local v3 = UDim2.fromScale(1, 1)
UDim2.fromScale(0.77, 0.77)
UDim2.fromScale(0.85, 0.85)
local v4 = UDim2.fromScale(0, 0)
local v5 = Color3.fromRGB(0, 0, 0)
local v6 = {
    0.5,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
}
local v7 = {
    0.6,
    Enum.EasingStyle.Elastic,
    Enum.EasingDirection.Out
}
local v8 = t.strict(t.instanceIsA("ImageLabel"))
local v9 = t.strict(t.string)
local v10 = t.strict(t.Color3)
local v11 = t.strict(t.number)
local v12 = t.strict(t.instanceIsA("GuiObject"))
local v13 = t.strict(t.optional(t.callback))
local v14 = {}

local function carries(v15, v16) -- line 31
    if v15.BaseMutation == v16 then
        return true
    end
    return table.find(v15.Mutations, v16) ~= nil
end

local function zoomFor(v17) -- line 35
    return 1, nil
end

local function iconFor(v18, v19) -- line 38 | captures: Mutations
    local MutationIcons = v18.MutationIcons
    if MutationIcons ~= nil then
        local v20 = Mutations.Ids()
        for v21, v22 in {
                v20.Golden,
                v20.Silver
            } do
            if (v19.BaseMutation == v22 or table.find(v19.Mutations, v22) ~= nil) and MutationIcons[v22] ~= nil then
                return MutationIcons[v22]
            end
        end
    end
    return v18.Icon or ""
end

local function imagesFor(v23, v24) -- line 57 | captures: Mutations, iconFor
    local v25 = iconFor(v23, v24)
    local v26 = { Icon = v25 }
    local Rainbow = Mutations.Ids().Rainbow
    if v24.BaseMutation == Rainbow or table.find(v24.Mutations, Rainbow) ~= nil then
        v26.RainbowOverlay = v23.WhiteImage or v25
    else
        v26.RainbowOverlay = nil
    end
    return v26
end

local function stretchBy(v27, v28, v29) -- line 71
    return UDim2.new(v27.X.Scale * v28, v27.X.Offset * v28, v27.Y.Scale * v29, v27.Y.Offset * v29)
end

local function makeCanvas(v30, v31, v32, v33) -- line 74 | captures: v1, v2
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = v30
    CanvasGroup.Size = v31
    CanvasGroup.Position = v1
    CanvasGroup.AnchorPoint = v2
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.ClipsDescendants = true
    CanvasGroup.ZIndex = v32
    CanvasGroup.Parent = v33
    return CanvasGroup
end

local function makeZoomedImage(v34, v35, v36, v37, v38) -- line 86 | captures: v1, v2
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = v34
    ImageLabel.Image = v35
    ImageLabel.Size = UDim2.fromScale(v36, v36)
    ImageLabel.Position = v1 + v37
    ImageLabel.AnchorPoint = v2
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.ZIndex = v38
    return ImageLabel
end

function v14.OverlayRainbow(v39, v40) -- line 98 | captures: Rarity, v1, v2, v3, v8, v9
    v8(v39)
    v9(v40)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "RainbowOverlayImage"
    ImageLabel.Image = v40
    ImageLabel.ImageTransparency = 0.5
    ImageLabel.Size = v3
    ImageLabel.Position = v1
    ImageLabel.AnchorPoint = v2
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.ZIndex = v39.ZIndex + 1
    ImageLabel.Parent = v39
    Rarity.Rarities.Rainbow.RarityGradient:Clone().Parent = ImageLabel
    return ImageLabel
end

function v14.Strip(v41) -- line 115 | captures: v8
    v8(v41)
    local RainbowOverlayImage = v41:FindFirstChild("RainbowOverlayImage")
    if RainbowOverlayImage and RainbowOverlayImage:IsA("ImageLabel") then
        RainbowOverlayImage:Destroy()
    end
    local AssetIconShapeLayer = v41:FindFirstChild("AssetIconShapeLayer")
    if AssetIconShapeLayer ~= nil then
        AssetIconShapeLayer:Destroy()
    end
    v41.ImageTransparency = 0
end

function v14.Tint(v42, v43, v44) -- line 127 | captures: v5, v8, v10, v11
    v8(v42)
    v10(v43)
    v11(v44)
    v42.ImageColor3 = v43
    v42.ImageTransparency = v44
    local AssetIconShapeLayer = v42:FindFirstChild("AssetIconShapeLayer")
    if AssetIconShapeLayer ~= nil then
        local v45 = if v43 == v5 then v43 else v5
        for v46, v47 in AssetIconShapeLayer:GetDescendants() do
            if v47:IsA("ImageLabel") then
                v47.ImageTransparency = v44
                if v47.Name == "IconStrokeImage" then
                    v47.ImageColor3 = v45
                else
                    v47.ImageColor3 = v43
                end
            end
        end
    end
end

function v14.ResolveImages(v48) -- line 156 | captures: AssetItem, Assets, imagesFor
    local function v49(...)
        assert(...)
    end

    v49(AssetItem.AssetItemData(v48))
    local v50 = Assets.Directory[v48.Category]
    local v51 = v50 ~= nil
    local v52 = ("no asset directory entry for category %*"):format(v48.Category)
    assert(v51, v52)
    return (imagesFor(v50, v48))
end

function v14.Paint(v53, v54) -- line 163 | captures: AssetItem, Assets, v4, v8, v14, imagesFor
    local function v55(...)
        assert(...)
    end

    v8(v53)
    v55(AssetItem.AssetItemData(v54))
    local v56 = Assets.Directory[v54.Category]
    local v57 = v56 ~= nil
    local v58 = ("no asset directory entry for category %*"):format(v54.Category)
    assert(v57, v58)
    local v59 = imagesFor(v56, v54)
    local Icon = v59.Icon
    assert(v4, "the icon zoom offset fell through its own default")
    v14.Strip(v53)
    v53.BackgroundTransparency = 1
    v53.ScaleType = Enum.ScaleType.Fit
    v53.Image = Icon
    v53.ImageTransparency = 0
    if v59.RainbowOverlay ~= nil then
        v14.OverlayRainbow(v53, v59.RainbowOverlay)
    end
end

function v14.WireHoverSquash(v60, v61, v62) -- line 246 | captures: Trove, Tween, v6, v7, v8, v12, v13
    v12(v60)
    v8(v61)
    v13(v62)
    local Size = v61.Size
    local v63 = Trove.new()
    local v64

    local function applyScaleType(v65) -- line 253 | captures: v61
        v61.ScaleType = v65
        for v66, v67 in v61:GetDescendants() do
            if v67:IsA("ImageLabel") then
                v67.ScaleType = v65
            end
        end
    end

    local function snapTo(v68) -- line 261 | captures: v64, v61, Size, applyScaleType
        local v69 = v64
        if v69 then
            v69:Cancel()
            v69:Destroy()
            v64 = nil
        end
        if not v61 then
            return
        end
        local v70 = v68 or Size
        if v70 then
            v61.Size = v70
        end
        applyScaleType(Enum.ScaleType.Fit)
    end

    local function relax(v71) -- line 280 | captures: v64, v61, Size, applyScaleType, Tween, v7
        if v61 then
            if Size then
                if v71 == false then
                    local v72 = v64
                    if v72 then
                        v72:Cancel()
                        v72:Destroy()
                        v64 = nil
                    end
                    if v61 then
                        local v73 = Size or Size
                        if v73 then
                            v61.Size = v73
                        end
                        applyScaleType(Enum.ScaleType.Fit)
                    end
                else
                    local v74 = v64
                    if v74 then
                        v74:Cancel()
                        v74:Destroy()
                        v64 = nil
                    end
                    local v75 = Tween(v61, { Size = Size }, v7)
                    assert(v75, "the spring-back tween was not created")
                    v64 = v75
                    v75.Completed:Once(function(v76) -- line 309 | captures: v64, applyScaleType
                        if v76 ~= Enum.PlaybackState.Cancelled then
                            applyScaleType(Enum.ScaleType.Fit)
                            v64 = nil
                        end
                    end)
                    v75:Play()
                end
            end
        else
            local v77 = v64
            if v77 then
                v77:Cancel()
                v77:Destroy()
                v64 = nil
            end
            if v61 then
                if Size then
                    v61.Size = Size
                end
                applyScaleType(Enum.ScaleType.Fit)
            end
        end
    end

    v63:Add(function() -- line 339 | captures: v64
        local v78 = v64
        if not v78 then
            return
        end
        v78:Cancel()
        v78:Destroy()
        v64 = nil
    end)
    v63:Connect(v60.MouseEnter, function() -- line 347 | captures: v64, v61, v62, Size, applyScaleType, Tween, v6
        if v61 then
            if v62 then
                if v62() then
                    local v79 = v64
                    if v79 then
                        v79:Cancel()
                        v79:Destroy()
                        v64 = nil
                    end
                    applyScaleType(Enum.ScaleType.Stretch)
                    local v80 = {}
                    v80.Size = UDim2.new(Size.X.Scale * 1.2, Size.X.Offset * 1.2, Size.Y.Scale * 0.43, Size.Y.Offset * 0.43)
                    local v81 = Tween(v61, v80, v6)
                    assert(v81, "the squash tween was not created")
                    v64 = v81
                    v81:Play()
                end
            else
                local v82 = v64
                if v82 then
                    v82:Cancel()
                    v82:Destroy()
                    v64 = nil
                end
                applyScaleType(Enum.ScaleType.Stretch)
                local v83 = {}
                v83.Size = UDim2.new(Size.X.Scale * 1.2, Size.X.Offset * 1.2, Size.Y.Scale * 0.43, Size.Y.Offset * 0.43)
                local v84 = Tween(v61, v83, v6)
                assert(v84, "the squash tween was not created")
                v64 = v84
                v84:Play()
            end
        end
    end)
    v63:Connect(v60.MouseLeave, relax)
    v63:Connect(v60.InputEnded, function(v85) -- line 388 | captures: relax
        if v85.UserInputType == Enum.UserInputType.MouseButton1 or v85.UserInputType == Enum.UserInputType.Touch then
            relax()
        end
    end)
    return v63, relax
end

return v14
