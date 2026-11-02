-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    "#",
    "%",
    "&",
    "$",
    "@",
    "/",
    "\\",
    "0",
    "1",
    "7",
    "X",
    "?"
}
local v2 = {}
local v3 = Color3.fromRGB(0, 229, 255)
local v4 = Color3.fromRGB(255, 238, 0)

v2[1] = v3
v2[2] = v4
v2[3] = Color3.fromRGB(255, 0, 128)

local v5 = {}

v5[1] = Color3.fromRGB(255, 0, 110)
v5[2] = Color3.fromRGB(0, 225, 255)

local v6 = {}

function v6.Bind(v7) -- line 31 | captures: v1, v2, v5
    local TextLabel = v7:IsA("TextLabel")
    local v8 = ("%* must be a TextLabel to glitch"):format((v7:GetFullName()))
    assert(TextLabel, v8)
    local v9 = v7:GetAttribute("TextGlitchIntervalMin") or 1.2
    local v10 = v7:GetAttribute("TextGlitchIntervalMax") or 3.5
    local v11 = v7:GetAttribute("TextGlitchBurstMin") or 0.12
    local v12 = v7:GetAttribute("TextGlitchBurstMax") or 0.35
    local v13 = v7:GetAttribute("TextGlitchGhosts") ~= false
    local v14 = Random.new()
    local UIStroke = v7:FindFirstChildOfClass("UIStroke")
    local UIGradient = v7:FindFirstChildOfClass("UIGradient")
    local Position = v7.Position
    local Rotation = v7.Rotation
    local TextTransparency = v7.TextTransparency
    local Color
    if UIStroke == nil then
    else
        Color = UIStroke.Color
    end
    local Offset
    if UIGradient == nil then
    else
        Offset = UIGradient.Offset
    end
    local Text = v7.Text
    local ZIndex = v7.ZIndex
    local v15 = {}
    local v16 = false
    local v17 = false
    local v18 = v7:GetPropertyChangedSignal("Text"):Connect(function() -- line 62 | captures: Text, v16, v7
        if not v16 then
            Text = v7.Text
        end
    end)
    local v19
    if v13 then
        local ZIndex = v7.ZIndex
        v7.ZIndex = math.max(ZIndex, 2)
        v19 = v7
        for v20, v21 in v5 do
            local v22 = v7:Clone()
            v22:ClearAllChildren()
            for v23 in v22:GetAttributes() do
                v22:SetAttribute(v23, nil)
            end
            v22.Name = "GlitchGhost"
            v22.TextColor3 = v21
            v22.TextTransparency = 1
            v22.BackgroundTransparency = 1
            v22.ZIndex = v7.ZIndex - 1
            v22.Parent = v7.Parent
            table.insert(v15, v22)
        end
    else
        v19 = v7
    end

    local function scrambled() -- line 91 | captures: Text, v14, v1
        local v24 = {}
        local v25 = #Text
        for v26 = 1, v25 do
            local Text_2 = Text
            v24[v26] = string.sub(Text_2, v26, v26)
        end
        local v27 = v14:NextInteger(1, 2)
        for v28 = 1, v27 do
            local v29 = #v24
            local v30 = v14:NextInteger(1, (math.max(v29, 1)))
            if v24[v30] ~= nil and v24[v30] ~= " " then
                v24[v30] = v1[v14:NextInteger(1, #v1)]
            end
        end
        return table.concat(v24)
    end

    local function setGhosts(v31, v32, v33) -- line 109 | captures: v19, Position, v15
        for v34, v35 in v15 do
            if v31 then
                local v36 = if v34 == 1 then 1 else -1
                v35.Text = v19.Text
                v35.Rotation = v19.Rotation
                v35.TextTransparency = 0.25
                v35.Position = Position + UDim2.fromOffset(v32 + v36 * 3, v33 + v36 * 2)
            else
                v35.TextTransparency = 1
            end
        end
    end

    local function restore() -- line 131 | captures: Color, Offset, v19, Text, v16, UIStroke, UIGradient, Position, Rotation, TextTransparency, v15
        v19.Text = Text
        v19.Position = Position
        v19.Rotation = Rotation
        v19.TextTransparency = TextTransparency
        if UIStroke ~= nil and Color ~= nil then
            UIStroke.Color = Color
        end
        if UIGradient ~= nil and Offset ~= nil then
            UIGradient.Offset = Offset
        end
        for v37, v38 in v15 do
            v38.TextTransparency = 1
        end
        v16 = false
    end

    local function burst() -- line 150 | captures: Color, Offset, v19, Text, v16, v17, v11, v12, v14, UIStroke, UIGradient, Position, Rotation, TextTransparency, v15, scrambled, setGhosts, v2
        v16 = true
        local v39 = v14:NextNumber(v11, v12)
        local v40 = 0
        while true do
            local v41, v42, v43, v44
            if v40 < v39 then
                if v17 then
                    v44 = true
                else
                    v41 = v14:NextInteger(-4, 4)
                    v42 = v14:NextInteger(-3, 3)
                    v19.Position = Position + UDim2.fromOffset(v41, v42)
                    v19.Rotation = Rotation + v14:NextNumber(-2, 2)
                    if v14:NextNumber() >= 0.65 then
                        v43 = Text
                    else
                        v43 = scrambled()
                    end
                    v44 = false
                end
            else
                v44 = true
            end
            if v44 then
                break
            end
            v19.Text = v43
            local v45 = if v14:NextNumber() >= 0.12 then TextTransparency else 1
            v19.TextTransparency = v45
            if UIStroke ~= nil and Color ~= nil then
                local v46 = if v14:NextNumber() >= 0.5 then Color else v2[v14:NextInteger(1, #v2)]
                UIStroke.Color = v46
            end
            if UIGradient ~= nil then
                local v47 = v14:NextNumber(-0.5, 0.5)
                UIGradient.Offset = Vector2.new(v47, 0)
            end
            setGhosts(true, v41, v42)
            v40 += task.wait(0.03)
        end
        v19.Text = Text
        v19.Position = Position
        v19.Rotation = Rotation
        v19.TextTransparency = TextTransparency
        if UIStroke ~= nil and Color ~= nil then
            UIStroke.Color = Color
        end
        if UIGradient ~= nil and Offset ~= nil then
            UIGradient.Offset = Offset
        end
        for v48, v49 in v15 do
            v49.TextTransparency = 1
        end
        v16 = false
    end

    task.spawn(function() -- line 211 | captures: v17, v9, v10, v14, burst
        while not v17 do
            task.wait(v14:NextNumber(v9, v10))
            if v17 then
                break
            end
            burst()
        end
    end)
    return function() -- line 220 | captures: Color, Offset, v19, Text, v16, v17, UIStroke, UIGradient, Position, Rotation, TextTransparency, ZIndex, v15, v18
        if v17 then
            return
        end
        v17 = true
        v18:Disconnect()
        v19.Text = Text
        v19.Position = Position
        v19.Rotation = Rotation
        v19.TextTransparency = TextTransparency
        if UIStroke ~= nil and Color ~= nil then
            UIStroke.Color = Color
        end
        if UIGradient ~= nil and Offset ~= nil then
            UIGradient.Offset = Offset
        end
        for v50, v51 in v15 do
            v51.TextTransparency = 1
        end
        v16 = false
        v19.ZIndex = ZIndex
        for v52, v53 in v15 do
            v53:Destroy()
        end
        table.clear(v15)
    end
end

return v6
