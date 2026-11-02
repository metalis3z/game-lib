-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
local v2 = {};
local l_AAA_0 = script.AAA;
local v6 = require(script.ObjectService);
local v7 = {
    "Right Arm", 
    "Left Arm"
};
local v8 = RaycastParams.new();
v8.FilterType = Enum.RaycastFilterType.Exclude;
v8.FilterDescendantsInstances = {
    workspace.Effects, 
    workspace.Live, 
    workspace.Thrown
};
local function v25(v13, v14) --[[ Line: 39 ]] --[[ Name: Footstep ]]
    local v15 = v14["Right Leg"];
    local v16 = v14["Left Leg"];
    if v2[v14] == nil then
        local v17 = v6.CreateEffect("Attachment", l_AAA_0.Footstep, nil, v15);
        local v18 = v6.CreateEffect("Attachment", l_AAA_0.Footstep, nil, v16);
        v17:Destroy(4);
        v18:Destroy(4);
        v2[v14] = {
            RightFootStepFX = v17, 
            LeftFootStepFX = v18
        };
    end;
    if v13 == "Right" then
        local l_RightFootStepFX_0 = v2[v14].RightFootStepFX;
        local v20 = workspace:Raycast(v14.PrimaryPart.Position, Vector3.new(0, -5, 0, 0), v8);
        local v21;
        if v20 then
            l_RightFootStepFX_0.Color = ColorSequence.new(v20.Instance.Color);
            v21 = true;
        else
            v21 = false;
        end;
        if v21 then
            v2[v14].RightFootStepFX:Emit();
            return;
        end;
    else
        local l_LeftFootStepFX_0 = v2[v14].LeftFootStepFX;
        local v23 = workspace:Raycast(v14.PrimaryPart.Position, Vector3.new(0, -5, 0, 0), v8);
        local v24;
        if v23 then
            l_LeftFootStepFX_0.Color = ColorSequence.new(v23.Instance.Color);
            v24 = true;
        else
            v24 = false;
        end;
        if v24 then
            v2[v14].LeftFootStepFX:Emit();
        end;
    end;
end;
local function v30(v26) --[[ Line: 67 ]] --[[ Name: AddTrails ]]
    for _, v28 in pairs(v7) do
        if v26:FindFirstChild(v28) then
            local v29 = v6.CreateEffect("Attachment", l_AAA_0.RunTrail, nil, v26:FindFirstChild(v28));
            task.delay(3.25, function() --[[ Line: 71 ]]
                v29:DisableTrails();
                v29:Destroy(1);
            end);
        end;
    end;
end;
v0.AddTrails = function(_, v32) --[[ Line: 79 ]] --[[ Name: AddTrails ]]
    v30(v32);
end;
v0.Explosion = function(_, v34) --[[ Line: 84 ]] --[[ Name: Explosion ]]
    local l_HumanoidRootPart_0 = v34.HumanoidRootPart;
    local v36 = v6.CreateEffect("Attachment", l_AAA_0.Explosion, nil, l_HumanoidRootPart_0);
    v36:Emit();
    v36:Destroy(4);
    v2[v34] = nil;
end;
v0.BigJump = function(_, v38) --[[ Line: 95 ]] --[[ Name: BigJump ]]
    local l_HumanoidRootPart_1 = v38.HumanoidRootPart;
    if not workspace:Raycast(v38.PrimaryPart.Position, Vector3.new(0, -5, 0, 0), v8) then
        return;
    else
        local v40 = v6.CreateEffect("Attachment", l_AAA_0.BigJump, nil, l_HumanoidRootPart_1);
        v40:Emit();
        v40:Destroy(2.5);
        return;
    end;
end;
v0.FootStep = function(_, v42, v43) --[[ Line: 110 ]] --[[ Name: FootStep ]]
    v25(v43, v42);
end;
v0.Activate = function(v44, v45, v46, ...) --[[ Line: 115 ]] --[[ Name: Activate ]]
    warn(v46);
    warn(v45);
    v0[v46](v44, v45, ...);
end;
return v0;