-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v2(...)
    return (tonumber(...))
end

local ClaimAll
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local AreaIndexProgressComponent = require(script.AreaIndexProgressComponent)
local Areas = require(ReplicatedStorage.Data.Areas)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetOddsDisplay = require(ReplicatedStorage.Client.Util.AssetOddsDisplay)
local Personalities = require(ReplicatedStorage.Data.Assets).Personalities
local Assets = require(ReplicatedStorage.Data.Assets)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ClaimRewardPanel = require(script.ClaimRewardPanel)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
require(script.Types.Interface)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Layout = require(ReplicatedStorage.Shared.Utils.Layout)
local BrainrotEgg = require(ReplicatedStorage.Data.BrainrotEgg)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local v3 = {}

v3.__index = v3
v3.__class = "IndexController"

local v4 = { "Base" }
local v5 = Color3.fromRGB(255, 55, 55)
local v6 = Color3.fromRGB(255, 255, 255)
local v7 = Color3.fromRGB(0, 0, 0)
local v8 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v9 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local v10 = Log.new()
local v11 = TryLock()
local Frame = GUI.Index().Frame
local IndexButton = Hud.Get("IndexButton")
local IndexNotificationBadge = Hud.Every("IndexNotificationBadge")
local ClaimAll_2 = Frame:FindFirstChild("ClaimAll")
local ClaimAll_3

if ClaimAll_2 == nil then
elseif ClaimAll_2:IsA("GuiObject") then
    ClaimAll = ClaimAll_2
    ClaimAll_3 = ClaimAll_2
end
local v12

if ClaimAll_3 == nil then
else
    v12 = ClaimAll_3:FindFirstChild("NotificationBadge")
end

local function renderNotificationBadge(v13, v14) -- line 58
    local v15, v16
    if v13 == nil then
        v16 = true
    elseif v13:IsA("GuiObject") then
        v15 = v14 > 0
        v16 = false
    else
        v16 = true
    end
    if v16 then
        return
    end
    v13.Visible = v15
    if v14 ~= 0 then
        for v17, v18 in v13:GetDescendants() do
            if v18:IsA("TextLabel") then
                v18.Text = tostring(v14)
            end
        end
    end
end

local ScrollingFrame = Frame.List.ScrollingFrame
local Section = ScrollingFrame:FindFirstChild("Section")
local v19 = Section ~= nil
assert(v19, "Index list is missing its Section template")
local Viewing = Frame.Side.Viewing
local Icon = Viewing.Icon
local PetName = Viewing.PetName
local PetRarity = Viewing.PetRarity
local PetOdds = Viewing.PetOdds
local Rewards = Frame.Side.Rewards
local Claim = Rewards.Claim
local Unlocked = Frame.Unlocked
local Fill = Unlocked.Fill
local TextLabel = Unlocked.TextLabel
local v20 = {}
local v21 = 0
local v22 = 0
for v23, v24 in Section.Pets:GetChildren() do
    local v25 = v2(string.match(v24.Name, "^Clr(%d+)$"))
    if v25 ~= nil and v24:IsA("ImageLabel") then
        v20[v25] = v24
        local v26 = math.max(v22, v25)
        v21 = v26
        v22 = v26
    end
end
local v27 = v22 > 0
assert(v27, "Index Section.Pets has no Clr cell templates")

local function variantForRarity(v28) -- line 98 | captures: v21
    local v29 = v21
    return (math.clamp(v28, 1, v29))
end

local function dressWithRarityGradient(v30, v31) -- line 101
    local UIGradient = v30:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        UIGradient:Destroy()
    end
    v30.BackgroundColor3 = Color3.new(1, 1, 1)
    v31:Clone().Parent = v30
end

