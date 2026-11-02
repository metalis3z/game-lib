--!strict
-- LOCATION: ReplicatedStorage/Modules/KickConfigurations

local KickConfigurations = {}

-- [ CORE KICK FORCES ]
KickConfigurations.BaseForwardForce = 80      -- The base forward push applied to every kick
KickConfigurations.BaseUpwardForce = 60       -- The base upward pop applied to every kick

-- [ INFINITE POWER SCALING (Method 2) ]
KickConfigurations.PowerScalingExponent = 0.6 -- <--- TWEAK THIS: The fractional exponent for diminishing returns! 
KickConfigurations.UpwardForceScaling = 0.4    -- Multiplier for how much of the bonus power applies to upward height vs forward distance

-- [ MINIGAME SETTINGS ]
KickConfigurations.PowerBarSpeed = 1.5        -- How fast the timing bar bounces up and down

-- [ VISUAL EFFECTS THRESHOLDS ]
KickConfigurations.EffectThresholds = {
	Perfect = 90, -- Top 10% of the bar
	Great = 80,   -- Top 20% of the bar
	Good = 70     -- Top 30% of the bar
}

return KickConfigurations