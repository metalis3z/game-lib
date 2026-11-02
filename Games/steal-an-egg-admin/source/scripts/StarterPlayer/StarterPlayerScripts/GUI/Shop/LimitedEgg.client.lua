-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local InfoOverlay = require(ReplicatedStorage.Client.InfoOverlay)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = Log.new()
local v2 = TryLock()
local v3
local LocalPlayer = Players.LocalPlayer
local LimitedEgg_2 = GUI.Shop().Frame.ScrollingFrame.LimitedEgg
local GuiObject = LimitedEgg_2:IsA("GuiObject")
assert(GuiObject, "Shop LimitedEgg must be a GuiObject")
local Spacer = LimitedEgg_2:FindFirstChild("Spacer")
local v4

if Spacer == nil then
    v4 = false
else
    v4 = Spacer:IsA("GuiObject")
end
assert(v4, "Shop LimitedEgg.Spacer must be a GuiObject")

local function requireChild(v5, v6, v7, v8) -- line 37
    local v9 = v5:FindFirstChild(v6)
    local v10 = v9 ~= nil
    local v11 = ("Shop LimitedEgg is missing %*"):format(v8)
    assert(v10, v11)
    local v12 = v9:IsA(v7)
    local v13 = ("Shop LimitedEgg %* must be a %*"):format(v8, v7)
    assert(v12, v13)
    return v9
end

local function bindSlot(v14, v15) -- line 45
    local v16 = ("Spacer.Frame.%*"):format(v15)
    local v17 = v14:FindFirstChild((tostring(v15)))
    local v18 = v17 ~= nil
    local v19 = ("Shop LimitedEgg is missing %*"):format(v16)
    assert(v18, v19)
    local GuiObject = v17:IsA("GuiObject")
    local v20 = ("Shop LimitedEgg %* must be a GuiObject"):format(v16)
    assert(GuiObject, v20)
    local Glow = v17:FindFirstChild("Glow")
    local v21 = { Frame = v17 }
    local v22 = ("%*.Icon"):format(v16)
    local Icon = v17:FindFirstChild("Icon")
    local v23 = Icon ~= nil
    local v24 = ("Shop LimitedEgg is missing %*"):format(v22)
    assert(v23, v24)
    local ImageLabel = Icon:IsA("ImageLabel")
    local v25 = ("Shop LimitedEgg %* must be a ImageLabel"):format(v22)
    assert(ImageLabel, v25)
    v21.Icon = Icon
    local v26 = ("%*.Amount"):format(v16)
    local Amount = v17:FindFirstChild("Amount")
    local v27 = Amount ~= nil
    local v28 = ("Shop LimitedEgg is missing %*"):format(v26)
    assert(v27, v28)
    local TextLabel = Amount:IsA("TextLabel")
    local v29 = ("Shop LimitedEgg %* must be a TextLabel"):format(v26)
    assert(TextLabel, v29)
    v21.Amount = Amount
    if Glow ~= nil and not Glow:IsA("ImageLabel") then
        Glow = nil
    end
    v21.Glow = Glow
    return v21
end

local function bindOfferUi(v30, v31) -- line 80
    local v32 = ("Buy%*"):format(v31)
    local v33 = ("Spacer.Btns.%*"):format(v32)
    local v34 = v30:FindFirstChild(v32)
    local v35 = v34 ~= nil
    local v36 = ("Shop LimitedEgg is missing %*"):format(v33)
    assert(v35, v36)
    local GuiButton = v34:IsA("GuiButton")
    local v37 = ("Shop LimitedEgg %* must be a GuiButton"):format(v33)
    assert(GuiButton, v37)
    local Amount = v34:FindFirstChild("Amount")
    local v38 = { Button = v34 }
    local v39 = ("%*.Price"):format(v33)
    local Price = v34:FindFirstChild("Price")
    local v40 = Price ~= nil
    local v41 = ("Shop LimitedEgg is missing %*"):format(v39)
    assert(v40, v41)
    local TextLabel = Price:IsA("TextLabel")
    local v42 = ("Shop LimitedEgg %* must be a TextLabel"):format(v39)
    assert(TextLabel, v42)
    v38.Price = Price
    if Amount ~= nil and not Amount:IsA("TextLabel") then
        Amount = nil
    end
    v38.Amount = Amount
    return v38
end

