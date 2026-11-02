-- StuckDetector - Affiche un bouton si le joueur est bloqué
local Players     = game:GetService("Players")
local RS          = game:GetService("ReplicatedStorage")
local UIS         = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer
local ResetRemote = RS:WaitForChild("PlayerReset", 10)
if not ResetRemote then return end

local STUCK_TIME = 4 -- secondes bloqué avant affichage

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StuckGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LP.PlayerGui

local StuckBtn = Instance.new("TextButton")
StuckBtn.Size = UDim2.new(0, 180, 0, 44)
StuckBtn.Position = UDim2.new(0.5, -90, 1, -120)
StuckBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StuckBtn.Text = "🔄 Débloquer / Reset"
StuckBtn.TextSize = 14
StuckBtn.Font = Enum.Font.GothamBold
StuckBtn.TextColor3 = Color3.new(1,1,1)
StuckBtn.BorderSizePixel = 0
StuckBtn.Visible = false
StuckBtn.ZIndex = 50
StuckBtn.Parent = ScreenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = StuckBtn
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255,100,100)
stroke.Thickness = 1.5
stroke.Parent = StuckBtn

local lastPos = Vector3.new(0,0,0)
local stuckTimer = 0
local wasRagdolled = false
local cooldown = false

StuckBtn.MouseButton1Click:Connect(function()
    if cooldown then return end
    cooldown = true
    ResetRemote:FireServer()
    StuckBtn.Visible = false
    stuckTimer = 0
    task.delay(3, function() cooldown = false end)
end)

-- Détecter si bloqué
local function checkStuck()
    local char = LP.Character
    if not char then stuckTimer = 0; return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then stuckTimer = 0; return end
    if hum.Health <= 0 then stuckTimer = 0; return end

    local isRagdolled = LP:GetAttribute("Ragdolled") == true or hum.PlatformStand
    
    if isRagdolled then
        local dist = (hrp.Position - lastPos).Magnitude
        if dist < 0.5 then
            stuckTimer += 0.5
        else
            stuckTimer = 0
            lastPos = hrp.Position
        end
        if stuckTimer >= STUCK_TIME then
            StuckBtn.Visible = true
        end
    else
        stuckTimer = 0
        lastPos = hrp.Position
        if not cooldown then StuckBtn.Visible = false end
    end
end

while true do
    task.wait(0.5)
    pcall(checkStuck)
end
