-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    TransparentParts = {}
};
v0.GetMousePos = function(_, v2) --[[ Line: 6 ]] --[[ Name: GetMousePos ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
    local l_Character_0 = l_LocalPlayer_0.Character;
    local v7 = require(game.ReplicatedStorage.Modules.Device);
    local v8 = require(game.ReplicatedStorage.Systems.Player.Game.SmoothShiftLock);
    local v9 = l_Character_0 and l_Character_0:FindFirstChild("Head") and l_Character_0.Head.LocalTransparencyModifier >= 0.5;
    if v8.Enabled or v9 then
        if v7:GetPlayerDevice() == "Mobile" then
            return (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -250)).Position;
        else
            local v10 = l_CurrentCamera_0:ScreenPointToRay(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
            return v10.Origin + v10.Direction * 500;
        end;
    elseif v2 then
        local v11 = require(game.ReplicatedStorage.Modules.Util);
        local l_v11_ClosestPlayerFromPosition_0 = v11:GetClosestPlayerFromPosition(l_Character_0 and l_Character_0.PrimaryPart and l_Character_0.PrimaryPart.Position or Vector3.new(), {
            PlayerSelection = "Survivors", 
            ReturnTable = true
        });
        for _, v14 in pairs(l_v11_ClosestPlayerFromPosition_0) do
            local l_Player_0 = v14.Player;
            local l_Distance_0 = v14.Distance;
            if v11:IsOnScreen(l_Player_0) and l_Distance_0 then
                local l_Position_0 = l_Player_0.PrimaryPart.Position;
                local l_AssemblyLinearVelocity_0 = l_Player_0.PrimaryPart.AssemblyLinearVelocity;
                if l_AssemblyLinearVelocity_0.Magnitude == 0 then
                    return l_Position_0;
                else
                    return l_Position_0 + l_AssemblyLinearVelocity_0 * (l_Distance_0 / 50);
                end;
            end;
        end;
        return (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -500)).Position;
    else
        local v19 = nil;
        local v20 = nil;
        if v7:GetPlayerDevice() == "Mobile" then
            v19 = workspace.CurrentCamera.CFrame.Position;
            v20 = workspace.CurrentCamera.CFrame.LookVector * 500;
        else
            local v21 = l_CurrentCamera_0:ScreenPointToRay(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
            v19 = v21.Origin;
            v20 = v21.Direction * 500;
        end;
        local v22 = {};
        for v23, _ in pairs(v0.TransparentParts) do
            table.insert(v22, v23);
        end;
        local v25 = RaycastParams.new();
        v25.FilterType = Enum.RaycastFilterType.Exclude;
        v25.FilterDescendantsInstances = v22;
        v25.IgnoreWater = true;
        local v26 = workspace:Raycast(v19, v20, v25);
        if v26 then
            return v26.Position;
        else
            return v19 + v20;
        end;
    end;
end;
v0.Start = function(_) --[[ Line: 90 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local function v29(v28) --[[ Line: 92 ]] --[[ Name: addToRegistry ]]
        -- upvalues: v0 (ref)
        if v28:IsA("BasePart") and (v28.Transparency >= 0.75 or v28.Parent == workspace.Hitboxes) then
            v0.TransparentParts[v28] = true;
        end;
    end;
    task.spawn(function() --[[ Line: 98 ]]
        -- upvalues: v0 (ref), v29 (copy)
        for _, v31 in pairs(workspace:GetDescendants()) do
            if v31:IsA("BasePart") and (v31.Transparency >= 0.75 or v31.Parent == workspace.Hitboxes) then
                v0.TransparentParts[v31] = true;
            end;
        end;
        workspace.DescendantAdded:Connect(v29);
        workspace.DescendantRemoving:Connect(function(v32) --[[ Line: 101 ]]
            -- upvalues: v0 (ref)
            if v0.TransparentParts[v32] then
                v0.TransparentParts[v32] = nil;
            end;
        end);
    end);
    require(game.ReplicatedStorage.Modules.Network):SetConnection("GetMousePosition", "REMOTE_FUNCTION", function(v33) --[[ Line: 110 ]]
        -- upvalues: v0 (ref)
        return v0:GetMousePos(v33);
    end);
end;
return v0;