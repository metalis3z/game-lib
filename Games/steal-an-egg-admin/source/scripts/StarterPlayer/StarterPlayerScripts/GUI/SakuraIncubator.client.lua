-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1, v2, v3
local ContextActionService = game:GetService("ContextActionService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
require(ReplicatedStorage.Shared.Globals.Constants)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
require(ReplicatedStorage.Shared.Types.Eggs)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Message_2 = require(ReplicatedStorage.Client.Notifications.Message)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local SakuraSignals = require(ReplicatedStorage.Client.SakuraSignals)
local Sakura_2 = require(ReplicatedStorage.Shared.Types.Sakura)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v4 = utf8.char(57346)
local v5 = Color3.fromRGB(255, 0, 0)
local v6 = Log.new()
local v7 = TryLock()
local LocalPlayer = Players.LocalPlayer
local SakuraEggCharge = GUI.SakuraEggCharge().SakuraEggCharge
local Frame = SakuraEggCharge:IsA("Frame")
assert(Frame, "SakuraEggCharge.SakuraEggCharge must be a Frame")
local Content = SakuraEggCharge.Content
local Frame_2 = Content:IsA("Frame")
assert(Frame_2, "SakuraEggCharge.Content must be a Frame")
local EggIconHolder = Content.EggIconHolder
local Icon = EggIconHolder.Icon
local ImageLabel = Icon:IsA("ImageLabel")
assert(ImageLabel, "SakuraEggCharge EggIconHolder.Icon must be an ImageLabel")
local Title = Icon.Title
local TextLabel = Title:IsA("TextLabel")
assert(TextLabel, "SakuraEggCharge EggIconHolder.Icon.Title must be a TextLabel")
local Mutate = Content.Mutate
local ImageButton = Mutate:IsA("ImageButton")
assert(ImageButton, "SakuraEggCharge.Content.Mutate must be an ImageButton")
local Deposit = Content.Deposit
local ImageButton_2 = Deposit:IsA("ImageButton")
assert(ImageButton_2, "SakuraEggCharge.Content.Deposit must be an ImageButton")

local function optionalGui(v8, v9, v10) -- line 61
    local v11 = v8:FindFirstChild(v9, true)
    if v11 and v11:IsA(v10) then
        return v11
    end
    return nil
end

local v12 = SakuraEggCharge:FindFirstChild("RemoveEgg", true)

if v12 then
    if v12:IsA("GuiButton") then
        v1 = v12
    end
end
local v13 = SakuraEggCharge:FindFirstChild("Help", true)

if not (v13 and v13:IsA("GuiButton")) then
    v13 = nil
end
local v14 = SakuraEggCharge:FindFirstChild("CostLabel", true)

if v14 then
    if v14:IsA("TextLabel") then
        v2 = v14
    end
end
local v15 = SakuraEggCharge:FindFirstChild("CrystalBalance", true)

if v15 then
    if v15:IsA("TextLabel") then
        v3 = v15
    end
end
local SliderBar = Content.SliderBar
local Fill = SliderBar.Progress.Fill
local Frame_3 = Fill:IsA("Frame")
assert(Frame_3, "SakuraEggCharge SliderBar.Progress.Fill must be a Frame")
local SliderButton = SliderBar.SliderButton
local ImageButton_3 = SliderButton:IsA("ImageButton")
assert(ImageButton_3, "SakuraEggCharge SliderBar.SliderButton must be an ImageButton")
local ProgressBar = Content.ProgressBar
local ImageLabel_2 = ProgressBar.Frame1.ImageLabel
local ImageLabel_3 = ImageLabel_2:IsA("ImageLabel")
assert(ImageLabel_3, "SakuraEggCharge ProgressBar.Frame1.ImageLabel must be an ImageLabel")
local UIGradient = ImageLabel_2.UIGradient
local UIGradient_2 = UIGradient:IsA("UIGradient")
assert(UIGradient_2, "SakuraEggCharge ProgressBar.Frame1.ImageLabel.UIGradient must be a UIGradient")
local ImageLabel_4 = ProgressBar.Frame2.ImageLabel
local ImageLabel_5 = ImageLabel_4:IsA("ImageLabel")
assert(ImageLabel_5, "SakuraEggCharge ProgressBar.Frame2.ImageLabel must be an ImageLabel")
local UIGradient_3 = ImageLabel_4.UIGradient
local UIGradient_4 = UIGradient_3:IsA("UIGradient")
assert(UIGradient_4, "SakuraEggCharge ProgressBar.Frame2.ImageLabel.UIGradient must be a UIGradient")
UIGradient.Enabled = true
UIGradient_3.Enabled = true

local SliderButton_2 = ProgressBar.SliderButton
local ImageButton_4 = SliderButton_2:IsA("ImageButton")
assert(ImageButton_4, "SakuraEggCharge ProgressBar.SliderButton must be an ImageButton")
local CurrentChargeLabel = Content.CurrentChargeHolder.CurrentChargeLabel
local MutationList = CurrentChargeLabel:IsA("TextLabel")
assert(MutationList, "SakuraEggCharge CurrentChargeLabel must be a TextLabel")
local SidePopUp = SakuraEggCharge.SidePopUp
MutationList = SidePopUp.MutationList
local ScrollingFrame = MutationList:IsA("ScrollingFrame")
assert(ScrollingFrame, "SakuraEggCharge SidePopUp.MutationList must be a ScrollingFrame")
local BuyLuck = SidePopUp.BuyLuck
local ImageButton_5 = BuyLuck:IsA("ImageButton")
assert(ImageButton_5, "SakuraEggCharge SidePopUp.BuyLuck must be an ImageButton")
local Price = BuyLuck.Price
local TextLabel_2 = Price:IsA("TextLabel")
assert(TextLabel_2, "SakuraEggCharge BuyLuck.Price must be a TextLabel")
local TextLabel_3 = BuyLuck.TextLabel
local TextLabel_4 = TextLabel_3:IsA("TextLabel")
assert(TextLabel_4, "SakuraEggCharge BuyLuck.TextLabel must be a TextLabel")
local EggPicker = SakuraEggCharge.EggPicker
local Frame_4 = EggPicker:IsA("Frame")
assert(Frame_4, "SakuraEggCharge.EggPicker must be a Frame")
local Eggs = EggPicker.Eggs
local ScrollingFrame_2 = Eggs:IsA("ScrollingFrame")
assert(ScrollingFrame_2, "SakuraEggCharge EggPicker.Eggs must be a ScrollingFrame")
local InventoryTemplate = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("GUI"):WaitForChild("BackpackController"):WaitForChild("Main"):WaitForChild("InventoryTemplate")
local GuiButton = InventoryTemplate:IsA("GuiButton")
assert(GuiButton, "BackpackController.Main.InventoryTemplate must be a GuiButton")
local v16, v17, v18, v19
for v20, v21 in ipairs(Deposit:GetChildren()) do
    if v21:IsA("TextLabel") then
        if v21.Text:find("Deposit") then
            v16 = v21
            v18 = v21
        else
            v17 = v21
            v19 = v21
        end
    end
end
local v22 = v18 and v19
assert(v22, "SakuraEggCharge Deposit button needs its two TextLabels")
local LockedOverlay = Mutate.LockedOverlay
v22 = LockedOverlay:IsA("Frame")
assert(v22, "SakuraEggCharge Mutate.LockedOverlay must be a Frame")
local TextLabel_5 = Mutate:FindFirstChildOfClass("TextLabel")
assert(TextLabel_5, "SakuraEggCharge Mutate button needs its ready TextLabel")
local v23, v24
for v25, v27 in ipairs(LockedOverlay:GetChildren()) do
    if v27:IsA("TextLabel") and v27.Text ~= "Mutate" then
        v23 = v27
        v24 = v27
    end
end
assert(v24, "SakuraEggCharge Mutate.LockedOverlay needs its unlock TextLabel")
local v28 = {}
for v32, v33 in ipairs(MutationList:GetChildren()) do
    if v33:IsA("Frame") and v33:FindFirstChild("MutationName") then
        table.insert(v28, v33)
    end
end
table.sort(v28, function(v34, v35) -- line 178
    return v34.AbsolutePosition.Y < v35.AbsolutePosition.Y
end)
local v36 = #v28 >= 2
assert(v36, "SakuraEggCharge MutationList needs two mutation rows")
local ImageColor3 = Icon.ImageColor3
local ImageLabel_6 = Instance.new("ImageLabel")

ImageLabel_6.Name = "ClickIndicator"
ImageLabel_6.Image = "rbxassetid://96606025304766"
ImageLabel_6.BackgroundTransparency = 1
ImageLabel_6.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_6.Position = UDim2.fromScale(0.8, 0.8)
ImageLabel_6.Size = UDim2.fromScale(0.45, 0.45)
ImageLabel_6.ZIndex = Icon.ZIndex + 2
ImageLabel_6.Visible = false
Instance.new("UIAspectRatioConstraint").Parent = ImageLabel_6

local UIScale = Instance.new("UIScale")

UIScale.Parent = ImageLabel_6
ImageLabel_6.Parent = Icon

local v37 = TweenService:Create(UIScale, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), { Scale = 1.3 })

