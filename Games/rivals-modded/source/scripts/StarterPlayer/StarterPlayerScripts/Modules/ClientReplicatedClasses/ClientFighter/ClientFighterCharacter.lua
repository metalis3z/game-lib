-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ClientHumanoidEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity);
local ChatBubbleMover = require(script:WaitForChild("ChatBubbleMover"));
local CustomNametag = require(script:WaitForChild("CustomNametag"));
local Animations = require(script:WaitForChild("Animations"));
local Flashlight = require(script:WaitForChild("Flashlight"));
local Visibility = require(script:WaitForChild("Visibility"));
local Airborne = require(script:WaitForChild("Airborne"));
local Gameplay = require(script:WaitForChild("Gameplay"));
local Snowball = require(script:WaitForChild("Snowball"));
local Visuals = require(script:WaitForChild("Visuals"));
local Avatar = require(script:WaitForChild("Avatar"));
local Boosts = require(script:WaitForChild("Boosts"));
local Sounds = require(script:WaitForChild("Sounds"));
local Joints = require(script:WaitForChild("Joints"));
local State = require(script:WaitForChild("State"));
local Arms = require(script:WaitForChild("Arms"));
local u1 = setmetatable({}, ClientHumanoidEntity);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 28
    -- upvalues: ClientHumanoidEntity (copy), u1 (copy), Signal (copy), State (copy), ChatBubbleMover (copy), CustomNametag (copy), Animations (copy), Flashlight (copy), Visibility (copy), Airborne (copy), Gameplay (copy), Snowball (copy), Visuals (copy), Avatar (copy), Boosts (copy), Sounds (copy), Joints (copy), Arms (copy)
    local v4 = ClientHumanoidEntity.new(p2);
    local v5 = setmetatable(v4, u1);
    v5.EnteredWorld = Signal.new();
    v5.BoostsChanged = Signal.new();
    v5.AirborneChanged = Signal.new();
    v5.RedirectSliding = Signal.new();
    v5.ClientFighter = p3;
    v5.Player = p2.Player;
    v5.Head = nil;
    v5.State = State.new(v5);
    v5.ChatBubbleMover = ChatBubbleMover.new(v5);
    v5.CustomNametag = CustomNametag.new(v5);
    v5.Animations = Animations.new(v5);
    v5.Flashlight = Flashlight.new(v5);
    v5.Visibility = Visibility.new(v5);
    v5.Airborne = Airborne.new(v5);
    v5.Gameplay = Gameplay.new(v5);
    v5.Snowball = Snowball.new(v5);
    v5.Visuals = Visuals.new(v5);
    v5.Avatar = Avatar.new(v5);
    v5.Boosts = Boosts.new(v5);
    v5.Sounds = Sounds.new(v5);
    v5.Joints = Joints.new(v5);
    v5.Arms = Arms.new(v5);
    v5._destroyed = false;
    v5._is_in_world = false;
    v5:_Init();

    return v5;
end;

function u1.IsRendered(p6) -- Line: 67
    -- upvalues: ClientHumanoidEntity (copy)
    local v7 = ClientHumanoidEntity.IsRendered(p6) and not p6.ClientFighter:Get("IsHiddenByEmotes");

    return v7;
end;

function u1.IsAlive(p8, ...) -- Line: 71
    return p8.State:IsAliveCached(...);
end;

function u1.IsGrounded(p9, ...) -- Line: 75
    return p9.State:IsGroundedCached(...);
end;

function u1.IsAirborne(p10, ...) -- Line: 79
    return p10.Airborne:IsActive(...);
end;

function u1.GetBoostByName(p11, ...) -- Line: 83
    return p11.Boosts:GetBoostByName(...);
end;

function u1.GetBoost(p12, ...) -- Line: 87
    return p12.Boosts:GetBoost(...);
end;

function u1.GetFOVOffset(p13, ...) -- Line: 91
    return p13.Gameplay:GetFOVOffset(...);
end;

function u1.IsInWorld(p14) -- Line: 95
    return p14._is_in_world;
end;

function u1.GetClampedVelocity(p15) -- Line: 99
    -- upvalues: CONSTANTS (copy)
    return not p15.RootPart and Vector3.new(0, 0, 0) or (p15.RootPart.Velocity.Magnitude <= 0.01 and p15.RootPart.Velocity or p15.RootPart.Velocity.Unit * math.clamp(p15.RootPart.Velocity.Magnitude, 0, CONSTANTS.BASE_WALKSPEED * 2.5));
end;

function u1.GetFloor(p16, p17) -- Line: 105
    -- upvalues: Utility (copy)
    local v18 = Utility:Raycast(p16.RootPart.Position, p16.RootPart.Position - Vector3.new(0, 1, 0), p17 or 3.5 * p16.RootPart.Size.Z, p16.ClientFighter:GetRaycastWhitelist(), Enum.RaycastFilterType.Include);

    return v18.Instance, v18;
end;

function u1.GetArmsData(p19) -- Line: 112
    -- upvalues: Utility (copy)
    return Utility:GetArmsData(p19.Model);
end;

function u1.WaitUntilIsInWorld(p20) -- Line: 116
    if not p20._is_in_world then
        p20.EnteredWorld:Wait();
    end;
end;

function u1.HardDash(p21, ...) -- Line: 122
    return p21.Gameplay:HardDash(...);
end;

function u1.WarpTo(p22, ...) -- Line: 126
    return p22.Gameplay:WarpTo(...);
end;

function u1.SetRedFigureMode(p23, ...) -- Line: 130
    return p23.Visuals:SetRedFigureMode(...);
end;

function u1.AirborneRedirect(p24, ...) -- Line: 134
    return p24.Airborne:Redirect(...);