local function formatCountdown(v43) -- line 108
    local v44 = math.ceil(v43)
    local v45 = math.max(0, v44)
    local v46 = v45 // 86400
    local v47 = v45 % 86400 // 3600
    local v48 = v45 % 3600 // 60
    local v49 = v45 % 60
    if v46 > 0 then
        return string.format("%dd %02dh %02dm %02ds", v46, v47, v48, v49)
    end
    if v47 > 0 then
        return string.format("%02dh %02dm %02ds", v47, v48, v49)
    end
    if v48 > 0 then
        return string.format("%02dm %02ds", v48, v49)
    end
    return string.format("%02ds", v49)
end

local function formatChance(v50) -- line 125
    local v51
    if v50 > 0 and v50 < 10 then
        local v52 = -math.log10(v50)
        local v53 = math.ceil(v52) + 1
        v51 = math.clamp(v53, 0, 4)
    else
        v51 = 0
    end
    local v54 = ("%%.%*f"):format(v51)
    local v55 = string.format(v54, v50)
    if v51 > 0 then
        v55 = v55:gsub("0+$", ""):gsub("%.$", "")
    end
    return (("%*%%"):format(v55))
end

local function formatEggAmount(v56) -- line 139
    if v56 == 1 then
        return "1 Egg"
    end
    return (("%* Eggs"):format(v56))
end

local function swapGradient(v57, v58) -- line 145
    for v59, v60 in v57:GetChildren() do
        if v60:IsA("UIGradient") then
            v60:Destroy()
        end
    end
    if v58 ~= nil then
        v58:Clone().Parent = v57
    end
end

local Title = Spacer:FindFirstChild("Title")
local v61 = Title ~= nil
assert(v61, "Shop LimitedEgg is missing Spacer.Title")
local TextLabel = Title:IsA("TextLabel")
assert(TextLabel, "Shop LimitedEgg Spacer.Title must be a TextLabel")
local bg = Spacer:FindFirstChild("bg")
local v62 = bg ~= nil
assert(v62, "Shop LimitedEgg is missing Spacer.bg")
local ImageLabel = bg:IsA("ImageLabel")
assert(ImageLabel, "Shop LimitedEgg Spacer.bg must be a ImageLabel")
local Icon = bg:FindFirstChild("Icon")
local v63 = Icon ~= nil
assert(v63, "Shop LimitedEgg is missing Spacer.bg.Icon")
local ImageLabel_2 = Icon:IsA("ImageLabel")
assert(ImageLabel_2, "Shop LimitedEgg Spacer.bg.Icon must be a ImageLabel")
local MechanicalVersion = bg:FindFirstChild("MechanicalVersion")
local v64 = MechanicalVersion ~= nil
assert(v64, "Shop LimitedEgg is missing Spacer.bg.MechanicalVersion")
local ImageLabel_3 = MechanicalVersion:IsA("ImageLabel")
assert(ImageLabel_3, "Shop LimitedEgg Spacer.bg.MechanicalVersion must be a ImageLabel")
local Infos = Spacer:FindFirstChild("Infos")
local v65 = Infos ~= nil
assert(v65, "Shop LimitedEgg is missing Spacer.Infos")
local GuiButton = Infos:IsA("GuiButton")
assert(GuiButton, "Shop LimitedEgg Spacer.Infos must be a GuiButton")
local Frame = Spacer:FindFirstChild("Frame")
local v66 = Frame ~= nil
assert(v66, "Shop LimitedEgg is missing Spacer.Frame")
local GuiObject_2 = Frame:IsA("GuiObject")
assert(GuiObject_2, "Shop LimitedEgg Spacer.Frame must be a GuiObject")
local Btns = Spacer:FindFirstChild("Btns")
local v67 = Btns ~= nil
assert(v67, "Shop LimitedEgg is missing Spacer.Btns")
local GuiObject_3 = Btns:IsA("GuiObject")
assert(GuiObject_3, "Shop LimitedEgg Spacer.Btns must be a GuiObject")
local v68 = {}
local v69 = #LimitedEgg.Entries
for v70 = 1, v69 do
    local v71 = bindSlot(Frame, v70)
    table.insert(v68, v71)
end

local function mechaLabelFor(v72) -- line 203
    local v73 = v72.Frame:FindFirstChild("MechanicalVersion") or v72.Frame:FindFirstChild("Icon2")
    if v73 ~= nil and v73:IsA("ImageLabel") then
        return v73
    end
    return nil
end

local v74, v75
local v76 = #LimitedEgg.Entries + 1
local v77 = Frame:FindFirstChild((tostring(v76)))
local v78

if v77 == nil then
else
    v78 = v77:FindFirstChild("Icon2")
end

if v77 ~= nil and v77:IsA("GuiObject") and v78 ~= nil and v78:IsA("ImageLabel") then
    v74 = bindSlot(Frame, v76)
    v75 = v78
