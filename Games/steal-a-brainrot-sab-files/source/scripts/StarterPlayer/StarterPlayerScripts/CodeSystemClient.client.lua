--[[
    Code System Client Script
    Handles UI interaction, tab switching, code redemption, and admin panel.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("CodeRemotes")
local redeemEvent = remotes:WaitForChild("RedeemCode")
local adminAction = remotes:WaitForChild("AdminAction")
local notifyClient = remotes:WaitForChild("NotifyClient")
local requestCodes = remotes:WaitForChild("RequestCodes")

-- ===== UI REFERENCES =====
local gui = player:WaitForChild("PlayerGui"):WaitForChild("CodeSystemGui")
local toggleBtn = gui:WaitForChild("ToggleBtn")
local mainFrame = gui:WaitForChild("MainFrame")
local closeBtn = mainFrame:WaitForChild("CloseBtn")
local redeemTab = mainFrame:WaitForChild("RedeemTab")
local adminTab = mainFrame:WaitForChild("AdminTab")
local redeemPage = mainFrame:WaitForChild("RedeemPage")
local adminPage = mainFrame:WaitForChild("AdminPage")

-- Redeem page
local codeInput = redeemPage:WaitForChild("CodeInput")
local redeemBtn = redeemPage:WaitForChild("RedeemBtn")
local redeemNotif = redeemPage:WaitForChild("NotifLabel")

-- Admin page
local notAuthLabel = adminPage:WaitForChild("NotAuthLabel")
local adminContent = adminPage:WaitForChild("AdminContent")
local adminCodeInput = adminContent:WaitForChild("CodeInput")
local toolInput = adminContent:WaitForChild("ToolInput")
local usesInput = adminContent:WaitForChild("UsesInput")
local addBtn = adminContent:WaitForChild("AddBtn")
local delBtn = adminContent:WaitForChild("DelBtn")
local codesList = adminContent:WaitForChild("CodesList")
local adminNotif = adminContent:WaitForChild("AdminNotif")

-- ===== TOGGLE PANEL =====
local panelVisible = false
mainFrame.Visible = false

toggleBtn.MouseButton1Click:Connect(function()
    panelVisible = not panelVisible
    mainFrame.Visible = panelVisible
end)

closeBtn.MouseButton1Click:Connect(function()
    panelVisible = false
    mainFrame.Visible = false
end)

-- ===== FORWARD DECLARATIONS =====
local checkAdminStatus
local refreshCodesList

-- ===== TAB SWITCHING =====
local function switchTab(tab)
    if tab == "redeem" then
        redeemPage.Visible = true
        adminPage.Visible = false
        redeemTab.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        adminTab.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    elseif tab == "admin" then
        redeemPage.Visible = false
        adminPage.Visible = true
        redeemTab.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        adminTab.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        if checkAdminStatus then checkAdminStatus() end
    end
end

redeemTab.MouseButton1Click:Connect(function() switchTab("redeem") end)
adminTab.MouseButton1Click:Connect(function() switchTab("admin") end)

-- ===== NOTIFICATIONS =====
local notifLabels = {}

local function showNotif(label, message, color)
    label.Text = message
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    notifLabels[label] = true
    task.spawn(function()
        task.wait(5)
        if notifLabels[label] then
            label.Text = ""
            notifLabels[label] = nil
        end
    end)
end

notifyClient.OnClientEvent:Connect(function(message, color)
    -- Handle refresh signal for admins
    if message == "__REFRESH__" then
        if refreshCodesList then refreshCodesList() end
        return
    end
    
    -- Show on whichever page is visible
    if adminPage.Visible then
        showNotif(adminNotif, message, color)
    else
        showNotif(redeemNotif, message, color)
    end
end)

-- ===== REDEEM CODE =====
redeemBtn.MouseButton1Click:Connect(function()
    local code = codeInput.Text
    if code == "" then
        showNotif(redeemNotif, "Please enter a code!", Color3.fromRGB(200, 100, 100))
        return
    end
    redeemEvent:FireServer(code)
    codeInput.Text = ""
end)

codeInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        redeemBtn:Activate()
    end
end)

-- ===== ADMIN PANEL =====
local isAdmin = false

checkAdminStatus = function()
    local success, result = pcall(function()
        return requestCodes:InvokeServer()
    end)
    
    if success and result ~= nil then
        isAdmin = true
        notAuthLabel.Visible = false
        adminContent.Visible = true
        if refreshCodesList then refreshCodesList() end
    else
        isAdmin = false
        notAuthLabel.Visible = true
        adminContent.Visible = false
    end
end

refreshCodesList = function()
    if not isAdmin then return end
    
    -- Clear existing
    for _, child in ipairs(codesList:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Fetch codes
    local success, codes = pcall(function()
        return requestCodes:InvokeServer()
    end)
    
    if not success or not codes then return end
    
    local count = 0
    for codeName, data in pairs(codes) do
        count = count + 1
        local entry = Instance.new("Frame")
        entry.Size = UDim2.new(1, -10, 0, 45)
        entry.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        entry.BorderSizePixel = 0
        entry.Parent = codesList
        
        local entryCorner = Instance.new("UICorner")
        entryCorner.CornerRadius = UDim.new(0, 4)
        entryCorner.Parent = entry
        
        local codeText = Instance.new("TextLabel")
        codeText.Size = UDim2.new(1, -10, 0, 20)
        codeText.Position = UDim2.new(0, 5, 0, 2)
        codeText.BackgroundTransparency = 1
        codeText.Text = codeName
        codeText.TextColor3 = Color3.fromRGB(100, 200, 255)
        codeText.Font = Enum.Font.GothamBold
        codeText.TextSize = 13
        codeText.TextXAlignment = Enum.TextXAlignment.Left
        codeText.Parent = entry
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 0, 20)
        infoText.Position = UDim2.new(0, 5, 0, 22)
        infoText.BackgroundTransparency = 1
        local usesStr = data.maxUses > 0 
            and ("Uses: " .. data.uses .. "/" .. data.maxUses)
            or "Uses: " .. data.uses .. " (unlimited)"
        infoText.Text = "Tool: " .. data.toolName .. " | " .. usesStr
        infoText.TextColor3 = Color3.fromRGB(180, 180, 180)
        infoText.Font = Enum.Font.Gotham
        infoText.TextSize = 11
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.Parent = entry
    end
    
    if count == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, -10, 0, 30)
        empty.BackgroundTransparency = 1
        empty.Text = "No codes yet. Add one above!"
        empty.TextColor3 = Color3.fromRGB(150, 150, 150)
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 12
        empty.Parent = codesList
    end
    
    -- Update canvas size
    codesList.CanvasSize = UDim2.new(0, 0, 0, count * 48 + 5)
end

-- Add code button
addBtn.MouseButton1Click:Connect(function()
    if not isAdmin then return end
    
    local code = adminCodeInput.Text
    local tool = toolInput.Text
    local uses = usesInput.Text
    
    if code == "" then
        showNotif(adminNotif, "Code name cannot be empty!", Color3.fromRGB(200, 100, 100))
        return
    end
    if tool == "" then
        showNotif(adminNotif, "Tool name cannot be empty!", Color3.fromRGB(200, 100, 100))
        return
    end
    
    adminAction:FireServer("add", {
        code = code,
        tool = tool,
        uses = uses,
    })
    
    -- Clear inputs
    adminCodeInput.Text = ""
    toolInput.Text = ""
    usesInput.Text = "0"
end)

-- Delete code button
delBtn.MouseButton1Click:Connect(function()
    if not isAdmin then return end
    
    local code = adminCodeInput.Text
    if code == "" then
        showNotif(adminNotif, "Enter a code name to delete!", Color3.fromRGB(200, 100, 100))
        return
    end
    
    adminAction:FireServer("delete", {
        code = code,
    })
    
    adminCodeInput.Text = ""
end)

-- Initialize
switchTab("redeem")
print("[CodeSystem] Client script loaded.")