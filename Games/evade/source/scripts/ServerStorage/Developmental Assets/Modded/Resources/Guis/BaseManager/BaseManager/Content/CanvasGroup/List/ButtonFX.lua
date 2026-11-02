-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v5 = {};
return function(v6, v7) --[[ Line: 30 ]]
    -- upvalues: v5 (copy), v1 (copy), v2 (copy), v4 (copy)
    local v8 = {};
    local v9 = false;
    local v10 = false;
    local v11 = v7 or 1.05;
    if v5[v6] then
        return function() --[[ Line: 37 ]]

        end;
    else
        v5[v6] = true;
        local v12 = v6:IsA("ImageButton") and v6.Image == "rbxassetid://12026054177";
        local v13 = nil;
        if v12 then
            for _, v15 in v6:GetChildren() do
                if v15:IsA("TextLabel") and v15.Text == "X" then
                    v13 = v15;
                    break;
                end;
            end;
        end;
        local v16 = nil;
        if v13 and not v13:FindFirstChildOfClass("UIScale") then
            local l_UIScale_0 = Instance.new("UIScale");
            l_UIScale_0.Name = "ButtonUIScale";
            l_UIScale_0.Parent = v13;
            v16 = l_UIScale_0;
        elseif v13 and v13:FindFirstChildOfClass("UIScale") then
            v16 = v13:FindFirstChildOfClass("UIScale");
        end;
        local l_UIScale_1 = v6:FindFirstChildOfClass("UIScale");
        if not l_UIScale_1 then
            local l_UIScale_2 = Instance.new("UIScale");
            l_UIScale_2.Name = "ButtonUIScale";
            l_UIScale_2.Parent = v6;
            l_UIScale_1 = l_UIScale_2;
        end;
        assert(l_UIScale_1);
        local function v20() --[[ Line: 75 ]] --[[ Name: Down ]]
            -- upvalues: v9 (ref), v10 (ref), v1 (ref), l_UIScale_1 (ref), v16 (ref), v13 (ref)
            if not v9 then
                v9 = not v9;
                v10 = false;
                require(script.Tween)(l_UIScale_1, {
                    Scale = 0.9
                }, {
                    0.065, 
                    Enum.EasingStyle.Exponential, 
                    "Out"
                });
                if v16 then
					require(script.Tween)(v16, {
                        Scale = 0.9
                    }, {
                        0.065, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
					require(script.Tween)(v13, {
                        Position = UDim2.new(0.5, 0, 0.6, 0)
                    }, {
                        0.065, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v21() --[[ Line: 88 ]] --[[ Name: Up ]]
            -- upvalues: v9 (ref), v1 (ref), l_UIScale_1 (ref), v16 (ref), v13 (ref)
            if v9 then
                v9 = not v9;
				require(script.Tween)(l_UIScale_1, {
                    Scale = 1
                }, {
                    0.25, 
                    Enum.EasingStyle.Circular, 
                    "Out"
                });
                if v16 then
					require(script.Tween)(v16, {
                        Scale = 1
                    }, {
                        0.25, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
					require(script.Tween)(v13, {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, {
                        0.25, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v22() --[[ Line: 100 ]] --[[ Name: MouseLeave ]]
            -- upvalues: v10 (ref), v9 (ref), v1 (ref), l_UIScale_1 (ref), v16 (ref), v13 (ref)
            if v10 then
                v10 = not v10;
                if not v9 then
					require(script.Tween)(l_UIScale_1, {
                        Scale = 1
                    }, {
                        0.035, 
                        Enum.EasingStyle.Exponential, 
                        "Out"
                    });
                    if v16 then
						require(script.Tween)(v16, {
                            Scale = 1
                        }, {
                            0.035, 
                            Enum.EasingStyle.Exponential, 
                            "Out"
                        });
                        return;
                    end;
                elseif v9 and v16 then
					require(script.Tween)(v13, {
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, {
                        0.035, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                end;
            end;
        end;
        local function v23() --[[ Line: 115 ]] --[[ Name: MouseEnter ]]
            -- upvalues: v10 (ref), v9 (ref), v1 (ref), l_UIScale_1 (ref), v11 (copy), v16 (ref)
            if not v10 then
                v10 = not v10;
                if not v9 then
					require(script.Tween)(l_UIScale_1, {
                        Scale = v11
                    }, {
                        0.05, 
                        Enum.EasingStyle.Circular, 
                        "Out"
                    });
                    if v16 then
						require(script.Tween)(v16, {
                            Scale = v11
                        }, {
                            0.05, 
                            Enum.EasingStyle.Circular, 
                            "Out"
                        });
                    end;
                end;
            end;
        end;
        (function() --[[ Line: 128 ]] --[[ Name: Events ]]
            -- upvalues: v8 (copy), v6 (copy), v20 (copy), v21 (copy), v2 (ref), v23 (copy), v22 (copy)
            v8[#v8 + 1] = v6.InputBegan:Connect(function(v24) --[[ Line: 129 ]]
                -- upvalues: v6 (ref), v20 (ref)
                if not v6.Active then
                    return;
                else
                    local l_UserInputType_0 = v24.UserInputType;
                    local l_UserInputState_0 = v24.UserInputState;
                    local l_KeyCode_0 = v24.KeyCode;
                    if l_UserInputType_0 == Enum.UserInputType.MouseButton1 or l_UserInputType_0 == Enum.UserInputType.Touch and l_UserInputState_0 == Enum.UserInputState.Begin or l_KeyCode_0 == Enum.KeyCode.ButtonA then
                        v20();
                    end;
                    return;
                end;
            end);
            v8[#v8 + 1] = v6.InputEnded:Connect(function(v28) --[[ Line: 139 ]]
                -- upvalues: v6 (ref), v21 (ref)
                if not v6.Active then
                    return;
                else
                    local l_UserInputType_1 = v28.UserInputType;
                    local _ = v28.UserInputState;
                    local l_KeyCode_1 = v28.KeyCode;
                    if l_UserInputType_1 == Enum.UserInputType.MouseButton1 or l_UserInputType_1 == Enum.UserInputType.Touch or l_KeyCode_1 == Enum.KeyCode.ButtonA then
                        v21();
                    end;
                    return;
                end;
            end);
            v8[#v8 + 1] = v6.MouseEnter:Connect(function() --[[ Line: 149 ]]
                -- upvalues: v6 (ref), v2 (ref), v23 (ref)
                if not v6.Active then
                    return;
                else
					v23();
                    return;
                end;
            end);
            v8[#v8 + 1] = v6.MouseLeave:Connect(function() --[[ Line: 158 ]]
                -- upvalues: v6 (ref), v2 (ref), v22 (ref)
                if not v6.Active then
                    return;
                else
					v22();
                    return;
                end;
            end);
        end)();
        local v34 = false;
        local function v37() --[[ Line: 190 ]] --[[ Name: stop ]]
            -- upvalues: v34 (ref), v8 (copy), l_UIScale_1 (ref), v16 (ref), v13 (ref), v32 (copy), v33 (copy), v5 (ref), v6 (copy)
            if v34 then
                return;
            else
                v34 = true;
                for _, v36 in ipairs(v8) do
                    v36:Disconnect();
                end;
                if l_UIScale_1 and l_UIScale_1.Parent then
                    l_UIScale_1.Scale = 1;
                end;
                if v16 then
                    v13.Position = UDim2.new(0.5, 0, 0.5, 0);
                    v16.Scale = 1;
                end;
                v5[v6] = nil;
                return;
            end;
        end;
        table.insert(v8, v6.Destroying:Connect(function() --[[ Line: 210 ]]
            -- upvalues: v37 (copy)
            v37();
        end));
        return v37;
    end;
end;