local UIGridLayout = Section.Pets:FindFirstChildOfClass("UIGridLayout")
local v32 = UIGridLayout ~= nil
assert(v32, "Index Section.Pets needs a UIGridLayout")
local Scale = Section.Size.Y.Scale
local Scale_2 = UIGridLayout.CellPadding.X.Scale
local v33 = (1 + Scale_2) / (UIGridLayout.CellSize.X.Scale + Scale_2)
local v34 = math.floor(v33)
local v35 = math.max(1, v34)
local v36 = Section.Pets.Size.Y.Scale * Scale
local v37 = Section.Unlocked.Size.Y.Scale * Scale
local v38 = {
    PerRow = v35,
    PetsPosAbs = Section.Pets.Position.Y.Scale * Scale,
    BgPosAbs = Section.BgFrame.Position.Y.Scale * Scale,
    BarSizeAbs = v37
}
local v39 = Scale - Section.Unlocked.Position.Y.Scale * Scale - v37

v38.BottomAbs = math.max(0, v39)
v38.CellAbs = UIGridLayout.CellSize.Y.Scale * v36
v38.PadAbs = UIGridLayout.CellPadding.Y.Scale * v36

function v3._build() -- line 127 | captures: Trove, v3
    local v40 = {}
    local v41 = setmetatable(v40, v3)
    v41._trove = Trove.new()
    v41._openTrove = nil
    v41._sections = {}
    v41._sectionsByPage = {}
    v41._currentPage = "Base"
    v41._selectedCategory = nil
    v41._isOpen = false
    v41._claimAllArmed = false
    v41._badgePulseTweens = {}
    v41:_buildEntries()
    v41:_init()
    return v41
end

function v3._buildEntries(v42) -- line 142 | captures: Areas, Personalities, Assets, BrainrotEgg, LimitedEgg, v4
    for v43, v44 in ipairs(v4) do
        v42._sectionsByPage[v44] = {}
    end
    for v45, v46 in Areas.Directory do
        for v47, v48 in ipairs(v4) do
            local v49 = {}
            for v50, v51 in v46.DropTable do
                local v52 = v51[1]
                local v53 = Assets.Directory[v52]
                if v53 and v51[2] > 0 and v53.DontRoll ~= true then
                    local v54 = {
                        Category = v52,
                        Config = v53,
                        ItemData = {
                            Scale = 1,
                            HasBeenFirstPlaced = true,
                            Category = v52,
                            Mutations = {},
                            Personality = Personalities.Personalities.Normal
                        }
                    }
                    table.insert(v49, v54)
                end
            end
            table.sort(v49, function(v55, v56) -- line 174
                local RarityNumber = v55.Config.Rarity.RarityNumber
                local RarityNumber_2 = v56.Config.Rarity.RarityNumber
                if RarityNumber == RarityNumber_2 then
                    if v55.Config.DropWeight == v56.Config.DropWeight then
                        return v55.Category < v56.Category
                    end
                    return v56.Config.DropWeight < v55.Config.DropWeight
                end
                return RarityNumber < RarityNumber_2
            end)
            if #v49 > 0 then
                local v57 = v42._sectionsByPage[v48]
                local v58 = {
                    RewardKind = "AreaBat",
                    SectionId = v45,
                    DisplayName = v46.DisplayName,
                    Icon = v46.Icon,
                    HeaderGradient = v46.Rarity.RarityGradient,
                    SortOrder = v46.Rarity.RarityNumber,
                    RewardGearId = v46.IndexBatGearId,
                    Entries = v49
                }
                table.insert(v57, v58)
            end
        end
    end
    for v59, v60 in ipairs(v4) do
        table.sort(v42._sectionsByPage[v60], function(v61, v62) -- line 204
            if v61.SortOrder == v62.SortOrder then
                return v61.SectionId < v62.SectionId
            end
            return v61.SortOrder < v62.SortOrder
        end)
    end

    local function collectLimitedEntries(v63) -- line 214 | captures: Personalities, Assets
        local v64 = {}
        for v65, v66 in ipairs(v63) do
            local AssetId = v66.AssetId
            local v67 = {
                Category = AssetId,
                Config = Assets.Directory[AssetId],
                ItemData = {
                    Scale = 1,
                    HasBeenFirstPlaced = true,
                    Category = AssetId,
                    Mutations = {},
                    Personality = Personalities.Personalities.Normal
                }
            }
            table.insert(v64, v67)
        end
        table.sort(v64, function(v68, v69) -- line 231
            if v68.Config.Rarity.RarityNumber == v69.Config.Rarity.RarityNumber then
                return v68.Category < v69.Category
            end
            return v68.Config.Rarity.RarityNumber < v69.Config.Rarity.RarityNumber
        end)
        return v64
    end

    for v70, v71 in ipairs(v4) do
        local v72 = collectLimitedEntries(LimitedEgg.Entries)
        local MechaReroll = LimitedEgg.MechaReroll
        if MechaReroll ~= nil then
            for v73, v74 in ipairs((collectLimitedEntries(MechaReroll.Entries))) do
                table.insert(v72, v74)
            end
        end
        local v75 = v42._sectionsByPage[v71]
        local v76 = {
            SectionId = "LimitedEgg",
            Icon = "rbxassetid://70476079280223",
            SortOrder = 1000000,
            RewardKind = "GearClaim",
            RewardGearId = "BeeLauncher",
            DisplayName = LimitedEgg.DisplayName,
            Entries = v72
        }
        table.insert(v75, v76)
        local v77 = v42._sectionsByPage[v71]
        local v78 = {
            SectionId = "BrainrotEgg",
            SortOrder = (1/0),
            RewardKind = "GearClaim",
            RewardGearId = "BeeLauncher",
            RetiredReward = true,
            DisplayName = BrainrotEgg.DisplayName,
            Icon = BrainrotEgg.BackgroundImage,
            Entries = collectLimitedEntries(BrainrotEgg.Entries)
        }
        table.insert(v77, v78)
    end
