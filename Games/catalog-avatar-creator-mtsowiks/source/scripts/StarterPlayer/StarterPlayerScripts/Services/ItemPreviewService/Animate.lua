-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Parent = script.Parent;
local Humanoid = Parent:WaitForChild("Humanoid");

local function dprint(...) -- Line: 18
end;

local success, result = pcall(function() -- Line: 23
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u1 = success and result;

local function getRigScale() -- Line: 28
    -- upvalues: u1 (copy), Parent (copy)
    return not u1 and 1 or Parent:GetScale();
end;

script:FindFirstChild("ScaleDampeningPercent");
local u2 = {};
local u3 = {};
local u4 = {
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
        } }
};
math.randomseed(tick());

local function configureAnimationSet(u5, u6, p7, p8) -- Line: 99
    -- upvalues: u3 (copy), dprint (copy), configureAnimationSet (copy), u2 (copy), Humanoid (copy)
    local v9 = p7 or "unknown";
    local v10 = u3[u5];

    if v10 and (v10.manualOverride and not p8) then
        dprint("[AnimConfig] Skipping rebuild for set (manual override active):", u5, " Reason:", v9);

        return;
    end;

    dprint("[AnimConfig] Rebuilding set:", u5, " Reason:", v9);

    if v10 and v10.connections then
        for _, v in v10.connections do
            v:Disconnect();
        end;
    end;

    u3[u5] = u3[u5] or {};
    u3[u5].count = 0;
    u3[u5].totalWeight = 0;
    u3[u5].connections = {};
    u3[u5].manualOverride = u3[u5].manualOverride or false;
    local u11 = true;
    u11 = not pcall(function() -- Line: 124
        -- upvalues: u11 (ref)
        u11 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end) and true or u11;
    local u12 = script:FindFirstChild(u5);
    local v13;

    if u11 and u12 ~= nil then
        table.insert(u3[u5].connections, u12.ChildAdded:Connect(function() -- Line: 138
            -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), u12 (copy)
            configureAnimationSet(u5, u6, "config.ChildAdded(" .. u12.Name .. ")", false);
        end));
        table.insert(u3[u5].connections, u12.ChildRemoved:Connect(function() -- Line: 141
            -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), u12 (copy)
            configureAnimationSet(u5, u6, "config.ChildRemoved(" .. u12.Name .. ")", false);
        end));
        v13 = true;

        for _, child in u12:GetChildren() do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v14 = Weight == nil and 1 or Weight.Value;
                local v15 = u3[u5];
                v15.count = v15.count + 1;
                local count = u3[u5].count;
                u3[u5][count] = {};
                u3[u5][count].anim = child;
                u3[u5][count].weight = v14;
                local v16 = u3[u5];
                v16.totalWeight = v16.totalWeight + v14;
                table.insert(u3[u5].connections, child.Changed:Connect(function() -- Line: 162
                    -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), child (copy)
                    configureAnimationSet(u5, u6, "Animation.Changed(" .. child.Name .. ")", false);
                end));
                table.insert(u3[u5].connections, child.ChildAdded:Connect(function() -- Line: 165
                    -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), child (copy)
                    configureAnimationSet(u5, u6, "Animation.ChildAdded(" .. child.Name .. ")", false);
                end));
                table.insert(u3[u5].connections, child.ChildRemoved:Connect(function() -- Line: 168
                    -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), child (copy)
                    configureAnimationSet(u5, u6, "Animation.ChildRemoved(" .. child.Name .. ")", false);
                end));

                if Weight and Weight:IsA("NumberValue") then
                    table.insert(u3[u5].connections, Weight.Changed:Connect(function() -- Line: 174
                        -- upvalues: configureAnimationSet (ref), u5 (copy), u6 (copy), Weight (copy)
                        configureAnimationSet(u5, u6, "Weight.Changed(" .. Weight.Name .. ")", false);
                    end));
                end;
            end;
        end;
    else
        v13 = false;
    end;

    if u3[u5].count <= 0 then
        if v13 then
            dprint("[AnimConfig] Set", u5, "had custom config but no valid Animation children; using defaults.");
        else
            dprint("[AnimConfig] Set", u5, "has no custom config; using defaults.");
        end;

        if u6 then
            for i, v in u6 do
                u3[u5][i] = {};
                u3[u5][i].anim = Instance.new("Animation");
                u3[u5][i].anim.Name = u5;
                u3[u5][i].anim.AnimationId = v.id;
                u3[u5][i].weight = v.weight;
                local v17 = u3[u5];
                v17.count = v17.count + 1;
                local v18 = u3[u5];
                v18.totalWeight = v18.totalWeight + v.weight;
            end;
        end;
    else
        dprint("[AnimConfig] Set", u5, "using CUSTOM config. Count:", u3[u5].count, "TotalWeight:", u3[u5].totalWeight);
    end;

    for i, v in u3 do
        for i2 = 1, v.count or 0 do
            local v19 = v[i2] and v[i2].anim;

            if v19 and (v19.AnimationId ~= "" and not u2[v19.AnimationId]) then
                Humanoid:LoadAnimation(v19);
                u2[v19.AnimationId] = true;
                dprint("[AnimConfig] Preloaded animation for set", i, "AnimId:", v19.AnimationId);
            end;
        end;
    end;

    dprint("[AnimConfig] Finished rebuild for set", u5, "Final count:", u3[u5].count, "TotalWeight:", u3[u5].totalWeight);
