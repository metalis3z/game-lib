local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Net = require(ReplicatedStorage.Packages.Net)
task.wait(2) -- Laisser le serveur initialiser
local InviteRemote   = Net:RemoteEvent("InviteSystem/Invite")
local ResponseRemote = Net:RemoteEvent("InviteSystem/Response")
local TpRemote       = Net:RemoteEvent("InviteSystem/Teleport")

local function createInviteGui(data)
    local old = PlayerGui:FindFirstChild("InviteNotif")
    if old then old:Destroy() end

    local screen = Instance.new("ScreenGui")
    screen.Name = "InviteNotif"
    screen.ResetOnSpawn = false
    screen.DisplayOrder = 999
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screen.Parent = PlayerGui

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 320, 0, 130)
    panel.Position = UDim2.new(0.5, -160, 0, -150)
    panel.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    panel.BorderSizePixel = 0
    panel.ZIndex = 10
    panel.Parent = screen
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", panel)
    stroke.Color = Color3.fromRGB(80, 140, 255)
    stroke.Thickness = 2

    -- Icône
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 12, 0, 12)
    icon.BackgroundColor3 = Color3.fromRGB(20, 80, 200)
    icon.Text = "📨"
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBold
    icon.ZIndex = 11
    icon.Parent = panel
    Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 8)

    -- Titre
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -70, 0, 20)
    title.Position = UDim2.new(0, 60, 0, 12)
    title.BackgroundTransparency = 1
    title.Text = "Invitation de " .. (data.adminName or "Admin")
    title.TextColor3 = Color3.fromRGB(100, 160, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 11
    title.Parent = panel

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, -70, 0, 16)
    sub.Position = UDim2.new(0, 60, 0, 34)
    sub.BackgroundTransparency = 1
    sub.Text = data.isPrivateServerInvite and "T'invite dans le serveur privé" or "Veut t'inviter dans son serveur"
    sub.TextColor3 = Color3.fromRGB(160, 170, 220)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 11
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.ZIndex = 11
    sub.Parent = panel

    -- Timer bar
    local timerBg = Instance.new("Frame")
    timerBg.Size = UDim2.new(1, -24, 0, 4)
    timerBg.Position = UDim2.new(0, 12, 0, 58)
    timerBg.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    timerBg.BorderSizePixel = 0
    timerBg.ZIndex = 11
    timerBg.Parent = panel
    Instance.new("UICorner", timerBg).CornerRadius = UDim.new(1, 0)
    local timerBar = Instance.new("Frame")
    timerBar.Size = UDim2.new(1, 0, 1, 0)
    timerBar.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
    timerBar.BorderSizePixel = 0
    timerBar.ZIndex = 12
    timerBar.Parent = timerBg
    Instance.new("UICorner", timerBar).CornerRadius = UDim.new(1, 0)

    -- Boutons
    local acceptBtn = Instance.new("TextButton")
    acceptBtn.Size = UDim2.new(0, 130, 0, 36)
    acceptBtn.Position = UDim2.new(0, 12, 0, 72)
    acceptBtn.BackgroundColor3 = Color3.fromRGB(20, 140, 60)
    acceptBtn.Text = "✓  Accepter"
    acceptBtn.TextColor3 = Color3.fromRGB(200, 255, 220)
    acceptBtn.Font = Enum.Font.GothamBold
    acceptBtn.TextSize = 13
    acceptBtn.BorderSizePixel = 0
    acceptBtn.ZIndex = 11
    acceptBtn.Parent = panel
    Instance.new("UICorner", acceptBtn).CornerRadius = UDim.new(0, 8)

    local refuseBtn = Instance.new("TextButton")
    refuseBtn.Size = UDim2.new(0, 130, 0, 36)
    refuseBtn.Position = UDim2.new(0, 178, 0, 72)
    refuseBtn.BackgroundColor3 = Color3.fromRGB(160, 30, 30)
    refuseBtn.Text = "✕  Refuser"
    refuseBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
    refuseBtn.Font = Enum.Font.GothamBold
    refuseBtn.TextSize = 13
    refuseBtn.BorderSizePixel = 0
    refuseBtn.ZIndex = 11
    refuseBtn.Parent = panel
    Instance.new("UICorner", refuseBtn).CornerRadius = UDim.new(0, 8)

    -- Animation entrée
    TweenService:Create(panel, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -160, 0, 20)
    }):Play()

    local timerTween = TweenService:Create(timerBar,
        TweenInfo.new(30, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
    timerTween:Play()

    local responded = false
    local function dismiss(accepted)
        if responded then return end
        responded = true
        timerTween:Cancel()

        -- Envoyer réponse au serveur
        -- Envoyer inviteId, accepted, adminJobId (pour TP), accessCode (pour rejoindre)
        ResponseRemote:FireServer(data.inviteId, accepted, data.adminJobId, data.accessCode)


        TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, -160, 0, -150)
        }):Play()
        task.delay(0.3, function() screen:Destroy() end)
    end

    acceptBtn.MouseButton1Click:Connect(function()
        TweenService:Create(acceptBtn, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(10, 200, 80)
        }):Play()
        task.wait(0.1)
        dismiss(true)
    end)

    refuseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(refuseBtn, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        }):Play()
        task.wait(0.1)
        dismiss(false)
    end)

    task.delay(30, function()
        if not responded then dismiss(false) end
    end)
end

-- Écouter les invitations du serveur
InviteRemote.OnClientEvent:Connect(function(data)
    if typeof(data) == "table" and data.inviteId then
        createInviteGui(data)
    end
end)
