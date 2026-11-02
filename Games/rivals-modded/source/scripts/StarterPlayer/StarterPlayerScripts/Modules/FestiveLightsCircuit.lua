-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2, ...) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._interval = p2;
    v3._references = { ... };
    v3._connections = {};
    v3._colors = {};
    v3._formatted = {};
    v3._next_update = 0;
    v3._offset = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 24
    if tick() < p4._next_update then
        return;
    end;

    p4._next_update = tick() + p4._interval;
    p4._offset = p4._offset + 1;

    for i, v in pairs(p4._formatted) do
        v.Reference.Transparency = 1;
        v.Visual.Transparency = 0;
        v.Visual.Color = p4._colors[(i + p4._offset) % #p4._colors + 1];
    end;
end;

function u1.Destroy(p6) -- Line: 39
    for _, v in pairs(p6._connections) do
        v:Disconnect();
    end;

    p6._connections = {};
    p6._references = {};
    p6._formatted = {};
end;

function u1._UpdateColors(p7) -- Line: 53
    p7._colors = {};
    p7._next_update = 0;

    for _, v in pairs(p7._references) do
        table.insert(p7._colors, v.Color);
    end;

    p7:Update(0);
end;

function u1._Setup(u8) -- Line: 64
    for _, v in pairs(u8._references) do
        local _connections = u8._connections;
        local PropertyChangedSignal = v:GetPropertyChangedSignal("Color");
        table.insert(_connections, PropertyChangedSignal:Connect(function() -- Line: 66
            -- upvalues: u8 (copy)
            u8:_UpdateColors();
        end));
        local _formatted = u8._formatted;
        local v9 = {
            Reference = v,
            Visual = v:WaitForChild("Visual")
        };
        table.insert(_formatted, v9);
    end;
end;

function u1._Init(p10) -- Line: 74
    p10:_Setup();
    p10:_UpdateColors();
end;

return u1;