-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_PoseProps_0 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("PoseProps");
local v5 = {
    Clear = function(v1) --[[ Line: 9 ]] --[[ Name: Clear ]]
        local l_ActivePoseProps_0 = v1:FindFirstChild("ActivePoseProps");
        if l_ActivePoseProps_0 then
            l_ActivePoseProps_0:Destroy();
        end;
        for _, v4 in ipairs(v1:GetDescendants()) do
            if v4:GetAttribute("PoseProp") == true then
                v4:Destroy();
            end;
        end;
    end
};
v5.AttachStoredProp = function(v6, v7) --[[ Line: 22 ]] --[[ Name: AttachStoredProp ]]
    -- upvalues: l_PoseProps_0 (copy), v5 (copy)
    if not v6 then
        return false;
    else
        local l_l_PoseProps_0_FirstChild_0 = l_PoseProps_0:FindFirstChild(v7);
        if not l_l_PoseProps_0_FirstChild_0 then
            warn("[PosePropUtil] Missing prop folder:", v7);
            return false;
        else
            local v9 = l_l_PoseProps_0_FirstChild_0:GetAttribute("AttachPartName") or "Torso";
            local l_v6_FirstChild_0 = v6:FindFirstChild(v9, true);
            if not l_v6_FirstChild_0 or not l_v6_FirstChild_0:IsA("BasePart") then
                warn("[PosePropUtil] Missing attach part:", v9);
                return false;
            else
                local l_l_l_PoseProps_0_FirstChild_0_FirstChild_0 = l_l_PoseProps_0_FirstChild_0:FindFirstChild("Cube", true);
                local l_l_l_PoseProps_0_FirstChild_0_FirstChildWhichIsA_0 = l_l_PoseProps_0_FirstChild_0:FindFirstChildWhichIsA("Motor6D", true);
                if not l_l_l_PoseProps_0_FirstChild_0_FirstChild_0 or not l_l_l_PoseProps_0_FirstChild_0_FirstChild_0:IsA("BasePart") then
                    warn("[PosePropUtil] Missing Cube in prop:", v7);
                    return false;
                elseif not l_l_l_PoseProps_0_FirstChild_0_FirstChildWhichIsA_0 then
                    warn("[PosePropUtil] Missing Motor6D in prop:", v7);
                    return false;
                else
                    v5.Clear(v6);
                    local l_Folder_0 = Instance.new("Folder");
                    l_Folder_0.Name = "ActivePoseProps";
                    l_Folder_0.Parent = v6;
                    local v14 = l_l_l_PoseProps_0_FirstChild_0_FirstChild_0:Clone();
                    v14.Parent = l_Folder_0;
                    v14.Anchored = false;
                    v14.CanCollide = false;
                    v14.CanTouch = false;
                    v14.CanQuery = false;
                    v14.Massless = true;
                    v14:SetAttribute("PoseProp", true);
                    local v15 = l_l_l_PoseProps_0_FirstChild_0_FirstChildWhichIsA_0:Clone();
                    v15.Part0 = l_v6_FirstChild_0;
                    v15.Part1 = v14;
                    v15.Parent = l_v6_FirstChild_0;
                    v15:SetAttribute("PoseProp", true);
                    return true;
                end;
            end;
        end;
    end;
end;
return v5;