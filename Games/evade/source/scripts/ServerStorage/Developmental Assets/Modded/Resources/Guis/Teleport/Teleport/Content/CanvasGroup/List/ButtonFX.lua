-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
return function(v1, v2) --[[ Line: 4 ]]
    -- upvalues: v0 (copy)
    local v3 = {};
    local v4 = false;
    local v5 = false;
    local v6 = v2 or 1.05;
    if v0[v1] then
        return function() --[[ Line: 11 ]]

        end;
    else
        v0[v1] = true;
        local v7 = v1:IsA("ImageButton") and v1.Image == "rbxassetid://12026054177";
        local v8 = nil;
        if v7 then
            for _, v10 in v1:GetChildren() do
                if v10:IsA("TextLabel") and v10.Text == "X" then
                    v8 = v10;
                    break;
                end;
            end;
        end;
        local v11 = nil;
        if v8 and not v8:FindFirstChildOfClass("UIScale") then
            local l_UIScale_0 = Instance.new("UIScale");
            l_UIScale_0.Name = "ButtonUIScale";
            l_UIScale_0.Parent = v8;
            v11 = l_UIScale_0;
        elseif v8 and v8:FindFirstChildOfClass("UIScale") then
            v11 = v8:FindFirstChildOfClass("UIScale");
        end;
        local l_UIScale_1 = v1:FindFirstChildOfClass("UIScale");
        if not l_UIScale_1 then
            local l_UIScale_2 = Instance.new("UIScale");
            l_UIScale_2.Name = "ButtonUIScale";
            l_UIScale_2.Parent = v1;
            l_UIScale_1 = l_UIScale_2;
        end;
        assert(l_UIScale_1);
        local function v15() --[[ Line: 43 ]] --[[ Name: v20 ]]
            -- upvalues: v4 (ref), v5 (ref), l_UIScale_1 (ref), v11 (ref), v8 (ref)
            if not v4 then
                v4 = not v4;
                v5 = false;
                require(script.Tween)(l_UIScale_1, {
                    Scale = 0.9
                }, {
                    0.065, 
                    Enum.EasingStyle.Exponential, 
                    "Out"
                });
                if v11 then
                    require(script.Tween)(v11, {
                        Scale = 0.9
                    }, {
                        0.065, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
                    require(script.Tween)(v8, {
                        Position = UDim2.new(0.5, 0, 0.6, 0)
                    }, {
                        0.065, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v16() --[[ Line: 73 ]] --[[ Name: v21 ]]
            -- upvalues: v4 (ref), l_UIScale_1 (ref), v11 (ref), v8 (ref)
            if v4 then
                v4 = not v4;
                require(script.Tween)(l_UIScale_1, {
                    Scale = 1
                }, {
                    0.25, 
                    Enum.EasingStyle.Circular, 
                    "Out"
                });
                if v11 then
                    require(script.Tween)(v11, {
                        Scale = 1
                    }, {
                        0.25, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                    require(script.Tween)(v8, {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, {
                        0.25, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v17() --[[ Line: 102 ]] --[[ Name: v22 ]]
            -- upvalues: v5 (ref), v4 (ref), l_UIScale_1 (ref), v11 (ref), v8 (ref)
            if v5 then
                v5 = not v5;
                if not v4 then
                    require(script.Tween)(l_UIScale_1, {
                        Scale = 1
                    }, {
                        0.035, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
                    if v11 then
                        require(script.Tween)(v11, {
                            Scale = 1
                        }, {
                            0.035, 
                            Enum.EasingStyle.Exponential, 
                            "Out"
                        });
                        return;
                    end;
                elseif v4 and v11 then
                    require(script.Tween)(v8, {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, {
                        0.035, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v18() --[[ Line: 135 ]] --[[ Name: v23 ]]
            -- upvalues: v5 (ref), v4 (ref), l_UIScale_1 (ref), v6 (copy), v11 (ref)
            if not v5 then
                v5 = not v5;
                if not v4 then
                    require(script.Tween)(l_UIScale_1, {
                        Scale = v6
                    }, {
                        0.05, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                    if v11 then
                        require(script.Tween)(v11, {
                            Scale = v6
                        }, {
                            0.05, 
                            Enum.EasingStyle.Circular, 
                            "Out"
                        });
                    end;
                end;
            end;
        end;
        (function() --[[ Line: 159 ]]
            -- upvalues: v3 (copy), v1 (copy), v15 (copy), v16 (copy), v18 (copy), v17 (copy)
            v3[#v3 + 1] = v1.InputBegan:Connect(function(v19) --[[ Line: 161 ]]
                -- upvalues: v1 (ref), v15 (ref)
                if not v1.Active then
                    return;
                else
                    local l_UserInputType_0 = v19.UserInputType;
                    local l_UserInputState_0 = v19.UserInputState;
                    local l_KeyCode_0 = v19.KeyCode;
                    if l_UserInputType_0 == Enum.UserInputType.MouseButton1 or l_UserInputType_0 == Enum.UserInputType.Touch and l_UserInputState_0 == Enum.UserInputState.Begin or l_KeyCode_0 == Enum.KeyCode.ButtonA then
                        v15();
                    end;
                    return;
                end;
            end);
            v3[#v3 + 1] = v1.InputEnded:Connect(function(v23) --[[ Line: 175 ]]
                -- upvalues: v1 (ref), v16 (ref)
                if not v1.Active then
                    return;
                else
                    local l_UserInputType_1 = v23.UserInputType;
                    local _ = v23.UserInputState;
                    local l_KeyCode_1 = v23.KeyCode;
                    if l_UserInputType_1 == Enum.UserInputType.MouseButton1 or l_UserInputType_1 == Enum.UserInputType.Touch or l_KeyCode_1 == Enum.KeyCode.ButtonA then
                        v16();
                    end;
                    return;
                end;
            end);
            v3[#v3 + 1] = v1.MouseEnter:Connect(function() --[[ Line: 189 ]]
                -- upvalues: v1 (ref), v18 (ref)
                if not v1.Active then
                    return;
                else
                    v18();
                    return;
                end;
            end);
            v3[#v3 + 1] = v1.MouseLeave:Connect(function() --[[ Line: 198 ]]
                -- upvalues: v1 (ref), v17 (ref)
                if not v1.Active then
                    return;
                else
                    v17();
                    return;
                end;
            end);
        end)();
        local v27 = false;
        local function v30() --[[ Line: 209 ]] --[[ Name: v37 ]]
            -- upvalues: v27 (ref), v3 (copy), l_UIScale_1 (ref), v11 (ref), v8 (ref), v0 (ref), v1 (copy)
            if v27 then
                return;
            else
                v27 = true;
                for _, v29 in ipairs(v3) do
                    v29:Disconnect();
                end;
                if l_UIScale_1 and l_UIScale_1.Parent then
                    l_UIScale_1.Scale = 1;
                end;
                if v11 then
                    v8.Position = UDim2.new(0.5, 0, 0.5, 0);
                    v11.Scale = 1;
                end;
                v0[v1] = nil;
                return;
            end;
        end;
        table.insert(v3, v1.Destroying:Connect(function() --[[ Line: 229 ]]
            -- upvalues: v30 (copy)
            v30();
        end));
        return v30;
    end;
end;