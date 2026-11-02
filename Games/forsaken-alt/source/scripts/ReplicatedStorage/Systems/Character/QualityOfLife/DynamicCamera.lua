-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
v0.Start = function(_) --[[ Line: 7 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), l_RunService_0 (copy), l_UserInputService_0 (copy)
    task.spawn(function() --[[ Line: 8 ]]
        -- upvalues: v0 (ref), l_RunService_0 (ref), l_UserInputService_0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local _ = l_LocalPlayer_0:WaitForChild("PlayerData");
        local l_DynamicCamSway_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.DynamicCamSway;
        local l_Camera_0 = workspace.Camera;
        local v8 = Vector2.new(0, 0);
        local v9 = 0;
        local function _(v10, v11, v12) --[[ Line: 28 ]] --[[ Name: lerp ]]
            return v10 + (v11 - v10) * v12;
        end;
        local function _(v14, v15) --[[ Line: 33 ]] --[[ Name: smoothMouseDelta ]]
            -- upvalues: v8 (ref)
            v8 = v8:Lerp(v14, v15);
            return v8;
        end;
        v0.Connection = l_RunService_0.RenderStepped:Connect(function(v17) --[[ Line: 39 ]]
            -- upvalues: l_DynamicCamSway_0 (copy), l_UserInputService_0 (ref), v8 (ref), v9 (ref), l_Camera_0 (copy)
            local v18 = math.clamp(math.rad(l_DynamicCamSway_0.Value), 0, 1e999);
            local l_l_UserInputService_0_MouseDelta_0 = l_UserInputService_0:GetMouseDelta();
            v8 = v8:Lerp(l_l_UserInputService_0_MouseDelta_0, 0.5);
            local l_v8_0 = v8;
            local v21 = math.clamp(l_v8_0.Magnitude / 20, 0, v18);
            local l_v9_0 = v9;
            local v23 = l_v8_0.X > 0 and v21 or -v21;
            local v24 = 3 * v17;
            v9 = l_v9_0 + (v23 - l_v9_0) * v24;
            l_Camera_0.CFrame = l_Camera_0.CFrame * CFrame.Angles(0, 0, v9);
        end);
    end);
end;
v0.Destroy = function(_) --[[ Line: 54 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    if v0.Connection then
        v0.Connection:Disconnect();
        v0.Connection = nil;
    end;
end;
return v0;