end;

function u1.AirborneTrigger(p25, ...) -- Line: 138
    return p25.Airborne:Trigger(...);
end;

function u1.AirborneCancel(p26, ...) -- Line: 142
    return p26.Airborne:Cancel(...);
end;

function u1.SetHitboxesVisible(p27, ...) -- Line: 146
    return p27.Visibility:SetHitboxesVisible(...);
end;

function u1.CloneModel(p28, ...) -- Line: 150
    return p28.Visibility:CloneModel(...);
end;

function u1.SetTranslucent(p29, ...) -- Line: 154
    return p29.Visibility:SetTranslucent(...);
end;

function u1.SetBoost(p30, ...) -- Line: 158
    return p30.Boosts:SetBoost(...);
end;

function u1.RemoveBoost(p31, ...) -- Line: 162
    return p31.Boosts:RemoveBoost(...);
end;

function u1.SetIKControlTargetItem(p32, ...) -- Line: 166
    return p32.Arms:SetIKControlTargetItem(...);
end;

function u1.DisableIKArms(p33, ...) -- Line: 170
    return p33.Arms:DisableIKArms(...);
end;

function u1.PlaySlidingAnimationAsync(p34, ...) -- Line: 174
    return p34.Animations:PlaySlidingAnimationAsync(...);
end;

function u1.StopSlidingAnimation(p35, ...) -- Line: 178
    return p35.Animations:StopSlidingAnimation(...);
end;

function u1.AddConnection(p36, p37) -- Line: 182
    table.insert(p36._connections, p37);
end;

function u1.Update(p38, p39, p40) -- Line: 186
    p38.State:Update(p39, p40);
    p38.Sounds:Update(p39, p40);
    p38.ChatBubbleMover:Update(p39, p40);
    p38.CustomNametag:Update(p39, p40);
    p38.Animations:Update(p39, p40);
    p38.Flashlight:Update(p39, p40);
    p38.Airborne:Update(p39, p40);
    p38.Snowball:Update(p39, p40);
    p38.Visuals:Update(p39, p40);
    p38.Boosts:Update(p39, p40);
    p38.Joints:Update(p39, p40);
    p38.Arms:Update(p39, p40);
end;

function u1.ReplicateFromServer(p41, p42, ...) -- Line: 201
    -- upvalues: ClientHumanoidEntity (copy)
    if p42 ~= "HurtEffect" then
        if p42 == "HealEffect" then
            if not p41:IsRendered() then
                return;
            end;

            if p41.ClientFighter.FighterInterface then
                p41.ClientFighter.FighterInterface:HealEffect(...);

                return;
            end;
        else
            if p42 == "BlindedEffect" then
                if not p41:IsRendered() or p41.ClientFighter:Get("IsSpectating") then
                    return;
                end;

                p41.Visuals:BlindedEffect(...);

                return;
            end;

            if p42 == "KnockbackEffect" then
                p41.Airborne:FromServer(...);

                return;
            end;

            if p42 == "CancelKnockbackEffect" then
                p41.Airborne:Cancel(...);
                p41.ClientFighter.StopSliding:Fire();

                return;
            end;

            if p42 == "SetBoost" then
                p41:SetBoost(...);

                return;
            end;

            if p42 == "ThrowSnowball" then
                p41.Snowball:ThrowSnowball(...);

                return;
            end;

            if p42 == "WarpTo" then
                p41:WarpTo(...);

                return;
            end;

            ClientHumanoidEntity.ReplicateFromServer(p41, p42, ...);
        end;

        return;
    end;

    if not p41:IsRendered() then
        return;
    end;

    p41.Visuals:HurtEffect(...);
    p41:_HurtEffect(...);
end;

function u1.Destroy(p43) -- Line: 239
    -- upvalues: ClientHumanoidEntity (copy)
    p43._destroyed = true;
    p43.EnteredWorld:Destroy();
    p43.BoostsChanged:Destroy();
    p43.AirborneChanged:Destroy();
    p43.RedirectSliding:Destroy();
    p43.State:Destroy();
    p43.ChatBubbleMover:Destroy();
    p43.CustomNametag:Destroy();
    p43.Animations:Destroy();
    p43.Flashlight:Destroy();
    p43.Visibility:Destroy();
    p43.Airborne:Destroy();
    p43.Gameplay:Destroy();
    p43.Snowball:Destroy();
    p43.Visuals:Destroy();
    p43.Avatar:Destroy();
    p43.Boosts:Destroy();
    p43.Sounds:Destroy();
    p43.Joints:Destroy();
    p43.Arms:Destroy();
    ClientHumanoidEntity.Destroy(p43);
end;

function u1._SetupAsync(p44) -- Line: 270
    while not p44.Model:IsDescendantOf(workspace) do
        p44.Model.AncestryChanged:Wait();
    end;

    if p44._destroyed then
        return;
    end;

    p44.Head = p44.Model:WaitForChild("Head");

    if p44._destroyed then
        return;
    end;

    p44._is_in_world = true;
    p44.EnteredWorld:Fire();
end;

function u1._Init(u45) -- Line: 289
    u45.Boosts.BoostsChanged:Connect(function(...) -- Line: 290
        -- upvalues: u45 (copy)
        u45.BoostsChanged:Fire(...);
    end);
    u45.Airborne.AirborneChanged:Connect(function(...) -- Line: 294
        -- upvalues: u45 (copy)
        u45.AirborneChanged:Fire(...);
    end);
    u45.Gameplay.RedirectSliding:Connect(function(...) -- Line: 298
        -- upvalues: u45 (copy)
        u45.RedirectSliding:Fire(...);
    end);
    task.spawn(u45._SetupAsync, u45);
end;

return u1;