end
local v79 = {}
local v80 = #LimitedEgg.Offers
for v81 = 1, v80 do
    local v82 = bindOfferUi(Btns, v81)
    table.insert(v79, v82)
end

local function bindIconAlternator(v83) -- line 235 | captures: TweenService, Icon, MechanicalVersion, v68
    local v84 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    local function fadeTo(v85, v86) -- line 238 | captures: v83, v84, TweenService
        return v83:Add(TweenService:Create(v85, v84, { ImageTransparency = v86 }))
    end

    local v87 = {}

    local function addSwap(v88, v89) -- line 242 | captures: v83, v84, v87, TweenService
        v88.ImageTransparency = 0
        v89.ImageTransparency = 1
        local v90 = {
            RegularIn = v83:Add(TweenService:Create(v88, v84, { ImageTransparency = 0 })),
            RegularOut = v83:Add(TweenService:Create(v88, v84, { ImageTransparency = 1 })),
            MechaIn = v83:Add(TweenService:Create(v89, v84, { ImageTransparency = 0 })),
            MechaOut = v83:Add(TweenService:Create(v89, v84, { ImageTransparency = 1 }))
        }
        table.insert(v87, v90)
    end

    addSwap(Icon, MechanicalVersion)
    local v91
    for v92, v93 in ipairs(v68) do
        local v94 = v93.Frame:FindFirstChild("MechanicalVersion") or v93.Frame:FindFirstChild("Icon2")
        if v94 == nil then
            v91 = nil
        elseif v94:IsA("ImageLabel") then
            v91 = v94
        end
        if v91 ~= nil then
            addSwap(v93.Icon, v91)
        end
    end
    local spawn = task.spawn
    v83:Add(spawn(function() -- line 262 | captures: v87
        while true do
            task.wait(1)
            for v95, v96 in v87 do
                v96.RegularOut:Play()
                v96.MechaIn:Play()
            end
            task.wait(4)
            for v97, v98 in v87 do
                v98.MechaOut:Play()
                v98.RegularIn:Play()
            end
            task.wait(1)
        end
    end))
end

local function bindEndingTimer(v99, v100) -- line 285 | captures: Workspace, Timer, formatCountdown, Title
    local v101 = v100 - Workspace:GetServerTimeNow()
    if v101 > 0 then
        Title.Text = formatCountdown(v101)
    else
        Title.Text = "Leaving Soon"
    end
    v99:Add(Timer.Simple(1, function() -- line 292 | captures: v100, Workspace, formatCountdown, Title
        local v102 = v100 - Workspace:GetServerTimeNow()
        if v102 <= 0 then
            Title.Text = "Leaving Soon"
        else
            Title.Text = formatCountdown(v102)
        end
    end))
end

local function bindRarityGlow(v103, v104, v105) -- line 301 | captures: swapGradient
    local UIGradient = v104:FindFirstChildWhichIsA("UIGradient")
    local v106
    if UIGradient == nil then
    else
        v106 = UIGradient:Clone()
    end
    swapGradient(v104, v105)
    v103:Add(function() -- line 310 | captures: v106, v104, swapGradient
        swapGradient(v104, v106)
        if v106 ~= nil then
            v106:Destroy()
        end
    end)
end

local function bindSlots(v107) -- line 317 | captures: Assets, LimitedEgg, v1, formatChance, v68, bindRarityGlow
    local v108 = 0
    for v109, v110 in ipairs(LimitedEgg.Entries) do
        local v111 = v110.Weight > 0
        assert(v111, "Limited egg drop weights must be positive")
        v108 += v110.Weight
    end
    local v112 = if LimitedEgg.MechaReroll == nil then 0 else LimitedEgg.MechaReroll.DisplayChance
    local v113 = 1 - v112
    for v114, v115 in ipairs(LimitedEgg.Entries) do
        local v116 = v68[v114]
        local v117 = Assets.Directory[v115.AssetId]
        local v118 = v117 ~= nil
        local v119 = ("Limited egg drop entry \"%*\" is not in the asset directory"):format(v115.AssetId)
        assert(v118, v119)
        local Image = v116.Icon.Image
        v116.Icon.Image = v117.Icon or Image
        v107:Add(function() -- line 338 | captures: v116, Image
            v116.Icon.Image = Image
        end)
        local v120 = LimitedEgg.MechaReroll and LimitedEgg.MechaReroll.Entries
        local v121 = v120 and v120[v114]
        local v122 = v121 and Assets.Directory[v121.AssetId]
        local v123 = v116.Frame:FindFirstChild("MechanicalVersion") or v116.Frame:FindFirstChild("Icon2")
        if v123 == nil then
            u109 = nil
        elseif v123:IsA("ImageLabel") then
        end
        if u109 ~= nil and v122 ~= nil then
            local Image = u109.Image
            u109.Image = v122.Icon or Image
            v107:Add(function() -- line 365 | captures: Image
                u109.Image = Image
            end)
        end
        v116.Amount.Text = formatChance(v113 * (v115.Weight / v108) * 100)
        local Glow = v116.Glow
        if Glow ~= nil then
            bindRarityGlow(v107, Glow, v117.Rarity.RarityGradient)
        end
    end
    v1:AtTrace():Log("Limited egg slot session opened")
