--[[
    Anti-Cheat Main Script
    Server-side anti-cheat system that monitors all players for hacks.
    
    Security Features:
    - 100% server-authoritative (runs in ServerScriptService)
    - Cannot be bypassed by client-side scripts
    - Violation tracking with decay system
    - Automatic kicking for repeat offenders
    - Admin notifications for violations
    - Cleanup on player disconnect
    
    Detected Hacks:
    - Speed hacks (WalkSpeed modification)
    - Jump hacks (JumpPower/JumpHeight modification)
    - Fly hacks (sustained airborne with upward velocity)
    - Teleport hacks (sudden large position changes)
    - HipHeight hacks (elevated character)
    - Invisibility hacks (transparent character parts)
    - Health hacks (health exceeding max or absurd values)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(script.Parent.Config)
local Checks = require(script.Parent.Checks)

-- Violation tracking: { [userId] = { count = number, lastTime = tick, violations = {} } }
local playerViolations = {}

-- ===== NOTIFICATION =====

local function notifyAdmins(message)
    if not Config.NotifyAdmins then return end
    
    -- Try to fire a notification remote if available
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local notify = remotes:FindFirstChild("Notify")
        if notify and notify:IsA("RemoteEvent") then
            for _, player in ipairs(Players:GetPlayers()) do
                local isAdmin = player:GetAttribute("IsAdministrator")
                if isAdmin then
                    notify:FireClient(player, "🛡️ " .. message)
                end
            end
        end
    end
    
    if Config.LogViolations then
        print("[AntiCheat] " .. message)
    end
end

-- ===== VIOLATION HANDLING =====

local function addViolation(player, reason, weight)
    local userId = player.UserId
    local now = tick()
    
    if not playerViolations[userId] then
        playerViolations[userId] = { count = 0, lastTime = now, violations = {} }
    end
    
    local record = playerViolations[userId]
    
    -- Decay old violations
    if now - record.lastTime > Config.ViolationDecay then
        record.count = 0
        record.violations = {}
    end
    
    record.count = record.count + (weight or 1)
    record.lastTime = now
    table.insert(record.violations, { reason = reason, time = now })
    
    notifyAdmins(string.format("%s flagged: %s (violations: %d/%d)", player.Name, reason, record.count, Config.MaxViolations))
    
    -- Kick if exceeded threshold
    if record.count >= Config.MaxViolations and Config.KickOnViolation then
        player:Kick(Config.KickReason .. "\n\nReason: " .. reason)
        notifyAdmins(string.format("%s kicked by anti-cheat (total violations: %d)", player.Name, record.count))
        playerViolations[userId] = nil
    end
end

-- ===== CHARACTER MONITORING =====

local function isAdmin(player)
    return player:GetAttribute("IsAdministrator") == true
end

local function monitorCharacter(player, character)
    -- Skip monitoring for admin players (they may use admin commands that modify properties)
    if isAdmin(player) then return end
    
    -- Set player ID attribute for tracking
    character:SetAttribute("AC_PlayerId", player.UserId)
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    
    -- Run checks at regular intervals
    task.spawn(function()
        while character and character.Parent and humanoid and humanoid.Parent do
            task.wait(Config.CheckInterval)
            
            if not character.Parent or not humanoid.Parent then break end
            
            -- Speed check
            local violated, reason = Checks.SpeedHack(humanoid)
            if violated then
                addViolation(player, reason, Config.SpeedViolationWeight)
            end
            
            -- Jump check
            violated, reason = Checks.JumpHack(humanoid)
            if violated then
                addViolation(player, reason, Config.JumpViolationWeight)
            end
            
            -- Fly check
            violated, reason = Checks.FlyHack(character, humanoid)
            if violated then
                addViolation(player, reason, Config.FlyViolationWeight)
            end
            
            -- Teleport check
            violated, reason = Checks.TeleportHack(character)
            if violated then
                addViolation(player, reason, Config.TeleportViolationWeight)
            end
            
            -- HipHeight check
            violated, reason = Checks.HipHeightHack(humanoid)
            if violated then
                addViolation(player, reason, Config.HipHeightViolationWeight)
            end
            
            -- Invisibility check
            violated, reason = Checks.InvisibilityHack(character)
            if violated then
                addViolation(player, reason, Config.TransparencyViolationWeight)
            end
            
            -- Health check
            violated, reason = Checks.HealthHack(humanoid)
            if violated then
                addViolation(player, reason, Config.HealthViolationWeight)
            end
        end
    end)
end

-- ===== PLAYER CONNECTIONS =====

local function onPlayerAdded(player)
    playerViolations[player.UserId] = { count = 0, lastTime = tick(), violations = {} }
    
    player.CharacterAdded:Connect(function(character)
        -- Small delay to let character fully load
        task.wait(0.5)
        monitorCharacter(player, character)
    end)
    
    -- Handle existing character (if player joined before script ran)
    if player.Character then
        task.wait(0.5)
        monitorCharacter(player, player.Character)
    end
end

local function onPlayerRemoving(player)
    playerViolations[player.UserId] = nil
    Checks.CleanupPlayer(player.UserId)
end

-- Connect events
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Handle players already in game
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- ===== SERVER-SIDE PROPERTY PROTECTION =====
-- Prevent server scripts from accidentally setting dangerous values
-- This also catches any server-side exploit that tries to modify character properties

local function protectCharacter(player, character)
    -- Skip protection for admin players
    if isAdmin(player) then return end
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    
    -- Reset WalkSpeed if it gets changed to an abnormal value
    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed > Config.MaxWalkSpeed then
            humanoid.WalkSpeed = 16
        end
    end)
    
    -- Reset JumpPower if abnormal
    humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        if humanoid.JumpPower > Config.MaxJumpPower then
            humanoid.JumpPower = 50
        end
    end)
    
    -- Reset HipHeight if abnormal
    humanoid:GetPropertyChangedSignal("HipHeight"):Connect(function()
        if humanoid.HipHeight > Config.MaxHipHeight then
            humanoid.HipHeight = 0
        end
    end)
end

-- Apply protection to all characters
local function setupProtection(player)
    player.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        protectCharacter(player, character)
    end)
    
    if player.Character then
        task.wait(0.5)
        protectCharacter(player, player.Character)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    setupProtection(player)
end
Players.PlayerAdded:Connect(setupProtection)

print("[AntiCheat] Server-side anti-cheat system initialized")
print("[AntiCheat] Monitoring: Speed, Jump, Fly, Teleport, HipHeight, Invisibility, Health")
print("[AntiCheat] Max violations before kick: " .. Config.MaxViolations)
print("[AntiCheat] Check interval: " .. Config.CheckInterval .. "s")