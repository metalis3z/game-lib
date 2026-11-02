-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ProductId
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
require(ReplicatedStorage.Client.Types.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
require(ReplicatedStorage.Data.Products)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Shared.Save)
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local Shake = require(ReplicatedStorage.Client.Shake)
local Shockwave = require(ReplicatedStorage.Client.UI.VFX.Shockwave)
local Sparkles = require(ReplicatedStorage.Client.UI.VFX.Sparkles)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    Products.Directory.SpeedBoostTier1,
    Products.Directory.SpeedBoostTier2,
    Products.Directory.SpeedBoostTier3,
    Products.Directory.SpeedBoostTier4,
    Products.Directory.SpeedBoostTier5,
    Products.Directory.SpeedBoostTier6,
    Products.Directory.SpeedBoostTier7,
    Products.Directory.SpeedBoostTier8,
    Products.Directory.SpeedBoostTier9,
    Products.Directory.SpeedBoostTier10,
    Products.Directory.SpeedBoostTier11,
    Products.Directory.SpeedBoostTier12
}
local v2 = ("ONLY ?%*"):format(Constants.ROBUX_ICON_STR)
local v3 = GUI.TreadmillSpeedShop()
local Spacer = v3.Frame.ScrollingFrame.DoubleSpeed.Spacer
local Treadmill = Hud.Get("SpeedMultiButton", "Treadmill")
local v4 = {}
for v5, v6 in Treadmill:GetChildren() do
    if v6:IsA("TextLabel") then
        table.insert(v4, v6)
    end
end
local v7 = #v4 >= 2
assert(v7, "TradmilHud SpeedMulti needs a multiplier label and a price label")
local v8 = v4[1]
local v9 = v4[2]
require(ReplicatedStorage.Shared.Utils.Layout).EnsureScale(Spacer.NextAm)
local v10 = {
    {
        HasRendered = false,
        AlwaysAnimate = true,
        LastRenderedSpeedBoostTierIndex = 0,
        Buy = Spacer.Buy,
        End = Spacer.NextAm,
        Root = v3,
        Start = Spacer.CurAm
    }
}
local v11 = 0

local function resolveOwnedSpeedBoostTierIndex() -- line 68 | captures: Save, TreadmillUtil
    return TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
end

local function resolveNextSpeedBoostProduct() -- line 71 | captures: Save, TreadmillUtil, v1
    return v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
end

local function resolveSpeedBoostMultiplierForTierIndex(v12) -- line 74 | captures: v1
    local v13 = v1[v12]
    if v13 == nil then
        return 1
    end
    return v13.SpeedBoostMultiplier
end

local function resolveCurrentAndNextSpeedBoostMultipliers() -- line 81 | captures: Save, TreadmillUtil, v1
    local v14 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    local v15 = v1[v14]
    local v16 = if v15 == nil then 1 else v15.SpeedBoostMultiplier
    local v17 = v1[v14 + 1]
    local v18 = if v17 == nil then v16 else v17.SpeedBoostMultiplier
    return v16, v18, v17 == nil
end

local function formatSpeedBoostMultiplier(v19) -- line 99 | captures: TreadmillUtil, t
    t.strict(t.number)(v19)
    return (TreadmillUtil.FormatSpeedMultiplierValue(v19))
end

local function hasProductCredit(v20) -- line 104 | captures: Save
    if Save.IsLocalDataLoaded() then
        local v21 = Save.Get()
        local ProductCredits
        if v21 == nil then
        else
            ProductCredits = v21.ProductCredits
        end
        if typeof(ProductCredits) == "table" then
            local v22 = ProductCredits[tostring(v20)]
            if typeof(v22) == "number" then
                return v22 > 0
            end
        end
    end
    return false
end

