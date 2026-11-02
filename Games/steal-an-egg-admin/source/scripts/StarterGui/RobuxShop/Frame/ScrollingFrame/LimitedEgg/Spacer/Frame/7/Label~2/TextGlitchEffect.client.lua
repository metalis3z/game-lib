-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local TextLabel = Parent:IsA("TextLabel")
assert(TextLabel, "Put this LocalScript inside the MECHA TextLabel")
local v1 = Random.new()
local v2 = {
    BurstIntervalMin = 1.2,
    BurstIntervalMax = 3.5,
    BurstDurationMin = 0.12,
    BurstDurationMax = 0.35,
    TickRate = 0.03,
    JitterX = 4,
    JitterY = 3,
    RotationJitter = 2,
    ScrambleChance = 0.65,
    MaxScrambledChars = 2,
    AberrationEnabled = true,
    AberrationOffset = 3,
    AberrationTransparency = 0.25,
    FlickerChance = 0.12,
    StrokeFlashChance = 0.5,
    GradientSlide = true,
    GlitchChars = {
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
        "?",
        "\226\150\147",
        "\226\150\146",
        "\226\150\145"
    },
    AberrationColorA = Color3.fromRGB(255, 0, 110),
    AberrationColorB = Color3.fromRGB(0, 225, 255)
}
local v3 = {}
local v4 = Color3.fromRGB(0, 229, 255)
local v5 = Color3.fromRGB(255, 238, 0)

v3[1] = v4
v3[2] = v5
v3[3] = Color3.fromRGB(255, 0, 128)
v2.StrokeFlashColors = v3

local Text = Parent.Text
local Position = Parent.Position
local Rotation = Parent.Rotation
local TextTransparency = Parent.TextTransparency
local UIStroke = Parent:FindFirstChildOfClass("UIStroke")
local v6 = UIStroke

if UIStroke then
    v6 = UIStroke.Color
end
local UIGradient = Parent:FindFirstChildOfClass("UIGradient")
local v7 = UIGradient

if UIGradient then
    v7 = UIGradient.Offset
end
local v8 = {}

if v2.AberrationEnabled then
    local ZIndex = Parent.ZIndex
    Parent.ZIndex = math.max(ZIndex, 2)
    for v9, v10 in {
            v2.AberrationColorA,
            v2.AberrationColorB
        } do
        local v11 = Parent:Clone()
        v11:ClearAllChildren()
        v11.Name = "GlitchGhost"
        v11.TextColor3 = v10
        v11.TextTransparency = 1
        v11.BackgroundTransparency = 1
        v11.ZIndex = Parent.ZIndex - 1
        v11.Parent = Parent.Parent
        table.insert(v8, v11)
    end
end

local function scrambleText() -- line 87 | captures: v1, v2, Text
    local v12 = {}
    local v13 = #Text
    for v14 = 1, v13 do
        v12[v14] = string.sub(Text, v14, v14)
    end
    local v15 = v1:NextInteger(1, v2.MaxScrambledChars)
    for v16 = 1, v15 do
        local v17 = v1:NextInteger(1, #v12)
        if v12[v17] ~= " " then
            v12[v17] = v2.GlitchChars[v1:NextInteger(1, #v2.GlitchChars)]
        end
    end
    return table.concat(v12)
end

local function setGhosts(v18, v19, v20) -- line 105 | captures: Parent, v2, Position, v8
    for v21, v22 in v8 do
        if v18 then
            local v23 = if v21 == 1 then 1 else -1
            v22.Text = Parent.Text
            v22.Rotation = Parent.Rotation
            v22.TextTransparency = v2.AberrationTransparency
            local fromOffset = UDim2.fromOffset
            local v24 = v19 + v23 * v2.AberrationOffset
            local v25 = v2.AberrationOffset / 2
            v22.Position = Position + fromOffset(v24, v20 + v23 * math.ceil(v25))
        else
            v22.TextTransparency = 1
        end
    end
end

local function restore() -- line 127 | captures: v6, v7, Parent, Text, Position, Rotation, TextTransparency, UIStroke, UIGradient, v8
    Parent.Text = Text
    Parent.Position = Position
    Parent.Rotation = Rotation
    Parent.TextTransparency = TextTransparency
    if UIStroke then
        UIStroke.Color = v6
    end
    if UIGradient then
        UIGradient.Offset = v7
    end
    for v26, v27 in v8 do
        v27.TextTransparency = 1
    end
end

local function doBurst() -- line 145 | captures: v6, v7, Parent, v1, v2, Text, Position, Rotation, TextTransparency, UIStroke, UIGradient, v8, scrambleText, setGhosts
    local v28 = v1:NextNumber(v2.BurstDurationMin, v2.BurstDurationMax)
    local v29 = 0
    while true do
        local v30, v31
        if v29 < v28 then
            v30 = v1:NextInteger(-v2.JitterX, v2.JitterX)
            local v32 = -v2.JitterY
            v31 = v1:NextInteger(v32, v2.JitterY)
            Parent.Position = Position + UDim2.fromOffset(v30, v31)
            Parent.Rotation = Rotation + v1:NextNumber(-v2.RotationJitter, v2.RotationJitter)
            local v33 = v1:NextNumber()
            if v2.ScrambleChance <= v33 then
                Parent.Text = Text
            else
                Parent.Text = scrambleText()
            end
        else
            break
        end
        local v34 = v1:NextNumber()
        local v35 = if v2.FlickerChance <= v34 then TextTransparency else 1
        Parent.TextTransparency = v35
        if UIStroke then
            local v36 = v1:NextNumber()
            if v2.StrokeFlashChance <= v36 then
                UIStroke.Color = v6
            else
                UIStroke.Color = v2.StrokeFlashColors[v1:NextInteger(1, #v2.StrokeFlashColors)]
            end
        end
        if UIGradient and v2.GradientSlide then
            local v37 = v1:NextNumber(-0.5, 0.5)
            UIGradient.Offset = Vector2.new(v37, 0)
        end
        setGhosts(true, v30, v31)
        v29 += task.wait(v2.TickRate)
    end
    Parent.Text = Text
    Parent.Position = Position
    Parent.Rotation = Rotation
    Parent.TextTransparency = TextTransparency
    if UIStroke then
        UIStroke.Color = v6
    end
    if UIGradient then
        UIGradient.Offset = v7
    end
    for v38, v39 in v8 do
        v39.TextTransparency = 1
    end
end

task.spawn(function() -- line 200 | captures: Parent, v1, v2, doBurst
    while Parent.Parent do
        task.wait(v1:NextNumber(v2.BurstIntervalMin, v2.BurstIntervalMax))
        doBurst()
    end
end)
