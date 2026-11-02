



local v_u_1 = game:GetService("TweenService")
local v_u_2 = {}
local v_u_3 = {
    ["TextLabel"] = { "TextTransparency", "BackgroundTransparency", "TextStrokeTransparency" },
    ["TextButton"] = { "TextTransparency", "BackgroundTransparency", "TextStrokeTransparency" },
    ["TextBox"] = { "TextTransparency", "BackgroundTransparency", "TextStrokeTransparency" },
    ["ViewportFrame"] = { "ImageTransparency", "BackgroundTransparency" },
    ["ImageButton"] = { "ImageTransparency", "BackgroundTransparency" },
    ["ImageLabel"] = { "ImageTransparency", "BackgroundTransparency" },
    ["Frame"] = { "BackgroundTransparency" },
    ["ScrollingFrame"] = { "ScrollBarImageTransparency", "BackgroundTransparency" },
    ["CanvasGroup"] = { "GroupTransparency", "BackgroundTransparency" },
    ["UIStroke"] = { "Transparency" }
}
local v4 = {}
local function v_u_11(p5, p6, p7)
    local v8 = TweenInfo.new(p6)
    for _, v9 in p5 do
        for _, v10 in v_u_3[v9.ClassName] or {} do
            if v9:GetAttribute("OriginalTransparency" .. v10) == nil then
                v9:SetAttribute("OriginalTransparency" .. v10, v9[v10])
            end
            v_u_1:Create(v9, v8, {
                [v10] = p7(v9, v10)
            }):Play()
        end
    end
end
function v4.fadeIn(p12, p_u_13)
    local v14 = p12:GetDescendants()
    table.insert(v14, p12)
    v_u_11(v14, p_u_13, function(p15, p16)
        return p15:GetAttribute("OriginalTransparency" .. p16) or 0
    end)
    v_u_2[p12] = v_u_2[p12] or {}
    local v17 = v_u_2[p12]
    local v18 = p12.DescendantAdded
    local function v22(p19)
        v_u_11({ p19 }, p_u_13, function(p20, p21)
            return p20:GetAttribute("OriginalTransparency" .. p21) or 0
        end)
    end
    table.insert(v17, v18:Connect(v22))
end
function v4.fadeOut(p23, p24, p25)
    local v_u_26 = p25 or 1
    local v27 = p23:GetDescendants()
    table.insert(v27, p23)
    v_u_11(v27, p24, function(_, _)
        return v_u_26
    end)
    if v_u_2[p23] then
        for _, v28 in v_u_2[p23] do
            v28:Disconnect()
        end
        v_u_2[p23] = nil
    end
end
return table.freeze(v4)