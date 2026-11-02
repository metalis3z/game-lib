

local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local u1 = "Standing";
UserSettings():GetService("UserGameSettings");
local _, _ = pcall(function() -- Line: 9
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local success, result = pcall(function() -- Line: 12
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u2 = success and result;
local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
local u3 = 0;
local u4 = 0;
local u5 = {
    x = 0,
    y = 0
};
local u6 = 0;
local u7 = "";
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = 1;
local u12 = {};
local u13 = {};
local u14 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        } },
    run = { {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        } },
    swim = { {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        } },
    swimidle = { {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        } }
};
local u15 = {};
local u16 = {};
local u17 = u15;
local u18 = {};
math.randomseed(tick());

function findExistingAnimationInSet(p19, p20)
    if p19 == nil or p20 == nil then
        return 0;
    end;

    for i = 1, p19.count do
        if p19[i].anim.AnimationId == p20.AnimationId then
            return i;
        end;

        local _ = i;
    end;

    return 0;
end;

local function destroyWalkAnimations() -- Line: 131
    -- upvalues: u15 (copy), u16 (copy), u4 (ref)
    for _, v in pairs(u15) do
        if v.track then
            v.track:Stop();
            v.track:Destroy();
            v.track = nil;
        end;
    end;

    for _, v in pairs(u16) do
        if v.track then
            v.track:Stop();
            v.track:Destroy();
            v.track = nil;
        end;
    end;

    u4 = 0;
end;

local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;

local function resetVelocityBounds(p25) -- Line: 152
    -- upvalues: u22 (ref), u21 (ref), u24 (ref), u23 (ref)
    u22 = 0;
    u21 = 0;
    u24 = 0;
    u23 = 0;
end;

local function updateVelocityBounds(p26) -- Line: 159
    -- upvalues: u21 (ref), u23 (ref), u22 (ref), u24 (ref)
    if p26 then
        if u21 < p26.x then
            u21 = p26.x;
        end;

        if u23 < p26.y then
            u23 = p26.y;
        end;

        if p26.x < u22 then
            u22 = p26.x;
        end;

        if p26.y < u24 then
            u24 = p26.y;
        end;
    end;
end;

local function checkStrafingEnabled(p27) -- Line: 168
    -- upvalues: u21 (ref), u22 (ref), u23 (ref), u24 (ref), u17 (ref), u15 (copy), u16 (copy)
    if u21 == 0 or (u22 == 0 or (u23 == 0 or u24 == 0)) then
        if u17 == u15 then
            warn("Strafe blending disabled.  Not all quadrants of motion represented.");
        end;

        u17 = u16;

        return;
    end;

    if u15.run and u15.walk then
        if u17 ~= u15 then
            u17 = u15;
            warn("Strafing reenabled");
        end;

        return;
    end;

    if u17 == u15 then
        warn("Strafe blending disabled.  Run and walk must be strafing-friendly.");
    end;

    u17 = u16;
end;

local function setupWalkAnimations() -- Line: 187
    -- upvalues: u22 (ref), u21 (ref), u24 (ref), u23 (ref), u15 (copy), checkStrafingEnabled (copy), u17 (ref), Humanoid (copy), u13 (copy)
    u22 = 0;
    u21 = 0;
    u24 = 0;
    u23 = 0;

    for _, v in pairs(u15) do
        local lv = v.lv;

        if lv then
            if u21 < lv.x then
                u21 = lv.x;
            end;

            if u23 < lv.y then
                u23 = lv.y;
            end;

            if lv.x < u22 then
                u22 = lv.x;
            end;

            if lv.y < u24 then
                u24 = lv.y;
            end;
        end;
    end;

    checkStrafingEnabled();

    for i, v in pairs(u17) do
        v.track = Humanoid:LoadAnimation(u13[i][1].anim);
        v.track.Priority = Enum.AnimationPriority.Core;
    end;
end;