end;

local function scriptChildModified(p20) -- Line: 223
    -- upvalues: u4 (copy), configureAnimationSet (copy)
    local v21 = u4[p20.Name];

    if v21 ~= nil then
        configureAnimationSet(p20.Name, v21, "scriptChildModified(" .. p20.Name .. ")", false);
    end;
end;

script.ChildAdded:Connect(scriptChildModified);
script.ChildRemoved:Connect(scriptChildModified);
local u22 = nil;
local u23 = 0;
local u24 = nil;
local u25 = nil;
local v26 = {};
local u27 = nil;
local u28 = nil;
local u29 = "";
local u30 = 0;

for i, v in u4 do
    configureAnimationSet(i, v, "initial", false);
end;

local function playEntry(p31, p32, p33, p34) -- Line: 243
    -- upvalues: u3 (copy), Humanoid (copy), dprint (copy), u27 (ref), u28 (ref), u29 (ref)
    local v35 = u3[p31];

    if not v35 or v35.count <= 0 then
        warn("[HumanoidAnimateConfigRunner] playEntry: set has no entries:", p31);

        return nil;
    end;

    local v36 = v35[p32];

    if not (v36 and v36.anim) then
        warn("[HumanoidAnimateConfigRunner] playEntry: invalid entry index", p32, "for set", p31);

        return nil;
    end;

    local anim = v36.anim;
    local v37 = p33 == nil and 0.25 or p33;
    local v38 = Humanoid:LoadAnimation(anim);
    local v39 = os.clock();

    while v38.Length <= 0 do
        task.wait(0.1);

        if os.clock() - v39 > 2 then
            return;
        end;
    end;

    if v38.Length > 0 and v38.Length <= 0.35 then
        dprint("[AnimConfig] Skipping animation", anim.AnimationId, "due to extremely low length:", v38.Length);
        v38:Destroy();

        return nil;
    end;

    if v38.Length <= 0 then
        dprint("[AnimConfig] Skipping animation", anim.AnimationId, "due to zero length after waiting.");
        v38:Destroy();

        return nil;
    end;

    if u27 then
        u27:Stop(v37);
        u27:Destroy();
        u27 = nil;
        u28 = nil;
    end;

    dprint("[AnimConfig] Playing entry", p32, "of set", p31, "AnimName:", anim.Name, "AnimId:", anim.AnimationId);
    v38.Priority = p34 or Enum.AnimationPriority.Core;
    v38.Looped = true;
    v38:Play(v37);
    u27 = v38;
    u28 = anim;
    u29 = p31;

    return v38;
end;

local function scheduleNextStep(u40) -- Line: 314
    -- upvalues: u30 (ref), dprint (copy), Humanoid (copy), Parent (copy), u22 (ref), u3 (copy), u23 (ref), playEntry (copy), u24 (ref), u25 (ref), scheduleNextStep (copy)
    task.delay(2.5, function() -- Line: 315
        -- upvalues: u40 (copy), u30 (ref), dprint (ref), Humanoid (ref), Parent (ref), u22 (ref), u3 (ref), u23 (ref), playEntry (ref), u24 (ref), u25 (ref), scheduleNextStep (ref)
        if u40 ~= u30 then
            dprint("[AnimConfig] Delayed step: token mismatch, aborting.");

            return;
        end;

        if Humanoid.Parent == nil or Parent.Parent == nil then
            dprint("[AnimConfig] Delayed step: character/humanoid missing, aborting.");

            return;
        end;

        if not u22 then
            return;
        end;

        local v41 = u3[u22];

        if not v41 or v41.count <= 1 then
            return;
        end;

        local v42 = u23;
        local v43 = 0;
        local v44;

        repeat
            v43 = v43 + 1;
            local v45 = v42 + 1;
            v42 = v41.count < v45 and 1 or v45;
            v44 = playEntry(u22, v42, u24, u25);
        until v44 or v41.count <= v43;

        if v44 then
            u23 = v42;
            scheduleNextStep(u40);
        end;
    end);
end;

