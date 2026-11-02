-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.CooldownAdded = Signal.new();
    v3.CooldownRemoved = Signal.new();
    v3.ClientItem = p2;
    v3.Cooldowns = {};
    v3:_Init();

    return v3;
end;

function u1.Get(p4, p5) -- Line: 27
    for i, v in pairs(p4.Cooldowns) do
        if v.Name == p5 then
            return v, i;
        end;
    end;
end;

function u1.Create(u6, p7, p8, u9, p10) -- Line: 35
    -- upvalues: HttpService (copy)
    if u6._destroyed then
        return;
    end;

    u6:Clear(u9);

    if not u9 then
        return;
    end;

    local u11 = {
        GetVariables = nil,
        Name = u9,
        ID = HttpService:GenerateGUID(),
        Start = tick(),
        Finish = tick() + p8,
        Duration = p8,
        IsReversed = p10,
        Image = p7,
        Cleanup = {}
    };

    function u11.GetVariables() -- Line: 58
        -- upvalues: u11 (copy)
        local v12 = u11.Finish - tick();
        local v13 = (tick() - u11.Start) / u11.Duration;

        if not u11.IsReversed then
            v13 = 1 - v13;
        end;

        return v12, v13, u11.IsReversed and 1 or 0;
    end;

    table.insert(u6.Cooldowns, u11);
    u6.CooldownAdded:Fire(u11);
    task.delay(p8, function() -- Line: 70
        -- upvalues: u6 (copy), u9 (copy), u11 (copy)
        local v14 = u6:Get(u9);

        if v14 and v14.ID == u11.ID then
            u6:Clear(u9);
        end;
    end);
end;

function u1.Clear(p15, p16) -- Line: 81
    local v17, v18 = p15:Get(p16);

    if not v17 then
        return;
    end;

    for _, v in pairs(v17.Cleanup) do
        v:Destroy();
    end;

    table.remove(p15.Cooldowns, v18);
    p15.CooldownRemoved:Fire(v17);
end;

function u1.Destroy(p19) -- Line: 96
    p19.CooldownAdded:Destroy();
    p19.CooldownRemoved:Destroy();

    for i = #p19.Cooldowns, 1, -1 do
        p19:Clear(p19.Cooldowns[i].Name);
        local _ = i;
    end;
end;

function u1._Init(p20) -- Line: 109
end;

return u1;