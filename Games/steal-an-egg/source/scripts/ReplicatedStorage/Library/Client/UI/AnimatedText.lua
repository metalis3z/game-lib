-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Normal = require(ReplicatedStorage.Directory.Sounds.Languages.Alphabet._Index.Normal)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t2 = {
	Color = "TextColor3",
	StrokeColor = "TextStrokeColor3",
	ImageColor = "ImageColor3"
}

t.ColorShortcuts = {}
t.ColorShortcuts.White = Color3.new(255/255, 255/255, 255/255)
t.ColorShortcuts.Black = Color3.new(0/255, 0/255, 0/255)
t.ColorShortcuts.Red = Color3.new(255/255, 102/255, 102/255)
t.ColorShortcuts.Green = Color3.new(102/255, 255/255, 102/255)
t.ColorShortcuts.Blue = Color3.new(102/255, 102/255, 255/255)
t.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1)
t.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2)
t.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2)
t.ImageShortcuts = {}
t.ImageShortcuts.Eggplant = 639588687
t.ImageShortcuts.Thinking = 955646496
t.ImageShortcuts.Sad = 947900188
t.ImageShortcuts.Happy = 414889555
t.ImageShortcuts.Despicable = 711674643

local t3 = {}

t.MarkupShortcuts = t3
t3.Font = {
	Start = "<Font=%s>",
	End = "<Font=/>"
}
t3.Img = {
	Start = "<Img=%s>",
	End = "<Img=/>"
}
t3.AnimateStepTime = {
	Start = "<AnimateStepTime=%s>",
	End = "<AnimateStepTime=/>"
}
t3.AnimateYield = {
	Start = "<AnimateYield=%s>",
	End = "<AnimateYield=/>"
}
t3.TextColor3 = {
	Start = "<TextColor3=%s>",
	End = "<TextColor3=/>"
}
t3.Color = {
	Start = "<Color=%s>",
	End = "<Color=/>"
}
t3.AnimateStepFrequency = {
	Start = "<AnimateStepFrequency=%s>",
	End = "<AnimateStepFrequency=/>"
}
t3.AnimateStyleTime = {
	Start = "<AnimateStyleTime=%s>",
	End = "<AnimateStyleTime=/>"
}
t3.AnimateStyle = {
	Start = "<AnimateStyle=%s>",
	End = "<AnimateStyle=/>"
}
t3.FadeAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Fade>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}
t3.AppearAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Appear>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}
t3.WiggleAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Wiggle>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}
t3.SwingAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Swing>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}
t3.RainbowAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Rainbow>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}
t3.SpinAnimateStyle = {
	Start = "<AnimateStepFrequency=1><AnimateStyleTime=.6><AnimateStyle=Spin>",
	End = "<AnimateStepFrequency=/><AnimateStyleTime=/><AnimateStyle=/>"
}