local function replaceLocomotionTrack(p28, p29) -- Line: 200
    -- upvalues: u7 (ref), u17 (ref), destroyWalkAnimations (copy), u15 (copy), u16 (copy), setupWalkAnimations (copy), u6 (ref)
    local v30;

    if u7 == "walk" and u17[p28] then
        destroyWalkAnimations();
        v30 = true;
    else
        v30 = false;
    end;

    if p29 then
        u15[p28] = {
            lv = p29,
            speed = p29.Magnitude
        };
    else
        u15[p28] = nil;
    end;

    if p28 == "run" or p28 == "walk" then
        if p29 then
            u16[p28] = u15[p28];
        else
            local v31 = p28 == "run" and 12.8 or 6.4;
            u16[p28] = {
                lv = Vector2.new(0, v31),
                speed = v31
            };
            u15[p28] = nil;
        end;
    end;

    if v30 then
        setupWalkAnimations();
        u6 = 0;
    end;
end;

function configureAnimationSet(u32, u33)
    -- upvalues: u13 (copy), replaceLocomotionTrack (copy), u12 (copy), Humanoid (copy)
    if u13[u32] ~= nil then
        for _, v in pairs(u13[u32].connections) do
            v:disconnect();
        end;
    end;

    u13[u32] = {};
    u13[u32].count = 0;
    u13[u32].totalWeight = 0;
    u13[u32].connections = {};
    local v34 = script:FindFirstChild(u32);

    if v34 ~= nil then
        table.insert(u13[u32].connections, v34.ChildAdded:connect(function(p35) -- Line: 242
            -- upvalues: u32 (copy), u33 (copy)
            configureAnimationSet(u32, u33);
        end));
        table.insert(u13[u32].connections, v34.ChildRemoved:connect(function(p36) -- Line: 243
            -- upvalues: u32 (copy), u33 (copy)
            configureAnimationSet(u32, u33);
        end));

        for _, child in pairs(v34:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v37 = Weight == nil and 1 or Weight.Value;
                u13[u32].count = u13[u32].count + 1;
                local count = u13[u32].count;
                u13[u32][count] = {};
                u13[u32][count].anim = child;
                u13[u32][count].weight = v37;
                u13[u32].totalWeight = u13[u32].totalWeight + u13[u32][count].weight;
                table.insert(u13[u32].connections, child.Changed:connect(function(p38) -- Line: 260
                    -- upvalues: u32 (copy), u33 (copy)
                    configureAnimationSet(u32, u33);
                end));
                table.insert(u13[u32].connections, child.ChildAdded:connect(function(p39) -- Line: 261
                    -- upvalues: u32 (copy), u33 (copy)
                    configureAnimationSet(u32, u33);
                end));
                table.insert(u13[u32].connections, child.ChildRemoved:connect(function(p40) -- Line: 262
                    -- upvalues: u32 (copy), u33 (copy)
                    configureAnimationSet(u32, u33);
                end));
                replaceLocomotionTrack(u32, (child:GetAttribute("LinearVelocity")));
            end;
        end;
    end;

    if u13[u32].count <= 0 then
        for i, v in pairs(u33) do
            u13[u32][i] = {};
            u13[u32][i].anim = Instance.new("Animation");
            u13[u32][i].anim.Name = u32;
            u13[u32][i].anim.AnimationId = v.id;
            u13[u32][i].weight = v.weight;
            u13[u32].count = u13[u32].count + 1;
            u13[u32].totalWeight = u13[u32].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u13) do
        local v41 = v;

        for i = 1, v.count do
            local v42;

            if u12[v41[i].anim.AnimationId] == nil then
                Humanoid:LoadAnimation(v41[i].anim);
                u12[v41[i].anim.AnimationId] = true;
                v42 = i;
            else
                v42 = i;
            end;
        end;
    end;
end;

function scriptChildModified(p43)
    -- upvalues: u14 (copy)
    local v44 = u14[p43.Name];

    if v44 == nil then
        if p43:isA("StringValue") then
            u14[p43.Name] = {};
            configureAnimationSet(p43.Name, u14[p43.Name]);
        end;

        return;
    end;

    configureAnimationSet(p43.Name, v44);
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v45;

if Humanoid then
    v45 = Humanoid:FindFirstChildOfClass("Animator");
else
    v45 = nil;
end;

