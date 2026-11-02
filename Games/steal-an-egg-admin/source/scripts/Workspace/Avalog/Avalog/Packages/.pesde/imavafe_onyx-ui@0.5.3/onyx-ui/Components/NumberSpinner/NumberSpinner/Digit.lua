-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.15)
local v2 = {}

function v2.new(v3, v4, v5) -- line 8 | captures: TextService, TweenService, v1
    local v6 = {
        Duration = v3.Duration,
        Value = v5,
        Labels = table.create(10),
        CanvasTweens = table.create(10)
    }
    local v7 = TweenInfo.new(v3.Duration)
    local v8 = v7
    local Frame = Instance.new("Frame")
    Frame.Name = "digit"
    Frame.LayoutOrder = v4
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(0, 0, 0, v3.TextSize + 6)
    Frame.ClipsDescendants = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "canvas"
    Frame_2.Size = UDim2.new(1, 0, 10, 0)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame
    Frame_2.Position = UDim2.new(0, 0, -v6.Value, 0)
    for v9 = 0, 9 do
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "n_" .. v9
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextSize = v3.TextSize
        TextLabel.TextColor3 = v3.TextColor3
        TextLabel.Font = v3.Font
        TextLabel.Text = v9
        TextLabel.Size = UDim2.new(1, 0, 0.1, 0)
        TextLabel.Position = UDim2.new(0, 0, v9 * 0.1, 0)
        TextLabel.Parent = Frame_2
        v6.Labels[v9] = TextLabel
        v6.CanvasTweens[v9] = TweenService:Create(Frame_2, v7, { Position = UDim2.new(0, 0, -v9, 0) })
    end
    Frame.Parent = v3.Frame
    local v10 = TextService:GetTextSize("8", v3.TextSize, v3.Font, Vector2.new(v3.TextSize, v3.TextSize))
    TweenService:Create(Frame, v1, { Size = UDim2.new(0, v10.X + 1, 0, v10.Y + 10) }):Play()
    local v11 = {}
    local v12 = {}

    function v12.__index(v13, v14) -- line 55 | captures: v6
        local v15 = v6[v14]
        if v15 then
            return v15
        end
        if pcall(function() -- line 61 | captures: v14, v6
                local v16 = v6.Labels[1][v14]
            end) then
            return v6.Labels[1][v14]
        end
        return nil
    end

    function v12.__newindex(v17, v18, v19) -- line 70 | captures: v6
        if v6[v18] then
            v6[v18] = v19
            v6:Update(v18, v19)
        elseif pcall(function() -- line 78 | captures: v18, v6
                local v20 = v6.Labels[1][v18]
            end) then
            v6.Labels[0][v18] = v19
            v6.Labels[1][v18] = v19
            v6.Labels[2][v18] = v19
            v6.Labels[3][v18] = v19
            v6.Labels[4][v18] = v19
            v6.Labels[5][v18] = v19
            v6.Labels[6][v18] = v19
            v6.Labels[7][v18] = v19
            v6.Labels[8][v18] = v19
            v6.Labels[9][v18] = v19
            v6:Update(v18, v19)
        end
    end

    local v21 = setmetatable(v11, v12)

    function v6.Destroy(v22) -- line 90 | captures: v3, v6, Frame, TextService, TweenService, v1
        local v23 = TextService:GetTextSize("8", v3.TextSize, v3.Font, Vector2.new(v3.TextSize, v3.TextSize))
        local v24 = TweenService:Create(Frame, v1, { Size = UDim2.new(0, 0, 0, v23.Y + 10) })
        v24.Completed:Connect(function() -- line 98 | captures: v24, v6, Frame
            Frame:Destroy()
            table.clear(v6)
            v24:Destroy()
        end)
        v24:Play()
    end

    function v6.Update(v25, v26, v27) -- line 106 | captures: v8, v3, v6, Frame, Frame_2, TextService, TweenService, v1
        if v26 == "Duration" then
            v8 = TweenInfo.new(v27)
            for v28 = 0, 9 do
                v6.CanvasTweens[v28] = TweenService:Create(Frame_2, v8, { Position = UDim2.new(0, 0, -v28, 0) })
            end
        elseif v26 == "Value" then
            v6.CanvasTweens[v27]:Play()
        elseif v26 == "TextSize" or v26 == "Font" then
            local v29 = TextService:GetTextSize("8", v3.TextSize, v3.Font, Vector2.new(v3.TextSize, v3.TextSize))
            TweenService:Create(Frame, v1, { Size = UDim2.new(0, v29.X + 1, 0, v29.Y + 10) }):Play()
        end
    end

    return v21
end

return v2