local function v26(v38) -- line 200 | captures: ImageLabel_6, UIScale, v37
    if ImageLabel_6.Visible ~= v38 then
        ImageLabel_6.Visible = v38
        if v38 then
            UIScale.Scale = 1
            v37:Play()
        else
            v37:Cancel()
        end
    end
end

local BackgroundColor3 = Mutate.BackgroundColor3
local v39 = BackgroundColor3:Lerp(Color3.new(0, 0, 0), 0.45)
local BackgroundColor3_2 = Deposit.BackgroundColor3
BackgroundColor3_2:Lerp(Color3.new(0, 0, 0), 0.45)
local v40 = Trove.new()
local v41 = 1
local v42 = false
local v43 = false
local v44 = true
local v45 = {}

local function notifyError(v46) -- line 224 | captures: Message_2, v5
    Message_2.Bottom({
        Time = 3,
        Message = v46,
        Color = v5
    })
end

local function getState() -- line 227 | captures: Save
    local v47 = Save.Get()
    if v47 == nil then
        return nil, 0
    end
    return v47.Sakura, v47.SakuraCrystals
end

local function isUnlocked() -- line 234 | captures: SakuraBloomPolicy, Save
    local v48 = Save.IsLocalDataLoaded()
    local v49
    if v48 then
        v49 = Save.Get()
    end
    return SakuraBloomPolicy.HasBloomUnlocked(v48, v49)
end

local function getRarityNumber(v50) -- line 244 | captures: Directory
    local v51 = Directory[v50]
    local v52 = v51 ~= nil
    local v53 = ("Missing asset config %*"):format(v50)
    assert(v52, v53)
    return v51.Rarity.RarityNumber
end

local function getRequired(v54) -- line 250 | captures: Sakura
    if v54.Egg == false then
        return 0
    end
    return Sakura.GetRequiredCrystals()
end

local function getDepositCapacity(v55, v56) -- line 256 | captures: Sakura
    local v57
    if v55.Egg == false then
        v57 = 0
    else
        v57 = Sakura.GetRequiredCrystals()
    end
    if v57 <= 0 then
        return 0
    end
    local v58 = Sakura.GetFreeChargeCap(v57) - v55.Deposited
    local v59 = math.min(v56, v58)
    return (math.max(0, v59))
end

local function getSliderAmount(v60, v61) -- line 269 | captures: v41, Sakura
    local v62
    if v60.Egg == false then
        v62 = 0
    else
        v62 = Sakura.GetRequiredCrystals()
    end
    local v63
    if v62 > 0 then
        local v64 = Sakura.GetFreeChargeCap(v62) - v60.Deposited
        local v65 = math.min(v61, v64)
        v63 = math.max(0, v65)
    else
        v63 = 0
    end
    if v63 <= 0 then
        return 0
    end
    local v66 = v63 * v41 + 0.5
    local v67 = math.floor(v66)
    return (math.max(1, v67))
