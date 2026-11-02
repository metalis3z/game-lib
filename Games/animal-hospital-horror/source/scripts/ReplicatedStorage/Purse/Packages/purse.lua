local GuiService = game:GetService("GuiService")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local BackpackGui = Instance.new("ScreenGui")

BackpackGui.Name = "BackpackGui"
BackpackGui.ResetOnSpawn = false
BackpackGui.Parent = PlayerGui

local t = {
	OpenClose = nil,
	IsHotbarVisible = false,
	IsOpen = false
}
local v1 = Instance.new("BindableEvent")

v1.Parent = script
t.StateChanged = v1
t.ModuleName = "Backpack"
t.KeepVRTopbarOpen = true
t.VRIsExclusive = true
t.VRClosesNonExclusive = true

local v2 = 60
local Size14 = Enum.FontSize.Size14
local v3 = 0.5 * GuiService.PreferredTransparency
local v4 = Color3.new(31/255, 31/255, 31/255)
local v5 = Color3.new(49/255, 49/255, 49/255)
local v6 = Color3.new(90/255, 142/255, 233/255)
local v7 = 0.5 * GuiService.PreferredTransparency
local v8 = Color3.new(255/255, 255/255, 255/255)

UDim2.fromOffset(14, 9)

local Backquote = Enum.KeyCode.Backquote.Value
local v9 = Color3.new(0/255, 162/255, 255/255)
local v10 = "Search"
local v11 = Color3.new(0.37, 0.37, 0.37)
local v12 = 0.15 * GuiService.PreferredTransparency
local Zero = Enum.KeyCode.Zero.Value
local Backspace = Enum.KeyCode.Backspace.Value
local t2 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}
local ContextActionService = game:GetService("ContextActionService")
local GamepadService = game:GetService("GamepadService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local v13 = GuiService:IsTenFootInterface()

local function Create(p1) --[[ Create | Line: 112 ]]
	return function(p1) --[[ Line: 113 | Upvalues: p1 (copy) ]]
		local v12 = Instance.new(p1)
		local v2 = nil

		for k2, v in pairs(p1) do
			if type(k2) == "number" then
				v.Parent = v12

				continue
			end

			if k2 == "Parent" then
				v2 = v

				continue
			end

			v12[k2] = v
		end

		if v2 then
			v12.Parent = v2
		end

		return v12
	end
end

pcall(function() --[[ Line: 133 | Upvalues: v10 (ref) ]]
	local LocalizationService = game:GetService("LocalizationService")

	v10 = LocalizationService:GetCorescriptLocalizations()[1]:GetString(LocalizationService.RobloxLocaleId, "BACKPACK_SEARCH")
end)

if v13 then
	Size14 = Enum.FontSize.Size24
	v2 = 100
end

local v14 = false
local v15 = UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X < 1024
local LocalPlayer = Players.LocalPlayer
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local t3 = {}
local v26 = nil
local t4 = {}
local t5 = {}
local t6 = {}
local v27 = 0
local v28 = nil
local v29 = false
local v30 = false
local v31 = false
local t7 = {}
local t8 = {}
local v32 = false
local v33 = 0
local v34 = if v15 then 3 else 10
local v35 = if v15 then 2 else 4
local v36 = nil
local v37 = "BindableEvent"

t.BackpackEmpty = (function(p1) --[[ Line: 113 | Upvalues: v37 (copy) ]]
	local v12 = Instance.new(v37)
	local v2 = nil

	for k2, v in pairs(p1) do
		if type(k2) == "number" then
			v.Parent = v12

			continue
		end

		if k2 == "Parent" then
			v2 = v

			continue
		end

		v12[k2] = v
	end

	if v2 then
		v12.Parent = v2
	end

	return v12
end)({
	Name = "BackpackEmpty",
	Parent = script
})

local v38 = "BindableEvent"

t.BackpackItemAdded = (function(p1) --[[ Line: 113 | Upvalues: v38 (copy) ]]
	local v12 = Instance.new(v38)
	local v2 = nil

	for k2, v in pairs(p1) do
		if type(k2) == "number" then
			v.Parent = v12

			continue
		end

		if k2 == "Parent" then
			v2 = v

			continue
		end

		v12[k2] = v
	end

	if v2 then
		v12.Parent = v2
	end

	return v12
end)({
	Name = "BackpackAdded",
	Parent = script
})

local v39 = "BindableEvent"

t.BackpackItemRemoved = (function(p1) --[[ Line: 113 | Upvalues: v39 (copy) ]]
	local v12 = Instance.new(v39)
	local v2 = nil

	for k2, v in pairs(p1) do
		if type(k2) == "number" then
			v.Parent = v12

			continue
		end

		if k2 == "Parent" then
			v2 = v

			continue
		end

		v12[k2] = v
	end

	if v2 then
		v12.Parent = v2
	end

	return v12
end)({
	Name = "BackpackRemoved",
	Parent = script
})

local function NewGui(p1, p2) --[[ NewGui | Line: 205 | Upvalues: Size14 (ref) ]]
	local v1 = Instance.new(p1)

	v1.Name = p2
	v1.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	v1.BackgroundTransparency = 1
	v1.BorderColor3 = Color3.new(0/255, 0/255, 0/255)
	v1.BorderSizePixel = 0
	v1.Size = UDim2.fromScale(1, 1)

	if p1:match("Text") then
		v1.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		v1.Text = ""
		v1.Font = Enum.Font.SourceSans
		v1.FontSize = Size14
		v1.TextWrapped = true

		if p1 == "TextButton" then
			v1.Font = Enum.Font.SourceSansBold
			v1.BorderSizePixel = 1
		end
	end

	return v1
end

local function FindLowestEmpty() --[[ FindLowestEmpty | Line: 227 | Upvalues: v34 (ref), t3 (copy) ]]
	for i = 1, v34 do
		local v1 = t3[i]

		if not v1.Tool then
			return v1
		end
	end

	return nil
end

function t.IsInventoryEmpty() --[[ isInventoryEmpty | Line: 237 | Upvalues: v34 (ref), t3 (copy) ]]
	for i = v34 + 1, #t3 do
		local v1 = t3[i]

		if v1 and v1.Tool then
			return false
		end
	end

	return true
end

local function UseGazeSelection() --[[ UseGazeSelection | Line: 249 ]]
	return false
end

local function AdjustHotbarFrames() --[[ AdjustHotbarFrames | Line: 253 | Upvalues: v19 (ref), v34 (ref), v27 (ref), t3 (copy), v18 (ref), t (copy) ]]
	local Visible = v19.Visible
	local v1 = v19.Visible and v34 or v27
	local count = 0
	local v2 = if v1 >= 1 then true else false

	for i = 1, v34 do
		local v3 = t3[i]

		if v3.Tool or Visible then
			count = count + 1
			v3:Readjust(count, v1)
			v3.Frame.Visible = true

			continue
		end

		v3.Frame.Visible = false
	end

	local v4 = v18
	local v5 = not Visible
	local v7, v8, v9, v10, v11

	if v5 and v2 then
		v5 = v2
	else
		local v6

		if v5 then
			local v12

			for j = v34 + 1, #t3 do
				local v13 = t3[j]

				if v13 and v13.Tool then
					v12 = false
					v5 = not v12
					v4.Visible = v5
					v6 = v18
					v7 = UDim2.new
					v8 = 0.5
					v9 = -15
					v10 = 1
					v11 = if v2 then -110 else -50
					v18.Position = v7(v8, v9, v10, v11)
					t.IsHotbarVisible = v2

					return
				end
			end

			v12 = true
			v5 = not v12
		end
	end

	v4.Visible = v5
	v7 = UDim2.new
	v8 = 0.5
	v9 = -15
	v10 = 1
	v11 = if v2 then -110 else -50
	v18.Position = v7(v8, v9, v10, v11)
	t.IsHotbarVisible = v2
end

local function UpdateScrollingFrameCanvasSize() --[[ UpdateScrollingFrameCanvasSize | Line: 275 | Upvalues: v21 (ref), v2 (ref), v22 (ref) ]]
	local v23 = math.floor(v21.AbsoluteSize.X / (v2 + 5))

	v21.CanvasSize = UDim2.fromOffset(0, math.ceil((#v22:GetChildren() - 1) / v23) * (v2 + 5) + 5)
end

local function AdjustInventoryFrames() --[[ AdjustInventoryFrames | Line: 282 | Upvalues: v34 (ref), t3 (copy), v21 (ref), v2 (ref), v22 (ref) ]]
	for i = v34 + 1, #t3 do
		local v1 = t3[i]

		v1.Frame.LayoutOrder = v1.Index
		v1.Frame.Visible = v1.Tool ~= nil
	end

	local v3 = math.floor(v21.AbsoluteSize.X / (v2 + 5))

	v21.CanvasSize = UDim2.fromOffset(0, math.ceil((#v22:GetChildren() - 1) / v3) * (v2 + 5) + 5)
end

local function UpdateBackpackLayout() --[[ UpdateBackpackLayout | Line: 291 | Upvalues: v17 (ref), v34 (ref), v2 (ref), v19 (ref), v35 (copy), v21 (ref), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy) ]]
	v17.Size = UDim2.new(0, 5 + v34 * (v2 + 5), 0, v2 + 5 + 5)
	v17.Position = UDim2.new(0.5, -v17.Size.X.Offset / 2, 1, -v17.Size.Y.Offset)
	v19.Size = UDim2.new(0, v17.Size.X.Offset, 0, v17.Size.Y.Offset * v35 + 40)
	v19.Position = UDim2.new(0.5, -v19.Size.X.Offset / 2, 1, v17.Position.Y.Offset - v19.Size.Y.Offset)
	v21.Size = UDim2.new(1, v21.ScrollBarThickness + 1, 1, -40)
	v21.Position = UDim2.fromOffset(0, 40)
	AdjustHotbarFrames()
	AdjustInventoryFrames()
end

local function Clamp(p1, p2, p3) --[[ Clamp | Line: 318 ]]
	return math.min(p2, (math.max(p1, p3)))
end

local function CheckBounds(p1, p2, p3) --[[ CheckBounds | Line: 322 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local AbsoluteSize = p1.AbsoluteSize

	return if AbsolutePosition.X < p2 and (p2 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p3) then p3 <= AbsolutePosition.Y + AbsoluteSize.Y else false
end

local function GetOffset(p1, p2) --[[ GetOffset | Line: 328 ]]
	return (p1.AbsolutePosition + p1.AbsoluteSize / 2 - p2).magnitude
end

local function DisableActiveHopper() --[[ DisableActiveHopper | Line: 333 ]]
	warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
end

local function UnequipAllTools() --[[ UnequipAllTools | Line: 342 | Upvalues: v24 (ref), v28 (ref) ]]
	if not v24 then
		return
	end

	v24:UnequipTools()

	if not v28 then
		return
	end

	warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
end

local function EquipNewTool(p1) --[[ EquipNewTool | Line: 351 | Upvalues: v24 (ref), v28 (ref), v23 (ref) ]]
	if v24 then
		v24:UnequipTools()

		if v28 then
			warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
		end
	end

	if p1:IsA("HopperBin") then
		warn((("[Purse] Cannot select \'%*\' hopper. HopperBin is deprecated and not supported."):format(p1)))
	else
		p1.Parent = v23
	end
end

local function IsEquipped(p1) --[[ IsEquipped | Line: 366 | Upvalues: v23 (ref) ]]
	return if p1 then p1:IsA("HopperBin") and p1.Active or p1.Parent == v23 else p1
end

local function v40(p1, p2) --[[ MakeSlot | Line: 370 | Upvalues: t3 (copy), v7 (ref), v5 (copy), v4 (copy), v17 (ref), v2 (ref), v34 (ref), v19 (ref), v27 (ref), v14 (ref), ContextActionService (copy), t4 (copy), v26 (ref), v23 (ref), v36 (ref), NewGui (copy), v6 (copy), t6 (copy), v21 (ref), v22 (ref), v24 (ref), v28 (ref), v25 (ref), v8 (copy), v40 (copy), v31 (ref), t5 (copy), Zero (copy) ]]
	local v1 = p2 or #t3 + 1
	local t = {
		Tool = nil,
		Index = v1,
		Frame = nil
	}
	local v29 = nil
	local v3 = nil
	local v42 = nil
	local v52 = nil
	local v62 = nil
	local v72 = nil
	local v82 = nil
	local v9 = nil

	local function UpdateSlotFading() --[[ UpdateSlotFading | Line: 395 | Upvalues: v29 (ref), v7 (ref), v5 (ref), v4 (ref) ]]
		v29.SelectionImageObject = nil
		v29.BackgroundTransparency = if v29.Draggable then 0 else v7
		v29.BackgroundColor3 = v29.Draggable and v5 or v4
	end

	function t.Readjust(p1, p2, p3) --[[ Readjust | Line: 401 | Upvalues: v17 (ref), v2 (ref), v29 (ref) ]]
		v29.Position = UDim2.fromOffset(v17.Size.X.Offset / 2 - v2 / 2 + (v2 + 5) * (p2 - (p3 / 2 + 0.5)), 5)
	end
	function t.Fill(p1, p2) --[[ Fill | Line: 409 | Upvalues: v42 (ref), v52 (ref), v82 (ref), v62 (ref), v34 (ref), v19 (ref), v29 (ref), v27 (ref), v14 (ref), ContextActionService (ref), t4 (ref), v26 (ref), t3 (ref) ]]
		if not p2 then
			return p1:Clear()
		end

		p1.Tool = p2

		local function assignToolData() --[[ assignToolData | Line: 416 | Upvalues: p2 (copy), v42 (ref), v52 (ref), v82 (ref) ]]
			local TextureId = p2.TextureId

			v42.Image = TextureId

			if TextureId == "" then
				v52.Visible = true
			else
				v52.Visible = false
			end

			v52.Text = p2.Name

			if not (v82 and p2:IsA("Tool")) then
				return
			end

			v82.Text = p2.ToolTip

			local v1 = v82.TextBounds.X + 6

			v82.Size = UDim2.fromOffset(v1, 16)
			v82.Position = UDim2.new(0.5, -v1 / 2, 0, -25)
		end

		assignToolData()

		if v62 then
			v62:disconnect()
			v62 = nil
		end

		v62 = p2.Changed:connect(function(p1) --[[ Line: 442 | Upvalues: assignToolData (copy) ]]
			if p1 ~= "TextureId" and (p1 ~= "Name" and p1 ~= "ToolTip") then
				return
			end

			assignToolData()
		end)

		local v1 = p1.Index <= v34

		if not v1 or v19.Visible then
			v29.Draggable = true
		end

		p1:UpdateEquipView()

		if v1 then
			v27 = v27 + 1

			if v27 >= 1 and not v14 then
				v14 = true
				ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			end
		end

		t4[p2] = p1

		local v2

		for i = 1, v34 do
			local v3 = t3[i]

			if not v3.Tool then
				v2 = v3
				v26 = v3

				return
			end
		end

		v2 = nil
		v26 = v2
	end
	function t.Clear(p1) --[[ Clear | Line: 481 | Upvalues: v62 (ref), v42 (ref), v52 (ref), v82 (ref), v29 (ref), v34 (ref), v27 (ref), v14 (ref), ContextActionService (ref), t4 (ref), v26 (ref), t3 (ref) ]]
		if not p1.Tool then
			return
		end

		if v62 then
			v62:disconnect()
			v62 = nil
		end

		v42.Image = ""
		v52.Text = ""

		if v82 then
			v82.Text = ""
			v82.Visible = false
		end

		v29.Draggable = false
		p1:UpdateEquipView(true)

		if p1.Index <= v34 then
			v27 = v27 - 1

			if v27 < 1 then
				v14 = false
				ContextActionService:UnbindAction("BackpackHotbarEquip")
			end
		end

		t4[p1.Tool] = nil
		p1.Tool = nil

		local v1

		for i = 1, v34 do
			local v2 = t3[i]

			if not v2.Tool then
				v1 = v2
				v26 = v2

				return
			end
		end

		v1 = nil
		v26 = v1
	end
	function t.UpdateEquipView(p1, p2) --[[ UpdateEquipView | Line: 514 | Upvalues: v23 (ref), v36 (ref), t (copy), v72 (ref), NewGui (ref), v29 (ref), v6 (ref), v7 (ref), v5 (ref), v4 (ref) ]]
		if p2 then
			if v72 then
				v72.Parent = nil
			end
		else
			local Tool = p1.Tool

			if if Tool then Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == v23 else Tool then
				v36 = t

				if not v72 then
					v72 = NewGui("Frame", "Equipped")
					v72.ZIndex = v29.ZIndex

					for k, v in pairs({
						{ 0.1, 1, 0, 0 },
						{ 0.8, 0.1, 0.1, 0 },
						{ 0.1, 1, 0.9, 0 },
						{ 0.8, 0.1, 0.1, 0.9 }
					}) do
						local v2 = NewGui("Frame", "Edge")

						v2.BackgroundTransparency = 0
						v2.BackgroundColor3 = v6
						v2.Size = UDim2.fromScale(v[1], v[2])
						v2.Position = UDim2.fromScale(v[3], v[4])
						v2.ZIndex = v72.ZIndex
						v2.Parent = v72
					end
				end

				v72.Parent = v29
			elseif v72 then
				v72.Parent = nil
			end
		end

		v29.SelectionImageObject = nil
		v29.BackgroundTransparency = if v29.Draggable then 0 else v7
		v29.BackgroundColor3 = v29.Draggable and v5 or v4
	end
	function t.IsEquipped(p1) --[[ IsEquipped | Line: 546 | Upvalues: v23 (ref) ]]
		local Tool = p1.Tool

		return if Tool then Tool:IsA("HopperBin") and Tool.Active or Tool.Parent == v23 else Tool
	end
	function t.Delete(p1) --[[ Delete | Line: 550 | Upvalues: t6 (ref), v29 (ref), t3 (ref), v21 (ref), v2 (ref), v22 (ref) ]]
		t6[v29] = nil
		v29:Destroy()
		table.remove(t3, p1.Index)

		for i = p1.Index, #t3 do
			t3[i]:SlideBack()
		end

		local v3 = math.floor(v21.AbsoluteSize.X / (v2 + 5))

		v21.CanvasSize = UDim2.fromOffset(0, math.ceil((#v22:GetChildren() - 1) / v3) * (v2 + 5) + 5)
	end
	function t.Swap(p1, p2) --[[ Swap | Line: 564 ]]
		local Tool = p1.Tool
		local Tool2 = p2.Tool

		p1:Clear()

		if Tool2 then
			p2:Clear()
			p1:Fill(Tool2)
		end

		if Tool then
			p2:Fill(Tool)
		else
			p2:Clear()
		end
	end
	function t.SlideBack(p1) --[[ SlideBack | Line: 578 | Upvalues: v29 (ref) ]]
		p1.Index = p1.Index - 1
		v29.Name = p1.Index
		v29.LayoutOrder = p1.Index
	end
	function t.TurnNumber(p1, p2) --[[ TurnNumber | Line: 584 | Upvalues: v9 (ref) ]]
		if not v9 then
			return
		end

		v9.Visible = p2
	end
	function t.SetClickability(p1, p2) --[[ SetClickability | Line: 590 | Upvalues: v29 (ref), v7 (ref), v5 (ref), v4 (ref) ]]
		if not p1.Tool then
			return
		end

		v29.Draggable = not p2
		v29.SelectionImageObject = nil
		v29.BackgroundTransparency = if v29.Draggable then 0 else v7
		v29.BackgroundColor3 = v29.Draggable and v5 or v4
	end
	function t.CheckTerms(p1, p2) --[[ CheckTerms | Line: 597 | Upvalues: v52 (ref), v82 (ref) ]]
		local sum = 0

		local function checkEm(p1, p2) --[[ checkEm | Line: 599 | Upvalues: sum (ref) ]]
			local _, v1 = p1:lower():gsub(p2, "")

			sum = sum + v1
		end

		local Tool = p1.Tool

		if Tool then
			for k in pairs(p2) do
				local _, v1 = v52.Text:lower():gsub(k, "")

				sum = sum + v1

				if Tool:IsA("Tool") then
					local _2, v3 = (if v82 then v82.Text or "" else ""):lower():gsub(k, "")

					sum = sum + v3
				end
			end
		end

		return sum
	end
	function t.Select(p1, p2) --[[ Select | Line: 617 | Upvalues: t (copy), v23 (ref), v24 (ref), v28 (ref), v25 (ref) ]]
		if p2 then
			return
		end

		local Tool = t.Tool

		if not Tool then
			return
		end

		if if Tool then Tool:IsA("HopperBin") and Tool.Active or (if Tool.Parent == v23 then true else false) else Tool then
			if not v24 then
				return
			end

			v24:UnequipTools()

			if v28 then
				warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
			end
		else
			if Tool.Parent ~= v25 then
				return
			end

			if v24 then
				v24:UnequipTools()

				if v28 then
					warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
				end
			end

			if Tool:IsA("HopperBin") then
				warn((("[Purse] Cannot select \'%*\' hopper. HopperBin is deprecated and not supported."):format(Tool)))

				return
			end

			Tool.Parent = v23
		end
	end
	v29 = NewGui("TextButton", v1)
	v29.BackgroundColor3 = v4
	v29.BorderColor3 = v8
	v29.Text = ""
	v29.AutoButtonColor = false
	v29.BorderSizePixel = 0
	v29.Size = UDim2.fromOffset(v2, v2)
	v29.Active = true
	v29.Draggable = false
	v29.BackgroundTransparency = v7
	v29.MouseButton1Click:connect(function() --[[ Line: 644 | Upvalues: t (copy) ]]
		changeSlot(t)
	end)
	t.Frame = v29

	local v10 = NewGui("Frame", "SelectionObjectClipper")

	v10.Visible = false
	v10.Parent = v29

	local v11 = NewGui("ImageLabel", "Selector")

	v11.Size = UDim2.fromScale(1, 1)
	v11.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
	v11.ScaleType = Enum.ScaleType.Slice
	v11.SliceCenter = Rect.new(12, 12, 52, 52)
	v11.Parent = v10
	v42 = NewGui("ImageLabel", "Icon")
	v42.Size = UDim2.fromScale(0.8, 0.8)
	v42.Position = UDim2.fromScale(0.1, 0.1)
	v42.Parent = v29
	v52 = NewGui("TextLabel", "ToolName")
	v52.Size = UDim2.new(1, -2, 1, -2)
	v52.Position = UDim2.fromOffset(1, 1)
	v52.Parent = v29
	t.Frame.LayoutOrder = t.Index

	if v1 <= v34 then
		v82 = NewGui("TextLabel", "ToolTip")
		v82.TextWrapped = false
		v82.TextYAlignment = Enum.TextYAlignment.Top
		v82.BackgroundColor3 = Color3.new(102/255, 102/255, 102/255)
		v82.BackgroundTransparency = 0
		v82.Visible = false
		v82.Parent = v29
		v29.MouseEnter:connect(function() --[[ Line: 683 | Upvalues: v82 (ref) ]]
			if v82.Text == "" then
				return
			end

			v82.Visible = true
		end)
		v29.MouseLeave:connect(function() --[[ Line: 688 | Upvalues: v82 (ref) ]]
			v82.Visible = false
		end)
		function t.MoveToInventory(p1) --[[ MoveToInventory | Line: 692 | Upvalues: t (copy), v34 (ref), v40 (ref), v22 (ref), v23 (ref), v24 (ref), v28 (ref), v31 (ref), v19 (ref) ]]
			if not (t.Index <= v34) then
				return
			end

			local Tool = t.Tool

			p1:Clear()

			local v1 = v40(v22)

			v1:Fill(Tool)

			if (if Tool then Tool:IsA("HopperBin") and Tool.Active or (if Tool.Parent == v23 then true else false) else Tool) and v24 then
				v24:UnequipTools()

				if v28 then
					warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
				end
			end

			if not v31 then
				return
			end

			v1.Frame.Visible = false
			v1.Parent = v19
		end

		if v1 < 10 or v1 == v34 then
			local v13 = v1 < 10 and v1 or 0

			v9 = NewGui("TextLabel", "Number")
			v9.Text = v13
			v9.Size = UDim2.fromScale(0.15, 0.15)
			v9.Visible = false
			v9.Parent = v29
			t5[Zero + v13] = function(p1) --[[ Line: 718 | Upvalues: t (copy) ]]
				t:Select(p1)
			end
		end
	end

	local Position = v29.Position
	local v142 = 0
	local v15 = nil

	v29.DragBegin:connect(function(p1) --[[ Line: 729 | Upvalues: t6 (ref), v29 (ref), Position (ref), v42 (ref), v52 (ref), v9 (ref), v72 (ref), v15 (ref), v22 (ref), v19 (ref), v3 (ref), NewGui (ref) ]]
		t6[v29] = true
		Position = p1
		v29.BorderSizePixel = 2
		v29.ZIndex = 2
		v42.ZIndex = 2
		v52.ZIndex = 2
		v29.Parent.ZIndex = 2

		if v9 then
			v9.ZIndex = 2
		end

		if v72 then
			v72.ZIndex = 2

			for k, v in pairs(v72:GetChildren()) do
				v.ZIndex = 2
			end
		end

		v15 = v29.Parent

		if v15 ~= v22 then
			return
		end

		local AbsolutePosition = v29.AbsolutePosition
		local v1 = UDim2.new(0, v29.AbsolutePosition.X - v19.AbsolutePosition.X, 0, v29.AbsolutePosition.Y - v19.AbsolutePosition.Y)

		v29.Parent = v19
		v29.Position = v1
		v3 = NewGui("Frame", "FakeSlot")
		v3.LayoutOrder = v29.LayoutOrder
		v3.Size = v29.Size
		v3.BackgroundTransparency = 1
		v3.Parent = v22
	end)
	v29.DragStopped:connect(function(p1, p2) --[[ Line: 771 | Upvalues: v3 (ref), v29 (ref), Position (ref), v15 (ref), v42 (ref), v52 (ref), v9 (ref), v72 (ref), t6 (ref), t (copy), v19 (ref), v34 (ref), v142 (ref), v26 (ref), v17 (ref), t3 (ref), v23 (ref), v24 (ref), v28 (ref), v31 (ref) ]]
		if v3 then
			v3:Destroy()
		end

		local v1 = tick()

		v29.Position = Position
		v29.Parent = v15
		v29.BorderSizePixel = 0
		v29.ZIndex = 1
		v42.ZIndex = 1
		v52.ZIndex = 1
		v15.ZIndex = 1

		if v9 then
			v9.ZIndex = 1
		end

		if v72 then
			v72.ZIndex = 1

			for k, v in pairs(v72:GetChildren()) do
				v.ZIndex = 1
			end
		end

		t6[v29] = nil

		if not t.Tool then
			return
		end

		local v2 = v19
		local AbsolutePosition = v2.AbsolutePosition
		local AbsoluteSize = v2.AbsoluteSize

		if if AbsolutePosition.X < p1 and (p1 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p2) then if p2 <= AbsolutePosition.Y + AbsoluteSize.Y then true else false else false then
			if t.Index <= v34 then
				t:MoveToInventory()
			end

			if v34 < t.Index and v1 - v142 < 0.5 then
				if v26 then
					t:Clear()
					v26:Fill(t.Tool)
					t:Delete()
				end

				v1 = 0
			end
		else
			local v4 = v17
			local AbsolutePosition2 = v4.AbsolutePosition
			local AbsoluteSize2 = v4.AbsoluteSize

			if if AbsolutePosition2.X < p1 and (p1 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < p2) then if p2 <= AbsolutePosition2.Y + AbsoluteSize2.Y then true else false else false then
				local t2 = { (1 / 0), nil }

				for i = 1, v34 do
					local v6 = t3[i]
					local Frame = v6.Frame
					local magnitude = (Frame.AbsolutePosition + Frame.AbsoluteSize / 2 - Vector2.new(p1, p2)).magnitude

					if magnitude < t2[1] then
						t2 = { magnitude, v6 }
					end
				end

				local v8 = t2[2]

				if v8 ~= t then
					t:Swap(v8)

					if v34 < t.Index then
						local Tool = t.Tool

						if Tool then
							if (if Tool then Tool:IsA("HopperBin") and Tool.Active or (if Tool.Parent == v23 then true else false) else Tool) and v24 then
								v24:UnequipTools()

								if v28 then
									warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
								end
							end

							if v31 then
								t.Frame.Visible = false
								t.Frame.Parent = v19
							end
						else
							t:Delete()
						end
					end
				end
			elseif t.Index <= v34 then
				t:MoveToInventory()
			end
		end

		v142 = v1
	end)
	v29.Parent = p1
	t3[v1] = t

	if not (v34 < v1) then
		return t
	end

	local v16 = v21.AbsoluteSize.X / (v2 + 5)
	local v172 = math.floor(v16)
	local v18 = (#v22:GetChildren() - 1) / v172
	local v192 = math.ceil(v18) * (v2 + 5) + 5

	v21.CanvasSize = UDim2.fromOffset(0, v192)

	if not v19.Visible or v31 then
		return t
	end

	local v20 = v21.CanvasSize.Y.Offset - v21.AbsoluteSize.Y

	v21.CanvasPosition = Vector2.new(0, (math.max(0, v20)))

	return t
end

local function SetNumberOfHotbarSlots(p1) --[[ SetNumberOfHotbarSlots | Line: 880 | Upvalues: v34 (ref), t3 (copy), v40 (copy), v17 (ref), v26 (ref), v27 (ref), UpdateBackpackLayout (copy) ]]
	if v34 == p1 then
		return
	end

	local v1 = v34

	if p1 < v1 then
		for i = v1, p1 + 1, -1 do
			local v2 = t3[i]

			if v2 then
				v2:MoveToInventory()
				v2:Delete()
			end
		end

		for j = v1, p1 + 1, -1 do
			local v3 = t3[j]

			if not v3.Tool then
				v3:Delete()
			end
		end
	else
		for k = v1, p1 do
			v34 = k

			if t3[k] then
				local _ = t3[k]
				local Tool = t3[k].Tool
				local v4 = v40(v17, k)

				if Tool then
					v4:Fill(Tool)

					continue
				end

				if not v26 then
					v26 = v4
				end

				continue
			end

			local v5 = v40(v17, k)

			v5.Frame.Visible = false

			if not v26 then
				v26 = v5
			end
		end
	end

	v34 = p1
	v27 = 0

	for n = 1, p1 do
		if t3[n] and t3[n].Tool then
			v27 = v27 + 1
		end
	end

	UpdateBackpackLayout()
end

local function OnChildAdded(p1) --[[ OnChildAdded | Line: 942 | Upvalues: v23 (ref), v24 (ref), v33 (ref), v28 (ref), v29 (ref), t4 (copy), LocalPlayer (ref), v26 (ref), v40 (copy), v22 (ref), t3 (copy), v25 (ref), AdjustHotbarFrames (copy), v34 (ref), v19 (ref), t (copy) ]]
	if p1:IsA("Tool") or p1:IsA("HopperBin") then
		if p1.Parent == v23 then
			v33 = tick()
		end

		if v28 and p1.Parent == v23 then
			warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
		end

		if not v29 and (p1.Parent == v23 and not t4[p1]) then
			local StarterGear = LocalPlayer:FindFirstChild("StarterGear")

			if StarterGear and StarterGear:FindFirstChild(p1.Name) then
				v29 = true

				for i = (v26 or v40(v22)).Index, 1, -1 do
					local v2 = t3[i]
					local v3 = i - 1

					if v3 > 0 then
						t3[v3]:Swap(v2)

						continue
					end

					v2:Fill(p1)
				end

				for k, v in pairs(v23:GetChildren()) do
					if v:IsA("Tool") and v ~= p1 then
						v.Parent = v25
					end
				end

				AdjustHotbarFrames()

				return
			end
		end

		local v4 = t4[p1]

		if v4 then
			v4:UpdateEquipView()
		else
			local v5 = v26 or v40(v22)

			v5:Fill(p1)

			if v5.Index <= v34 and not v19.Visible then
				AdjustHotbarFrames()
			end

			if p1:IsA("HopperBin") and p1.Active then
				if v24 then
					v24:UnequipTools()

					if v28 then
						warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
					end
				end

				v28 = p1
			end
		end

		t.BackpackItemAdded:Fire()
	else
		if not p1:IsA("Humanoid") or p1.Parent ~= v23 then
			return
		end

		v24 = p1
	end
end

local function OnChildRemoved(p1) --[[ OnChildRemoved | Line: 1009 | Upvalues: v33 (ref), v23 (ref), v25 (ref), t4 (copy), v34 (ref), v19 (ref), AdjustHotbarFrames (copy), v28 (ref), t (copy), t3 (copy) ]]
	if not (p1:IsA("Tool") or p1:IsA("HopperBin")) then
		return
	end

	v33 = tick()

	local v1 = p1.Parent

	if v1 == v23 or v1 == v25 then
		return
	end

	local v2 = t4[p1]

	if v2 then
		v2:Clear()

		if v34 < v2.Index then
			v2:Delete()
		elseif not v19.Visible then
			AdjustHotbarFrames()
		end
	end

	if p1 == v28 then
		v28 = nil
	end

	t.BackpackItemRemoved:Fire()

	local v3

	for i = v34 + 1, #t3 do
		local v4 = t3[i]

		if v4 and v4.Tool then
			v3 = false

			if not v3 then
				return
			end

			t.BackpackEmpty:Fire()

			return
		end
	end

	v3 = true

	if not v3 then
		return
	end

	t.BackpackEmpty:Fire()
end

local function OnCharacterAdded(p1) --[[ OnCharacterAdded | Line: 1043 | Upvalues: t3 (copy), v34 (ref), v28 (ref), t8 (ref), v23 (ref), OnChildRemoved (copy), OnChildAdded (copy), v25 (ref), LocalPlayer (ref), AdjustHotbarFrames (copy) ]]
	for i = #t3, 1, -1 do
		local v1 = t3[i]

		if v1.Tool then
			v1:Clear()
		end

		if v34 < i then
			v1:Delete()
		end
	end

	v28 = nil

	for k, v in pairs(t8) do
		v:disconnect()
	end

	t8 = {}
	v23 = p1
	table.insert(t8, p1.ChildRemoved:connect(OnChildRemoved))
	table.insert(t8, p1.ChildAdded:connect(OnChildAdded))

	for k, v in pairs(p1:GetChildren()) do
		OnChildAdded(v)
	end

	v25 = LocalPlayer:WaitForChild("Backpack")
	table.insert(t8, v25.ChildRemoved:connect(OnChildRemoved))
	table.insert(t8, v25.ChildAdded:connect(OnChildAdded))

	for k, v in pairs(v25:GetChildren()) do
		OnChildAdded(v)
	end

	AdjustHotbarFrames()
end

local function OnInputBegan(p1, p2) --[[ OnInputBegan | Line: 1082 | Upvalues: v30 (ref), t5 (copy), v19 (ref), t (copy) ]]
	if p1.UserInputType == Enum.UserInputType.Keyboard and not v30 then
		local v1 = t5[p1.KeyCode.Value]

		if v1 then
			v1(p2)
		end
	end

	local UserInputType = p1.UserInputType

	if p2 or UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.Touch or not v19.Visible then
		return
	end

	t.OpenClose()
end

local function OnUISChanged(p1) --[[ OnUISChanged | Line: 1105 | Upvalues: UserInputService (copy), VRService (copy), v34 (ref), t3 (copy) ]]
	if p1 ~= "KeyboardEnabled" and p1 ~= "VREnabled" then
		return
	end

	local v1 = UserInputService.KeyboardEnabled and not VRService.VREnabled

	for i = 1, v34 do
		t3[i]:TurnNumber(v1)
	end
end

local v41 = nil
local v42 = nil

local function f43() --[[ Line: 1117 ]] end

local v44 = Vector2.new(0, 0)

function unbindAllGamepadEquipActions() --[[ unbindAllGamepadEquipActions | Line: 1121 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("BackpackHasGamepadFocus")
	ContextActionService:UnbindAction("BackpackCloseInventory")
end

local function setHotbarVisibility(p1, p2) --[[ setHotbarVisibility | Line: 1128 | Upvalues: v34 (ref), t3 (copy) ]]
	for i = 1, v34 do
		local v1 = t3[i]

		if v1 and (v1.Frame and (p2 or v1.Tool)) then
			v1.Frame.Visible = p1
		end
	end
end

local function getInputDirection(p1) --[[ getInputDirection | Line: 1137 | Upvalues: v44 (ref) ]]
	local v1 = if p1.UserInputState == Enum.UserInputState.End then -1 else 1

	if p1.KeyCode == Enum.KeyCode.Thumbstick1 then
		local magnitude = p1.Position.magnitude

		v44 = if magnitude > 0.98 then Vector2.new(p1.Position.x / magnitude, -p1.Position.y / magnitude) else Vector2.new(0, 0)
	else
		v44 = if p1.KeyCode == Enum.KeyCode.DPadLeft then Vector2.new(v44.x - v1 * 1, v44.y) elseif p1.KeyCode == Enum.KeyCode.DPadRight then Vector2.new(v44.x + v1 * 1, v44.y) elseif p1.KeyCode == Enum.KeyCode.DPadUp then Vector2.new(v44.x, v44.y - v1 * 1) elseif p1.KeyCode == Enum.KeyCode.DPadDown then Vector2.new(v44.x, v44.y + v1 * 1) else Vector2.new(0, 0)
	end

	return v44
end

function changeToolFunc(p1, p2, p3) --[[ Line: 1198 | Upvalues: v41 (ref), v42 (ref), v24 (ref), v28 (ref), v34 (ref), t3 (copy), v36 (ref) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	if v41 then
		if (v41.KeyCode ~= Enum.KeyCode.ButtonR1 or p3.KeyCode ~= Enum.KeyCode.ButtonL1) and (v41.KeyCode ~= Enum.KeyCode.ButtonL1 or p3.KeyCode ~= Enum.KeyCode.ButtonR1) then
			v41 = p3
			v42 = tick()
			delay(0.06, function() --[[ Line: 1226 | Upvalues: v41 (ref), p3 (copy), v34 (ref), t3 (ref), v24 (ref), v28 (ref), v36 (ref) ]]
				if v41 ~= p3 then
					return
				end

				local v1 = if p3.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

				for i = 1, v34 do
					if t3[i]:IsEquipped() then
						local sum2 = v1 + i
						local v2 = false

						if v34 < sum2 then
							sum2 = 1
							v2 = true
						elseif sum2 < 1 then
							sum2 = v34
							v2 = true
						end

						local v3 = sum2

						while not t3[sum2].Tool do
							sum2 = sum2 + v1

							if sum2 == v3 then
								return
							end

							if v34 < sum2 then
								sum2 = 1
								v2 = true
							elseif sum2 < 1 then
								sum2 = v34
								v2 = true
							else
								continue
							end
						end

						if not v2 then
							t3[sum2]:Select()

							return
						end

						if not v24 then
							v36 = nil

							return
						end

						v24:UnequipTools()

						if not v28 then
							v36 = nil

							return
						end

						warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
						v36 = nil

						return
					end
				end

				if v36 and v36.Tool then
					v36:Select()

					return
				end

				for j = if v1 == -1 then v34 or 1 else 1, if v1 == -1 then 1 else v34, v1 do
					if t3[j].Tool then
						t3[j]:Select()

						return
					end
				end
			end)

			return
		end

		if tick() - v42 <= 0.06 then
			if not v24 then
				v41 = p3
				v42 = tick()

				return
			end

			v24:UnequipTools()

			if not v28 then
				v41 = p3
				v42 = tick()

				return
			end

			warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
			v41 = p3
			v42 = tick()

			return
		end
	end

	v41 = p3
	v42 = tick()
	delay(0.06, function() --[[ Line: 1226 | Upvalues: v41 (ref), p3 (copy), v34 (ref), t3 (ref), v24 (ref), v28 (ref), v36 (ref) ]]
		if v41 ~= p3 then
			return
		end

		local v1 = if p3.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

		for i = 1, v34 do
			if t3[i]:IsEquipped() then
				local sum2 = v1 + i
				local v2 = false

				if v34 < sum2 then
					sum2 = 1
					v2 = true
				elseif sum2 < 1 then
					sum2 = v34
					v2 = true
				end

				local v3 = sum2

				while not t3[sum2].Tool do
					sum2 = sum2 + v1

					if sum2 == v3 then
						return
					end

					if v34 < sum2 then
						sum2 = 1
						v2 = true
					elseif sum2 < 1 then
						sum2 = v34
						v2 = true
					else
						continue
					end
				end

				if not v2 then
					t3[sum2]:Select()

					return
				end

				if not v24 then
					v36 = nil

					return
				end

				v24:UnequipTools()

				if not v28 then
					v36 = nil

					return
				end

				warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
				v36 = nil

				return
			end
		end

		if v36 and v36.Tool then
			v36:Select()

			return
		end

		for j = if v1 == -1 then v34 or 1 else 1, if v1 == -1 then 1 else v34, v1 do
			if t3[j].Tool then
				t3[j]:Select()

				return
			end
		end
	end)
end
function getGamepadSwapSlot() --[[ getGamepadSwapSlot | Line: 1293 | Upvalues: t3 (copy) ]]
	for i = 1, #t3 do
		if t3[i].Frame.BorderSizePixel > 0 then
			return t3[i]
		end
	end
end
function changeSlot(p1) --[[ changeSlot | Line: 1301 | Upvalues: GamepadService (copy), GuiService (copy), v20 (ref), v34 (ref) ]]
	if p1.Frame == GuiService.SelectedObject and not GamepadService.GamepadCursorEnabled then
		local v1 = getGamepadSwapSlot()

		if not v1 then
			local Size = p1.Frame.Size
			local Position = p1.Frame.Position

			p1.Frame:TweenSizeAndPosition(Size + UDim2.fromOffset(10, 10), Position - UDim2.fromOffset(5, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 1337 | Upvalues: p1 (copy), Size (copy), Position (copy) ]]
				p1.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
			end)
			p1.Frame.BorderSizePixel = 3
			v20.SelectionImageObject.Visible = true

			return
		end

		v1.Frame.BorderSizePixel = 0

		if v1 == p1 then
			return
		end

		p1:Swap(v1)
		v20.SelectionImageObject.Visible = false

		if v34 < p1.Index and not p1.Tool then
			if GuiService.SelectedObject == p1.Frame then
				GuiService.SelectedObject = v1.Frame
			end

			p1:Delete()
		end

		if not (v34 < v1.Index) or v1.Tool then
			return
		end

		if GuiService.SelectedObject ~= v1.Frame then
			v1:Delete()

			return
		end

		GuiService.SelectedObject = p1.Frame
		v1:Delete()

		return
	end

	p1:Select()
	v20.SelectionImageObject.Visible = false
end
function enableGamepadInventoryControl() --[[ enableGamepadInventoryControl | Line: 1357 | Upvalues: v19 (ref), t (copy), ContextActionService (copy), f43 (copy), GuiService (copy), v17 (ref) ]]
	local function f1(p1, p2, p3) --[[ Line: 1358 | Upvalues: v19 (ref), t (ref) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return
		end

		if getGamepadSwapSlot() then
			local v1 = getGamepadSwapSlot()

			if v1 then
				v1.Frame.BorderSizePixel = 0
			end
		else
			if not v19.Visible then
				return
			end

			t.OpenClose()
		end
	end

	ContextActionService:BindAction("BackpackHasGamepadFocus", f43, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction("BackpackCloseInventory", f1, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)
	GuiService.SelectedObject = v17:FindFirstChild("1")
end
function disableGamepadInventoryControl() --[[ disableGamepadInventoryControl | Line: 1392 | Upvalues: v34 (ref), t3 (copy), GuiService (copy), v16 (ref) ]]
	unbindAllGamepadEquipActions()

	for i = 1, v34 do
		local v1 = t3[i]

		if v1 and v1.Frame then
			v1.Frame.BorderSizePixel = 0
		end
	end

	if not (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(v16)) then
		return
	end

	GuiService.SelectedObject = nil
end

local function bindBackpackHotbarAction() --[[ bindBackpackHotbarAction | Line: 1407 | Upvalues: v14 (ref), ContextActionService (copy) ]]
	if v14 then
		return
	end

	v14 = true
	ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
end

local function unbindBackpackHotbarAction() --[[ unbindBackpackHotbarAction | Line: 1422 | Upvalues: v14 (ref), ContextActionService (copy) ]]
	disableGamepadInventoryControl()
	v14 = false
	ContextActionService:UnbindAction("BackpackHotbarEquip")
end

function gamepadDisconnected() --[[ gamepadDisconnected | Line: 1428 | Upvalues: VRService (copy), v32 (ref) ]]
	if VRService.VREnabled then
		return
	end

	v32 = false
	disableGamepadInventoryControl()
end
function gamepadConnected() --[[ gamepadConnected | Line: 1435 | Upvalues: VRService (copy), v32 (ref), GuiService (copy), v16 (ref), v27 (ref), v14 (ref), ContextActionService (copy), v19 (ref) ]]
	if VRService.VREnabled then
		return
	end

	v32 = true
	GuiService:AddSelectionParent("BackpackSelection", v16)

	if v27 >= 1 and not v14 then
		v14 = true
		ContextActionService:BindAction("BackpackHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end

	if not v19.Visible then
		return
	end

	enableGamepadInventoryControl()
end

local function MakeVRRoundButton(p1, p2) --[[ MakeVRRoundButton | Line: 1486 | Upvalues: NewGui (copy) ]]
	local v1 = NewGui("ImageButton", p1)

	v1.Size = UDim2.fromOffset(40, 40)
	v1.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"

	local v2 = NewGui("ImageLabel", "Icon")

	v2.Size = UDim2.fromScale(0.5, 0.5)
	v2.Position = UDim2.fromScale(0.25, 0.25)
	v2.Image = p2
	v2.Parent = v1

	local v3 = NewGui("ImageLabel", "Selection")

	v3.Size = UDim2.fromScale(0.9, 0.9)
	v3.Position = UDim2.fromScale(0.05, 0.05)
	v3.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	v1.SelectionImageObject = v3

	return v1, v2, v3
end

v16 = NewGui("Frame", "Backpack")

if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
	v16.Parent = BackpackGui
end

v17 = NewGui("Frame", "Hotbar")
v17.Parent = v16

for i = 1, v34 do
	local v45 = v40(v17, i)

	v45.Frame.Visible = false

	if not v26 then
		v26 = v45
	end
end

v18 = NewGui("ImageButton", "OpenInventory")
v18.Size = UDim2.fromOffset(30, 30)
v18.Image = "rbxasset://textures/ui/Backpack/ScrollUpArrow.png"
v18.MouseButton1Click:connect(function() --[[ Line: 1536 | Upvalues: t (copy) ]]
	t.OpenClose()
end)
v18.SelectionGained:connect(function() --[[ Line: 1539 | Upvalues: v18 (ref), v9 (copy) ]]
	v18.ImageColor3 = v9
end)
v18.SelectionLost:connect(function() --[[ Line: 1542 | Upvalues: v18 (ref) ]]
	v18.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
end)

local v46 = NewGui("Frame", "Selection")

v46.Visible = false
v18.SelectionImageObject = v46

local v47 = MakeVRRoundButton("CloseInventory", "rbxasset://textures/ui/Keyboard/close_button_icon.png")

v47.Position = UDim2.fromOffset(0, -50)
v47.MouseButton1Click:connect(function() --[[ Line: 1552 | Upvalues: v19 (ref), t (copy) ]]
	if not v19.Visible then
		return
	end

	t.OpenClose()
end)
LeftBumperButton = NewGui("ImageLabel", "LeftBumper")
LeftBumperButton.Size = UDim2.fromOffset(40, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2)
RightBumperButton = NewGui("ImageLabel", "RightBumper")
RightBumperButton.Size = UDim2.fromOffset(40, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2)
v19 = NewGui("Frame", "Inventory")
v19.BackgroundTransparency = v3
v19.BackgroundColor3 = v4
v19.Active = true
v19.Visible = false
v19.Parent = v16
v20 = NewGui("TextButton", "VRInventorySelector")
v20.Position = UDim2.new(0, 0, 0, 0)
v20.Size = UDim2.fromScale(1, 1)
v20.BackgroundTransparency = 1
v20.Text = ""
v20.Parent = v19

local v48 = NewGui("ImageLabel", "Selector")

v48.Size = UDim2.fromScale(1, 1)
v48.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v48.ScaleType = Enum.ScaleType.Slice
v48.SliceCenter = Rect.new(12, 12, 52, 52)
v48.Visible = false
v20.SelectionImageObject = v48
v21 = NewGui("ScrollingFrame", "ScrollingFrame")
v21.Selectable = false
v21.CanvasSize = UDim2.new(0, 0, 0, 0)
v21.Parent = v19
v22 = NewGui("Frame", "UIGridFrame")
v22.Selectable = false
v22.Size = UDim2.new(1, -10, 1, 0)
v22.Position = UDim2.fromOffset(5, 0)
v22.Parent = v21

local UIGridLayout = Instance.new("UIGridLayout")

UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.fromOffset(v2, v2)
UIGridLayout.CellPadding = UDim2.fromOffset(5, 5)
UIGridLayout.Parent = v22

local v49 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v49.Size = UDim2.fromOffset(34, 34)
v49.Position = UDim2.new(0.5, -v49.Size.X.Offset / 2, 0, 43)
v49.Icon.Position = v49.Icon.Position - UDim2.fromOffset(0, 2)
v49.MouseButton1Click:connect(function() --[[ Line: 1612 | Upvalues: v21 (ref), v2 (ref) ]]
	v21.CanvasPosition = Vector2.new(v21.CanvasPosition.X, (math.min(v21.CanvasSize.Y.Offset - v21.AbsoluteWindowSize.Y, (math.max(0, v21.CanvasPosition.Y - (v2 + 5))))))
end)

local v50 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v50.Rotation = 180
v50.Icon.Position = v50.Icon.Position - UDim2.fromOffset(0, 2)
v50.Size = UDim2.fromOffset(34, 34)
v50.Position = UDim2.new(0.5, -v50.Size.X.Offset / 2, 1, -v50.Size.Y.Offset - 3)
v50.MouseButton1Click:connect(function() --[[ Line: 1629 | Upvalues: v21 (ref), v2 (ref) ]]
	v21.CanvasPosition = Vector2.new(v21.CanvasPosition.X, (math.min(v21.CanvasSize.Y.Offset - v21.AbsoluteWindowSize.Y, (math.max(0, v21.CanvasPosition.Y + (v2 + 5))))))
end)
v21.Changed:connect(function(p1) --[[ Line: 1640 | Upvalues: v21 (ref), v49 (ref), v50 (ref) ]]
	if p1 ~= "AbsoluteWindowSize" and (p1 ~= "CanvasPosition" and p1 ~= "CanvasSize") then
		return
	end

	local v1 = if v21.CanvasPosition.Y < v21.CanvasSize.Y.Offset - v21.AbsoluteWindowSize.Y then true else false

	v49.Visible = v21.CanvasPosition.Y ~= 0
	v50.Visible = v1
end)
UpdateBackpackLayout()

local v51 = "Frame"

local function f52(p1) --[[ Line: 113 | Upvalues: v51 (copy) ]]
	local v12 = Instance.new(v51)
	local v2 = nil

	for k2, v in pairs(p1) do
		if type(k2) == "number" then
			v.Parent = v12

			continue
		end

		if k2 == "Parent" then
			v2 = v

			continue
		end

		v12[k2] = v
	end

	if v2 then
		v12.Parent = v2
	end

	return v12
end

local t9 = {
	Name = "GamepadHintsFrame",
	BackgroundTransparency = 1,
	Visible = false
}
local fromOffset = UDim2.fromOffset
local Offset = v17.Size.X.Offset

t9.Size = fromOffset(Offset, if v13 then 95 else 60)
t9.Parent = v16

local v54 = f52(t9)

local function addGamepadHint(p1, p2, p3) --[[ addGamepadHint | Line: 1663 | Upvalues: v54 (copy), v13 (copy) ]]
	local v1 = "Frame"

	local function f2(p1) --[[ Line: 113 | Upvalues: v1 (copy) ]]
		local v12 = Instance.new(v1)
		local v2 = nil

		for k2, v in pairs(p1) do
			if type(k2) == "number" then
				v.Parent = v12

				continue
			end

			if k2 == "Parent" then
				v2 = v

				continue
			end

			v12[k2] = v
		end

		if v2 then
			v12.Parent = v2
		end

		return v12
	end

	local v3 = f2({
		Name = "HintFrame",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -5),
		Position = UDim2.new(0, 0, 0, 0),
		Parent = v54
	})
	local v4 = "ImageLabel"

	local function f5(p1) --[[ Line: 113 | Upvalues: v4 (copy) ]]
		local v12 = Instance.new(v4)
		local v2 = nil

		for k2, v in pairs(p1) do
			if type(k2) == "number" then
				v.Parent = v12

				continue
			end

			if k2 == "Parent" then
				v2 = v

				continue
			end

			v12[k2] = v
		end

		if v2 then
			v12.Parent = v2
		end

		return v12
	end

	local t = {
		Name = "HintImage",
		BackgroundTransparency = 1
	}

	t.Size = v13 and UDim2.fromOffset(90, 90) or UDim2.fromOffset(60, 60)
	t.Image = v13 and p2 or p1
	t.Parent = v3
	f5(t)

	local v8 = "TextLabel"

	local function f9(p1) --[[ Line: 113 | Upvalues: v8 (copy) ]]
		local v12 = Instance.new(v8)
		local v2 = nil

		for k2, v in pairs(p1) do
			if type(k2) == "number" then
				v.Parent = v12

				continue
			end

			if k2 == "Parent" then
				v2 = v

				continue
			end

			v12[k2] = v
		end

		if v2 then
			v12.Parent = v2
		end

		return v12
	end

	local t2 = {
		Name = "HintText",
		BackgroundTransparency = 1,
		TextWrapped = true
	}

	t2.Position = UDim2.fromOffset(if v13 then 100 else 70, 0)
	t2.Size = UDim2.new(1, -(if v13 then 100 else 70), 1, 0)
	t2.Font = Enum.Font.SourceSansBold
	t2.FontSize = v13 and Enum.FontSize.Size36 or Enum.FontSize.Size24
	t2.Text = p3
	t2.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	t2.TextXAlignment = Enum.TextXAlignment.Left
	t2.Parent = v3

	local v15 = f9(t2)

	Instance.new("UITextSizeConstraint", v15).MaxTextSize = v15.TextSize
end

local function resizeGamepadHintsFrame() --[[ resizeGamepadHintsFrame | Line: 1697 | Upvalues: v54 (copy), v17 (ref), v13 (copy), v19 (ref) ]]
	v54.Size = UDim2.new(v17.Size.X.Scale, v17.Size.X.Offset, 0, if v13 then 95 else 60)
	v54.Position = UDim2.new(v17.Position.X.Scale, v17.Position.X.Offset, v19.Position.Y.Scale, v19.Position.Y.Offset - v54.Size.Y.Offset)

	local v5 = v54:GetChildren()
	local sum = 0

	for i = 1, #v5 do
		v5[i].Size = UDim2.new(1, 0, 1, -5)
		v5[i].Position = UDim2.new(0, 0, 0, 0)
		sum = sum + (v5[i].HintText.Position.X.Offset + v5[i].HintText.TextBounds.X)
	end

	local v6 = (v54.AbsoluteSize.X - sum) / (#v5 - 1)

	for j = 1, #v5 do
		v5[j].Position = j == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v5[j - 1].Position.X.Offset + v5[j - 1].Size.X.Offset + v6, 0, 0)
		v5[j].Size = UDim2.new(0, v5[j].HintText.Position.X.Offset + v5[j].HintText.TextBounds.X, 1, -5)
	end
end

addGamepadHint("rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png", "rbxasset://textures/ui/Controls/DesignSystem/ButtonX@2x.png", "Remove From Hotbar")
addGamepadHint("rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png", "rbxasset://textures/ui/Controls/DesignSystem/ButtonA@2x.png", "Select/Swap")
addGamepadHint("rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png", "rbxasset://textures/ui/Controls/DesignSystem/ButtonB@2x.png", "Close Backpack")

local v55 = NewGui("Frame", "Search")

v55.BackgroundColor3 = v11
v55.BackgroundTransparency = v12
v55.Size = UDim2.fromOffset(190, 30)
v55.Position = UDim2.new(1, -v55.Size.X.Offset - 5, 0, 5)
v55.Parent = v19

local v56 = NewGui("TextBox", "TextBox")

v56.Text = v10
v56.ClearTextOnFocus = false
v56.FontSize = Enum.FontSize.Size24
v56.TextXAlignment = Enum.TextXAlignment.Left
v56.Size = v55.Size - UDim2.fromOffset(0, 0)
v56.Position = UDim2.fromOffset(0, 0)
v56.Parent = v55

local v57 = NewGui("TextButton", "X")

v57.Text = "x"
v57.TextColor3 = v6
v57.FontSize = Enum.FontSize.Size24
v57.TextYAlignment = Enum.TextYAlignment.Bottom
v57.BackgroundColor3 = v11
v57.BackgroundTransparency = 0
v57.Size = UDim2.new(0, v55.Size.Y.Offset - 10, 0, v55.Size.Y.Offset - 10)
v57.Position = UDim2.new(1, -v57.Size.X.Offset - 10, 0.5, -v57.Size.Y.Offset / 2)
v57.ZIndex = 0
v57.Visible = false
v57.BorderSizePixel = 0
v57.Parent = v55

local function search() --[[ search | Line: 1786 | Upvalues: v56 (copy), v34 (ref), t3 (copy), v19 (ref), v31 (ref), v22 (ref), v21 (ref), v2 (ref), v57 (copy) ]]
	local t = {}

	for v1 in v56.Text:gmatch("%S+") do
		t[v1:lower()] = true
	end

	local list = {}

	for i = v34 + 1, #t3 do
		local v23 = t3[i]

		table.insert(list, { v23, (v23:CheckTerms(t)) })
		v23.Frame.Visible = false
		v23.Frame.Parent = v19
	end

	table.sort(list, function(p1, p2) --[[ Line: 1801 ]]
		return p1[2] > p2[2]
	end)
	v31 = true

	local count = 0

	for i, v in ipairs(list) do
		local v3 = v[1]

		if v[2] > 0 then
			v3.Frame.Visible = true
			v3.Frame.Parent = v22
			v3.Frame.LayoutOrder = v34 + count
			count = count + 1
		end
	end

	v21.CanvasPosition = Vector2.new(0, 0)

	local v5 = math.floor(v21.AbsoluteSize.X / (v2 + 5))

	v21.CanvasSize = UDim2.fromOffset(0, math.ceil((#v22:GetChildren() - 1) / v5) * (v2 + 5) + 5)
	v57.ZIndex = 3
end

local function clearResults() --[[ clearResults | Line: 1823 | Upvalues: v57 (copy), v31 (ref), v34 (ref), t3 (copy), v22 (ref), v21 (ref), v2 (ref) ]]
	local v1, v23, v3, v4

	if not (v57.ZIndex > 0) then
		v1 = v21.AbsoluteSize.X / (v2 + 5)
		v23 = math.floor(v1)
		v3 = (#v22:GetChildren() - 1) / v23
		v4 = math.ceil(v3) * (v2 + 5) + 5
		v21.CanvasSize = UDim2.fromOffset(0, v4)

		return
	end

	v31 = false

	for i = v34 + 1, #t3 do
		local v5 = t3[i]

		v5.Frame.LayoutOrder = v5.Index
		v5.Frame.Parent = v22
		v5.Frame.Visible = true
	end

	v57.ZIndex = 0
	v1 = v21.AbsoluteSize.X / (v2 + 5)
	v23 = math.floor(v1)
	v3 = (#v22:GetChildren() - 1) / v23
	v4 = math.ceil(v3) * (v2 + 5) + 5
	v21.CanvasSize = UDim2.fromOffset(0, v4)
end

local function reset() --[[ reset | Line: 1837 | Upvalues: clearResults (copy), v56 (copy), v10 (ref) ]]
	clearResults()
	v56.Text = v10
end

local function onChanged(p1) --[[ onChanged | Line: 1842 | Upvalues: v56 (copy), clearResults (copy), v10 (ref), search (copy), v57 (copy) ]]
	if p1 ~= "Text" then
		return
	end

	local Text = v56.Text

	if Text == "" then
		clearResults()
	elseif Text ~= v10 then
		search()
	end

	v57.Visible = if Text == "" then false else Text ~= v10
end

local function onFocused() --[[ onFocused | Line: 1854 | Upvalues: v56 (copy), v10 (ref) ]]
	if v56.Text ~= v10 then
		return
	end

	v56.Text = ""
end

local function focusLost(p1) --[[ focusLost | Line: 1860 | Upvalues: search (copy), v56 (copy), v10 (ref) ]]
	if p1 then
		search()

		return
	end

	if v56.Text ~= "" then
		return
	end

	v56.Text = v10
end

v56.Focused:connect(onFocused)
v57.MouseButton1Click:connect(reset)
v56.Changed:connect(onChanged)
v56.FocusLost:connect(focusLost)
t.StateChanged.Event:connect(function(p1) --[[ Line: 1874 | Upvalues: v57 (copy), clearResults (copy), v56 (copy), v10 (ref) ]]
	v57.Modal = p1

	if p1 then
		return
	end

	clearResults()
	v56.Text = v10
end)
t5[Enum.KeyCode.Escape.Value] = function(p1) --[[ Line: 1881 | Upvalues: clearResults (copy), v56 (copy), v10 (ref), v19 (ref), t (copy) ]]
	if p1 then
		clearResults()
		v56.Text = v10

		return
	end

	if not v19.Visible then
		return
	end

	t.OpenClose()
end

local function detectGamepad(p1) --[[ detectGamepad | Line: 1889 | Upvalues: VRService (copy), v55 (copy) ]]
	if p1 == Enum.UserInputType.Gamepad1 and not VRService.VREnabled then
		v55.Visible = false
	else
		v55.Visible = true
	end
end

UserInputService.LastInputTypeChanged:connect(detectGamepad)

local function f58(p1, p2, p3) --[[ Line: 1900 | Upvalues: GuiService (copy), v34 (ref), t3 (copy) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	if not GuiService.SelectedObject then
		return
	end

	for i = 1, v34 do
		if t3[i].Frame == GuiService.SelectedObject and t3[i].Tool then
			t3[i]:MoveToInventory()

			return
		end
	end
end

local function openClose() --[[ openClose | Line: 1916 | Upvalues: t6 (copy), v19 (ref), AdjustHotbarFrames (copy), v17 (ref), v34 (ref), t3 (copy), v32 (ref), t2 (copy), UserInputService (copy), resizeGamepadHintsFrame (copy), v54 (copy), ContextActionService (copy), f58 (copy), t (copy) ]]
	if not next(t6) then
		v19.Visible = not v19.Visible

		local Visible = v19.Visible

		AdjustHotbarFrames()
		v17.Active = not v17.Active

		for i = 1, v34 do
			t3[i]:SetClickability(not Visible)
		end
	end

	if v19.Visible then
		if v32 then
			if t2[UserInputService:GetLastInputType()] then
				resizeGamepadHintsFrame()
				v54.Visible = true
			end

			enableGamepadInventoryControl()
		end
	else
		if v32 then
			v54.Visible = false
		end

		disableGamepadInventoryControl()
	end

	if v19.Visible then
		ContextActionService:BindAction("BackpackRemoveSlot", f58, false, Enum.KeyCode.ButtonX)
	else
		ContextActionService:UnbindAction("BackpackRemoveSlot")
	end

	t.IsOpen = v19.Visible
	t.StateChanged:Fire(v19.Visible)
end

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
t.OpenClose = openClose

while not LocalPlayer do
	wait()
	LocalPlayer = Players.LocalPlayer
end

LocalPlayer.CharacterAdded:connect(OnCharacterAdded)

if LocalPlayer.Character then
	OnCharacterAdded(LocalPlayer.Character)
end

for j = 0, 9 do
	table.insert(t7, (tostring(j)))
end

table.insert(t7, "`")
UserInputService.InputBegan:connect(OnInputBegan)
UserInputService.TextBoxFocused:connect(function() --[[ Line: 1990 | Upvalues: v30 (ref) ]]
	v30 = true
end)
UserInputService.TextBoxFocusReleased:connect(function() --[[ Line: 1993 | Upvalues: v30 (ref) ]]
	v30 = false
end)
t5[Backspace] = function() --[[ Line: 1998 | Upvalues: v28 (ref), v24 (ref) ]]
	if not (v28 and v24) then
		return
	end

	v24:UnequipTools()

	if not v28 then
		return
	end

	warn("[Purse] Cannot deselect active hopper. HopperBin is deprecated and not supported.")
end
UserInputService.Changed:connect(OnUISChanged)

local v60 = UserInputService.KeyboardEnabled and not VRService.VREnabled

for k = 1, v34 do
	t3[k]:TurnNumber(v60)
end

local v61

if not UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	UserInputService.GamepadConnected:connect(function(p13) --[[ Line: 2012 ]]
		if p13 ~= Enum.UserInputType.Gamepad1 then
			return
		end

		gamepadConnected()
	end)
	UserInputService.GamepadDisconnected:connect(function(p13) --[[ Line: 2017 ]]
		if p13 ~= Enum.UserInputType.Gamepad1 then
			return
		end

		gamepadDisconnected()
	end)
	GuiService.MenuOpened:Connect(function() --[[ Line: 2038 | Upvalues: t (copy) ]]
		if not t.IsOpen then
			return
		end

		t.OpenClose()
	end)
	v61 = function() --[[ OnPreferredTransparencyChanged | Line: 2055 | Upvalues: GuiService (copy), v3 (ref), v19 (ref), v7 (ref), t3 (copy), v12 (ref), v55 (copy) ]]
		v3 = 0.5 * GuiService.PreferredTransparency
		v19.BackgroundTransparency = v3
		v7 = 0.5 * GuiService.PreferredTransparency

		for i2, v in ipairs(t3) do
			v.Frame.BackgroundTransparency = v7
		end

		v12 = 0.15 * GuiService.PreferredTransparency
		v55.BackgroundTransparency = v12
	end
	GuiService:GetPropertyChangedSignal("PreferredTransparency"):connect(v61)

	return t
end

gamepadConnected()
UserInputService.GamepadConnected:connect(function(p13) --[[ Line: 2012 ]]
	if p13 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadConnected()
end)
UserInputService.GamepadDisconnected:connect(function(p13) --[[ Line: 2017 ]]
	if p13 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadDisconnected()
end)
GuiService.MenuOpened:Connect(function() --[[ Line: 2038 | Upvalues: t (copy) ]]
	if not t.IsOpen then
		return
	end

	t.OpenClose()
end)
v61 = function() --[[ OnPreferredTransparencyChanged | Line: 2055 | Upvalues: GuiService (copy), v3 (ref), v19 (ref), v7 (ref), t3 (copy), v12 (ref), v55 (copy) ]]
	v3 = 0.5 * GuiService.PreferredTransparency
	v19.BackgroundTransparency = v3
	v7 = 0.5 * GuiService.PreferredTransparency

	for i2, v in ipairs(t3) do
		v.Frame.BackgroundTransparency = v7
	end

	v12 = 0.15 * GuiService.PreferredTransparency
	v55.BackgroundTransparency = v12
end
GuiService:GetPropertyChangedSignal("PreferredTransparency"):connect(v61)

return t