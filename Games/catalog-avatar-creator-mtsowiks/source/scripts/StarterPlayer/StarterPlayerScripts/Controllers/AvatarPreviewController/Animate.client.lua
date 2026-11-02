-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Humanoid = script.Parent:WaitForChild("Humanoid");
local u1 = {};
local u2 = {};
local u3 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        } }
};
math.randomseed(tick());

local function configureAnimationSet(u4, u5) -- Line: 26
    -- upvalues: u2 (copy), configureAnimationSet (copy), u1 (copy), Humanoid (copy)
    if u2[u4] ~= nil then
        for _, v in pairs(u2[u4].connections) do
            v:Disconnect();
        end;
    end;

    u2[u4] = {
        count = 0,
        totalWeight = 0,
        connections = {}
    };
    local u6 = true;
    u6 = not pcall(function() -- Line: 40
        -- upvalues: u6 (ref)
        u6 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end) and true or u6;
    local v7 = script:FindFirstChild(u4);

    if u6 and v7 ~= nil then
        table.insert(u2[u4].connections, v7.ChildAdded:Connect(function() -- Line: 50
            -- upvalues: configureAnimationSet (ref), u4 (copy), u5 (copy)
            configureAnimationSet(u4, u5);
        end));
        table.insert(u2[u4].connections, v7.ChildRemoved:Connect(function() -- Line: 53
            -- upvalues: configureAnimationSet (ref), u4 (copy), u5 (copy)
            configureAnimationSet(u4, u5);
        end));

        for _, child in pairs(v7:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v8 = not Weight and 1 or Weight.Value;
                local v9 = u2[u4];
                v9.count = v9.count + 1;
                u2[u4][u2[u4].count] = {
                    anim = child,
                    weight = v8
                };
                local v10 = u2[u4];
                v10.totalWeight = v10.totalWeight + v8;
                table.insert(u2[u4].connections, child.Changed:Connect(function() -- Line: 75
                    -- upvalues: configureAnimationSet (ref), u4 (copy), u5 (copy)
                    configureAnimationSet(u4, u5);
                end));
                table.insert(u2[u4].connections, child.ChildAdded:Connect(function() -- Line: 78
                    -- upvalues: configureAnimationSet (ref), u4 (copy), u5 (copy)
                    configureAnimationSet(u4, u5);
                end));
                table.insert(u2[u4].connections, child.ChildRemoved:Connect(function() -- Line: 81
                    -- upvalues: configureAnimationSet (ref), u4 (copy), u5 (copy)
                    configureAnimationSet(u4, u5);
                end));
            end;
        end;
    end;

    if u2[u4].count <= 0 then
        for i, v in pairs(u5) do
            local Animation = Instance.new("Animation");
            Animation.Name = u4;
            Animation.AnimationId = v.id;
            u2[u4][i] = {
                anim = Animation,
                weight = v.weight
            };
            local v11 = u2[u4];
            v11.count = v11.count + 1;
            local v12 = u2[u4];
            v12.totalWeight = v12.totalWeight + v.weight;
        end;
    end;

    for i = 1, u2[u4].count do
        local anim = u2[u4][i].anim;

        if u1[anim.AnimationId] == nil then
            Humanoid:LoadAnimation(anim);
            u1[anim.AnimationId] = true;
        end;
    end;
end;

local function scriptChildModified(p13) -- Line: 115
    -- upvalues: u3 (copy), configureAnimationSet (copy)
    local v14 = u3[p13.Name];

    if v14 then
        configureAnimationSet(p13.Name, v14);
    end;
end;

script.ChildAdded:Connect(scriptChildModified);
script.ChildRemoved:Connect(scriptChildModified);

for i, v in pairs(u3) do
    configureAnimationSet(i, v);
end;

local u15 = "";
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = false;
local u21 = nil;

local function keyFrameReachedFunc(p22) -- Line: 142
    -- upvalues: u20 (ref), u17 (ref), u21 (ref)
    if p22 ~= "End" then
        return;
    end;

    if not u20 then
        u21("idle", 0.1);

        return;
    end;

    if u17 and u17.Looped then
        return;
    end;

    u20 = false;
    u21("idle", 0.1);
end;

local function rollAnimation(p23) -- Line: 162
    -- upvalues: u2 (copy)
    local v24 = u2[p23];

    if not v24 or v24.count == 0 then
        return 1;
    end;

    local v25 = math.random(1, v24.totalWeight);
    local v26 = 1;

    while v24[v26].weight < v25 do
        v25 = v25 - v24[v26].weight;
        v26 = v26 + 1;
    end;

    return v26;
end;

local function switchToAnim(p27, p28, p29) -- Line: 179
    -- upvalues: u16 (ref), u17 (ref), u18 (ref), u19 (ref), Humanoid (copy), u15 (ref), keyFrameReachedFunc (copy), u20 (ref), u21 (ref)
    if p27 == u16 then
        return;
    end;

    if u17 then
        u17:Stop(p29);
        u17:Destroy();
        u17 = nil;
    end;

    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    if u19 then
        u19:Disconnect();
        u19 = nil;
    end;

    u17 = Humanoid:LoadAnimation(p27);
    u17.Priority = Enum.AnimationPriority.Core;
    u17:Play(p29);
    u15 = p28;
    u16 = p27;
    u18 = u17.KeyframeReached:Connect(keyFrameReachedFunc);
    u19 = u17.Stopped:Connect(function() -- Line: 209
        -- upvalues: u20 (ref), u21 (ref)
        if u20 then
            u20 = false;
            u21("idle", 0.1);
        end;
    end);
end;

u21 = function(p30, p31) -- Line: 218
    -- upvalues: u2 (copy), rollAnimation (copy), switchToAnim (copy), u20 (ref)
    local v32 = u2[p30];

    if not v32 or v32.count == 0 then
        return;
    end;

    switchToAnim(v32[rollAnimation(p30)].anim, p30, p31);
    u20 = false;
end;

local function playEmote(p33, p34) -- Line: 230
    -- upvalues: switchToAnim (copy), u20 (ref)
    switchToAnim(p33, p33.Name, p34);
    u20 = true;
end;

script:WaitForChild("PlayEmote").OnInvoke = function(p35) -- Line: 241
    -- upvalues: switchToAnim (copy), u20 (ref), u17 (ref)
    if typeof(p35) ~= "Instance" or not p35:IsA("Animation") then
        return false;
    end;

    switchToAnim(p35, p35.Name, 0.1);
    u20 = true;

    return true, u17;
end;

local v36 = Humanoid:FindFirstChildOfClass("Animator");

if v36 then
    for _, v in ipairs(v36:GetPlayingAnimationTracks()) do
        v:Stop(0);
        v:Destroy();
    end;
end;

u21("idle", 0.1);