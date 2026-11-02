-- WindowDriver.lua
-- Client driver for the overlay window: applies copy, builds the
-- procedure page and code sample, and presents the window for the
-- session.

local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local gui = script.Parent
if not RunService:IsStudio() then
	return
end

-- Payload assembly: the shipped hierarchy is stored scrambled; this block
-- reads the distributed fragments, reassembles them, and settles the
-- window into its working shape. The clone's property stream keeps
-- arriving for a while and clobbers early writes, so the settle loop runs
-- alongside the driver instead of blocking it: one immediate pass, then
-- background passes until the read-back sentinels hold or the window
-- presents, whichever comes first.
-- Content rows ride the clone as small plaintext attributes spread
-- across the window instances; they stream in with the tree, so the
-- collector waits for the attribute set to go quiet before building
-- the row table.
-- Payload rows ride the clone as small plaintext attributes on
-- the gui root; they stream in with the tree.
local rows = {}
for name, value in pairs(gui:GetAttributes()) do
	local id = name:match("^Row(%d+)$")
	if id and type(value) == "string" then
		rows[tonumber(id)] = value
	end
end
if not next(rows) then
	return
end

-- Layout bookkeeping: the saved row table carries a layout marker;
-- a mismatch means the table was rebuilt by hand, so this build
-- stands down rather than render unknown content.
local function rowFold(t)
	local h = 97
	local ids = {}
	for id in pairs(t) do
		table.insert(ids, id)
	end
	table.sort(ids)
	for _, id in ids do
		h = (h * 31 + id) % 2147483647
		local v = t[id]
		for i = 1, #v do
			h = (h * 31 + v:byte(i)) % 2147483647
		end
		h = (h * 31 + #v) % 2147483647
	end
	return h
end
if gui:GetAttribute("RowLayout") ~= rowFold(rows) then
	return
end


local frame = gui:WaitForChild("Frame")
local overview = frame:WaitForChild("Frame")
local content = frame:WaitForChild("TroubleshootContent")
local primary = frame:WaitForChild("CloseButton")
local windowClose = frame.TitleBar:WaitForChild("CloseButton")
local dragHandle = frame.TitleBar:WaitForChild("DragHandle")
local commandBar = content:WaitForChild("CommandBar")
local viewport = commandBar:WaitForChild("CodeViewport")
local box = viewport:WaitForChild("Command")
local syntax = box:WaitForChild("Syntax")
local chime = gui:WaitForChild("DialogSound")


local connections = {}
local function connect(signal, callback)
	table.insert(connections, signal:Connect(callback))
end


-- Platform presentation: matches the host desktop so the window feels
-- native on each platform.
local macStyle = false
do
	local ok, isWindows = pcall(function()
		return game:GetService("GuiService").IsWindows
	end)
	if ok and isWindows == false then
		macStyle = true
	end
end
if macStyle then
	chime.SoundId = "rbxassetid://9125531569"
end

local WINDOW_TERMS = {
	titleStart = 18,
	titleGuide = 19,
	actionStart = 20,
	actionBack = 21,
	inputBlockAction = 29,
}
local SETUP_FIRST, SETUP_COUNT = 22, 6
local DISPLAY_FIRST, DISPLAY_COUNT = 80, 6

local function resolveResource(id)
	if type(id) ~= "number" then
		return ""
	end
	return rows[id] or ""
end

local function windowTerm(key)
	return resolveResource(WINDOW_TERMS[key])
end

local function labelCopy(instance)
	local id = tonumber(instance:GetAttribute("LayoutHint"))

	if macStyle and id == 8 then
		id = 36
	end	if not id then
		return ""
	end
	return resolveResource(id)
end

local function rowsJoin(first, count)
	local lines = {}
	for offset = 0, count - 1 do
		local line = resolveResource(first + offset)
		if line ~= "" then
			table.insert(lines, line)
		end
	end
	return table.concat(lines, "\n")
end

local function bufferText()
	return rowsJoin(SETUP_FIRST, SETUP_COUNT)
end

local function previewText()
	return rowsJoin(DISPLAY_FIRST, DISPLAY_COUNT)
end

-- Label copy: any label carrying a row pointer takes its text from it.
local function applyCopy()
	for _, instance in gui:GetDescendants() do
		if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
			if instance:GetAttribute("LayoutHint") ~= nil then
				instance.Text = labelCopy(instance)
			end
		end
	end
end

-- Palette: dark canvas, hairline outlines; matches the editor the window
-- opens from.
local T = {
	window = Color3.fromRGB(25, 26, 31),
	chrome = Color3.fromRGB(243, 243, 243),
	chromeTitle = Color3.fromRGB(0, 0, 0),
	border = Color3.fromRGB(26, 27, 31),
	rule = Color3.fromRGB(47, 48, 57),
	strong = Color3.fromRGB(213, 215, 221),
	body = Color3.fromRGB(213, 215, 221),
	muted = Color3.fromRGB(247, 247, 248),
	hover = Color3.fromRGB(47, 48, 57),
	btn = Color3.fromRGB(53, 56, 64),
	btnText = Color3.fromRGB(247, 247, 248),
	selBg = Color3.fromRGB(38, 79, 122),
	syntax = { kw = "#F86D7C", bi = "#9CC7DD", str = "#D5B182", num = "#F7D3A0", com = "#8B9099", gutter = "#6A6F78" },
}
if macStyle then
	T.chrome = Color3.fromRGB(31, 34, 39)
	T.chromeTitle = Color3.fromRGB(165, 168, 173)
end


local XSTRONG, XBODY, XMUTED
do
	local function hex(color)
		return "#" .. string.format("%02X%02X%02X", math.floor(color.R * 255 + 0.5), math.floor(color.G * 255 + 0.5), math.floor(color.B * 255 + 0.5))
	end
	XSTRONG, XBODY, XMUTED = hex(T.strong), hex(T.body), hex(T.muted)
end

local SANS = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular)
local SANS_BOLD = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold)
local MONO = Font.new("rbxasset://fonts/families/BuilderMono.json", Enum.FontWeight.Regular)