local t4 = {
	ContainerHorizontalAlignment = "Left",
	ContainerVerticalAlignment = "Center",
	TextYAlignment = "Bottom",
	TextScaled = true,
	TextScaleRelativeTo = "Frame",
	TextScale = 0.4,
	TextSize = 20,
	Font = "FredokaOne",
	TextColor3 = "White",
	TextStrokeColor3 = "Black",
	TextTransparency = 0,
	TextStrokeTransparency = 1,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ImageColor3 = "White",
	ImageTransparency = 0,
	ImageRectOffset = "0,0",
	ImageRectSize = "0,0",
	AnimateStepTime = 0.025,
	AnimateStepGrouping = "Letter",
	AnimateStepFrequency = 1,
	AnimateYield = 0,
	AnimateStyle = "Appear",
	AnimateStyleTime = 0.5,
	AnimateStyleNumPeriods = 3,
	AnimateStyleAmplitude = 0.5,
	Punctuations = "[,%.%!%?]",
	PunctuationDelay = 0.2,
	PunctuationEnabled = true,
	TypingSound = "rbxassetid://91414159854126",
	SyllableRegistry = nil,
	CustomLayerSize = nil,
	UITextStrokeThickness = 2.6
}
local t5 = {
	Appear = function(p1) --[[ Appear | Line: 388 ]]
		p1.Visible = true
	end,
	Fade = function(p1, p2, p3) --[[ Fade | Line: 392 ]]
		p1.Visible = true

		if p1:IsA("TextLabel") then
			p1.TextTransparency = 1 - p2 * (1 - p3.TextTransparency)

			return
		end

		if not p1:IsA("ImageLabel") then
			return
		end

		p1.ImageTransparency = 1 - p2 * (1 - p3.ImageTransparency)
	end,
	Wiggle = function(p1, p2, p3) --[[ Wiggle | Line: 401 ]]
		p1.Visible = true
		p1.Position = p3.InitialPosition + UDim2.new(0, 0, 0, math.sin(p2 * math.pi * 2 * p3.AnimateStyleNumPeriods) * (p3.InitialSize.Y.Offset * (1 - p2) * p3.AnimateStyleAmplitude) / 2)
	end,
	Swing = function(p1, p2, p3) --[[ Swing | Line: 408 ]]
		p1.Visible = true
		p1.Rotation = math.sin(p2 * math.pi * 2 * p3.AnimateStyleNumPeriods) * (90 * (1 - p2) * p3.AnimateStyleAmplitude)
	end,
	Spin = function(p1, p2, p3) --[[ Spin | Line: 414 ]]
		p1.Visible = true
		p1.Position = p3.InitialPosition + UDim2.new(0, p3.InitialSize.X.Offset / 2, 0, p3.InitialSize.Y.Offset / 2)
		p1.AnchorPoint = Vector2.new(0.5, 0.5)
		p1.Rotation = p2 * p3.AnimateStyleNumPeriods * 360
	end,
	Rainbow = function(p1, p2, p3) --[[ Rainbow | Line: 422 ]]
		p1.Visible = true

		local v1 = Color3.fromHSV(p2 * p3.AnimateStyleNumPeriods % 1, 1, 1)

		if p1:IsA("TextLabel") then
			local v2 = getColorFromString(p3.TextColor3)

			p1.TextColor3 = Color3.new(v1.r + p2 * (v2.r - v1.r), v1.g + p2 * (v2.g - v1.g), v1.b + p2 * (v2.b - v1.b))
		else
			local v3 = getColorFromString(p3.ImageColor3)

			p1.ImageColor3 = Color3.new(v1.r + p2 * (v3.r - v1.r), v1.g + p2 * (v3.g - v1.g), v1.b + p2 * (v3.b - v1.b))
		end
	end
}
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local v2 = 0

function getLayerCollector(p1) --[[ getLayerCollector | Line: 446 ]]
	if not p1 then
		return nil
	end

	if p1:IsA("LayerCollector") then
		return p1
	end

	if p1 and p1.Parent then
		return getLayerCollector(p1.Parent)
	end

	return nil
end
function getColorFromString(p1) --[[ getColorFromString | Line: 458 | Upvalues: t (copy) ]]
	if t.ColorShortcuts[p1] then
		return t.ColorShortcuts[p1]
	end

	local v1, v2, v3 = p1:match("(%d+),(%d+),(%d+)")

	return Color3.new(v1 / 255, v2 / 255, v3 / 255)
end
function getVector2FromString(p1) --[[ getVector2FromString | Line: 467 ]]
	local v1, v2 = p1:match("(%d+),(%d+)")

	return Vector2.new(v1, v2)
end
function setHorizontalAlignment(p1, p2) --[[ setHorizontalAlignment | Line: 472 ]]
	if p2 == "Left" then
		p1.AnchorPoint = Vector2.new(0, 0)
		p1.Position = UDim2.new(0, 0, 0, 0)

		return
	end

	if p2 == "Center" then
		p1.AnchorPoint = Vector2.new(0.5, 0)
		p1.Position = UDim2.new(0.5, 0, 0, 0)

		return
	end

	if p2 ~= "Right" then
		return
	end

	p1.AnchorPoint = Vector2.new(1, 0)
	p1.Position = UDim2.new(1, 0, 0, 0)
