-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local function _(v1, v2, v3) --[[ Line: 5 ]] --[[ Name: mapValue ]]
    return (math.clamp(v2 + (v3 - v2) * v1, v2, v3));
end;
local function _(v5, v6, v7) --[[ Line: 9 ]] --[[ Name: normalizeValue ]]
    return (math.clamp((v5 - v6) / (v7 - v6), 0, 1));
end;
local function _(v9, v10) --[[ Line: 13 ]] --[[ Name: snap ]]
    return v10 == 0 and v9 or math.floor((v9 + v10 / 2) / v10) * v10;
end;
v0.CreateSettingUI = function(_, v13, v14, v15) --[[ Line: 18 ]] --[[ Name: CreateSettingUI ]]
    -- upvalues: v0 (copy)
    local v16 = require(game.ReplicatedStorage.Modules.Sounds);
    if not v13 then
        v13 = Instance.new("NumberValue");
        v13.Name = "SettingValue";
    end;
    local v17 = setmetatable({
        SettingValue = v13
    }, v0);
    v17.Instance = v14 or script.Slider:Clone();
    v17.Value = v13.Value;
    local l_DragBar_0 = v17.Instance.DragBar;
    local l_Dragger_0 = l_DragBar_0.Dragger;
    local l_Mouse_0 = game.Players.LocalPlayer:GetMouse();
    local l_v13_Attribute_0 = v13:GetAttribute("MinValue");
    local l_v13_Attribute_1 = v13:GetAttribute("MaxValue");
    local l_v13_Attribute_2 = v13:GetAttribute("Step");
    v17.__displayValue = Instance.new("NumberValue");
    v17.__displayValue.Name = "__displayValue";
    v17.__displayValue.Value = v13.Value;
    v17.__displayValue.Parent = v17.Instance;
    v17.__displayValue:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 44 ]]
        -- upvalues: l_Dragger_0 (copy), v17 (copy)
        l_Dragger_0.Title.Text = tostring((math.round(v17.__displayValue.Value)));
    end);
    l_Dragger_0.Title.Text = tostring((math.round(v17.__displayValue.Value)));
    local function v30() --[[ Line: 49 ]] --[[ Name: enableDragging ]]
        -- upvalues: v17 (copy), v16 (copy), l_Mouse_0 (copy), l_DragBar_0 (copy), l_v13_Attribute_0 (copy), l_v13_Attribute_1 (copy), l_v13_Attribute_2 (copy)
        v17.Dragging = true;
        v16:Play("switch");
        while task.wait() and v17.Dragging do
            local l_X_0 = l_Mouse_0.X;
            local l_X_1 = l_DragBar_0.AbsoluteSize.X;
            local v26 = (l_X_0 - l_DragBar_0.AbsolutePosition.X) / l_X_1;
            local l_l_v13_Attribute_0_0 = l_v13_Attribute_0;
            local l_l_v13_Attribute_1_0 = l_v13_Attribute_1;
            local v29 = math.clamp(l_l_v13_Attribute_0_0 + (l_l_v13_Attribute_1_0 - l_l_v13_Attribute_0_0) * v26, l_l_v13_Attribute_0_0, l_l_v13_Attribute_1_0);
            l_l_v13_Attribute_1_0 = l_v13_Attribute_2;
            l_l_v13_Attribute_0_0 = l_l_v13_Attribute_1_0 == 0 and v29 or math.floor((v29 + l_l_v13_Attribute_1_0 / 2) / l_l_v13_Attribute_1_0) * l_l_v13_Attribute_1_0;
            if v17.Value ~= l_l_v13_Attribute_0_0 then
                v16:Play("tick", {
                    Volume = 0.025
                });
                v17.Value = l_l_v13_Attribute_0_0;
                v17:OnUpdate();
                if v17.__updatedEvent then
                    v17.__updatedEvent:Fire();
                end;
            end;
        end;
    end;
    local function v32(v31) --[[ Line: 69 ]] --[[ Name: onInputEnded ]]
        -- upvalues: v17 (copy), v16 (copy), v13 (ref), v15 (copy)
        if not v17.Dragging then
            return;
        else
            if v31.UserInputType == Enum.UserInputType.MouseButton1 or v31.UserInputType == Enum.UserInputType.Touch or v31.UserInputType == Enum.UserInputType.Gamepad1 and v31.KeyCode == Enum.KeyCode.ButtonR2 then
                v17.Dragging = false;
                v16:Play("switch");
                if v13.Name ~= "SettingValue" and v13.Name ~= "Value" then
                    require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v13, v17.Value);
                    return;
                else
                    v17:OnUpdate();
                    if v15 then
                        v15(v17.Value);
                    end;
                end;
            end;
            return;
        end;
    end;
    l_Dragger_0.MouseButton1Down:Connect(v30);
    game.UserInputService.InputEnded:Connect(v32);
    return v17;
end;
v0.OnUpdate = function(v33) --[[ Line: 95 ]] --[[ Name: OnUpdate ]]
    local l_Attribute_0 = v33.SettingValue:GetAttribute("MinValue");
    local l_Attribute_1 = v33.SettingValue:GetAttribute("MaxValue");
    local v36 = math.clamp((v33.Value - l_Attribute_0) / (l_Attribute_1 - l_Attribute_0), 0, 1);
    local l_Dragger_1 = v33.Instance.DragBar.Dragger;
    local v38 = math.clamp(v36, 0, 1);
    game.TweenService:Create(l_Dragger_1, TweenInfo.new(0.1), {
        Position = UDim2.fromScale(v38, 0.5)
    }):Play();
    game.TweenService:Create(v33.__displayValue, TweenInfo.new(0.1), {
        Value = v33.Value
    }):Play();
end;
return v0;