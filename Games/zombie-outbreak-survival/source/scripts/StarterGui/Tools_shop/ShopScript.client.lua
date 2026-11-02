local Frame = script.Parent.Frame
local List = Frame.List
local Template = List.Template
local Remote = game.ReplicatedStorage.Remotes.BuyTool
local Notification = game.ReplicatedStorage.Remotes.Notification
local Tools = game.ReplicatedStorage.Tools:GetChildren()
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local Values = game.ReplicatedStorage:WaitForChild("Values")
local VIP_GAMEPASS_ID = Values:WaitForChild("VIPGamepassId").Value

-- Track VIP status
local isVIP = false

-- Function to check VIP status
local function checkVIPStatus()
    local success, hasPass = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIP_GAMEPASS_ID)
    end)
    
    if success then
        isVIP = hasPass
    else
        isVIP = false
        warn("Failed to check VIP status: " .. tostring(hasPass))
    end
end

-- Check VIP status initially
checkVIPStatus()

-- Listen for gamepass purchase
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(playerId, gamepassId, wasPurchased)
    if playerId == player.UserId and gamepassId == VIP_GAMEPASS_ID and wasPurchased then
        isVIP = true
        -- Refresh shop to show VIP items
        refreshShop()
        -- Show notification
        Notification:FireServer("VIP Gamepass Purchased!", "You now have access to VIP items!", 5)
    end
end)

-- Function to refresh the shop
local function refreshShop()
    -- Clear existing tool entries (except Template)
    for _, child in ipairs(List:GetChildren()) do
        if child:IsA("Frame") and child ~= Template then
            child:Destroy()
        end
    end

    -- Populate the shop list with tools
    for _, item in ipairs(Tools) do
        if item.Name ~= "Template" then -- Prevent template from being listed
            local Clone = Template:Clone()
            Clone.Parent = List
            Clone.Name = item.Name
            Clone.Visible = true
            Clone.ItemName.Text = item.ItemInfo.ItemName.Value
            
            -- Check if this is a VIP item
            local isVIPItem = item.ItemInfo:FindFirstChild("VIP") and item.ItemInfo.VIP.Value
            
            -- Show/hide VIP label
            local vipLabel = Clone:FindFirstChild("VIPLabel")
            if vipLabel then
                vipLabel.Visible = isVIPItem
            end
            
            -- Set price text
            if item.ItemInfo.Price.Value == 0 then
                Clone.Price.Text = "Free!"
            else
                Clone.Price.Text = tostring(item.ItemInfo.Price.Value)
            end
            
            -- Handle buy button click
            Clone.Buy.MouseButton1Click:Connect(function()
                -- Check if VIP item and player doesn't have VIP
                if isVIPItem and not isVIP then
                    -- Prompt to buy VIP gamepass
                    MarketplaceService:PromptGamePassPurchase(player, VIP_GAMEPASS_ID)
                    Notification:FireServer("VIP Required", "You need VIP to purchase this item!", 3)
                    return
                end
                
                -- Check if player has enough money
                local money = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money")
                if money and money.Value >= item.ItemInfo.Price.Value then
                    Remote:FireServer(item.Name, item.ItemInfo.Price.Value)
                else
                    Notification:FireServer("Insufficient Funds", "You don't have enough money!", 3)
                end
            end)
            
            -- Hover effect removed
        end
    end

    -- Update CanvasSize to fit content after all clones are added
    task.wait() -- Wait for layout to update
    local layout = List:FindFirstChildWhichIsA("UIListLayout")
    local contentSize = layout and layout.AbsoluteContentSize or List.AbsoluteContentSize
    List.CanvasSize = UDim2.new(5, contentSize.X, 0, contentSize.Y)
end

-- Initial shop population
refreshShop()