end

local function bindMechaRerollSlot(v124) -- line 378 | captures: v74, v75, TweenService, Assets, LimitedEgg, v1, formatChance
    local v125 = v74
    local v126 = v75
    local MechaReroll = LimitedEgg.MechaReroll
    if not (v125 ~= nil and v126 ~= nil and MechaReroll ~= nil) then
        return
    end
    local v127 = {}
    for v128, v129 in ipairs(MechaReroll.Entries) do
        local v130 = Assets.Directory[v129.AssetId]
        local v131 = v130 ~= nil
        local v132 = ("Limited egg mecha entry \"%*\" is not in the asset directory"):format(v129.AssetId)
        assert(v131, v132)
        local Icon = v130.Icon
        table.insert(v127, Icon)
    end
    if #v127 == 0 then
        return
    end
    local Icon = v125.Icon
    local Text = v125.Amount.Text
    local Image = Icon.Image
    local Image_2 = v126.Image
    v124:Add(function() -- line 401 | captures: v125, v126, Icon, Text, Image, Image_2
        v125.Amount.Text = Text
        Icon.Image = Image
        Icon.ImageTransparency = 0
        v126.Image = Image_2
        v126.ImageTransparency = 1
    end)
    v125.Amount.Text = formatChance(MechaReroll.DisplayChance * 100)
    Icon.Image = v127[1]
    Icon.ImageTransparency = 0
    v126.ImageTransparency = 1
    local v133 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local v134 = {}
    v134[Icon] = v124:Add(TweenService:Create(Icon, v133, { ImageTransparency = 0 }))
    v134[v126] = v124:Add(TweenService:Create(v126, v133, { ImageTransparency = 0 }))
    local v135 = {}
    v135[Icon] = v124:Add(TweenService:Create(Icon, v133, { ImageTransparency = 1 }))
    v135[v126] = v124:Add(TweenService:Create(v126, v133, { ImageTransparency = 1 }))
    v124:Add(task.spawn(function() -- line 420 | captures: v126, v127, Icon, v134, v135
        local v136 = Icon
        local v137 = v126
        local v138 = 1
        while true do
            task.wait(1)
            v138 = v138 % #v127 + 1
            v137.Image = v127[v138]
            v135[v136]:Play()
            local v139 = v134[v137]
            v139:Play()
            v139.Completed:Wait()
            v136, v137 = v137, v136
        end
    end))
    v1:AtTrace():Log("Limited egg mecha re-roll slot session opened")
end

local function bindHoverInfo(v140) -- line 440 | captures: v74, Assets, InfoOverlay, LimitedEgg, v1, Infos, v68
    for v141, v142 in ipairs(LimitedEgg.Entries) do
        local v143 = v68[v141]
        local v144 = Assets.Directory[v142.AssetId]
        local v145 = {}
        local v146 = {
            "Rarity",
            v144.Rarity._id
        }
        v145[1] = {
            "Title",
            v144.DisplayName
        }
        v145[2] = v146
        v140:Add(InfoOverlay.Hook(v143.Frame, v145))
    end
    local v147 = v74
    if v147 ~= nil then
        v140:Add(InfoOverlay.Hook(v147.Frame, { { "Title", "Mecha Re-roll" } }))
    end
    local InfoText = LimitedEgg.InfoText
    if InfoText ~= nil then
        v140:Add(InfoOverlay.Hook(Infos, { { "Desc", InfoText } }))
        v140:Add(Infos.Activated:Connect(function() -- line 462 | captures: InfoText, InfoOverlay, Infos
            InfoOverlay.Show(Infos, { { "Desc", InfoText } })
        end))
    end
    v140:Add(function() -- line 468 | captures: InfoOverlay
        InfoOverlay.Dismiss()
    end)
    v1:AtTrace():Log("Limited egg hover info session opened")
end

local function closeSession() -- line 473 | captures: v3, v1
    local v148 = v3
    if v148 == nil then
        return
    end
    v3 = nil
    v148:Destroy()
    v1:AtTrace():Log("Limited egg shop session closed")
