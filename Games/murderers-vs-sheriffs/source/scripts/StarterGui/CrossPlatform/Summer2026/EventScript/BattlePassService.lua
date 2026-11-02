local _ = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType")
)
local u1 = nil
local Button_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button")
)
local ProfileData_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData")
)
local ItemService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService")
)
local NavigationService_upv_1 = require(script.Parent:WaitForChild("NavigationService"))
local Remotes_upv_1 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local u2 = nil
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local u3 = 1
local Main_1 = script.Parent.Parent:WaitForChild("Container"):WaitForChild("Main")
local BattlePass_1 = Main_1:WaitForChild("BattlePass")
local ScrollingFrame_upv_1 = BattlePass_1:WaitForChild("Rewards"):WaitForChild("ScrollingFrame")
local Tier_upv_1 = ScrollingFrame_upv_1:WaitForChild("Tier")
Tier_upv_1.Parent = script
local BuyTiers_upv_1 = BattlePass_1:WaitForChild("BuyTiers")
local TextLabel_upv_1 = BattlePass_1:WaitForChild("Title"):WaitForChild("YourTier"):WaitForChild(
    "TextLabel"
)
local FinalReward_upv_1 = Main_1:WaitForChild("FinalReward")
local Character_upv_1 = FinalReward_upv_1:WaitForChild("CharacterContainer"):WaitForChild(
    "Character"
)
local RewardIcon_upv_1 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("RewardIcon")
local ClaimAmountText_upv_1 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild(
    "ClaimAmountText"
)
local LockText_upv_1 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("LockText")
local Claim_upv_1 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("Claim")
local u4 = nil
local Authentication_upv_1 = FinalReward_upv_1:WaitForChild("Authentication")
local function IsFrameInBounds(a1, a2)
    local AbsolutePosition_1 = a1.AbsolutePosition
    local AbsolutePosition_2 = a2.AbsolutePosition
    return (AbsolutePosition_2.Y <= AbsolutePosition_1.Y)
        and (AbsolutePosition_1.Y + a1.AbsoluteSize.Y <= AbsolutePosition_2.Y + a2.AbsoluteSize.Y)
end
local function ScrollToItemRight(a1, a2)
    a1.CanvasPosition = Vector2.new(
        ((((a2.AbsolutePosition.X - a1.AbsolutePosition.X) + a1.CanvasPosition.X)
            + a2.AbsoluteSize.X) - a1.AbsoluteSize.X) + 75,
        0
    )
end
local function ScrollToItem(a1, a2)
    local AbsolutePosition_3 = a2.AbsolutePosition
    local AbsolutePosition_4 = a1.AbsolutePosition
    a1.CanvasPosition = Vector2.new(
        AbsolutePosition_3.X - AbsolutePosition_4.X,
        AbsolutePosition_3.Y - AbsolutePosition_4.Y
    )
end
local function UpdateBattlePassTiers()
    local BattlePass_2 = u1.EventStartInfo.BattlePass
    local v1 = ProfileData_upv_1[u1.Title]
    local ClaimedRewards_1 = v1.ClaimedRewards
    local CurrentTier_1 = v1.CurrentTier
    local v2 = nil
    for key_1, value_1 in tbl_upv_2[u1.Title] do
        local num_1 = tonumber(key_1)
        local v3 = CurrentTier_1 < num_1
        local v4 = num_1 <= CurrentTier_1
        local v5 = ClaimedRewards_1[key_1] == true
        local v6 = ClaimedRewards_1[key_1] ~= true
        local v7 = num_1 == BattlePass_2.TotalTiers
        v2 = false
        if (num_1 <= CurrentTier_1 + u3) then
            v2 = v3
        end
        local v8 = v6 and (v4 and (not v7))
        value_1.BuySelected.Visible = v2
        value_1.Container.ItemInfo.Claimed.Visible = v5
        value_1.Container.TitleFrame.View.Visible = v7
        value_1.Container.TitleFrame.Claim.Visible = v8
        value_1.Locked.Visible = v3
    end
    TextLabel_upv_1.Text = ("Your Tier: %*/%*"):format(CurrentTier_1, BattlePass_2.TotalTiers)
    if (BattlePass_2.TotalTiers > CurrentTier_1) then
        return
    end
    for _, value_2 in BuyTiers_upv_1:GetChildren() do
        if (value_2:IsA("Frame")) then
            value_2.Visible = value_2.Name == "PassComplete"
        end
    end