local function updateProductPrice(v23, v24) -- line 122 | captures: Constants, Price, Save
    v23.Visible = true
    if v24 == nil then
        v23.Text = "MAX"
        v23.Visible = false
    else
        local ProductId = v24.ProductId
        if ProductId <= 0 then
            v23.Text = "???"
            v23.Visible = false
        else
            local v25
            if Save.IsLocalDataLoaded() then
                local v26 = Save.Get()
                local ProductCredits
                if v26 == nil then
                else
                    ProductCredits = v26.ProductCredits
                end
                if typeof(ProductCredits) == "table" then
                    local v27 = ProductCredits[tostring(ProductId)]
                    if typeof(v27) == "number" then
                        v25 = v27 > 0
                    else
                        v25 = false
                    end
                else
                    v25 = false
                end
            else
                v25 = false
            end
            if v25 then
                v23.Text = "FREE!"
            else
                task.spawn(function() -- line 157 | captures: v23, ProductId, Constants, Price
                    local v28, v29 = Price(ProductId, true)
                    local v30
                    if v29 then
                        v30 = tostring(v28)
                    else
                        v30 = "???"
                    end
                    v23.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, v30)
                end)
            end
        end
    end
end

local function updateSideButtonPrice(v31) -- line 168 | captures: v11, Constants, Price, Save, v2, v9
    v11 += 1
    local v32 = v11
    if v31 == nil then
        v9.Text = "MAX"
    else
        local ProductId = v31.ProductId
        local v33
        if Save.IsLocalDataLoaded() then
            local v34 = Save.Get()
            local ProductCredits
            if v34 == nil then
            else
                ProductCredits = v34.ProductCredits
            end
            if typeof(ProductCredits) == "table" then
                local v35 = ProductCredits[tostring(ProductId)]
                if typeof(v35) == "number" then
                    v33 = v35 > 0
                else
                    v33 = false
                end
            else
                v33 = false
            end
        else
            v33 = false
        end
        if v33 then
            v9.Text = "FREE!"
        else
            v9.Text = v2
            task.spawn(function() -- line 199 | captures: v32, ProductId, v11, Constants, Price, v2, v9
                local v36, v37 = Price(ProductId, true)
                if v32 == v11 then
                    local v38
                    if v37 then
                        v38 = ("ONLY %*%*"):format(v36, Constants.ROBUX_ICON_STR)
                    else
                        v38 = v2
                    end
                    v9.Text = v38
                end
            end)
        end
    end
end

local function updateDoubleYourSpeedTool() -- line 213 | captures: v11, Constants, Price, Save, TreadmillUtil, v1, v2, Treadmill, v8, v9
    local v39 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
    local v40 = v39 ~= nil
    Treadmill.Interactable = v40
    v9.Visible = v40
    if v39 == nil then
        v8.Text = "MAX"
        v11 += 1
        v9.Text = "MAX"
    else
        v8.Text = TreadmillUtil.FormatSpeedMultiplier(v39.SpeedBoostMultiplier)
        v11 += 1
        local v41 = v11
        if v39 == nil then
            v9.Text = "MAX"
        else
            local ProductId = v39.ProductId
            local v42
            if Save.IsLocalDataLoaded() then
                local v43 = Save.Get()
                local ProductCredits
                if v43 == nil then
                else
                    ProductCredits = v43.ProductCredits
                end
                if typeof(ProductCredits) == "table" then
                    local v44 = ProductCredits[tostring(ProductId)]
                    if typeof(v44) == "number" then
                        v42 = v44 > 0
                    else
                        v42 = false
                    end
                else
                    v42 = false
                end
            else
                v42 = false
            end
            if v42 then
                v9.Text = "FREE!"
            else
                v9.Text = v2
                task.spawn(function() -- line 255 | captures: v41, ProductId, v11, Constants, Price, v2, v9
                    local v45, v46 = Price(ProductId, true)
                    if v41 == v11 then
                        local v47
                        if v46 then
                            v47 = ("ONLY %*%*"):format(v45, Constants.ROBUX_ICON_STR)
                        else
                            v47 = v2
                        end
                        v9.Text = v47
                    end
                end)
            end
        end
    end
end