end

local function bindOffer(v149, v150) -- line 482 | captures: v3, ButtonFX, Price, PromptPurchase, v2
    local Amount = v150.Ui.Amount
    if Amount ~= nil then
        local Amount_2 = v150.Amount
        if Amount_2 == 1 then
            Amount.Text = "1 Egg"
        else
            Amount.Text = ("%* Eggs"):format(Amount_2)
        end
    end
    local Button = v150.Ui.Button
    v149:Add(ButtonFX(Button, nil, function() -- line 494 | captures: v150, PromptPurchase, v2
        v2(function() -- line 495 | captures: v150, PromptPurchase
            PromptPurchase.Prompt(v150.ProductId, true)
        end)
    end))
    local spawn = task.spawn
    v149:Add((spawn(function() -- line 499 | captures: v149, v150, v3, Price
        local v151, v152 = Price(v150.ProductId, true)
        if v3 == v149 then
            if v152 then
                v150.Ui.Price.Text = "\238\128\130" .. tostring(v151)
            else
                v150.Ui.Price.Text = "Loading..."
            end
        end
    end)))
end

local function openSession() -- line 515 | captures: v3, Workspace, t, LimitedEgg, Products, Timer, Trove, TryCall, v1, formatCountdown, Title, v79, bindIconAlternator, bindSlots, bindMechaRerollSlot, bindHoverInfo, bindOffer
    local v153 = v3
    if v153 ~= nil then
        v3 = nil
        v153:Destroy()
        v1:AtTrace():Log("Limited egg shop session closed")
    end
    local v154 = Trove.new()
    v3 = v154
    local v155, v156 = TryCall(function() -- line 525 | captures: v154, Workspace, t, LimitedEgg, Products, Timer, formatCountdown, Title, v79, bindIconAlternator, bindSlots, bindMechaRerollSlot, bindHoverInfo, bindOffer
        local EndsAt = LimitedEgg.EndsAt
        local v157 = EndsAt ~= nil
        Title.Visible = v157
        if EndsAt ~= nil then
            local v158 = EndsAt - Workspace:GetServerTimeNow()
            if v158 > 0 then
                Title.Text = formatCountdown(v158)
            else
                Title.Text = "Leaving Soon"
            end
            local Simple = Timer.Simple
            v154:Add(Simple(1, function() -- line 537 | captures: EndsAt, Workspace, formatCountdown, Title
                local v159 = EndsAt - Workspace:GetServerTimeNow()
                if v159 <= 0 then
                    Title.Text = "Leaving Soon"
                else
                    Title.Text = formatCountdown(v159)
                end
            end))
        end
        bindSlots(v154)
        bindMechaRerollSlot(v154)
        bindHoverInfo(v154)
        bindIconAlternator(v154)
        for v160, v161 in ipairs(LimitedEgg.Offers) do
            local v162 = Products.Directory[v161.ProductName]
            local v163 = v162 ~= nil
            local v164 = ("Limited egg offer \"%*\" is not in the product directory"):format(v161.ProductName)
            assert(v163, v164)
            t.strict(t.number)(v162.ProductId)
            bindOffer(v154, {
                Ui = v79[v160],
                Amount = v161.Amount,
                ProductId = v162.ProductId
            })
        end
    end)
    if not v155 then
        local v165 = v3
        if v165 ~= nil then
            v3 = nil
            v165:Destroy()
            v1:AtTrace():Log("Limited egg shop session closed")
        end
        error(v156)
    end
    v1:AtTrace():Log("Limited egg shop session opened")
end

task.spawn(function() -- line 570 | captures: PolicyService, t, TryCall, LocalPlayer, LimitedEgg_2
    LimitedEgg_2.Visible = false
    local v166, v167 = TryCall(function() -- line 573 | captures: PolicyService, LocalPlayer
        return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer).ArePaidRandomItemsRestricted
    end)
    if v166 then
        TryCall(function() -- line 577 | captures: v167, t, LimitedEgg_2
            t.strict(t.boolean)(v167)
            LimitedEgg_2.Visible = not v167
        end)
    end
end)
Tabs.Shown:Connect(function(v168) -- line 584 | captures: openSession
    if v168 == "Shop" then
        openSession()
    end
end)
Tabs.Hidden:Connect(function(v169) -- line 589 | captures: v3, v1
    if v169 == "Shop" then
        local v170 = v3
        if v170 ~= nil then
            v3 = nil
            v170:Destroy()
            v1:AtTrace():Log("Limited egg shop session closed")
        end
    end
end)

if Tabs.Current() == "Shop" then
    openSession()
end