end

local v68 = NumberSequence.new(1)
local v69 = NumberSequence.new(0)

local function applyArcCut(v70, v71, v72, v73) -- line 289 | captures: v68, v69
    local AbsoluteSize = v71.AbsoluteSize
    local v74 = math.rad(v73)
    local v75 = math.cos(v74)
    local new = Vector2.new
    local v76 = math.rad(v73)
    local v77 = new(v75, (math.sin(v76)))
    local X = AbsoluteSize.X
    local X_2 = v77.X
    local v78 = X * math.abs(X_2)
    local Y = AbsoluteSize.Y
    local Y_2 = v77.Y
    local v79 = v78 + Y * math.abs(Y_2)
    if v79 <= 0 then
        return
    end
    local v80 = 0.5 + (v72 - (v71.AbsolutePosition + AbsoluteSize / 2)):Dot(v77) / v79
    v70.Rotation = v73
    if v80 <= 0.001 then
        v70.Transparency = v68
    elseif v80 >= 1 then
        v70.Transparency = v69
    else
        local v81 = {}
        local v82 = NumberSequenceKeypoint.new(0, 0)
        local v83 = NumberSequenceKeypoint.new(v80 - 0.001, 0)
        local v84 = NumberSequenceKeypoint.new(v80, 1)
        v81[1] = v82
        v81[2] = v83
        v81[3] = v84
        v81[4] = NumberSequenceKeypoint.new(1, 1)
        v70.Transparency = NumberSequence.new(v81)
    end
end

local function setArc(v85) -- line 318 | captures: Sakura, ProgressBar, ImageLabel_2, UIGradient, ImageLabel_4, UIGradient_3, SliderButton_2, v68, v69, applyArcCut
    local v86 = v85 / Sakura.Incubator.MaxChargePercent
    local v87 = math.clamp(v86, 0, 1)
    local v88 = 3.4173546754048973 - v87 * 3.693116697220001
    local v89 = math.cos(v88) * 0.473 + 0.5
    SliderButton_2.Position = UDim2.fromScale(v89, 0.7587 - math.sin(v88) * 0.7207)
    local AbsoluteSize = ProgressBar.AbsoluteSize
    local v90 = 0.7207 * AbsoluteSize.Y * math.sin(v88)
    local v91 = 0.473 * AbsoluteSize.X * math.cos(v88)
    local v92 = math.atan2(v90, v91)
    local v93 = math.deg(v92)
    if v93 < -90 then
        v93 += 360
    end
    local v94 = 90 - v93
    local v95 = ProgressBar.AbsolutePosition + Vector2.new(0.5 * AbsoluteSize.X, 0.7587 * AbsoluteSize.Y)
    if v87 > 0 then
        applyArcCut(UIGradient, ImageLabel_2, v95, (math.clamp(v94, -180, 0)))
    else
        UIGradient.Transparency = v68
    end
    if v87 >= 1 then
        UIGradient_3.Transparency = v69
    else
        applyArcCut(UIGradient_3, ImageLabel_4, v95, (math.clamp(v94, 0, 180)))
    end
end

local NumberValue = Instance.new("NumberValue")
local v96
NumberValue.Changed:Connect(function(v97) -- line 345 | captures: CurrentChargeLabel, setArc
    setArc(v97)
    local v98 = v97 + 0.5
    CurrentChargeLabel.Text = ("%*%%"):format((math.floor(v98)))
end)

local function showCharge(v99, v100) -- line 349 | captures: v96, TweenService, CurrentChargeLabel, setArc, NumberValue
    if v96 then
        v96:Cancel()
        v96 = nil
    end
    if v100 then
        NumberValue.Value = v99
        setArc(v99)
        local v101 = v99 + 0.5
        CurrentChargeLabel.Text = ("%*%%"):format((math.floor(v101)))
    else
        local v102 = NumberValue.Value - v99
        if math.abs(v102) < 0.01 then
            NumberValue.Value = v99
            setArc(v99)
            local v103 = v99 + 0.5
            CurrentChargeLabel.Text = ("%*%%"):format((math.floor(v103)))
        else
            local v104 = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local v105 = TweenService:Create(NumberValue, v104, { Value = v99 })
            v96 = v105
            v105:Play()
        end
    end
end

local function v29(v106) -- line 372 | captures: v41, Fill, SliderButton
    v41 = math.clamp(v106, 0, 1)
    Fill.Size = UDim2.fromScale(v41, 1)
    SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
end

local v107

local function getProductPrice(v108) -- line 378 | captures: v107, MarketplaceService, Products, v45
    local v109 = Products.Directory[v108]
    local v110 = v45[v109.ProductId]
    if v110 then
        return v110
    end
    task.spawn(function() -- line 384 | captures: v109, v107, MarketplaceService, v45
        local v111, v112 = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v109.ProductId, Enum.InfoType.Product)
        if v111 and v112 and v112.PriceInRobux then
            v45[v109.ProductId] = v112.PriceInRobux
            v107()
        end
    end)
    return nil
end

local function renderEggIcon(v113) -- line 394 | captures: Directory, Icon, Title, ImageColor3, ImageLabel_6, UIScale, v37
    local Egg = v113.Egg
    if Egg == false then
        Icon.Image = "rbxassetid://111633736515788"
        Icon.ImageColor3 = ImageColor3
        Title.Visible = true
        if ImageLabel_6.Visible ~= true then
            ImageLabel_6.Visible = true
            UIScale.Scale = 1
            v37:Play()
        end
    else
        local v114 = Directory[Egg.Egg.AssetCategory]
        local v115 = v114 ~= nil
        local v116 = ("Missing asset config %*"):format(Egg.Egg.AssetCategory)
        assert(v115, v116)
        Icon.Image = v114.Egg.Icon
        Icon.ImageColor3 = Color3.new(1, 1, 1)
        Title.Visible = false
        if ImageLabel_6.Visible ~= false then
            ImageLabel_6.Visible = false
            v37:Cancel()
        end
    end
