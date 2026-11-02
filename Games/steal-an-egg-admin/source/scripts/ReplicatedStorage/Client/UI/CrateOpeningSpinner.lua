-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Layout = require(ReplicatedStorage.Shared.Utils.Layout)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = {
    Fallback = "rbxassetid://116351329433541",
    Glow = "rbxassetid://109516122757226",
    GlowScale = 1.1,
    GlowTransparency = 0.45,
    CenterY = 0.3,
    Size = 0.54
}
local v2 = Random.new()
local LocalPlayer = Players.LocalPlayer
local v3 = assert(LocalPlayer, "Crate spinner requires a local player")
local v4 = false
local v5 = {}

local function waitForChild(v6, v7) -- line 32
    local v10 = v6:WaitForChild(v7, 5)
    local v11 = v10 ~= nil
    local v12 = ("%*.%* did not load"):format(v6:GetFullName(), v7)
    assert(v11, v12)
    return v10
end

local function getView() -- line 39 | captures: v3
    local v13 = v3:WaitForChild("PlayerGui", 5)
    local v14 = v13 ~= nil
    local v15 = ("%*.PlayerGui did not load"):format((v3:GetFullName()))
    assert(v14, v15)
    local v16 = v13:WaitForChild("CrateOpeningPopUpFrame", 5)
    local v17 = v16 ~= nil
    local v18 = ("%*.CrateOpeningPopUpFrame did not load"):format((v13:GetFullName()))
    assert(v17, v18)
    local ScreenGui = v16:IsA("ScreenGui")
    assert(ScreenGui, "CrateOpeningPopUpFrame must be a ScreenGui")
    local v19 = v16:WaitForChild("CrateOpeningPopUp", 5)
    local v20 = v19 ~= nil
    local v21 = ("%*.CrateOpeningPopUp did not load"):format((v16:GetFullName()))
    assert(v20, v21)
    local GuiObject = v19:IsA("GuiObject")
    assert(GuiObject, "CrateOpeningPopUp must be a GuiObject")
    local v22 = v19:WaitForChild("Main", 5)
    local v23 = v22 ~= nil
    local v24 = ("%*.Main did not load"):format((v19:GetFullName()))
    assert(v23, v24)
    local Frame = v22:IsA("Frame")
    assert(Frame, "CrateOpeningPopUp.Main must be a Frame")
    local v25 = v22:WaitForChild("Holder", 5)
    local v26 = v25 ~= nil
    local v27 = ("%*.Holder did not load"):format((v22:GetFullName()))
    assert(v26, v27)
    local Frame_2 = v25:IsA("Frame")
    assert(Frame_2, "CrateOpeningPopUp.Main.Holder must be a Frame")
    local v28 = v25:WaitForChild("GenericFrameTemplate", 5)
    local v29 = v28 ~= nil
    local v30 = ("%*.GenericFrameTemplate did not load"):format((v25:GetFullName()))
    assert(v29, v30)
    local Frame_3 = v28:IsA("Frame")
    assert(Frame_3, "GenericFrameTemplate must be a Frame")
    local v31 = v25:WaitForChild("SpecialFrameTemplate", 5)
    local v32 = v31 ~= nil
    local v33 = ("%*.SpecialFrameTemplate did not load"):format((v25:GetFullName()))
    assert(v32, v33)
    local Frame_4 = v31:IsA("Frame")
    assert(Frame_4, "SpecialFrameTemplate must be a Frame")
    local v34 = v25:WaitForChild("UIListLayout", 5)
    local v35 = v34 ~= nil
    local v36 = ("%*.UIListLayout did not load"):format((v25:GetFullName()))
    assert(v35, v36)
    local UIListLayout = v34:IsA("UIListLayout")
    assert(UIListLayout, "Holder.UIListLayout must be a UIListLayout")
    local v37 = v25:WaitForChild("UIPadding", 5)
    local v38 = v37 ~= nil
    local v39 = ("%*.UIPadding did not load"):format((v25:GetFullName()))
    assert(v38, v39)
    local UIPadding = v37:IsA("UIPadding")
    assert(UIPadding, "Holder.UIPadding must be a UIPadding")
    local v40 = v19:WaitForChild("Skip", 5)
    local v41 = v40 ~= nil
    local v42 = ("%*.Skip did not load"):format((v19:GetFullName()))
    assert(v41, v42)
    local ImageButton = v40:IsA("ImageButton")
    assert(ImageButton, "CrateOpeningPopUp.Skip must be an ImageButton")
    local v43 = v19:WaitForChild("Arrow", 5)
    local v44 = v43 ~= nil
    local v45 = ("%*.Arrow did not load"):format((v19:GetFullName()))
    assert(v44, v45)
    local ImageLabel = v43:IsA("ImageLabel")
    assert(ImageLabel, "CrateOpeningPopUp.Arrow must be an ImageLabel")
    local v46 = v19:WaitForChild("RewardTitleFrame", 5)
    local v47 = v46 ~= nil
    local v48 = ("%*.RewardTitleFrame did not load"):format((v19:GetFullName()))
    assert(v47, v48)
    local Frame_5 = v46:IsA("Frame")
    assert(Frame_5, "RewardTitleFrame must be a Frame")
    local v49 = v46:WaitForChild("RewardName", 5)
    local v50 = v49 ~= nil
    local v51 = ("%*.RewardName did not load"):format((v46:GetFullName()))
    assert(v50, v51)
    local TextLabel = v49:IsA("TextLabel")
    assert(TextLabel, "RewardTitleFrame.RewardName must be a TextLabel")
    local v52 = if v34.FillDirection == Enum.FillDirection.Horizontal and v34.SortOrder == Enum.SortOrder.LayoutOrder then not v34.Wraps else false
    assert(v52, "Holder.UIListLayout must be a single horizontal row sorted by LayoutOrder")
    return {
        Arrow = v43,
        GenericTemplate = v28,
        Holder = v25,
        Layout = v34,
        Main = v22,
        Padding = v37,
        Popup = v19,
        RewardName = v49,
        RewardTitle = v46,
        Screen = v16,
        Skip = v40,
        SpecialTemplate = v31
    }
