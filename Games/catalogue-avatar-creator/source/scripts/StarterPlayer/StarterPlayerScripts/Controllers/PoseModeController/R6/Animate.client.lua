-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Parent = script.Parent;
local Torso = Parent:WaitForChild("Torso");
local u1 = Torso:WaitForChild("Right Shoulder");
local u2 = Torso:WaitForChild("Left Shoulder");
local u3 = Torso:WaitForChild("Right Hip");
local u4 = Torso:WaitForChild("Left Hip");
Torso:WaitForChild("Neck");
local Humanoid = Parent:WaitForChild("Humanoid");
local u5 = "Standing";

local function getRigScale() -- Line: 15
    -- upvalues: Parent (copy)
    return Parent:GetScale();
end;

local u6 = "";
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = 1;
local u11 = {};
local u12 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=180426354",
            weight = 10
        } },
    run = { {
            id = "run.xml",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=125750702",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=180436148",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=180436334",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=178130996",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=182393478",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=129967390",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=129967478",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=128777973",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=128853357",
            weight = 10
        } },
    dance1 = { {
            id = "http://www.roblox.com/asset/?id=182435998",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491037",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491065",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=182436842",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491248",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491277",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=182436935",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491368",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491423",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=129423131",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=129423030",
            weight = 10
        } }
};
local u13 = { "dance1", "dance2", "dance3" };
local u14 = {
    wave = false,
    point = false,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};

function configureAnimationSet(u15, u16)
    -- upvalues: u11 (copy)
    if u11[u15] ~= nil then
        for _, v in pairs(u11[u15].connections) do
            v:disconnect();
        end;
    end;

    u11[u15] = {};
    u11[u15].count = 0;
    u11[u15].totalWeight = 0;
    u11[u15].connections = {};
    local v17 = script:FindFirstChild(u15);

    if v17 ~= nil then
        table.insert(u11[u15].connections, v17.ChildAdded:connect(function(p18) -- Line: 106
            -- upvalues: u15 (copy), u16 (copy)
            configureAnimationSet(u15, u16);
        end));
        table.insert(u11[u15].connections, v17.ChildRemoved:connect(function(p19) -- Line: 107
            -- upvalues: u15 (copy), u16 (copy)
            configureAnimationSet(u15, u16);
        end));
        local v20 = 1;

        for _, child in pairs(v17:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u11[u15].connections, child.Changed:connect(function(p21) -- Line: 111
                    -- upvalues: u15 (copy), u16 (copy)
                    configureAnimationSet(u15, u16);
                end));
                u11[u15][v20] = {};
                u11[u15][v20].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u11[u15][v20].weight = 1;
                else
                    u11[u15][v20].weight = Weight.Value;
                end;

                u11[u15].count = u11[u15].count + 1;
                u11[u15].totalWeight = u11[u15].totalWeight + u11[u15][v20].weight;
                v20 = v20 + 1;
            end;
        end;
    end;

    if u11[u15].count <= 0 then
        for i, v in pairs(u16) do
            u11[u15][i] = {};
            u11[u15][i].anim = Instance.new("Animation");
            u11[u15][i].anim.Name = u15;
            u11[u15][i].anim.AnimationId = v.id;
            u11[u15][i].weight = v.weight;
            u11[u15].count = u11[u15].count + 1;
            u11[u15].totalWeight = u11[u15].totalWeight + v.weight;
        end;
    end;
end;

function scriptChildModified(p22)
    -- upvalues: u12 (copy)
    local v23 = u12[p22.Name];

    if v23 ~= nil then
        configureAnimationSet(p22.Name, v23);
    end;
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v24;

if Humanoid then
    v24 = Humanoid:FindFirstChildOfClass("Animator");
else
    v24 = nil;
end;

if v24 then
    local v25 = v24:GetPlayingAnimationTracks();

    for _, v in ipairs(v25) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u12) do
    configureAnimationSet(i, v);
end;

local u26 = "None";
local u27 = 0;
local u28 = 0;

