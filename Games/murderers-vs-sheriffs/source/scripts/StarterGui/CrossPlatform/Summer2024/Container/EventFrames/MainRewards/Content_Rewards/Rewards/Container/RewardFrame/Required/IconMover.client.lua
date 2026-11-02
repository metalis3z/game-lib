-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Icon = script.Parent.Icon
local Amount = script.Parent.Amount

local function v6(p1) --[[ v6 | Line: 5 | Upvalues: Amount (copy), Icon (copy) ]]
	if p1 == "Text" then
		local X = Amount.TextBounds.X
		local Position = Amount.Position

		Amount.Position = UDim2.new(Position.X.Scale, Position.X.Offset - Icon.AbsoluteSize.X / 2, Position.Y.Scale, Position.Y.Offset)
		Icon.Position = UDim2.new(0.5, X / 2 + 9, 0.5, 0)
	end
end

v6("Text")
Amount.Changed:Connect(v6)