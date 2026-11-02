-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = Vector2.new(0.5, 0.5)
local freeze = table.freeze
local v2 = {
    ScaleUDim2 = function(v3, v4) -- ScaleUDim2 | line 10
        return UDim2.new(v3.X.Scale * v4, v3.X.Offset * v4, v3.Y.Scale * v4, v3.Y.Offset * v4)
    end
}

function v2.EnsureScale(v5) -- line 13 | captures: t
    t.strict(t.instanceIsA("GuiObject"))(v5)
    local UIScale = v5:FindFirstChildWhichIsA("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Parent = v5
    return UIScale_2
end

function v2.CenterAnchor(v6) -- line 24 | captures: t, v1
    t.strict(t.instanceIsA("GuiObject"))(v6)
    local AnchorPoint = v6.AnchorPoint
    if AnchorPoint == v1 then
        return
    end
    local Position = v6.Position
    local Size = v6.Size
    local v7 = v1 - AnchorPoint
    v6.AnchorPoint = v1
    v6.Position = UDim2.new(Position.X.Scale + Size.X.Scale * v7.X, Position.X.Offset + Size.X.Offset * v7.X, Position.Y.Scale + Size.Y.Scale * v7.Y, Position.Y.Offset + Size.Y.Offset * v7.Y)
end

function v2.SetLabelWithShadow(v8, v9, v10, v11) -- line 37 | captures: t
    t.strict(t.string)(v9)
    t.strict(t.instanceIsA("TextLabel"))(v8)
    t.strict(t.optional(t.Color3))(v10)
    t.strict(t.optional(t.string))(v11)
    v8.Text = v11 or v9
    local Shadow = v8:FindFirstChild("Shadow")
    if Shadow ~= nil then
        Shadow.Text = v9
        if v10 ~= nil then
            Shadow.TextColor3 = v10
        end
    end
end

function v2.SwapGradient(v12, v13) -- line 56
    for v14, v15 in v12:GetChildren() do
        if v15:IsA("UIGradient") then
            v15:Destroy()
        end
    end
    if v13 == nil then
        return nil
    end
    local v16 = v13:Clone()
    v16.Parent = v12
    return v16
end

return freeze(v2)