if v45 then
    local PlayingAnimationTracks = v45:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u14) do
    configureAnimationSet(i, v);
end;

for _, child in script:GetChildren() do
    if child:isA("StringValue") then
        u14[child.Name] = {};
        configureAnimationSet(child.Name, u14[child.Name]);
    end;
end;

local u46 = "None";
local u47 = 0;
local u48 = 0;
local u49 = false;

function stopAllAnimations()
    -- upvalues: u7 (ref), u18 (copy), u49 (ref), u8 (ref), u10 (ref), u9 (ref), u17 (ref)
    local v50 = u7;
    local v51 = u18[v50] ~= nil and u18[v50] == false and "idle" or v50;

    if u49 then
        v51 = "idle";
        u49 = false;
    end;

    u7 = "";
    u8 = nil;

    if u10 ~= nil then
        u10:disconnect();
    end;

    if u9 ~= nil then
        u9:Stop();
        u9:Destroy();
        u9 = nil;
    end;

    for _, v in pairs(u17) do
        if v.track then
            v.track:Stop();
            v.track:Destroy();
            v.track = nil;
        end;
    end;

    return v51;
end;

local function getRigScale() -- Line: 383
    -- upvalues: u2 (copy), script_Parent (copy)
    return not u2 and 1 or script_Parent:GetScale();
end;

function getHeightScale()
    -- upvalues: Humanoid (copy), getRigScale (copy), ScaleDampeningPercent (ref)
    if not Humanoid then
        return getRigScale();
    end;

    if not Humanoid.AutomaticScalingEnabled then
        return getRigScale();
    end;

    local v52 = Humanoid.HipHeight / 2;

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
    end;

    if ScaleDampeningPercent ~= nil then
        v52 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2;
    end;

    return v52;
end;

local function signedAngle(p53, p54) -- Line: 412
    return -math.atan2(p53.x * p54.y - p53.y * p54.x, p53.x * p54.x + p53.y * p54.y);
end;

local function get2DWeight(p55, p56, p57, p58, p59, p60) -- Line: 417
    local v61 = 0.5 * (p59 + p60);
    local v62 = {
        x = (p58 - p59) / v61,
        y = 2 * -math.atan2(p56.x * p55.y - p56.y * p55.x, p56.x * p55.x + p56.y * p55.y)
    };
    local v63 = {
        x = (p60 - p59) / v61,
        y = 2 * -math.atan2(p56.x * p57.y - p56.y * p57.x, p56.x * p57.x + p56.y * p57.y)
    };

    return math.clamp(1 - (v62.x * v63.x + v62.y * v63.y) / (0.0001 + (v63.x * v63.x + v63.y * v63.y)), 0, 1);
end;

local function blend2D(p64, p65) -- Line: 428
    -- upvalues: u2 (copy), u17 (ref), get2DWeight (copy)
    if u2 then
        local v66 = getHeightScale();
        p64 = p64 / v66;
        p65 = p65 / v66;
    end;

    local v67 = {};
    local v68 = 0;

    for i, v in pairs(u17) do
        if p64.x * v.lv.x < 0 or p64.y * v.lv.y < 0 then
            v67[i] = 0;
        else
            v67[i] = (1 / 0);
            local v69 = v;
            local v70 = i;

            for _, v2 in pairs(u17) do
                if p64.x * v2.lv.x >= 0 and p64.y * v2.lv.y >= 0 then
                    local v71 = v67[v70];
                    local v72 = get2DWeight(p64, v69.lv, v2.lv, p65, v69.speed, v2.speed);
                    v67[v70] = math.min(v71, v72);
                end;
            end;

            v68 = v68 + v67[v70];
        end;
    end;

    local v73 = 0;
    local v74 = 0;
    local v75 = 0;

    for i, v in pairs(u17) do
        if v67[i] / v68 > 0.1 then
            v73 = v73 + v67[i];
            v74 = v74 + v67[i] * v.lv.x;
            v75 = v75 + v67[i] * v.lv.y;
        else
            v67[i] = 0;
        end;
    end;

    local v76 = v74 * v74 + v75 * v75;
    local v77 = v76 <= 0.0001 and 0 or math.sqrt(p65 * p65 / v76);

    if not u2 then
        v77 = v77 / getHeightScale();
    end;

    local v78 = 0;

    for _, v in pairs(u17) do
        if v.track.IsPlaying then
            v78 = v.track.TimePosition;
            break;
        end;
    end;

    for i, v in pairs(u17) do
        if v67[i] > 0 then
            if not v.track.IsPlaying then
                v.track:Play(0.2);
                v.track.TimePosition = v78;
            end;

            local math_max_ret = math.max(0.0001, v67[i] / v73);
            v.track:AdjustWeight(math_max_ret, 0.2);
            v.track:AdjustSpeed(v77);
        else
            v.track:Stop(0.2);
        end;
    end;
