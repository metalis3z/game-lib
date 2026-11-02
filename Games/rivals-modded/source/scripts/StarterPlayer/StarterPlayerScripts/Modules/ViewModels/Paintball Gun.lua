-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("PaintGrenadeExplosionEffect"):WaitForChild("Attachment");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._last_splat_sound = 0;
    v3:_Init();

    return v3;
end;

function u1.GetPaintballColor(p4) -- Line: 27
    return Color3.fromHSV(math.random(), 0.75, 1);
end;

function u1.PlaySplatSound(p5, u6) -- Line: 31
    -- upvalues: Utility (copy)
    local u7 = tick() - p5._last_splat_sound < 0.001;
    p5._last_splat_sound = tick();

    local function play_sound() -- Line: 35
        -- upvalues: Utility (ref), u7 (copy), u6 (copy)
        Utility:CreateSound("rbxassetid://16835701807", 0.5 * (u7 and 0.5 or 1), 1 + 0.4 * math.random(), u6, true, 1);
    end;

    if u7 then
        task.delay(0.25 * math.random(), play_sound);

        return;
    end;

    Utility:CreateSound("rbxassetid://16835701807", 0.5 * (u7 and 0.5 or 1), 1 + 0.4 * math.random(), u6, true, 1);
end;

function u1.CustomImpactMarker(p8, p9) -- Line: 46
end;

function u1.ExplosionEffect(u10, p11, p12) -- Line: 50
    -- upvalues: BetterDebris (copy), Utility (copy), Attachment (copy)
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Transparency = 1;
    Part.CFrame = CFrame.new(p11);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 5);
    Utility:CreateSound("rbxassetid://13455969017", 0.25, 1.4 + 0.2 * math.random(), Part, true, 10);
    Utility:CreateSound("rbxassetid://102872919640755", 1.5, 0.9 + 0.2 * math.random(), Part, true, 10);
    local v13 = Attachment:Clone();

    for _, child in pairs(v13:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p12 / 18);
        end;
    end;

    v13.Parent = Part;
    Utility:PlayParticles(v13);
    local v14 = p11 + workspace.CurrentCamera.CFrame.LookVector * -3;
    local RaycastWhitelist = u10.ClientItem.ClientFighter:GetRaycastWhitelist();
    local u15 = {
        IsFromPaintGrenade = true
    };

    for i = 1, 4 do
        local v16 = i;

        for i2 = 1, 4 do
            local u17 = Utility:Raycast(v14, v14 + (CFrame.Angles(0, 6.283185307179586 * (v16 / 4 + 0.2617993877991494 * math.random()), 0) * CFrame.Angles(6.283185307179586 * (i2 / 4 + 0.2617993877991494 * math.random()), 0, 0)).LookVector * p12, p12, RaycastWhitelist, Enum.RaycastFilterType.Include);
            local _ = i2;

            for i3 = 1, 2 do
                task.delay(0.25 * math.random(), function() -- Line: 85
                    -- upvalues: u10 (copy), u17 (copy), u15 (copy)
                    if u10._destroyed then
                        return;
                    end;

                    u10.ClientItem:_ImpactMarkers({ u17 }, u15);
                end);
                local _ = i3;
            end;
        end;
    end;
end;

function u1._Init(p18) -- Line: 102
end;

return u1;