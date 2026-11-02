-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local TextService = game:GetService("TextService")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement
local v2 = v1.PureComponent:extend(script.Name)

function v2.init(v3) -- line 12
    v3:UpdateHotkeyTextSize(v3.props.HotkeyLabel)
end

function v2.willUpdate(v4, v5) -- line 16
    if v4.props.HotkeyLabel ~= v5.HotkeyLabel then
        v4:UpdateHotkeyTextSize(v5.HotkeyLabel)
    end
end

function v2.UpdateHotkeyTextSize(v6, v7) -- line 22 | captures: TextService
    v6.HotkeyTextSize = TextService:GetTextSize(v7, 9, Enum.Font.Gotham, Vector2.new((1/0), (1/0)))
end

function v2.render(v8) -- line 31 | captures: v1, createElement
    local v9 = { BackgroundColor3 = v8.props.Tool.Color.Color }
    if v8.props.CurrentTool == v8.props.Tool then
        v9.BackgroundTransparency = 0
    else
        v9.BackgroundTransparency = 1
    end
    v9.BorderSizePixel = 0
    v9.Image = v8.props.IconAssetId
    v9.AutoButtonColor = false

    v9[v1.Event.Activated] = function() -- line 38 | captures: v8
        v8.props.Core.EquipTool(v8.props.Tool)
    end

    return createElement("ImageButton", v9, {
        Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
        Hotkey = createElement("TextLabel", {
            BackgroundTransparency = 1,
            TextSize = 9,
            Position = UDim2.new(0, 3, 0, 3),
            Size = UDim2.fromOffset(v8.HotkeyTextSize.X, v8.HotkeyTextSize.Y),
            Font = Enum.Font.Gotham,
            Text = v8.props.HotkeyLabel,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        })
    })
end

return v2