function v26.PlayAnimation(p46, p47, p48, p49) -- Line: 365
    -- upvalues: u3 (copy), dprint (copy), u30 (ref), u22 (ref), u29 (ref), u24 (ref), u25 (ref), playEntry (copy), u23 (ref), u27 (ref), Humanoid (copy), Parent (copy), scheduleNextStep (copy)
    local v50 = u3[p47];

    if not v50 or v50.count <= 0 then
        warn("[HumanoidAnimateConfigRunner] No animations configured for set:", p47);

        return nil;
    end;

    dprint("[AnimConfig] PlayAnimation called for set:", p47, "Entries:", v50.count);
    u30 = u30 + 1;
    local u51 = u30;
    u22 = p47;
    u29 = p47;
    u24 = p48;
    u25 = p49;
    local v52 = nil;
    local v53 = 1;

    for i = 1, v50.count do
        v52 = playEntry(p47, i, p48, p49);

        if v52 then
            v53 = i;
            break;
        end;
    end;

    if not v52 then
        return nil;
    end;

    u23 = v53;

    if v50.count == 1 then
        dprint("[AnimConfig] Set", p47, "has only one animation; playing it looped (no cycling).");

        return u27;
    end;

    dprint("[AnimConfig] Set", p47, "has", v50.count, "animations; starting cycle via task.delay.");
    task.delay(2.5, function() -- Line: 315
        -- upvalues: u51 (copy), u30 (ref), dprint (ref), Humanoid (ref), Parent (ref), u22 (ref), u3 (ref), u23 (ref), playEntry (ref), u24 (ref), u25 (ref), scheduleNextStep (ref)
        if u51 ~= u30 then
            dprint("[AnimConfig] Delayed step: token mismatch, aborting.");

            return;
        end;

        if Humanoid.Parent == nil or Parent.Parent == nil then
            dprint("[AnimConfig] Delayed step: character/humanoid missing, aborting.");

            return;
        end;

        if not u22 then
            return;
        end;

        local v54 = u3[u22];

        if not v54 or v54.count <= 1 then
            return;
        end;

        local v55 = u23;
        local v56 = 0;
        local v57;

        repeat
            v56 = v56 + 1;
            local v58 = v55 + 1;
            v55 = v54.count < v58 and 1 or v58;
            v57 = playEntry(u22, v55, u24, u25);
        until v57 or v54.count <= v56;

        if v57 then
            u23 = v55;
            scheduleNextStep(u51);
        end;
    end);

    return u27;
end;

function v26.StopAnimation(p59, p60) -- Line: 417
    -- upvalues: u27 (ref), dprint (copy), u29 (ref), u28 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u30 (ref)
    if u27 then
        local v61 = p60 == nil and 0.25 or p60;
        dprint("[AnimConfig] Stopping current animation set:", u29, "TransitionTime:", v61);
        u27:Stop(v61);
        u27:Destroy();
        u27 = nil;
        u28 = nil;
    end;

    u29 = "";
    u22 = nil;
    u23 = 0;
    u24 = nil;
    u25 = nil;
    u30 = u30 + 1;
end;

function v26.GetCurrentAnimation(p62) -- Line: 443
    -- upvalues: u29 (ref), u27 (ref)
    return u29, u27;
end;

function v26.SetAnimation(p63, p64, p65) -- Line: 457
    -- upvalues: dprint (copy), u3 (copy), u2 (copy), Humanoid (copy)
    dprint("[AnimConfig] SetAnimation override for set:", p64);

    if type(p65) ~= "table" then
        warn("[HumanoidAnimateConfigRunner] SetAnimation expects a table as second argument");

        return;
    end;

    local v66 = u3[p64];

    if v66 and v66.connections then
        for _, v in v66.connections do
            v:Disconnect();
        end;
    end;

    u3[p64] = u3[p64] or {};
    u3[p64].connections = {};
    u3[p64].manualOverride = true;
    u3[p64].count = 0;
    u3[p64].totalWeight = 0;
    local v67 = 0;

    for i, v in p65 do
        local v68, v69;

        if type(v) == "table" then
            v68 = v.Id or v.id;
            v69 = v.Weight or (v.weight or 1);
        else
            v68 = v;
            v69 = 1;
        end;

        if type(v68) == "string" and v68 ~= "" then
            v67 = v67 + 1;
            local Animation = Instance.new("Animation");
            Animation.Name = i;
            Animation.AnimationId = v68;
            u3[p64][v67] = {
                anim = Animation,
                weight = v69
            };
            local v70 = u3[p64];
            v70.count = v70.count + 1;
            local v71 = u3[p64];
            v71.totalWeight = v71.totalWeight + v69;

            if not u2[v68] then
                Humanoid:LoadAnimation(Animation);
                u2[v68] = true;
                dprint("[AnimConfig] Preloaded override animation for set", p64, "Label:", i, "AnimId:", v68);
            end;
        else
            warn("[HumanoidAnimateConfigRunner] SetAnimation: invalid assetId for", i, "in set", p64);
        end;
    end;

    dprint("[AnimConfig] Override complete for set", p64, "Count:", u3[p64].count, "TotalWeight:", u3[p64].totalWeight);
end;

return v26;