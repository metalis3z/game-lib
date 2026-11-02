-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local v1 = game:GetService("RunService")
local v2 = game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(script.Flags)
local v5 = require(v3.UserGenerated.Concurrency.Bindable)
local v_u_6 = v5.new()
local v_u_7 = v5.new()
local v_u_8 = false
local v_u_9 = nil
v2.InputBegan:Connect(function(p10, p11)
    if not p11 then
        if ((p10.UserInputType == Enum.UserInputType.Touch or p10.UserInputType == Enum.UserInputType.MouseButton1) and true or p10.KeyCode == Enum.KeyCode.ButtonR2) and not v_u_8 then
            if p10.UserInputType == Enum.UserInputType.Touch then
                v_u_9 = {
                    ["Object"] = p10,
                    ["Origin"] = p10.Position,
                    ["Age"] = 0
                }
                return
            end
            local v12 = p10.Position
            v_u_9 = nil
            if v_u_8 == true then
                return
            end
            v_u_8 = true
            v_u_6:Fire(p10, v12)
        end
    end
end)
v2.InputChanged:Connect(function(p13, p14)
    if not p14 then
        if v_u_9 and (v_u_9.Object == p13 and (v_u_9.Origin - p13.Position).Magnitude > v_u_4.DraggingThreshold:Get()) then
            v_u_9 = nil
        end
    end
end)
v2.InputEnded:Connect(function(p15, p16)
    if not p16 then
        if v_u_9 and v_u_9.Object == p15 then
            if (v_u_9.Origin - v_u_9.Object.Position).Magnitude > v_u_4.DraggingThreshold:Get() then
                v_u_9 = nil
            else
                local v17 = v_u_9.Object
                local v18 = v_u_9.Origin
                v_u_9 = nil
                if v_u_8 ~= true then
                    v_u_8 = true
                    v_u_6:Fire(v17, v18)
                end
            end
        end
        if (p15.UserInputType == Enum.UserInputType.Touch or p15.UserInputType == Enum.UserInputType.MouseButton1) and true or p15.KeyCode == Enum.KeyCode.ButtonR2 then
            local _ = p15.Position
            v_u_9 = nil
            if v_u_8 == false then
                return
            end
            v_u_8 = false
            v_u_7:Fire(p15)
        end
    end
end)
v1:BindToRenderStep("ActionController", Enum.RenderPriority.Input.Value, function(p19)
    if v_u_9 then
        local v20 = v_u_9
        v20.Age = v20.Age + p19
        if v_u_9.Age >= v_u_4.TouchDuration:Get() then
            if (v_u_9.Origin - v_u_9.Object.Position).Magnitude > v_u_4.DraggingThreshold:Get() then
                v_u_9 = nil
                return
            end
            local v21 = v_u_9.Object
            local v22 = v_u_9.Origin
            v_u_9 = nil
            if v_u_8 == true then
                return
            end
            v_u_8 = true
            v_u_6:Fire(v21, v22)
        end
    end
end)
local v23 = {
    ["Pressed"] = v_u_6,
    ["Released"] = v_u_7,
    ["IsInputDown"] = function()
        return v_u_8
    end
}
return table.freeze(v23)