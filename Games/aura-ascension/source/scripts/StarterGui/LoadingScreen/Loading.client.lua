-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = l_Players_0.LocalPlayer;
local l_Parent_0 = script.Parent;
l_Parent_0.Enabled = true;
local l_CanvasGroup_0 = l_Parent_0:WaitForChild("CanvasGroup");
local l_Dots_0 = l_CanvasGroup_0:WaitForChild("Frame"):WaitForChild("Dots");
local l_Update_0 = l_Parent_0:WaitForChild("Update");
local l_CloseButton_0 = l_Update_0:WaitForChild("CloseButton");
local l_HasSeenUpdate_0 = l_ReplicatedStorage_0:WaitForChild("HasSeenUpdate");
local l_SaveSeenUpdate_0 = l_ReplicatedStorage_0:WaitForChild("SaveSeenUpdate");
local v13 = {
    BOUNCE_SPEED = 12, 
    BOUNCE_HEIGHT = 25, 
    WAVE_DELAY = 0.4, 
    EXIT_TIME = 0.6, 
    MIN_SCALE = 0.7, 
    MAX_SCALE = 1.3
};
local v14 = {};
local v15 = nil;
local function _(v16, v17, v18, v19, v20) --[[ Line: 38 ]] --[[ Name: map ]]
    return v19 + (v16 - v17) * (v20 - v19) / (v18 - v17);
end;
local function v25() --[[ Line: 43 ]] --[[ Name: Init ]]
    -- upvalues: l_CanvasGroup_0 (copy), l_Update_0 (copy), l_Dots_0 (copy), v14 (copy)
    l_CanvasGroup_0.GroupTransparency = 0;
    l_Update_0.Visible = false;
    for _, v23 in ipairs(l_Dots_0:GetChildren()) do
        if v23:IsA("GuiObject") then
            v23.AnchorPoint = Vector2.new(0.5, 0.5);
            local v24 = v23:FindFirstChildWhichIsA("UIScale") or Instance.new("UIScale", v23);
            table.insert(v14, {
                Instance = v23, 
                Scale = v24
            });
        end;
    end;
end;
local function _() --[[ Line: 62 ]] --[[ Name: Start ]]
    -- upvalues: l_CanvasGroup_0 (copy), v15 (ref), l_RunService_0 (copy), v14 (copy), v13 (copy)
    l_CanvasGroup_0.Visible = true;
    local v26 = os.clock();
    v15 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 67 ]]
        -- upvalues: v26 (copy), v14 (ref), v13 (ref)
        local v27 = os.clock() - v26;
        for v28, v29 in ipairs(v14) do
            local l_Instance_0 = v29.Instance;
            local l_Scale_0 = v29.Scale;
            local v32 = math.sin(v27 * v13.BOUNCE_SPEED - v28 * v13.WAVE_DELAY);
            l_Instance_0.Position = UDim2.new(l_Instance_0.Position.X.Scale, l_Instance_0.Position.X.Offset, 0.5, v32 * v13.BOUNCE_HEIGHT);
            local l_MIN_SCALE_0 = v13.MIN_SCALE;
            local l_MAX_SCALE_0 = v13.MAX_SCALE;
            l_Scale_0.Scale = l_MIN_SCALE_0 + (v32 - -1) * (l_MAX_SCALE_0 - l_MIN_SCALE_0) / 2;
            l_Instance_0.BackgroundTransparency = 0.6 + (v32 - -1) * -0.6 / 2;
        end;
    end);
end;
local function v43() --[[ Line: 84 ]] --[[ Name: Stop ]]
    -- upvalues: v15 (ref), v14 (copy), l_CanvasGroup_0 (copy), v13 (copy), l_TweenService_0 (copy), l_HasSeenUpdate_0 (copy), l_Update_0 (copy), l_Parent_0 (copy)
    if v15 then
        v15:Disconnect();
        v15 = nil;
    end;
    for _, v37 in ipairs(v14) do
        v37.Instance.Position = UDim2.new(v37.Instance.Position.X.Scale, v37.Instance.Position.X.Offset, 0.5, 0);
    end;
    local v38 = l_CanvasGroup_0:FindFirstChildWhichIsA("UIScale") or Instance.new("UIScale", l_CanvasGroup_0);
    local v39 = TweenInfo.new(v13.EXIT_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    local v40 = l_TweenService_0:Create(l_CanvasGroup_0, v39, {
        GroupTransparency = 1
    });
    local v41 = l_TweenService_0:Create(v38, v39, {
        Scale = 1.5
    });
    v40:Play();
    v41:Play();
    v40.Completed:Once(function() --[[ Line: 109 ]]
        -- upvalues: l_CanvasGroup_0 (ref), l_HasSeenUpdate_0 (ref), l_Update_0 (ref), l_Parent_0 (ref)
        l_CanvasGroup_0.Visible = false;
        local v42 = true;
        if not pcall(function() --[[ Line: 115 ]]
            -- upvalues: v42 (ref), l_HasSeenUpdate_0 (ref)
            v42 = l_HasSeenUpdate_0:InvokeServer();
        end) then
            warn("Failed to check update \226\134\146 showing anyway");
            v42 = false;
        end;
        if not v42 then
            print("SHOWING UPDATE UI");
            l_Update_0.Visible = true;
        else
            print("ALREADY SEEN UPDATE");
            l_Parent_0.Enabled = false;
            task.defer(function() --[[ Line: 131 ]]
                -- upvalues: l_Parent_0 (ref)
                if l_Parent_0 then
                    l_Parent_0:Destroy();
                end;
            end);
        end;
    end);
end;
l_CloseButton_0.MouseButton1Click:Connect(function() --[[ Line: 141 ]]
    -- upvalues: l_SaveSeenUpdate_0 (copy), l_Update_0 (copy), l_Parent_0 (copy)
    l_SaveSeenUpdate_0:FireServer();
    l_Update_0.Visible = false;
    l_Parent_0.Enabled = false;
    task.defer(function() --[[ Line: 148 ]]
        -- upvalues: l_Parent_0 (ref)
        if l_Parent_0 then
            l_Parent_0:Destroy();
        end;
    end);
end);
task.spawn(function() --[[ Line: 156 ]]
    -- upvalues: l_ContentProvider_0 (copy)
    pcall(function() --[[ Line: 157 ]]
        -- upvalues: l_ContentProvider_0 (ref)
        l_ContentProvider_0:PreloadAsync({
            "rbxassetid://112617528948143"
        });
    end);
end);
v25();
l_CanvasGroup_0.Visible = true;
local v44 = os.clock();
v15 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 67 ]]
    -- upvalues: v44 (copy), v14 (copy), v13 (copy)
    local v45 = os.clock() - v44;
    for v46, v47 in ipairs(v14) do
        local l_Instance_1 = v47.Instance;
        local l_Scale_1 = v47.Scale;
        local v50 = math.sin(v45 * v13.BOUNCE_SPEED - v46 * v13.WAVE_DELAY);
        l_Instance_1.Position = UDim2.new(l_Instance_1.Position.X.Scale, l_Instance_1.Position.X.Offset, 0.5, v50 * v13.BOUNCE_HEIGHT);
        local l_MIN_SCALE_1 = v13.MIN_SCALE;
        local l_MAX_SCALE_1 = v13.MAX_SCALE;
        l_Scale_1.Scale = l_MIN_SCALE_1 + (v50 - -1) * (l_MAX_SCALE_1 - l_MIN_SCALE_1) / 2;
        l_Instance_1.BackgroundTransparency = 0.6 + (v50 - -1) * -0.6 / 2;
    end;
end);
task.delay(6.5, v43);