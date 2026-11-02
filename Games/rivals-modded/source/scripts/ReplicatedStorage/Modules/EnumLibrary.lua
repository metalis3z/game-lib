-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Signal = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Signal"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.AlwaysReplicateToEveryone = {};
    v2._num_enums = 0;
    v2._to_enum = {};
    v2._from_enum = {};
    v2._enum_builder_complete = false;
    v2._enum_builder_completed_internal = Signal.new();
    v2:_Init();

    return v2;
end;

function u1.EncryptTable(p3, p4) -- Line: 31
    -- upvalues: HttpService (copy)
    local string_reverse_ret = string.reverse(HttpService:JSONEncode(p4));
    local v5 = "";

    for i = 1, #string_reverse_ret do
        local string_sub_ret = string.sub(string_reverse_ret, i, i);
        local v6 = string.byte(string_sub_ret) - -1;
        v5 = v5 .. string.char(v6);
        local _ = i;
    end;

    return v5;
end;

function u1.DecryptTable(p7, u8) -- Line: 45
    -- upvalues: HttpService (copy)
    return pcall(function() -- Line: 46
        -- upvalues: u8 (copy), HttpService (ref)
        local v9 = "";

        for i = #u8, 1, -1 do
            local string_sub_ret = string.sub(u8, i, i);
            local v10 = string.byte(string_sub_ret) + -1;
            v9 = v9 .. string.char(v10);
            local _ = i;
        end;

        return HttpService:JSONDecode(v9);
    end);
end;

function u1.ToEnum(p11, p12, p13) -- Line: 60
    if p12 then
        local v14 = p11._to_enum[p12];
        assert(p13 or v14 ~= nil, p12);

        return v14;
    end;
end;

function u1.FromEnum(p15, p16, p17) -- Line: 70
    if p16 then
        local v18 = p15._from_enum[p16];
        assert(p17 or v18 ~= nil, p16);

        return v18;
    end;
end;

function u1.AddEnum(p19, p20) -- Line: 80
    if p19:ToEnum(p20, true) then
        return;
    end;

    local utf8_char_ret = utf8.char(p19._num_enums);
    p19._num_enums = p19._num_enums + 1;
    p19._to_enum[p20] = utf8_char_ret;
    p19._from_enum[utf8_char_ret] = p20;
end;

function u1.WaitForEnumBuilder(p21) -- Line: 92
    if not p21._enum_builder_complete then
        p21._enum_builder_completed_internal:Wait();
    end;
end;

function u1.EnumBuilderCompleted(p22) -- Line: 98
    p22._enum_builder_complete = true;
    p22._enum_builder_completed_internal:Fire();
end;

function u1._Init(p23) -- Line: 107
end;

return u1._new();