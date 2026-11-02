-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = {};
local function v13(v3) --[[ Line: 10 ]] --[[ Name: onThrowingKnifeAdded ]]
    -- upvalues: v2 (copy)
    local v4 = v3:WaitForChild("HandleLink", 5);
    if not v4 then
        return;
    else
        local l_Value_0 = v4.Value;
        if not l_Value_0 then
            return;
        else
            local v6 = v3:WaitForChild("BladePosition", 5);
            if not v6 then
                return;
            else
                local v7 = l_Value_0:Clone();
                v7.CFrame = v6.CFrame;
                local l_VH_0 = v7:FindFirstChild("VH");
                if l_VH_0 then
                    v7.Transparency = 1;
                    l_VH_0.Transparency = 0;
                    l_VH_0:SetAttribute("VisualHandle", true);
                else
                    v7.Transparency = 0;
                end;
                v7:SetAttribute("Direction", v3:GetAttribute("Direction"));
                v7:SetAttribute("ThrowSpeed", v3:GetAttribute("ThrowSpeed"));
                v7.Anchored = true;
                v7.Name = "KnifeVisual";
                local l_Part_0 = Instance.new("Part");
                l_Part_0.Name = "TrailPart";
                l_Part_0.Size = Vector3.new(1, 1, 1, 0);
                l_Part_0.Transparency = 1;
                l_Part_0.Anchored = true;
                l_Part_0.CanCollide = false;
                l_Part_0.CanQuery = false;
                local v10 = script:WaitForChild("Bottom"):Clone();
                local v11 = script:WaitForChild("Top"):Clone();
                local v12 = script:WaitForChild("Trail"):Clone();
                v12.Attachment0 = v11;
                v12.Attachment1 = v10;
                v10.Parent = l_Part_0;
                v11.Parent = l_Part_0;
                v12.Parent = l_Part_0;
                l_Part_0.Parent = workspace;
                game.Debris:AddItem(l_Part_0, 10);
                v7.Parent = v3;
                v3.Destroying:Connect(function() --[[ Line: 64 ]]
                    -- upvalues: v2 (ref), v7 (copy), l_Part_0 (copy)
                    v2[v7] = nil;
                    game.Debris:AddItem(l_Part_0, 1);
                end);
                v2[v7] = l_Part_0;
                return;
            end;
        end;
    end;
end;
l_RunService_0.PreSimulation:Connect(function(v14) --[[ Line: 73 ]] --[[ Name: onUpdate ]]
    -- upvalues: v2 (copy)
    for v15, v16 in v2 do
        if v15.Parent == nil then
            v2[v15] = nil;
        else
            local l_CFrame_0 = v15.CFrame;
            local l_v15_Attribute_0 = v15:GetAttribute("Direction");
            local v19 = v15:GetAttribute("ThrowSpeed") or 96;
            local v20 = v14 * -12.566370614359172;
            local v21 = l_CFrame_0 * CFrame.Angles(v20, 0, 0) + l_v15_Attribute_0 * v19 * v14;
            v15.CFrame = v21;
            v16.CFrame = CFrame.new(v21.Position, v21.Position + l_v15_Attribute_0);
        end;
    end;
end);
l_CollectionService_0:GetInstanceAddedSignal("ThrowingKnife"):Connect(v13);