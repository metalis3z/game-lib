-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Digit = require(script.Digit)
local v1 = {}
local v2 = {
    Frame = true,
    Digits = true,
    CommaLabels = true,
    Text = true
}
local v3 = {
    Value = "number",
    Duration = "number",
    Decimals = "number",
    Prefix = "string",
    Suffix = "string",
    Commas = "boolean",
    GuiObject = "Instance"
}
local v4 = {}

v4[Enum.TextXAlignment.Center] = Enum.HorizontalAlignment.Center
v4[Enum.TextXAlignment.Left] = Enum.HorizontalAlignment.Left
v4[Enum.TextXAlignment.Right] = Enum.HorizontalAlignment.Right

local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

TextLabel.TextSize = 25
TextLabel.TextColor3 = Color3.fromRGB(250, 250, 255)
TextLabel.Font = Enum.Font.SourceSans

local function newSpinner() -- line 32 | captures: Digit, v2, v3, v4, Frame, TextLabel
    local v5 = {
        Value = 0,
        Duration = 0.3,
        Decimals = 2,
        Prefix = "$",
        Suffix = "",
        Commas = false,
        GuiObject = nil,
        Digits = {
            Whole = table.create(3),
            Decimal = table.create(2)
        },
        CommaLabels = table.create(2)
    }
    local v6 = {}
    local v7 = {}

    function v7.__index(v8, v9) -- line 53 | captures: v5, Frame, TextLabel
        local v10 = v5[v9]
        if v10 then
            return v10
        end
        if pcall(function() -- line 59 | captures: v9, Frame
                local v11 = Frame[v9]
            end) then
            return v5.Frame[v9]
        end
        local v12, v13 = pcall(function() -- line 66 | captures: v9, TextLabel
            return TextLabel[v9]
        end)
        if v12 then
            local v14 = v5.Digits.Whole[1]
            if v14 then
                return v14[v9]
            end
            return v13
        end
        return nil
    end

    function v7.__newindex(v15, v16, v17) -- line 81 | captures: v5, v2, v3, v4, Frame, TextLabel
        if v2[v16] then
            warn("Attempted to set read-only value Spinner." .. v16)
        elseif pcall(function() -- line 88 | captures: v16, Frame
                local v18 = Frame[v16]
            end) then
            local v19 = Frame[v16]
            local v20 = typeof(v19)
            if v20 == "nil" or v20 == typeof(v17) then
                v5.Frame[v16] = v17
            else
                warn("Attempted to set Spinner." .. v16 .. " to invalid value (" .. tostring(v17) .. ")")
            end
        elseif v16 == "TextXAlignment" then
            v5.Layout.HorizontalAlignment = v4[v17]
        elseif pcall(function() -- line 108 | captures: v16, TextLabel
                local v21 = TextLabel[v16]
            end) then
            local v22 = TextLabel[v16]
            local v23 = typeof(v22)
            if v23 == "nil" or v23 == typeof(v17) then
                for v24, v25 in pairs(v5.Digits.Whole) do
                    v25[v16] = v17
                end
                for v26, v27 in pairs(v5.Digits.Decimal) do
                    v27[v16] = v17
                end
                for v28, v29 in pairs(v5.CommaLabels) do
                    v29[v16] = v17
                end
                v5.PrefixLabel[v16] = v17
                v5.SuffixLabel[v16] = v17
                v5.DecimalLabel[v16] = v17
                v5.NegativeLabel[v16] = v17
            else
                warn("Attempted to set Spinner." .. v16 .. " to invalid value (" .. tostring(v17) .. ")")
            end
        elseif v3[v16] then
            if typeof(v17) == v3[v16] then
                v5[v16] = v17
                v5:Update(v16, v17)
            else
                warn("Attempted to set Spinner." .. v16 .. " to invalid value (" .. tostring(v17) .. ")")
            end
        end
    end

    local v30 = setmetatable(v6, v7)

    local function Destroy(v31) -- line 146
        v31.Frame:Destroy()
        table.clear(v31)
    end

    v5.Destroy = Destroy

    function v5.Update(v32, v33, v34) -- line 151 | captures: v5, v30, Digit
        if v33 == "Prefix" then
            v5.PrefixLabel.Text = v5.Prefix
        elseif v33 == "Suffix" then
            v5.SuffixLabel.Text = v5.Suffix
        else
            local Value = v5.Value
            local v35 = math.abs(Value)
            local v36 = v5.Value < 0
            if v5.NegativeLabel then
                v5.NegativeLabel.Visible = v36
            end
            local v37 = v5.Decimals > 0 and string.format("%." .. v5.Decimals .. "f", v35) or string.format("%d", v35)
            local v38 = string.split(v37, ".")
            local v39 = v38[1]
            local v40 = v38[2]
            if v39 then
                local v41 = #v39
                for v42 = 1, v41 do
                    local v43 = v5.Digits.Whole[v42]
                    if v43 then
                        v43.Duration = v5.Duration
                        local v44 = string.sub(v39, v42, v42)
                        v43.Value = tonumber(v44)
                    else
                        local new = Digit.new
                        local v45 = v42 * 2 - 900
                        local v46 = string.sub(v39, v42, v42)
                        local v47 = new(v30, v45, (tonumber(v46)))
                        v5.Digits.Whole[v42] = v47
                    end
                end
                local v48 = v41 + 1
                local v49 = #v5.Digits.Whole
                for v50 = v48, v49 do
                    local v51 = v5.Digits.Whole[v50]
                    if v51 then
                        v51:Destroy()
                        v5.Digits.Whole[v50] = nil
                    end
                end
                if v5.Commas then
                    local v52 = v41 * 2 - 900
                    local format = string.format
                    local Value = v5.Value
                    local v53 = math.abs(Value)
                    local v54 = #format("%d", (math.floor(v53))) - 1
                    local v55 = 0
                    for v56 = 0, v54, 3 do
                        if v56 ~= 0 then
                            local v57 = v55 + 1
                            local v58 = v5.CommaLabels[v57]
                            if not v58 then
                                v58 = Instance.new("TextLabel")
                                v58.Name = "Comma"
                                v58.BackgroundTransparency = 1
                                v58.Size = UDim2.new(0, 0, 1, 0)
                                v58.Font = v30.Font
                                v58.TextSize = v30.TextSize
                                v58.TextColor3 = v30.TextColor3
                                v58.Text = ","
                                v58.AutomaticSize = Enum.AutomaticSize.X
                                v58.Parent = v5.Frame
                                v5.CommaLabels[v57] = v58
                            end
                            v58.LayoutOrder = v52 - (v56 - 1) * 2 - 1
                            v55 = v57
                        end
                    end
                    local v59 = v55 + 1
                    local v60 = #v5.CommaLabels
                    for v61 = v59, v60 do
                        v5.CommaLabels[v61]:Destroy()
                        v5.CommaLabels[v61] = nil
                    end
                end
                if v40 then
                    if v5.DecimalLabel then
                        v5.DecimalLabel.Visible = true
                    end
                    local v62 = #v40
                    for v63 = 1, v62 do
                        local v64 = v5.Digits.Decimal[v63]
                        if v64 then
                            v64.Duration = v5.Duration
                            local v65 = string.sub(v40, v63, v63)
                            v64.Value = tonumber(v65)
                        else
                            local new = Digit.new
                            local v66 = string.sub(v40, v63, v63)
                            local v67 = new(v30, v63, (tonumber(v66)))
                            v5.Digits.Decimal[v63] = v67
                        end
                    end
                    local v68 = #v40 + 1
                    local v69 = #v5.Digits.Decimal
                    for v70 = v68, v69 do
                        local v71 = v5.Digits.Decimal[v70]
                        if v71 then
                            v71:Destroy()
                            v5.Digits.Decimal[v70] = nil
                        end
                    end
                else
                    if v5.DecimalLabel then
                        v5.DecimalLabel.Visible = false
                    end
                    for v72, v73 in ipairs(v5.Digits.Decimal) do
                        v73:Destroy()
                    end
                    table.clear(v5.Digits.Decimal)
                end
            end
        end
    end

    return v30, v5
