--[[
    Anti-Cheat Checks Module
    Contains all individual check functions for detecting hacks.
    Each check function returns: (violated: boolean, reason: string)
    All checks are server-authoritative and read server-side character properties.
]]

local Config = require(script.Parent.Config)

local Checks = {}

-- ===== SPEED HACK DETECTION =====
function Checks.SpeedHack(humanoid)
    if not humanoid then return false end
    
    local walkSpeed = humanoid.WalkSpeed
    if walkSpeed > Config.MaxWalkSpeed then
        return true, string.format("Speed hack: WalkSpeed %.1f (max %d)", walkSpeed, Config.MaxWalkSpeed)
    end
    
    return false
end

-- ===== JUMP POWER DETECTION =====
function Checks.JumpHack(humanoid)
    if not humanoid then return false end
    
    local jumpPower = humanoid.JumpPower
    local jumpHeight = humanoid.JumpHeight
    local useJumpPower = humanoid.UseJumpPower
    
    if useJumpPower and jumpPower > Config.MaxJumpPower then
        return true, string.format("Jump hack: JumpPower %.1f (max %d)", jumpPower, Config.MaxJumpPower)
    end
    
    if not useJumpPower and jumpHeight > Config.MaxJumpHeight then
        return true, string.format("Jump hack: JumpHeight %.1f (max %.1f)", jumpHeight, Config.MaxJumpHeight)
    end
    
    return false
end

-- ===== FLY HACK DETECTION =====
-- Uses a stateful approach: tracks consecutive airborne samples
local flyStates = {}

function Checks.FlyHack(character, humanoid)
    if not character or not humanoid then return false end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local playerId = character:GetAttribute("AC_PlayerId")
    if not playerId then return false end
    
    local state = flyStates[playerId] or { airSamples = 0, lastY = nil }
    
    -- Check if character is on the ground
    local isAirborne = humanoid:GetState() == Enum.HumanoidStateType.Freefall
        or humanoid:GetState() == Enum.HumanoidStateType.Jumping
    
    local yVelocity = hrp.AssemblyLinearVelocity.Y
    
    if isAirborne then
        -- If moving upward or maintaining altitude while airborne for too long
        if yVelocity > 5 or (state.lastY and math.abs(hrp.Position.Y - state.lastY) < 0.5 and yVelocity > -1) then
            state.airSamples = state.airSamples + 1
        else
            state.airSamples = math.max(0, state.airSamples - 1)
        end
    else
        state.airSamples = 0
    end
    
    state.lastY = hrp.Position.Y
    flyStates[playerId] = state
    
    if state.airSamples >= Config.FlyCheckSamples then
        state.airSamples = 0
        return true, string.format("Fly hack: Airborne with upward velocity for %d samples", Config.FlyCheckSamples)
    end
    
    return false
end

-- ===== TELEPORT DETECTION =====
local lastPositions = {}

function Checks.TeleportHack(character)
    if not character then return false end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local playerId = character:GetAttribute("AC_PlayerId")
    if not playerId then return false end
    
    local currentPos = hrp.Position
    local lastPos = lastPositions[playerId]
    
    if lastPos then
        local distance = (currentPos - lastPos).Magnitude
        if distance > Config.MaxTeleportDistance then
            lastPositions[playerId] = currentPos
            return true, string.format("Teleport hack: Moved %.1f studs in one tick (max %d)", distance, Config.MaxTeleportDistance)
        end
    end
    
    lastPositions[playerId] = currentPos
    return false
end

-- ===== HIP HEIGHT DETECTION =====
function Checks.HipHeightHack(humanoid)
    if not humanoid then return false end
    
    local hipHeight = humanoid.HipHeight
    if hipHeight > Config.MaxHipHeight then
        return true, string.format("HipHeight hack: HipHeight %.1f (max %d)", hipHeight, Config.MaxHipHeight)
    end
    
    return false
end

-- ===== TRANSPARENCY / INVISIBILITY DETECTION =====
function Checks.InvisibilityHack(character)
    if not character or not Config.CheckTransparency then return false end
    
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            if part.Transparency > 0.5 then
                return true, string.format("Invisibility hack: Part '%s' has transparency %.2f", part.Name, part.Transparency)
            end
        end
    end
    
    return false
end

-- ===== HEALTH DETECTION =====
function Checks.HealthHack(humanoid)
    if not humanoid then return false end
    
    local health = humanoid.Health
    local maxHealth = humanoid.MaxHealth
    
    if maxHealth > 0 and health > maxHealth * Config.MaxHealthMultiplier then
        return true, string.format("Health hack: Health %.1f exceeds MaxHealth %.1f", health, maxHealth)
    end
    
    -- Also check for absurdly high max health
    if maxHealth > 10000 then
        return true, string.format("Health hack: MaxHealth %.1f is abnormally high", maxHealth)
    end
    
    return false
end

-- ===== CLEANUP =====
function Checks.CleanupPlayer(playerId)
    flyStates[playerId] = nil
    lastPositions[playerId] = nil
end

return Checks