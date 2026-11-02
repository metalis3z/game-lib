
local v_u_1 = game:GetService("RunService")
local v_u_2 = require("../mod/utility")
return {
    ["emit"] = function(p_u_3, p4)
        if p_u_3:GetAttribute("Enabled") then
            local v_u_5 = v_u_2.getAttribute(p_u_3, "PartScale", Vector3.new(1, 1, 1))
            local v_u_6 = v_u_2.getAttribute(p_u_3, "PartDistance", 1.5)
            local v_u_7 = v_u_2.getAttribute(p_u_3, "OffsetPosition", Vector3.new(0, 0, 0))
            local v_u_8 = v_u_2.getAttribute(p_u_3, "OffsetRotation", Vector3.new(0, 0, 0)) * v_u_2.DEG_TO_RAD
            local v_u_9 = p_u_3.CFrame
            local v_u_10 = p_u_3.Size
            local v_u_11 = p_u_3.CollisionGroup
            p_u_3.CollisionGroup = "ForgeMouseIgnore"
            table.insert(p4, function()
                p_u_3.Size = v_u_10
                p_u_3.CFrame = v_u_9
                p_u_3.CollisionGroup = v_u_11 == "" and "Default" or (v_u_11 or "Default")
            end)
            local function v20()
                local v12 = workspace.CurrentCamera
                local v13 = v12.FieldOfView / 2
                local v14 = math.rad(v13)
                local v15 = math.tan(v14) * v_u_6 * 2
                local v16 = v12.ViewportSize.X / v12.ViewportSize.Y * v15
                local v17 = v12.CFrame * CFrame.new(0, 0, -v_u_6)
                local v18 = p_u_3
                local v19 = p_u_3.Size.Z
                v18.Size = Vector3.new(v16, v15, v19) * v_u_5
                p_u_3.CFrame = v17 * CFrame.new(v_u_7) * CFrame.fromOrientation(v_u_8.x, v_u_8.y, v_u_8.z)
            end
            if v_u_1:IsRunning() then
                local v_u_21 = v_u_2.getRanomId()
                v_u_1:BindToRenderStep(v_u_21, v_u_2.RENDER_PRIORITY + p4.depth, v20)
                local function v22()
                    v_u_1:UnbindFromRenderStep(v_u_21)
                end
                table.insert(p4, v22)
            else
                local v23 = v_u_1.RenderStepped
                table.insert(p4, v23:Connect(v20))
            end
        else
            return
        end
    end
}