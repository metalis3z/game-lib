
local function v_u_11(p1, p2, p3)
    local v4, v5, v6 = p1:ToHSV()
    local v7, v8, v9 = p2:ToHSV()
    local v10 = (v4 + ((v7 - v4 + 0.5) % 1 - 0.5) * p3) % 1
    return Color3.fromHSV(v10, v5 + (v8 - v5) * p3, v6 + (v9 - v6) * p3)
end
return function(p12, p13)
    local v14 = p12.Keypoints
    if p13 <= 0 then
        return v14[1].Value
    end
    if p13 >= 1 then
        return v14[#v14].Value
    end
    for v15 = 1, #v14 - 1 do
        local v16 = v14[v15]
        local v17 = v14[v15 + 1]
        if v16.Time <= p13 and p13 < v17.Time then
            return v_u_11(v16.Value, v17.Value, (p13 - v16.Time) / (v17.Time - v16.Time))
        end
    end
    return v14[#v14].Value
end