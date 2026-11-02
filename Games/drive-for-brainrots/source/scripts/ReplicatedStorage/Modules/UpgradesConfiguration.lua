-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRBXBhaXJzCFVwZ3JhZGVzDlJvYnV4UHJvZHVjdElkFUdldFVwZ3JhZGVCeVByb2R1Y3RJZAtEaXNwbGF5TmFtZQdJbWFnZUlkCEJhc2VDb3N0D1ByaWNlTXVsdGlwbGllcgxEZWZhdWx0VmFsdWUIQ2FwYWNpdHkbcmJ4YXNzZXRpZDovLzk0NTc2OTQ2NDYzMzEwDUNhcnJ5Q2FwYWNpdHkIU3RhdEJhc2UMU3RhdFBlckxldmVsBFRpbWUccmJ4YXNzZXRpZDovLzExNjM5ODYzOTMzOTMzMghab25lVGltZQACBwEBAAAGAwAABQECEKQBAQAAAABA+wIAAE0CAuMCAAAAnwECBBcBBQBNBgUhAwAAAJoGAgAAAAAAggQCAG4B+v8CAAAAxgEAAIIBAgAEAwEEAAAAQAMCAwMAGwQBGAAAAAAAAAABAAAAAf4ABQAcAAAAAAQAAAECADyjAAAA/wACAAAAAAD/AQIAAAAAAOICBgBvAwcAMAMCVwAAAABvAwgAMAMClgEAAACMA6hhMAMCVQIAAACMAwUAMAMC8wMAAACMAwEAMAMCtgQAAABvAwkAMAMCIQUAAAAwAgGuCgAAAOICDQBvAw4AMAMCVwAAAABvAw8AMAMClgEAAACMA8gAMAMCVQIAAABvAxAAMAMC8wMAAACMAwAAMAMCtgQAAACMAxQAMAMCPAsAAACMAwIAMAMCrQwAAABvAxEAMAMCIQUAAAAwAgEJEgAAADABAOMTAAAAwAEUABIAAAAwAQDlFQAAAIIAAgAWAwUDBgMHAwgDCQMDBQYAAQIDBAUDCgMLAgAAADcMpupBAwwDDQMOBQgAAQIDBAsMBQMPAxACZmZmZmZm9j8CAAAgMQym6kEDEQMCBgADBAEAAQABGAADAAIAAQEAAAEAAAEAAAEAAAEAAAEAAPoACAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAPgA9wAVAAAACQEAAAAAAQbZTAzADXv5MWhvP5ugZHJ2wVt4NB0mDQ==

-- decompilation:
local v0 = {
    Upgrades = {

        BasePlot = {
            DisplayName = "Base Floor",
            ImageId = "rbxassetid://94576946463310",  -- reuse capacity icon or replace
            BaseCost = 250,
            PriceMultiplier = 4,
            DefaultValue = 0,
            -- RobuxProductId can be added later if needed
        },
        CarryCapacity = {
            DisplayName = "Capacity", 
            ImageId = "rbxassetid://94576946463310", 
            BaseCost = 25000, 
            PriceMultiplier = 5, 
            DefaultValue = 1, 
            RobuxProductId = 3576717752
        }, 
        ZoneTime = {
            DisplayName = "Time", 
            ImageId = "rbxassetid://116398639339332", 
            BaseCost = 200, 
            PriceMultiplier = 1.4, 
            DefaultValue = 0, 
            StatBase = 20, 
            StatPerLevel = 2, 
            RobuxProductId = 3576717705
        }
    }
};
v0.GetUpgradeByProductId = function(v1) --[[ Line: 27 ]] --[[ Name: GetUpgradeByProductId ]]
    -- upvalues: v0 (copy)
    for v2, v3 in pairs(v0.Upgrades) do
        if v3.RobuxProductId == v1 then
            return v2;
        end;
    end;
    return nil;
end;
return v0;
