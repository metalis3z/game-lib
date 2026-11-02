-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
return function(v1, v2, v3, v4) --[[ Line: 4 ]]
    -- upvalues: l_TweenService_0 (copy)
    local v5 = nil;
    v5 = if type(v1) == "table" then v1 else {
        v1
    };
    local v6 = {};
    for _, v8 in ipairs(v5) do
        local v9 = nil;
        if v3 == nil then
            v9 = {
                1, 
                Enum.EasingStyle.Linear, 
                Enum.EasingDirection.Out
            };
        else
            v9 = v3;
            if v9[2] == nil then
                v9[2] = Enum.EasingStyle.Sine;
            elseif type(v9[2]) == "string" then
                if string.lower(v9[2]) == "expo" then
                    v9[2] = Enum.EasingStyle.Exponential;
                else
                    v9[2] = Enum.EasingStyle[v9[2]];
                end;
            end;
            if v9[3] == nil then
                v9[3] = Enum.EasingDirection.InOut;
            elseif type(v9[3]) == "string" then
                v9[3] = Enum.EasingDirection[v9[3]];
            end;
        end;
        local v10 = TweenInfo.new(unpack(v9));
        local v11 = nil;
        if v8:IsA("Model") and v2.Scale then
            local l_NumberValue_0 = Instance.new("NumberValue");
            v11 = l_NumberValue_0;
            l_NumberValue_0.Value = v8:GetScale();
            local l_l_NumberValue_0_0 = l_NumberValue_0 --[[ copy: 14 -> 18 ]];
            l_NumberValue_0.Changed:Connect(function() --[[ Line: 43 ]]
                -- upvalues: v8 (copy), l_l_NumberValue_0_0 (copy)
                if v8.Parent then
                    v8:ScaleTo(l_l_NumberValue_0_0.Value);
                end;
            end);
            v2.Value = v2.Scale;
            v2.Scale = nil;
        elseif v8:IsA("Model") and v2.CFrame then
            local l_CFrameValue_0 = Instance.new("CFrameValue");
            v11 = l_CFrameValue_0;
            l_CFrameValue_0.Value = v8:GetPivot();
            local l_l_CFrameValue_0_0 = l_CFrameValue_0 --[[ copy: 14 -> 17 ]];
            l_CFrameValue_0.Changed:Connect(function() --[[ Line: 56 ]]
                -- upvalues: v8 (copy), l_l_CFrameValue_0_0 (copy)
                if v8.Parent then
                    v8:PivotTo(l_l_CFrameValue_0_0.Value);
                end;
            end);
            v2.Value = v2.CFrame;
            v2.CFrame = nil;
        elseif v8:IsA("Model") and v2.Position then
            local l_Vector3Value_0 = Instance.new("Vector3Value");
            v11 = l_Vector3Value_0;
            l_Vector3Value_0.Value = v8:GetPivot().Position;
            local l_l_Vector3Value_0_0 = l_Vector3Value_0 --[[ copy: 14 -> 16 ]];
            l_Vector3Value_0.Changed:Connect(function() --[[ Line: 69 ]]
                -- upvalues: v8 (copy), l_l_Vector3Value_0_0 (copy)
                if v8.Parent then
                    local l_v8_Pivot_0 = v8:GetPivot();
                    v8:PivotTo(l_v8_Pivot_0 - l_v8_Pivot_0.Position + l_l_Vector3Value_0_0.Value);
                end;
            end);
            v2.Value = v2.Position;
            v2.Position = nil;
        end;
        local v19 = l_TweenService_0:Create(v11 or v8, v10, v2);
        local l_v11_0 = v11;
        if l_v11_0 then
            v19.Completed:Once(function() --[[ Line: 83 ]]
                -- upvalues: l_v11_0 (copy)
                l_v11_0:Destroy();
            end);
        end;
        if v4 then
            task.delay(v4, function() --[[ Line: 89 ]]
                -- upvalues: v19 (copy)
                v19:Play();
            end);
        else
            v19:Play();
        end;
        table.insert(v6, v19);
    end;
    return unpack(v6);
end;