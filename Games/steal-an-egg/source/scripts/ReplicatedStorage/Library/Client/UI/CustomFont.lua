-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Fonts = script:WaitForChild("Fonts")
local abs = math.abs
local max = math.max
local sub = string.sub
local rep = string.rep
local byte = string.byte
local gsub = string.gsub
local find = string.find
local match = string.match
local upper = string.upper
local gmatch = string.gmatch
local sort = table.sort
local insert = table.insert
local v1 = UDim2.new
local v2 = Color3.new
local v3 = Vector2.new
local v4 = Instance.new
local v5 = v4("ImageLabel")

v5.Size = v1(0, 0, 0, 0)
v5.BackgroundTransparency = 1
v5.ScaleType = Enum.ScaleType.Stretch

local t = {
	Right = true,
	Bottom = true
}
local t2 = {
	Left = true,
	Top = true
}
local t3 = {
	AbsoluteSize = true,
	TextWrapped = true,
	TextScaled = true,
	TextXAlignment = true,
	TextYAlignment = true
}
local t4 = {
	TextTransparency = true,
	TextStrokeTransparency = true,
	BackgroundTransparency = true
}
local t5 = {
	AbsolutePosition = true,
	AbsoluteSize = true,
	Position = true,
	Size = true,
	Rotation = true,
	Parent = true
}
local t6 = {
	FontName = true,
	Style = true
}

local function getAlignMultiplier(p1) --[[ getAlignMultiplier | Line: 81 | Upvalues: t (copy), t2 (copy) ]]
	if t[p1.Name] then
		return 1
	end

	if t2[p1.Name] then
		return 0
	end

	return 0.5
end

local function getClosestNumber(p1, p2) --[[ getClosestNumber | Line: 85 | Upvalues: sort (copy), abs (copy) ]]
	sort(p2, function(p1, p23) --[[ Line: 86 | Upvalues: p1 (copy), abs (ref) ]]
		return abs(p1 - p1) < abs(p1 - p23)
	end)

	return p2[1]
end

local function wrapper(p1, p2) --[[ wrapper | Line: 92 ]]
	local v1 = newproxy(true)
	local v2 = getmetatable(v1)

	function v2.__index(p12, p22) --[[ Line: 96 | Upvalues: p2 (copy), p1 (copy) ]]
		return p2[p22] or p1[p22]
	end
	function v2.__newindex(p12, p22, p3) --[[ Line: 99 | Upvalues: p2 (copy), p1 (copy) ]]
		if p2[p22] then
			p2[p22] = p3
		else
			p1[p22] = p3
		end
	end
	function v2.__call() --[[ Line: 106 | Upvalues: p1 (copy) ]]
		return p1
	end
	function v2.__tostring(p12) --[[ Line: 109 | Upvalues: p1 (copy) ]]
		return tostring(p1)
	end
	v2.__metatable = "The metatable is locked."

	return v1
end

local function defaultHide(p1) --[[ defaultHide | Line: 117 ]]
	p1.TextTransparency = 2
	p1.BackgroundTransparency = 2
	p1.TextStrokeTransparency = 2
end

local function newBackground(p1, p2, p3) --[[ newBackground | Line: 123 | Upvalues: Trove (copy), v4 (copy), v1 (copy), v2 (copy) ]]
	local v12 = if p3 then p3 else Trove.new()
	local _background = v4("Frame", p1)

	_background.Name = "_background"
	_background.Size = v1(1, 0, 1, 0)
	_background.BackgroundTransparency = p1.BackgroundTransparency
	_background.BackgroundColor3 = p1.BackgroundColor3
	_background.BorderSizePixel = p1.BorderSizePixel
	_background.BorderColor3 = p1.BorderColor3
	_background.ZIndex = p1.ZIndex

	if p2 == "TextButton" then
		v12:Connect(_background.MouseEnter, function() --[[ Line: 136 | Upvalues: p1 (copy), _background (copy), v2 (ref) ]]
			if p1.AutoButtonColor then
				local BackgroundColor3 = p1.BackgroundColor3

				_background.BackgroundColor3 = v2(BackgroundColor3.r - 0.29411764705882354, BackgroundColor3.g - 0.29411764705882354, BackgroundColor3.b - 0.29411764705882354)
			end
		end)
		v12:Connect(p1.MouseLeave, function() --[[ Line: 144 | Upvalues: p1 (copy), _background (copy) ]]
			if p1.AutoButtonColor then
				_background.BackgroundColor3 = p1.BackgroundColor3
			end
		end)
	end

	return _background, v12
