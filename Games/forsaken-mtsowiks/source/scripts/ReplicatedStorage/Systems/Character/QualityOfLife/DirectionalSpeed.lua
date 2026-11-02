-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: DirectionalSpeed, time of decompilation: Fri Nov 28 21:12:46 2025 ]]
local v0 = {};
v0.Start = function(_) --[[ Line: 7 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 8 ]]
        -- upvalues: v0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        local l_HumanoidRootPart_0 = l_Character_0:WaitForChild("HumanoidRootPart");
        local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
        local l_SpeedMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(l_LocalPlayer_0, 1, "DirectionalMovement");
        local v7 = {
            Forwards = 1, 
            ForwardsRight = 0.975, 
            Right = 0.925, 
            BackwardsRight = 0.8, 
            Backwards = 0.7, 
            BackwardsLeft = 0.8, 
            Left = 0.925, 
            ForwardsLeft = 0.975
        };
        local function v9() --[[ Line: 35 ]] --[[ Name: UpdateDirectionalMovement ]]
            -- upvalues: l_Humanoid_0 (copy), l_HumanoidRootPart_0 (copy), l_Character_0 (copy), l_SpeedMultiplier_0 (copy), v7 (copy)
            if l_Humanoid_0.WalkSpeed <= 0.1 or l_HumanoidRootPart_0.Anchored or l_Character_0:GetAttribute("DirectionalMovementDisabled") or l_Character_0:GetAttribute("Ragdolling") then
                l_SpeedMultiplier_0.Value = 1;
                return;
            else
                local v8 = l_HumanoidRootPart_0.CFrame:VectorToObjectSpace(l_Humanoid_0.MoveDirection);
                if v8:Dot(Vector3.new(1, 0, -1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.ForwardsRight;
                    return;
                elseif v8:Dot(Vector3.new(1, 0, 1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.BackwardsRight;
                    return;
                elseif v8:Dot(Vector3.new(-1, 0, 1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.BackwardsLeft;
                    return;
                elseif v8:Dot(Vector3.new(-1, 0, -1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.ForwardsLeft;
                    return;
                elseif v8:Dot(Vector3.new(0, 0, -1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.Forwards;
                    return;
                elseif v8:Dot(Vector3.new(1, 0, 0, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.Right;
                    return;
                elseif v8:Dot(Vector3.new(0, 0, 1, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.Backwards;
                    return;
                elseif v8:Dot(Vector3.new(-1, 0, 0, 0).Unit) > 0.95 then
                    l_SpeedMultiplier_0.Value = v7.Left;
                    return;
                else
                    if v8 == Vector3.new(0, 0, 0, 0) then
                        l_SpeedMultiplier_0.Value = 1;
                    end;
                    return;
                end;
            end;
        end;
        v0.Connection = game["Run Service"].RenderStepped:Connect(function(_) --[[ Line: 67 ]]
            -- upvalues: v9 (copy)
            v9();
        end);
    end);
end;
v0.Destroy = function(_) --[[ Line: 73 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.Connection then
        v0.Connection:Disconnect();
        v0.Connection = nil;
    end;
end;
return v0;