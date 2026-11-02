-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 14
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._objects = {};
    v2._next_update = 0;
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 29
    -- upvalues: FighterController (copy), Utility (copy)
    if tick() < p3._next_update then
        return;
    end;

    p3._next_update = tick() + 0.25;
    local v5 = FighterController.LocalFighter and FighterController.LocalFighter.Entity and FighterController.LocalFighter.Entity.Humanoid;

    if v5 then
        v5 = v5.RootPart;
    end;

    if not v5 then
        return;
    end;

    for i, v in pairs(p3._objects) do
        if v.MathHitboxCheckEnabled and Utility:IsWithinPart(i, v5.Position, Vector3.new(2, 2, 2)) then
            task.spawn(v.TouchedCallback, v5, true);
        end;
    end;
end;

function u1._ObjectAdded(p6, u7) -- Line: 54
    -- upvalues: Players (copy), FighterController (copy), Utility (copy)
    local u8 = {
        TouchedCallback = nil,
        Connections = {},
        Cooldowns = {},
        MathHitboxCheckEnabled = u7:GetAttribute("MathHitboxCheckEnabled")
    };

    function u8.TouchedCallback(p9, p10) -- Line: 62
        -- upvalues: Players (ref), u8 (copy), FighterController (ref), u7 (copy), Utility (ref)
        local v11 = p9.AssemblyRootPart or p9;

        if p9.Parent ~= Players.LocalPlayer.Character or (tick() < (u8.Cooldowns[v11] or 0) or not (FighterController.LocalFighter and FighterController.LocalFighter:IsAlive())) then
            return;
        end;

        local Attribute = u7:GetAttribute("Velocity");
        local Attribute2 = u7:GetAttribute("LocalTo");
        local Attribute3 = u7:GetAttribute("MinimumYVelocity");

        if Attribute2 then
            Attribute = u7.CFrame[Attribute2] * Attribute;
        end;

        if Attribute3 then
            local X = Attribute.X;

            if math.abs(Attribute.Y) >= 0.001 then
                local math_abs_ret = math.abs(Attribute.Y);
                Attribute3 = math.max(Attribute3, math_abs_ret) * math.sign(Attribute.Y);
            end;

            Attribute = Vector3.new(X, Attribute3, Attribute.Z);
        end;

        local Attribute4 = u7:GetAttribute("HasToBeInFront");
        local v12;

        if typeof(Attribute4) == "CFrame" then
            v12 = Attribute4;
        else
            v12 = CFrame.identity;
        end;

        if not (p10 or (not Attribute4 or Utility:AngleBetweenVectors((v11.Position - (u7.CFrame * v12).Position).Unit, Attribute.Unit) <= 1.5707963267948966)) then
            return;
        end;

        u8.Cooldowns[v11] = tick() + (u7:GetAttribute("Cooldown") or 0.5);
        local Velocity = FighterController.LocalFighter.Entity.RootPart.Velocity;
        local WalkSpeed = FighterController.LocalFighter.Entity.Humanoid.WalkSpeed;
        local v13 = Utility:AngleBetweenVectors(Attribute, Vector3.new(0, 1, 0)) < 0.08726646259971647 and true or Utility:AngleBetweenVectors(Attribute, Vector3.new(-0, -1, -0)) < 0.08726646259971647;
        local v14 = u7:GetAttribute("SpringSpeed") or 12;
        local v15;

        if v13 then
            v15 = Velocity.Unit * math.max((Velocity * (Vector3.new(1, 0, 1)).Unit).Magnitude, WalkSpeed);
        else
            v15 = nil;
        end;

        if not (v15 and (v15 == v15 and (v15.Magnitude > 0.001 and v15))) then
            v15 = nil;
        end;

        if u7:GetAttribute("Override") then
            FighterController.LocalFighter.Entity:AirborneCancel();
        end;

        FighterController.LocalFighter.Entity:AirborneTrigger(Attribute, v14, nil, v15);
        local Attribute5 = u7:GetAttribute("SoundID");
        local v16 = u7:GetAttribute("SoundVolume") or 1;

        if Attribute5 then
            Utility:CreateSound(Attribute5, 1 * v16, 1, script, true, 10);

            return;
        end;

        Utility:CreateSound("rbxassetid://17835965717", 1 * v16, 1.25, script, true, 5);
    end;

    local function from_touched(p17) -- Line: 120
        -- upvalues: u8 (copy)
        u8.TouchedCallback(p17);
    end;

    table.insert(u8.Connections, u7.Touched:Connect(from_touched));
    table.insert(u8.Connections, u7.TouchEnded:Connect(from_touched));
    p6._objects[u7] = u8;
end;

function u1._ObjectRemoved(p18, p19) -- Line: 130
    local v20 = p18._objects[p19];

    if not v20 then
        return;
    end;

    for _, v in pairs(v20.Connections) do
        v:Disconnect();
    end;

    p18._objects[p19] = nil;
end;

function u1._Init(u21) -- Line: 144
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("CustomKnockbackPart"):Connect(function(p22) -- Line: 145
        -- upvalues: u21 (copy)
        u21:_ObjectAdded(p22);
    end);
    CollectionService:GetInstanceRemovedSignal("CustomKnockbackPart"):Connect(function(p23) -- Line: 149
        -- upvalues: u21 (copy)
        u21:_ObjectRemoved(p23);
    end);

    for _, v in pairs(CollectionService:GetTagged("CustomKnockbackPart")) do
        task.defer(u21._ObjectAdded, u21, v);
    end;
end;

return u1._new();