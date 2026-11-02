local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Net = require(RS.Packages.Net)

-- Remotes
local ShowMenu   = Net:RemoteEvent("CraftRefresh/ShowMenu")
local MenuChoice = Net:RemoteEvent("CraftRefresh/MenuChoice")

-- Créer le GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CraftRefreshMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LP.PlayerGui

-- Fond assombri
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = 0.5
Overlay.BorderSizePixel = 0
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = ScreenGui

-- Fenêtre principale
local Window = Instance.new("Frame")
Window.Size = UDim2.new(0, 340, 0, 220)
Window.Position = UDim2.new(0.5, -170, 0.5, -110)
Window.BackgroundColor3 = Color3.fromRGB(18, 14, 35)
Window.BorderSizePixel = 0
Window.ZIndex = 101
Window.Parent = ScreenGui
local WC = Instance.new("UICorner"); WC.CornerRadius = UDim.new(0,16); WC.Parent = Window
local WS = Instance.new("UIStroke"); WS.Color = Color3.fromRGB(0,191,255); WS.Thickness = 2; WS.Parent = Window

-- Titre
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "🔄  REFRESH CRAFT MACHINE"
Title.TextColor3 = Color3.fromRGB(0,191,255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 102
Title.Parent = Window

-- Séparateur
local Sep = Instance.new("Frame")
Sep.Size = UDim2.new(0.85,0,0,1)
Sep.Position = UDim2.new(0.075,0,0,52)
Sep.BackgroundColor3 = Color3.fromRGB(0,191,255)
Sep.BackgroundTransparency = 0.6
Sep.BorderSizePixel = 0
Sep.ZIndex = 102
Sep.Parent = Window

-- Fonction créer bouton
local function makeBtn(text, color, posY, action)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 42)
    btn.Position = UDim2.new(0.1, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.ZIndex = 102
    btn.Parent = Window
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,10); bc.Parent = btn
    btn.MouseButton1Click:Connect(function()
        -- Tween fermeture
        TweenService:Create(Window, TweenInfo.new(0.15), {
            Position = UDim2.new(0.5,-170, 0.6,-110),
            BackgroundTransparency = 1
        }):Play()
        Overlay.Visible = false
        Window.Visible = false
        if action then
            MenuChoice:FireServer(action)
        end
    end)
    return btn
end

makeBtn("🌍  Global — Clear + Refresh",  Color3.fromRGB(220,60,60),   62, "global_clear")
makeBtn("🌍  Global — Refresh seulement", Color3.fromRGB(0,140,200),  114, "global_refresh")
makeBtn("🖥️  Local seulement — Clear + Refresh", Color3.fromRGB(80,180,80), 166, "local_clear")

-- Annuler
local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0,90,0,26)
CancelBtn.Position = UDim2.new(0.5,-45,0,186)
CancelBtn.BackgroundTransparency = 1
CancelBtn.Text = "✖ Annuler"
CancelBtn.TextColor3 = Color3.fromRGB(180,180,180)
CancelBtn.TextScaled = true
CancelBtn.Font = Enum.Font.Gotham
CancelBtn.ZIndex = 102
CancelBtn.Parent = Window
CancelBtn.MouseButton1Click:Connect(function()
    Overlay.Visible = false
    Window.Visible = false
end)

Window.Visible = false

-- Afficher le menu quand le serveur le demande
ShowMenu.OnClientEvent:Connect(function()
    -- Animation ouverture
    Window.Position = UDim2.new(0.5,-170, 0.4,-110)
    Window.BackgroundTransparency = 1
    Overlay.Visible = true
    Window.Visible = true
    TweenService:Create(Window, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5,-170, 0.5,-110),
        BackgroundTransparency = 0
    }):Play()
end)
