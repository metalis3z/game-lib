-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: ReplicatedClass (copy), u1 (copy)
    local v2 = ReplicatedClass.new();
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFFlag(p4, p5) -- Line: 21
    return p4:Get(p5);
end;

function u1.SetFFlag(p6, p7, p8) -- Line: 25
    p6:SetReplicate(p7, p8);
end;

function u1.IsFreeWeaponsActive(p9) -- Line: 29
    -- upvalues: ItemLibrary (copy)
    for i in pairs(ItemLibrary.Statuses) do
        if p9:GetFFlag("FreeToUse" .. i .. "Weapons") then
            return true;
        end;
    end;
end;

function u1._Fetch(p10) -- Line: 41
    -- upvalues: ReplicatedStorage (copy)
    local v11 = ReplicatedStorage.Remotes.Misc.RequestFFlags:InvokeServer();

    for i, v in pairs(v11) do
        p10:SetFFlag(i, v);
    end;
end;

function u1._Init(u12) -- Line: 49
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.UpdateFFlag.OnClientEvent:Connect(function(...) -- Line: 50
        -- upvalues: u12 (copy)
        u12:SetFFlag(...);
    end);
    task.defer(u12._Fetch, u12);
end;

return u1._new();