end;

local function getWalkDirection() -- Line: 504
    -- upvalues: Humanoid (copy)
    local WalkToPoint = Humanoid.WalkToPoint;
    local WalkToPart = Humanoid.WalkToPart;

    if Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
        return Humanoid.MoveDirection;
    end;

    if not WalkToPart and WalkToPoint == Vector3.new(0, 0, 0) then
        return Humanoid.MoveDirection;
    end;

    if WalkToPart then
        WalkToPoint = WalkToPart.CFrame:PointToWorldSpace(WalkToPoint);
    end;

    local v79;

    if Humanoid.RootPart then
        local v80 = WalkToPoint - Humanoid.RootPart.CFrame.Position;
        v79 = Vector3.new(v80.x, 0, v80.z);
        local Magnitude = v79.Magnitude;

        if Magnitude > 0.01 then
            v79 = v79 / Magnitude;
        end;
    else
        v79 = Vector3.new(0, 0, 0);
    end;

    return v79;
end;

local function updateVelocity(p81) -- Line: 531
    -- upvalues: u17 (ref), u15 (copy), getWalkDirection (copy), Humanoid (copy), u1 (ref), u3 (ref), u5 (ref), u4 (ref), u6 (ref), blend2D (copy)
    if u17 == u15 then
        local v82 = getWalkDirection();

        if not Humanoid.RootPart then
            return;
        end;

        local CFrame = Humanoid.RootPart.CFrame;

        if math.abs(CFrame.UpVector.Y) < 0.0001 or (u1 ~= "Running" or u3 < 0.001) then
            for _, v in pairs(u17) do
                if v.track then
                    v.track:AdjustWeight(0.0001, 0.2);
                end;
            end;

            return;
        end;

        local LookVector = CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        local v83 = Vector3_new_ret / Vector3_new_ret.Magnitude;
        local v84 = v82:Dot(v83);
        local Vector2_new_ret = Vector2.new(v83.X * v82.Z - v83.Z * v82.X, v84 <= 0 and v84 > -0.05 and 0.0001 or v84);
        local Vector2_new_ret2 = Vector2.new(Vector2_new_ret.x - u5.x, Vector2_new_ret.y - u5.y);

        if Vector2_new_ret2:Dot(Vector2_new_ret2) > 0.001 or (math.abs(u3 - u4) > 0.01 or p81 - u6 > 1) then
            u5 = Vector2_new_ret;
            u4 = u3;
            u6 = p81;
            blend2D(u5, u4);
        end;
    elseif math.abs(u3 - u4) > 0.01 or p81 - u6 > 1 then
        u4 = u3;
        u6 = p81;
        blend2D(Vector2.yAxis, u4);
    end;
end;

function setAnimationSpeed(p85)
    -- upvalues: u7 (ref), u11 (ref), u9 (ref)
    if u7 ~= "walk" and p85 ~= u11 then
        u11 = p85;
        u9:AdjustSpeed(u11);
    end;
end;

function keyFrameReachedFunc(p86)
    -- upvalues: u7 (ref), u18 (copy), u49 (ref), u9 (ref), u11 (ref), Humanoid (copy)
    if p86 == "End" then
        local v87 = u7;
        local v88 = u18[v87] ~= nil and u18[v87] == false and "idle" or v87;

        if u49 then
            if u9.Looped then
                return;
            end;

            v88 = "idle";
            u49 = false;
        end;

        playAnimation(v88, 0.15, Humanoid);
        setAnimationSpeed(u11);
    end;
