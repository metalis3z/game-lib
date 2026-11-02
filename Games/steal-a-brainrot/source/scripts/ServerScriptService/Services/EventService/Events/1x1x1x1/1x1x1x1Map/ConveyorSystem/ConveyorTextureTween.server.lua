-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Parent_0 = script.Parent;
local function _(v2) --[[ Line: 6 ]] --[[ Name: Axis ]]
    if tostring(v2:GetAttribute("Axis") or "X") == "Y" then
        return "OffsetStudsV";
    else
        return "OffsetStudsU";
    end;
end;
local function _(v4) --[[ Line: 10 ]] --[[ Name: Direction ]]
    if tostring(v4:GetAttribute("Direction") or "Positive") == "Negative" then
        return -1;
    else
        return 1;
    end;
end;
local function _(v6) --[[ Line: 14 ]] --[[ Name: DaSpeed ]]
    local v7 = tonumber(v6:GetAttribute("Speed"));
    return v7 and math.abs(v7) > 0 and math.abs(v7) or 1;
end;
local function _(v9) --[[ Line: 19 ]] --[[ Name: StartTexture ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_Parent_1 = v9.Parent;
    local v11 = tostring(l_Parent_1:GetAttribute("Axis") or "X") == "Y" and "OffsetStudsV" or "OffsetStudsU";
    local v12 = tostring(l_Parent_1:GetAttribute("Direction") or "Positive") == "Negative" and -1 or 1;
    local v13 = tonumber(l_Parent_1:GetAttribute("Speed"));
    local v14 = v13 and math.abs(v13) > 0 and math.abs(v13) or 1;
    v13 = function() --[[ Line: 25 ]] --[[ Name: RunOnce ]]
        -- upvalues: v12 (copy), v14 (copy), v11 (copy), v9 (copy), l_TweenService_0 (ref), v13 (copy)
        local v15 = v12 * 2000;
        local v16 = math.abs(v15) / math.max(v14, 0.001);
        local v17 = {
            [v11] = v9[v11] + v15
        };
        local v18 = l_TweenService_0:Create(v9, TweenInfo.new(v16, Enum.EasingStyle.Linear), v17);
        v18.Completed:Connect(function() --[[ Line: 31 ]]
            -- upvalues: v9 (ref), v11 (ref), v13 (ref)
            v9[v11] = 0;
            v13();
        end);
        v18:Play();
    end;
    v13();
end;
local function v42(v20) --[[ Line: 41 ]] --[[ Name: ConveyorFolder ]]
    -- upvalues: l_TweenService_0 (copy)
    for _, v22 in ipairs(v20:GetDescendants()) do
        if v22:IsA("Texture") then
            local l_Parent_2 = v22.Parent;
            local v24 = tostring(l_Parent_2:GetAttribute("Axis") or "X") == "Y" and "OffsetStudsV" or "OffsetStudsU";
            local v25 = tostring(l_Parent_2:GetAttribute("Direction") or "Positive") == "Negative" and -1 or 1;
            local v26 = tonumber(l_Parent_2:GetAttribute("Speed"));
            local v27 = v26 and math.abs(v26) > 0 and math.abs(v26) or 1;
            v26 = function() --[[ Line: 25 ]] --[[ Name: RunOnce ]]
                -- upvalues: v25 (copy), v27 (copy), v24 (copy), v22 (copy), l_TweenService_0 (ref), v26 (copy)
                local v28 = v25 * 2000;
                local v29 = math.abs(v28) / math.max(v27, 0.001);
                local v30 = {
                    [v24] = v22[v24] + v28
                };
                local v31 = l_TweenService_0:Create(v22, TweenInfo.new(v29, Enum.EasingStyle.Linear), v30);
                v31.Completed:Connect(function() --[[ Line: 31 ]]
                    -- upvalues: v22 (ref), v24 (ref), v26 (ref)
                    v22[v24] = 0;
                    v26();
                end);
                v31:Play();
            end;
            v26();
        end;
    end;
    v20.DescendantAdded:Connect(function(v32) --[[ Line: 47 ]]
        -- upvalues: l_TweenService_0 (ref)
        if v32:IsA("Texture") then
            local l_Parent_3 = v32.Parent;
            local v34 = tostring(l_Parent_3:GetAttribute("Axis") or "X") == "Y" and "OffsetStudsV" or "OffsetStudsU";
            local v35 = tostring(l_Parent_3:GetAttribute("Direction") or "Positive") == "Negative" and -1 or 1;
            local v36 = tonumber(l_Parent_3:GetAttribute("Speed"));
            local v37 = v36 and math.abs(v36) > 0 and math.abs(v36) or 1;
            v36 = function() --[[ Line: 25 ]] --[[ Name: RunOnce ]]
                -- upvalues: v35 (copy), v37 (copy), v34 (copy), v32 (copy), l_TweenService_0 (ref), v36 (copy)
                local v38 = v35 * 2000;
                local v39 = math.abs(v38) / math.max(v37, 0.001);
                local v40 = {
                    [v34] = v32[v34] + v38
                };
                local v41 = l_TweenService_0:Create(v32, TweenInfo.new(v39, Enum.EasingStyle.Linear), v40);
                v41.Completed:Connect(function() --[[ Line: 31 ]]
                    -- upvalues: v32 (ref), v34 (ref), v36 (ref)
                    v32[v34] = 0;
                    v36();
                end);
                v41:Play();
            end;
            v36();
        end;
    end);
end;
for _, v44 in ipairs(l_Parent_0:GetDescendants()) do
    if v44.Name == "Conveyor" then
        v42(v44);
    end;
end;
l_Parent_0.DescendantAdded:Connect(function(v45) --[[ Line: 60 ]]
    -- upvalues: v42 (copy)
    if v45.Name == "Conveyor" then
        v42(v45);
    end;
end);