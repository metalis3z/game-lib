


local v_u_1 = {}
game.Players.LocalPlayer:GetMouse()
local v_u_2 = game:GetService("UserInputService")
v_u_2.InputEnded:Connect(function(p3)
	if p3.UserInputType == Enum.UserInputType.MouseButton1 or p3.UserInputType == Enum.UserInputType.Touch then
		_G.currentDraggingObject = nil
		_G.dragType = nil
	end
end)
function v_u_1.makeResizable(p_u_4, p5)
	local v_u_6 = script.resizer:Clone()
	local v_u_7 = v_u_6.dragger
	v_u_6.Size = UDim2.fromOffset(30, 30)
	v_u_6.Position = UDim2.new(1, -30, 1, -30)
	local v_u_8 = p5 or Vector2.new(40, 22.5)
	local v_u_9 = nil
	local v_u_10 = nil
	local v_u_11 = nil
	local v_u_12 = p_u_4:FindFirstAncestorWhichIsA("ScreenGui")
	v_u_6.Parent = p_u_4
	local function v_u_13()
		if not p_u_4:GetAttribute("NoDrag") then
			v_u_7.Position = UDim2.new(0, 0, 0, 0)
			v_u_7.Size = UDim2.new(2, 0, 2, 0)
			v_u_7.Parent = v_u_6
			v_u_9 = nil
			v_u_11 = nil
			if _G.currentDraggingObject == p_u_4 and _G.dragType == "resize" then
				_G.currentDraggingObject = nil
				_G.dragType = nil
			end
		end
	end
	local function v_u_23(p14)
		if v_u_9 and (p_u_4 and not p_u_4:GetAttribute("NoDrag")) then
			if _G.currentDraggingObject == p_u_4 and _G.dragType == "resize" then
				local v15 = p14.Position
				local v16 = v_u_10 + Vector2.new(v15.X - v_u_9.X, v15.Y - v_u_9.Y)
				local v17 = v_u_8.X
				local v18 = v16.X
				local v19 = math.max(v17, v18)
				local v20 = v_u_8.Y
				local v21 = v16.Y
				local v22 = math.max(v20, v21)
				p_u_4.Size = UDim2.fromOffset(v19, v22)
			end
		else
			return
		end
	end
	v_u_7.InputBegan:Connect(function(p_u_24)
		if (p_u_24.UserInputType == Enum.UserInputType.MouseButton1 or p_u_24.UserInputType == Enum.UserInputType.Touch) and not (p_u_4:GetAttribute("NoDrag") or _G.currentDraggingObject) then
			_G.currentDraggingObject = p_u_4
			_G.dragType = "resize"
			v_u_10 = p_u_4.AbsoluteSize
			v_u_9 = p_u_24.Position
			v_u_11 = p_u_24
			v_u_7.Size = UDim2.fromOffset(v_u_12.AbsoluteSize.X, v_u_12.AbsoluteSize.Y)
			v_u_7.Position = UDim2.new(0, 0, 0, 0)
			v_u_7.Parent = v_u_12
			p_u_24.Changed:Connect(function()
				if p_u_24.UserInputState == Enum.UserInputState.End then
					v_u_13()
				end
			end)
		end
	end)
	v_u_7.InputChanged:Connect(function(p25)
		if (p25.UserInputType == Enum.UserInputType.MouseMovement or p25.UserInputType == Enum.UserInputType.Touch) and (p25 == v_u_11 or v_u_9 and (_G.currentDraggingObject == p_u_4 and _G.dragType == "resize")) then
			v_u_23(p25)
		end
	end)
	v_u_2.InputChanged:Connect(function(p26)
		if p26 == v_u_11 and (_G.currentDraggingObject == p_u_4 and _G.dragType == "resize") then
			v_u_23(p26)
		end
	end)
end
function v_u_1.makeDraggable(p_u_27)
	local v_u_28 = game:GetService("UserInputService")
	local v_u_29 = nil
	local v_u_30 = nil
	local v_u_31 = p_u_27.Position
	local v_u_32 = nil
	local function v_u_36(p33)
		if not p_u_27:GetAttribute("NoDrag") then
			local v34 = p33.Position - v_u_30
			local v35 = {
				["Position"] = UDim2.new(v_u_31.X.Scale, v_u_31.X.Offset + v34.X, v_u_31.Y.Scale, v_u_31.Y.Offset + v34.Y)
			}
			v_u_32 = game:GetService("TweenService"):Create(p_u_27, TweenInfo.new(0.25), v35)
			v_u_32:Play()
		end
	end
	p_u_27.InputBegan:Connect(function(p_u_37)
		if (p_u_37.UserInputType == Enum.UserInputType.MouseButton1 or p_u_37.UserInputType == Enum.UserInputType.Touch) and not (v_u_28:GetFocusedTextBox() or _G.currentDraggingObject) then
			_G.currentDraggingObject = p_u_27
			_G.dragType = "drag"
			v_u_30 = p_u_37.Position
			v_u_31 = p_u_27.Position
			v_u_1.dragged = p_u_27
			p_u_37.Changed:Connect(function()
				if p_u_37.UserInputState == Enum.UserInputState.End and (_G.currentDraggingObject == p_u_27 and _G.dragType == "drag") then
					_G.currentDraggingObject = nil
					_G.dragType = nil
				end
			end)
		end
	end)
	p_u_27.InputChanged:Connect(function(p38)
		if p38.UserInputType == Enum.UserInputType.MouseMovement or p38.UserInputType == Enum.UserInputType.Touch then
			v_u_29 = p38
		end
	end)
	v_u_28.InputChanged:Connect(function(p39)
		if p39 == v_u_29 and (_G.currentDraggingObject == p_u_27 and _G.dragType == "drag") then
			v_u_36(p39)
		end
	end)
end
return v_u_1
