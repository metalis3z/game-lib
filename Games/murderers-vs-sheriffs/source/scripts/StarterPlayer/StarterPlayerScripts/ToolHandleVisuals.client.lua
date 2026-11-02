-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_CollectionService_0 = game:GetService("CollectionService");
local v1 = {};
local function v16(v2) --[[ Line: 6 ]] --[[ Name: onInstanceAdded ]]
    -- upvalues: v1 (copy)
    local v3 = v2:WaitForChild("Handle", 5);
    if not v3 then
        return;
    else
        v3:WaitForChild("Mesh", 5);
        local v4 = v3:Clone();
        if not script:FindFirstAncestorWhichIsA("Player") then
            local _ = game:GetService("Players"):GetPlayerFromCharacter(v2.Parent);
        end;
        local l_RigidConstraint_0 = Instance.new("RigidConstraint");
        l_RigidConstraint_0.Name = "VisualConstraint";
        l_RigidConstraint_0.Parent = v4;
        local l_Attachment_0 = Instance.new("Attachment");
        l_Attachment_0.Parent = v3;
        local l_Attachment_1 = Instance.new("Attachment");
        l_Attachment_1.Parent = v4;
        l_RigidConstraint_0.Attachment0 = l_Attachment_0;
        l_RigidConstraint_0.Attachment1 = l_Attachment_1;
        v3.LocalTransparencyModifier = 1;
        v3:GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 31 ]]
            -- upvalues: v4 (copy), v3 (copy)
            v4.Transparency = v3.Transparency;
        end);
        v4.CanCollide = false;
        v4.CanQuery = false;
        v4.CanTouch = false;
        v4.Parent = script;
        for _, v10 in v3:GetChildren() do
            if v10:IsA("ParticleEmitter") then
                v10:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 42 ]]
                    -- upvalues: v4 (copy), v10 (copy)
                    v4[v10.Name].Enabled = v10.Enabled;
                end);
            end;
        end;
        for _, v12 in v3:GetDescendants() do
            if v12:IsA("Decal") then
                v12.Transparency = 1;
            end;
        end;
        local function _() --[[ Line: 54 ]] --[[ Name: onToolEquipped ]]
            -- upvalues: v4 (copy)
            if not v4.Parent then
                return;
            else
                v4.Parent = workspace;
                return;
            end;
        end;
        local function _() --[[ Line: 61 ]] --[[ Name: onToolUnequipped ]]
            -- upvalues: v4 (copy)
            if not v4.Parent then
                return;
            else
                v4.Parent = script;
                return;
            end;
        end;
        v1[v2] = v4;
        local v15 = nil;
        v15 = v2.AncestryChanged:Connect(function() --[[ Line: 70 ]]
            -- upvalues: v2 (copy), v15 (ref), v4 (copy)
            if not v2.Parent then
                v15:Disconnect();
                return;
            elseif v2.Parent:IsA("Model") then
                if not v4.Parent then
                    return;
                else
                    v4.Parent = workspace;
                    return;
                end;
            elseif not v4.Parent then
                return;
            else
                v4.Parent = script;
                return;
            end;
        end);
        return;
    end;
end;
local function v18(v17) --[[ Line: 83 ]] --[[ Name: onInstanceRemoved ]]
    -- upvalues: v1 (copy)
    if v1[v17] then
        v1[v17]:Destroy();
        v1[v17] = nil;
    end;
end;
(function() --[[ Line: 90 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_CollectionService_0 (copy), v16 (copy), v18 (copy)
    for _, v20 in l_CollectionService_0:GetTagged("GlowTool") do
        v16(v20);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("GlowTool"):Connect(v16);
    l_CollectionService_0:GetInstanceRemovedSignal("GlowTool"):Connect(v18);
end)();