-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = script.Parent.Icon
local v_u_2 = script.Parent.Amount
local function v7(p3)
    if p3 == "Text" then
        local v4 = v_u_2.TextBounds.X
        local v5 = v_u_1.AbsoluteSize.X
        local v6 = v_u_2.Position
        v_u_2.Position = UDim2.new(v6.X.Scale, v6.X.Offset - v5 / 2, v6.Y.Scale, v6.Y.Offset)
        v_u_1.Position = UDim2.new(0.5, v4 / 2 + 6, 0.5, 0)
    end
end
v7("Text")
v_u_2.Changed:Connect(v7)