end

function v1.new() -- line 266 | captures: newSpinner
    local v74, v75 = newSpinner()
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.ClipsDescendants = true
    Frame.Size = UDim2.new(0, 200, 0, 50)
    Frame.Position = UDim2.new(0, 0, 0, 0)
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 0)
    UIListLayout.Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Prefix"
    TextLabel.LayoutOrder = -1000
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(0, 0, 1, 0)
    TextLabel.Font = v74.Font
    TextLabel.TextSize = v74.TextSize
    TextLabel.TextColor3 = v74.TextColor3
    TextLabel.Text = v74.Prefix
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Parent = Frame
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Suffix"
    TextLabel_2.LayoutOrder = 1000
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Size = UDim2.new(0, 0, 1, 0)
    TextLabel_2.Font = v74.Font
    TextLabel_2.TextSize = v74.TextSize
    TextLabel_2.TextColor3 = v74.TextColor3
    TextLabel_2.Text = v74.Suffix
    TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_2.Parent = Frame
    local TextLabel_3 = Instance.new("TextLabel")
    TextLabel_3.Name = "Decimal"
    TextLabel_3.LayoutOrder = 0
    TextLabel_3.BackgroundTransparency = 1
    TextLabel_3.Size = UDim2.new(0, 0, 1, 0)
    TextLabel_3.Font = v74.Font
    TextLabel_3.TextSize = v74.TextSize
    TextLabel_3.TextColor3 = v74.TextColor3
    TextLabel_3.Text = "."
    TextLabel_3.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_3.Parent = Frame
    local TextLabel_4 = Instance.new("TextLabel")
    TextLabel_4.Name = "Negative"
    TextLabel_4.LayoutOrder = -999
    TextLabel_4.BackgroundTransparency = 1
    TextLabel_4.Size = UDim2.new(0, 0, 1, 0)
    TextLabel_4.Font = v74.Font
    TextLabel_4.TextSize = v74.TextSize
    TextLabel_4.TextColor3 = v74.TextColor3
    TextLabel_4.Text = "-"
    TextLabel_4.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_4.Parent = Frame
    v75.Frame = Frame
    v75.Layout = UIListLayout
    v75.PrefixLabel = TextLabel
    v75.SuffixLabel = TextLabel_2
    v75.DecimalLabel = TextLabel_3
    v75.NegativeLabel = TextLabel_4
    v74.GuiObject = Frame
    v74:Update()
    return v74
