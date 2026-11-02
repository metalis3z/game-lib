-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    TestAttributeKey = "ExpandedLobby.Group",
    ServerTypeAttributeKey = "ExpandedLobby.ServerType",
    UnlockedValue = "None",
    ServerAttribute = "ExpandedLobbyServerGroup",
    TeleportDataKey = "ExpandedLobbyGroup",
    StudioForceAttribute = "ExpandedLobbyForceGroup",
    RemovalTag = "ExpandedLobbyABTestRemoval",
    JobAttributeWaitSeconds = 15,
    ApplyDeadlineSeconds = 120,
    Groups = table.freeze({
        Control = "Control",
        Variant = "Variant"
    }),
    PlotSpread = table.freeze({
        CenterZ = -364.1,
        ZScale = 1.35,
        WestColumnXOffset = -20,
        WestColumnMaxX = 500
    })
}

function v1.IsValidGroup(v2) -- line 19 | captures: v1
    if v2 == v1.Groups.Control then
        return true
    end
    return v2 == v1.Groups.Variant
end

return table.freeze(v1)
