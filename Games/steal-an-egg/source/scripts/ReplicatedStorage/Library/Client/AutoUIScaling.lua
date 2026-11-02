-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	assert(if typeof(p1) == "Instance" then p1:IsA("ScrollingFrame") else false, (("Expected ScrollingFrame, got %*"):format((typeof(p1)))))

	local RunService = game:GetService("RunService")
	local v3 = workspace
	local v4 = p1:FindFirstChildOfClass("UIListLayout") or p1:FindFirstChildOfClass("UIGridLayout")

	assert(v4, "UIListLayout or UIGridLayout not found in the provided ScrollingFrame.")

	local UIPadding = p1:FindFirstChildOfClass("UIPadding")

	local function v5(p1) --[[ ancestorEnabled | Line: 16 | Upvalues: v5 (copy) ]]
		if not p1 then
			return false
		end

		if p1:IsA("LayerCollector") then
			return p1.Enabled
		end

		if p1:IsA("GuiObject") and not p1.Visible then
			return false
		end

		return v5(p1.Parent)
	end

	local v6 = false
	local v7 = false

	if p1:IsA("LayerCollector") then
		v7 = p1.Enabled
	elseif not p1:IsA("GuiObject") or p1.Visible then
		local v8 = p1.Parent

		v7 = if v8 then if v8:IsA("LayerCollector") then v8.Enabled elseif v8:IsA("GuiObject") and not v8.Visible then false else v5(v8.Parent) else false
	end

	local function refreshVisible() --[[ refreshVisible | Line: 36 | Upvalues: p1 (copy), v7 (ref), v5 (copy), v6 (ref) ]]
		if p1:IsA("LayerCollector") then
			v7 = p1.Enabled
		elseif p1:IsA("GuiObject") and not p1.Visible then
			v7 = false
		else
			local v1 = p1.Parent

			v7 = if v1 then if v1:IsA("LayerCollector") then v1.Enabled elseif v1:IsA("GuiObject") and not v1.Visible then false else v5(v1.Parent) else false
		end

		v6 = true
	end

	local function updateCanvasSize() --[[ updateCanvasSize | Line: 47 | Upvalues: v7 (ref), v6 (ref), p1 (copy), v4 (copy), UIPadding (copy) ]]
		if not (v7 and v6) then
			return
		end

		v6 = false

		local AbsoluteWindowSize = p1.AbsoluteWindowSize
		local AbsoluteContentSize = v4.AbsoluteContentSize

		if UIPadding then
			AbsoluteContentSize = AbsoluteContentSize + Vector2.new(UIPadding.PaddingLeft.Offset, UIPadding.PaddingTop.Offset) + Vector2.new(UIPadding.PaddingRight.Offset, UIPadding.PaddingBottom.Offset) + AbsoluteWindowSize * Vector2.new(UIPadding.PaddingLeft.Scale, UIPadding.PaddingTop.Scale) + AbsoluteWindowSize * Vector2.new(UIPadding.PaddingRight.Scale, UIPadding.PaddingBottom.Scale)
		end

		if p1.ScrollingDirection == Enum.ScrollingDirection.X then
			AbsoluteContentSize = Vector2.new(AbsoluteContentSize.X, AbsoluteWindowSize.Y)
		elseif p1.ScrollingDirection == Enum.ScrollingDirection.Y then
			AbsoluteContentSize = Vector2.new(AbsoluteWindowSize.X, AbsoluteContentSize.Y)
		end

		p1.CanvasSize = UDim2.fromOffset(AbsoluteContentSize.X, AbsoluteContentSize.Y)
	end

	RunService.RenderStepped:Connect(function() --[[ Line: 69 | Upvalues: updateCanvasSize (copy) ]]
		updateCanvasSize()
	end)
	v4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshVisible)
	p1:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(refreshVisible)
	v3.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refreshVisible)
	updateCanvasSize()

	local v9 = p1.Parent

	while v9 do
		if v9:IsA("BillboardGui") or v9:IsA("ScreenGui") then
			local v10 = v9

			v10:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 83 | Upvalues: v10 (copy), p1 (copy), v7 (ref), v5 (copy), v6 (ref) ]]
				if not v10.Enabled then
					return
				end

				if p1:IsA("LayerCollector") then
					v7 = p1.Enabled
				elseif p1:IsA("GuiObject") and not p1.Visible then
					v7 = false
				else
					local v1 = p1.Parent

					v7 = if v1 then if v1:IsA("LayerCollector") then v1.Enabled elseif v1:IsA("GuiObject") and not v1.Visible then false else v5(v1.Parent) else false
				end

				v6 = true
			end)

			break
		end

		if v9:IsA("Frame") then
			local v11 = v9

			v11:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 92 | Upvalues: v11 (copy), p1 (copy), v7 (ref), v5 (copy), v6 (ref) ]]
				if not v11.Visible then
					return
				end

				if p1:IsA("LayerCollector") then
					v7 = p1.Enabled
				elseif p1:IsA("GuiObject") and not p1.Visible then
					v7 = false
				else
					local v1 = p1.Parent

					v7 = if v1 then if v1:IsA("LayerCollector") then v1.Enabled elseif v1:IsA("GuiObject") and not v1.Visible then false else v5(v1.Parent) else false
				end

				v6 = true
			end)
		end

		v9 = v9.Parent
	end
end