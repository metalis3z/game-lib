-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = {
    "rbxassetid://2590541",
    "rbxassetid://83032711602009",
    "rbxassetid://128727548904352",
    "rbxassetid://90166684921447",
    "rbxassetid://140239100555084",
    "rbxassetid://97272253453870",
    "rbxassetid://126082024890331",
    "rbxassetid://131249583090004",
    "rbxassetid://130283158493590",
    "rbxassetid://114556019900394",
    "rbxassetid://112466666772902",
    "rbxassetid://117101826648137",
    "rbxassetid://114538468748606",
    "rbxassetid://139873735674722",
    "rbxassetid://103775503564962",
    "rbxassetid://98373420251654",
    "rbxassetid://79425698371704",
    "rbxassetid://87166826689312",
    "rbxassetid://90076189567688",
    "rbxassetid://139561695601892",
    "rbxassetid://140445824066751",
    "rbxassetid://90343553347218",
    "rbxassetid://80578694078644",
    "rbxassetid://75411897165689",
    "rbxassetid://120909749571199",
    "rbxassetid://112084468503688",
    "rbxassetid://126283045144965",
    "rbxassetid://129853781030059",
    "rbxassetid://136743858401776",
    "rbxassetid://119486130155706",
    "rbxassetid://132663054692921",
    "rbxassetid://133945106822765",
    "rbxassetid://70983245593146",
    "rbxassetid://115582632329247",
    "rbxassetid://129297227277092",
    "rbxassetid://87912065660686",
    "rbxassetid://81705944196717",
    "rbxassetid://78878769229079"
};
local u2 = #u1 / 2;
local u3 = #u1 - 8;
local u4 = setmetatable({}, WrapGroupObject);
u4.__index = u4;

function u4.new(...) -- Line: 56
    -- upvalues: WrapGroupObject (copy), u4 (copy)
    local v5 = WrapGroupObject.new(...);
    local v6 = setmetatable(v5, u4);
    v6._fire_ring = {};
    v6._fire_ring_glow = {};
    v6._last_update = 0;
    v6._last_interval = 0.04;
    v6._current_frame = 0;
    v6:_Init();

    return v6;
end;

function u4.GetPreloadedImageIDs(p7) -- Line: 74
    -- upvalues: u1 (copy)
    return u1;
end;

function u4.Update(p8, p9) -- Line: 78
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    if ServerTimeNow < p8._last_update + p8._last_interval then
        return;
    end;

    p8._last_update = ServerTimeNow;
    local v10 = 0;
    p8._last_interval = 0.04;
    p8._current_frame = p8._current_frame - 1;

    if p8._current_frame < 1 then
        p8._current_frame = #u1;
    end;

    if p8._current_frame == #u1 or p8._current_frame == 1 then
        v10 = 1;
    elseif u3 <= p8._current_frame then
        v10 = (p8._current_frame - u3) / u3 * 10;
    elseif p8._current_frame < u2 then
        v10 = v10 + (1 - p8._current_frame / u2);
        p8._last_interval = 0.04 / (v10 + 1);
    end;

    local math_clamp_ret = math.clamp(v10, 0, 1);

    for _, v in pairs(p8._fire_ring) do
        v.Texture = u1[p8._current_frame];
        v.Transparency = math_clamp_ret;
    end;

    for _, v in pairs(p8._fire_ring_glow) do
        v.Transparency = math.max(math_clamp_ret, 0.5);
    end;
end;

function u4._Setup(p11) -- Line: 120
    for _, v in pairs(p11.ExtraObjects) do
        if v.Name == "FireRing" then
            table.insert(p11._fire_ring, v);
        elseif v.Name == "FireRingGlow" then
            table.insert(p11._fire_ring_glow, v);
        end;
    end;
end;

function u4._Init(p12) -- Line: 130
    p12:_Setup();
end;

return u4;