-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Parent_0 = script.Parent;
local v3 = l_Parent_0:WaitForChild("Door.R");
local v4 = l_Parent_0:WaitForChild("Door.L");
local l_Hitbox_0 = l_Parent_0:WaitForChild("Hitbox");
local v6 = {};
local v7 = 0;
local function v13(v8, v9, v10) --[[ Line: 18 ]] --[[ Name: TweenDoors ]]
    -- upvalues: v6 (copy), l_TweenService_0 (copy)
    if v6[v8] then
        v6[v8]:Destroy();
        v6[v8] = nil;
    end;
    local l_CFrameValue_0 = Instance.new("CFrameValue");
    v6[v8] = l_CFrameValue_0;
    l_CFrameValue_0.Value = v8:GetPivot();
    l_CFrameValue_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 26 ]]
        -- upvalues: v8 (copy), l_CFrameValue_0 (copy)
        v8:PivotTo(l_CFrameValue_0.Value);
    end);
    local v12 = l_TweenService_0:Create(l_CFrameValue_0, TweenInfo.new(v10, Enum.EasingStyle.Linear), {
        Value = v9
    });
    v12.Completed:Connect(function() --[[ Line: 30 ]]
        -- upvalues: v6 (ref), v8 (copy), l_CFrameValue_0 (copy)
        if v6[v8] == l_CFrameValue_0 then
            v6[v8] = nil;
        end;
        l_CFrameValue_0:Destroy();
    end);
    v12:Play();
end;
local function v15() --[[ Line: 39 ]] --[[ Name: OpenSound ]]
    -- upvalues: l_Hitbox_0 (copy)
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundId = "rbxassetid://123655096558549";
    l_Sound_0.Parent = l_Hitbox_0;
    l_Sound_0.Volume = 0.5;
    l_Sound_0:Play();
    l_Sound_0.Ended:Connect(function() --[[ Line: 45 ]]
        -- upvalues: l_Sound_0 (copy)
        l_Sound_0:Destroy();
    end);
end;
local l_v3_Pivot_0 = v3:GetPivot();
local l_v4_Pivot_0 = v4:GetPivot();
local v18 = l_v3_Pivot_0 * CFrame.new(6.5, 0, 0);
local v19 = l_v4_Pivot_0 * CFrame.new(-6.5, 0, 0);
local function _() --[[ Line: 53 ]] --[[ Name: OpenDoors ]]
    -- upvalues: v15 (copy), v13 (copy), v3 (copy), v18 (copy), v4 (copy), v19 (copy)
    if not DoorOpen then
        v15();
        DoorOpen = true;
    end;
    v13(v3, v18, 0.35);
    v13(v4, v19, 0.35);
end;
local function _() --[[ Line: 62 ]] --[[ Name: CloseDoors ]]
    -- upvalues: v13 (copy), v3 (copy), l_v3_Pivot_0 (copy), v4 (copy), l_v4_Pivot_0 (copy)
    DoorOpen = false;
    v13(v3, l_v3_Pivot_0, 0.35);
    v13(v4, l_v4_Pivot_0, 0.35);
end;
l_Hitbox_0.Touched:Connect(function() --[[ Line: 68 ]]
    -- upvalues: v7 (ref), v15 (copy), v13 (copy), v3 (copy), v18 (copy), v4 (copy), v19 (copy)
    v7 = os.clock() + 2;
    if not DoorOpen then
        v15();
        DoorOpen = true;
    end;
    v13(v3, v18, 0.35);
    v13(v4, v19, 0.35);
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 73 ]]
    -- upvalues: v7 (ref), v13 (copy), v3 (copy), l_v3_Pivot_0 (copy), v4 (copy), l_v4_Pivot_0 (copy)
    if DoorOpen and os.clock() >= v7 then
        DoorOpen = false;
        v13(v3, l_v3_Pivot_0, 0.35);
        v13(v4, l_v4_Pivot_0, 0.35);
    end;
end);
l_Hitbox_0.CanTouch = true;
l_Hitbox_0.CanCollide = false;