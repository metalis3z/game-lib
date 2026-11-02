-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local SnowballParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.SnowballParticles;
local Snowballs = Players.LocalPlayer.PlayerScripts.Assets.Misc.Snowballs;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ClientFighterCharacter = p2;
    v3._grab_snowball_hash = 0;
    v3._grab_snowball_visual = nil;
    v3._grab_snowball_animation_start = Instance.new("Animation");
    v3._grab_snowball_animation_idle = Instance.new("Animation");
    v3._grab_snowball_animation_throw = Instance.new("Animation");
    v3._grab_snowball_animation_track_start = nil;
    v3._grab_snowball_animation_track_idle = nil;
    v3:_Init();

    return v3;
end;

function u1.ThrowSnowball(p4, p5) -- Line: 38
    local v6 = p4.ClientFighterCharacter:Get("IsGrabbingSnowball");
    p4.ClientFighterCharacter:SetReplicate("IsGrabbingSnowball", nil);
    p4:_ThrowSnowball(p5, v6);
end;

function u1.Update(p7, p8, p9) -- Line: 45
end;

function u1.Destroy(p10) -- Line: 49
    p10._grab_snowball_animation_start:Destroy();
    p10._grab_snowball_animation_idle:Destroy();
    p10._grab_snowball_animation_throw:Destroy();
    p10:_ThrowSnowball(nil);
end;

function u1._GrabSnowball(u11, p12) -- Line: 60
    -- upvalues: Snowballs (copy)
    u11:_ThrowSnowball(nil);
    local RightHand = u11.ClientFighterCharacter.Model:FindFirstChild("RightHand");

    if not RightHand then
        return;
    end;

    u11._grab_snowball_hash = u11._grab_snowball_hash + 1;
    local _grab_snowball_hash = u11._grab_snowball_hash;
    local success, result = pcall(u11.ClientFighterCharacter.Humanoid.LoadAnimation, u11.ClientFighterCharacter.Humanoid, u11._grab_snowball_animation_start);

    if success then
        u11._grab_snowball_animation_track_start = result;
        u11._grab_snowball_animation_track_start:Play(0);
        u11._grab_snowball_animation_track_start:AdjustSpeed(3);
        task.delay(0.5, function() -- Line: 81
            -- upvalues: _grab_snowball_hash (copy), u11 (copy)
            if _grab_snowball_hash ~= u11._grab_snowball_hash then
                return;
            end;

            local success2, result2 = pcall(u11.ClientFighterCharacter.Humanoid.LoadAnimation, u11.ClientFighterCharacter.Humanoid, u11._grab_snowball_animation_idle);

            if success2 then
                u11._grab_snowball_animation_track_idle = result2;
                u11._grab_snowball_animation_track_idle:Play();
            end;
        end);
    end;

    if not p12 then
        return;
    end;

    u11._grab_snowball_visual = Snowballs[p12]:Clone();
    u11._grab_snowball_visual.PrimaryPart = u11._grab_snowball_visual.Primary;
    u11._grab_snowball_visual:PivotTo(RightHand.CFrame);
    u11._grab_snowball_visual.Parent = RightHand;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = RightHand;
    WeldConstraint.Part1 = u11._grab_snowball_visual.PrimaryPart;
    WeldConstraint.Parent = u11._grab_snowball_visual;
end;

