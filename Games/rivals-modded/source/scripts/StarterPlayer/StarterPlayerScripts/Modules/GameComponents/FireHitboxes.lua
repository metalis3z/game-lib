-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
require(ReplicatedStorage.Modules.Spring);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local FireHitboxes = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("FireHitboxes");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._fire_hitboxes = {};
    v2:_Init();

    return v2;
end;

function u1.Extinguish(p3, p4) -- Line: 31
    for i, v in pairs(p3._fire_hitboxes) do
        if i:GetAttribute("FireHitboxID") == p4 then
            v.Visual:Destroy();
            p3._fire_hitboxes[i] = nil;

            return v.Visual:GetPivot().Position;
        end;
    end;
end;

function u1.Update(p5, p6) -- Line: 41
    for i, v in pairs(p5._fire_hitboxes) do
        v.Visual:PivotTo(i.CFrame);
    end;
end;

function u1._Setup(u7) -- Line: 51
    -- upvalues: BetterDebris (copy), TweenService (copy), Utility (copy), CollectionService (copy), FireHitboxes (copy), FighterController (copy), WrapController (copy)
    local function fire_hitbox_removed(p8) -- Line: 54
        -- upvalues: u7 (copy), BetterDebris (ref), TweenService (ref), Utility (ref)
        local u9 = u7._fire_hitboxes[p8];

        if not u9 then
            return;
        end;

        u9.Destroyed = true;

        for _, descendant in pairs(u9.Visual:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        BetterDebris:AddItem(u9.Visual, 10);

        if u9.Visual.Name == "Hot Coals" then
            for _, child in pairs(u9.Visual.Coals:GetChildren()) do
                child.Color = Color3.fromRGB(0, 0, 0);
                task.delay(0.5 * math.random(), function() -- Line: 75
                    -- upvalues: TweenService (ref), child (copy)
                    TweenService:Create(child, TweenInfo.new(0.25 + 0.5 * math.random(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Size = Vector3.new(0, 0, 0)
                    }):Play();
                end);
            end;
        end;

        local u10 = u9.Sound1 and u9.Sound1.Volume;
        local u11 = u9.Sound2 and u9.Sound2.Volume;
        local PointLight = u9.Visual.Primary.PointLight;
        Utility:RenderstepForLoop(0, 100, 1, function(p12) -- Line: 85
            -- upvalues: u9 (copy), u10 (copy), u11 (copy), PointLight (copy)
            local v13 = 1 - (p12 / 100) ^ 2;

            if u9.Sound1 then
                u9.Sound1.Volume = u10 * v13;
            end;

            if u9.Sound2 then
                u9.Sound2.Volume = u11 * v13;
            end;

            PointLight.Brightness = 3 * v13;
        end);
        u7._fire_hitboxes[p8] = nil;
    end;

    CollectionService:GetInstanceRemovedSignal("FireHitbox"):Connect(fire_hitbox_removed);

    local function fire_hitbox_added(p14) -- Line: 104
        -- upvalues: FireHitboxes (ref), FighterController (ref), WrapController (ref), Utility (ref), u7 (copy), TweenService (ref)
        local Attribute = p14:GetAttribute("IsMain");
        local Attribute2 = p14:GetAttribute("ObjectID");
        local v15 = p14:GetAttribute("ViewModelName") or "Default";
        local v16 = (FireHitboxes:FindFirstChild(v15) or FireHitboxes.Default):Clone();
        v16.PrimaryPart = v16.Primary;
        v16.Primary.Size = p14.Size;
        v16:PivotTo(p14.CFrame);
        v16.Parent = workspace;

        if Attribute and v16.Primary:FindFirstChild("Fire") then
            v16.Primary.Fire.Acceleration = Vector3.new(0, 10, 0);
        end;

        local Wrap = FighterController:GetWrap(Attribute2);

        if Wrap then
            WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v16), Wrap, true);
        end;

        local v17, v18;

        if Attribute then
            local v19 = math.max(p14.Size.X, p14.Size.Y, p14.Size.Z) * 1.5;
            v17 = Utility:CreateSound("rbxassetid://13702989275", 0.5, 0.7 + 0.3 * math.random(), v16.Primary, true, nil, v19);

            if v15 == "Campfire Stick" then
                v18 = Utility:CreateSound("rbxassetid://115255932685592", 1.25, 1, v16.Primary, true, nil, v19);
            else
                v18 = Utility:CreateSound("rbxassetid://14812827622", 1.25, 0.875, v16.Primary, true, nil, v19);
            end;
        else
            v17 = nil;
            v18 = nil;
        end;

        local u20 = {
            Destroyed = false,
            Visual = v16,
            Sound1 = v17,
            Sound2 = v18
        };
        u7._fire_hitboxes[p14] = u20;

        if u20.Visual.Name == "Hot Coals" then
            for _, child in pairs(u20.Visual.Coals:GetChildren()) do
                local Size = child.Size;
                child.Size = Vector3.new(0, 0, 0);
                child.CFrame = child.CFrame * CFrame.Angles(6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random());
                task.delay(0.5 * math.random(), function() -- Line: 156
                    -- upvalues: u20 (copy), TweenService (ref), child (copy), Size (copy)
                    if u20.Destroyed then
                        return;
                    end;

                    TweenService:Create(child, TweenInfo.new(1 * math.random(), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = Size
                    }):Play();
                end);
            end;
        end;
    end;

    CollectionService:GetInstanceAddedSignal("FireHitbox"):Connect(fire_hitbox_added);

    for _, v in pairs(CollectionService:GetTagged("FireHitbox")) do
        task.spawn(fire_hitbox_added, v);
    end;
end;

function u1._Init(p21) -- Line: 174
    p21:_Setup();
end;

return u1._new();