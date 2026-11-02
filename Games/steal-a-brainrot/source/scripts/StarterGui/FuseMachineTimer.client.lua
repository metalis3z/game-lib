local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer

-- Attendre que workspace et le BillboardGui soient chargés
local function getTimerLabel()
    local fm = workspace:FindFirstChild("FuseMachine")
    if not fm then return nil end
    local overhead = fm:FindFirstChild("Overhead")
    if not overhead then return nil end
    local bb = overhead:FindFirstChild("FuseTimerGui")
    if not bb then return nil end
    local bg = bb:FindFirstChild("BG")
    if not bg then return nil end
    return bg:FindFirstChild("TimerLabel")
end

-- Cible: 16 mai 2026 à 21h00 UTC
local TARGET_TIME = os.time({year=2026, month=5, day=16, hour=21, min=0, sec=0})

local function formatTime(secs)
    if secs <= 0 then return "🔥 EN COURS !" end
    local h = math.floor(secs / 3600)
    local m = math.floor((secs % 3600) / 60)
    local s = math.floor(secs % 60)
    return string.format("%02dh %02dm %02ds", h, m, s)
end

-- Attendre que le label soit disponible
local label = nil
local attempts = 0
while not label and attempts < 30 do
    label = getTimerLabel()
    if not label then
        task.wait(0.5)
        attempts += 1
    end
end

if not label then
    warn("[FuseMachineTimer] TimerLabel introuvable")
    return
end

print("[FuseMachineTimer] ✅ Timer actif - cible 16/05/2026 21h00")

-- Arc-en-ciel sur le timer
local hue = 0
local conn = RunService.Heartbeat:Connect(function(dt)
    hue = (hue + dt * 0.25) % 1
    if label and label.Parent then
        local remaining = TARGET_TIME - os.time()
        if remaining > 0 then
            label.TextColor3 = Color3.fromHSV(hue, 0.4, 1)
        else
            label.TextColor3 = Color3.fromRGB(255, 100, 0)
        end
    end
end)

-- Update toutes les secondes
while label and label.Parent do
    local remaining = math.max(0, TARGET_TIME - os.time())
    label.Text = formatTime(remaining)
    task.wait(1)
end

conn:Disconnect()
