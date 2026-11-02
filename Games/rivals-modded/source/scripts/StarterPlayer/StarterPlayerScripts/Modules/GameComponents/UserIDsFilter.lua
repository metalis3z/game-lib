-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 7
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._Parse(p3, p4) -- Line: 25
    local v5 = "";
    local v6 = {};

    for i = 1, #p4 do
        local string_sub_ret = string.sub(p4, i, i);
        local v7;

        if string_sub_ret == "," or i == #p4 then
            if i == #p4 then
                v5 = v5 .. string_sub_ret;
            end;

            local v8 = tonumber(v5);
            table.insert(v6, v8);
            v7 = i;
            v5 = "";
        else
            v5 = v5 .. string_sub_ret;
            v7 = i;
        end;
    end;

    return v6;
end;

function u1._ObjectAdded(p9, p10) -- Line: 47
    -- upvalues: Players (copy)
    if table.find(p9:_Parse(p10:GetAttribute("UserIDs")), Players.LocalPlayer.UserId) then
        return;
    end;

    task.defer(p10.Destroy, p10);
end;

function u1._Init(u11) -- Line: 55
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("UserIDsShow"):Connect(function(p12) -- Line: 56
        -- upvalues: u11 (copy)
        u11:_ObjectAdded(p12);
    end);

    for _, v in pairs(CollectionService:GetTagged("UserIDsShow")) do
        task.defer(u11._ObjectAdded, u11, v);
    end;
end;

return u1._new();