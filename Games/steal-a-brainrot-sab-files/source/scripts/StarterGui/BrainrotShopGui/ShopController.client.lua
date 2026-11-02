local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animals = require(ReplicatedStorage.Shared.Animals)

local screenGui = script.Parent
local mainFrame = screenGui.MainFrame
local closeButton = mainFrame.TitleBar.CloseButton

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local isOpen = false

local function openShop()
    if isOpen then return end
    isOpen = true
    
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundTransparency = 1
    
    local openTween = TweenService:Create(mainFrame, tweenInfo, {
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundTransparency = 0
    })
    openTween:Play()
    
    for _, item in ipairs(mainFrame.ItemsContainer:GetChildren()) do
        if item:IsA("Frame") then
            item.BackgroundTransparency = 1
            task.wait(0.05)
            TweenService:Create(item, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0
            }):Play()
        end
    end
end

local function closeShop()
    if not isOpen then return end
    isOpen = false
    
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    closeTween:Play()
    
    closeTween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end

local function setupBuyButton(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(100, 255, 150),
            Size = UDim2.new(0, 55, 0, 28)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 200, 120),
            Size = UDim2.new(0, 50, 0, 25)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 45, 0, 22)}):Play()
        task.wait(0.1)
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0, 50, 0, 25)}):Play()
    end)
end

local function setupItemViewport(item)
    if not item:IsA("Frame") then return end
    local viewport = item:FindFirstChild("ItemImage")
    if viewport and viewport:IsA("ViewportFrame") then
        local animalName = item.Name:gsub("Item_", "")
        local model = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)
        if model then
            local ok, cleanup = pcall(function()
                return Animals:AttachOnViewport(animalName, viewport, true)
            end)
            if not ok then
                warn("Failed to attach animal on viewport for:", animalName, cleanup)
            end
        else
            warn("Animal model not found for item:", animalName)
        end
    end
end

for _, item in ipairs(mainFrame.ItemsContainer:GetChildren()) do
    if item:IsA("Frame") then
        local buyBtn = item:FindFirstChild("BuyButton")
        if buyBtn then setupBuyButton(buyBtn) end
        setupItemViewport(item)
    end
end

closeButton.MouseButton1Click:Connect(closeShop)

closeButton.MouseEnter:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100),
        Size = UDim2.new(0, 45, 0, 45)
    }):Play()
end)

closeButton.MouseLeave:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 70, 70),
        Size = UDim2.new(0, 40, 0, 40)
    }):Play()
end)

local remote = ReplicatedStorage:WaitForChild("OpenShopRemote", 5)
if remote then
    remote.OnClientEvent:Connect(openShop)
end