end;

function rollAnimation(p89)
    -- upvalues: u13 (copy)
    local math_random_ret = math.random(1, u13[p89].totalWeight);
    local v90 = 1;

    while u13[p89][v90].weight < math_random_ret do
        math_random_ret = math_random_ret - u13[p89][v90].weight;
        v90 = v90 + 1;
    end;

    return v90;
end;

local function switchToAnim(p91, p92, p93, p94, p95) -- Line: 623
    -- upvalues: u8 (ref), u9 (ref), u10 (ref), u11 (ref), u7 (ref), setupWalkAnimations (copy), destroyWalkAnimations (copy)
    if p91 ~= u8 or p95 then
        if u9 ~= nil then
            u9:Stop(p93);
            u9:Destroy();
        end;

        if u10 ~= nil then
            u10:disconnect();
            u10 = nil;
        end;

        u11 = 1;
        u7 = p92;
        u8 = p91;

        if p92 == "walk" then
            setupWalkAnimations();

            return;
        end;

        destroyWalkAnimations();
        u9 = p94:LoadAnimation(p91);
        u9.Priority = Enum.AnimationPriority.Core;
        u9:Play(p93);
        u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;

local u96 = nil;

function playAnimation(p97, p98, p99, ...)
    -- upvalues: u96 (ref), u13 (copy), switchToAnim (copy), u49 (ref)
    u96 = { p97, p98, p99 };
    local v100 = rollAnimation(p97);
    switchToAnim(u13[p97][v100].anim, p97, p98, p99, ...);
    u49 = false;
end;

script:WaitForChild("Refresh").Event:Connect(function(...) -- Line: 670
    -- upvalues: u96 (ref)
    if not u96 then
        return;
    end;

    for _, v in pairs(script.Parent.Humanoid:GetPlayingAnimationTracks()) do
        v:Stop();
        v:Destroy();
    end;

    script.RefreshServer:FireServer();
    playAnimation(u96[1], u96[2], u96[3], true, ...);
end);

function playEmote(p101, p102, p103)
    -- upvalues: switchToAnim (copy), u49 (ref)
    switchToAnim(p101, p101.Name, p102, p103);
    u49 = true;
end;

local u104 = "";
local u105 = nil;
local u106 = nil;
local u107 = nil;

function toolKeyFrameReachedFunc(p108)
    -- upvalues: u104 (ref), Humanoid (copy)
    if p108 == "End" then
        playToolAnimation(u104, 0, Humanoid);
    end;
end;

function playToolAnimation(p109, p110, p111, p112)
    -- upvalues: u13 (copy), u106 (ref), u105 (ref), u104 (ref), u107 (ref)
    local v113 = rollAnimation(p109);
    local anim = u13[p109][v113].anim;

    if u106 ~= anim then
        if u105 ~= nil then
            u105:Stop();
            u105:Destroy();
            p110 = 0;
        end;

        u105 = p111:LoadAnimation(anim);

        if p112 then
            u105.Priority = p112;
        end;

        u105:Play(p110);
        u104 = p109;
        u106 = anim;
        u107 = u105.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u104 (ref), u107 (ref), u106 (ref), u105 (ref)
    local v114 = u104;

    if u107 ~= nil then
        u107:disconnect();
    end;

    u104 = "";
    u106 = nil;

    if u105 ~= nil then
        u105:Stop();
        u105:Destroy();
        u105 = nil;
    end;

    return v114;
end;

function onRunning(p115)
    -- upvalues: u2 (copy), u49 (ref), Humanoid (copy), u3 (ref), u1 (ref), updateVelocity (copy), u18 (copy), u7 (ref)
    local v116 = not u2 and 1 or getHeightScale();
    u3 = p115;

    if (u49 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and (Humanoid.WalkSpeed / v116 or 0.75) or 0.75) * v116 < p115 then
        playAnimation("walk", 0.2, Humanoid);

        if u1 ~= "Running" then
            u1 = "Running";
            updateVelocity(0);
        end;
    elseif u18[u7] == nil and not u49 then
        playAnimation("idle", 0.2, Humanoid);
        u1 = "Standing";
    end;
