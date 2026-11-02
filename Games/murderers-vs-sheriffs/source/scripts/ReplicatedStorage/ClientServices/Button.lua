-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local _ = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
return {
    createButton = function(v3, v4, v5) --[[ Line: 28 ]] --[[ Name: createButton ]]
        -- upvalues: l_TweenService_0 (copy), v1 (copy)
        local v6 = {
            Frame = v3, 
            Container = v3.Container
        };
        v6.shadowSize = math.abs(v6.Container.Shadow.Position.X.Offset);
        v6.clickStart = v5 or function() --[[ Line: 35 ]]

        end;
        v6.clickEnd = v4 or function() --[[ Line: 36 ]]

        end;
        local v7 = false;
        local v8 = true;
        local l_Position_0 = v6.Container.Position;
        local l_Position_1 = v6.Container.Shadow.Position;
        v6.Reset = function(_) --[[ Line: 44 ]] --[[ Name: Reset ]]
            -- upvalues: v7 (ref), l_TweenService_0 (ref), v6 (copy), v1 (ref), l_Position_0 (copy), l_Position_1 (copy)
            v7 = false;
            l_TweenService_0:Create(v6.Container, v1, {
                Size = UDim2.fromScale(1, 1), 
                Position = l_Position_0
            }):Play();
            l_TweenService_0:Create(v6.Container.Shadow, v1, {
                Size = UDim2.new(1, v6.shadowSize * 2, 1, v6.shadowSize * 3), 
                Position = l_Position_1
            }):Play();
        end;
        v6.Press = function(_) --[[ Line: 58 ]] --[[ Name: Press ]]
            -- upvalues: v8 (ref), v7 (ref), l_TweenService_0 (ref), v6 (copy), v1 (ref)
            if not v8 then
                return;
            else
                v7 = true;
                l_TweenService_0:Create(v6.Container, v1, {
                    Size = UDim2.fromScale(0.95, 0.95), 
                    Position = v6.Container.Position + UDim2.new(0, 0, 0, 2)
                }):Play();
                l_TweenService_0:Create(v6.Container.Shadow, v1, {
                    Size = UDim2.new(1, v6.shadowSize * 2, 1, v6.shadowSize * 2), 
                    Position = v6.Container.Shadow.Position
                }):Play();
                return;
            end;
        end;
        v6.Disable = function(_) --[[ Line: 75 ]] --[[ Name: Disable ]]
            -- upvalues: v8 (ref), v6 (copy)
            v8 = false;
            v6.Container.Background.Visible = false;
        end;
        v6.Enable = function(_) --[[ Line: 80 ]] --[[ Name: Enable ]]
            -- upvalues: v8 (ref), v6 (copy)
            v8 = true;
            v6.Container.Background.Visible = true;
        end;
        v6.GetEnabled = function(_) --[[ Line: 85 ]] --[[ Name: GetEnabled ]]
            -- upvalues: v8 (ref)
            return v8;
        end;
        v6.Clicked = function(_) --[[ Line: 89 ]] --[[ Name: Clicked ]]
            -- upvalues: v7 (ref), v8 (ref), v6 (copy)
            if v7 and v8 then
                v6:Reset();
                v6.clickStart();
                task.wait(0.025);
                v6.clickEnd();
                return;
            else
                v6:Reset();
                return;
            end;
        end;
        v6.Frame.Button.MouseButton1Down:Connect(v6.Press);
        v6.Frame.Button.MouseButton1Up:Connect(v6.Clicked);
        v6.Frame.MouseLeave:Connect(v6.Reset);
        return v6;
    end
};