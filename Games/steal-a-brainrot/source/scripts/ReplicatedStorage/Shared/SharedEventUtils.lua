-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v2 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local _ = require(l_ReplicatedStorage_0.Packages.Trove);
local v4 = 0;
local v5 = {};
local v6 = {};
local v7 = CFrame.new(-410.752, -9.782, 59.406):Inverse();
@native
local function v10(v8, v9) --[[ Line: 17 ]] --[[ Name: pushPartCFrame ]]
    -- upvalues: v4 (ref), v5 (copy), v6 (copy)
    v4 = v4 + 1;
    v5[v4] = v8;
    v6[v4] = v9;
end;
@native
local function v12(v11) --[[ Line: 23 ]] --[[ Name: isPointInCarpet ]]
    -- upvalues: v2 (copy), v7 (copy)
    return v2.isPointInVolume_direct(v11, v7, (Vector3.new(20, 661.5, 401, 0)));
end;
@native
local function v13() --[[ Line: 27 ]] --[[ Name: stepParts ]]
    -- upvalues: v5 (copy), v6 (copy), v4 (ref)
    debug.profilebegin("SharedEventUtils:StepParts");
    workspace:BulkMoveTo(v5, v6, Enum.BulkMoveMode.FireCFrameChanged);
    v4 = 0;
    table.clear(v5);
    table.clear(v6);
    debug.profileend();
end;
local function v19(v14, v15, v16) --[[ Line: 36 ]] --[[ Name: loadAnimation ]]
    local v17 = v15:LoadAnimation(v16);
    local function v18() --[[ Line: 39 ]] --[[ Name: cleanup ]]
        -- upvalues: v17 (copy)
        v17:Stop(0);
        v17:Destroy();
    end;
    v14:Add(v18);
    return v17, function() --[[ Line: 45 ]]
        -- upvalues: v14 (copy), v18 (copy)
        v14:Remove(v18);
    end;
end;
if l_RunService_0:IsServer() then
    l_RunService_0.PostSimulation:Connect(v13);
else
    l_RunService_0.PreRender:Connect(v13);
end;
return {
    pushPartCFrame = v10, 
    isPointInCarpet = v12, 
    loadAnimation = v19
};