function stopAllAnimations()
    -- upvalues: u6 (ref), u14 (copy), u7 (ref), u9 (ref), u8 (ref)
    local v29 = u6;
    local v30 = u14[v29] ~= nil and u14[v29] == false and "idle" or v29;
    u6 = "";
    u7 = nil;

    if u9 ~= nil then
        u9:disconnect();
    end;

    if u8 ~= nil then
        u8:Stop();
        u8:Destroy();
        u8 = nil;
    end;

    return v30;
end;

function setAnimationSpeed(p31)
    -- upvalues: u10 (ref), u8 (ref)
    if p31 ~= u10 then
        u10 = p31;
        u8:AdjustSpeed(u10);
    end;
end;

function keyFrameReachedFunc(p32)
    -- upvalues: u6 (ref), u14 (copy), u10 (ref), Humanoid (copy)
    if p32 == "End" then
        local v33 = u6;
        playAnimation(u14[v33] ~= nil and u14[v33] == false and "idle" or v33, 0, Humanoid);
        setAnimationSpeed(u10);
    end;
end;

function playAnimation(p34, p35, p36)
    -- upvalues: u11 (copy), u7 (ref), u8 (ref), u10 (ref), u6 (ref), u9 (ref)
    local v37 = math.random(1, u11[p34].totalWeight);
    local v38 = 1;

    while u11[p34][v38].weight < v37 do
        v37 = v37 - u11[p34][v38].weight;
        v38 = v38 + 1;
    end;

    local anim = u11[p34][v38].anim;

    if anim ~= u7 then
        if u8 ~= nil then
            u8:Stop(p35);
            u8:Destroy();
        end;

        u10 = 1;
        u8 = p36:LoadAnimation(anim);
        u8.Priority = Enum.AnimationPriority.Core;
        u8:Play(p35);
        u6 = p34;
        u7 = anim;

        if u9 ~= nil then
            u9:disconnect();
        end;

        u9 = u8.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;

local u39 = "";
local u40 = nil;
local u41 = nil;
local u42 = nil;

function toolKeyFrameReachedFunc(p43)
    -- upvalues: u39 (ref), Humanoid (copy)
    if p43 == "End" then
        playToolAnimation(u39, 0, Humanoid);
    end;
end;

function playToolAnimation(p44, p45, p46, p47)
    -- upvalues: u11 (copy), u41 (ref), u40 (ref), u39 (ref), u42 (ref)
    local v48 = math.random(1, u11[p44].totalWeight);
    local v49 = 1;

    while u11[p44][v49].weight < v48 do
        v48 = v48 - u11[p44][v49].weight;
        v49 = v49 + 1;
    end;

    local anim = u11[p44][v49].anim;

    if u41 ~= anim then
        if u40 ~= nil then
            u40:Stop();
            u40:Destroy();
            p45 = 0;
        end;

        u40 = p46:LoadAnimation(anim);

        if p47 then
            u40.Priority = p47;
        end;

        u40:Play(p45);
        u39 = p44;
        u41 = anim;
        u42 = u40.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u39 (ref), u42 (ref), u41 (ref), u40 (ref)
    local v50 = u39;

    if u42 ~= nil then
        u42:disconnect();
    end;

    u39 = "";
    u41 = nil;

    if u40 ~= nil then
        u40:Stop();
        u40:Destroy();
        u40 = nil;
    end;

    return v50;
end;

function onRunning(p51)
    -- upvalues: Parent (copy), Humanoid (copy), u7 (ref), u5 (ref), u14 (copy), u6 (ref)
    local v52 = p51 / Parent:GetScale();

    if v52 <= 0.01 then
        if u14[u6] == nil then
            playAnimation("idle", 0.1, Humanoid);
            u5 = "Standing";
        end;

        return;
    end;

    playAnimation("walk", 0.1, Humanoid);

    if u7 and u7.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
        setAnimationSpeed(v52 / 14.5);
    end;

    u5 = "Running";
