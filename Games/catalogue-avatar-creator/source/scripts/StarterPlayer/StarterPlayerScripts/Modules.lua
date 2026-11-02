-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Parent = script.Parent;

return {
    Controllers = Parent:WaitForChild("Controllers"),
    Services = Parent:WaitForChild("Services"),
    Elements = Parent:WaitForChild("Elements"),
    Utilities = Parent:WaitForChild("Utilities"),
    Shared = {
        CatalogUtilities = ReplicatedStorage:WaitForChild("CatalogUtilities"),
        SortingSchema = ReplicatedStorage:WaitForChild("SortingSchema"),
        TimeUtilities = ReplicatedStorage:WaitForChild("TimeUtilities")
    }
};