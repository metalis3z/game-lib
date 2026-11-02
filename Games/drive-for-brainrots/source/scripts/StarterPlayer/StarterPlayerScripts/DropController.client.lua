-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- decompilation:
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Workspace_0 = game:GetService("Workspace");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_RequestDropItem_0 = l_ReplicatedStorage_0:WaitForChild("Events"):WaitForChild("RequestDropItem");
local l_Zones_0 = l_Workspace_0:WaitForChild("Zones");
local l_Drop_0 = l_PlayerGui_0:WaitForChild("GUI"):WaitForChild("HUD"):WaitForChild("Drop");
print("[DropController] Loaded (Smart Visibility Active)");
local function v14(v9) --[[ Line: 25 ]] --[[ Name: isInsideAnyZone ]]
    -- upvalues: l_Zones_0 (copy)
    for _, v11 in ipairs(l_Zones_0:GetChildren()) do
        if v11:IsA("BasePart") then
            local v12 = v11.CFrame:PointToObjectSpace(v9);
            local l_Size_0 = v11.Size;
            if math.abs(v12.X) <= l_Size_0.X / 2 and math.abs(v12.Y) <= l_Size_0.Y / 2 and math.abs(v12.Z) <= l_Size_0.Z / 2 then
                return true;
            end;
        end;
    end;
    return false;
end;
l_Drop_0.MouseButton1Click:Connect(function() --[[ Line: 41 ]]
    -- upvalues: l_Drop_0 (copy), l_LocalPlayer_0 (copy), l_RequestDropItem_0 (copy)
    if l_Drop_0.Visible and not l_LocalPlayer_0:GetAttribute("IsBeingEaten") then
        l_RequestDropItem_0:FireServer();
    end;
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 48 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Drop_0 (copy), v14 (copy)
    if l_LocalPlayer_0:GetAttribute("IsBeingEaten") then
        if l_Drop_0.Visible then
            l_Drop_0.Visible = false;
        end;
        return;
    else
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            l_Drop_0.Visible = false;
            return;
        else
            local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
            if not l_HumanoidRootPart_0 then
                l_Drop_0.Visible = false;
                return;
            else
                local v17 = v14(l_HumanoidRootPart_0.Position);
                local v18 = l_Character_0:FindFirstChild("StackItem") ~= nil;
                if v17 and v18 then
                    if not l_Drop_0.Visible then
                        l_Drop_0.Visible = true;
                        return;
                    end;
                elseif l_Drop_0.Visible then
                    l_Drop_0.Visible = false;
                end;
                return;
            end;
        end;
    end;
end);
