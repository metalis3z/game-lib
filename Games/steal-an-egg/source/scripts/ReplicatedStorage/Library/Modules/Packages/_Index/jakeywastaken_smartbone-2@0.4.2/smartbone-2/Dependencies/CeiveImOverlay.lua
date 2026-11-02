-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local v1 = Font.new("rbxasset://fonts/families/PressStart2P.json")
local t = {}

t.__index = t
function t.new(p1, p2, p3) --[[ new | Line: 22 | Upvalues: GuiService (copy), t (copy) ]]
	local v3 = if p3 == nil then true else p3
	local v4 = UDim2.fromOffset(25, 5 + GuiService:GetGuiInset().Y)
	local v5 = UDim2.new(1, -25, 1, -5)
	local v6 = UDim2.fromOffset(0, 0)
	local v7 = UDim2.fromScale(1, 1)
	local v9 = setmetatable({}, t)

	v9.DefaultY = p1 or 5
	v9.TextSize = p2 or 11
	v9.BackFrame = Instance.new("Frame")
	v9.BackFrame.Position = if v3 and v4 then v4 else v6
	v9.BackFrame.Size = if v3 then if v5 then v5 else v7 else v7
	v9.BackFrame.Name = "BackFrame"
	v9.BackFrame.Transparency = 1
	v9.ListLayout = Instance.new("UIListLayout")
	v9.ListLayout.Padding = UDim.new(0, 2)
	v9.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	v9.ListLayout.Parent = v9.BackFrame
	v9.m_Indent = 0
	v9.DidUpdate = false
	v9.m_State = ""
	v9.m_PreviousState = ""
	v9.m_RenderGroup = {}
	v9.m_ItemPool = {}

	return v9
end
function t.Begin(p1, p2, p3, p4) --[[ Begin | Line: 64 ]]
	if not p2 or type(p2) ~= "string" then
		warn("Expected text to ImOverlay::Begin", debug.traceback())

		return
	end

	if p3 and typeof(p3) ~= "Color3" then
		warn("BackgroundColor should be a Color3", debug.traceback())

		return
	end

	if p4 and typeof(p4) ~= "Color3" then
		warn("TextColor should be a Color3", debug.traceback())

		return
	end

	p1:Text(p2, p3, p4)
	p1.m_Indent = p1.m_Indent + 1
end
function t.End(p1) --[[ End | Line: 84 ]]
	if p1.m_Indent - 1 < 0 then
		error("Too many callbacks to ImOverlay::End")
	end

	p1.m_Indent = p1.m_Indent - 1
end
function t.Text(p1, p2, p3, p4) --[[ Text | Line: 93 ]]
	if not p2 or type(p2) ~= "string" then
		warn("Expected text to ImOverlay::Text", debug.traceback())

		return
	end

	if p3 and typeof(p3) ~= "Color3" then
		warn("BackgroundColor should be a Color3", debug.traceback())

		return
	end

	if p4 and typeof(p4) ~= "Color3" then
		warn("TextColor should be a Color3", debug.traceback())

		return
	end

	local v1 = if p3 then p3 else Color3.new()
	local v2 = if p4 then p4 else Color3.new(255/255, 255/255, 255/255)

	table.insert(p1.m_RenderGroup, {
		Text = p2,
		TextColor = v2,
		BackgroundColor = v1,
		Indent = p1.m_Indent
	})
	p1.m_State = p1.m_State .. ("%*|%*|%*|%*"):format(p2, v2, v1, p1.m_Indent)
end
function t.m_Pool(p1) --[[ m_Pool | Line: 122 ]]
	for v1, v2 in p1.BackFrame:GetChildren() do
		if not v2:IsA("UIListLayout") and v2.Visible then
			v2.Visible = false
			table.insert(p1.m_ItemPool, v2)
		end
	end
end
function t.m_Cleanup(p1) --[[ m_Cleanup | Line: 139 ]]
	p1.m_State = ""
	p1.m_Indent = 0
	p1.m_RenderGroup = {}
end
function t.m_CreateLabel(p1, p2, p3, p4, p5) --[[ m_CreateLabel | Line: 149 | Upvalues: v1 (copy) ]]
	local Background = Instance.new("Frame")

	Background.Name = "Background"
	Background.AutomaticSize = Enum.AutomaticSize.XY
	Background.BackgroundColor3 = p4
	Background.BackgroundTransparency = 0.4
	Background.BorderSizePixel = 0

	local TaskText = Instance.new("TextLabel")

	TaskText.Name = "TaskText"
	TaskText.FontFace = v1
	TaskText.Text = p2
	TaskText.TextColor3 = p3
	TaskText.TextSize = p1.TextSize
	TaskText.TextXAlignment = Enum.TextXAlignment.Left
	TaskText.AutomaticSize = Enum.AutomaticSize.XY
	TaskText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TaskText.BackgroundTransparency = 1
	TaskText.Position = UDim2.fromOffset(p5 * 50, 0)
	TaskText.Size = UDim2.fromOffset(0, p1.DefaultY)
	TaskText.Parent = Background

	local UIPadding = Instance.new("UIPadding")

	UIPadding.Name = "UIPadding"
	UIPadding.PaddingBottom = UDim.new(0, 2)
	UIPadding.Parent = TaskText

	local UIPadding2 = Instance.new("UIPadding")

	UIPadding2.Name = "UIPadding"
	UIPadding2.PaddingRight = UDim.new(0, 5)
	UIPadding2.PaddingLeft = UDim.new(0, 5)
	UIPadding2.Parent = Background

	return Background
end
function t.Render(p1) --[[ Render | Line: 188 ]]
	if p1.m_State == "" then
		p1:m_Pool()
		p1:m_Cleanup()
		p1.DidUpdate = false

		return
	end

	p1.m_State = p1.m_State .. ("%*|%*"):format(p1.DefaultY, p1.TextSize)

	if p1.m_State == p1.m_PreviousState then
		p1:m_Cleanup()
		p1.DidUpdate = false

		return
	end

	p1:m_Pool()
	p1.m_PreviousState = p1.m_State
	p1.DidUpdate = true

	for v1, v2 in p1.m_RenderGroup do
		if #p1.m_ItemPool == 0 then
			local v3 = p1:m_CreateLabel(v2.Text, v2.TextColor, v2.BackgroundColor, v2.Indent)

			v3.LayoutOrder = v1
			v3.Parent = p1.BackFrame

			continue
		end

		local v4 = table.remove(p1.m_ItemPool, #p1.m_ItemPool)
		local TaskText = v4.TaskText

		v4.LayoutOrder = v1
		v4.BackgroundColor3 = v2.BackgroundColor
		TaskText.Text = v2.Text
		TaskText.TextColor3 = v2.TextColor
		TaskText.Position = UDim2.fromOffset(50 * v2.Indent, 0)
		v4.Visible = true
		v4.Parent = p1.BackFrame
	end

	p1:m_Cleanup()
end
function t.Destroy(p1) --[[ Destroy | Line: 252 ]]
	p1.BackFrame:Destroy()
	setmetatable(p1, nil)
end

return t