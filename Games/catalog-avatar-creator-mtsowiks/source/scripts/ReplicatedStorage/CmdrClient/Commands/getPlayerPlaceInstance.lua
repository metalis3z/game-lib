-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "get-player-place-instance",
    Description = "Returns the target player\'s Place ID and the JobId separated by a space. Returns 0 if the player is offline or something else goes wrong.",
    Group = "Administrator",
    Aliases = {},
    Args = {
        {
            Type = "playerId",
            Name = "Player",
            Description = "Get the place instance of this player"
        },

        function(p1) -- Line: 12
            return {
                Name = "Format",
                Description = "What data to return. PlaceIdJobId returns both separated by a space.",
                Default = "PlaceIdJobId",
                Type = p1.Cmdr.Util.MakeEnumType("PlaceInstance Format", { "PlaceIdJobId", "PlaceId", "JobId" })
            };
        end
    }
};