end
local function UpdateBuyTiers()
    local Container_1 = BuyTiers_upv_1:WaitForChild("TokenBuy"):WaitForChild("Container")
    local BattlePass_3 = u1.EventStartInfo.BattlePass
    local CurrentTier_2 = ProfileData_upv_1[u1.Title].CurrentTier
    local v9 = ScrollingFrame_upv_1:FindFirstChild(("Tier%*"):format((CurrentTier_2 + u3) + 1))
    if (v9) then
        ScrollingFrame_upv_1.CanvasPosition = Vector2.new(
            ((((v9.AbsolutePosition.X - ScrollingFrame_upv_1.AbsolutePosition.X)
                + ScrollingFrame_upv_1.CanvasPosition.X) + v9.AbsoluteSize.X)
                - ScrollingFrame_upv_1.AbsoluteSize.X) + 75,
            0
        )
    else
        local v10 = ScrollingFrame_upv_1:FindFirstChild(("Tier%*"):format(CurrentTier_2 + u3))
        if (v10) then
            ScrollingFrame_upv_1.CanvasPosition = Vector2.new(
                ((((v10.AbsolutePosition.X - ScrollingFrame_upv_1.AbsolutePosition.X)
                    + ScrollingFrame_upv_1.CanvasPosition.X) + v10.AbsoluteSize.X)
                    - ScrollingFrame_upv_1.AbsoluteSize.X) + 75,
                0
            )
        end
    end
    if (BattlePass_3.TotalTiers > CurrentTier_2 + u3) then
        local TierAmount_1 = Container_1:WaitForChild("BuyInfo"):WaitForChild("TierAmount")
        TierAmount_1.Text = ("%* Tier"):format(u3)
    else
        Container_1:WaitForChild("BuyInfo"):WaitForChild("TierAmount").Text = "FULL PASS"
    end
    local v11 = u3
    local TotalCost_1 = Container_1:WaitForChild("BuyInfo"):WaitForChild("TotalCost")
    TotalCost_1.Text = ItemService_upv_1:CommaNumber(v11 * BattlePass_3.TierCost)
    UpdateBattlePassTiers()
end
local function AddBuyTierAmount(a1)
    u3 = math.clamp(
        u3 + a1,
        1,
        u1.EventStartInfo.BattlePass.TotalTiers - ProfileData_upv_1[u1.Title].CurrentTier
    )
    UpdateBuyTiers()
end
local function UpdateFinalReward()
    local v12 = ProfileData_upv_1[u1.Title]
    local BattlePass_4 = u1.EventStartInfo.BattlePass
    local v13 = BattlePass_4.TotalTiers <= v12.CurrentTier
    local v14 = v12.FinalRewardClaimAmount or 0
    local v15 = ItemService_upv_1:GetDisplayInfo(
        BattlePass_4.FinalReward,
        BattlePass_4.FinalRewardType
    )
    RewardIcon_upv_1:WaitForChild("BoxIcon").Image = v15.Image
    RewardIcon_upv_1:WaitForChild("ItemName"):WaitForChild("Label").Text = v15.Name
    RewardIcon_upv_1:WaitForChild("ItemName").BackgroundColor3 = v15.Color
    Character_upv_1.Image = BattlePass_4.FinalRewardIcon
    local TextLabel_2 = Claim_upv_1:WaitForChild("Container"):WaitForChild("Container"):WaitForChild(
        "TextLabel"
    )
    TextLabel_2.Text = ItemService_upv_1:CommaNumber(BattlePass_4.FinalRewardCost)
    if (v13) then
        LockText_upv_1.Visible = false
        u4:Enable()
        if (v14 <= 0) then
            ClaimAmountText_upv_1.Visible = false
        else
            ClaimAmountText_upv_1.Text = ("%*x CLAIMED"):format(v14)
            ClaimAmountText_upv_1.Visible = true
        end
    else
        LockText_upv_1.Visible = true
        u4:Disable()
    end
    local _ = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("ClaimAmountText")
    local v16 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("LockText")
    local v17 = FinalReward_upv_1:WaitForChild("Right"):WaitForChild("Claim")
end
function tbl_upv_1.ConnectBuyTiers(a1)
    local tbl_3 = {}
    tbl_3[BuyTiers_upv_1.Plus1] = 1
    tbl_3[BuyTiers_upv_1.Plus10] = 10
    tbl_3[BuyTiers_upv_1.Minus1] = -1
    tbl_3[BuyTiers_upv_1.Minus10] = -10
    for key_2, value_upv_3 in tbl_3 do
        Button_upv_1.createButton(
            key_2,
            function()
                u3 = math.clamp(
                    u3 + value_upv_3,
                    1,
                    u1.EventStartInfo.BattlePass.TotalTiers
                        - ProfileData_upv_1[u1.Title].CurrentTier
                )
                UpdateBuyTiers()
            end
        )
    end
    Button_upv_1.createButton(
        BuyTiers_upv_1:WaitForChild("TokenBuy"):WaitForChild("Container"):WaitForChild("BuyButton"),
        function()
            local v16 = ProfileData_upv_1[u1.Title]
            if ((ProfileData_upv_1.Materials.Owned[u1.EventStartInfo.CurrencyName] or 0)
                < u3 * u1.EventStartInfo.BattlePass.TierCost) then
                return
            end
            v16.CurrentTier = v16.CurrentTier + u3
            u2.BuyBattlePassTiers:FireServer(u3)
            u3 = 1
            UpdateBuyTiers()
            UpdateFinalReward()
        end
    )
