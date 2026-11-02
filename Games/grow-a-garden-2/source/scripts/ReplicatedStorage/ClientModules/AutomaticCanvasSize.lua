--credit to prince games studio
local function ComputePadding(p1, p2) --[[ ComputePadding | Line: 23 ]]
	return Vector2.new(p2.PaddingLeft.Offset + p2.PaddingRight.Offset, p2.PaddingTop.Offset + p2.PaddingBottom.Offset) + p1 * Vector2.new(p2.PaddingLeft.Scale + p2.PaddingRight.Scale, p2.PaddingTop.Scale + p2.PaddingBottom.Scale)
end

local function ComputeCanvasSize(p1, p2) --[[ ComputeCanvasSize | Line: 36 | Upvalues: ComputePadding (copy) ]]
	local zero = Vector2.zero
	local zero2 = Vector2.zero
	local v1 = p1.AbsolutePosition + p1.CanvasPosition
	local AbsoluteSize = p1.AbsoluteSize

	for v2, v3 in p1:GetChildren() do
		if v3:IsA("GuiObject") and v3.Visible then
			local AbsoluteSize2 = v3.AbsoluteSize
			local UIPadding = v3:FindFirstChildOfClass("UIPadding")

			if UIPadding then
				AbsoluteSize2 = AbsoluteSize2 + ComputePadding(AbsoluteSize2, UIPadding)
			end

			local v4 = v3.AbsolutePosition - v1

			if p2 then
				zero = zero:Min(v4)
			end

			zero2 = zero2:Max(v4 + AbsoluteSize2)
		end
	end

	local UIListLayout = p1:FindFirstChildOfClass("UIListLayout")

	if UIListLayout then
		zero2 = zero2:Max(UIListLayout.AbsoluteContentSize)
	end

	local UIGridLayout = p1:FindFirstChildOfClass("UIGridLayout")

	if UIGridLayout then
		zero2 = zero2:Max(UIGridLayout.AbsoluteContentSize)
	end

	local sum = zero2 + zero:Abs()
	local v10 = p1:FindFirstChildWhichIsA("UIPadding")

	if v10 then
		sum = sum + ComputePadding(AbsoluteSize, v10)
	end

	local ScrollingDirection = p1.ScrollingDirection

	if ScrollingDirection == Enum.ScrollingDirection.X then
		sum = sum * Vector2.xAxis
	elseif ScrollingDirection == Enum.ScrollingDirection.Y then
		sum = sum * Vector2.yAxis
	end

	return UDim2.fromOffset(sum.X, sum.Y)
end

local function Update(p1) --[[ Update | Line: 96 | Upvalues: ComputeCanvasSize (copy) ]]
	if not p1.Destroyed then
		p1.Frame.CanvasSize = ComputeCanvasSize(p1.Frame, p1.IncludeNegativeOffset)
	end
end

local function RequestUpdate(p1) --[[ RequestUpdate | Line: 105 | Upvalues: ComputeCanvasSize (copy) ]]
	if not (p1.Destroyed or p1.Scheduled) then
		p1.Scheduled = true
		task.defer(function() --[[ Line: 110 | Upvalues: p1 (copy), ComputeCanvasSize (ref) ]]
			p1.Scheduled = false

			local v12 = p1

			if not v12.Destroyed then
				v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
			end
		end)
	end
end

local function Unwatch(p1, p2) --[[ Unwatch | Line: 116 ]]
	local v1 = p1.Connections[p2]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		v3:Disconnect()
	end

	p1.Connections[p2] = nil
end

local function Watch(p1, p2) --[[ Watch | Line: 127 | Upvalues: ComputeCanvasSize (copy) ]]
	if p1.Connections[p2] then
		return
	end

	local t = {}

	if p2:IsA("GuiObject") then
		t[#t + 1] = p2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 134 | Upvalues: p1 (copy), ComputeCanvasSize (ref) ]]
			local v1 = p1

			if v1.Destroyed then
				return
			end

			if v1.Scheduled then
				return
			end

			v1.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v1 (copy), ComputeCanvasSize (ref) ]]
				v1.Scheduled = false

				local v12 = v1

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end)
		t[#t + 1] = p2:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 137 | Upvalues: p1 (copy), ComputeCanvasSize (ref) ]]
			local v1 = p1

			if v1.Destroyed then
				return
			end

			if v1.Scheduled then
				return
			end

			v1.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v1 (copy), ComputeCanvasSize (ref) ]]
				v1.Scheduled = false

				local v12 = v1

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end)
	else
		if not p2:IsA("UILayout") then
			return
		end

		t[#t + 1] = p2.Changed:Connect(function() --[[ Line: 141 | Upvalues: p1 (copy), ComputeCanvasSize (ref) ]]
			local v1 = p1

			if v1.Destroyed then
				return
			end

			if v1.Scheduled then
				return
			end

			v1.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v1 (copy), ComputeCanvasSize (ref) ]]
				v1.Scheduled = false

				local v12 = v1

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end)
	end

	p1.Connections[p2] = t
end

return function(p1, p2) --[[ AutomaticCanvasSize | Line: 161 | Upvalues: ComputeCanvasSize (copy), Watch (copy) ]]
	local t = {
		Scheduled = false,
		Destroyed = false,
		Frame = p1
	}

	t.IncludeNegativeOffset = if p2 then p2.IncludeNegativeOffset == true else false
	t.Connections = {}
	t.Connections[p1] = { p1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 172 | Upvalues: t (copy), ComputeCanvasSize (ref) ]]
			local v1 = t

			if v1.Destroyed then
				return
			end

			if v1.Scheduled then
				return
			end

			v1.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v1 (copy), ComputeCanvasSize (ref) ]]
				v1.Scheduled = false

				local v12 = v1

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end), p1.ChildAdded:Connect(function(p1) --[[ Line: 175 | Upvalues: Watch (ref), t (copy), ComputeCanvasSize (ref) ]]
			Watch(t, p1)

			local v1 = t

			if v1.Destroyed then
				return
			end

			if v1.Scheduled then
				return
			end

			v1.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v1 (copy), ComputeCanvasSize (ref) ]]
				v1.Scheduled = false

				local v12 = v1

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end), p1.ChildRemoved:Connect(function(p1) --[[ Line: 179 | Upvalues: t (copy), ComputeCanvasSize (ref) ]]
			local v1 = t
			local v2 = v1.Connections[p1]

			if v2 then
				for v3, v4 in v2 do
					v4:Disconnect()
				end

				v1.Connections[p1] = nil
			end

			local v5 = t

			if v5.Destroyed then
				return
			end

			if v5.Scheduled then
				return
			end

			v5.Scheduled = true
			task.defer(function() --[[ Line: 110 | Upvalues: v5 (copy), ComputeCanvasSize (ref) ]]
				v5.Scheduled = false

				local v12 = v5

				if not v12.Destroyed then
					v12.Frame.CanvasSize = ComputeCanvasSize(v12.Frame, v12.IncludeNegativeOffset)
				end
			end)
		end) }

	for v2, v3 in p1:GetChildren() do
		Watch(t, v3)
	end

	if not t.Destroyed then
		t.Frame.CanvasSize = ComputeCanvasSize(t.Frame, t.IncludeNegativeOffset)
	end

	return function() --[[ Line: 191 | Upvalues: t (copy) ]]
		if t.Destroyed then
			return
		end

		t.Destroyed = true

		for v1 in t.Connections do
			local v2 = t
			local v3 = v2.Connections[v1]

			if v3 then
				for v4, v5 in v3 do
					v5:Disconnect()
				end

				v2.Connections[v1] = nil
			end
		end
	end
end