end

local function renderMutationRows(v117, v118) -- line 420 | captures: Mutations, Sakura, v28
    local v119 = {}
    local v120 = {
        Name = Sakura.MutationName,
        Chance = Sakura.GetEffectiveMutationChance(v117, v118)
    }
    local v121 = {
        Name = Sakura.SpecialMutationName,
        Chance = Sakura.GetSpecialChance(v117, v118)
    }
    v119[1] = v120
    v119[2] = v121
    for v122, v123 in ipairs(v119) do
        local v124 = v28[v122]
        local MutationName = v124.MutationName
        local ChanceLabel = v124.ChanceLabel
        local v125 = MutationName:IsA("TextLabel") and ChanceLabel:IsA("TextLabel")
        assert(v125, "Mutation row needs MutationName and ChanceLabel")
        local v126 = Mutations.Get(v123.Name)
        MutationName.Text = Mutations.LabelOf(v123.Name)
        if v126 then
            MutationName.TextColor3 = v126.Tint
        end
        ChanceLabel.Text = string.format("%.1f%%", v123.Chance):gsub("%.0%%", "%%")
    end
end

local function renderCost() -- line 445 | captures: v2, Sakura, Simple
    local v127 = ("Mutation Cost: <font color=\"#FF69B4\">%* crystals</font>"):format((Simple.FormatCompact(Sakura.GetRequiredCrystals())))
    if v2 then
        v2.Text = v127
    end
end

local function render() -- line 451 | captures: v1, v2, v3, v16, v17, v23, v41, v44, v107, MarketplaceService, Products, Sakura, Save, Simple, v4, Mutate, Deposit, SliderBar, BuyLuck, Price, TextLabel_3, LockedOverlay, TextLabel_5, BackgroundColor3, v39, BackgroundColor3_2, v45, showCharge, renderEggIcon, renderMutationRows
    local v128 = Save.Get()
    local Sakura_2, v129
    if v128 == nil then
        v129 = 0
    else
        Sakura_2 = v128.Sakura
        v129 = v128.SakuraCrystals
    end
    if Sakura_2 == nil then
        return
    end
    local v130
    if Sakura_2.Egg == false then
        v130 = 0
    else
        v130 = Sakura.GetRequiredCrystals()
    end
    local v131 = Sakura.GetChargePercent(Sakura_2.Deposited, v130)
    local v132 = Sakura_2.Egg ~= false
    local v133 = v131 >= 100
    local v134
    if Sakura_2.Egg == false then
        v134 = 0
    else
        v134 = Sakura.GetRequiredCrystals()
    end
    local v135
    if v134 > 0 then
        local v136 = Sakura.GetFreeChargeCap(v134) - Sakura_2.Deposited
        local v137 = math.min(v129, v136)
        v135 = math.max(0, v137)
    else
        v135 = 0
    end
    local v138 = v132 and Sakura.GetFreeChargeCap(v130) <= Sakura_2.Deposited
    renderEggIcon(Sakura_2)
    showCharge(v131, v44)
    v44 = false
    if v3 then
        v3.Text = ("You have <font color=\"#FF69B4\">%*</font> crystals"):format((Simple.FormatCompact(v129)))
    end
    if v1 then
        v1.Visible = v132
    end
    local v139 = ("Mutation Cost: <font color=\"#FF69B4\">%* crystals</font>"):format((Simple.FormatCompact(Sakura.GetRequiredCrystals())))
    if v2 then
        v2.Text = v139
    end
    renderMutationRows(v131, Sakura_2.LuckBoost)
    local v140
    if Sakura_2.Egg == false then
        v140 = 0
    else
        v140 = Sakura.GetRequiredCrystals()
    end
    local v141
    if v140 > 0 then
        local v142 = Sakura.GetFreeChargeCap(v140) - Sakura_2.Deposited
        local v143 = math.min(v129, v142)
        v141 = math.max(0, v143)
    else
        v141 = 0
    end
    local v144
    if v141 > 0 then
        local v145 = v141 * v41 + 0.5
        local v146 = math.floor(v145)
        v144 = math.max(1, v146)
    else
        v144 = 0
    end
    local v147 = v132 and v135 > 0
    SliderBar.Visible = v147
    if v132 then
        if v144 > 0 then
            Deposit.Active = true
            Deposit.BackgroundColor3 = BackgroundColor3_2
            v16.Text = ("Deposit %*"):format((Simple.FormatCompact(v144)))
            local v148 = v17
            local v149 = v144 / v130 * 100 + 0.5
            v148.Text = ("+%*%% Charge"):format((math.floor(v149)))
        end
    else
        Deposit.Active = true
        Deposit.BackgroundColor3 = BackgroundColor3_2
        v16.Text = "Place Egg"
        v17.Text = "Choose an egg to mutate"
    end
    Mutate.Active = v133
    local v150 = if v133 then BackgroundColor3 else v39
    Mutate.BackgroundColor3 = v150
    LockedOverlay.Visible = not v133
    TextLabel_5.Visible = v133
    v23.Text = "(Unlocks at 100%)"
    local MaxLuckBoosts = Sakura.Incubator.MaxLuckBoosts
    local v151 = v132 and Sakura_2.LuckBoost < MaxLuckBoosts
    BuyLuck.Visible = v151
    local v152 = Sakura.GetLuckMultiplier(Sakura_2.LuckBoost + 1)
    TextLabel_3.Text = ("<font color=\"#FF69B4\">%*x</font> Great Bloom Odds (%*/%*)"):format(v152, Sakura_2.LuckBoost, MaxLuckBoosts)
    local v153 = Sakura.Incubator.LuckBoostProductNames[Sakura_2.LuckBoost + 1]
    local v154
    if v153 then
        local v155 = Products.Directory[v153]
        v154 = v45[v155.ProductId]
        if not v154 then
            task.spawn(function() -- line 570 | captures: v155, v107, MarketplaceService, v45
                local v156, v157 = pcall(MarketplaceService.GetProductInfo, MarketplaceService, v155.ProductId, Enum.InfoType.Product)
                if v156 and v157 and v157.PriceInRobux then
                    v45[v155.ProductId] = v157.PriceInRobux
                    v107()
                end
            end)
            v154 = nil
        end
    end
    local v158
    if v154 then
        v158 = ("%*%*"):format(v4, v154)
    else
        v158 = ""
    end
    Price.Text = v158