end
function tbl_upv_1.GenerateItems(a1)
    local BattlePass_5 = u1.EventStartInfo.BattlePass
    local v17 = ProfileData_upv_1[u1.Title]
    local ClaimedRewards_upv_2 = v17.ClaimedRewards
    local CurrentTier_3 = v17.CurrentTier
    tbl_upv_2[u1.Title] = {}
    for key_upv_3, value_4 in BattlePass_5.Rewards do
        local v18 = ItemService_upv_1:FindItemInfo(value_4.ItemID, value_4.ItemType)
        local v19 = value_4.DisplayInfo
            or (ItemService_upv_1:GetDisplayInfo(value_4.ItemID, value_4.ItemType))
        local v20 = Tier_upv_1:Clone()
        local Container_upv_2 = v20.Container
        if (tonumber(key_upv_3) == BattlePass_5.TotalTiers) then
            v20.Container.ItemInfo.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0)
            Container_upv_2.TitleFrame.View.ImageButton.Activated:Connect(
                function()
                    NavigationService_upv_1:GoToPage("FinalReward")
                end
            )
        end
        Container_upv_2.TitleFrame.TierNumber.TextLabel.Text = key_upv_3
        Container_upv_2.ItemInfo.Icon.Image = v19.Image
        if (v18 and (v18.Rarity == "Common" or v18.Rarity == nil)) then
            v19.Color = Color3.fromRGB(255, 255, 255)
        end
        Container_upv_2.ItemInfo.ItemName.Text = v19.Name
        Container_upv_2.ItemInfo.ItemName.TextColor3 = v19.Color
        local v21 = nil
        if (not (v21.Amount) or v21.Amount <= 0) then
            Container_upv_2.ItemInfo.Amount.Text = ""
        else
            Container_upv_2.ItemInfo.Amount.Text = "x" .. v21.Amount
        end
        Container_upv_2.TitleFrame.Claim.ImageButton.Activated:Once(
            function()
                Container_upv_2.TitleFrame.Claim.Visible = false
                u2.ClaimBattlePassReward:FireServer(key_upv_3)
                ClaimedRewards_upv_2[key_upv_3] = true
                UpdateBattlePassTiers()
            end
        )
        v20.Name = ("Tier%*"):format(key_upv_3)
        v20.LayoutOrder = tonumber(key_upv_3)
        v20.Parent = ScrollingFrame_upv_1
        tbl_upv_2[u1.Title][key_upv_3] = v20
    end
    UpdateBattlePassTiers()
    local UIListLayout_upv_1 = ScrollingFrame_upv_1:WaitForChild("UIListLayout")
    UIListLayout_upv_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            ScrollingFrame_upv_1.CanvasSize = UDim2.fromOffset(
                UIListLayout_upv_1.AbsoluteContentSize.X + 5,
                0
            )
        end
    )
    ScrollingFrame_upv_1.CanvasSize = UDim2.fromOffset(
        UIListLayout_upv_1.AbsoluteContentSize.X + 5,
        0
    )
    local AbsolutePosition_5 = ScrollingFrame_upv_1:FindFirstChild(
        ("Tier%*"):format(math.clamp(CurrentTier_3 - 1, 1, BattlePass_5.TotalTiers))
    ).AbsolutePosition
    local AbsolutePosition_6 = ScrollingFrame_upv_1.AbsolutePosition
    ScrollingFrame_upv_1.CanvasPosition = Vector2.new(
        AbsolutePosition_5.X - AbsolutePosition_6.X,
        AbsolutePosition_5.Y - AbsolutePosition_6.Y
    )
    tbl_upv_1:ConnectBuyTiers()
end
local function UpdateAuthentication()
    local v22 = game.Players.LocalPlayer:GetAttribute("Authenticated") == true
    Authentication_upv_1.Visible = not v22
end
function tbl_upv_1.Initialize(a1, a2)
    u1 = a2
    tbl_upv_1:GenerateItems()
    UpdateBuyTiers()
    u2 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild(
        u1.Title .. "Remotes"
    )
    local v23 = Button_upv_1.createButton(
        Claim_upv_1,
        function()
            if (u1.EventStartInfo.BattlePass.FinalRewardCost
                <= (ProfileData_upv_1.Materials.Owned[u1.EventStartInfo.CurrencyName] or 0)) then
                u4:Disable()
                u2.BuyBattlePassFinalReward:FireServer()
                local v24 = ProfileData_upv_1[u1.Title]
                v24.FinalRewardClaimAmount = v24.FinalRewardClaimAmount + 1
                UpdateBuyTiers()
                UpdateFinalReward()
                task.spawn(
                    function()
                        wait(1)
                        u4:Enable()
                    end
                )
            end
        end
    )
    u4 = v23
    UpdateFinalReward()
    Remotes_upv_1:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(
        function(a3)
            if (a3 ~= u1.Title) then
                return
            end
            UpdateBattlePassTiers()
        end
    )
    Button_upv_1.createButton(
        FinalReward_upv_1:WaitForChild("Title"):WaitForChild("Back"):WaitForChild("Back"),
        function()
            NavigationService_upv_1:GoToPage("BattlePass")
        end
    )
    local v25 = game.Players.LocalPlayer:GetAttribute("Authenticated") == true
    Authentication_upv_1.Visible = not v25
    game.Players.LocalPlayer:GetAttributeChangedSignal("Authenticated"):Connect(
        UpdateAuthentication
    )
end
return tbl_upv_1