end

local function pickRewardId() -- line 134 | captures: MonsterParasite, v2
    local v53 = v2:NextNumber(0, 100)
    local v54 = 0
    for v55, v56 in MonsterParasite.Rewards do
        v54 += v56.Weight
        if v53 <= v54 then
            return v56.Id
        end
    end
    return MonsterParasite.Rewards[#MonsterParasite.Rewards].Id
end

local function buildRewardIds(v57, v58) -- line 148 | captures: pickRewardId
    local v59 = table.create(36)
    for v60 = 1, 36 do
        if v60 == v58 then
            v59[v60] = v57
        else
            v59[v60] = pickRewardId()
        end
    end
    return v59
end

local function ensureCardImage(v61, v62, v63, v64, v65) -- line 164
    local v66 = v61:FindFirstChild(v62)
    if v66 == nil then
        if v66 ~= nil then
            v66:Destroy()
        end
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = v62
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Position = UDim2.fromScale(0.5, 0.3)
        ImageLabel.ScaleType = v65
        ImageLabel.Size = UDim2.fromScale(v64, v64)
        ImageLabel.ZIndex = v63
        ImageLabel.Parent = v61
        return ImageLabel
    end
    if v66:IsA("ImageLabel") then
        return v66
    end
    if v66 ~= nil then
        v66:Destroy()
    end
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = v62
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.fromScale(0.5, 0.3)
    ImageLabel.ScaleType = v65
    ImageLabel.Size = UDim2.fromScale(v64, v64)
    ImageLabel.ZIndex = v63
    ImageLabel.Parent = v61
    return ImageLabel
end

local function setFrameText(v67, v68) -- line 199 | captures: Layout, MonsterParasite, MonsterParasite_2, Rarities, ensureCardImage
    local ItemName = v67:FindFirstChild("ItemName")
    local v69 = ItemName and ItemName:IsA("TextLabel")
    assert(v69, "Reward frame requires ItemName")
    local RarityLabel = v67:FindFirstChild("RarityLabel")
    local v70 = RarityLabel and RarityLabel:IsA("TextLabel")
    assert(v70, "Reward frame requires RarityLabel")
    local v71 = MonsterParasite.GetReward(v68)
    ItemName.Text = MonsterParasite.RewardLabel(v71)
    local Rarity = v71.Rarity
    RarityLabel.Text = Rarity
    if v68 == MonsterParasite_2.RewardIds.MonsterEgg then
        Rarity = "Prismatic"
    end
    local v72 = Rarities[Rarity]
    local v73 = ("Unknown Monster Chest rarity: %*"):format(Rarity)
    local v74 = assert(v72, v73)
    Layout.SwapGradient(RarityLabel, v74.RarityGradient)
    local UIStroke = RarityLabel:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        Layout.SwapGradient(UIStroke, v74.RarityGradient)
    end
    local v75 = ensureCardImage(v67, "Glow", 2, 0.5940000000000001, Enum.ScaleType.Stretch)
    v75.Image = "rbxassetid://109516122757226"
    v75.ImageTransparency = 0.45
    v75.ImageColor3 = v74.RarityGradient.Color.Keypoints[1].Value
    v75.Visible = true
    local v76 = ensureCardImage(v67, "Icon", 3, 0.54, Enum.ScaleType.Fit)
    local FallbackIcon = v67:GetAttribute("FallbackIcon")
    local Icon = v71.Icon
    if not Icon then
        if typeof(FallbackIcon) == "string" then
            Icon = FallbackIcon
        else
            Icon = "rbxassetid://116351329433541"
        end
    end
    v76.Image = Icon
    v76.Visible = true
end

local function buildFrames(v77, v78, v79, v80) -- line 246 | captures: MonsterParasite_2, setFrameText
    local v81 = table.create(#v79)
    local MonsterEgg = MonsterParasite_2.RewardIds.MonsterEgg
    for v82, v83 in v79 do
        local v84 = if v83 == MonsterEgg then v77.SpecialTemplate else v77.GenericTemplate
        local Frame = Instance.new("Frame")
        Frame.Name = ("RewardSlot%*"):format(v82)
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.LayoutOrder = v82
        Frame.Size = UDim2.fromOffset(v8, v8)
        Frame.Parent = v77.Holder
        v9:Add(Frame)
        local v85 = v84:Clone()
        v85.Name = ("RewardFrame%*"):format(v82)
        v85.AnchorPoint = Vector2.new(0.5, 0.5)
        v85.Position = UDim2.fromScale(0.5, 0.5)
        v85.Size = UDim2.fromScale(1, 1)
        v85.Visible = true
        setFrameText(v85, v83)
        local UIScale = v85:FindFirstChildOfClass("UIScale")
        local v86 = UIScale ~= nil
        assert(v86, "Reward frame requires UIScale")
        UIScale.Scale = 0.7
        v85.Parent = Frame
        v81[v82] = {
            Scale = UIScale,
            Slot = Frame
        }
    end
    return v81
end

local function spinCurve(v87) -- line 284
    if v87 >= 0.055 then
        return (1 - (1 - (v87 - 0.055) / 0.945) ^ 4) * 0.92 + 0.08
    end
    local v88 = v87 / 0.055
    return v88 ^ 2 * (v88 * 0.6772486772486772 + 0.3227513227513228) * 0.08
end

local function formatReward(v89) -- line 291 | captures: MonsterParasite_2, Mutations
    if v89.Id ~= MonsterParasite_2.RewardIds.MonsterEgg or v89.Egg == nil then
        return v89.DisplayName
    end
    return (("x1 %* %*"):format(Mutations.LabelOf(v89.Egg.Mutation), v89.Egg.AssetCategory))
end

local function playTween(v90, v91, v92) -- line 298 | captures: TweenService
    local v93 = TweenService:Create(v90, v91, v92)
    v93:Play()
    v93.Completed:Wait()
end

local function runPresentation(v94, v95, v96) -- line 303 | captures: GuiService, RunService, TweenService, Audio, Confetti, MonsterParasite_2, Mutations, Spring, v2, buildRewardIds, buildFrames
    local Reward = v95.Reward
    local v97 = assert(Reward, "Successful Monster Chest result requires a reward")
    local Screen = v94.Screen
    local DisplayOrder = v94.Screen.DisplayOrder
    Screen.DisplayOrder = math.max(DisplayOrder, 200)
    v94.Screen.ResetOnSpawn = false
    v94.Popup.Visible = false
    v94.Main.Visible = false
    v94.RewardTitle.Visible = false
    v94.Skip.Visible = true
    v94.Skip.Active = true
    v94.GenericTemplate.Visible = false
    v94.SpecialTemplate.Visible = false
    local UIScale = Instance.new("UIScale")
    UIScale.Name = "CrateOpeningRuntimeScale"
    UIScale.Scale = 1
    UIScale.Parent = v94.Popup
    v96:Add(UIScale)
    RunService.Heartbeat:Wait()
    local X = v94.Main.AbsoluteSize.X
    local v98 = math.max(X, 1)
    local Y = v94.Main.AbsoluteSize.Y
    local v99 = math.max(Y, 1)
    local v100 = v98 * 0.176
    local v101 = v98 * 0.01
    local v102 = v98 * 0.01
    local v103 = math.max(8, v102)
    local v104 = v2:NextInteger(29, 33)
    local v105 = buildRewardIds(v97.Id, v104)
    v94.Layout.Padding = UDim.new(0, v101)
    v94.Padding.PaddingLeft = UDim.new(0, v103)
    v94.Padding.PaddingRight = UDim.new(0, v103)
    v94.Holder.Size = UDim2.fromOffset(v103 * 2 + v100 * 36 + v101 * 35, v99)
    v94.Holder.Position = UDim2.fromOffset(0, 0)
    local v106 = buildFrames(v94, v96, v105, v100)
    RunService.Heartbeat:Wait()
    local v107 = v94.Arrow.AbsolutePosition.X + v94.Arrow.AbsoluteSize.X * 0.5
    local Slot = v106[v104].Slot
    local SelectedObject = GuiService.SelectedObject
    local Active = v94.Popup.Active
    local ZIndex = v94.Popup.ZIndex
    local SelectionGroup = v94.Popup.SelectionGroup
    local SelectionBehaviorDown = v94.Popup.SelectionBehaviorDown
    local SelectionBehaviorLeft = v94.Popup.SelectionBehaviorLeft
    local SelectionBehaviorRight = v94.Popup.SelectionBehaviorRight
    local SelectionBehaviorUp = v94.Popup.SelectionBehaviorUp
    local Active_2 = v94.Main.Active
    local Selectable = v94.RewardTitle.Selectable
    local Modal = v94.Skip.Modal
    local Selectable_2 = v94.Skip.Selectable
    v96:Add(function() -- line 355 | captures: v94, SelectedObject, Active, ZIndex, SelectionGroup, SelectionBehaviorDown, SelectionBehaviorLeft, SelectionBehaviorRight, SelectionBehaviorUp, Active_2, Selectable, Modal, Selectable_2, GuiService
        if GuiService.SelectedObject == v94.Skip then
            GuiService.SelectedObject = SelectedObject
        end
        v94.Popup.Active = Active
        v94.Popup.ZIndex = ZIndex
        v94.Popup.SelectionGroup = SelectionGroup
        v94.Popup.SelectionBehaviorDown = SelectionBehaviorDown
        v94.Popup.SelectionBehaviorLeft = SelectionBehaviorLeft
        v94.Popup.SelectionBehaviorRight = SelectionBehaviorRight
        v94.Popup.SelectionBehaviorUp = SelectionBehaviorUp
        v94.Main.Active = Active_2
        v94.RewardTitle.Selectable = Selectable
        v94.Skip.Modal = Modal
        v94.Skip.Selectable = Selectable_2
    end)
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "CrateOpeningInputBlocker"
    TextButton.Active = true
    TextButton.AutoButtonColor = false
    TextButton.BackgroundTransparency = 1
    TextButton.Modal = true
    TextButton.Selectable = false
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.Text = ""
    TextButton.ZIndex = 1
    TextButton.Parent = v94.Screen
    v96:Add(TextButton)
    v94.Popup.Active = true
    v94.Popup.ZIndex = math.max(2, ZIndex)
    v94.Popup.SelectionGroup = true
    v94.Popup.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    v94.Popup.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    v94.Popup.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    v94.Popup.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    v94.Main.Active = true
    v94.RewardTitle.Selectable = false
    v94.Skip.Modal = true
    v94.Skip.Selectable = true
    GuiService.SelectedObject = v94.Skip
    UIScale.Scale = 0.86
    v94.Popup.Visible = true
    v94.Main.Visible = true
    local v108 = TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(UIScale, v108, { Scale = 1 }):Play()
    local v109 = false
    v96:Connect(v94.Skip.Activated, function() -- line 402 | captures: v109, v94
        v109 = true
        v94.Skip.Active = false
    end)
    local Rotation = v94.Arrow.Rotation
    local v110 = Spring.new(0)
    v110.Speed = 19
    v110.Damper = 0.58
    local v111 = table.create(#v106)

    local function renderOffset(v112, v113) -- line 411 | captures: v94, v106, Rotation, v110, v111, Audio
        v94.Holder.Position = UDim2.fromOffset(v112, 0)
        for v114, v115 in v106 do
            local v116 = v94.Arrow.AbsolutePosition.X + v94.Arrow.AbsoluteSize.X * 0.5
            local v117 = v115.Slot.AbsolutePosition.X + v115.Slot.AbsoluteSize.X * 0.5
            local v118 = v117 - v116
            local v119 = math.abs(v118)
            local v120 = v94.Main.AbsoluteSize.X * 0.5
            local v121 = v119 / math.max(v120, 1)
            local v122 = math.clamp(v121, 0, 1)
            local v123 = math.lerp(1, 0.7, v122)
            v115.Scale.Scale = v123
            local v124 = v117 - v115.Slot.AbsoluteSize.X * v123 * 0.5
            if v113 then
                local v125 = v111[v114]
                if v125 and v116 < v125 and v124 <= v116 then
                    Audio.Play("rbxassetid://80158078882046", script, {
                        Volume = 0.72,
                        PlaybackSpeed = { 0.97, 1.03 }
                    })
                    v110:Impulse(24 * v110.Speed)
                end
            end
            v111[v114] = v124
        end
        local Arrow = v94.Arrow
        local Position = v110.Position
        Arrow.Rotation = Rotation + math.clamp(Position, -24, 24)
    end

    renderOffset(0, false)
    local v126 = if v2:NextNumber() >= 0.5 then 1 else -1
    local v127 = v107 - (Slot.AbsolutePosition.X + Slot.AbsoluteSize.X * 0.5) + v100 * v2:NextNumber(0.1, 0.19) * v126
    local v128 = v2:NextNumber(3, 6)
    local v129 = os.clock()
    local v130
    local v131 = 0
    local v132 = 0
    local v133
    while true do
        local v134 = os.clock()
        if v109 and v130 == nil then
            v130 = v134
            v131 = v132
        end
        local v135
        if v130 then
            local v136 = (v134 - v130) / 0.55
            local v137 = math.clamp(v136, 0, 1)
            local v138 = 1 - (1 - v137) ^ 5
            v133 = math.lerp(v131, v127, v138)
            v135 = v137 >= 1
        else
            local v139 = (v134 - v129) / v128
            local v140 = math.clamp(v139, 0, 1)
            local v141
            if v140 >= 0.055 then
                v141 = (1 - (1 - (v140 - 0.055) / 0.945) ^ 4) * 0.92 + 0.08
            else
                local v142 = v140 / 0.055
                v141 = v142 ^ 2 * (v142 * 0.6772486772486772 + 0.3227513227513228) * 0.08
            end
            v133 = math.lerp(0, v127, v141)
            v135 = v140 >= 1
        end
        renderOffset(v133, true)
        if v135 then
            break
        end
        RunService.RenderStepped:Wait()
        v132 = v133
    end
    task.wait(0.1)
    local v143 = v133 + ((nil).Arrow.AbsolutePosition.X + (nil).Arrow.AbsoluteSize.X * 0.5) - (Slot.AbsolutePosition.X + Slot.AbsoluteSize.X * 0.5)
    local v144 = os.clock()
    while true do
        local v145 = (os.clock() - v144) / 0.48
        local v146 = math.clamp(v145, 0, 1)
        local v147 = TweenService:GetValue(v146, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        renderOffset(math.lerp(v127, v143, v147), false)
        if v146 >= 1 then
            break
        end
        RunService.RenderStepped:Wait()
    end
    renderOffset(v143, false);
    (nil).Skip.Visible = false
    local RewardName = (nil).RewardName
    if v97.Id == MonsterParasite_2.RewardIds.MonsterEgg then
        if v97.Egg == nil then
            RewardName.Text = v97.DisplayName
        else
            RewardName.Text = ("x1 %* %*"):format(Mutations.LabelOf(v97.Egg.Mutation), v97.Egg.AssetCategory)
        end
    else
        RewardName.Text = v97.DisplayName
    end
    (nil).RewardTitle.Visible = true
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0.55
    UIScale_2.Parent = (nil).RewardTitle;
    (nil):Add(UIScale_2)
    local Scale = v106[v104].Scale
    Scale.Scale = 1
    local v148 = TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local v149 = TweenService:Create(UIScale_2, v148, { Scale = 1 })
    v149:Play()
    local v150 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(Scale, v150, { Scale = 1.16 }):Play()
    v149.Completed:Wait()
    Confetti.Burst()
    local v151 = TweenInfo.new(0.34, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v152 = TweenService:Create(Scale, v151, { Scale = 1.04 })
    v152:Play()
    v152.Completed:Wait()
    task.wait(0.85)
    local v153 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v154 = TweenService:Create(UIScale, v153, { Scale = 0.9 })
    v154:Play()
    v154.Completed:Wait();
    (nil).Arrow.Rotation = Rotation
end

function v5.Play(v155) -- line 532 | captures: v4, Trove, getView, runPresentation
    local v156 = v155.Success and v155.Reward ~= nil
    assert(v156, "Crate spinner requires a successful reward")
    if v4 then
        return
    end
    v4 = true
    local v157 = Trove.new()
    local v158, Rotation
    local v159, v160 = xpcall(function() -- line 546 | captures: v158, Rotation, v155, v157, getView, runPresentation
        local v161 = getView()
        v158 = v161
        Rotation = v161.Arrow.Rotation
        runPresentation(v161, v155, v157)
    end, debug.traceback)
    if v158 ~= nil then
        v158.Popup.Visible = false
        v158.Main.Visible = false
        v158.RewardTitle.Visible = false
        v158.Skip.Active = false
        if Rotation ~= nil then
            v158.Arrow.Rotation = Rotation
        end
    end
    v157:Destroy()
    v4 = false
    if not v159 then
        error(v160, 2)
    end
end

return table.freeze(v5)
