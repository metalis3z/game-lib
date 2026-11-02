-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

workspace:WaitForChild("Training Areas", 1e999):WaitForChild("Electra Field", 1e999):WaitForChild("AreaHitbox", 1e999);
local l_RunService_0 = game:GetService("RunService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Characters_0 = workspace:WaitForChild("Characters");
local v3 = RaycastParams.new();
v3.FilterType = Enum.RaycastFilterType.Exclude;
v3.IgnoreWater = true;
v3.FilterDescendantsInstances = {
    l_Characters_0, 
    workspace["Training Areas"]
};
local v4 = {};
local v5 = {};
local function v10(v6) --[[ Line: 17 ]] --[[ Name: tryTrack ]]
    -- upvalues: v4 (copy), v5 (copy)
    local l_Head_0 = v6:FindFirstChild("Head");
    if not l_Head_0 then
        return;
    else
        local l_OverheadDisplay_0 = l_Head_0:FindFirstChild("OverheadDisplay");
        if not l_OverheadDisplay_0 then
            return;
        else
            l_OverheadDisplay_0.AlwaysOnTop = true;
            local v9 = {
                head = l_Head_0, 
                gui = l_OverheadDisplay_0
            };
            v4[#v4 + 1] = v9;
            v5[v6] = #v4;
            return;
        end;
    end;
end;
local function v15(v11) --[[ Line: 31 ]] --[[ Name: untrack ]]
    -- upvalues: v5 (copy), v4 (copy)
    local v12 = v5[v11];
    if not v12 then
        return;
    else
        v4[v12] = v4[#v4];
        v4[#v4] = nil;
        for v13, v14 in pairs(v5) do
            if v14 == #v4 + 1 then
                v5[v13] = v12;
                break;
            end;
        end;
        v5[v11] = nil;
        return;
    end;
end;
for _, v17 in ipairs(l_Characters_0:GetChildren()) do
    v10(v17);
end;
l_Characters_0.ChildAdded:Connect(v10);
l_Characters_0.ChildRemoved:Connect(v15);
local v18 = 0;
local v19 = 1;
local function _(v20, v21) --[[ Line: 68 ]] --[[ Name: setEnabled ]]
    if v20.Enabled ~= v21 then
        v20.Enabled = v21;
    end;
end;
l_RunService_0.RenderStepped:Connect(function(v23) --[[ Line: 74 ]]
    -- upvalues: v18 (ref), l_CurrentCamera_0 (copy), v4 (copy), v19 (ref), v3 (copy)
    v18 = v18 + v23;
    if v18 < 0.05 then
        return;
    else
        v18 = v18 - 0.05;
        local l_Position_0 = l_CurrentCamera_0.CFrame.Position;
        local v25 = #v4;
        if v25 == 0 then
            return;
        else
            for _ = 1, math.min(4, v25) do
                if v25 < v19 then
                    v19 = 1;
                end;
                local v27 = v4[v19];
                v19 = v19 + 1;
                local l_head_0 = v27.head;
                local l_gui_0 = v27.gui;
                if l_head_0 and l_gui_0 then
                    local v30 = l_head_0.Position - l_Position_0;
                    if v30.X * v30.X + v30.Y * v30.Y + v30.Z * v30.Z > 90000 then
                        if l_gui_0.Enabled ~= false then
                            l_gui_0.Enabled = false;
                        end;
                    else
                        local v31, v32 = l_CurrentCamera_0:WorldToViewportPoint(l_head_0.Position);
                        if not v32 or v31.Z <= 0 then
                            if l_gui_0.Enabled ~= false then
                                l_gui_0.Enabled = false;
                            end;
                        else
                            local v33 = workspace:Raycast(l_Position_0, v30, v3) == nil;
                            if l_gui_0.Enabled ~= v33 then
                                l_gui_0.Enabled = v33;
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end);