end

function v1.fromGuiObject(v76) -- line 345 | captures: v1, v4
    if not (not typeof(v76) ~= "Instance" and v76:IsA("GuiObject")) then
        return
    end
    local v77 = v1.new()
    v77.Name = "Spinner_" .. v76.Name
    v77.SizeConstraint = v76.SizeConstraint
    v77.Size = v76.Size
    v77.Position = v76.Position
    v77.AnchorPoint = v76.AnchorPoint
    v77.Rotation = v76.Rotation
    v77.LayoutOrder = v76.LayoutOrder
    v77.ZIndex = v76.ZIndex
    v77.Visible = v76.Visible
    v77.BackgroundColor3 = v76.BackgroundColor3
    v77.BorderColor3 = v76.BorderColor3
    v77.BorderSizePixel = v76.BorderSizePixel
    v77.BackgroundTransparency = v76.BackgroundTransparency
    if v76:IsA("TextLabel") or v76:IsA("TextButton") or v76:IsA("TextBox") then
        v77.Font = v76.Font
        v77.TextSize = v76.TextSize
        v77.TextColor3 = v76.TextColor3
        v77.TextTransparency = v76.TextTransparency
        v77.TextStrokeColor3 = v76.TextStrokeColor3
        v77.TextStrokeTransparency = v76.TextStrokeTransparency
        v77.Layout.HorizontalAlignment = v4[v76.TextXAlignment]
    end
    v77.Parent = v76.Parent
    v76.Visible = false
    return v77
end

return v1
