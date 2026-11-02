-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Sniper = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels:WaitForChild("Sniper"));
local u1 = setmetatable({}, Sniper);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Sniper (copy), u1 (copy)
    local v2 = Sniper.new(...);
    local v3 = setmetatable(v2, u1);
    v3.BulletTrail = v3.ItemModel:WaitForChild("Bullet"):WaitForChild("MeshPart"):WaitForChild("TrailA0"):WaitForChild("Trail");
    v3:_Init();

    return v3;
end;

function u1.CustomTracers(u4, u5, p6) -- Line: 28
    -- upvalues: BetterDebris (copy), WrapController (copy), Utility (copy)
    local Wrap = u4:GetWrap();

    local function play() -- Line: 31
        -- upvalues: u4 (copy), u5 (copy), BetterDebris (ref), WrapController (ref), Wrap (copy), Utility (ref)
        local MuzzlePosition = u4:GetMuzzlePosition();

        if not MuzzlePosition then
            return;
        end;

        local v7 = MuzzlePosition + workspace.CurrentCamera.CFrame.RightVector * 0.1;

        for _, v in pairs(u5.RaycastResults) do
            local u8 = v.StartPosition or v7;
            local Magnitude = (u8 - v.Position).Magnitude;
            local Part = Instance.new("Part");
            Part.CastShadow = false;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.Anchored = true;
            Part.Color = Color3.fromRGB(255, 176, 112);
            Part:SetAttribute("IgnoreTransparency", true);
            Part:AddTag("Wrappable");
            Part:SetAttribute("WrapGroup", 3);
            Part.Parent = workspace;
            BetterDebris:AddItem(Part, 10);
            WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(Part), Wrap);
            Part.Material = Enum.Material.Neon;
            Part.MaterialVariant = "";
            task.spawn(function() -- Line: 61
                -- upvalues: Utility (ref), Part (copy), Magnitude (copy), v (copy), u8 (copy)
                Utility:RenderstepForLoop(0, 100, 2, function(p9) -- Line: 62
                    -- upvalues: Part (ref), Magnitude (ref), v (ref), u8 (ref)
                    local v10 = p9 / 100;
                    local v11 = (1 - v10) ^ 4;
                    Part.Size = Vector3.new(0.01 + 1 * v11, 0.01 + 1 * v11, Magnitude * (1 - v10 ^ 4) - 5);
                    Part.CFrame = CFrame.new(v.Position, u8) * CFrame.new(0, 0, -Part.Size.Z / 2);
                end);
                Part:Destroy();
            end);
        end;
    end;

    if u4.ClientItem:Get("IsAiming") then
        u4.ClientItem:GetDataChangedSignal("IsAiming"):ConnectOnce(function() -- Line: 77
            -- upvalues: play (copy)
            task.delay(0.06, task.defer, play);
        end);

        return;
    end;

    play();
end;

function u1._UpdateBulletTrail(p12) -- Line: 89
    p12.BulletTrail.Enabled = p12:IsAnimationPlaying("Shoot1") or p12:IsAnimationPlaying("EmptyReload");
end;

function u1._Init(u13) -- Line: 93
    u13.AnimationPlayed:Connect(function(p14) -- Line: 94
        -- upvalues: u13 (copy)
        if p14 == "Shoot1" or p14 == "EmptyReload" then
            u13:_UpdateBulletTrail();
        end;
    end);
    u13.AnimationStopped:Connect(function(p15) -- Line: 100
        -- upvalues: u13 (copy)
        if p15 == "Shoot1" or p15 == "EmptyReload" then
            u13:_UpdateBulletTrail();
        end;
    end);
    u13:_UpdateBulletTrail();
end;

return u1;