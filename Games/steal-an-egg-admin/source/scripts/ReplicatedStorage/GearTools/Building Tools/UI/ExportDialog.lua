-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script:FindFirstAncestorWhichIsA("Tool"):WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local createElement = v1.createElement

local function ExportDialog(v2) -- line 8 | captures: v1, createElement
    local v3 = {}
    local v4 = {}
    local v5 = {
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(31, 31, 31),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 200, 0, 0)
    }
    local v6 = { Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }) }
    local v7 = {
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        Modal = true,
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 23),
        Text = "Close",
        Font = Enum.Font.GothamSemibold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11
    }

    v7[v1.Event.Activated] = function(v8) -- line 32 | captures: v2
        v2.OnDismiss()
    end

    v6.CloseButton = createElement("TextButton", v7, { Corners = createElement("UICorner", { CornerRadius = UDim.new(0, 4) }) })
    local v9 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -23),
        Font = Enum.Font.GothamSemibold,
        RichText = true,
        Text = v2.Text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        TextWrapped = true
    }

    v9[v1.Change.TextBounds] = function(v10) -- line 49
        v10.Parent.Size = UDim2.new(0, 200, 0, v10.TextBounds.Y + 23 + 26)
    end

    v6.Text = createElement("TextLabel", v9, {
        Padding = createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10)
        })
    })
    v4.Dialog = createElement("Frame", v5, v6)
    return createElement("ScreenGui", v3, v4)
end

return ExportDialog