end

local function split(p1, p2) --[[ split | Line: 156 | Upvalues: find (copy), sub (copy), insert (copy) ]]
	local v1 = 0
	local t = {}

	while true do
		local v2 = find(p1, p2, v1, true)

		if not v2 then
			break
		end

		insert(t, (sub(p1, v1, v2 - 1)))
		v1 = v2 + 1
	end

	insert(t, (sub(p1, v1)))

	return t
end

local function getLines(p1) --[[ getLines | Line: 174 | Upvalues: gsub (copy), rep (copy), split (copy) ]]
	return split(gsub(p1, "\t", rep(" ", 4)), "\n")
end

local function getWords(p1, p2) --[[ getWords | Line: 179 | Upvalues: gsub (copy), rep (copy), split (copy), gmatch (copy), insert (copy) ]]
	debug.profilebegin("CustomFont getWords")

	local v1 = split(gsub(p1, "\t", rep(" ", 4)), "\n")
	local v2 = #v1
	local v3, v4 = v1, {}

	for i = 1, v2 do
		for v5 in gmatch(v3[i], " *[^%s]+ *") do
			insert(v4, v5)
		end

		if p2 and i < v2 then
			insert(v4, "\n")
		end
	end

	debug.profileend()

	return v4
end

local function getStringWidth(p1, p2) --[[ getStringWidth | Line: 201 | Upvalues: sub (copy), byte (copy) ]]
	debug.profilebegin("CustomFont getStringWidth")

	local v1 = 0

	for i = 1, #p1 do
		local v2 = if i + 1 <= #p1 then i + 1 else false
		local v3 = byte((sub(p1, i, i)))
		local v4 = if v2 then byte((sub(p1, v2, v2))) else v2

		v1 = v1 + p2.characters[v3].xadvance + (if v4 and (p2.kerning[v3] and p2.kerning[v3][v4]) then p2.kerning[v3][v4].x else 0)
	end

	debug.profileend()

	return v1
end

local function getMaxHeight(p1, p2) --[[ getMaxHeight | Line: 222 | Upvalues: sub (copy), byte (copy) ]]
	debug.profilebegin("CustomFont getMaxHeight")

	local v1 = 0

	for i = 1, #p1 do
		local v2 = byte((sub(p1, i, i)))
		local v3 = p2.characters[v2].height + p2.characters[v2].yoffset

		if v1 < v3 then
			v1 = v3
		end
	end

	debug.profileend()

	return v1
end

local function wrapText(p1, p2, p3) --[[ wrapText | Line: 240 | Upvalues: getWords (copy), abs (copy), getStringWidth (copy) ]]
	debug.profilebegin("CustomFont wrapText")

	local v1 = getWords(p1, true)
	local v2 = abs(p3.child.AbsoluteSize.x)
	local sum = 0
	local count = 1
	local t = { "" }

	for i = 1, #v1 do
		local v3 = v1[i]

		if v3 == "\n" then
			count = count + 1
			t[count] = ""
			sum = 0

			continue
		end

		local v4 = getStringWidth(v3, p3.styles[p3.style][p2])

		if v4 + sum <= v2 then
			t[count] = t[count] .. v3
		else
			count = count + 1
			t[count] = v3
			sum = 0
		end

		sum = sum + v4
	end

	debug.profileend()

	return t
end

