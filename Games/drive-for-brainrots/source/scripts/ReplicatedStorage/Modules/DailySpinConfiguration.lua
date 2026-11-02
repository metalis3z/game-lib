-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBXBhaXJzB1Jld2FyZHMGQ2hhbmNlDkdldFRvdGFsV2VpZ2h0BFR5cGUGQW1vdW50BUltYWdlBENhc2gccmJ4YXNzZXRpZDovLzExOTQ5NjY5MjU0ODU4NwVTcGlucxxyYnhhc3NldGlkOi8vMTM4Mjk3OTk2NjQyNDE3BE5hbWUESXRlbRlUb3JydHVnaW5uaSBEcmFnb25mcnV0aW5pDFRpY3RhYyBTYWh1cgACBwABAAAADowAAACkAQEAAAAAQPsCAABNAgIVAgAAAJ8BAgQXAQMATQYFjAMAAABDAAAGbgH8/wIAAACCAAIABAMBBAAAAEADAgMDABkEARgAAQAAAAAAAAEAAP8AAxoAAAAABAAAAQIAWqMAAAD/AAIAAAAAAP8BAAAGAAAA4gIEAG8DBQAwAwIRAAAAAIwD6AMwAwIrAQAAAIwDMgAwAwKMAgAAAG8DBgAwAwKpAwAAAPYCAQDiAgQAbwMHADADAhEAAAAAjAMCADADAisBAAAAjAMUADADAowCAAAAbwMIADADAqkDAAAA9gIBAeICBABvAwUAMAMCEQAAAACMA4gTMAMCKwEAAACMAw8AMAMCjAIAAABvAwYAMAMCqQMAAAD2AgEC4gIEAG8DBQAwAwIRAAAAAIwDECcwAwIrAQAAAIwDCgAwAwKMAgAAAG8DBgAwAwKpAwAAAPYCAQPiAgoAbwMLADADAhEAAAAAbwMMADADAroJAAAAjAMGADADAowCAAAA9gIBBOICCgBvAwsAMAMCEQAAAABvAw0AMAMCugkAAACMAwIAMAMCjAIAAAD2AgEFMAEAFQ4AAADAAQ8AEgAAADABAAQQAAAAggACABEDBQMGAwMDBwUEAAECAwMIAwkDCgMLAwwFAwAJAgMNAw4DDwMCBgADBAEAAQABGAADAAwAAQAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAEAAAAAAAAAAAAA+gAJAAAACAEAAAAAAbWJTv6FeEnGd56q1QAs/q7FkVmKh00k/w==

-- decompilation:
local v0 = {
    Rewards = {
        [1] = {
            Type = "Cash", 
            Amount = 1000, 
            Chance = 50, 
            Image = "rbxassetid://119496692548587"
        }, 
        [2] = {
            Type = "Spins", 
            Amount = 2, 
            Chance = 20, 
            Image = "rbxassetid://138297996642417"
        }, 
        [3] = {
            Type = "Cash", 
            Amount = 5000, 
            Chance = 15, 
            Image = "rbxassetid://119496692548587"
        }, 
        [4] = {
            Type = "Cash", 
            Amount = 10000, 
            Chance = 10, 
            Image = "rbxassetid://119496692548587"
        }, 
        [5] = {
            Type = "Item", 
            Name = "Torrtuginni Dragonfrutini", 
            Chance = 6
        }, 
        [6] = {
            Type = "Item", 
            Name = "Tictac Sahur", 
            Chance = 2
        }
    }
};
v0.GetTotalWeight = function() --[[ Line: 25 ]] --[[ Name: GetTotalWeight ]]
    -- upvalues: v0 (copy)
    local v1 = 0;
    for _, v3 in pairs(v0.Rewards) do
        v1 = v1 + v3.Chance;
    end;
    return v1;
end;
return v0;