end

function v107() -- line 590 | captures: v43, render
    if not v43 then
        v43 = true
        task.defer(function() -- line 595 | captures: v43, render
            v43 = false
            render()
        end)
    end
end

local function closePicker() -- line 600 | captures: EggPicker, v40
    v40:Clean()
    EggPicker.Visible = false
end

local function requestInsert(v159) -- line 604 | captures: v41, v107, Message_2, Remotes, v5, v7, Fill, SliderButton, EggPicker, v40
    v7(function() -- line 605 | captures: v159, v41, v107, Message_2, Remotes, v5, Fill, SliderButton, EggPicker, v40
        local v160, v161 = Remotes.Bloomery.AskLoadEgg:InvokeServer(v159)
        if v160 then
            v40:Clean()
            EggPicker.Visible = false
            v41 = 1
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            v107()
        else
            if typeof(v161) ~= "string" then
                v161 = "Failed to place egg"
            end
            Message_2.Bottom({
                Time = 3,
                Message = v161,
                Color = v5
            })
        end
    end)
end

local function buildPickerRow(v162, v163, v164) -- line 626 | captures: v41, v107, Directory, ButtonFX, EggRecords, Message_2, Remotes, v5, v7, Fill, SliderButton, EggPicker, Eggs, InventoryTemplate, v40
    local v165 = EggRecords.Decode(v163)
    local v166 = Directory[v165.AssetCategory]
    local v167 = v166 ~= nil
    local v168 = ("Missing asset config %*"):format(v165.AssetCategory)
    assert(v167, v168)
    local v169 = InventoryTemplate:Clone()
    v169.Name = ("SakuraEgg.%*"):format(v162)
    v169.LayoutOrder = v164
    v169.Active = true
    v169.AutoButtonColor = false
    v169.BackgroundColor3 = Color3.new(0, 0, 0)
    v169.BackgroundTransparency = 0.5
    v169.Visible = true
    local UIStroke = v169:FindFirstChild("UIStroke")
    if UIStroke and UIStroke:IsA("UIStroke") then
        UIStroke.Thickness = 0
    end
    local Icon = v169.Icon
    local ImageLabel = Icon:IsA("ImageLabel")
    assert(ImageLabel, "Inventory row Icon must be an ImageLabel")
    Icon.Image = v166.Egg.Icon
    Icon.ImageColor3 = Color3.new(1, 1, 1)
    local ToolName = v169.ToolName
    local TextLabel = ToolName:IsA("TextLabel")
    assert(TextLabel, "Inventory row ToolName must be a TextLabel")
    for v170, v171 in ipairs(ToolName:GetChildren()) do
        if v171:IsA("UIGradient") then
            v171:Destroy()
        end
    end
    v166.Rarity.RarityGradient:Clone().Parent = ToolName
    ToolName.Text = EggRecords.DisplayNameWithWeight(v165)
    ToolName.Visible = true
    local v172 = { "FavIcon", "Weight", "Shadow", "Shadow_2" }
    for v173, v174 in ipairs(v172) do
        local v175 = v169:FindFirstChild(v174)
        if v175 and v175:IsA("GuiObject") then
            v175.Visible = false
        end
    end
    local BaseTemplate = v169:FindFirstChild("BaseTemplate")
    if BaseTemplate then
        for v176, v177 in ipairs(BaseTemplate:GetChildren()) do
            if v177:IsA("GuiObject") then
                v177.Visible = false
            end
        end
    end
    v169.Parent = Eggs
    v40:Add(v169)
    local Activated = v169.Activated
    v40:Add(Activated:Connect(function() -- line 677 | captures: v162, v41, v107, Message_2, Remotes, v5, v7, Fill, SliderButton, EggPicker, v40
        v7(function() -- line 679 | captures: v162, v41, v107, Message_2, Remotes, v5, Fill, SliderButton, EggPicker, v40
            local v178, v179 = Remotes.Bloomery.AskLoadEgg:InvokeServer(v162)
            if v178 then
                v40:Clean()
                EggPicker.Visible = false
                v41 = 1
                Fill.Size = UDim2.fromScale(v41, 1)
                SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
                v107()
            else
                if typeof(v179) ~= "string" then
                    v179 = "Failed to place egg"
                end
                Message_2.Bottom({
                    Time = 3,
                    Message = v179,
                    Color = v5
                })
            end
        end)
    end))
    ButtonFX(v169)
end