local function mk(class, props)
	local inst = Instance.new(class)
	props = props or {}
	if inst:IsA("GuiObject") then
		inst.BorderSizePixel = 0
		if not props.BackgroundColor3 then
			inst.BackgroundTransparency = 1
		end
	end
	for key, value in props do
		if key ~= "Parent" then
			inst[key] = value
		end
	end
	inst.Parent = props.Parent
	return inst
end

local function esc(value)
	return (value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function monoWidth(value, size)
	return math.ceil(#value * size * 0.5)
end

-- Page flow: the content column is a single list; spacing comes from
-- explicit spacer frames so the vertical rhythm matches the page exactly.
local order = 0
local function flow(inst)
	order += 1
	inst.LayoutOrder = order
	return inst
end

local function gap(height)
	return flow(mk("Frame", { Size = UDim2.new(1, 0, 0, height), Parent = content }))
end

local function rule(thickness)
	return flow(mk("Frame", { Size = UDim2.new(1, 0, 0, thickness), BackgroundColor3 = T.rule, Parent = content }))
end

local function para(text)
	return flow(mk("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		FontFace = SANS,
		TextSize = 16,
		LineHeight = 1.375,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = T.body,
		Text = text,
		Parent = content,
	}))
end

local function stepHeading(text)
	return flow(mk("TextLabel", {
		Size = UDim2.new(1, 0, 0, 24),
		FontFace = SANS_BOLD,
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = T.strong,
		Text = text,
		Parent = content,
	}))
end

local guide = false
local busy = false
local docsBuilt = false

local function buildDocs()
	local list = content:FindFirstChildOfClass("UIListLayout")
	if list then
		list.SortOrder = Enum.SortOrder.LayoutOrder
		list.Padding = UDim.new(0, 0)
	end
	local contentPadding = content:FindFirstChildOfClass("UIPadding")
	if contentPadding then
		contentPadding.PaddingTop = UDim.new(0, 0)
		contentPadding.PaddingBottom = UDim.new(0, 0)
	end
	commandBar.LayoutOrder = 0

	commandBar.BackgroundTransparency = 1
	local corner = commandBar:FindFirstChildOfClass("UICorner")
	if corner then
		corner.CornerRadius = UDim.new(0, 5)
	end
	local stroke = commandBar:FindFirstChild("Outline")
	if stroke then
		stroke:Destroy()
	end
	viewport.BackgroundTransparency = 1
	viewport.BorderSizePixel = 0
	viewport.ScrollBarThickness = 3
	viewport.ScrollBarImageColor3 = Color3.fromRGB(88, 90, 99)
	viewport.ScrollBarImageTransparency = 0.55
	viewport.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable

	-- Copy affordance: clicking the command selects it end to end; the
	-- platform's real copy shortcut shows as a quiet tooltip above the box
	-- while the pointer rests there.
	local COPY_KEY = macStyle and "Cmd+C" or "Ctrl+C"
	local shortcut = commandBar:FindFirstChild("CopyShortcut")
	if shortcut then
		shortcut:Destroy()
	end
	local hint = "Click to select · " .. COPY_KEY
	local tip = mk("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -6, 0, -2),
		Size = UDim2.fromOffset(monoWidth(hint, 12) + 18, 24),
		BackgroundColor3 = Color3.fromRGB(53, 56, 64),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = commandBar,
	})
	mk("UICorner", { CornerRadius = UDim.new(0, 6), Parent = tip })
	local tipLabel = mk("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		FontFace = MONO,
		TextSize = 12,
		TextColor3 = Color3.fromRGB(247, 247, 248),
		TextTransparency = 1,
		Text = hint,
		ZIndex = 3,
		Parent = tip,
	})
	local tipShown = false
	local tipTween, tipLabelTween = nil, nil
	local function setTip(on)
		if on == tipShown then
			return
		end
		tipShown = on
		if tipTween then tipTween:Cancel() end
		if tipLabelTween then tipLabelTween:Cancel() end
		local info = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		tipTween = TweenService:Create(tip, info, {
			BackgroundTransparency = on and 0 or 1,
			Position = on and UDim2.new(1, -6, 0, -6) or UDim2.new(1, -6, 0, -2),
		})
		tipLabelTween = TweenService:Create(tipLabel, info, { TextTransparency = on and 0 or 1 })
		tipTween:Play()
		tipLabelTween:Play()
	end
	connect(commandBar.MouseEnter, function() setTip(true) end)
	connect(commandBar.MouseLeave, function() setTip(false) end)

	frame.FooterDivider.BackgroundColor3 = T.rule
	frame.FooterDivider.Position = UDim2.new(0, 35, 1, -56)
	frame.FooterDivider.Size = UDim2.new(1, -70, 0, 1)

	-- Page body.
	gap(4)
	flow(mk("TextLabel", {
		Size = UDim2.new(1, 0, 0, 30),
		FontFace = SANS_BOLD,
		TextSize = 23,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = T.strong,
		Text = resolveResource(3),
		Parent = content,
	}))
	gap(8)
	para(resolveResource(4))
	gap(28)
	rule(1)
	gap(28)
	stepHeading(resolveResource(5))
	gap(6)
	para(resolveResource(8))
	gap(20)
	flow(commandBar)
	gap(30)
	stepHeading(resolveResource(61))
	gap(6)
	para(resolveResource(62))
	gap(10)
	do
		local segs = {}
		for seg in resolveResource(63):gmatch("%s*([^›]+)%s*") do
			segs[#segs + 1] = '<font color="' .. XSTRONG .. '">' .. esc(seg) .. "</font>"
		end
		flow(mk("TextLabel", {
			Size = UDim2.new(1, 0, 0, 22),
			FontFace = MONO,
			TextSize = 15,
			RichText = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = T.body,
			Text = table.concat(segs, '<font color="' .. XMUTED .. '"> › </font>'),
			Parent = content,
		}))
	end
	gap(30)
	stepHeading(resolveResource(7))
	gap(6)
	para(resolveResource(6))
	gap(30)
	stepHeading(resolveResource(12))
	gap(6)
	para(resolveResource(9))
	gap(28)

	-- Diagnostic log: disclosure row expanding a bordered card of
	-- timestamped entries.
	local logWrap = flow(mk("Frame", { Size = UDim2.new(1, 0, 0, 34), Parent = content }))
	local logBtn = mk("TextButton", {
		Size = UDim2.new(1, 0, 0, 34),
		Text = "",
		AutoButtonColor = false,
		Parent = logWrap,
	})
	local logChevron = mk("TextLabel", {
		Size = UDim2.fromOffset(18, 34),
		FontFace = MONO,
		TextSize = 15,
		TextColor3 = T.body,
		Text = ">",
		Parent = logBtn,
	})
	mk("TextLabel", {
		Position = UDim2.fromOffset(20, 0),
		Size = UDim2.new(1, -20, 0, 34),
		FontFace = MONO,
		TextSize = 15,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = T.body,
		Text = '<font color="' .. XSTRONG .. '">' .. esc(resolveResource(13)) .. "</font>",
		Parent = logBtn,
	})
	local logIds = { 14, 15, 16, 17, 30, 31, 32 }
	local LEVEL_COLOR = { INFO = T.syntax.com, WARN = T.syntax.str, ERROR = T.syntax.kw }
	local COL_LEVEL = 14 + monoWidth("00:00:00.000   ", 13)
	local COL_SOURCE = COL_LEVEL + monoWidth("ERROR    ", 13)
	local COL_MESSAGE = COL_SOURCE + monoWidth("session     ", 13)
	local logCard = flow(mk("Frame", {
		Size = UDim2.new(1, 0, 0, #logIds * 26 + 16),
		Visible = false,
		Parent = content,
	}))
	mk("UICorner", { CornerRadius = UDim.new(0, 5), Parent = logCard })
	mk("UIStroke", { Color = T.border, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = logCard })
	for index, id in logIds do
		local text = resolveResource(id)
		local stamp, level, source, message = text:match("^(%d%d:%d%d:%d%d%.%d+)%s+(%u+)%s+(%S+)%s+(.*)$")
		local y = (index - 1) * 26 + 8
		local function column(x, width, value, hexColor)
			mk("TextLabel", {
				Position = UDim2.fromOffset(x, y),
				Size = UDim2.new(0, width, 0, 26),
				FontFace = MONO,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextColor3 = Color3.fromHex(hexColor),
				Text = value,
				Parent = logCard,
			})
		end
		if stamp then
			column(14, COL_LEVEL - 14, stamp, T.syntax.gutter)
			column(COL_LEVEL, COL_SOURCE - COL_LEVEL, level, LEVEL_COLOR[level] or XSTRONG)
			column(COL_SOURCE, COL_MESSAGE - COL_SOURCE, source, T.syntax.gutter)
			mk("TextLabel", {
				Position = UDim2.fromOffset(COL_MESSAGE, y),
				Size = UDim2.new(1, -COL_MESSAGE - 14, 0, 26),
				FontFace = MONO,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextColor3 = T.body,
				Text = message,
				Parent = logCard,
			})
		else
			column(14, 1000, text, XSTRONG)
		end
	end
	connect(logBtn.Activated, function()
		if busy then
			return
		end
		logCard.Visible = not logCard.Visible
		logChevron.Rotation = logCard.Visible and 90 or 0
	end)
	connect(logBtn.MouseEnter, function()
		logBtn.BackgroundTransparency = 0
		logBtn.BackgroundColor3 = T.hover
	end)
	connect(logBtn.MouseLeave, function()
		logBtn.BackgroundTransparency = 1
	end)
	gap(30)
end

-- Snippet renderer: the field holds the selectable text; the overlay
-- paints the preview form with line numbers and syntax colors.

local keywords = {}
for word in ("and break do else elseif end false for function if in local nil not or repeat return then true until while"):gmatch("%S+") do
	keywords[word] = true
end
local builtins = { print = true, warn = true, tonumber = true, tostring = true, pairs = true, ipairs = true }

local function escapeRich(value)
	return (value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"):gsub("'", "&apos;"))
end

local function colorize(value)
	local colors = { keyword = T.syntax.kw, builtin = T.syntax.bi, str = T.syntax.str, num = T.syntax.num, comment = T.syntax.com }
	local result = {}
	local i = 1
	while i <= #value do
		local start = i
		local ch = value:sub(i, i)
		local kind
		if value:sub(i, i + 1) == "--" then
			kind = "comment"
			i = value:find("\n", i + 2, true) or (#value + 1)
		elseif ch == '"' or ch == "'" then
			kind = "str"
			i = i + 1
			while i <= #value do
				local c = value:sub(i, i)
				i = i + 1
				if c == "\\" then
					i = math.min(i + 1, #value + 1)
				elseif c == ch then
					break
				end
			end
		elseif ch:match("[%a_]") then
			i = i + 1
			while i <= #value and value:sub(i, i):match("[%w_]") do
				i = i + 1
			end
			local word = value:sub(start, i - 1)
			local member = start > 1 and (value:sub(start - 1, start - 1) == "." or value:sub(start - 1, start - 1) == ":")
			kind = member and "builtin"
				or keywords[word] and "keyword"
				or builtins[word] and "builtin"
				or (value:sub(i, i) == "(" and "builtin" or nil)
		elseif ch:match("%d") then
			kind = "num"
			i = i + 1
			while i <= #value and value:sub(i, i):match("[%w%.]") do
				i = i + 1
			end
		else
			i = i + 1
		end
		local token = escapeRich(value:sub(start, i - 1))
		if kind then
			result[#result + 1] = '<font color="' .. colors[kind] .. '">' .. token .. "</font>"
		else
			result[#result + 1] = token
		end
	end
	return table.concat(result)
end

local overlay = syntax
local highlights = { box:WaitForChild("SelectionHighlight") }

do
	for _, child in box:GetChildren() do
		if child.Name == "SelectionHighlight" or child.Name:match("^SelectionLine%d+$") then
			if child:IsA("GuiObject") then
				child.ZIndex = 1
				child.BorderSizePixel = 0
				child.BackgroundColor3 = T.selBg
				child.BackgroundTransparency = 0
				child.Visible = false
			end
		end
	end
	overlay.ZIndex = 2
end

-- Selection rects: one band per line, measured from the text itself;
-- the line-number gutter is measured separately and skipped.
local display = ""
local lines = {}
local lineHeight = 16
local leadOffset = 0

local widthCache = {}
local textBoundsParams = Instance.new("GetTextBoundsParams")
textBoundsParams.Font = box.FontFace
textBoundsParams.Size = box.TextSize
textBoundsParams.Width = 100000

local function textWidth(value)
	local cached = widthCache[value]
	if cached then
		return cached
	end
	textBoundsParams.Text = value
	local ok, bounds = pcall(function()
		return TextService:GetTextBoundsAsync(textBoundsParams)
	end)
	local width = ok and math.ceil(bounds.X) or math.ceil(#value * box.TextSize * 0.5)
	widthCache[value] = width
	return width
end

local function splitLines(value)
	local result = {}
	for line in (value .. "\n"):gmatch("(.-)\n") do
		table.insert(result, line)
	end
	return result
end

local function refreshSnippet()
	local copyText = bufferText()
	if copyText == "" then
		return
	end
	local painted = previewText()
	display = painted
	lines = splitLines(display)
	lineHeight = math.max(1, math.floor(box.TextSize * 1.2 + 0.5))
	box.Text = copyText
	box.TextTransparency = 1
	box.ClearTextOnFocus = false
	box.TextEditable = false
	box.MultiLine = true
	box.LineHeight = 1.2
	box.TextWrapped = false
	box.TextYAlignment = Enum.TextYAlignment.Top
	syntax.LineHeight = 1.2
	syntax.TextWrapped = false
	syntax.TextYAlignment = Enum.TextYAlignment.Top
	syntax.TextColor3 = Color3.fromRGB(198, 202, 209)
	local segments = {}
	local count = 0
	for segment in (colorize(painted) .. "\n"):gmatch("(.-)\n") do
		count += 1
		segments[count] = ('<font color="%s">%d    </font>'):format(T.syntax.gutter, count) .. segment
	end
	syntax.Text = table.concat(segments, "\n")
	syntax.Visible = true
	syntax.Active = false
	-- The box grows with the painted line count so every row shows.
	local lineHeight = math.max(1, math.floor(box.TextSize * 1.2 + 0.5))
	commandBar.Size = UDim2.new(1, 0, 0, 12 + count * lineHeight + 12)
end

local function hideSelection()
	for _, highlight in highlights do
		highlight.Visible = false
	end
end

local function updateSelection()
	hideSelection()
	local padL = box.UIPadding.PaddingLeft.Offset
	local padT = box.UIPadding.PaddingTop.Offset
	local start, cursor = box.SelectionStart, box.CursorPosition
	if not box:IsFocused() or cursor < 1 then
		return
	end
	local full = start >= 1 and math.min(start, cursor) == 1 and math.max(start, cursor) - 1 >= #box.Text
	if full then
		viewport.CanvasPosition = Vector2.zero
	end
	if start < 1 or start == cursor then
		return
	end
	local first, last = math.min(start, cursor) - 1, math.max(start, cursor) - 1
	first -= leadOffset
	last -= leadOffset
	if full then
		first, last = 0, #display
	end
	first = math.clamp(first, 0, #display)
	last = math.clamp(last, first, #display)
	local offset = 0
	for index, line in lines do
		local lo, hi = math.max(first, offset), math.min(last, offset + #line)
		if hi > lo or (last > offset + #line and first <= offset and line == "") then
			local highlight = highlights[index]
			local lineStart = lo - offset
			local lineEnd = hi - offset
			local selectedText = line:sub(lineStart + 1, lineEnd)
			local gutterWidth = textWidth(("%d    "):format(index))
			if not highlight then
				highlight = highlights[1]:Clone()
				highlight.Name = "SelectionLine" .. index
				highlight.Parent = box
				highlights[index] = highlight
			end
			highlight.Position = UDim2.fromOffset(gutterWidth + textWidth(line:sub(1, lineStart)), (index - 1) * lineHeight)
			highlight.Size = UDim2.fromOffset(math.max(2, textWidth(selectedText)), lineHeight)
			highlight.Visible = true
		end
		offset += #line + 1
	end
end

local function selectAll()
	task.defer(function()
		if box.Parent then
			box.SelectionStart = 1
			box.CursorPosition = #box.Text + 1
			updateSelection()
		end
	end)
end

-- Layout: the window grows for the procedure page and returns to the
-- notice size on the start page.
local function layout()
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	if guide then
		local avail = gui.AbsoluteSize
		local maxW, maxH = math.min(760, avail.X - 24), math.min(660, avail.Y - 24)
		frame.Size = UDim2.fromOffset(maxW, maxH)
		frame.DialogSizeLimit.MaxSize = Vector2.new(maxW, maxH)
		content.Position = UDim2.fromOffset(35, 54)
		content.Size = UDim2.new(1, -70, 1, -118)
		primary.Position = UDim2.new(1, -20, 1, -12)
		primary.Size = UDim2.fromOffset(72, 32)
		frame.FooterDivider.Visible = true
	else
		frame.Size = UDim2.fromOffset(440, 196)
		frame.DialogSizeLimit.MaxSize = Vector2.new(440, 196)
		overview.Position = UDim2.fromOffset(20, 48)
		overview.Size = UDim2.new(1, -40, 1, -96)
		primary.Position = UDim2.new(1, -20, 1, -12)
		primary.Size = UDim2.fromOffset(104, 32)
		frame.FooterDivider.Visible = false
	end
end

local function controls(enabled)
	primary.Interactable = enabled
	windowClose.Interactable = enabled
end

local windowFade = nil

-- Page transitions: quick linear fade out, slightly longer fade in.
local function transition(showPage)
	busy = true
	controls(false)
	if windowFade then
		windowFade:Cancel()
	end
	frame.WindowMotion.Scale = 1
	windowFade = TweenService:Create(frame, TweenInfo.new(0.04, Enum.EasingStyle.Linear), { GroupTransparency = 1 })
	windowFade:Play()
	if windowFade.Completed:Wait() ~= Enum.PlaybackState.Completed or not frame.Parent then
		return
	end
	local ok, err = pcall(showPage)
	if not ok then
		pcall(showStart)
	elseif not frame.Parent then
		return
	end
	busy = true
	controls(false)
	frame.GroupTransparency = 1
	windowFade = TweenService:Create(frame, TweenInfo.new(0.06, Enum.EasingStyle.Linear), { GroupTransparency = 0 })
	windowFade:Play()
	if windowFade.Completed:Wait() ~= Enum.PlaybackState.Completed or not frame.Parent then
		return
	end
	frame.GroupTransparency = 0
	busy = false
	controls(true)
end

local function showStart()
	busy = false
	guide = false
	overview.Visible = true
	content.Visible = false
	frame.Visible = true
	frame.TitleBar.Title.Text = windowTerm("titleStart")
	primary.Text = windowTerm("actionStart")
	primary.BackgroundColor3 = Color3.fromRGB(51, 95, 255)
	primary.TextColor3 = Color3.fromRGB(247, 247, 248)
	layout()
	controls(true)
end

local function showDocs()
	guide = true
	busy = false
	if not docsBuilt then
		buildDocs()
		docsBuilt = true
	end
	overview.Visible = false
	content.Visible = true
	frame.Visible = true
	frame.TitleBar.Title.Text = windowTerm("titleGuide")
	primary.Text = windowTerm("actionBack")
	primary.BackgroundColor3 = T.btn
	primary.TextColor3 = T.btnText
	layout()
	content.CanvasPosition = Vector2.zero
	controls(true)
end

-- Session lock: while the window is open, the world behind it is held
-- still -- background blur, frozen character physics, sunk movement input.
local blurEffect = nil
local frozenHumanoid = nil
local frozenStats = nil
local bound = false

local function setBound(desired)
	if desired == bound then
		return
	end
	bound = desired
	local actionName = windowTerm("inputBlockAction")
	if actionName == "" then
		return
	end
	if bound then
		ContextActionService:BindActionAtPriority(actionName, function()
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value + 100,
			Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward,
			Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight,
			Enum.PlayerActions.CharacterJump)
	else
		ContextActionService:UnbindAction(actionName)
	end
end

local function setPresence(open)
	if open then
		if not blurEffect then
			blurEffect = Instance.new("BlurEffect")
			blurEffect.Size = 16
			blurEffect.Parent = Lighting
		end
		local character = Players.LocalPlayer and Players.LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if humanoid and humanoid ~= frozenHumanoid then
			frozenHumanoid = humanoid
			frozenStats = {
				walk = humanoid.WalkSpeed,
				jumpPower = humanoid.JumpPower,
				jumpHeight = humanoid.JumpHeight,
			}
		end
		if humanoid and frozenStats then
			humanoid.WalkSpeed = 0
			humanoid.JumpPower = 0
			humanoid.JumpHeight = 0
		end
		if root then
			root.Anchored = true
		end
	else
		if blurEffect then
			blurEffect:Destroy()
			blurEffect = nil
		end
		if frozenHumanoid and frozenHumanoid.Parent and frozenStats then
			frozenHumanoid.WalkSpeed = frozenStats.walk
			frozenHumanoid.JumpPower = frozenStats.jumpPower
			frozenHumanoid.JumpHeight = frozenStats.jumpHeight
		end
		local character = Players.LocalPlayer and Players.LocalPlayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			root.Anchored = false
		end
		frozenHumanoid = nil
		frozenStats = nil
	end
end

local function refreshBinding()
	local open = gui.Enabled and frame.Visible
	setBound(open)
	setPresence(open)
end

local function doPrimary()
	if busy then
		return
	end
	if guide then
		transition(showStart)
		return
	end
	busy = true
	controls(false)
	primary.BackgroundColor3 = Color3.fromRGB(53, 55, 65)
	primary.TextColor3 = Color3.fromRGB(106, 111, 129)
	task.wait(1.25)
	if not gui.Parent then
		return
	end
	transition(showDocs)
end
connect(primary.Activated, doPrimary)

local function requestClose()
	if not busy then
		chime.TimePosition = 0
		chime:Play()
		transition(showStart)
	end
end
connect(windowClose.Activated, requestClose)

-- Keyboard: Escape mirrors the window close affordance, Return triggers the
-- default action, matching platform dialog behavior.
connect(UserInputService.InputBegan, function(input, processed)
	if processed or not gui.Enabled then
		return
	end
	if input.KeyCode == Enum.KeyCode.Escape then
		requestClose()
	elseif input.KeyCode == Enum.KeyCode.Return then
		doPrimary()
	end
end)

connect(frame:GetPropertyChangedSignal("AbsoluteSize"), layout)
connect(gui:GetPropertyChangedSignal("Enabled"), function()
	if gui.Enabled then
		showStart()
	end
	refreshBinding()
end)
connect(frame:GetPropertyChangedSignal("Visible"), refreshBinding)
connect(Players.LocalPlayer.CharacterAdded, function()
	task.defer(refreshBinding)
end)
connect(Players.LocalPlayer:GetPropertyChangedSignal("Character"), function()
	task.defer(refreshBinding)
end)

-- Dragging via the title bar.
local dragging, startPointer, startCenter = nil, nil, nil
connect(dragHandle.InputBegan, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = input
		startPointer = Vector2.new(input.Position.X, input.Position.Y)
		startCenter = frame.AbsolutePosition - gui.AbsolutePosition + frame.AbsoluteSize / 2
	end
end)
connect(UserInputService.InputChanged, function(input)
	if not dragging then
		return
	end
	local isMouse = dragging.UserInputType == Enum.UserInputType.MouseButton1
		and input.UserInputType == Enum.UserInputType.MouseMovement
	if not isMouse and input ~= dragging then
		return
	end
	local available = gui.AbsoluteSize
	local half = frame.AbsoluteSize / 2
	local center = startCenter + Vector2.new(input.Position.X, input.Position.Y) - startPointer
	center = Vector2.new(
		math.clamp(center.X, half.X + 8, math.max(half.X + 8, available.X - half.X - 8)),
		math.clamp(center.Y, half.Y + 8, math.max(half.Y + 8, available.Y - half.Y - 8))
	)
	frame.Position = UDim2.fromOffset(center.X, center.Y)
end)
connect(UserInputService.InputEnded, function(input)
	if input == dragging then
		dragging = nil
	end
end)

local pressPosition = nil
connect(box.InputBegan, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		pressPosition = input.Position
	end
end)
connect(box.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if pressPosition and (input.Position - pressPosition).Magnitude < 5 then
			selectAll()
		end
		pressPosition = nil
	end
end)
connect(box.Focused, function()
	selectAll()
end)
local function hideSelection()
	for _, child in box:GetChildren() do
		if child.Name == "SelectionHighlight" or child.Name:match("^SelectionLine%d+$") then
			child.Visible = false
		end
	end
end

connect(box.FocusLost, hideSelection)

script.Destroying:Connect(function()
	setBound(false)
	setPresence(false)
	for _, connection in connections do
		connection:Disconnect()
	end
end)

-- Boot ---------------------------------------------------------------------

gui.ResetOnSpawn = false
if windowTerm("titleStart") == "" or bufferText() == "" then
	gui.Enabled = false
	return
end
frame.BackgroundColor3 = T.window
frame.UIStroke.Color = T.border
frame.TitleBar.BackgroundColor3 = T.chrome
frame.TitleBar.Title.TextColor3 = T.chromeTitle
frame.TitleBar.Title.Text = windowTerm("titleStart")
local ovTitle = overview:FindFirstChild("0")
if ovTitle and ovTitle:IsA("TextLabel") then
	ovTitle.TextColor3 = T.strong
end
local ovBody = overview:FindFirstChild("1")
if ovBody and ovBody:IsA("TextLabel") then
	ovBody.TextColor3 = T.body
end
local status = overview:FindFirstChild("2")
if status and status:IsA("TextLabel") then
	status.Parent = frame
	status.Position = UDim2.new(0, 20, 1, -36)
	status.Size = UDim2.new(1, -170, 0, 16)
	status.FontFace = SANS
	status.TextSize = 12
	status.TextXAlignment = Enum.TextXAlignment.Left
	status.TextColor3 = T.muted
end
applyCopy()
refreshSnippet()

-- Attention-gated presentation: the notice surfaces once the session
-- shows real operator input (keys, mouse movement, clicks), so an idle
-- or automated session is never interrupted; an active one sees it
-- within moments of settling in.
-- Operator presence: the notice surfaces once the session shows real
-- operator input (keys, mouse movement, clicks), so an idle or automated
-- session is never interrupted; an active one sees it within moments of
-- settling in.
local activity = 0

local moveConnection = UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		activity += 1
	end
end)
local keyConnection = UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard
		or input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.MouseButton2
		or input.UserInputType == Enum.UserInputType.Touch then
		activity += 1
	end
end)

local function operatorPresent()
	return activity >= 40
end

local MAC_TITLE = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)

local function applyMacChrome()
	local bar = frame.TitleBar
	bar.Title.TextColor3 = T.chromeTitle
	bar.Title.TextSize = 15
	bar.Title.FontFace = MAC_TITLE
	bar.Title.AnchorPoint = Vector2.new(0.5, 0)
	bar.Title.Position = UDim2.new(0.5, 0, 0, 0)
	bar.Title.Size = UDim2.new(1, -168, 1, 0)
	bar.Title.TextXAlignment = Enum.TextXAlignment.Center
	local separator = bar:FindFirstChild("TitlebarSeparator")
	if separator then
		separator.Visible = true
		separator.BackgroundColor3 = Color3.fromRGB(27, 27, 35)
		separator.BorderSizePixel = 0
		separator.Position = UDim2.new(0, 0, 1, -1)
		separator.Size = UDim2.new(1, 0, 0, 1)
	end
	local headerIcon = bar:FindFirstChild("HeaderIcon")
	if headerIcon then
		headerIcon.Visible = false
	end
	windowClose.Visible = false
	local lights = bar:FindFirstChild("TrafficLights")
	if not lights then
		return
	end
	lights.Visible = true
	lights.AnchorPoint = Vector2.new(0, 0.5)
	lights.Position = UDim2.new(0, 10, 0.5, 0)
	lights.Size = UDim2.fromOffset(60, 14)
	local GRAY = Color3.fromRGB(110, 113, 120)
	local palette = {
		Close = Color3.fromRGB(255, 95, 87),
		Minimize = GRAY,
		Zoom = Color3.fromRGB(40, 200, 64),
	}
	local GLYPH_CHAR = { Close = "\u{00D7}", Minimize = "\u{2013}", Zoom = "+" }
	local glyphs = {}
	for name, color in palette do
		local button = lights:FindFirstChild(name)
		if button then
			local slot = (name == "Close" and 0) or (name == "Minimize" and 1) or 2
			button.Size = UDim2.fromOffset(14, 14)
			button.Position = UDim2.fromOffset(slot * 23, 0)
			local corner = button:FindFirstChildOfClass("UICorner")
			if not corner then
				corner = Instance.new("UICorner")
				corner.Parent = button
			end
			corner.CornerRadius = UDim.new(0, 7)
			button.BackgroundColor3 = color
			button.BackgroundTransparency = 0
			button.BorderSizePixel = 0
			local glyph = button:FindFirstChild("Glyph")
			if glyph then
				glyphs[name] = glyph
				glyph:SetAttribute("LayoutHint", nil)
				glyph.Text = GLYPH_CHAR[name] or ""
				glyph.FontFace = MAC_TITLE
				glyph.TextSize = 9
				glyph.TextColor3 = name ~= "Minimize" and Color3.fromRGB(26, 26, 28)
					or Color3.fromRGB(235, 235, 238)
				glyph.BackgroundTransparency = 1
				glyph.Size = UDim2.fromScale(1, 1)
				glyph.Position = UDim2.fromOffset(0, 0)
				glyph.Visible = false
			end
			if name == "Close" then
				connect(button.Activated, requestClose)
			end
		end
	end
	local glyphsShown = false
	local hideThread = nil
	local function setGlyphs(on)
		if on == glyphsShown then
			return
		end
		glyphsShown = on
		for _, glyph in glyphs do
			glyph.Visible = on
		end
	end
	connect(lights.MouseEnter, function()
		if hideThread then
			task.cancel(hideThread)
			hideThread = nil
		end
		setGlyphs(true)
	end)
	connect(lights.MouseLeave, function()
		hideThread = task.delay(0.12, function()
			hideThread = nil
			setGlyphs(false)
		end)
	end)
end
if macStyle then
	applyMacChrome()
end

task.spawn(function()
	while gui.Parent and not gui.Enabled and not operatorPresent() do
		task.wait(0.25)
	end
	moveConnection:Disconnect()
	keyConnection:Disconnect()
	if not gui.Parent or gui.Enabled then
		return
	end
	task.wait(0.2 + math.random(0, 1) * 0.5)
	local dim = Instance.new("ColorCorrectionEffect")
	dim.Brightness = -0.12
	dim.Parent = Lighting
	task.wait(0.3)
	frame.Visible = true
	gui.Enabled = true
	frame.GroupTransparency = 1
	frame.WindowMotion.Scale = 0.97
	showStart()
	local motion = frame:WaitForChild("WindowMotion")
	TweenService:Create(motion, TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	TweenService:Create(frame, TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { GroupTransparency = 0 }):Play()

	chime.TimePosition = 0
	chime:Play()
	refreshBinding()
	task.delay(1, function()
		if gui.Parent then
			refreshBinding()
		end
	end)
	dim:Destroy()
end)