local function updateDoubleYourSpeedText(v48, v49, v50, v51) -- line 269 | captures: TreadmillUtil, t
    t.strict(t.number)(v49)
    local Start = v48.Start
    t.strict(t.number)(v49)
    Start.Text = TreadmillUtil.FormatSpeedMultiplierValue(v49)
    local v52
    if v51 then
        v52 = "MAX"
    else
        t.strict(t.number)(v50)
        t.strict(t.number)(v50)
        v52 = TreadmillUtil.FormatSpeedMultiplierValue(v50)
    end
    v48.End.Text = v52
end

local function updateDoubleYourSpeedVisibility(v53, v54) -- line 283
    v53.Buy.Visible = not v54
    v53.Buy.Interactable = not v54
end

local function playDoubleYourSpeedAnimation(v55, v56, v57) -- line 287 | captures: Audio, Flash, ViewportSize, Shake, Shockwave, Sparkles, TreadmillUtil, Tween, t
    v55.Start.TextWrapped = false
    v55.End.TextWrapped = false
    v55.Start.TextScaled = false
    v55.End.TextScaled = false
    v55.Start.TextSize = 130 * ViewportSize.ReadScale()
    v55.End.TextSize = 130 * ViewportSize.ReadScale()
    local OriginalScale = v55.End:GetAttribute("OriginalScale")
    local OriginalThickness = v55.End:GetAttribute("OriginalThickness")
    local v58 = typeof(OriginalScale) == "number"
    assert(v58, "DoubleYourSpeed.Pack.Multiplier.End.OriginalScale must be a number")
    local v59 = typeof(OriginalThickness) == "number"
    assert(v59, "DoubleYourSpeed.Pack.Multiplier.End.OriginalThickness must be a number")
    task.delay(0.6, function() -- line 302 | captures: Audio
        Audio.Play("rbxassetid://73631996481069", script, { Volume = 1.5 })
    end)
    Tween(v55.End.UIStroke, { Thickness = OriginalThickness * 0.15 }, { 0.6, "Back", "In" })
    Tween(v55.End.UIScale, { Scale = OriginalScale * 4 }, { 0.6, "Back", "In" }).Completed:Wait()
    Tween(v55.End.UIStroke, { Thickness = OriginalThickness * 0.1 }, { 0.3, "Sine", "Out" })
    Tween(v55.End.UIScale, { Scale = OriginalScale * 6 }, { 0.3, "Sine", "Out" }).Completed:Wait()
    task.spawn(function() -- line 309 | captures: v55, v56, v57, TreadmillUtil, t
        local v60 = v57 - v56
        local v61 = math.abs(v60)
        local v62 = math.clamp(v61, 1, 15)
        local v63 = v60 / v62
        local v64 = math.round(v63)
        for v65 = 1, v62 do
            local v66 = v56 + v64 * v65
            t.strict(t.number)(v66)
            local End = v55.End
            t.strict(t.number)(v66)
            End.Text = TreadmillUtil.FormatSpeedMultiplierValue(v66)
            task.wait(0.025)
        end
        t.strict(t.number)(v57)
        local End = v55.End
        t.strict(t.number)(v57)
        End.Text = TreadmillUtil.FormatSpeedMultiplierValue(v57)
    end)
    local Start = v55.Start
    t.strict(t.number)(v56)
    t.strict(t.number)(v56)
    Start.Text = TreadmillUtil.FormatSpeedMultiplierValue(v56)
    task.delay(0.075, function() -- line 333 | captures: v55, Flash, Shake, Shockwave, Sparkles
        Shake.Play(1, 6, 0.25, false)
        local v67 = Color3.new(1, 1, 1)
        Flash(0, 0.25, v67, 0.25)
        Shockwave(v55.End, 1.5, 0.7, 6)
        local v68 = Sparkles(v55.End)
        task.delay(10, v68)
    end)
    Tween(v55.End.UIStroke, { Thickness = OriginalThickness }, { 0.075, "Quad", "In" })
    Tween(v55.End.UIScale, { Scale = OriginalScale }, { 0.075, "Quad", "In" }).Completed:Wait()
    v55.End.UIScale.Scale = OriginalScale
    v55.End.UIStroke.Thickness = OriginalThickness
    v55.Start.TextWrapped = v55.Start.TextWrapped
    v55.Start.TextScaled = v55.Start.TextScaled
    v55.End.TextWrapped = v55.End.TextWrapped
    v55.End.TextScaled = v55.End.TextScaled