local function openPicker() -- line 702 | captures: Directory, Message_2, Sakura, Save, v5, EggPicker, Eggs, v40, buildPickerRow
    local v180 = Save.Get()
    local v181 = Save.Get()
    local Sakura_2
    if v181 == nil then
    else
        Sakura_2 = v181.Sakura
    end
    if v180 ~= nil and Sakura_2 ~= nil then
        if Sakura_2.Unlocked then
            if Sakura_2.Egg == false then
                v40:Clean()
                local v182 = {}
                for v183, v184 in pairs(v180.EggInventory) do
                    if v184.Placement == nil and not Sakura.HasSakuraMutation(v184.Mutations) then
                        table.insert(v182, v183)
                    end
                end
                if #v182 == 0 then
                    local v185 = 0
                    for v186, v187 in pairs(v180.EggInventory) do
                        if v187.Placement ~= nil then
                            v185 += 1
                        end
                    end
                    if v185 > 0 then
                        Message_2.Bottom({
                            Message = "All your eggs are placed - pick one up from your pen first!",
                            Time = 3,
                            Color = v5
                        })
                    else
                        Message_2.Bottom({
                            Message = "You have no eggs to mutate - steal or hatch one first!",
                            Time = 3,
                            Color = v5
                        })
                    end
                else
                    table.sort(v182, function(v188, v189) -- line 729 | captures: v180, Directory
                        local AssetCategory = v180.EggInventory[v188].AssetCategory
                        local v190 = Directory[AssetCategory]
                        local v191 = v190 ~= nil
                        local v192 = ("Missing asset config %*"):format(AssetCategory)
                        assert(v191, v192)
                        local RarityNumber = v190.Rarity.RarityNumber
                        local AssetCategory_2 = v180.EggInventory[v189].AssetCategory
                        local v193 = Directory[AssetCategory_2]
                        local v194 = v193 ~= nil
                        local v195 = ("Missing asset config %*"):format(AssetCategory_2)
                        assert(v194, v195)
                        local RarityNumber_2 = v193.Rarity.RarityNumber
                        if RarityNumber == RarityNumber_2 then
                            return v188 < v189
                        end
                        return RarityNumber_2 < RarityNumber
                    end)
                    for v196, v197 in ipairs(v182) do
                        buildPickerRow(v197, v180.EggInventory[v197], v196)
                    end
                    Eggs.CanvasPosition = Vector2.zero
                    EggPicker.Visible = true
                end
            end
        else
            Message_2.Bottom({
                Message = "The Sakura Incubator is still sealed",
                Time = 3,
                Color = v5
            })
        end
    end
end

local function playDepositFlyIn() -- line 766 | captures: TweenService, Content, EggIconHolder, Deposit
    for v198 = 1, 6 do
        local delay = task.delay
        local v199 = (v198 - 1) * 0.05
        delay(v199, function() -- line 771 | captures: TweenService, Content, EggIconHolder, Deposit
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Image = "rbxassetid://71612969542341"
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel.Size = UDim2.fromScale(0.05, 0.08)
            local v200 = Deposit.Position.X.Scale + (math.random() - 0.5) * 0.1
            ImageLabel.Position = UDim2.fromScale(v200, Deposit.Position.Y.Scale)
            ImageLabel.ZIndex = 20
            ImageLabel.Parent = Content
            local v201 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local v202 = TweenService:Create(ImageLabel, v201, {
                Position = UDim2.fromScale(EggIconHolder.Position.X.Scale, EggIconHolder.Position.Y.Scale),
                Size = UDim2.fromScale(0.02, 0.03)
            })
            v202.Completed:Once(function() -- line 783 | captures: ImageLabel
                ImageLabel:Destroy()
            end)
            v202:Play()
        end)
    end
    task.wait(0.75)
end

local function updateSliderFromInput(v203) -- line 791 | captures: v41, SliderBar, Fill, SliderButton, render
    local X = SliderBar.AbsoluteSize.X
    if X <= 0 then
        return
    end
    local v204 = (v203.X - SliderBar.AbsolutePosition.X) / X
    v41 = math.clamp(v204, 0, 1)
    Fill.Size = UDim2.fromScale(v41, 1)
    SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
    render()
end

EggPicker.Visible = false
v41 = 1
Fill.Size = UDim2.fromScale(v41, 1)
SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
GUI.ButtonActivated(Deposit, function() -- line 805 | captures: v41, v107, Message_2, Remotes, Sakura, Save, v5, v7, openPicker, playDepositFlyIn
    local v205 = Save.Get()
    local Sakura_2
    if v205 == nil then
    else
        Sakura_2 = v205.Sakura
    end
    if Sakura_2 == nil then
        v7(function() -- line 814 | captures: v41, v107, Message_2, Remotes, Sakura, Save, v5, playDepositFlyIn
            local v206 = Save.Get()
            local Sakura_2, v207
            if v206 == nil then
                v207 = 0
            else
                Sakura_2 = v206.Sakura
                v207 = v206.SakuraCrystals
            end
            if Sakura_2 == nil or Sakura_2.Egg == false then
                return
            end
            local v208
            if Sakura_2.Egg == false then
                v208 = 0
            else
                v208 = Sakura.GetRequiredCrystals()
            end
            local v209
            if v208 > 0 then
                local v210 = Sakura.GetFreeChargeCap(v208) - Sakura_2.Deposited
                local v211 = math.min(v207, v210)
                v209 = math.max(0, v211)
            else
                v209 = 0
            end
            local v212
            if v209 > 0 then
                local v213 = v209 * v41 + 0.5
                local v214 = math.floor(v213)
                v212 = math.max(1, v214)
            else
                v212 = 0
            end
            if v212 <= 0 then
                Message_2.Bottom({
                    Message = "You have no Sakura Crystals to deposit",
                    Time = 3,
                    Color = v5
                })
            else
                playDepositFlyIn()
                local v215, v216 = Remotes.Bloomery.AskHandoff:InvokeServer(v212)
                if v215 then
                    v107()
                else
                    local v217 = if typeof(v216) == "string" then v216 else "Failed to deposit"
                    Message_2.Bottom({
                        Time = 3,
                        Message = v217,
                        Color = v5
                    })
                end
            end
        end)
    elseif Sakura_2.Egg == false then
        openPicker()
    else
        v7(function() -- line 866 | captures: v41, v107, Message_2, Remotes, Sakura, Save, v5, playDepositFlyIn
            local v218 = Save.Get()
            local Sakura_2, v219
            if v218 == nil then
                v219 = 0
            else
                Sakura_2 = v218.Sakura
                v219 = v218.SakuraCrystals
            end
            if Sakura_2 == nil or Sakura_2.Egg == false then
                return
            end
            local v220
            if Sakura_2.Egg == false then
                v220 = 0
            else
                v220 = Sakura.GetRequiredCrystals()
            end
            local v221
            if v220 > 0 then
                local v222 = Sakura.GetFreeChargeCap(v220) - Sakura_2.Deposited
                local v223 = math.min(v219, v222)
                v221 = math.max(0, v223)
            else
                v221 = 0
            end
            local v224
            if v221 > 0 then
                local v225 = v221 * v41 + 0.5
                local v226 = math.floor(v225)
                v224 = math.max(1, v226)
            else
                v224 = 0
            end
            if v224 <= 0 then
                Message_2.Bottom({
                    Message = "You have no Sakura Crystals to deposit",
                    Time = 3,
                    Color = v5
                })
            else
                playDepositFlyIn()
                local v227, v228 = Remotes.Bloomery.AskHandoff:InvokeServer(v224)
                if v227 then
                    v107()
                else
                    local v229 = if typeof(v228) == "string" then v228 else "Failed to deposit"
                    Message_2.Bottom({
                        Time = 3,
                        Message = v229,
                        Color = v5
                    })
                end
            end
        end)
    end
end)
ButtonFX(Deposit)
GUI.ButtonActivated(Mutate, function() -- line 914 | captures: v107, Message_2, Remotes, SakuraSignals, Sakura_2, v5, v6, v7
    v7(function() -- line 915 | captures: v107, Message_2, Remotes, SakuraSignals, Sakura_2, v5, v6
        local v230, v231, v232 = Remotes.Bloomery.AskMutate:InvokeServer()
        if v230 then
            if Sakura_2.MutateResult(v232) then
                SakuraSignals.Reveal:Fire(v232)
                v107()
            else
                v6:AtError():Log("Sakura mutate returned an invalid result")
            end
        else
            if typeof(v231) ~= "string" then
                v231 = "Failed to mutate"
            end
            Message_2.Bottom({
                Time = 3,
                Message = v231,
                Color = v5
            })
        end
    end)
end)
ButtonFX(Mutate)