end
function t.New(p1, p2, p3, p4, p5, p6, p7, p8) --[[ New | Line: 485 | Upvalues: Asserts (copy), t4 (copy), t2 (copy), v1 (copy), TextService (copy), t (copy), v2 (ref), RunService (copy), t5 (copy), Normal (copy), Audio (copy), ReplicatedFirst (copy) ]]
	Asserts.optional.string(p8)

	for k, v in pairs(p2:GetChildren()) do
		v:Destroy()
	end

	if p5 == nil then
		p5 = true
	end

	local v12 = if p7 == nil then if t4.PunctuationEnabled then t4.PunctuationDelay or false else false else typeof(p7) == "number" and p7 or p7 and t4.PunctuationDelay
	local tbl = {}
	local t3 = {}

	if p6 then
		p3 = p6.Text
		p4 = p6.StartingProperties
	end

	local tbl2 = {}
	local t6 = {}
	local t7 = {}
	local v22 = 0
	local v3 = false
	local TextLabel = Instance.new("TextLabel")
	local UIStroke = Instance.new("UIStroke")
	local ImageLabel = Instance.new("ImageLabel")
	local v4 = getLayerCollector(p2)

	UIStroke.Thickness = t4.UITextStrokeThickness
	UIStroke.Parent = TextLabel
	TextLabel.FontFace.Weight = Enum.FontWeight.Bold
	TextLabel.AutoLocalize = false

	local v5 = nil
	local v6 = nil

	local function applyMarkup(p1, p2) --[[ applyMarkup | Line: 535 | Upvalues: t2 (ref), t3 (copy), tbl (ref), v5 (ref), tbl2 (copy), t4 (ref), v6 (ref), v1 (ref) ]]
		local v12 = t2[p1] or p1

		if p2 == "/" and t3[v12] then
			p2 = t3[v12]
		elseif p2 == "/" then
			warn("Attempt to default <" .. v12 .. "> to value with no default")
		end

		if tonumber(p2) then
			p2 = tonumber(p2)
		elseif p2 == "false" or p2 == "true" then
			p2 = if p2 == "true" then true else false
		end

		tbl[v12] = p2

		if v5(v12, p2) then
			return true
		end

		if v12 == "ContainerHorizontalAlignment" and tbl2[#tbl2] then
			setHorizontalAlignment(tbl2[#tbl2].Container, p2)
		else
			if t4[v12] then
				return true
			end

			if v12 ~= "Img" then
				v1:AtWarning():Log((("Unknown property <%*> with value <%*>. This will not be applied."):format(v12, p2)))

				return false
			end

			v6(p2)
		end

		return true
	end

	v5 = function(p1, p2, p3) --[[ applyProperty | Line: 567 | Upvalues: TextLabel (copy), ImageLabel (copy) ]]
		local v1 = nil
		local v2 = false

		for v5, v6 in pairs(p3 and { p3 } or { TextLabel, ImageLabel }) do
			if pcall(function() --[[ Line: 571 | Upvalues: v1 (ref), v6 (copy), p1 (copy) ]]
				v1 = typeof(v6[p1])
			end) then
				if v1 == "Color3" then
					v6[p1] = getColorFromString(p2)
				elseif v1 == "Vector2" then
					v6[p1] = getVector2FromString(p2)
				else
					v6[p1] = p2
				end

				v2 = true
			end
		end

		return v2
	end

	for k, v in pairs(t4) do
		applyMarkup(k, v)
		t3[t2[k] or k] = tbl[t2[k] or k]
	end

	for v9, v10 in pairs(p4 or {}) do
		applyMarkup(v9, v10)
		t3[t2[v9] or v9] = tbl[t2[v9] or v9]
	end

	if p6 then
		tbl = p6.OverflowPickupProperties

		for k, v in pairs(tbl) do
			applyMarkup(k, v)
		end
	end

	local function getTextSize() --[[ getTextSize | Line: 605 | Upvalues: tbl (ref), v4 (copy), p2 (copy) ]]
		if tbl.TextScaled ~= true then
			return tbl.TextSize
		end

		local v1 = nil

		if tbl.TextScaleRelativeTo == "Screen" then
			v1 = v4.AbsoluteSize.Y
		elseif tbl.TextScaleRelativeTo == "Frame" then
			v1 = p2.AbsoluteSize.Y
		end

		return math.min(tbl.TextScale * v1, 100)
	end

	local v11 = 0

	local function newLine() --[[ newLine | Line: 620 | Upvalues: tbl2 (copy), v11 (ref), p5 (ref), tbl (ref), v4 (copy), p2 (copy), v3 (ref), t6 (copy), v22 (ref) ]]
		local v1 = tbl2[#tbl2]
		local v2, Container, v32

		if not v1 then
			v2 = Instance.new("Frame")
			v2.Name = string.format("Line%03d", #tbl2 + 1)
			v2.Size = UDim2.new(0, 0, 0, 0)
			v2.BackgroundTransparency = 1
			Container = Instance.new("Frame", v2)
			Container.Name = "Container"
			Container.Size = UDim2.new(0, 0, 0, 0)
			Container.BackgroundTransparency = 1
			setHorizontalAlignment(Container, tbl.ContainerHorizontalAlignment)
			v2.Parent = p2
			v32 = tbl2
			table.insert(tbl2, v2)
			t6[#tbl2] = {}
			v22 = 0

			return
		end

		v11 = v11 + v1.Size.Y.Offset

		if p5 then
			v2 = Instance.new("Frame")
			v2.Name = string.format("Line%03d", #tbl2 + 1)
			v2.Size = UDim2.new(0, 0, 0, 0)
			v2.BackgroundTransparency = 1
			Container = Instance.new("Frame", v2)
			Container.Name = "Container"
			Container.Size = UDim2.new(0, 0, 0, 0)
			Container.BackgroundTransparency = 1
			setHorizontalAlignment(Container, tbl.ContainerHorizontalAlignment)
			v2.Parent = p2
			v32 = tbl2
			table.insert(tbl2, v2)
			t6[#tbl2] = {}
			v22 = 0

			return
		end

		local v5

		if tbl.TextScaled == true then
			local v6 = nil

			if tbl.TextScaleRelativeTo == "Screen" then
				v6 = v4.AbsoluteSize.Y
			elseif tbl.TextScaleRelativeTo == "Frame" then
				v6 = p2.AbsoluteSize.Y
			end

			v5 = math.min(tbl.TextScale * v6, 100)
		else
			v5 = tbl.TextSize
		end

		if v11 + v5 > p2.AbsoluteSize.Y then
			v3 = true
		else
			v2 = Instance.new("Frame")
			v2.Name = string.format("Line%03d", #tbl2 + 1)
			v2.Size = UDim2.new(0, 0, 0, 0)
			v2.BackgroundTransparency = 1
			Container = Instance.new("Frame", v2)
			Container.Name = "Container"
			Container.Size = UDim2.new(0, 0, 0, 0)
			Container.BackgroundTransparency = 1
			setHorizontalAlignment(Container, tbl.ContainerHorizontalAlignment)
			v2.Parent = p2
			v32 = tbl2
			table.insert(tbl2, v2)
			t6[#tbl2] = {}
			v22 = 0
		end
	end

	newLine()

	local function addFrameProperties(p1) --[[ addFrameProperties | Line: 647 | Upvalues: t7 (copy), tbl (ref) ]]
		t7[p1] = table.clone(tbl)
		t7[p1].InitialSize = p1.Size
		t7[p1].InitialPosition = p1.Position
		t7[p1].InitialAnchorPoint = p1.AnchorPoint
	end

	local function formatLabel(p1, p22, p3, p4) --[[ formatLabel | Line: 654 | Upvalues: tbl2 (copy), tbl (ref), v22 (ref), p2 (copy), t6 (copy), newLine (copy), t7 (copy) ]]
		local v1 = tbl2[#tbl2]
		local v2 = tostring(tbl.TextYAlignment)

		if v2 == "Top" then
			p1.Position = UDim2.new(0, v22, 0, 0)
			p1.AnchorPoint = Vector2.new(0, 0)
		elseif v2 == "Center" then
			p1.Position = UDim2.new(0, v22, 0.5, 0)
			p1.AnchorPoint = Vector2.new(0, 0.5)
		elseif v2 == "Bottom" then
			p1.Position = UDim2.new(0, v22, 1, 0)
			p1.AnchorPoint = Vector2.new(0, 1)
		end

		v22 = v22 + p3

		if v22 > p2.AbsoluteSize.X and v22 ~= p3 then
			p1:Destroy()

			local v3 = t6[#tbl2][#t6[#tbl2]]

			if v3:IsA("TextLabel") and v3.Text == " " then
				v1.Container.Size = UDim2.new(0, v22 - p3 - v3.Size.X.Offset, 1, 0)
				v3:Destroy()
				table.remove(t6[#tbl2])
			end

			newLine()
			p4()
		else
			p1.Size = UDim2.new(0, p3, 0, p22)
			v1.Container.Size = UDim2.new(0, v22, 1, 0)

			local v4 = UDim2.new

			v1.Size = v4(1, 0, 0, (math.max(v1.Size.Y.Offset, p22)))
			p1.Name = string.format("Group%03d", #t6[#tbl2] + 1)
			p1.Parent = v1.Container
			table.insert(t6[#tbl2], p1)
			t7[p1] = table.clone(tbl)
			t7[p1].InitialSize = p1.Size
			t7[p1].InitialPosition = p1.Position
			t7[p1].InitialAnchorPoint = p1.AnchorPoint
			tbl.AnimateYield = 0
		end
	end

	local function v122(p1) --[[ printText | Line: 694 | Upvalues: newLine (copy), v22 (ref), tbl (ref), v4 (copy), p2 (copy), TextService (ref), TextLabel (copy), t7 (copy), formatLabel (ref), v3 (ref), v122 (ref) ]]
		if p1 == "\n" then
			newLine()

			return
		end

		if p1 == " " and v22 == 0 then
			return
		end

		local v1

		if tbl.TextScaled == true then
			local v2 = nil

			if tbl.TextScaleRelativeTo == "Screen" then
				v2 = v4.AbsoluteSize.Y
			elseif tbl.TextScaleRelativeTo == "Frame" then
				v2 = p2.AbsoluteSize.Y
			end

			v1 = math.min(tbl.TextScale * v2, 100)
		else
			v1 = tbl.TextSize
		end

		local X = TextService:GetTextSize(p1, v1, TextLabel.Font, Vector2.new(v4.AbsoluteSize.X, v1)).X
		local v5 = TextLabel:Clone()

		v5.TextScaled = false
		v5.TextSize = v1
		v5.Text = p1
		v5.TextTransparency = 1
		v5.TextStrokeTransparency = 1
		v5.TextWrapped = false

		local count = 1
		local sum = 0

		for v6, v7 in utf8.graphemes(p1) do
			local v8 = string.sub(p1, v6, v7)
			local X2 = TextService:GetTextSize(v8, v1, TextLabel.Font, Vector2.new(v4.AbsoluteSize.X, v1)).X
			local v9 = TextLabel:Clone()

			v9.Text = v8
			v9.TextScaled = false
			v9.TextSize = v1
			v9.Position = UDim2.new(0, sum, 0, 0)
			v9.Size = UDim2.new(0, X2 + 3, 0, v1)
			v9.Name = string.format("Char%03d", count)
			v9.Parent = v5
			v9.Visible = false
			t7[v9] = table.clone(tbl)
			t7[v9].InitialSize = v9.Size
			t7[v9].InitialPosition = v9.Position
			t7[v9].InitialAnchorPoint = v9.AnchorPoint
			count = count + 1
			sum = sum + X2
		end

		formatLabel(v5, v1, X, function() --[[ Line: 750 | Upvalues: v3 (ref), v122 (ref), p1 (copy) ]]
			if v3 then
				return
			end

			v122(p1)
		end)
	end

	v6 = function(p1) --[[ printImage | Line: 757 | Upvalues: tbl (ref), v4 (copy), p2 (copy), ImageLabel (copy), t (ref), formatLabel (ref), v3 (ref), v6 (ref) ]]
		local v1

		if tbl.TextScaled == true then
			local v2 = nil

			if tbl.TextScaleRelativeTo == "Screen" then
				v2 = v4.AbsoluteSize.Y
			elseif tbl.TextScaleRelativeTo == "Frame" then
				v2 = p2.AbsoluteSize.Y
			end

			v1 = math.min(tbl.TextScale * v2, 100)
		else
			v1 = tbl.TextSize
		end

		local v5 = ImageLabel:Clone()

		if t.ImageShortcuts[p1] then
			v5.Image = typeof(t.ImageShortcuts[p1]) == "number" and "rbxassetid://" .. t.ImageShortcuts[p1] or t.ImageShortcuts[p1]
		else
			v5.Image = "rbxassetid://" .. p1
		end

		v5.Size = UDim2.new(0, v1, 0, v1)
		v5.Visible = false
		formatLabel(v5, v1, v1, function() --[[ Line: 773 | Upvalues: v3 (ref), v6 (ref), p1 (copy) ]]
			if v3 then
				return
			end

			v6(p1)
		end)
	end

	local function printSeries(p1) --[[ printSeries | Line: 780 | Upvalues: applyMarkup (ref), v122 (ref) ]]
		for k, v in pairs(p1) do
			local v1, v2 = string.match(v, "<(.+)=(.+)>")

			if v1 and v2 then
				if not applyMarkup(v1, v2) then
					warn("Could not apply markup: ", v)
				end

				continue
			end

			v122(v)
		end
	end

	local v13 = #p3
	local t8 = {}
	local v14 = if p6 then p6.OverflowPickupIndex else 1

	while v14 and v14 <= v13 do
		local v15, v16
		local v17, v18 = string.find(p3, "<.->", v14)
		local v19, v20 = string.find(p3, "[ \t\n]", v14)
		local v21 = nil

		if v17 and (v18 and (not v19 or v17 < v19)) then
			v15 = v18
			v16 = v17
		else
			v16 = v19 or v13 + 1
			v15 = v20 or v13 + 1
			v21 = true
		end

		local v24 = v14 < v16 and string.sub(p3, v14, v16 - 1) or nil
		local v25 = v16 <= v13 and string.sub(p3, v16, v15) or nil

		table.insert(t8, v24)

		if v21 then
			printSeries(t8)

			if v3 then
				break
			end

			printSeries({ v25 })

			if v3 then
				v14 = v16

				break
			end

			t8 = {}
		else
			table.insert(t8, v25)
		end

		v14 = v15 + 1
	end

	if not v3 then
		printSeries(t8)
	end

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.HorizontalAlignment = tbl.ContainerHorizontalAlignment
	UIListLayout.VerticalAlignment = tbl.ContainerVerticalAlignment
	UIListLayout.Parent = p2

	local X = p2.AbsoluteSize.X
	local sum = 0
	local v26 = 0

	for k, v in pairs(tbl2) do
		sum = sum + v.Size.Y.Offset

		local Container = v.Container
		local v27 = nil
		local v28 = nil

		if Container.AnchorPoint.X == 0 then
			v27 = Container.Position.X.Offset
			v28 = Container.Size.X.Offset
		elseif Container.AnchorPoint.X == 0.5 then
			v27 = v.AbsoluteSize.X / 2 - Container.Size.X.Offset / 2
			v28 = v.AbsoluteSize.X / 2 + Container.Size.X.Offset / 2
		elseif Container.AnchorPoint.X == 1 then
			v27 = v.AbsoluteSize.X - Container.Size.X.Offset
			v28 = v.AbsoluteSize.X
		end

		local v29 = math.min(X, v27)

		X, v26 = v29, math.max(v26, v28)
	end

	v2 = v2 + 1

	local v31 = false
	local v32 = false
	local v33 = false
	local v34 = "TextAnimation" .. v2
	local t9 = {}

	local function updateAnimations() --[[ updateAnimations | Line: 876 | Upvalues: v32 (ref), t9 (ref), v31 (ref), RunService (ref), v34 (copy), t5 (ref) ]]
		if v32 and #t9 == 0 or v31 then
			v31 = true
			RunService:UnbindFromRenderStep(v34)
			t9 = {}

			return
		end

		local v1 = tick()

		for i = #t9, 1, -1 do
			local v2 = t9[i]
			local Settings = v2.Settings
			local v3 = t5[Settings.AnimateStyle]

			if not v3 then
				warn("No animation style found for: ", Settings.AnimateStyle, ", defaulting to Appear")
				v3 = t5.Appear
			end

			local v5 = math.min((v1 - v2.Start) / Settings.AnimateStyleTime, 1)

			v3(v2.Char, v5, Settings)

			local v6 = v2.Char:FindFirstChildWhichIsA("UIStroke")

			if v6 then
				v6.Transparency = v2.Char.TextTransparency
			end

			if v5 >= 1 then
				table.remove(t9, i)
			end
		end
	end

	local function setFrameToDefault(p1) --[[ setFrameToDefault | Line: 906 | Upvalues: t7 (copy), v5 (ref) ]]
		p1.Position = t7[p1].InitialPosition
		p1.Size = t7[p1].InitialSize
		p1.AnchorPoint = t7[p1].InitialAnchorPoint

		for k, v in pairs(t7[p1]) do
			v5(k, v, p1)
		end
	end

	local function setGroupVisible(p1, p2) --[[ setGroupVisible | Line: 915 | Upvalues: setFrameToDefault (copy) ]]
		p1.Visible = p2

		for k, v in pairs(p1:GetChildren()) do
			if v:IsA("UIStroke") then
				v.Enabled = p2

				continue
			end

			v.Visible = p2

			if p2 then
				setFrameToDefault(v)
			end
		end

		if not (p2 and p1:IsA("ImageLabel")) then
			return
		end

		setFrameToDefault(p1)
	end

	local function animate(p1) --[[ animate | Line: 933 | Upvalues: v31 (ref), RunService (ref), v34 (copy), updateAnimations (copy), t6 (copy), t9 (ref), v33 (ref), t7 (copy), Normal (ref), Audio (ref), p8 (copy), t4 (ref), ReplicatedFirst (ref), v12 (copy), v32 (ref) ]]
		v31 = false
		RunService:BindToRenderStep(v34, Enum.RenderPriority.Last.Value, updateAnimations)

		local count = nil
		local v1 = nil
		local v2 = nil
		local v3 = nil

		for k, v in pairs(t6) do
			for k2, v4 in pairs(v) do
				v4.Visible = false

				for k3, v5 in pairs(v4:GetChildren()) do
					if v5:IsA("UIStroke") then
						v5.Enabled = false

						continue
					end

					v5.Visible = false
				end
			end
		end

		local function animateCharacter(p1, p2) --[[ animateCharacter | Line: 949 | Upvalues: t9 (ref) ]]
			local v1 = p1:FindFirstChildWhichIsA("UIStroke")
			local v3

			if v1 then
				v1.Transparency = 1
			end

			v3 = {
				Char = p1,
				Settings = p2,
				Start = tick()
			}
			table.insert(t9, v3)
		end

		local function yield() --[[ yield | Line: 957 | Upvalues: v33 (ref), count (ref), v1 (ref), v2 (ref) ]]
			if v33 or (count % v1 ~= 0 or not (v2 >= 0)) then
				return
			end

			wait(if v2 > 0 then v2 or nil else nil)
		end

		for k, v in pairs(t6) do
			for k2, v4 in pairs(v) do
				local v42 = t7[v4]

				if v42.AnimateStepGrouping ~= v3 or v42.AnimateStepFrequency ~= v1 then
					count = 0
				end

				v3 = v42.AnimateStepGrouping

				local AnimateStepTime = v42.AnimateStepTime

				v1 = v42.AnimateStepFrequency

				if v42.AnimateYield > 0 then
					wait(v42.AnimateYield)
				end

				if v3 == "Word" or v3 == "All" then
					if v4:IsA("TextLabel") then
						v4.Visible = true

						for k3, v5 in pairs(v4:GetChildren()) do
							local v6 = v5:FindFirstChildWhichIsA("UIStroke")

							if v6 then
								v6.Transparency = 1
							end

							table.insert(t9, {
								Char = v5,
								Settings = t7[v5],
								Start = tick()
							})
						end
					else
						local v8 = v4:FindFirstChildWhichIsA("UIStroke")

						if v8 then
							v8.Transparency = 1
						end

						table.insert(t9, {
							Char = v4,
							Settings = v42,
							Start = tick()
						})
					end

					if v3 == "Word" then
						count = count + 1

						if not v33 and (count % v1 == 0 and AnimateStepTime >= 0) then
							wait(if AnimateStepTime > 0 then AnimateStepTime or nil else nil)
						end
					end
				elseif v3 == "Letter" then
					if v4:IsA("TextLabel") then
						v4.Visible = true

						local Text = v4.Text
						local count2 = 1

						while true do
							local v11 = v4:FindFirstChild(string.format("Char%03d", count2))

							if not v11 then
								break
							end

							local v13 = v11:FindFirstChildWhichIsA("UIStroke")

							if v13 then
								v13.Transparency = 1
							end

							table.insert(t9, {
								Char = v11,
								Settings = t7[v11],
								Start = tick()
							})
							count = count + 1

							local Text2 = v11.Text

							if Text2 ~= " " then
								local v15 = Normal[string.lower(Text2)]

								if v15 then
									Audio.ScheduleAndPlay(v15.Sound:Clone(), nil, v15.Sound.Parent)
								else
									Audio.Play(p8 or t4.TypingSound, ReplicatedFirst)
								end
							end

							if v12 and string.match(Text2, t4.Punctuations) then
								task.wait(v12)
							end

							if not v33 and (count % v1 == 0 and AnimateStepTime >= 0) then
								wait(AnimateStepTime > 0 and AnimateStepTime or nil)
							end

							if v31 then
								return
							end

							count2 = count2 + 1
						end
					else
						local v18 = v4:FindFirstChildWhichIsA("UIStroke")

						if v18 then
							v18.Transparency = 1
						end

						table.insert(t9, {
							Char = v4,
							Settings = v42,
							Start = tick()
						})
						count = count + 1

						if not v33 and (count % v1 == 0 and AnimateStepTime >= 0) then
							wait(if AnimateStepTime > 0 then AnimateStepTime or nil else nil)
						end
					end
				else
					warn("Invalid step grouping: ", v3)
				end

				if v31 then
					return
				end
			end
		end

		v32 = true

		if not p1 then
			return
		end

		while #t9 > 0 do
			RunService.RenderStepped:Wait()
		end
	end

	local t10 = {
		Overflown = v3,
		OverflowPickupIndex = v14,
		StartingProperties = p4,
		OverflowPickupProperties = tbl,
		Text = p3
	}

	if p6 then
		p6.NextTextObject = t10
	end

	t10.ContentSize = Vector2.new(v26 - X, sum)
	function t10.Animate(p1, p2) --[[ Animate | Line: 1072 | Upvalues: animate (copy) ]]
		if p2 then
			animate(true)
		else
			coroutine.wrap(animate)()
		end

		if not p1.NextTextObject then
			return
		end

		p1.NextTextObject:Animate(p2)
	end
	function t10.Show(p1, p2) --[[ Show | Line: 1083 | Upvalues: v33 (ref), v31 (ref), t6 (copy), setGroupVisible (copy) ]]
		if p2 then
			v33 = true
		else
			v31 = true

			for k, v in pairs(t6) do
				for k2, v2 in pairs(v) do
					setGroupVisible(v2, true)
				end
			end
		end

		if not p1.NextTextObject then
			return
		end

		p1.NextTextObject:Show(p2)
	end
	function t10.Hide(p1) --[[ Hide | Line: 1099 | Upvalues: v31 (ref), t6 (copy) ]]
		v31 = true

		for k, v in pairs(t6) do
			for k2, v2 in pairs(v) do
				v2.Visible = false

				for k3, v3 in pairs(v2:GetChildren()) do
					if v3:IsA("UIStroke") then
						v3.Enabled = false

						continue
					end

					v3.Visible = false
				end
			end
		end

		if not p1.NextTextObject then
			return
		end

		p1.NextTextObject:Hide()
	end
	function t10.Destroy(p1) --[[ Destroy | Line: 1111 | Upvalues: RunService (ref), v34 (copy) ]]
		p1:Hide()
		RunService:UnbindFromRenderStep(v34)
		table.clear(p1)
	end

	return t10
end
function t.ContinueOverflow(p1, p2, p3) --[[ ContinueOverflow | Line: 1120 | Upvalues: t (copy) ]]
	return t:New(p2, nil, nil, false, p3)
end

return t