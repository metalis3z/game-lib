-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Parent = script.Parent;
local Humanoid = Parent:WaitForChild("Humanoid");
local u1 = "";
local u2 = nil;
local u3 = nil;
local u4 = {};

function configureAnimationSet(u5, u6)
    -- upvalues: u4 (copy)
    if u4[u5] ~= nil then
        for _, v in u4[u5].connections do
            v:Disconnect();
        end;
    end;

    u4[u5] = {};
    u4[u5].count = 0;
    u4[u5].totalWeight = 0;
    u4[u5].connections = {};
    local u7 = true;
    pcall(function() -- Line: 29
        -- upvalues: u7 (ref)
        u7 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    local v8 = script:FindFirstChild(u5);

    if u7 and v8 ~= nil then
        table.insert(u4[u5].connections, v8.ChildAdded:Connect(function() -- Line: 33
            -- upvalues: u5 (copy), u6 (copy)
            configureAnimationSet(u5, u6);
        end));
        table.insert(u4[u5].connections, v8.ChildRemoved:Connect(function() -- Line: 34
            -- upvalues: u5 (copy), u6 (copy)
            configureAnimationSet(u5, u6);
        end));

        for _, child in v8:GetChildren() do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v9 = Weight == nil and 1 or Weight.Value;
                u4[u5].count = u4[u5].count + 1;
                local count = u4[u5].count;
                u4[u5][count] = {};
                u4[u5][count].anim = child;
                u4[u5][count].weight = v9;
                u4[u5].totalWeight = u4[u5].totalWeight + v9;
                table.insert(u4[u5].connections, child.Changed:Connect(function() -- Line: 49
                    -- upvalues: u5 (copy), u6 (copy)
                    configureAnimationSet(u5, u6);
                end));
            end;
        end;
    end;

    if u4[u5].count <= 0 then
        for i, v in u6 do
            u4[u5][i] = {};
            u4[u5][i].anim = Instance.new("Animation");
            u4[u5][i].anim.Name = u5;
            u4[u5][i].anim.AnimationId = v.id;
            u4[u5][i].weight = v.weight;
            u4[u5].count = u4[u5].count + 1;
            u4[u5].totalWeight = u4[u5].totalWeight + v.weight;
        end;
    end;
end;

function rollAnimation(p10)
    -- upvalues: u4 (copy)
    local v11 = math.random(1, u4[p10].totalWeight);
    local v12 = 1;

    while u4[p10][v12].weight < v11 do
        v11 = v11 - u4[p10][v12].weight;
        v12 = v12 + 1;
    end;

    return v12;
end;

function playAnimation(p13, p14, p15)
    -- upvalues: u4 (copy), u2 (ref), u3 (ref), u1 (ref)
    local v16 = rollAnimation(p13);
    local anim = u4[p13][v16].anim;

    if anim ~= u2 then
        if u3 ~= nil then
            u3:Stop(p14);
            u3:Destroy();
        end;

        u3 = p15:LoadAnimation(anim);
        u3.Priority = Enum.AnimationPriority.Core;
        u3.Looped = true;
        u3:Play(p14);
        u3:AdjustSpeed(0);
        u1 = p13;
        u2 = anim;
    end;
end;

for i, v in {
    idle = { {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        } }
} do
    configureAnimationSet(i, v);
end;

local v17 = Humanoid:FindFirstChildOfClass("Animator");

if v17 then
    for _, v in v17:GetPlayingAnimationTracks() do
        v:Stop(0);
        v:Destroy();
    end;
end;

if Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid);
end;

while Parent.Parent ~= nil do
    task.wait(1);

    if not (u3 and u3.IsPlaying) then
        playAnimation("idle", 0.2, Humanoid);
    end;
end;