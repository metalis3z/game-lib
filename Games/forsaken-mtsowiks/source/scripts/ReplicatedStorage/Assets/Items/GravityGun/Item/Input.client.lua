-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_Parent_0 = script.Parent;
local l_Reliable_0 = l_Parent_0:WaitForChild("Reliable");
local l_Unreliable_0 = l_Parent_0:WaitForChild("Unreliable");
local v6 = false;
local v7 = nil;
local v8 = RaycastParams.new();
v8.RespectCanCollide = true;
v8.IgnoreWater = true;
local function v12(v9, v10, _) --[[ Line: 16 ]] --[[ Name: processAction ]]
    -- upvalues: v6 (ref), l_Reliable_0 (copy)
    if v6 and v9 == "GG_Secondary" then
        l_Reliable_0:FireServer("Secondary", v10 == Enum.UserInputState.Begin);
    end;
    return Enum.ContextActionResult.Pass;
end;
local function v20() --[[ Line: 24 ]] --[[ Name: updateTarget ]]
    -- upvalues: l_UserInputService_0 (copy), v8 (copy), v7 (ref), l_Unreliable_0 (copy)
    local v13 = assert(workspace.CurrentCamera);
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local v15 = v13:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y, 0);
    local v16 = workspace:Raycast(v15.Origin, v15.Direction * 1000, v8);
    local v17 = nil;
    local v18 = false;
    if v16 then
        v17 = v16.Position;
    end;
    if v17 ~= v7 then
        v7 = v17;
        v18 = true;
    end;
    if v18 then
        local v19 = v17 and CFrame.new(v17, v17 + v15.Direction);
        l_Unreliable_0:FireServer("SetTarget", v19, v16 and v16.Instance);
    end;
end;
local function v21() --[[ Line: 49 ]] --[[ Name: onEquipped ]]
    -- upvalues: l_Parent_0 (copy), v8 (copy), v6 (ref), l_RunService_0 (copy), v20 (copy), l_ContextActionService_0 (copy), v12 (copy)
    v8.FilterDescendantsInstances = {
        l_Parent_0.Parent
    };
    v6 = true;
    targetConn = l_RunService_0.Heartbeat:Connect(v20);
    l_ContextActionService_0:BindAction("GG_Secondary", v12, true, Enum.UserInputType.MouseButton2);
end;
local function v22() --[[ Line: 58 ]] --[[ Name: onUnequipped ]]
    -- upvalues: v6 (ref), l_ContextActionService_0 (copy)
    if v6 then
        v6 = false;
        if targetConn then
            targetConn:Disconnect();
            targetConn = nil;
        end;
        l_ContextActionService_0:UnbindAction("GG_Secondary");
    end;
end;
l_Parent_0.Equipped:Connect(v21);
l_Parent_0.Unequipped:Connect(v22);