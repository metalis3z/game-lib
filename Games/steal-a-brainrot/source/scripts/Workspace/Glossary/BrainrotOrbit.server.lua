-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
if script:IsDescendantOf(workspace) then
    local l__BrainrotAssets__2 = require(l__ReplicatedStorage__1.Shared.BrainrotAssets);
    local l__RunService__3 = game:GetService("RunService");
    local l__Cube__4 = script.Parent.Animated.Cube;
    local v1 = {
        "Admin Lucky Block",
        "Ballerina Cappuccina",
        "Griffin",
        "Hydra Dragon Cannelloni",
        "La Grande Combinasion",
        "Los Hackers",
        "Meowl",
        "Noobini Pizzanini",
        "Secret Lucky Block",
        "Tralalero Tralala"
    };
    l__BrainrotAssets__2.preload(v1);
    local v2 = {};
    for _, v3 in v1 do
        local v4 = l__BrainrotAssets__2.getModel(v3);
        if v4 then
            local v5 = l__ReplicatedStorage__1.Animations.Animals:FindFirstChild(v3);
            if v5 then
                local v6 = v4:Clone();
                if v6.PrimaryPart then
                    v6.PrimaryPart.Anchored = false;
                end;
                local v7 = Instance.new("Motor6D");
                v7.Part0 = workspace.Terrain;
                v7.Part1 = v6.PrimaryPart;
                v7.Parent = v6.PrimaryPart;
                v6:ScaleTo(v6:GetScale() * 0.1);
                v6.Parent = script.Parent;
                table.insert(v2, {
                    model = v6,
                    anim = v5.Idle,
                    motor = v7
                });
            end;
        end;
    end;
    local v8 = {};
    for _, v9 in ipairs(v2) do
        local l__model__5 = v9.model;
        if not l__model__5.PrimaryPart then
            local v10 = l__model__5:FindFirstChild("RootPart");
            if v10 and v10:IsA("BasePart") then
                l__model__5.PrimaryPart = v10;
            else
                local v11 = l__model__5:FindFirstChildWhichIsA("BasePart");
                if v11 then
                    l__model__5.PrimaryPart = v11;
                end;
            end;
        end;
        if l__model__5.PrimaryPart then
            local v12 = l__model__5:FindFirstChild("AnimationController");
            local v13 = v12 and (v9.anim and v9.anim:IsA("Animation"));
            if v13 then
                v13 = v12:FindFirstChildWhichIsA("Animator");
            end;
            if v13 then
                local v14 = v13:LoadAnimation(v9.anim);
                v14.Looped = true;
                v14:Play();
            end;
            table.insert(v8, {
                model = l__model__5,
                motor = v9.motor
            });
        end;
    end;
    local v15 = {};
    for v16 = 1, #v8 do
        v15[v16] = v16 % 2 + 1;
    end;
    for v17 = #v15, 2, -1 do
        local v18 = math.random(v17);
        local v19 = v15[v18];
        local v20 = v15[v17];
        v15[v17] = v19;
        v15[v18] = v20;
    end;
    local u21 = {
        {},
        {}
    };
    for v22, v23 in ipairs(v8) do
        table.insert(u21[v15[v22]], v23);
    end;
    l__RunService__3.Stepped:Connect(function() --[[ Line: 94 ]]
        -- upvalues: l__Cube__4 (copy), u21 (copy)
        local v24 = os.clock();
        local l__Position__6 = l__Cube__4.Position;
        local v25 = math.sin(v24 * 1) * 0.3;
        for v26 = 1, 2 do
            local v27 = u21[v26];
            local v28 = #v27;
            if v28 > 0 then
                local v29 = v26 == 1 and 1 or -1;
                local v30 = v26 == 1 and 0 or 2;
                local v31 = v24 * 0.5 * v29;
                for v32, v33 in ipairs(v27) do
                    local v34 = (v32 - 1) * (6.283185307179586 / v28);
                    local v35 = v31 + v34;
                    local v36 = math.cos(v35) * 2;
                    local v37 = v25 + v30;
                    local v38 = math.sin(v35) * 2;
                    local v39 = l__Position__6 + Vector3.new(v36, v37, v38);
                    local v40 = math.sin(v24 * 0.2 + v34) * 6.283185307179586;
                    local v41 = math.sin(v24 * 0.2 + v34) * 6.283185307179586;
                    local v42 = math.sin(v24 * 0.2 + v34) * 6.283185307179586;
                    v33.motor.Transform = CFrame.new(v39) * CFrame.Angles(v40, v41 + 3.141592653589793, v42);
                end;
            end;
        end;
    end);
end;