


local v_u_1 = game:GetService("TweenService")
local v2 = script.Parent
local function v_u_32(p3)
    for _, v_u_4 in ipairs(p3:GetDescendants()) do
        if v_u_4:IsA("Texture") then
            local v5 = v_u_4.Parent
            local v6 = v5:GetAttribute("Axis") or "X"
            local v_u_7 = tostring(v6) == "Y" and "OffsetStudsV" or "OffsetStudsU"
            local v8 = v5:GetAttribute("Direction") or "Positive"
            local v_u_9 = tostring(v8) == "Negative" and -1 or 1
            local v10 = tonumber(v5:GetAttribute("Speed"))
            local v_u_11 = v10 and (math.abs(v10) > 0 and math.abs(v10)) or 1
            local function v_u_17()
                local v12 = v_u_9 * 2000
                local v13 = v_u_11
                local v14 = math.abs(v12) / math.max(v13, 0.001)
                local v15 = {
                    [v_u_7] = v_u_4[v_u_7] + v12
                }
                local v16 = v_u_1:Create(v_u_4, TweenInfo.new(v14, Enum.EasingStyle.Linear), v15)
                v16.Completed:Connect(function()
                    v_u_4[v_u_7] = 0
                    v_u_17()
                end)
                v16:Play()
            end
            v_u_17()
        end
    end
    p3.DescendantAdded:Connect(function(p_u_18)
        if p_u_18:IsA("Texture") then
            local v19 = p_u_18.Parent
            local v20 = v19:GetAttribute("Axis") or "X"
            local v_u_21 = tostring(v20) == "Y" and "OffsetStudsV" or "OffsetStudsU"
            local v22 = v19:GetAttribute("Direction") or "Positive"
            local v_u_23 = tostring(v22) == "Negative" and -1 or 1
            local v24 = tonumber(v19:GetAttribute("Speed"))
            local v_u_25 = v24 and (math.abs(v24) > 0 and math.abs(v24)) or 1
            local function v_u_31()
                local v26 = v_u_23 * 2000
                local v27 = v_u_25
                local v28 = math.abs(v26) / math.max(v27, 0.001)
                local v29 = {
                    [v_u_21] = p_u_18[v_u_21] + v26
                }
                local v30 = v_u_1:Create(p_u_18, TweenInfo.new(v28, Enum.EasingStyle.Linear), v29)
                v30.Completed:Connect(function()
                    p_u_18[v_u_21] = 0
                    v_u_31()
                end)
                v30:Play()
            end
            v_u_31()
        end
    end)
end
for _, v33 in ipairs(v2:GetDescendants()) do
    if v33.Name == "Conveyor" then
        v_u_32(v33)
    end
end
v2.DescendantAdded:Connect(function(p34)
    if p34.Name == "Conveyor" then
        v_u_32(p34)
    end
end)