function u1._ThrowSnowball(u13, u14, u15) -- Line: 110
    -- upvalues: Snowballs (copy), BetterDebris (copy), Utility (copy), SnowballParticles (copy)
    u13._grab_snowball_hash = u13._grab_snowball_hash + 1;

    if u13._grab_snowball_visual then
        u13._grab_snowball_visual:Destroy();
        u13._grab_snowball_visual = nil;
    end;

    if u13._grab_snowball_animation_track_start then
        u13._grab_snowball_animation_track_start:Stop(0);
        u13._grab_snowball_animation_track_start:Destroy();
        u13._grab_snowball_animation_track_start = nil;
    end;

    if u13._grab_snowball_animation_track_idle then
        u13._grab_snowball_animation_track_idle:Stop(0);
        u13._grab_snowball_animation_track_idle:Destroy();
        u13._grab_snowball_animation_track_idle = nil;
    end;

    if not (u14 and u15) then
        return;
    end;

    local RightHand = u13.ClientFighterCharacter.Model:FindFirstChild("RightHand");

    if not RightHand then
        return;
    end;

    task.spawn(function() -- Line: 140
        -- upvalues: RightHand (copy), u14 (copy), Snowballs (ref), u15 (copy), u13 (copy), BetterDebris (ref), Utility (ref), SnowballParticles (ref)
        local Position = RightHand.Position;
        local Magnitude = (Position - u14).Magnitude;
        local u16 = Snowballs[u15]:Clone();
        u16.PrimaryPart = u16.Primary;
        u16:PivotTo(RightHand.CFrame);
        u16.Parent = workspace;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = RightHand;
        WeldConstraint.Part1 = u16.PrimaryPart;
        WeldConstraint.Parent = u16;
        local success, result = pcall(u13.ClientFighterCharacter.Humanoid.LoadAnimation, u13.ClientFighterCharacter.Humanoid, u13._grab_snowball_animation_throw);

        if success then
            result:Play();
            result:AdjustSpeed(1.25);
            BetterDebris:AddItem(result, 2);
            wait(0.32);
        end;

        u16.PrimaryPart.Anchored = true;
        WeldConstraint.Part0 = nil;
        local CFrame_Angles_ret = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2);
        Utility:RenderstepForLoop(0, 100, 225 / Magnitude, function(p17) -- Line: 171
            -- upvalues: Position (copy), u14 (ref), u16 (copy), CFrame_Angles_ret (copy)
            local v18 = p17 / 100;
            local CFrame_new_ret = CFrame.new(Position:Lerp(u14, v18));
            local v19 = Position.Y + (u14.Y - Position.Y) * (math.sin(1.8849555921538759 * v18) / 0.9510565162951536);
            local v20 = math.sin(3.141592653589793 * v18) * 3;
            local CFrame_new = CFrame.new;
            local X = CFrame_new_ret.X;
            local Y = CFrame_new_ret.Y;
            local math_abs_ret = math.abs(CFrame_new_ret.Y - v19);
            u16:PivotTo(CFrame_new(X, Y + math.max(v20, math_abs_ret), CFrame_new_ret.Z) * CFrame_Angles_ret);
        end);

        for _, descendant in pairs(u16:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = 1;
            end;
        end;

        BetterDebris:AddItem(u16, 4);
        local v21 = SnowballParticles[u15].Attachment:Clone();
        v21.Parent = u16.PrimaryPart;
        Utility:PlayParticles(v21);

        if u15 == "WaterBalloon" then
            Utility:CreateSound("rbxassetid://122599219317279", 0.4, 0.9 + 0.2 * math.random(), u16.PrimaryPart, true, 5);

            return;
        end;

        Utility:CreateSound("rbxassetid://11800684590", 0.4, 0.9 + 0.2 * math.random(), u16.PrimaryPart, true, 5);
    end);
end;

function u1._Setup(p22) -- Line: 201
    p22._grab_snowball_animation_start.AnimationId = "rbxassetid://127148856297189";
    p22._grab_snowball_animation_idle.AnimationId = "rbxassetid://120318438418071";
    p22._grab_snowball_animation_throw.AnimationId = "rbxassetid://107298949913168";
end;

function u1._Init(u23) -- Line: 207
    u23.ClientFighterCharacter:GetDataChangedSignal("IsGrabbingSnowball"):Connect(function() -- Line: 208
        -- upvalues: u23 (copy)
        local v24 = u23.ClientFighterCharacter:Get("IsGrabbingSnowball");

        if not v24 then
            return;
        end;

        u23:_GrabSnowball(v24);
    end);
    u23:_Setup();
end;

return u1;