end

function v3._getSave(v79) -- line 271 | captures: Save
    return Save.Get()
end

local function _isDiscovered(v80, v81) -- line 274
    local v82 = v80:_getSave()
    if v82 == nil then
        return false
    end
    return v82.Index[v81.Category] == true
end

v3._isDiscovered = _isDiscovered

local function _isClaimed(v83, v84) -- line 282
    local v85 = v83:_getSave()
    if v85 == nil then
        return false
    end
    return v85.IndexClaimedCategories[v84.Category] == true
end

v3._isClaimed = _isClaimed

local function _isClaimable(v86, v87) -- line 287
    return v86:_isDiscovered(v87) and not v86:_isClaimed(v87)
end

v3._isClaimable = _isClaimable

function v3._getEntryDisplayName(v88, v89) -- line 294 | captures: ItemDisplay
    return ItemDisplay.GetNameFromItemData(v89.ItemData)
end

local function _getEntryByCategory(v90, v91) -- line 297
    if v91 ~= nil then
        for v92, v93 in ipairs(v90._sectionsByPage[v90._currentPage]) do
            for v94, v95 in ipairs(v93.Entries) do
                if v95.Category == v91 then
                    return v95
                end
            end
        end
    end
    return nil
end

v3._getEntryByCategory = _getEntryByCategory

function v3._renderHiddenIcon(v96, v97) -- line 310 | captures: v7
    v97.ImageColor3 = v7
    v97.ImageTransparency = 0.35
end

local function _renderVisibleIcon(v98, v99) -- line 314
    v99.ImageColor3 = Color3.fromRGB(255, 255, 255)
    v99.ImageTransparency = 0
end

v3._renderVisibleIcon = _renderVisibleIcon

function v3._renderEntryIcon(v100, v101, v102, v103) -- line 318 | captures: Assets
    v101.Image = Assets.Directory[v102.Category].Icon or ""
    v101.ScaleType = Enum.ScaleType.Fit
    if v103 then
        v100:_renderVisibleIcon(v101)
    else
        v100:_renderHiddenIcon(v101)
    end
end

