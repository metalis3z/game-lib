-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) -- Line: 8
    -- upvalues: u1 (copy)
    local v13 = typeof(p2) == "string";
    local v14 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v13, v14);
    local v15 = typeof(p3) == "string";
    local v16 = "Argument 2 invalid, expected a string, got " .. tostring(p3);
    assert(v15, v16);
    local v17 = typeof(p4) == "table";
    local v18 = "Argument 3 invalid, expected a table, got " .. tostring(p4);
    assert(v17, v18);
    local v19 = not p5 or typeof(p5) == "table";
    local v20 = "Argument 4 invalid, expected a table or nil, got " .. tostring(p5);
    assert(v19, v20);
    local v21 = not p6 or typeof(p6) == "number";
    local v22 = "Argument 5 invalid, expected a number or nil, got " .. tostring(p6);
    assert(v21, v22);
    local v23 = not p7 or typeof(p7) == "number";
    local v24 = "Argument 6 invalid, expected a number or nil, got " .. tostring(p7);
    assert(v23, v24);
    local v25 = not p8 or typeof(p8) == "boolean";
    local v26 = "Argument 7 invalid, expected a boolean or nil, got " .. tostring(p8);
    assert(v25, v26);
    local v27 = not p9 or typeof(p9) == "number";
    local v28 = "Argument 8 invalid, expected a number or nil, got " .. tostring(p9);
    assert(v27, v28);
    local v29 = not p10 or typeof(p10) == "number";
    local v30 = "Argument 9 invalid, expected a number or nil, got " .. tostring(p10);
    assert(v29, v30);
    local v31 = not p11 or typeof(p11) == "number";
    local v32 = "Argument 10 invalid, expected a number or nil, got " .. tostring(p11);
    assert(v31, v32);
    local v33 = not p12 or typeof(p12) == "table";
    local v34 = "Argument 11 invalid, expected a table or nil, got " .. tostring(p12);
    assert(v33, v34);
    local v35 = setmetatable({}, u1);
    v35.EntryType = p2;
    v35.EntryName = p3;
    v35.Rewards = p4;
    v35.Prices = p5 or {};
    v35.MainCurrency = nil;
    v35.ProductID = p6 or nil;
    v35.ProductIDTriple = p7 or nil;
    v35.IsLimited = p8 or nil;
    v35.PurchaseAppearTime = p9 or -1;
    v35.PurchaseStartTime = p10 or -1;
    v35.PurchaseDuration = p11 or (1 / 0);
    v35._temp_properties = p12;
    v35:_Init();

    return v35;
end;

function u1._Setup(p36) -- Line: 52
    -- upvalues: CurrencyLibrary (copy)
    for i in pairs(p36.Prices) do
        local v37 = CurrencyLibrary.Info[i] ~= nil;
        local v38 = "Argument 4 invalid, expected a valid currency name, got " .. tostring(i);
        assert(v37, v38);

        if not p36.MainCurrency or CurrencyLibrary.Info[i].OrderIndex < CurrencyLibrary.Info[p36.MainCurrency].OrderIndex then
            p36.MainCurrency = i;
        end;
    end;

    assert(p36.MainCurrency or (p36.ProductID or p36.ProductIDTriple), "Argument 4 invalid, currency missing");

    for i, v in pairs(p36._temp_properties or {}) do
        p36[i] = v;
    end;

    p36._temp_properties = nil;
end;

function u1._Init(p39) -- Line: 70
    p39:_Setup();
end;

return u1;