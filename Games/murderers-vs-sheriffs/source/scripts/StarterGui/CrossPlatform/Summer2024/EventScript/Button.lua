-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    ["createButton"] = function(p1, p2, p3)
        local v_u_4 = {
            ["Frame"] = p1,
            ["Container"] = p1.Container
        }
        local v5 = v_u_4.Container.Shadow.Position.X.Offset
        v_u_4.shadowSize = math.abs(v5)
        v_u_4.clickStart = p3 or function() end
        v_u_4.clickEnd = p2 or function() end
        local v_u_6 = false
        local v_u_7 = true
        function v_u_4.Reset(_)
            v_u_6 = false
            v_u_4.Container:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true)
            v_u_4.Container.Shadow:TweenSize(UDim2.new(1, v_u_4.shadowSize * 2, 1, v_u_4.shadowSize * 3), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true)
        end
        function v_u_4.Press(_)
            if v_u_7 then
                v_u_6 = true
                v_u_4.Container:TweenSize(UDim2.new(0.95, 0, 0.95, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
                v_u_4.Container.Shadow:TweenSize(UDim2.new(1, v_u_4.shadowSize * 2, 1, v_u_4.shadowSize * 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
            end
        end
        function v_u_4.Disable(_)
            v_u_7 = false
            v_u_4.Container.Background.Visible = false
        end
        function v_u_4.Enable(_)
            v_u_7 = true
            v_u_4.Container.Background.Visible = true
        end
        function v_u_4.GetEnabled(_)
            return v_u_7
        end
        function v_u_4.Clicked(_)
            if v_u_6 and v_u_7 then
                v_u_4:Reset()
                v_u_4.clickStart()
                task.wait(0.025)
                v_u_4.clickEnd()
            else
                v_u_4:Reset()
            end
        end
        v_u_4.Frame.Button.MouseButton1Down:Connect(v_u_4.Press)
        v_u_4.Frame.Button.MouseButton1Up:Connect(v_u_4.Clicked)
        v_u_4.Frame.MouseLeave:Connect(v_u_4.Reset)
        return v_u_4
    end
}