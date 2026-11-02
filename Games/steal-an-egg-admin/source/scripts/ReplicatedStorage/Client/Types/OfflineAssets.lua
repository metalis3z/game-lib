-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)

return {
    OfflineRedeemResult = t.interface({
        AwardedAmount = t.number,
        BaseAmount = t.number,
        ClaimedByUid = t.map(t.string, t.number)
    }),
    OfflineClaimSummary = t.interface({
        ClaimableAmount = t.number,
        IsMultiplierPurchasePending = t.boolean,
        ReservedAmount = t.number,
        TotalAmount = t.number
    })
}
