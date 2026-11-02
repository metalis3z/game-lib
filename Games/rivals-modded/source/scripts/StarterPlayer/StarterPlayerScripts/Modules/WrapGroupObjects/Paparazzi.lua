-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local TweenInfo_new_ret = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret2 = TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
local NumberRange_new_ret = NumberRange.new(0.3, 0.5);
local NumberRange_new_ret2 = NumberRange.new(0.25, 0.3);
local NumberRange_new_ret3 = NumberRange.new(1, 3);
local NumberRange_new_ret4 = NumberRange.new(0, 5);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 18
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._flashes1 = {};
    v3._flashes2 = {};
    v3._flashes3 = {};
    v3._flashes4 = {};
    v3._flashes_large = {};
    v3._started = 0;
    v3._next_flash = 0;
    v3._last_index = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(u4, p5) -- Line: 39
    -- upvalues: NumberRange_new_ret (copy), NumberRange_new_ret2 (copy), NumberRange_new_ret4 (copy), NumberRange_new_ret3 (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    u4._started = u4._started + p5;

    if u4._started < u4._next_flash then
        return;
    end;

    u4._next_flash = u4._started + Random.new():NextNumber(NumberRange_new_ret.Min, NumberRange_new_ret.Max);
    local v6 = {};

    if u4._last_index ~= 1 then
        table.insert(v6, 1);
    end;

    if u4._last_index ~= 2 then
        table.insert(v6, 2);
    end;

    if u4._last_index ~= 3 then
        table.insert(v6, 3);
    end;

    if u4._last_index ~= 4 then
        table.insert(v6, 4);
    end;

    u4._last_index = v6[Random.new():NextInteger(1, #v6)];
    local u7 = Random.new():NextNumber(NumberRange_new_ret2.Min, NumberRange_new_ret2.Max);
    local v8 = Random.new():NextNumber(NumberRange_new_ret4.Min, NumberRange_new_ret4.Max);
    local v9 = Random.new():NextNumber(NumberRange_new_ret4.Min, NumberRange_new_ret4.Max);
    local u10 = Random.new():NextInteger(NumberRange_new_ret3.Min, NumberRange_new_ret3.Max);

    for _, v in pairs(u4[`_flashes{u4._last_index}`]) do
        v.OffsetStudsU = v8;
        v.OffsetStudsV = v9;
        task.spawn(function() -- Line: 58
            -- upvalues: u10 (copy), TweenService (ref), v (copy), TweenInfo_new_ret (ref), u4 (copy), u7 (copy), TweenInfo_new_ret2 (ref)
            for i = 1, u10 do
                local v11 = TweenService:Create(v, TweenInfo_new_ret, {
                    Transparency = 0.1
                });
                v11:Play();
                table.insert(u4._tweens, v11);
                task.wait(TweenInfo_new_ret.Time);
                local v12 = TweenService:Create(v, TweenInfo.new(u7, TweenInfo_new_ret2.EasingStyle, TweenInfo_new_ret2.EasingDirection), {
                    Transparency = 1
                });
                v12:Play();
                table.insert(u4._tweens, v12);
                task.wait(u7 / 1.5);
                local _ = i;
            end;
        end);
    end;

    for _, v in pairs(u4._flashes_large) do
        v.Transparency = 0.85;
        local v13 = TweenService:Create(v, TweenInfo.new(u7 + 0.5, TweenInfo_new_ret2.EasingStyle, TweenInfo_new_ret2.EasingDirection), {
            Transparency = 1
        });
        v13:Play();
        table.insert(u4._tweens, v13);
    end;
end;

function u1._Setup(p14) -- Line: 100
    for _, v in pairs(p14.ExtraObjects) do
        if v.Name == "FlashesBackground" then
            table.insert(p14._flashes_large, v);
        else
            local v15 = v;

            for i = 1, 4 do
                local v16;

                if v15.Name == `Flashes{i}` then
                    local v17 = p14[`_flashes{i}`];
                    table.insert(v17, v15);
                    v15.Transparency = 1;
                    v16 = i;
                else
                    v16 = i;
                end;
            end;
        end;
    end;

    p14._started = workspace:GetServerTimeNow();
end;

function u1._Init(p18) -- Line: 131
    p18:_Setup();
end;

return u1;