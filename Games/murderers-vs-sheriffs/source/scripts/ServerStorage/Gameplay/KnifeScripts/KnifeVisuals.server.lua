-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Oracle

local l_Parent_0 = script.Parent;
(function() --[[ Line: 4 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_Parent_0 (copy)
    local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("EquippedPerk");
    while not l_l_Parent_0_Attribute_0 do
        l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("EquippedPerk");
        task.wait();
    end;
    local l_HasteTrail_0 = script:WaitForChild("HasteTrail");
    local v3 = l_Parent_0:FindFirstAncestorOfClass("Model") or l_Parent_0:FindFirstAncestorOfClass("Player").Character;
    l_HasteTrail_0.Parent = v3:WaitForChild("UpperTorso");
    l_HasteTrail_0.Attachment0 = v3:WaitForChild("UpperTorso"):WaitForChild("NeckAttachment");
    l_HasteTrail_0.Attachment1 = v3:WaitForChild("UpperTorso"):WaitForChild("WaistRigAttachment");
    l_Parent_0.Equipped:Connect(function() --[[ Line: 18 ]]
        -- upvalues: l_l_Parent_0_Attribute_0 (ref), l_HasteTrail_0 (copy)
        if l_l_Parent_0_Attribute_0 == "Haste" then
            l_HasteTrail_0.Enabled = true;
        end;
    end);
    l_Parent_0.Unequipped:Connect(function() --[[ Line: 24 ]]
        -- upvalues: l_HasteTrail_0 (copy)
        l_HasteTrail_0.Enabled = false;
    end);
end)();