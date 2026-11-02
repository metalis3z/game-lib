
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.UserGenerated.FastFlags)
local v3 = require(v1.UserGenerated.Lang.Asserts)
local v4 = CFrame.new(0, 0, -3.35)
return table.freeze({
    ["ChargeMaxDuration"] = v2.Replicated("BanHammer.ChargeMaxDuration", v3.FinitePositive, 2.5),
    ["Cooldown"] = v2.Replicated("BanHammer.Cooldown", v3.FiniteNonNegative, 2),
    ["MinForce"] = v2.Replicated("BanHammer.MinForce", v3.FiniteNonNegative, 1000),
    ["MaxForce"] = v2.Replicated("BanHammer.MaxForce", v3.FiniteNonNegative, 2800),
    ["MinRagdollDuration"] = v2.Replicated("BanHammer.MinRagdollDuration", v3.FiniteNonNegative, 2),
    ["MaxRagdollDuration"] = v2.Replicated("BanHammer.MaxRagdollDuration", v3.FiniteNonNegative, 6),
    ["MinRadius"] = v2.Replicated("BanHammer.MinRadius", v3.FinitePositive, 10),
    ["MaxRadius"] = v2.Replicated("BanHammer.MaxRadius", v3.FinitePositive, 20),
    ["TargettingTTL"] = v2.Replicated("BanHammer.TargettingTTL", v3.Finite, 0.3),
    ["SlamOffset"] = v4
})