end;

function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u28 (ref), u5 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u28 = 0.3;
    u5 = "Jumping";
end;

function onClimbing(p53)
    -- upvalues: Parent (copy), Humanoid (copy), u5 (ref)
    local v54 = p53 / Parent:GetScale();
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(v54 / 12);
    u5 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u28 (ref), Humanoid (copy), u5 (ref)
    if u28 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    end;

    u5 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;

function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;

function onSwimming(p55)
    -- upvalues: u5 (ref)
    if p55 > 0 then
        u5 = "Running";

        return;
    end;

    u5 = "Standing";
end;

function getTool()
    -- upvalues: Parent (copy)
    for _, child in ipairs(Parent:GetChildren()) do
        if child.className == "Tool" then
            return child;
        end;
    end;

    return nil;
end;

function getToolAnim(p56)
    for _, child in ipairs(p56:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

function animateTool()
    -- upvalues: u26 (ref), Humanoid (copy)
    if u26 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u26 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u26 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;

local u57 = 0;

function move(p58)
    -- upvalues: u57 (ref), u28 (ref), u5 (ref), Humanoid (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u26 (ref), u27 (ref), u41 (ref)
    local v59 = 1;
    local v60 = 1;
    local v61 = p58 - u57;
    u57 = p58;
    local v62 = false;

    if u28 > 0 then
        u28 = u28 - v61;
    end;

    if u5 == "FreeFall" and u28 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u5 == "Running" then
            playAnimation("walk", 0.1, Humanoid);
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
            v62 = true;
            v60 = 1;
            v59 = 0.1;
        end;
    end;

    if v62 then
        local v63 = v59 * math.sin(p58 * v60);
        u1:SetDesiredAngle(v63 + 0);
        u2:SetDesiredAngle(v63 - 0);
        u3:SetDesiredAngle(-v63);
        u4:SetDesiredAngle(-v63);
    end;

    local v64 = getTool();

    if v64 and v64:FindFirstChild("Handle") then
        local v65 = getToolAnim(v64);

        if v65 then
            u26 = v65.Value;
            v65.Parent = nil;
            u27 = p58 + 0.3;
        end;

        if u27 < p58 then
            u27 = 0;
            u26 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u26 = "None";
    u41 = nil;
    u27 = 0;
end;

Humanoid.Died:connect(onDied);
Humanoid.Running:connect(onRunning);
Humanoid.Jumping:connect(onJumping);
Humanoid.Climbing:connect(onClimbing);
Humanoid.GettingUp:connect(onGettingUp);
Humanoid.FreeFalling:connect(onFreeFall);
Humanoid.FallingDown:connect(onFallingDown);
Humanoid.Seated:connect(onSeated);
Humanoid.PlatformStanding:connect(onPlatformStanding);
Humanoid.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p66) -- Line: 533
    -- upvalues: u13 (copy), u5 (ref), u14 (copy), Humanoid (copy)
    local v67 = "";

    if p66 == "/e dance" then
        v67 = u13[math.random(1, #u13)];
    elseif string.sub(p66, 1, 3) == "/e " then
        v67 = string.sub(p66, 4);
    elseif string.sub(p66, 1, 7) == "/emote " then
        v67 = string.sub(p66, 8);
    end;

    if u5 == "Standing" and u14[v67] ~= nil then
        playAnimation(v67, 0.1, Humanoid);
    end;
end);

script:WaitForChild("PlayEmote").OnInvoke = function(p68) -- Line: 550
    -- upvalues: u5 (ref), u14 (copy), Humanoid (copy), u8 (ref)
    if u5 == "Standing" then
        if u14[p68] == nil then
            return false;
        end;

        playAnimation(p68, 0.1, Humanoid);

        return true, u8;
    end;
end;

playAnimation("idle", 0.1, Humanoid);
u5 = "Standing";

while Parent.Parent ~= nil do
    local _, v69 = wait(0.1);
    move(v69);
end;