function scaleText(p1, p2) --[[ scaleText | Line: 269 | Upvalues: sort (copy), wrapText (copy), gsub (copy), rep (copy), split (copy), getMaxHeight (copy), getStringWidth (copy), insert (copy), max (copy), abs (copy) ]]
	debug.profilebegin("CustomFont scaleText")

	local child = p2.child

	sort(p2.information.sizes, function(p1, p2) --[[ Line: 273 ]]
		return p2 < p1
	end)

	local v1 = p2.information.sizes[1]
	local v2 = false

	for i = 1, #p2.information.sizes do
		local v3
		local v4 = p2.information.sizes[i]
		local v5 = p2.styles[p2.style][v4]
		local v6

		if child.TextWrapped then
			v3 = wrapText(p1, v4, p2)

			if not v3 then
				v6 = split(gsub(p1, "\t", rep(" ", 4)), "\n")
				v3 = v6
			end
		else
			v6 = split(gsub(p1, "\t", rep(" ", 4)), "\n")
			v3 = v6
		end

		local sum = -v5.firstAdjust
		local t = {}

		for j = 1, #v3 do
			local v7 = v3[j]

			sum = sum + getMaxHeight(v7, v5)
			insert(t, (getStringWidth(v7, v5)))
		end

		if max(unpack(t)) <= abs(child.AbsoluteSize.x) and sum <= abs(child.AbsoluteSize.y) then
			v2 = true
			v1 = v4

			break
		end
	end

	local v8 = if v2 and v1 then v1 else p2.information.sizes[#p2.information.sizes]

	debug.profileend()

	return v8
end

local function drawSprite(p1, p2, p3, p4) --[[ drawSprite | Line: 307 | Upvalues: v5 (copy), v3 (copy) ]]
	debug.profilebegin("CustomFont drawSprite")

	local v1 = if typeof(p4) == "table" then true else false
	local v2 = v1 and p4[1] or v5:Clone()

	if v1 then
		table.remove(p4, 1)
	end

	local child = p3.child
	local v32 = p3.styles[p3.style][p3.size]
	local v4 = v32.characters[p1]

	v2.Name = p1
	v2.ImageColor3 = child.TextColor3
	v2.ImageTransparency = p3.attached.TextTransparency
	v2.ZIndex = child.ZIndex
	v2.Image = p3.atlases[v4.atlas + 1]
	v2.ImageRectSize = v3(v4.width, v4.height)
	v2.ImageRectOffset = v3(v4.x, v4.y)

	local v52, v6

	if p2 and (v32.kerning[p1] and v32.kerning[p1][p2]) then
		local v7 = v32.kerning[p1][p2]

		v52 = v7.x
		v6 = v7.y
	else
		v52 = 0
		v6 = 0
	end

	v2.Position = UDim2.new(0, v52, 0, v4.yoffset + v6)
	v2.Size = UDim2.new(0, v4.width, 0, v4.height)
	debug.profileend()

	return unpack({ v2, v52, v6 + v4.yoffset + v4.height })
end

local function drawLine(p1, p2, p3, p4, p5) --[[ drawLine | Line: 349 | Upvalues: sub (copy), byte (copy), drawSprite (copy), v1 (copy), insert (copy), t (copy), t2 (copy), abs (copy) ]]
	debug.profilebegin("CustomFont drawLine")

	local child = p4.child
	local v12 = #p1
	local v2 = p4.styles[p4.style][p4.size]
	local v3 = 0
	local t3 = {}
	local v4 = 0

	for i = 1, v12 do
		local v5, v6
		local v7 = if i + 1 <= v12 then i + 1 else false
		local v8 = byte((sub(p1, i, i)))
		local v10, v11, v122 = drawSprite(v8, if v7 then byte((sub(p1, v7, v7))) else v7, p4, p5)

		v5 = if v3 < v122 then v122 else v3
		v10.Position = v10.Position + v1(0, v4, 0, p2)
		v6 = v7 and v2.characters[v8].xadvance or v2.characters[v8].width
		v3 = v5
		insert(t3, v10)
		insert(p3, v10)
		v4 = v4 + v6 + v11
	end

	local TextXAlignment = child.TextXAlignment
	local v13 = if t[TextXAlignment.Name] then 1 elseif t2[TextXAlignment.Name] then 0 else 0.5
	local v14 = (abs(child.AbsoluteSize.x) - v4) * v13

	for j = 1, v12 do
		local v15 = t3[j]

		v15.Position = v15.Position + v1(0, v14, 0, 0)
	end

	debug.profileend()

	return unpack({ v4, v3 })
end

local function drawLines(p1, p2, p3, p4) --[[ drawLines | Line: 386 | Upvalues: wrapText (copy), gsub (copy), rep (copy), split (copy), drawLine (copy), insert (copy), t (copy), t2 (copy), abs (copy), v1 (copy) ]]
	debug.profilebegin("CustomFont drawLines")

	local child = p2.child

	if child.TextScaled then
		p2.size = scaleText(p1, p2)
	end

	local v12, v2

	if child.TextWrapped then
		v12 = wrapText(p1, p2.size, p2)

		if not v12 then
			v2 = split(gsub(p1, "\t", rep(" ", 4)), "\n")
			v12 = v2
		end
	else
		v2 = split(gsub(p1, "\t", rep(" ", 4)), "\n")
		v12 = v2
	end

	local sum = -p2.styles[p2.style][p2.size].firstAdjust
	local t3 = { 0 }
	local t4 = {}

	for i = 1, #v12 do
		local v3, v4 = drawLine(v12[i], sum, t4, p2, p4)

		insert(t3, v3)
		sum = sum + v4
	end

	local TextYAlignment = child.TextYAlignment
	local v5 = if t[TextYAlignment.Name] then 1 elseif t2[TextYAlignment.Name] then 0 else 0.5
	local v6 = (abs(child.AbsoluteSize.y) - sum) * v5

	for j = 1, #t4 do
		local v7 = t4[j]

		v7.Position = v7.Position + v1(0, 0, 0, v6)
		v7.Parent = p3
	end

	debug.profileend()

	return t4
end

local t7 = {
	new = function(p1) --[[ new | Line: 426 ]]
		local t = {}
		local v1 = setmetatable({}, {
			__metatable = "The metatable is locked.",
			__index = p1,
			__newindex = function(p12, p2, p3) --[[ __newindex | Line: 430 | Upvalues: p1 (copy), t (copy) ]]
				if p1[p2] == p3 then
					return
				end

				p1[p2] = p3

				if type(t[p2]) ~= "function" then
					return
				end

				t[p2](p3)
			end
		})

		function v1.connect(p1, p2, p3) --[[ connect | Line: 441 | Upvalues: t (copy) ]]
			t[p2] = p3
		end

		return v1
	end
}
local t8 = {}

function t8.new(p1, p2, p3) --[[ new | Line: 450 | Upvalues: t8 (copy), sort (copy), abs (copy) ]]
	debug.profilebegin("CustomFont Settings.new")

	local v1 = setmetatable({}, {
		__index = t8
	})

	v1.child = p3
	v1.attached = p2
	v1.information = p1.font.information
	v1.atlases = p1.atlases
	v1.font_kernel = p1
	v1.styles = p1.font.styles
	sort(v1.information.sizes, function(p1, p2) --[[ Line: 464 ]]
		return p2 < p1
	end)
	v1.style = v1.information.styles[1]
	v1.size = p3.TextSize

	for v2, v3 in next, v1.styles do
		for v4, v5 in next, v3 do
			setmetatable(v5.characters, {
				__index = function(p1, p2) --[[ __index | Line: 477 ]]
					local v2 = rawget(p1, (tostring(p2)))

					if v2 then
						return v2
					end

					return rawget(p1, (tostring(63)))
				end
			})
		end

		local t2 = {
			__index = function(p1, p2) --[[ __index | Line: 492 | Upvalues: v1 (copy), sort (ref), abs (ref), p3 (copy) ]]
				local v12 = tostring(p2)
				local v2 = rawget(p1, v12)

				if v2 then
					return v2
				end

				local sizes = v1.information.sizes

				sort(sizes, function(p1, p23) --[[ Line: 86 | Upvalues: v12 (copy), abs (ref) ]]
					return abs(v12 - p1) < abs(v12 - p23)
				end)

				local v3 = sizes[1]

				v1.size = v3
				p3.TextSize = v3

				return rawget(p1, (tostring(v3)))
			end
		}

		setmetatable(v3, t2)
	end

	setmetatable(v1.styles, {
		__index = function(p1, p22) --[[ __index | Line: 509 | Upvalues: v1 (copy), p2 (copy) ]]
			local v12 = rawget(p1, p22)

			if v12 then
				return v12
			end

			local v2 = v1.information.styles[1]

			v1.style = v2
			p2.Style = v2

			return rawget(p1, v2)
		end
	})
	debug.profileend()

	return v1
end
function t8.preload(p1) --[[ preload | Line: 526 | Upvalues: ContentProvider (copy) ]]
	if not p1.font_kernel.__atlases_loaded then
		p1.font_kernel.__atlases_loaded = true
		pcall(ContentProvider.PreloadAsync, ContentProvider, p1.atlases)
	end
end

local t9 = {
	new = function(p1, p2, p3) --[[ new | Line: 537 | Upvalues: t7 (copy), v4 (copy), Fonts (copy), t8 (copy), Trove (copy), t6 (copy), upper (copy), sub (copy), newBackground (copy), drawLines (copy), t4 (copy), t3 (copy), match (copy), t5 (copy), insert (copy), wrapper (copy) ]]
		debug.profilebegin("CustomFont.new")

		local v1 = t7.new({})
		local v2 = if type(p2) == "string" then true else false
		local v3 = not v2 and p2 or v4(p2)
		local v42 = Fonts:FindFirstChild(p1)
		local v7 = t8.new(require((assert(v42, (("font module not found for font name: %*"):format(p1))))), v1, v3)

		v7:preload()

		local v8 = Trove.new()
		local v9 = v8:Extend()

		v1.FontName = p1
		v1.Style = v7.style
		v1.TextTransparency = v3.TextTransparency
		v1.TextStrokeTransparency = v3.TextStrokeTransparency
		v1.BackgroundTransparency = v3.BackgroundTransparency
		v1.MaxVisibleGraphemes = v3.MaxVisibleGraphemes
		v1.TextFits = false

		local t = {}
		local t2 = {}
		local t9 = {}

		for v10 in next, t6 do
			local v11 = v1[v10]
			local v12 = type(v11)
			local v14 = Instance.new(upper((sub(v12, 1, 1))) .. sub(v12, 2) .. "Value", v3)

			v14.Name = v10
			v14.Value = v11
			v9:Connect(v14.Changed, function(p1) --[[ Line: 573 | Upvalues: v1 (copy), v10 (copy) ]]
				v1[v10] = p1
			end)
			t[v14.Name] = v14
			t2[v14] = true
		end

		local v15 = newBackground(v3, p3 and "TextButton", v9)

		v3.MaxVisibleGraphemes = 0
		v3.TextTransparency = 2
		v3.BackgroundTransparency = 2
		v3.TextStrokeTransparency = 2

		local function cleanWithCache(p1) --[[ cleanWithCache | Line: 587 | Upvalues: v15 (copy) ]]
			local v1 = typeof(p1)
			local v2 = if v1 == "number" and p1 then p1 elseif v1 == "string" then #p1 or 0 else 0
			local t = {}

			for v3, v4 in v15:GetChildren() do
				if v4:IsA("ImageLabel") then
					if #t == v2 then
						v4:Destroy()

						continue
					end

					table.insert(t, v4)
				end
			end

			return t
		end

		local function drawText() --[[ drawText | Line: 608 | Upvalues: t9 (ref), drawLines (ref), v3 (copy), v7 (ref), v15 (copy), cleanWithCache (copy) ]]
			debug.profilebegin("CustomFont drawText")
			t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
			debug.profileend()
		end

		v1:connect("TextStrokeTransparency", function(p1) --[[ Line: 617 | Upvalues: t9 (ref), drawLines (ref), v3 (copy), v7 (ref), v15 (copy), cleanWithCache (copy) ]]
			debug.profilebegin("CustomFont drawText")
			t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
			debug.profileend()
		end)
		v1:connect("BackgroundTransparency", function(p1) --[[ Line: 621 | Upvalues: v15 (copy) ]]
			v15.BackgroundTransparency = p1
		end)
		v1:connect("Style", function(p1) --[[ Line: 625 | Upvalues: v7 (ref), t (ref), t9 (ref), drawLines (ref), v3 (copy), v15 (copy), cleanWithCache (copy) ]]
			v7.style = p1
			t.Style.Value = p1
			debug.profilebegin("CustomFont drawText")
			t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
			debug.profileend()
		end)
		v1:connect("TextTransparency", function(p1) --[[ Line: 631 | Upvalues: t9 (ref) ]]
			for i = 1, #t9 do
				t9[i].ImageTransparency = p1
			end
		end)
		v1:connect("FontName", function(p1) --[[ Line: 637 | Upvalues: Fonts (ref), v7 (ref), t8 (ref), v1 (copy), v3 (copy), t (ref), t9 (ref), drawLines (ref), v15 (copy), cleanWithCache (copy) ]]
			local v12 = Fonts:FindFirstChild(p1)

			if not v12 then
				return
			end

			v7 = t8.new(require(v12), v1, v3)
			v7:preload()
			t.FontName.Value = p1

			if v3.TextScaled then
				v7.style = v1.Style
				debug.profilebegin("CustomFont drawText")
				t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
				debug.profileend()

				return
			end

			v7.size = v3.TextSize
			v7.style = v1.Style
			debug.profilebegin("CustomFont drawText")
			t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
			debug.profileend()
		end)
		v9:Connect(v3.Changed, function(p1) --[[ Line: 656 | Upvalues: t4 (ref), v3 (copy), v1 (copy), v7 (ref), t9 (ref), drawLines (ref), v15 (copy), cleanWithCache (copy), t3 (ref), match (ref), t5 (ref) ]]
			if t4[p1] then
				if v3[p1] ~= 2 then
					v1[p1] = v3[p1]
				end

				v3[p1] = 2
			else
				if p1 == "TextSize" then
					v7.size = v3[p1]
					debug.profilebegin("CustomFont drawText")
					t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
					debug.profileend()

					return
				end

				if p1 == "TextColor3" then
					for v12, v2 in next, t9 do
						v2.ImageColor3 = v3[p1]
					end
				elseif p1 == "ZIndex" then
					v15.ZIndex = v3[p1]

					for v32, v4 in next, t9 do
						v4.ZIndex = v3[p1]
					end
				else
					if p1 == "Text" then
						debug.profilebegin("CustomFont drawText")
						t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
						debug.profileend()

						return
					end

					if t3[p1] then
						if p1 ~= "TextScaled" or v3[p1] then
							debug.profilebegin("CustomFont drawText")
							t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
							debug.profileend()

							return
						end

						v7.size = v3.TextSize
						debug.profilebegin("CustomFont drawText")
						t9 = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))
						debug.profileend()
					else
						if match(p1, "Text") or t5[p1] then
							return
						end

						pcall(function() --[[ Line: 682 | Upvalues: v15 (ref), p1 (copy), v3 (ref) ]]
							v15[p1] = v3[p1]
						end)
					end
				end
			end
		end)

		if v3:IsA("TextBox") then
			v9:Connect(v3.Focused, function() --[[ Line: 689 | Upvalues: v3 (copy) ]]
				if v3.ClearTextOnFocus then
					v3.Text = ""
				end
			end)
		end

		function v1.Revert(p1) --[[ Revert | Line: 698 | Upvalues: t (ref), v9 (ref), v15 (copy), v3 (copy), t9 (ref), t2 (ref) ]]
			for v1, v2 in next, t do
				v2:Destroy()
			end

			v9:Clean()
			v15:Destroy()
			v3.TextTransparency = p1.TextTransparency
			v3.BackgroundTransparency = p1.BackgroundTransparency
			v3.MaxVisibleGraphemes = p1.MaxVisibleGraphemes
			table.clear(t9)
			table.clear(t2)
			table.clear(t)
			t2 = nil
			t = nil
			v9 = nil

			return v3
		end
		function v1.GetChildren(p1) --[[ GetChildren | Line: 717 | Upvalues: v3 (copy), v15 (copy), t2 (ref), insert (ref) ]]
			local v1 = next
			local v2, v32 = v3:GetChildren()
			local t = {}

			for v4, v5 in v1, v2, v32 do
				if v5 ~= v15 and not t2[v5] then
					insert(t, v5)
				end
			end

			return t
		end
		function v1.ClearAllChildren(p1) --[[ ClearAllChildren | Line: 727 | Upvalues: v3 (copy), v15 (copy), t2 (ref) ]]
			local v1 = next
			local v2, v32 = v3:GetChildren()

			for v4, v5 in v1, v2, v32 do
				if v5 ~= v15 and not t2[v5] then
					v5:Destroy()
				end
			end
		end
		function v1.Destroy(p1) --[[ Destroy | Line: 735 | Upvalues: v8 (copy) ]]
			p1:Revert()
			v8:Destroy()
		end
		debug.profilebegin("CustomFont drawText")

		local _ = drawLines(v3.Text, v7, v15, (cleanWithCache(v3.Text)))

		debug.profileend()
		debug.profileend()

		return wrapper(v3, v1)
	end
}

function t9.Replace(p1, p2) --[[ Replace | Line: 746 | Upvalues: Asserts (copy), t9 (copy) ]]
	local v1 = p2 or "StrokeMario64"

	Asserts.string(v1)
	Asserts.GuiObject(p1)

	local v2 = p1:IsA("TextBox") or p1:IsA("TextLabel") or p1:IsA("TextButton")

	assert(v2, (("CustomFont.Replace expected a TextBox, TextLabel, or TextButton, got %*"):format(p1.ClassName)))

	return t9.new(v1, p1, p1:IsA("TextButton"))
end
task.wait()

return t9