-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = {};
local function v8(v3) --[[ Line: 11 ]] --[[ Name: onThrowingKnifeAdded ]]
    -- upvalues: v2 (copy)
    local l_Value_0 = v3:WaitForChild("HandleLink").Value;
    if not l_Value_0 then
        return;
    else
        local l_BladePosition_0 = v3:WaitForChild("BladePosition");
        local v6 = l_Value_0:Clone();
        v6.CFrame = l_BladePosition_0.CFrame;
        local l_VH_0 = v6:FindFirstChild("VH");
        if l_VH_0 then
            v6.Transparency = 1;
            l_VH_0.Transparency = 0;
            l_VH_0:SetAttribute("VisualHandle", true);
        else
            v6.Transparency = 0;
        end;
        v6:SetAttribute("Direction", v3:GetAttribute("Direction"));
        v6.Anchored = true;
        v6.Name = "KnifeVisual";
        v6.Parent = v3;
        v2[v6] = true;
        return;
    end;
end;
l_RunService_0.PreSimulation:Connect(function(v9) --[[ Line: 40 ]] --[[ Name: onUpdate ]]
    -- upvalues: v2 (copy)
    for v10, _ in v2 do
        if v10.Parent == nil then
            v2[v10] = nil;
        else
            local l_CFrame_0 = v10.CFrame;
            local l_v10_Attribute_0 = v10:GetAttribute("Direction");
            local v14 = v9 * -12.566370614359172;
            v10.CFrame = l_CFrame_0 * CFrame.Angles(v14, 0, 0) + l_v10_Attribute_0 * 96 * v9;
        end;
    end;
end);
l_CollectionService_0:GetInstanceAddedSignal("ThrowingKnife"):Connect(v8);