end

local v69

function v69(v70, v71) -- line 350 | captures: v69, Save, TreadmillUtil, t, v1, updateProductPrice, playDoubleYourSpeedAnimation
    local v72 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    local v73 = v1[v72]
    local v74 = if v73 == nil then 1 else v73.SpeedBoostMultiplier
    local v75 = v1[v72 + 1]
    local v76 = if v75 == nil then v74 else v75.SpeedBoostMultiplier
    local v77 = v75 == nil
    v70.Buy.Visible = not v77
    v70.Buy.Interactable = not v77
    updateProductPrice(v70.Buy.Price, v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1])
    if v71 then
        if v70.HasRendered and not v77 then
            local v78 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
            local delay = task.delay
            local v79 = v74
            local v80 = v76
            delay(1.2, function() -- line 387 | captures: v70, v78, v79, v80, v69, Save, TreadmillUtil, playDoubleYourSpeedAnimation
                if v70.AlwaysAnimate then
                    if TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) == v78 then
                        playDoubleYourSpeedAnimation(v70, v79, v80)
                    else
                        v69(v70, false)
                    end
                elseif v70.Root.Enabled and TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) == v78 then
                    playDoubleYourSpeedAnimation(v70, v79, v80)
                else
                    v69(v70, false)
                end
            end)
        end
    else
        local Start = v70.Start
        t.strict(t.number)(v74)
        t.strict(t.number)(v74)
        Start.Text = TreadmillUtil.FormatSpeedMultiplierValue(v74)
        local v81
        if v77 then
            v81 = "MAX"
        else
            t.strict(t.number)(v76)
            t.strict(t.number)(v76)
            v81 = TreadmillUtil.FormatSpeedMultiplierValue(v76)
        end
        v70.End.Text = v81
    end
    v70.LastRenderedSpeedBoostTierIndex = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    v70.HasRendered = true
end

local function bindDoubleYourSpeedButton(v82) -- line 413 | captures: ButtonFX, PromptPurchase, Save, TreadmillUtil, v1
    ButtonFX(v82.Buy, nil, function() -- line 414 | captures: PromptPurchase, Save, TreadmillUtil, v1
        local v83 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
        if v83 ~= nil then
            PromptPurchase.Prompt(v83.ProductId, true)
        end
    end)
end

local function updateSpeedBoostProducts() -- line 422 | captures: v69, v11, Constants, Price, Save, TreadmillUtil, v1, v2, Treadmill, v8, v9, v10
    local v84 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    for v85, v86 in ipairs(v10) do
        local v87 = v86.Root.Enabled and v84 ~= v86.LastRenderedSpeedBoostTierIndex
        v69(v86, v87)
    end
    local v88 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
    local v89 = v88 ~= nil
    Treadmill.Interactable = v89
    v9.Visible = v89
    if v88 == nil then
        v8.Text = "MAX"
        v11 += 1
        v9.Text = "MAX"
    else
        v8.Text = TreadmillUtil.FormatSpeedMultiplier(v88.SpeedBoostMultiplier)
        v11 += 1
        local v90 = v11
        if v88 == nil then
            v9.Text = "MAX"
        else
            local ProductId = v88.ProductId
            local v91
            if Save.IsLocalDataLoaded() then
                local v92 = Save.Get()
                local ProductCredits
                if v92 == nil then
                else
                    ProductCredits = v92.ProductCredits
                end
                if typeof(ProductCredits) == "table" then
                    local v93 = ProductCredits[tostring(ProductId)]
                    if typeof(v93) == "number" then
                        v91 = v93 > 0
                    else
                        v91 = false
                    end
                else
                    v91 = false
                end
            else
                v91 = false
            end
            if v91 then
                v9.Text = "FREE!"
            else
                v9.Text = v2
                task.spawn(function() -- line 472 | captures: v90, ProductId, v11, Constants, Price, v2, v9
                    local v94, v95 = Price(ProductId, true)
                    if v90 == v11 then
                        local v96
                        if v95 then
                            v96 = ("ONLY %*%*"):format(v94, Constants.ROBUX_ICON_STR)
                        else
                            v96 = v2
                        end
                        v9.Text = v96
                    end
                end)
            end
        end
    end
