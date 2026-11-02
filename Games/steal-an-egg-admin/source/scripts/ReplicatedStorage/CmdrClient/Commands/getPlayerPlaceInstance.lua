-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Name = "get-player-place-instance",
    Description = "Returns the target player's Place ID and the JobId separated by a space. Returns 0 if the player is offline or something else goes wrong.",
    Group = "DefaultDebug",
    Aliases = {}
}

v1.Args = {
    {
        Type = "playerId",
        Name = "Player",
        Description = "Get the place instance of this player"
    },
    function(v2) -- line 13
        return {
            Name = "Format",
            Description = "What data to return. PlaceIdJobId returns both separated by a space.",
            Default = "PlaceIdJobId",
            Type = v2.Cmdr.Util.MakeEnumType("PlaceInstance Format", { "PlaceIdJobId", "PlaceId", "JobId" })
        }
    end
}
return v1
