local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = require(script.Parent.Parent.Modules)
local Events = script.Parent.Parent.Events

-- UI References
local Admin = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Admin")
local container = Admin:WaitForChild("container")
local wrapper = container:WaitForChild("wrapper")
local topBar = wrapper:WaitForChild("topBar")
local body = wrapper:WaitForChild("body")
local sidebar = body:WaitForChild("sidebar")
local content = body:WaitForChild("content")
local searchContainer = content:WaitForChild("searchContainer")
local searchInput = searchContainer:WaitForChild("wrapper"):WaitForChild("searchInput")
local clear = searchContainer:WaitForChild("clear")
local itemsSection = content:WaitForChild("itemsSection")
local itemsWrapper = itemsSection:WaitForChild("itemsWrapper")
local itemsContainer = itemsWrapper:WaitForChild("container")
local topFade = itemsSection:FindFirstChild("topFade")
local bottomFade = itemsSection:FindFirstChild("bottomFade")

-- Detail overlay references
local playerCountLabel = topBar:FindFirstChild("playerCount")
local detailOverlay = wrapper:WaitForChild("detailOverlay")
local detailFrame = detailOverlay:WaitForChild("detailFrame")
local detailIcon = detailFrame:WaitForChild("header"):WaitForChild("icon")
local detailTitle = detailFrame:WaitForChild("header"):WaitForChild("title")
local detailCategory = detailFrame:WaitForChild("header"):WaitForChild("categoryLabel")
local detailClose = detailFrame:WaitForChild("header"):WaitForChild("closeButton")
local detailDesc = detailFrame:WaitForChild("description")
local argsContainer = detailFrame:WaitForChild("argsContainer")
local executeBtn = detailFrame:WaitForChild("buttonRow"):WaitForChild("executeButton")
local cancelBtn = detailFrame:WaitForChild("buttonRow"):WaitForChild("cancelButton")

-- Module Dependencies
local DraggablePanel = require(Modules.Utilities.DraggablePanel)
local ScrollFade = require(Modules.Elements.ScrollFade)
local SoundController = require(Modules.Controllers.SoundController)
local Registry = require(ReplicatedStorage:WaitForChild("AdminCommands"):WaitForChild("Registry"))

local CmdrFunction
local cmdrClient = ReplicatedStorage:FindFirstChild("CmdrClient")
if cmdrClient then
    CmdrFunction = cmdrClient:FindFirstChild("CmdrFunction")
end

-- Styling constants
local FONT = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium)
local FONT_BOLD = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold)
local BG_BUTTON = Color3.fromRGB(33, 34, 39)
local BG_BUTTON_HOVER = Color3.fromRGB(43, 44, 50)
local BG_ACTIVE = Color3.fromRGB(88, 101, 242)
local STROKE_COLOR = Color3.fromRGB(247, 245, 255)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local TEXT_DIM = Color3.fromRGB(160, 160, 170)
local ACCENT = Color3.fromRGB(88, 101, 242)

local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local openTween = TweenService:Create(container, tweenInfo, { GroupTransparency = 0 })
local closeTween = TweenService:Create(container, tweenInfo, { GroupTransparency = 1 })

local state = {
    IsOpen = false,
    SelectedCategory = nil,
    CurrentCommand = nil,
}

local connections = {}
local draggable = nil
local scrollFade = nil
local categoryButtons = {}
local commandCards = {}
local argInputs = {}

-- ===== HELPER FUNCTIONS =====

local function makeStroke(parent, color, thickness, trans)
    local s = Instance.new("UIStroke")
    s.Color = color or STROKE_COLOR
    s.Thickness = thickness or 1
    s.Transparency = trans or 0.5
    s.Parent = parent
    return s
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(radius or 0.04, 0)
    c.Parent = parent
    return c
end

-- ===== COMMAND EXECUTION =====

local function runCommand(commandStr)
    if not CmdrFunction then
        Events.Notify:Fire("❌ Command system not available.")
        return
    end
    local success, result = pcall(function()
        return CmdrFunction:InvokeServer(commandStr, { Data = {} })
    end)
    
    if not success then
        Events.Notify:Fire("❌ Command failed: " .. tostring(result))
    elseif result and result ~= "" then
        Events.Notify:Fire("✅ " .. tostring(result))
    else
        Events.Notify:Fire("✅ Command executed.")
    end
