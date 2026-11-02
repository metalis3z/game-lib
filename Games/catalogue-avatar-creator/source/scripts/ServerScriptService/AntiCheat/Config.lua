--[[
    Anti-Cheat Configuration
    Centralized configuration for all anti-cheat thresholds and settings.
    Adjust these values to balance security vs false positives.
]]

return {
    -- General settings
    CheckInterval = 0.5,          -- How often to run checks (seconds)
    MaxViolations = 5,            -- Violations before kick
    ViolationDecay = 30,          -- Seconds before a violation expires
    
    -- Speed hack detection
    MaxWalkSpeed = 50,            -- Max allowed WalkSpeed (default: 16)
    SpeedViolationWeight = 2,     -- Weight per speed violation
    
    -- Jump power detection
    MaxJumpPower = 100,           -- Max allowed JumpPower (default: 50)
    MaxJumpHeight = 7.2,         -- Max allowed JumpHeight (default: 7.2)
    JumpViolationWeight = 2,
    
    -- Fly hack detection
    FlyCheckSamples = 4,          -- Consecutive samples needed to confirm fly
    MaxAirTime = 5,               -- Max seconds airborne without falling
    FlyViolationWeight = 3,
    
    -- Teleport detection
    MaxTeleportDistance = 200,    -- Max studs moved per check interval
    TeleportViolationWeight = 3,
    
    -- HipHeight detection
    MaxHipHeight = 5,             -- Max allowed HipHeight (default: 0)
    HipHeightViolationWeight = 2,
    
    -- Transparency/invisibility detection
    CheckTransparency = true,
    TransparencyViolationWeight = 2,
    
    -- Health detection
    MaxHealthMultiplier = 1.5,    -- Max health as multiplier of MaxHealth
    HealthViolationWeight = 3,
    
    -- Gravity detection
    MinGravity = 0,               -- Min workspace gravity (default: 196.2)
    MaxGravity = 300,             -- Max workspace gravity
    GravityViolationWeight = 2,
    
    -- Action settings
    KickOnViolation = true,       -- Kick player when violations exceed threshold
    KickReason = "Anti-Cheat: Unusual behavior detected",
    LogViolations = true,         -- Print violations to output
    NotifyAdmins = true,          -- Send notification to admins
}