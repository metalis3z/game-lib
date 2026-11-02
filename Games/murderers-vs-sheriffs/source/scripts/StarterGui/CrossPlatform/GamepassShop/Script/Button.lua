return {
    createButton = function(v0, v1, v2)
        local v3 = {
            Frame = v0, 
            Container = v0.Container
        };
        v3.shadowSize = math.abs(v3.Container.Shadow.Position.X.Offset);
        v3.clickStart = v2 or function()

        end;
        v3.clickEnd = v1 or function()

        end;
        local v4 = false;
        local v5 = true;
        v3.Reset = function(_)
            v4 = false;
            v3.Container:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true);
            v3.Container.Shadow:TweenSize(UDim2.new(1, v3.shadowSize * 2, 1, v3.shadowSize * 3), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true);
        end;
        v3.Press = function(_)
            if not v5 then
                return;
            else
                v4 = true;
                v3.Container:TweenSize(UDim2.new(0.95, 0, 0.95, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true);
                v3.Container.Shadow:TweenSize(UDim2.new(1, v3.shadowSize * 2, 1, v3.shadowSize * 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true);
                return;
            end;
        end;
        v3.Disable = function(_) 
            v5 = false;
            v3.Container.Background.Visible = false;
        end;
        v3.Enable = function(_)
            v5 = true;
            v3.Container.Background.Visible = true;
        end;
        v3.GetEnabled = function(_)
            return v5;
        end;
        v3.Clicked = function(_)
            if v4 and v5 then
                v3:Reset();
                v3.clickStart();
                task.wait(0.025);
                v3.clickEnd();
                return;
            else
                v3:Reset();
                return;
            end;
        end;
        v3.Frame.Button.MouseButton1Down:Connect(v3.Press);
        v3.Frame.Button.MouseButton1Up:Connect(v3.Clicked);
        v3.Frame.MouseLeave:Connect(v3.Reset);
        return v3;
    end
};