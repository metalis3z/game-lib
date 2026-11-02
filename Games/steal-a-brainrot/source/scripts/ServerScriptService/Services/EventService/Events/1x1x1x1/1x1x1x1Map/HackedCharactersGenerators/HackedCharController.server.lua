-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Parent_0 = script.Parent;
local l_Template_0 = l_Parent_0:WaitForChild("Template");
local l_Entry_0 = l_Template_0:WaitForChild("Entry");
local function _() --[[ Line: 14 ]] --[[ Name: Randomize ]]
    local v4 = math.random(1, 36);
    return (string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v4, v4));
end;
local function _(v6) --[[ Line: 19 ]] --[[ Name: ScrambleEmUp ]]
    task.spawn(function() --[[ Line: 20 ]]
        -- upvalues: v6 (copy)
        while v6:IsDescendantOf(game) do
            local l_v6_0 = v6;
            local v8 = math.random(1, 36);
            l_v6_0.Text = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v8, v8);
            task.wait(0.05);
        end;
    end);
end;
local function v21(v10) --[[ Line: 28 ]] --[[ Name: SpawnTemplate ]]
    -- upvalues: l_Template_0 (copy), l_Entry_0 (copy), l_TweenService_0 (copy)
    local v11 = l_Template_0:Clone();
    v11.Visible = true;
    v11.AnchorPoint = Vector2.new(0.5, 0);
    v11.Parent = v10;
    for _, v13 in ipairs(v11:GetChildren()) do
        if v13.Name == "Entry" then
            v13:Destroy();
        end;
    end;
    for _ = 1, math.random(2, 4) do
        local v15 = l_Entry_0:Clone();
        v15.Visible = true;
        local v16 = math.random(1, 36);
        v15.Text = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v16, v16);
        v15.Parent = v11;
        task.spawn(function() --[[ Line: 20 ]]
            -- upvalues: v15 (copy)
            while v15:IsDescendantOf(game) do
                local l_v15_0 = v15;
                local v18 = math.random(1, 36);
                l_v15_0.Text = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v18, v18);
                task.wait(0.05);
            end;
        end);
    end;
    local v19 = math.random();
    local v20 = math.random(-0.25, 0.1);
    v11.Position = UDim2.new(v19, 0, v20, 0);
    l_TweenService_0:Create(v11, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
        Position = UDim2.new(v19, 0, 1.5, 0)
    }):Play();
    task.delay(1.55, function() --[[ Line: 57 ]]
        -- upvalues: v11 (copy)
        v11:Destroy();
    end);
end;
local function _(v22) --[[ Line: 62 ]] --[[ Name: Run ]]
    -- upvalues: v21 (copy)
    task.spawn(function() --[[ Line: 63 ]]
        -- upvalues: v21 (ref), v22 (copy)
        while true do
            v21(v22);
            task.wait(0.18);
        end;
    end);
end;
for _, v25 in ipairs(l_Parent_0:GetChildren()) do
    local l_SurfaceGui_0 = v25:FindFirstChildOfClass("SurfaceGui");
    task.spawn(function() --[[ Line: 63 ]]
        -- upvalues: v21 (copy), l_SurfaceGui_0 (copy)
        while true do
            v21(l_SurfaceGui_0);
            task.wait(0.18);
        end;
    end);
end;
l_Parent_0.ChildAdded:Connect(function(v27) --[[ Line: 76 ]]
    -- upvalues: v21 (copy)
    local l_SurfaceGui_1 = v27:WaitForChild("SurfaceGui");
    l_SurfaceGui_1:ClearAllChildren();
    task.spawn(function() --[[ Line: 63 ]]
        -- upvalues: v21 (ref), l_SurfaceGui_1 (copy)
        while true do
            v21(l_SurfaceGui_1);
            task.wait(0.18);
        end;
    end);
end);