end

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
for v97, v98 in ipairs(v10) do
    local Buy = v98.Buy
    ButtonFX(Buy, nil, function() -- line 490 | captures: PromptPurchase, Save, TreadmillUtil, v1
        local v99 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
        if v99 ~= nil then
            PromptPurchase.Prompt(v99.ProductId, true)
        end
    end)
    local v100 = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    local v101 = v1[v100]
    local v102 = if v101 == nil then 1 else v101.SpeedBoostMultiplier
    local v103 = v1[v100 + 1]
    local v104 = if v103 == nil then v102 else v103.SpeedBoostMultiplier
    local v105 = v103 == nil
    v98.Buy.Visible = not v105
    v98.Buy.Interactable = not v105
    updateProductPrice(v98.Buy.Price, v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1])
    t.strict(t.number)(v102)
    local Start = v98.Start
    t.strict(t.number)(v102)
    Start.Text = TreadmillUtil.FormatSpeedMultiplierValue(v102)
    local v106
    if v105 then
        v106 = "MAX"
    else
        t.strict(t.number)(v104)
        t.strict(t.number)(v104)
        v106 = TreadmillUtil.FormatSpeedMultiplierValue(v104)
    end
    v98.End.Text = v106
    v98.LastRenderedSpeedBoostTierIndex = TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get())
    v98.HasRendered = true
end
ButtonFX(Treadmill, 1.08, function() -- line 530 | captures: PromptPurchase, Save, TreadmillUtil, v1
    local v107 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
    if v107 ~= nil then
        PromptPurchase.Prompt(v107.ProductId, true)
    end
end)
local v108 = v1[TreadmillUtil.ResolveSpeedBoostTierIndex(Save.Get()) + 1]
local v109 = v108 ~= nil

Treadmill.Interactable = v109
v9.Visible = v109

if v108 == nil then
    v8.Text = "MAX"
    v11 += 1
    v9.Text = "MAX"
else
    v8.Text = TreadmillUtil.FormatSpeedMultiplier(v108.SpeedBoostMultiplier)
    v11 += 1
    local v110 = v11
    if v108 == nil then
        v9.Text = "MAX"
    else
        local ProductId_2 = v108.ProductId
        ProductId = ProductId_2
        local v111
        if Save.IsLocalDataLoaded() then
            local v112 = Save.Get()
            local ProductCredits
            if v112 == nil then
            else
                ProductCredits = v112.ProductCredits
            end
            if typeof(ProductCredits) == "table" then
                local v113 = ProductCredits[tostring(ProductId_2)]
                if typeof(v113) == "number" then
                    v111 = not not (v113 > 0)
                else
                    v111 = false
                end
            else
                v111 = false
            end
        else
            v111 = false
        end
        if v111 then
            v9.Text = "FREE!"
        else
            v9.Text = v2
            task.spawn(function() -- line 566 | captures: ProductId, v11, Constants, Price, v2, v9, v110
                local v114, v115 = Price(ProductId, true)
                if v110 == v11 then
                    local v116
                    if v115 then
                        v116 = ("ONLY %*%*"):format(v114, Constants.ROBUX_ICON_STR)
                    else
                        v116 = v2
                    end
                    v9.Text = v116
                end
            end)
        end
    end
end
Save.WatchFields({ "SpeedBoostTierIndex", "ProductCredits" }, updateSpeedBoostProducts)