if v1 then
    v1.Visible = false
    GUI.ButtonActivated(v1, function() -- line 939 | captures: v107, Message, Message_2, Remotes, Save, v5, v7
        local v233 = Save.Get()
        local Sakura
        if v233 == nil then
        else
            Sakura = v233.Sakura
        end
        if Sakura ~= nil and Sakura.Egg ~= false then
            if Sakura.Deposited > 0 then
                if Message.Prompt("Remove this egg? Its charge and luck will be lost.", true) then
                    v7(function() -- line 954 | captures: v107, Message_2, Remotes, v5
                        local v234, v235 = Remotes.Bloomery.AskEjectEgg:InvokeServer()
                        if v234 then
                            v107()
                        else
                            if typeof(v235) ~= "string" then
                                v235 = "Failed to remove egg"
                            end
                            Message_2.Bottom({
                                Time = 3,
                                Message = v235,
                                Color = v5
                            })
                        end
                    end)
                end
            elseif Sakura.LuckBoost <= 0 then
                v7(function() -- line 971 | captures: v107, Message_2, Remotes, v5
                    local v236, v237 = Remotes.Bloomery.AskEjectEgg:InvokeServer()
                    if v236 then
                        v107()
                    else
                        if typeof(v237) ~= "string" then
                            v237 = "Failed to remove egg"
                        end
                        Message_2.Bottom({
                            Time = 3,
                            Message = v237,
                            Color = v5
                        })
                    end
                end)
            elseif Message.Prompt("Remove this egg? Its charge and luck will be lost.", true) then
                v7(function() -- line 990 | captures: v107, Message_2, Remotes, v5
                    local v238, v239 = Remotes.Bloomery.AskEjectEgg:InvokeServer()
                    if v238 then
                        v107()
                    else
                        if typeof(v239) ~= "string" then
                            v239 = "Failed to remove egg"
                        end
                        Message_2.Bottom({
                            Time = 3,
                            Message = v239,
                            Color = v5
                        })
                    end
                end)
            end
        end
    end)
    ButtonFX(v1)
end
GUI.ButtonActivated(BuyLuck, function() -- line 1007 | captures: Products, PromptPurchase, Sakura, Save
    local v240 = Save.Get()
    local v241 = v240 and Sakura.Incubator.LuckBoostProductNames[v240.Sakura.LuckBoost + 1]
    if v241 then
        PromptPurchase.Prompt(Products.Directory[v241].ProductId, true)
    end
end)
ButtonFX(BuyLuck)
Icon.Active = true
Icon.InputBegan:Connect(function(v242) -- line 1020 | captures: openPicker
    if v242.UserInputType == Enum.UserInputType.MouseButton1 or v242.UserInputType == Enum.UserInputType.Touch then
        openPicker()
    end
end)
SliderButton.InputBegan:Connect(function(v243) -- line 1027 | captures: v42
    if v243.UserInputType == Enum.UserInputType.MouseButton1 or v243.UserInputType == Enum.UserInputType.Touch then
        v42 = true
    end
end)
SliderBar.InputBegan:Connect(function(v244) -- line 1034 | captures: v41, v42, SliderBar, Fill, SliderButton, render
    if v244.UserInputType == Enum.UserInputType.MouseButton1 then
        v42 = true
        local v245 = Vector2.new(v244.Position.X, v244.Position.Y)
        local X = SliderBar.AbsoluteSize.X
        if not (X <= 0) then
            local v246 = (v245.X - SliderBar.AbsolutePosition.X) / X
            v41 = math.clamp(v246, 0, 1)
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            render()
        end
    elseif v244.UserInputType == Enum.UserInputType.Touch then
        v42 = true
        local v247 = Vector2.new(v244.Position.X, v244.Position.Y)
        local X = SliderBar.AbsoluteSize.X
        if not (X <= 0) then
            local v248 = (v247.X - SliderBar.AbsolutePosition.X) / X
            v41 = math.clamp(v248, 0, 1)
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            render()
        end
    end
end)
UserInputService.InputChanged:Connect(function(v249) -- line 1063 | captures: v41, v42, SliderBar, Fill, SliderButton, render
    if v42 then
        if v249.UserInputType == Enum.UserInputType.MouseMovement then
            local v250 = Vector2.new(v249.Position.X, v249.Position.Y)
            local X = SliderBar.AbsoluteSize.X
            if not (X <= 0) then
                local v251 = (v250.X - SliderBar.AbsolutePosition.X) / X
                v41 = math.clamp(v251, 0, 1)
                Fill.Size = UDim2.fromScale(v41, 1)
                SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
                render()
            end
        elseif v249.UserInputType == Enum.UserInputType.Touch then
            local v252 = Vector2.new(v249.Position.X, v249.Position.Y)
            local X = SliderBar.AbsoluteSize.X
            if not (X <= 0) then
                local v253 = (v252.X - SliderBar.AbsolutePosition.X) / X
                v41 = math.clamp(v253, 0, 1)
                Fill.Size = UDim2.fromScale(v41, 1)
                SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
                render()
            end
        end
    end
end)
UserInputService.InputEnded:Connect(function(v254) -- line 1093 | captures: v42
    if v254.UserInputType == Enum.UserInputType.MouseButton1 or v254.UserInputType == Enum.UserInputType.Touch then
        v42 = false
    end
end)
Save.WatchFields({ "Sakura", "SakuraCrystals", "EggInventory" }, function() -- line 1100 | captures: v107, SakuraBloomPolicy, Save, Tabs
    if not Tabs.IsShowing("SakuraEggCharge") then
        return
    end
    local v255 = Save.IsLocalDataLoaded()
    local v256
    if v255 then
        v256 = Save.Get()
    end
    if SakuraBloomPolicy.HasBloomUnlocked(v255, v256) then
        v107()
    else
        Tabs.Dismiss(true)
    end
end)

