-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = false;
local function v2() --[[ Line: 6 ]]

end;
local v3 = {};
local function v8(v4) --[[ Line: 10 ]] --[[ Name: cylinderVisualizer ]]
    -- upvalues: v1 (ref), v2 (copy), l_RunService_0 (copy)
    if not v1 then
        return v2;
    else
        local l_CylinderHandleAdornment_0 = Instance.new("CylinderHandleAdornment");
        l_CylinderHandleAdornment_0.Adornee = workspace.Terrain;
        l_CylinderHandleAdornment_0.Color3 = v4;
        l_CylinderHandleAdornment_0.Transparency = l_RunService_0:IsClient() and 0.7 or 0.4;
        l_CylinderHandleAdornment_0.Parent = workspace.Terrain;
        return function(v6, v7) --[[ Line: 19 ]]
            -- upvalues: l_CylinderHandleAdornment_0 (copy)
            if v6 == nil then
                l_CylinderHandleAdornment_0:Destroy();
                return;
            else
                l_CylinderHandleAdornment_0.CFrame = CFrame.new(v6) * CFrame.Angles(1.5707963267948966, 0, 0);
                l_CylinderHandleAdornment_0.Radius = v7;
                return;
            end;
        end;
    end;
end;
local function v13(v9) --[[ Line: 30 ]] --[[ Name: tsunamiVisualizer ]]
    -- upvalues: v1 (ref), v2 (copy), l_RunService_0 (copy)
    if not v1 then
        return v2;
    else
        local l_BoxHandleAdornment_0 = Instance.new("BoxHandleAdornment");
        l_BoxHandleAdornment_0.Adornee = workspace.Terrain;
        l_BoxHandleAdornment_0.Color3 = v9;
        l_BoxHandleAdornment_0.Transparency = l_RunService_0:IsClient() and 0.7 or 0.4;
        l_BoxHandleAdornment_0.Parent = workspace.Terrain;
        return function(v11, v12) --[[ Line: 39 ]]
            -- upvalues: l_BoxHandleAdornment_0 (copy)
            if v11 == nil then
                l_BoxHandleAdornment_0:Destroy();
                return;
            else
                l_BoxHandleAdornment_0.CFrame = v11;
                l_BoxHandleAdornment_0.Size = v12;
                return;
            end;
        end;
    end;
end;
local v14 = {};
v3.drawHitbox = function(v15) --[[ Line: 52 ]] --[[ Name: drawHitbox ]]
    -- upvalues: v1 (ref), v8 (copy), v14 (copy)
    if v1 then
        local v16 = v8(Color3.fromRGB(55, 255, 0));
        v16(v15, 5);
        table.insert(v14, function() --[[ Line: 56 ]]
            -- upvalues: v16 (copy)
            v16(nil);
        end);
    end;
end;
v3.drawTsunami = function(v17, v18) --[[ Line: 62 ]] --[[ Name: drawTsunami ]]
    -- upvalues: v1 (ref), v13 (copy), v14 (copy)
    if v1 then
        local v19 = v13(Color3.fromRGB(255, 0, 0));
        v19(v17, v18);
        table.insert(v14, function() --[[ Line: 66 ]]
            -- upvalues: v19 (copy)
            v19(nil);
        end);
    end;
end;
v3.drawTsunamiMutationArea = function(v20, v21, v22) --[[ Line: 72 ]] --[[ Name: drawTsunamiMutationArea ]]
    -- upvalues: v1 (ref), v13 (copy)
    if v1 then
        local v23 = v13(Color3.fromRGB(255, 247, 0));
        v23(v20, v21);
        task.delay(v22, function() --[[ Line: 76 ]]
            -- upvalues: v23 (copy)
            v23(nil);
        end);
    end;
end;
v3.clear = function() --[[ Line: 82 ]] --[[ Name: clear ]]
    -- upvalues: v14 (copy)
    for _, v25 in v14 do
        v25();
    end;
    table.clear(v14);
end;
v3.getEnabled = function() --[[ Line: 89 ]] --[[ Name: getEnabled ]]
    -- upvalues: v1 (ref)
    return v1;
end;
v3.setEnabled = function(v26) --[[ Line: 93 ]] --[[ Name: setEnabled ]]
    -- upvalues: v1 (ref), l_RunService_0 (copy)
    v1 = v26;
    if l_RunService_0:IsServer() then
        script:SetAttribute("Enabled", v26);
    end;
end;
if l_RunService_0:IsClient() then
    script:GetAttributeChangedSignal("Enabled"):Connect(function() --[[ Line: 101 ]]
        -- upvalues: v3 (copy)
        v3.setEnabled(script:GetAttribute("Enabled"));
    end);
end;
return v3;
