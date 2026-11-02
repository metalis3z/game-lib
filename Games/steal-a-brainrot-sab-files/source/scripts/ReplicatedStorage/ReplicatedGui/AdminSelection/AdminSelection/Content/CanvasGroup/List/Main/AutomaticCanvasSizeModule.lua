


return function(p1, p2)
	if p1.ScrollingDirection == Enum.ScrollingDirection.X then
		local v3 = 1000
		local v4 = p1:FindFirstChildOfClass("UIListLayout")
		if v4 then
			v3 = v3 + v4.AbsoluteContentSize.X
		end
		local v5 = p1:FindFirstChildOfClass("UIGridLayout")
		if v5 then
			v3 = v3 + v5.AbsoluteContentSize.X
		end
		local v6 = p1:FindFirstChildOfClass("UIPadding")
		if v6 then
			v3 = v3 + (v6.PaddingLeft.Offset + v6.PaddingRight.Offset)
		end
		if p2 then
			v3 = v3 + p2
		end
		p1.CanvasSize = UDim2.new(0, v3, 0, 0)
	else
		local v7 = 1000
		local v8 = p1:FindFirstChildOfClass("UIListLayout")
		if v8 then
			v7 = v7 + v8.AbsoluteContentSize.Y
		end
		local v9 = p1:FindFirstChildOfClass("UIGridLayout")
		if v9 then
			v7 = v7 + v9.AbsoluteContentSize.Y
		end
		local v10 = p1:FindFirstChildOfClass("UIPadding")
		if v10 then
			v7 = v7 + (v10.PaddingBottom.Offset + v10.PaddingTop.Offset)
		end
		if p2 then
			v7 = v7 + p2
		end
		p1.CanvasSize = UDim2.new(0, 0, 0, v7)
	end
end
