-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Parent = script.Parent;

local function getPositionByFrame(p1) -- Line: 8
    local v2 = p1 - 1;
    local v3 = math.floor(v2 / 2);

    return UDim2.fromScale(-(v2 % 2), -v3);
end;

local v4 = 1;
local v5 = true;

while true do
    while true do
        local v6 = v4 - 1;
        local v7 = math.floor(v6 / 2);
        Parent.Position = UDim2.fromScale(-(v6 % 2), -v7);
        task.wait(0.07);

        if not v5 then
            break;
        end;

        v4 = v4 + 1;

        if v4 > 6 then
            v4 = 5;
            v5 = false;
        end;
    end;

    v4 = v4 - 1;

    if v4 < 1 then
        v4 = 2;
        v5 = true;
    end;
end;