end;

function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u48 (ref), u1 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u48 = 0.31;
    u1 = "Jumping";
end;

function onClimbing(p117)
    -- upvalues: u2 (copy), Humanoid (copy), u1 (ref)
    if u2 then
        p117 = p117 / getHeightScale();
    end;

    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(p117 / 5);
    u1 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u48 (ref), Humanoid (copy), u1 (ref)
    if u48 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    end;

    u1 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u1 (ref)
    u1 = "FallingDown";
end;

function onSeated()
    -- upvalues: u1 (ref)
    u1 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u1 (ref)
    u1 = "PlatformStanding";
end;

function onSwimming(p118)
    -- upvalues: u2 (copy), Humanoid (copy), u1 (ref)
    if u2 then
        p118 = p118 / getHeightScale();
    end;

    if p118 <= 1 then
        playAnimation("swimidle", 0.4, Humanoid);
        u1 = "Standing";

        return;
    end;

    playAnimation("swim", 0.4, Humanoid);
    setAnimationSpeed(p118 / 10);
    u1 = "Swimming";
end;

function animateTool()
    -- upvalues: u46 (ref), Humanoid (copy)
    if u46 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u46 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u46 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function getToolAnim(p119)
    for _, child in ipairs(p119:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

local u120 = 0;

function stepAnimate(p121)
    -- upvalues: u120 (ref), u48 (ref), u1 (ref), Humanoid (copy), updateVelocity (copy), script_Parent (copy), u46 (ref), u47 (ref), u106 (ref)
    local v122 = p121 - u120;
    u120 = p121;

    if u48 > 0 then
        u48 = u48 - v122;
    end;

    if u1 == "FreeFall" and u48 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    else
        if u1 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u1 == "Running" then
            playAnimation("walk", 0.2, Humanoid);
            updateVelocity(p121);
        elseif u1 == "Dead" or (u1 == "GettingUp" or (u1 == "FallingDown" or (u1 == "Seated" or u1 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;

    local v123 = script_Parent:FindFirstChildOfClass("Tool");

    if v123 and v123:FindFirstChild("Handle") then
        local v124 = getToolAnim(v123);

        if v124 then
            u46 = v124.Value;
            v124.Parent = nil;
            u47 = p121 + 0.3;
        end;

        if u47 < p121 then
            u47 = 0;
            u46 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u46 = "None";
    u106 = nil;
    u47 = 0;
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p125) -- Line: 933
    -- upvalues: u1 (ref), u18 (copy), Humanoid (copy)
    local v126 = "";

    if string.sub(p125, 1, 3) == "/e " then
        v126 = string.sub(p125, 4);
    elseif string.sub(p125, 1, 7) == "/emote " then
        v126 = string.sub(p125, 8);
    end;

    if u1 == "Standing" and u18[v126] ~= nil then
        playAnimation(v126, 0.1, Humanoid);
    end;
end);

script:WaitForChild("PlayEmote").OnInvoke = function(p127) -- Line: 947
    -- upvalues: u1 (ref), u18 (copy), Humanoid (copy), u9 (ref)
    if u1 == "Standing" then
        if u18[p127] ~= nil then
            playAnimation(p127, 0.1, Humanoid);

            return true, u9;
        end;

        if typeof(p127) ~= "Instance" or not p127:IsA("Animation") then
            return false;
        end;

        playEmote(p127, 0.1, Humanoid);

        return true, u9;
    end;
end;

-- BODY LOOK (ported 1/1 from gun game's Animate) --------------------------------------------
-- Look up and down and the body follows: the neck takes 75% of the tilt, the waist 25%.
--   camera all the way up   -> 90 total  ->  neck  67.5   waist  22.5
--   camera all the way down -> 70 total  ->  neck -52.5   waist -17.5
-- It writes the joints' C0 (the Animator only writes Transform), so animations still play on top.
-- This place's rigs use AnimationConstraints (the avatar joint upgrade) instead of Motor6Ds; for
-- those the joint's frame on the parent part is Attachment0.CFrame, so that is what turns.
do
    local RunService = game:GetService("RunService");
    local Character = script_Parent;
    local camera = workspace.CurrentCamera;

    local CAMERA_RANGE = 80; -- degrees the camera tilts each way before it stops
    local LIMIT_UP = 90;     -- body degrees at full camera travel up
    local LIMIT_DOWN = 70;   -- body degrees at full camera travel down
    local NECK_SHARE = 0.75;
    local WAIST_SHARE = 0.25;

    local neckJoint, waistJoint;
    local neckBase, waistBase;
    local neckAxis, waistAxis;

    local function findMotor(name)
        for _, descendant in ipairs(Character:GetDescendants()) do
            if descendant.Name == name and (descendant:IsA("Motor6D") or (descendant:IsA("AnimationConstraint") and descendant.Attachment0)) then
                return descendant;
            end;
        end;
        return nil;
    end;

    -- the joint's frame on its parent part: C0 for a Motor6D, Attachment0.CFrame otherwise
    local function getFrame(joint)
        if joint:IsA("Motor6D") then
            return joint.C0;
        end;
        return joint.Attachment0.CFrame;
    end;
    local function setFrame(joint, frame)
        if joint:IsA("Motor6D") then
            joint.C0 = frame;
        elseif joint.Attachment0 then
            joint.Attachment0.CFrame = frame;
        end;
    end;

    local function startLook()
        RunService:BindToRenderStep("AnimateLook", Enum.RenderPriority.Character.Value + 1, function()
            camera = workspace.CurrentCamera;
            -- where the camera is pointing, -80 (down) to +80 (up)
            local degrees = math.deg(math.asin(math.clamp(camera.CFrame.LookVector.Y, -1, 1)));
            local fraction = math.clamp(degrees / CAMERA_RANGE, -1, 1);
            local total = fraction >= 0 and fraction * LIMIT_UP or fraction * LIMIT_DOWN;

            if neckJoint and neckJoint.Parent then
                setFrame(neckJoint, neckBase * CFrame.fromAxisAngle(neckAxis, math.rad(total * NECK_SHARE)));
            end;
            if waistJoint and waistJoint.Parent then
                setFrame(waistJoint, waistBase * CFrame.fromAxisAngle(waistAxis, math.rad(total * WAIST_SHARE)));
            end;
        end);
    end;

    -- Only the player's own character (this runs on the client that owns it).
    if game:GetService("Players"):GetPlayerFromCharacter(Character) == game:GetService("Players").LocalPlayer then
        task.spawn(function()
            local deadline = os.clock() + 5;
            while os.clock() < deadline do
                if findMotor("Neck") then
                    break;
                end;
                task.wait(0.1);
            end;

            neckJoint = findMotor("Neck");
            waistJoint = findMotor("Waist");
            if not neckJoint and not waistJoint then
                warn("[Animate] body look: no Neck or Waist Motor6D found");
                return;
            end;

            -- pitch turns about the torso's right vector, found inside each joint's own frame
            if neckJoint then
                neckBase = getFrame(neckJoint);
                neckAxis = neckBase:VectorToObjectSpace(Vector3.new(1, 0, 0));
            end;
            if waistJoint then
                waistBase = getFrame(waistJoint);
                waistAxis = waistBase:VectorToObjectSpace(Vector3.new(1, 0, 0));
            end;

            startLook();
        end);
    end;

    Character.AncestryChanged:Connect(function()
        if not Character:IsDescendantOf(game) then
            pcall(function()
                RunService:UnbindFromRenderStep("AnimateLook");
            end);
            if neckJoint and neckJoint.Parent and neckBase then
                setFrame(neckJoint, neckBase);
            end;
            if waistJoint and waistJoint.Parent and waistBase then
                setFrame(waistJoint, waistBase);
            end;
        end;
    end);
end;

if script_Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid);
    u1 = "Standing";
end;

while script_Parent.Parent ~= nil do
    local _, v128 = wait(0.1);
    stepAnimate(v128);
end;