local tbl_upv_1 = {}
local _ = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType")
)
local Button_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button")
)
local ItemService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService")
)
local ItemPopupService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild(
        "ItemPopupService"
    )
)
local u1 = Color3.fromRGB(70, 169, 255)
local u2 = Color3.fromRGB(103, 255, 1)
local Gifting_upv_1 = script.Parent.Parent:WaitForChild("Container"):WaitForChild("Main"):WaitForChild(
    "Gifting"
)
local RequiredBar_upv_1 = Gifting_upv_1:WaitForChild("Container"):WaitForChild("Center"):WaitForChild(
    "RequiredBar"
)
local Buy1_upv_1 = Gifting_upv_1:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("Buy1")
local Buy10_upv_1 = Gifting_upv_1:WaitForChild("Container"):WaitForChild("Left"):WaitForChild(
    "Buy10"
)
local Claim_upv_1 = Gifting_upv_1:WaitForChild("Container"):WaitForChild("Right"):WaitForChild(
    "Claim"
)
local u3 = nil
local ProfileData_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData")
)
local Sync_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")
)
local EventInfoService_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "EventInfoService"
    )
)
EventInfoService_upv_1:WaitForInitializedAsync()
local u4 = EventInfoService_upv_1:GetMainEvent()
local CurrencyName_upv_1 = u4.EventStartInfo.CurrencyName
local u5 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild(
    u4.Title .. "Remotes"
)
local RewardRequiredAmount_upv_1 = u4.EventStartInfo.Gifting.RewardRequiredAmount
local GiftCurrencyPrice_upv_1 = u4.EventStartInfo.Gifting.GiftCurrencyPrice
function tbl_upv_1.Update(a1)
    local v1 = ProfileData_upv_1[u4.Title]
    local v2 = v1.GiftsGiven or 0
    local v3 = v1.GiftRewardClaimedAmount or 0
    local v4 = (v3 + 1) * RewardRequiredAmount_upv_1 <= v2
    local v5 = v2 - v3 * RewardRequiredAmount_upv_1
    local v6 = math.clamp(v5 / RewardRequiredAmount_upv_1, 0, 1)
    RequiredBar_upv_1.RequiredAmount.Text = v5 .. "/" .. RewardRequiredAmount_upv_1
    RequiredBar_upv_1.BarContainer.Bar.Size = UDim2.new(v6, 0, 1, 0)
    local Bar_1 = RequiredBar_upv_1.BarContainer.Bar
    Bar_1.BackgroundColor3 = v4 and u2 or u1
    RequiredBar_upv_1.ReadyClaim.Visible = v4
    RequiredBar_upv_1.RequiredAmount.Visible = not v4
    Gifting_upv_1.Container.Center.TotalGiven.Text = "Total Given: " .. v2
    Gifting_upv_1.Container.Center.TotalGiven.Visible = v3 > 0
    Gifting_upv_1.Container.Right.RewardIcon.Background.Owned.Visible = v3 > 0
    Gifting_upv_1.Container.Right.RewardIcon.ClaimCounter.Visible = v3 > 1
    Gifting_upv_1.Container.Right.RewardIcon.ClaimCounter.Text = v3 .. "x Claimed"
    if (v4) then
        u3:Enable()
    else
        u3:Disable()
    end
end
function tbl_upv_1.Open(a1)
    tbl_upv_1:Update()
end
local function claimGiftingReward()
    local v8 = ProfileData_upv_1[u4.Title]
    if ((((v8.GiftRewardClaimedAmount or 0) + 1) * RewardRequiredAmount_upv_1)
        > (v8.GiftsGiven or 0)) then
        return
    end
    u5.ClaimGiftReward:FireServer()
    ProfileData_upv_1[u4.Title].GiftRewardClaimedAmount = (v8.GiftRewardClaimedAmount or 0) + 1
    u3:Disable()
    tbl_upv_1:Update()
end
local function buyGiftsWithTokens(a1)
    local v9 = ProfileData_upv_1.Materials.Owned[CurrencyName_upv_1] or 0
    local v10 = GiftCurrencyPrice_upv_1 * a1
    if (v9 < v10) then
        return
    end
    ProfileData_upv_1.Materials.Owned[CurrencyName_upv_1] = v9 - v10
    ProfileData_upv_1[u4.Title].GiftInventory = (ProfileData_upv_1[u4.Title].GiftInventory or 0)
        + a1
    ItemPopupService_upv_1:AddNewItem("GiftVisual", "Materials", a1)
    u5.BuyGift:FireServer(a1)
end
local function updateGiftTool(a1, a2)
    ProfileData_upv_1[u4.Title].GiftsGiven = a2
    ProfileData_upv_1[u4.Title].GiftInventory = a1
    local TextLabel_1 = Gifting_upv_1:WaitForChild("Title"):WaitForChild("Gifts"):WaitForChild(
        "Container"
    ):WaitForChild("TextLabel")
    TextLabel_1.Text = ItemService_upv_1:CommaNumber(ProfileData_upv_1[u4.Title].GiftInventory or 0)
    tbl_upv_1:Update()
end
function tbl_upv_1.Initialize()
    Button_upv_1.createButton(
        Buy1_upv_1,
        function()
            buyGiftsWithTokens(1)
        end
    )
    Button_upv_1.createButton(
        Buy10_upv_1,
        function()
            buyGiftsWithTokens(10)
        end
    )
    local Gifting_2 = u4.EventStartInfo.Gifting
    Gifting_upv_1.Container.Right.RewardIcon.BoxIcon.Image = Sync_upv_1.Weapons[Gifting_2.RewardID].Image
    u3 = Button_upv_1.createButton(Claim_upv_1, claimGiftingReward)
    local TextLabel_2 = Buy1_upv_1:WaitForChild("Container"):WaitForChild("Container"):WaitForChild(
        "ListContainer"
    ):WaitForChild("TextLabel")
    TextLabel_2.Text = ItemService_upv_1:CommaNumber(Gifting_2.GiftCurrencyPrice)
    local TextLabel_3 = Buy10_upv_1:WaitForChild("Container"):WaitForChild("Container"):WaitForChild(
        "ListContainer"
    ):WaitForChild("TextLabel")
    TextLabel_3.Text = ItemService_upv_1:CommaNumber(Gifting_2.GiftCurrencyPrice * 10)
    local ChancesFrame_upv_1 = Gifting_upv_1.Container.Left.GiftIcon.ChancesFrame
    Gifting_upv_1.Container.Left.GiftIcon.ChancesButton.Button.Activated:Connect(
        function()
            ChancesFrame_upv_1.Visible = not ChancesFrame_upv_1.Visible
        end
    )
    updateGiftTool(
        ProfileData_upv_1[u4.Title].GiftInventory,
        ProfileData_upv_1[u4.Title].GiftsGiven
    )
    u5.UpdateGiftTool.OnClientEvent:Connect(updateGiftTool)
    tbl_upv_1:Update()
    EventInfoService_upv_1:OnEventEnded(
        function()
            Gifting_upv_1:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("Buy1").Visible = false
            Gifting_upv_1:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("Buy10").Visible = false
        end
    )
end
return tbl_upv_1