local function v30() -- line 1117 | captures: v41, ContextActionService, Fill, SliderButton, render
    ContextActionService:BindActionAtPriority("SakuraDepositSlider", function(v257, v258, v259) -- line 1118 | captures: v41, Fill, SliderButton, render
        if v258 == Enum.UserInputState.Begin then
            local v260 = if v259.KeyCode == Enum.KeyCode.ButtonR1 then 0.1 else -0.1
            local v261 = v41 + v260
            v41 = math.clamp(v261, 0, 1)
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            render()
            return Enum.ContextActionResult.Sink
        end
        return Enum.ContextActionResult.Pass
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
end

local function v31() -- line 1135 | captures: ContextActionService
    ContextActionService:UnbindAction("SakuraDepositSlider")
end

if v13 then
    GUI.ButtonActivated(v13, function() -- line 1139 | captures: SakuraBloomPolicy, SakuraSignals, Save, Tabs
        local v262 = Save.IsLocalDataLoaded()
        local v263
        if v262 then
            v263 = Save.Get()
        end
        if SakuraBloomPolicy.HasBloomUnlocked(v262, v263) then
            Tabs.Dismiss(true)
            SakuraSignals.ShowTutorial:Fire()
        end
    end)
    ButtonFX(v13)
end
Tabs.Shown:Connect(function(v264) -- line 1155 | captures: v41, v44, v107, ContextActionService, Players, ButtonHintStrip, ClientGlobals, SakuraBloomPolicy, SakuraSignals, Save, Tabs, Fill, SliderButton, render
    if v264 ~= "SakuraEggCharge" then
        return
    end
    local v265 = Save.IsLocalDataLoaded()
    local v266
    if v265 then
        v266 = Save.Get()
    end
    if SakuraBloomPolicy.HasBloomUnlocked(v265, v266) then
        local v267 = Save.Get()
        if Players.LocalPlayer:GetAttribute("SakuraTutorialSkip") or v267 == nil then
            v41 = 1
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            v44 = true
            v107()
            ContextActionService:BindActionAtPriority("SakuraDepositSlider", function(v268, v269, v270) -- line 1177 | captures: v41, Fill, SliderButton, render
                if v269 == Enum.UserInputState.Begin then
                    local v271 = if v270.KeyCode == Enum.KeyCode.ButtonR1 then 0.1 else -0.1
                    local v272 = v41 + v271
                    v41 = math.clamp(v272, 0, 1)
                    Fill.Size = UDim2.fromScale(v41, 1)
                    SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
                    render()
                    return Enum.ContextActionResult.Sink
                end
                return Enum.ContextActionResult.Pass
            end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
            if ClientGlobals.Console then
                ButtonHintStrip.Present("SakuraDepositSlider", Enum.KeyCode.ButtonR1, "Deposit Amount")
            end
        elseif v267.Sakura.TutorialSeen then
            v41 = 1
            Fill.Size = UDim2.fromScale(v41, 1)
            SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
            v44 = true
            v107()
            ContextActionService:BindActionAtPriority("SakuraDepositSlider", function(v273, v274, v275) -- line 1208 | captures: v41, Fill, SliderButton, render
                if v274 == Enum.UserInputState.Begin then
                    local v276 = if v275.KeyCode == Enum.KeyCode.ButtonR1 then 0.1 else -0.1
                    local v277 = v41 + v276
                    v41 = math.clamp(v277, 0, 1)
                    Fill.Size = UDim2.fromScale(v41, 1)
                    SliderButton.Position = UDim2.fromScale(v41, SliderButton.Position.Y.Scale)
                    render()
                    return Enum.ContextActionResult.Sink
                end
                return Enum.ContextActionResult.Pass
            end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
            if ClientGlobals.Console then
                ButtonHintStrip.Present("SakuraDepositSlider", Enum.KeyCode.ButtonR1, "Deposit Amount")
            end
        else
            Tabs.Dismiss(true)
            SakuraSignals.ShowTutorial:Fire()
        end
    else
        Tabs.Dismiss(true)
    end
end)
Tabs.Hidden:Connect(function(v278) -- line 1228 | captures: ContextActionService, ButtonHintStrip, EggPicker, v40
    if v278 ~= "SakuraEggCharge" then
        return
    end
    v40:Clean()
    EggPicker.Visible = false
    ContextActionService:UnbindAction("SakuraDepositSlider")
    ButtonHintStrip.Retract("SakuraDepositSlider")
end)
render()