function v3._sizeSection(v104, v105, v106) -- line 327 | captures: v38
    local v107 = v106 / v38.PerRow
    local v108 = math.ceil(v107)
    local v109 = math.max(1, v108)
    local v110 = v109 * v38.CellAbs + (v109 - 1) * v38.PadAbs
    local v111 = v38.PetsPosAbs + v110 + 0.04
    local v112 = v111 + v38.BarSizeAbs
    local v113 = v112 + v38.BottomAbs
    local v114 = v112 - v38.BgPosAbs
    local v115 = math.max(0, v114)
    v105.Size = UDim2.new(v105.Size.X.Scale, v105.Size.X.Offset, v113, 0)
    v105.BgFrame.Size = UDim2.new(v105.BgFrame.Size.X.Scale, 0, v115 / v113, 0)
    v105.BgFrame.Position = UDim2.new(v105.BgFrame.Position.X.Scale, 0, v38.BgPosAbs / v113, 0)
    v105.Unlocked.Size = UDim2.new(v105.Unlocked.Size.X.Scale, 0, v38.BarSizeAbs / v113, 0)
    v105.Unlocked.Position = UDim2.new(v105.Unlocked.Position.X.Scale, 0, (v111 + v38.BarSizeAbs * v105.Unlocked.AnchorPoint.Y) / v113, 0)
    v105.Pets.Position = UDim2.new(v105.Pets.Position.X.Scale, 0, v38.PetsPosAbs / v113, 0)
    v105.Pets.Size = UDim2.new(v105.Pets.Size.X.Scale, 0, v110 / v113, 0)
    local UIGridLayout = v105.Pets:FindFirstChildOfClass("UIGridLayout")
    if UIGridLayout ~= nil then
        UIGridLayout.CellSize = UDim2.new(UIGridLayout.CellSize.X.Scale, 0, v38.CellAbs / v110, 0)
        UIGridLayout.CellPadding = UDim2.new(UIGridLayout.CellPadding.X.Scale, 0, v38.PadAbs / v110, 0)
    end
end

