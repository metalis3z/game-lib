-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local u1 = {
    Info = {},
    InfoByWeapon = {}
};
(function(p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 10, Name: add_scavenger_hunt
    -- upvalues: u1 (copy), ItemLibrary (copy)
    local v11 = {
        AllowedInPrivateServers = p2,
        Name = p3,
        Color = p4,
        ObjectsName = p5,
        ObjectsNamePlural = p6,
        ObjectsImage = p7,
        Objects = p8,
        NumObjects = #p8,
        RewardOnCompletion = p9,
        Rewards = p10
    };
    u1.Info[p3] = v11;

    for _, v in pairs(p10) do
        if ItemLibrary.Items[v.Name] then
            u1.InfoByWeapon[v.Name] = v11;
        end;
    end;
end)(false, "JumpPad", Color3.fromRGB(49, 210, 255), "Jump Shard", "Jump Shards", "rbxassetid://110601089716497", { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, true, { {
        Name = "Jump Pad"
    } });

return u1;