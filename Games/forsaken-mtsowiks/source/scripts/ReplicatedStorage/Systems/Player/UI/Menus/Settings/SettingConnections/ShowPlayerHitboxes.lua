-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Connections = {}
};
local function v4(v1, v2) --[[ Line: 5 ]] --[[ Name: toggleHitbox ]]
    -- upvalues: v0 (copy)
    if (v1.Name == "CollisionHitbox" or v1.Name == "QueryHitbox") and v1:IsA("BasePart") then
        v1.Transparency = v2;
        local v3 = v1.Parent:IsA("Model") and v1.Parent:FindFirstChild("Torso");
        if v3 and v0.Connections then
            table.insert(v0.Connections, v3:GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 11 ]]
                -- upvalues: v3 (copy), v1 (copy), v2 (copy)
                if v3.Transparency > 0.5 then
                    v1.Transparency = 1;
                    return;
                else
                    v1.Transparency = v2;
                    return;
                end;
            end));
        end;
    end;
end;
v0.Updated = function(v5, v6) --[[ Line: 22 ]] --[[ Name: Updated ]]
    -- upvalues: v4 (copy)
    if v6 then
        for _, v8 in pairs(workspace:GetDescendants()) do
            v4(v8, 0.6);
        end;
        if not v5.Connection then
            v5.Connection = workspace.DescendantAdded:Connect(function(v9) --[[ Line: 27 ]]
                -- upvalues: v4 (ref)
                v4(v9, 0.6);
            end);
            return;
        end;
    else
        for _, v11 in pairs(workspace:GetDescendants()) do
            v4(v11, 1);
        end;
        if v5.Connection then
            v5.Connection:Disconnect();
            v5.Connection = nil;
        end;
        if v5.Connections then
            for _, v13 in pairs(v5.Connections) do
                v13:Disconnect();
            end;
            table.clear(v5.Connections);
        end;
    end;
end;
return v0;