function v3._ensureSectionPool(v116, v117) -- line 347 | captures: AreaIndexProgressComponent, v11, ScrollingFrame, Section
    if v116._openTrove ~= nil then
        while #v116._sections < v117 do
            local v118 = Section:Clone()
            v118.Name = ("IndexArea%*"):format(#v116._sections + 1)
            v118.Visible = false
            v118.Parent = ScrollingFrame
            local v119 = {
                Frame = v118,
                Slots = {}
            }
            local new = AreaIndexProgressComponent.new
            local Unlocked = v118.Unlocked
            v119.ProgressComponent = new(Unlocked, function(v120) -- line 357 | captures: v116, v11
                v11(function() -- line 358 | captures: v120, v116
                    if v120 == "LimitedEgg" then
                        v116:_claimLimitedEggReward()
                    elseif v120 ~= "BrainrotEgg" then
                        v116:_equipAreaBat(v120)
                    end
                end)
            end)
            local _sections = v116._sections
            table.insert(_sections, v119)
            v116._openTrove:Add(v118)
            local _openTrove = v116._openTrove
            _openTrove:Add(function() -- line 370 | captures: v119
                v119.ProgressComponent:Destroy()
            end)
        end
    end
end

function v3._ensureSlotPool(v121, v122, v123) -- line 375 | captures: v21, SurfaceButton
    if v121._openTrove ~= nil then
        for v124, v125 in ipairs(v123.Entries) do
            local Rarity = v125.Config.Rarity
            local RarityNumber = Rarity.RarityNumber
            local v126 = v21
            local v127 = math.clamp(RarityNumber, 1, v126)
            local v128 = ("Clr%*"):format(v127)
            local RarityGradient
            if Rarity.RarityNumber <= v127 then
            else
                RarityGradient = Rarity.RarityGradient
            end
            local v129
            if RarityGradient == nil then
                v129 = v128
            else
                v129 = ("%*:%*"):format(v128, Rarity._id)
            end
            local v130 = v122.Slots[v124]
            if v130 ~= nil and v130.Variant ~= v129 then
                v130.Teardown()
                v130.Frame:Destroy()
                v130 = nil
            end
            if v130 == nil then
                local v131 = v122.Frame.Pets:FindFirstChild(v128)
                local v132
                if v131 == nil then
                    v132 = false
                else
                    v132 = v131:IsA("ImageLabel")
                end
                local v133 = ("Index section lost its %* template"):format(v128)
                assert(v132, v133)
                local v134 = v131:Clone()
                v134.Name = ("IndexEntry%*"):format(v124)
                v134.Visible = false
                v134.LayoutOrder = v124
                v134.Parent = v122.Frame.Pets
                if RarityGradient ~= nil then
                    local UIGradient = v134:FindFirstChildOfClass("UIGradient")
                    if UIGradient ~= nil then
                        UIGradient:Destroy()
                    end
                    v134.BackgroundColor3 = Color3.new(1, 1, 1)
                    RarityGradient:Clone().Parent = v134
                end
                local v135 = {
                    Frame = v134,
                    Variant = v129,
                    Teardown = function() -- Teardown | line 420
                    end
                }
                v135.Teardown = SurfaceButton(v134, 1.08, function() -- line 422 | captures: v121, v135
                    local Entry = v135.Entry
                    if Entry ~= nil and v121._selectedCategory ~= Entry.Category then
                        v121:_selectEntry(Entry.Category)
                    end
                end)
                v122.Slots[v124] = v135
                v121._openTrove:Add(function() -- line 430 | captures: v135
                    v135.Teardown()
                end)
                v121._openTrove:Add(v134)
            end
        end
    end
end

function v3._renderSlot(v136, v137, v138) -- line 437 | captures: v5, v6
    local Frame = v137.Frame
    v137.Entry = v138
    if v138 == nil then
        Frame.Visible = false
    else
        local v139 = v136:_isDiscovered(v138)
        local v140 = v136:_isClaimed(v138)
        local v141 = v136._selectedCategory == v138.Category
        Frame.Visible = true
        if v139 then
            Frame.TextLabel.Text = v136:_getEntryDisplayName(v138)
        else
            Frame.TextLabel.Text = "???"
        end
        v136:_renderEntryIcon(Frame.Icon, v138, v139)
        local UIStroke = Frame:FindFirstChildOfClass("UIStroke")
        if UIStroke ~= nil then
            local v142 = v139 and not v140
            if v141 then
                UIStroke.Color = v6
            elseif v142 then
                UIStroke.Color = v5
            else
                UIStroke.Color = Color3.fromRGB(0, 0, 0)
            end
        end
    end
end

local function _renderSlots(v143) -- line 471
    local v144 = v143._sectionsByPage[v143._currentPage]
    v143:_ensureSectionPool(#v144)
    for v145, v146 in ipairs(v143._sections) do
        local v147 = v144[v145]
        v146.Section = v147
        if v147 == nil then
            v146.Frame.Visible = false
            for v148, v149 in ipairs(v146.Slots) do
                v143:_renderSlot(v149, nil)
            end
        else
            v146.Frame.Visible = true
            v146.Frame.Name = v147.SectionId
            v146.Frame.LayoutOrder = v145
            v146.Frame.BgFrame.TextLabel.Text = v147.DisplayName
            v146.Frame.BgFrame.Image = v147.Icon
            v146.Frame.BgFrame.ScaleType = Enum.ScaleType.Crop
            local v150 = 0
            for v151, v152 in v147.Entries do
                if v143:_isDiscovered(v152) then
                    v150 += 1
                end
            end
            local v153 = v143:_getSave()
            local v154 = if v153 == nil then false else (v153.GearInventory[v147.RewardGearId] or 0) > 0
            if v147.RewardKind == "AreaBat" then
                local v155 = if v153 == nil then false else v153.VisitedGears[v147.RewardGearId] == true
                v146.ProgressComponent:RenderAreaBat(v147.SectionId, v147.RewardGearId, v150, #v147.Entries, v155, v154)
            else
                local v156 = v154 or v147.RetiredReward == true
                v146.ProgressComponent:RenderGearClaim(v147.SectionId, v147.RewardGearId, v150, #v147.Entries, v156)
            end
            v143:_sizeSection(v146.Frame, #v147.Entries)
            v143:_ensureSlotPool(v146, v147)
            for v157, v158 in ipairs(v146.Slots) do
                v143:_renderSlot(v158, v147.Entries[v157])
            end
        end
    end
end

v3._renderSlots = _renderSlots

local function _selectEntry(v159, v160) -- line 523
    v159._selectedCategory = v160
    v159:_renderSlots()
    v159:_renderInfo()
    v159:_renderRewards()
end

v3._selectEntry = _selectEntry

local function _selectDefaultEntry(v161) -- line 529
    if v161:_getEntryByCategory(v161._selectedCategory) == nil then
        for v162, v163 in ipairs(v161._sectionsByPage[v161._currentPage]) do
            local v164 = v163.Entries[1]
            if v164 ~= nil then
                v161._selectedCategory = v164.Category
                return
            end
        end
    end
end

v3._selectDefaultEntry = _selectDefaultEntry

function v3._renderInfo(v165) -- line 543 | captures: AssetItems, AssetOddsDisplay, Simple, Viewing, Icon, PetName, PetRarity, PetOdds
    local v166 = v165:_getEntryByCategory(v165._selectedCategory)
    if v166 == nil then
        return
    end
    local v167 = v165:_isDiscovered(v166)
    v165:_renderEntryIcon(Icon, v166, v167)
    PetRarity.Text = v166.Config.Rarity._id
    local UIGradient = PetOdds:FindFirstChildOfClass("UIGradient")
    if UIGradient then
        UIGradient:Destroy()
    end
    if v166.Config.Rarity.RarityGradient then
        Viewing.BackgroundColor3 = v166.Config.Rarity.Color
        local v168 = Color3.new(0, 0, 0)
        Viewing.UIStroke.Color = v166.Config.Rarity.Color:Lerp(v168, 0.5)
    end
    AssetOddsDisplay.DescribeItem(v166.Config, v166.ItemData, false)
    if v167 then
        PetName.Text = v165:_getEntryDisplayName(v166)
        local v169 = AssetItems.IndexMoneyReward(v166.Category) / 100
        local v170 = Simple.FormatCompact(v169, ".#")
        PetOdds.Text = ("$%*/s"):format(v170)
    else
        PetName.Text = "???"
        PetOdds.Text = "???"
    end
end

function v3._renderRewards(v171) -- line 571 | captures: ClaimRewardPanel, Rewards
    local v172 = v171:_getEntryByCategory(v171._selectedCategory)
    local v173
    if v172 == nil then
        v173 = false
    else
        v173 = v171:_isClaimed(v172)
    end
    local v174
    if v172 == nil then
        v174 = false
    else
        v174 = v171:_isClaimable(v172)
    end
    ClaimRewardPanel.Render(Rewards, v172, v173, v174)
end

local function _countUnclaimedByPage(v175, v176) -- line 577
    local v177 = 0
    for v178, v179 in ipairs(v175._sectionsByPage[v176]) do
        local v180 = v177
        for v181, v182 in ipairs(v179.Entries) do
            if v175:_isClaimable(v182) then
                v180 += 1
            end
            v177 = v180
        end
    end
    return v177
end

v3._countUnclaimedByPage = _countUnclaimedByPage

local function _countDiscoveredByPage(v183, v184) -- line 588
    local v185 = 0
    for v186, v187 in ipairs(v183._sectionsByPage[v184]) do
        local v188 = v185
        for v189, v190 in ipairs(v187.Entries) do
            if v183:_isDiscovered(v190) then
                v188 += 1
            end
            v185 = v188
        end
    end
    return v185
end

v3._countDiscoveredByPage = _countDiscoveredByPage

local function _countEntriesByPage(v191, v192) -- line 599
    local v193 = 0
    for v194, v195 in ipairs(v191._sectionsByPage[v192]) do
        v193 += #v195.Entries
    end
    return v193
end

v3._countEntriesByPage = _countEntriesByPage

function v3._startBadgePulse(v196) -- line 606 | captures: TweenService, Layout, v9, IndexNotificationBadge
    if not (#v196._badgePulseTweens > 0) then
        for v197, v198 in ipairs(IndexNotificationBadge) do
            if v198:IsA("GuiObject") then
                local v199 = Layout.EnsureScale(v198)
                v199.Scale = 0.8
                local v200 = TweenService:Create(v199, v9, { Scale = 1.2 })
                local _badgePulseTweens = v196._badgePulseTweens
                table.insert(_badgePulseTweens, v200)
                v200:Play()
            end
        end
    end
end

function v3._stopBadgePulse(v201) -- line 622 | captures: Layout, IndexNotificationBadge
    if #v201._badgePulseTweens == 0 then
        return
    end
    for v202, v203 in ipairs(v201._badgePulseTweens) do
        v203:Cancel()
        v203:Destroy()
    end
    table.clear(v201._badgePulseTweens)
    for v204, v205 in ipairs(IndexNotificationBadge) do
        if v205:IsA("GuiObject") then
            Layout.EnsureScale(v205).Scale = 1
        end
    end
end

function v3._renderNotificationBadges(v206, v207) -- line 639 | captures: v12, IndexNotificationBadge, renderNotificationBadge
    for v208, v209 in ipairs(IndexNotificationBadge) do
        renderNotificationBadge(v209, v207)
    end
    renderNotificationBadge(v12, v207)
    if v207 > 0 then
        v206:_startBadgePulse()
    else
        v206:_stopBadgePulse()
    end
end

function v3._renderProgress(v210) -- line 650 | captures: TextLabel, ClaimAll, TweenService, v4, v8, Unlocked, Fill
    local v211 = v210:_countEntriesByPage(v210._currentPage)
    local v212 = v210:_countDiscoveredByPage(v210._currentPage)
    local v213 = 0
    for v214, v215 in ipairs(v4) do
        v213 += v210:_countUnclaimedByPage(v215)
    end
    v210._claimAllArmed = v213 > 0
    v210:_renderNotificationBadges(v213)
    if ClaimAll == nil then
        Unlocked.Visible = true
        Unlocked.Active = v210._claimAllArmed
        if v210._claimAllArmed then
            TextLabel.Text = ("CLAIM ALL (%*)!"):format(v213)
            TweenService:Create(Fill, v8, { Size = UDim2.fromScale(1, 1) }):Play()
        else
            TextLabel.Text = ("Unlocked: %*/%*"):format(v212, v211)
            local v216
            if v211 == 0 then
                v216 = 0
            else
                local v217 = v212 / v211
                v216 = math.clamp(v217, 0, 1)
            end
            TweenService:Create(Fill, v8, { Size = UDim2.fromScale(v216, 1) }):Play()
        end
    else
        ClaimAll.Visible = v210._claimAllArmed
        Unlocked.Visible = not v210._claimAllArmed
        Unlocked.Active = false
        TextLabel.Text = ("Unlocked: %*/%*"):format(v212, v211)
        local v218
        if v211 == 0 then
            v218 = 0
        else
            local v219 = v212 / v211
            v218 = math.clamp(v219, 0, 1)
        end
        TweenService:Create(Fill, v8, { Size = UDim2.fromScale(v218, 1) }):Play()
    end
end

local function _render(v220) -- line 688
    if v220._isOpen then
        v220:_selectDefaultEntry()
        v220:_renderSlots()
        v220:_renderInfo()
        v220:_renderRewards()
    end
    v220:_renderProgress()
end

v3._render = _render

function v3._open(v221) -- line 699 | captures: Trove
    if v221._isOpen then
        return
    end
    v221._isOpen = true
    v221._currentPage = "Base"
    v221._selectedCategory = nil
    v221._openTrove = Trove.new()
    v221:_render()
end

local function _close(v222) -- line 709
    v222._isOpen = false
    v222._currentPage = "Base"
    v222._selectedCategory = nil
    if v222._openTrove ~= nil then
        v222._openTrove:Destroy()
        v222._openTrove = nil
    end
    table.clear(v222._sections)
    v222:_render()
end

v3._close = _close

function v3._processClaimResults(v223, v224) -- line 720 | captures: Save
    if v224 ~= nil then
        for v225, v226 in ipairs(v224) do
            Save.ApplyLocalFieldEntry("IndexClaimedCategories", v226.Category, true)
        end
    end
end

function v3._claimSelected(v227) -- line 728 | captures: Remotes, v10
    local v228 = v227:_getEntryByCategory(v227._selectedCategory)
    if v228 ~= nil and v227:_isClaimable(v228) then
        local v229, v230, v231 = Remotes.Codex.AskRedeem:InvokeServer(v228.Category)
        if v229 then
            v227:_processClaimResults(v231)
            v227:Refresh()
        else
            v10:AtWarning():Log((("[Index] Claim failed: %*"):format(v230)))
        end
    end
end

function v3._claimAll(v232) -- line 742 | captures: Remotes, v10
    local v233, v234, v235 = Remotes.Codex.AskRedeemAll:InvokeServer()
    if v233 then
        v232:_processClaimResults(v235)
        v232:Refresh()
    else
        v10:AtWarning():Log((("[Index] Claim all failed: %*"):format(v234)))
    end
end

function v3._equipAreaBat(v236, v237) -- line 752 | captures: Remotes, v10
    local v238, v239 = Remotes.Codex.AskWearFieldBat:InvokeServer(v237)
    if v238 then
        v236:Refresh()
    else
        v10:AtWarning():Log((("[Index] Equip area bat failed: %*"):format(v239)))
    end
end

function v3._claimLimitedEggReward(v240) -- line 761 | captures: Remotes, v10
    local v241, v242 = Remotes.Codex.AskRedeemLimitedEgg:InvokeServer()
    if v241 then
        v240:Refresh()
    else
        v10:AtWarning():Log((("[Index] Limited Egg reward claim failed: %*"):format(v242)))
    end
end

local function Refresh(v243) -- line 770
    v243:_render()
end

v3.Refresh = Refresh

function v3._init(v244) -- line 773 | captures: ClaimAll, ButtonFX, Save, SurfaceButton, Tabs, v11, IndexButton, Section, Claim, Unlocked, v20
    Section.Visible = false
    for v245, v246 in v20 do
        v246.Visible = false
    end
    v244._trove:Add(ButtonFX(IndexButton, 1.08, function() -- line 781 | captures: Tabs
        Tabs.Toggle("Index")
    end))
    v244._trove:Add(ButtonFX(Claim, nil, function() -- line 784 | captures: v244, v11
        v11(function() -- line 785 | captures: v244
            v244:_claimSelected()
        end)
    end))

    local function v1() -- line 789 | captures: v244, v11
        if v244._claimAllArmed then
            v11(function() -- line 791 | captures: v244
                v244:_claimAll()
            end)
        end
    end

    v244._trove:Add(SurfaceButton(Unlocked, 1.04, v1))
    if ClaimAll ~= nil then
        local v247
        if ClaimAll:IsA("GuiButton") then
            v247 = ButtonFX(ClaimAll, 1.04, v1)
        else
            v247 = SurfaceButton(ClaimAll, 1.04, v1)
        end
        v244._trove:Add(v247)
    end
    v244._trove:Add(Save.WatchFields({ "Index", "IndexClaimedCategories", "VisitedGears", "GearInventory" }, function() -- line 806 | captures: v244
        v244:Refresh()
    end))
    v244._trove:Connect(Tabs.Shown, function(v248) -- line 809 | captures: v244
        if v248 == "Index" then
            v244:_open()
        end
    end)
    v244._trove:Connect(Tabs.Hidden, function(v249) -- line 814 | captures: v244
        if v249 == "Index" then
            v244:_close()
        end
    end)
    v244:_render()
end

return v3._build()