end

-- ===== CATEGORY SIDEBAR =====

local function selectCategory(categoryName)
    state.SelectedCategory = categoryName
    
    -- Update button styles
    for name, btn in pairs(categoryButtons) do
        local isActive = (name == categoryName)
        TweenService:Create(btn, tweenInfo, {
            BackgroundColor3 = isActive and BG_ACTIVE or BG_BUTTON,
            BackgroundTransparency = isActive and 0.1 or 0.3,
        }):Play()
        local stroke = btn:FindFirstChildWhichIsA("UIStroke")
        if stroke then
            TweenService:Create(stroke, tweenInfo, {
                Transparency = isActive and 0.2 or 0.6,
            }):Play()
        end
    end
    
    -- Clear search when switching categories
    searchInput.Text = ""
    clear.Visible = false
    
    -- Populate command cards
    populateCommands(Registry.GetCommandsByCategory(categoryName))
end

local function createCategoryButton(categoryData)
    local btn = Instance.new("TextButton")
    btn.Name = categoryData.Name
    btn.Size = UDim2.new(1, 0, 0.1, 0)
    btn.BackgroundColor3 = BG_BUTTON
    btn.BackgroundTransparency = 0.3
    btn.Text = ""
    btn.LayoutOrder = categoryData.Order
    btn.Parent = sidebar
    makeCorner(btn, 0.08)
    makeStroke(btn, STROKE_COLOR, 1, 0.6)
    
    local icon = Instance.new("ImageLabel")
    icon.Name = "icon"
    icon.Size = UDim2.new(0.25, 0, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Position = UDim2.new(0.05, 0, 0.5, 0)
    icon.BackgroundTransparency = 1
    icon.Image = categoryData.Icon
    icon.Parent = btn
    
    local label = Instance.new("TextLabel")
    label.Name = "label"
    label.Size = UDim2.new(0.65, 0, 0.8, 0)
    label.AnchorPoint = Vector2.new(0, 0.5)
    label.Position = UDim2.new(0.3, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = categoryData.DisplayName
    label.TextColor3 = TEXT_COLOR
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = FONT
    label.Parent = btn
    
    btn.Activated:Connect(function()
        SoundController.PlaySound("CLICK")
        selectCategory(categoryData.Name)
    end)
    
    btn.MouseEnter:Connect(function()
        if state.SelectedCategory ~= categoryData.Name then
            SoundController.PlaySound("HOVER")
            TweenService:Create(btn, tweenInfo, { BackgroundTransparency = 0.15 }):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if state.SelectedCategory ~= categoryData.Name then
            TweenService:Create(btn, tweenInfo, { BackgroundTransparency = 0.3 }):Play()
        end
    end)
    
    categoryButtons[categoryData.Name] = btn
    return btn
end

-- ===== COMMAND CARDS =====

local function clearCommandCards()
    for _, card in ipairs(commandCards) do
        card:Destroy()
    end
    commandCards = {}
end

function populateCommands(commands)
    clearCommandCards()
    
    for index, cmd in ipairs(commands) do
        local card = Instance.new("TextButton")
        card.Name = cmd.Name
        card.Size = UDim2.new(0.97, 0, 0, 36)
        card.AutomaticSize = Enum.AutomaticSize.Y
        card.BackgroundColor3 = BG_BUTTON
        card.BackgroundTransparency = 0.35
        card.Text = ""
        card.LayoutOrder = index
        card.Parent = itemsContainer
        makeCorner(card, 0.06)
        makeStroke(card, STROKE_COLOR, 1, 0.6)
        
        local cardPadding = Instance.new("UIPadding")
        cardPadding.PaddingTop = UDim.new(0, 6)
        cardPadding.PaddingBottom = UDim.new(0, 6)
        cardPadding.PaddingLeft = UDim.new(0, 10)
        cardPadding.PaddingRight = UDim.new(0, 10)
        cardPadding.Parent = card
        
        local cardLayout = Instance.new("UIListLayout")
        cardLayout.FillDirection = Enum.FillDirection.Vertical
        cardLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        cardLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        cardLayout.Padding = UDim.new(0, 2)
        cardLayout.Parent = card
        
        -- Command name row
        local nameRow = Instance.new("Frame")
        nameRow.Size = UDim2.new(1, 0, 0, 18)
        nameRow.BackgroundTransparency = 1
        nameRow.Parent = card
        
        local cmdIcon = Instance.new("ImageLabel")
        cmdIcon.Size = UDim2.new(0, 16, 0, 16)
        cmdIcon.AnchorPoint = Vector2.new(0, 0.5)
        cmdIcon.Position = UDim2.new(0, 0, 0.5, 0)
        cmdIcon.BackgroundTransparency = 1
        cmdIcon.Image = cmd.Icon or "rbxassetid://6034258833"
        cmdIcon.Parent = nameRow
        
        local cmdName = Instance.new("TextLabel")
        cmdName.Size = UDim2.new(1, -22, 1, 0)
        cmdName.AnchorPoint = Vector2.new(0, 0.5)
        cmdName.Position = UDim2.new(0, 22, 0.5, 0)
        cmdName.BackgroundTransparency = 1
        cmdName.Text = cmd.Name
        cmdName.TextColor3 = TEXT_COLOR
        cmdName.TextScaled = true
        cmdName.TextXAlignment = Enum.TextXAlignment.Left
        cmdName.FontFace = FONT_BOLD
        cmdName.Parent = nameRow
        
        -- Description
        local cmdDesc = Instance.new("TextLabel")
        cmdDesc.Size = UDim2.new(1, 0, 0, 14)
        cmdDesc.BackgroundTransparency = 1
        cmdDesc.Text = cmd.Description
        cmdDesc.TextColor3 = TEXT_DIM
        cmdDesc.TextScaled = true
        cmdDesc.TextWrapped = true
        cmdDesc.TextXAlignment = Enum.TextXAlignment.Left
        cmdDesc.FontFace = FONT
        cmdDesc.Parent = card
        
        -- Store command reference
        card:SetAttribute("CommandIndex", index)
        
        -- Click to open detail
        card.Activated:Connect(function()
            SoundController.PlaySound("CLICK")
            showDetail(cmd)
        end)
        
        -- Hover effects
        card.MouseEnter:Connect(function()
            SoundController.PlaySound("HOVER")
            local stroke = card:FindFirstChildWhichIsA("UIStroke")
            if stroke then
                TweenService:Create(stroke, tweenInfo, { Transparency = 0.2 }):Play()
            end
            TweenService:Create(card, tweenInfo, { BackgroundTransparency = 0.15 }):Play()
        end)
        
        card.MouseLeave:Connect(function()
            local stroke = card:FindFirstChildWhichIsA("UIStroke")
            if stroke then
                TweenService:Create(stroke, tweenInfo, { Transparency = 0.6 }):Play()
            end
            TweenService:Create(card, tweenInfo, { BackgroundTransparency = 0.35 }):Play()
        end)
        
        table.insert(commandCards, card)
    end
    
    -- Show "no results" message if empty
    if #commands == 0 then
        local noResults = Instance.new("TextLabel")
        noResults.Name = "noResults"
        noResults.Size = UDim2.new(1, 0, 0, 40)
        noResults.BackgroundTransparency = 1
        noResults.Text = "No commands found."
        noResults.TextColor3 = TEXT_DIM
        noResults.TextScaled = true
        noResults.FontFace = FONT
        noResults.Parent = itemsContainer
        table.insert(commandCards, noResults)
    end
    
    if scrollFade then
        scrollFade:Update()
    end
end

-- ===== DETAIL POP-UP =====

local function clearArgInputs()
    for _, input in ipairs(argInputs) do
        input:Destroy()
    end
    argInputs = {}
end

function showDetail(cmd)
    state.CurrentCommand = cmd
    clearArgInputs()
    
    -- Populate detail frame
    detailIcon.Image = cmd.Icon or "rbxassetid://6034258833"
    detailTitle.Text = cmd.Name
    detailCategory.Text = string.upper(cmd.Category or "")
    detailDesc.Text = cmd.Description
    
    -- Create argument inputs
    if cmd.Arguments and #cmd.Arguments > 0 then
        for _, arg in ipairs(cmd.Arguments) do
            local argFrame = Instance.new("Frame")
            argFrame.Name = arg.Name
            argFrame.Size = UDim2.new(1, 0, 0, 40)
            argFrame.AutomaticSize = Enum.AutomaticSize.Y
            argFrame.BackgroundTransparency = 1
            argFrame.Parent = argsContainer
            
            local argLayout = Instance.new("UIListLayout")
            argLayout.FillDirection = Enum.FillDirection.Vertical
            argLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
            argLayout.Padding = UDim.new(0, 2)
            argLayout.Parent = argFrame
            
            -- Label
            local argLabel = Instance.new("TextLabel")
            argLabel.Size = UDim2.new(1, 0, 0, 16)
            argLabel.BackgroundTransparency = 1
            argLabel.Text = arg.Name .. (arg.Required and " *" or "")
            argLabel.TextColor3 = arg.Required and Color3.fromRGB(255, 180, 80) or TEXT_DIM
            argLabel.TextScaled = true
            argLabel.TextXAlignment = Enum.TextXAlignment.Left
            argLabel.FontFace = FONT_BOLD
            argLabel.Parent = argFrame
            
            -- Input box
            local argInput = Instance.new("TextBox")
            argInput.Size = UDim2.new(1, 0, 0, 28)
            argInput.BackgroundColor3 = BG_BUTTON
            argInput.BackgroundTransparency = 0.2
            argInput.PlaceholderText = arg.Placeholder or ("Enter " .. arg.Name .. "...")
            argInput.Text = ""
            argInput.TextColor3 = TEXT_COLOR
            argInput.PlaceholderColor3 = TEXT_DIM
            argInput.TextScaled = true
            argInput.FontFace = FONT
            argInput.ClearTextOnFocus = false
            argInput.TextXAlignment = Enum.TextXAlignment.Left
            argInput.Parent = argFrame
            makeCorner(argInput, 0.08)
            makeStroke(argInput, STROKE_COLOR, 1, 0.6)
            
            local inputPadding = Instance.new("UIPadding")
            inputPadding.PaddingLeft = UDim.new(0, 8)
            inputPadding.PaddingRight = UDim.new(0, 8)
            inputPadding.Parent = argInput
            
            table.insert(argInputs, argInput)
        end
    else
        -- No arguments needed
        local noArgsLabel = Instance.new("TextLabel")
        noArgsLabel.Size = UDim2.new(1, 0, 0, 30)
        noArgsLabel.BackgroundTransparency = 1
        noArgsLabel.Text = "This command requires no additional arguments."
        noArgsLabel.TextColor3 = TEXT_DIM
        noArgsLabel.TextScaled = true
        noArgsLabel.FontFace = FONT
        noArgsLabel.Parent = argsContainer
        table.insert(argInputs, noArgsLabel)
    end
    
    -- Show overlay with animation
    detailOverlay.Visible = true
    detailFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    detailFrame.Size = UDim2.new(0.85, 0, 0.75, 0)
    
    TweenService:Create(detailOverlay, tweenInfo, { BackgroundTransparency = 0.3 }):Play()
    TweenService:Create(detailFrame, tweenInfo, { Size = UDim2.new(0.85, 0, 0.75, 0) }):Play()
end

local function hideDetail()
    TweenService:Create(detailOverlay, tweenInfo, { BackgroundTransparency = 1 }):Play()
    
    task.delay(0.15, function()
        detailOverlay.Visible = false
        state.CurrentCommand = nil
        clearArgInputs()
    end)
end

-- ===== EXECUTE COMMAND =====

local function executeCommand()
    local cmd = state.CurrentCommand
    if not cmd then return end
    
    -- Build command string
    local commandStr = cmd.Command
    local missingRequired = false
    
    if cmd.Arguments and #cmd.Arguments > 0 then
        for i, arg in ipairs(cmd.Arguments) do
            local input = argInputs[i]
            if input and input:IsA("TextBox") then
                local value = input.Text
                if arg.Required and (not value or value == "") then
                    missingRequired = true
                    Events.Notify:Fire("⚠️ Missing required argument: " .. arg.Name)
                    break
                end
                if value and value ~= "" then
                    commandStr = commandStr .. " " .. value
                end
            end
        end
    end
    
    if missingRequired then return end
    
    runCommand(commandStr)
    hideDetail()
end

-- ===== INITIALIZATION =====

topBar.Active = true
draggable = DraggablePanel.new(topBar, container, { ScreenGui = Admin })
scrollFade = ScrollFade.new(itemsWrapper, topFade, bottomFade)

searchInput.ClearTextOnFocus = false
clear.Visible = false

-- Search functionality
searchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = searchInput.Text
    clear.Visible = text ~= ""
    
    if text == "" then
        -- Show current category commands
        if state.SelectedCategory then
            populateCommands(Registry.GetCommandsByCategory(state.SelectedCategory))
        end
    else
        -- Search across all commands
        populateCommands(Registry.SearchCommands(text))
    end
end)

clear.Activated:Connect(function()
    searchInput.Text = ""
    searchInput:CaptureFocus()
end)

-- Detail overlay connections
detailClose.Activated:Connect(function()
    SoundController.PlaySound("CLICK")
    hideDetail()
end)

cancelBtn.Activated:Connect(function()
    SoundController.PlaySound("CLICK")
    hideDetail()
end)

executeBtn.Activated:Connect(function()
    SoundController.PlaySound("CLICK")
    executeCommand()
end)

-- Execute button hover effects
executeBtn.MouseEnter:Connect(function()
    TweenService:Create(executeBtn, tweenInfo, { BackgroundTransparency = 0 }):Play()
end)
executeBtn.MouseLeave:Connect(function()
    TweenService:Create(executeBtn, tweenInfo, { BackgroundTransparency = 0.1 }):Play()
end)

cancelBtn.MouseEnter:Connect(function()
    TweenService:Create(cancelBtn, tweenInfo, { BackgroundTransparency = 0.1 }):Play()
end)
cancelBtn.MouseLeave:Connect(function()
    TweenService:Create(cancelBtn, tweenInfo, { BackgroundTransparency = 0.2 }):Play()
end)

-- Build category sidebar
local categories = Registry.GetCategories()
for _, categoryData in ipairs(categories) do
    createCategoryButton(categoryData)
end

-- Select first category by default
if #categories > 0 then
    selectCategory(categories[1].Name)
end

-- Update player count
local function updatePlayerCount()
    if playerCountLabel then
        playerCountLabel.Text = "Players: " .. #Players:GetPlayers()
    end
end
updatePlayerCount()
Players.PlayerAdded:Connect(updatePlayerCount)
Players.PlayerRemoving:Connect(updatePlayerCount)

-- ===== OPEN/CLOSE =====

function state.Close(skipButtonVisibility)
    if not state.IsOpen then return end
    
    state.IsOpen = false
    Events.InterfaceAction:Fire("Remove", script.Name)
    
    if skipButtonVisibility ~= true then
        Events.SetButtonsVisible:Fire("All")
    end
    
    for _, conn in connections do
        if conn then conn:Disconnect() end
    end
    table.clear(connections)
    
    closeTween:Play()
    closeTween.Completed:Once(function()
        if state.IsOpen ~= true then
            Admin.Enabled = false
        end
    end)
end

function state.Open(toggle)
    if state.IsOpen then
        if toggle then
            state.Close()
        end
        return
    end
    
    state.IsOpen = true
    Events.InterfaceAction:Fire("Add", script.Name, state.Close)
    Events.SetButtonsVisible:Fire("All", { "admin" })
    
    draggable:Reset()
    Admin.Enabled = true
    container.GroupTransparency = 1
    openTween:Play()
    
    table.insert(connections, topBar.closeButton.Activated:Connect(state.Close))
    
    scrollFade:Update()
end

Admin.Enabled = false

Events.DisplayAdmin.Event:Connect(state.Open)

return state