



local v_u_1 = require(script.Parent.Parent.ColorSequenceUtils)
local v_u_2 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(0.1510416716337204, Color3.new(0, 1, 0)),
    ColorSequenceKeypoint.new(0.3072916567325592, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(0.4965277910232544, Color3.new(0, 1, 0)),
    ColorSequenceKeypoint.new(0.6649305820465088, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(0.8385416865348816, Color3.new(0, 1, 0)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
})
local v_u_3 = 0
return {
    ["simulate"] = function(p4)
        v_u_3 = v_u_3 + p4 * 0.25
        return {
            ["main"] = v_u_1.calculateColorSequence(v_u_2, v_u_3)
        }
    end,
    ["apply"] = function(p5)
        local v_u_6 = {}
        local v_u_7 = p5:FindFirstChildWhichIsA("UIGradient")
        local v_u_8
        if v_u_7 then
            v_u_8 = v_u_7.Color
        else
            v_u_8 = nil
        end
        if not v_u_7 then
            v_u_7 = Instance.new("UIGradient")
            v_u_7.Parent = p5
            table.insert(v_u_6, v_u_7)
        end
        local v9 = v_u_7
        assert(v9)
        return {
            ["main"] = v_u_7,
            ["cleanup"] = function()
                if v_u_8 then
                    v_u_7.Color = v_u_8
                end
                for _, v10 in v_u_6 do
                    v10:Destroy()
                end
            end
        }
    end
}