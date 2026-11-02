-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1._GetItem(p3, p4) -- Line: 29
    -- upvalues: FighterController (copy)
    for _, v in pairs(FighterController.Objects) do
        local Item = v:GetItem(p4);

        if Item then
            return Item;
        end;
    end;
end;

function u1._SetupWrap(p5, u6, u7) -- Line: 39
    -- upvalues: WrapController (copy)
    local u8 = nil;

    local function update_wrap() -- Line: 42
        -- upvalues: WrapController (ref), u8 (ref), u6 (copy), u7 (copy)
        WrapController:ResetWrap(u8);
        u8 = WrapController:RecordOriginalWrapProperties(u6);
        WrapController:ApplyWrap(u8, u7:GetWrap(), true);
    end;

    u6.DescendantAdded:Connect(function(p9) -- Line: 48
        -- upvalues: WrapController (ref), u8 (ref), u6 (copy), u7 (copy)
        if p9:HasTag("Wrappable") then
            WrapController:ResetWrap(u8);
            u8 = WrapController:RecordOriginalWrapProperties(u6);
            WrapController:ApplyWrap(u8, u7:GetWrap(), true);
        end;
    end);
    WrapController:ResetWrap(u8);
    u8 = WrapController:RecordOriginalWrapProperties(u6);
    WrapController:ApplyWrap(u8, u7:GetWrap(), true);
end;

function u1._ObjectAdded(p10, p11) -- Line: 57
    -- upvalues: Players (copy), FighterController (copy), RunService (copy)
    p11:WaitForChild("Hitbox");
    local Attribute = p11:GetAttribute("ObjectID");
    local Attribute2 = p11:GetAttribute("HitboxDelay");
    local Attribute3 = p11:GetAttribute("PlacedByUserID");
    local Attribute4 = p11:GetAttribute("TeamID");
    local v12 = p10:_GetItem(Attribute);

    if v12 then
        v12.ViewModel:PlayHideMineSound(p11);
        p10:_SetupWrap(p11, v12);
    end;

    local u13;

    if Attribute3 == Players.LocalPlayer.UserId then
        u13 = true;
    else
        u13 = FighterController.LocalFighter and FighterController.LocalFighter:Get("TeamID") and FighterController.LocalFighter:Get("TeamID") == Attribute4;
    end;

    local u14 = u13 and 0.5 or 1;
    local v15 = Attribute2 / 2;
    local u16 = 0;
    local u17 = {};

    local function update_transparency(p18) -- Line: 82
        -- upvalues: u17 (copy), u13 (copy), u14 (copy), u16 (ref)
        p18.LocalTransparencyModifier = u17[p18] and not u13 and 1 or u14 * u16;
    end;

    local function set(p19) -- Line: 88
        -- upvalues: u16 (ref), u17 (copy), u13 (copy), u14 (copy)
        u16 = p19;

        for i in pairs(u17) do
            i.LocalTransparencyModifier = u17[i] and not u13 and 1 or u14 * u16;
        end;
    end;

    local function add_object(p20) -- Line: 96
        -- upvalues: u17 (copy), u13 (copy), u14 (copy), u16 (ref)
        if p20:IsA("BasePart") or (p20:IsA("Decal") or (p20:IsA("Texture") or (p20:IsA("ParticleEmitter") or (p20:IsA("Trail") or p20:IsA("Beam"))))) then
            u17[p20] = p20:HasTag("DontShowToEnemies") or false;
            p20.LocalTransparencyModifier = u17[p20] and not u13 and 1 or u14 * u16;
        end;
    end;

    p11.DescendantAdded:Connect(add_object);

    for _, descendant in pairs(p11:GetDescendants()) do
        add_object(descendant);
    end;

    u16 = 0;

    for i in pairs(u17) do
        i.LocalTransparencyModifier = u17[i] and not u13 and 1 or u14 * u16;
    end;

    wait(Attribute2 / 2);
    local v21 = tick();

    while p11:IsDescendantOf(workspace) and tick() < v21 + v15 do
        local v22 = (tick() - v21) / v15;
        u16 = math.clamp(v22, 0, 1);

        for i in pairs(u17) do
            i.LocalTransparencyModifier = u17[i] and not u13 and 1 or u14 * u16;
        end;

        RunService.RenderStepped:Wait();
    end;

    u16 = 1;

    for i in pairs(u17) do
        i.LocalTransparencyModifier = u17[i] and not u13 and 1 or u14 * u16;
    end;
end;

function u1._Init(u23) -- Line: 124
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("SubspaceTripmine"):Connect(function(p24) -- Line: 125
        -- upvalues: u23 (copy)
        u23:_ObjectAdded(p24);
    end);

    for _, v in pairs(CollectionService:GetTagged("SubspaceTripmine")) do
        task.defer(u23._ObjectAdded, u23, v);
    end;
end;

return u1._new();