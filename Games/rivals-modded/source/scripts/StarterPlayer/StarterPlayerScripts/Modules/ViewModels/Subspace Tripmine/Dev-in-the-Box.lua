-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Subspace Tripmine"]);
local DevintheBoxExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("DevintheBoxExplosionEffect");
local u2 = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("Dev-in-the-Box");
local u3 = setmetatable({}, u1);
u3.__index = u3;

function u3.new(...) -- Line: 15
    -- upvalues: u1 (copy), u3 (copy)
    local v4 = u1.new(...);
    local v5 = setmetatable(v4, u3);
    v5:_Init();

    return v5;
end;

function u3.ExplosionEffect(p6, p7) -- Line: 27
    -- upvalues: u2 (copy), BetterDebris (copy), WrapController (copy), Utility (copy), DevintheBoxExplosionEffect (copy)
    local v8 = p7:FuzzyEq(workspace.CurrentCamera.CFrame.Position) and CFrame.new(p7) or CFrame.new(p7, (Vector3.new(workspace.CurrentCamera.CFrame.X, p7.Y, workspace.CurrentCamera.CFrame.Z)));
    local v9 = math.random() < 0.5;
    local u10 = u2:Clone();
    u10.Dev.SenseiWarrior.Transparency = v9 and 0 or 1;
    u10.Dev.Nosniy.Transparency = v9 and 1 or 0;
    u10:PivotTo(v8 + Vector3.new(0, 0.5, 0));
    u10.Parent = workspace;
    BetterDebris:AddItem(u10, 4);
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(u10), p6.ClientItem:GetWrap(), true);
    Utility:CreateSound("rbxassetid://86639533276627", 0.875, 1 + 0.1 * math.random(), p7, true, 10);
    Utility:CreateSound("rbxassetid://121003602924254", 1.25, 1 + 0.1 * math.random(), p7, true, 10);
    local v11 = DevintheBoxExplosionEffect:Clone();
    v11.CFrame = CFrame.new(p7);
    v11.Parent = workspace;
    BetterDebris:AddItem(v11, 5);
    Utility:PlayParticles(v11);
    pcall(function() -- Line: 48
        -- upvalues: u10 (copy)
        task.delay(3, function() -- Line: 49
            -- upvalues: u10 (ref)
            u10.Primary.Anchored = false;
        end);
        u10.AnimationController:LoadAnimation(u10.Animation):Play();
        wait(0.1);
        u10.top.Lid.Delete:Destroy();
        u10.top.Lid.Velocity = (Random.new():NextUnitVector() * Vector3.new(1, 0, 1) + Vector3.new(0, 4, 0)) * (15 + 25 * math.random());
        u10.top.Lid.RotVelocity = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2).LookVector * (10 + 10 * math.random());
    end);
end;

function u3._Init(p12) -- Line: 67
end;

return u3;