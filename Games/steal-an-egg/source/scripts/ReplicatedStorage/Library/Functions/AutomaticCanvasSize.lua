-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	if p1.ScrollingDirection == Enum.ScrollingDirection.X then
		local sum = 0
		local UIListLayout = p1:FindFirstChildOfClass("UIListLayout")

		if UIListLayout then
			sum = sum + UIListLayout.AbsoluteContentSize.X
		end

		local UIGridLayout = p1:FindFirstChildOfClass("UIGridLayout")

		if UIGridLayout then
			sum = sum + UIGridLayout.AbsoluteContentSize.X
		end

		local UIPadding = p1:FindFirstChildOfClass("UIPadding")

		if UIPadding then
			sum = sum + (UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset)
		end

		p1.CanvasSize = UDim2.new(0, sum, 0, 0)
	else
		local sum = 0
		local UIListLayout = p1:FindFirstChildOfClass("UIListLayout")

		if UIListLayout then
			sum = sum + UIListLayout.AbsoluteContentSize.Y
		end

		local UIGridLayout = p1:FindFirstChildOfClass("UIGridLayout")

		if UIGridLayout then
			sum = sum + UIGridLayout.AbsoluteContentSize.Y
		end

		local UIPadding = p1:FindFirstChildOfClass("UIPadding")

		if UIPadding then
			sum = sum + (UIPadding.PaddingBottom.Offset + UIPadding.PaddingTop.Offset)
		end

		p1.CanvasSize = UDim2.new(0, 0, 0, sum)
	end
end