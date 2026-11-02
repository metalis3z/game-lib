local v0 = require(script.Parent.Parent.ColorSequenceUtils);
local v1 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 170, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 255, 200)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 200, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))
});
local v2 = 0;
return {
    simulate = function(v3)
        v2 = v2 + v3 * 0.5;
        return {
            main = v0.calculateColorSequence(v1, v2)
        };
    end, 
    apply = function(v4)
        local v5 = {};
        local function _(v6, v7, v8)
            local v9 = v6[v7];
            v6[v7] = v8;
            table.insert(v5, 1, function()
                v6[v7] = v9;
            end);
        end;
        local function v15(v11, v12)
            local l_v11_FirstChildWhichIsA_0 = v11:FindFirstChildWhichIsA(v12);
            if not l_v11_FirstChildWhichIsA_0 then
                local v14 = Instance.new(v12);
                v14.Parent = v11;
                table.insert(v5, 1, function()
                    v14:Destroy();
                end);
                l_v11_FirstChildWhichIsA_0 = v14;
            end;
            return l_v11_FirstChildWhichIsA_0;
        end;
        if v4:IsA("TextLabel") then
            _(v4, "TextColor3", Color3.new(1, 1, 1));
        end;
        local v22 = v15(v4, "UIGradient");
        local v23 = v15(v4, "UIStroke");
        local v24 = v15(v23, "UIGradient");
        _(v22, "Rotation", 90);
        _(v22, "Transparency", NumberSequence.new(0));
        _(v23, "Color", Color3.fromRGB(255, 170, 0));
        _(v23, "Thickness", 3.5);
        _(v23, "Transparency", 0.3);
        _(v24, "Rotation", 90);
        _(v24, "Transparency", NumberSequence.new(0));
        return {
            main = v22, 
            stroke = v24, 
            cleanup = function()
                for _, v39 in v5 do
                    v39();
                end;
            end
        };
    end
};