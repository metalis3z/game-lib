-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Parent_0 = script.Parent;
local v2 = {
    l_Parent_0:WaitForChild("Arrow1"), 
    l_Parent_0:WaitForChild("Arrow2"), 
    l_Parent_0:WaitForChild("Arrow3")
};
local function v8(v3, v4, v5) --[[ Line: 17 ]] --[[ Name: TweenModel ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_CFrameValue_0 = Instance.new("CFrameValue");
    l_CFrameValue_0.Value = v3:GetPivot();
    l_CFrameValue_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 20 ]]
        -- upvalues: v3 (copy), l_CFrameValue_0 (copy)
        v3:PivotTo(l_CFrameValue_0.Value);
    end);
    local v7 = l_TweenService_0:Create(l_CFrameValue_0, TweenInfo.new(v5, Enum.EasingStyle.Linear), {
        Value = v4
    });
    v7.Completed:Connect(function() --[[ Line: 24 ]]
        -- upvalues: l_CFrameValue_0 (copy)
        l_CFrameValue_0:Destroy();
    end);
    v7:Play();
    v7.Completed:Wait();
end;
while script:IsDescendantOf(workspace) do
    for _, v10 in ipairs(v2) do
        local l_v10_Pivot_0 = v10:GetPivot();
        v8(v10, l_v10_Pivot_0 * CFrame.new(0, -1.5, 0), 0.15);
        v8(v10, l_v10_Pivot_0 * CFrame.new(0, 3, 0), 0.075);
        v8(v10, l_v10_Pivot_0, 0.15);
        task.wait(0.05);
    end;
end;