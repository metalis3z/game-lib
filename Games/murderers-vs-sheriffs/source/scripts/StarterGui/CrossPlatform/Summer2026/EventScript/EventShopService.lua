local tbl_1 = {}
local ScrollingFrame_upv_1 = script.Parent.Parent:WaitForChild("Container"):WaitForChild("Main"):WaitForChild(
    "ShopBundles"
):WaitForChild("Main"):WaitForChild("Items"):WaitForChild("ScrollingFrame")
local ProfileData_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData")
)
local NavigationService_upv_1 = require(script.Parent:WaitForChild("NavigationService"))
local Sync_upv_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")
)
local TweenService_upv_1 = game:GetService("TweenService")
local Remotes_1 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local Shop_upv_1 = Remotes_1:WaitForChild("Shop")
local Inventory_upv_1 = Remotes_1:WaitForChild("Inventory")
local u1 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EventInfoService_1 = require(
    game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild(
        "EventInfoService"
    )
)
EventInfoService_1:WaitForInitializedAsync()
local u3 = EventInfoService_1:GetMainEvent()
local tbl_upv_2 = {}
local function UpdateRequiredPurchases()
    local v1 = nil
    for _, value_1 in ScrollingFrame_upv_1:GetChildren() do
        if (not (value_1:FindFirstChild("PurchaseButton"))) then
            continue
        end
        local v2 = Sync_upv_1.NewShop[value_1.Name]
        if (not (v2)) then
            continue
        end
        local RequiredPurchases_1 = v2.RequiredPurchases
        if (not (RequiredPurchases_1)) then
            continue
        end
        v1 = true
        for v3, value_2 in RequiredPurchases_1 do
            if (not (ProfileData_upv_1.OneTimePurchases[value_2])) then
                v1 = false
                break
            end
        end
        value_1.Visible = v1
    end
end
local function UpdateOneTimePurchase()
    local OneTimePurchases_1 = ProfileData_upv_1.OneTimePurchases
    for _, value_upv_3 in ScrollingFrame_upv_1:GetChildren() do
        if (not (value_upv_3:FindFirstChild("PurchaseButton"))) then
            continue
        end
        local Name_1 = value_upv_3.Name
        if (not (Sync_upv_1.NewShop[Name_1]) or tbl_upv_2[Name_1]) then
            continue
        end
        if (OneTimePurchases_1[Name_1]) then
            tbl_upv_2[Name_1] = true
            task.spawn(
                function()
                    value_upv_3.Purchased.Visible = true
                    task.wait(2)
                    local tbl_3 = {GroupTransparency = 1}
                    tbl_3.Size = UDim2.new(0, 0, 1, 0)
                    TweenService_upv_1:Create(value_upv_3, u1, tbl_3):Play()
                    task.wait(u1.Time)
                    value_upv_3.Visible = false
                end
            )
        end
    end
end
local function ScrollToItem(a1)
    local v3 = ScrollingFrame_upv_1:FindFirstChild(a1)
    if (v3) then
        local AbsolutePosition_1 = v3.AbsolutePosition
        local AbsolutePosition_2 = ScrollingFrame_upv_1.AbsolutePosition
        local v4 = AbsolutePosition_1.X - AbsolutePosition_2.X
            + ScrollingFrame_upv_1.CanvasPosition.X
        local v5 = AbsolutePosition_1.Y - AbsolutePosition_2.Y
            + ScrollingFrame_upv_1.CanvasPosition.Y
        local v6 = nil
        if (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.X) then
            v6 = Vector2.new(v4, ScrollingFrame_upv_1.CanvasPosition.Y)
        elseif (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.Y) then
            v6 = Vector2.new(ScrollingFrame_upv_1.CanvasPosition.X, v5)
        elseif (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.XY) then
            v6 = Vector2.new(v4, v5)
        end
        local tbl_4 = {}
        tbl_4.CanvasPosition = v6
        TweenService_upv_1:Create(ScrollingFrame_upv_1, u2, tbl_4):Play()
    else
        warn("Target item not found:", a1)
    end
end
local function ConnectOneTimePurchase()
    for key_1, _ in u3.EventStartInfo.ShopData do
        if (ProfileData_upv_1.OneTimePurchases[key_1]) then
            tbl_upv_2[key_1] = true
            ScrollingFrame_upv_1[key_1].Visible = false
        end
    end
    UpdateOneTimePurchase()
    UpdateRequiredPurchases()
    Inventory_upv_1.ProfileDataChanged.Event:Connect(
        function(a1)
            if (a1 ~= "OneTimePurchases") then
                return
            end
            UpdateOneTimePurchase()
            UpdateRequiredPurchases()
        end
    )
    Shop_upv_1:WaitForChild("ProductPurchaseComplete").OnClientEvent:Connect(
        UpdateRequiredPurchases
    )
end
local function UpdateShopItemContainer()
    local UIListLayout_1 = ScrollingFrame_upv_1:WaitForChild("UIListLayout")
    local v7 = 0
    local v8 = 0
    if (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.X) then
        v7 = UIListLayout_1.AbsoluteContentSize.X + 5
    elseif (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.Y) then
        v8 = UIListLayout_1.AbsoluteContentSize.Y + 5
    elseif (ScrollingFrame_upv_1.ScrollingDirection == Enum.ScrollingDirection.XY) then
        v7, v8 = UIListLayout_1.AbsoluteContentSize.X + 5, UIListLayout_1.AbsoluteContentSize.Y + 5
    end
    ScrollingFrame_upv_1.CanvasSize = UDim2.fromOffset(v7, v8)
end
function tbl_1.GenerateShopItems(a1)
    ScrollingFrame_upv_1:WaitForChild("UIListLayout"):GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(UpdateShopItemContainer)
    UpdateShopItemContainer()
    for _, value_upv_4 in ScrollingFrame_upv_1:GetChildren() do
        local PurchaseButton_1 = value_upv_4:FindFirstChild("PurchaseButton")
        if (PurchaseButton_1) then
            PurchaseButton_1.Activated:Connect(
                function()
                    Shop_upv_1.BuyItemNew:InvokeServer(value_upv_4.Name, "Robux")
                end
            )
        end
    end
    NavigationService_upv_1.PageChanged.Event:Connect(
        function(a2, a3)
            if (a2 ~= "ShopBundles") then
                return
            end
            if (a3) then
                if (a3 ~= "ItemBundle") then
                    ScrollToItem(a3)
                elseif (ScrollingFrame_upv_1.SnowyBundleEffect.Visible) then
                    ScrollToItem("SnowyBundleEffect")
                else
                    ScrollToItem("SnowyBundle")
                end
            else
                local tbl_5 = {}
                tbl_5.CanvasPosition = Vector2.new(0, 0)
                TweenService_upv_1:Create(ScrollingFrame_upv_1, u2, tbl_5):Play()
            end
        end
    )
    ConnectOneTimePurchase()
end
return tbl_1