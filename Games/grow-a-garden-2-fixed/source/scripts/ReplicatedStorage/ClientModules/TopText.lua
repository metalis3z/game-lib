--credit to quartz games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local NpcUIs = ReplicatedStorage.Assets.NpcUIs
local Talk_UI = NpcUIs.Talk_UI
local Response_UI = NpcUIs.Response_UI
local Option_UI = NpcUIs.Option_UI
local responseText = SoundService.SFX.responseText
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local v2 = nil
local v3 = nil

local function stripRichTextTags(p1) --[[ stripRichTextTags | Line: 34 ]]
	return p1:gsub("<.->", "")
end

local function playTypewriterEffect(p1, p2, p3) --[[ playTypewriterEffect | Line: 38 | Upvalues: SoundService (copy), responseText (copy) ]]
	local count = utf8.len((p1.Text:gsub("<.->", ""))) or 0

	p1.MaxVisibleGraphemes = 0

	local v2, v3

	if p2 then
		v2 = p3 and SoundService.NPC_SFX:FindFirstChild(p3) or SoundService.NPC_SFX.NPC_Text
		v3 = count
	else
		v2 = nil
		v3 = count
	end

	if p2 and v2 then
		while count >= 1 do
			task.wait()

			if v2.TimePosition > 0.07 or not v2.Playing then
				v2.TimePosition = 0
				v2.Playing = true
				v2.PlaybackSpeed = 1 + math.random(-5, 5) / 100
			end

			p1.MaxVisibleGraphemes = p1.MaxVisibleGraphemes + 1
			count = count - 1
		end
	else
		while count >= 1 do
			task.wait()

			if math.floor(count / 3) * 3 == count or count == v3 then
				responseText.TimePosition = 0
				responseText.Playing = true
				responseText.PlaybackSpeed = 1 + math.random(-5, 5) / 100
			end

			p1.MaxVisibleGraphemes = p1.MaxVisibleGraphemes + 1
			count = count - 1
		end
	end
end

local function setupDisappearScripts(p1, p2, p3) --[[ setupDisappearScripts | Line: 75 ]]
	if not p3 then
		return
	end

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("LocalScript") or v2:IsA("Script") then
			v2:Destroy()
		end
	end

	for v3, v4 in p2:GetDescendants() do
		if v4:IsA("LocalScript") or v4:IsA("Script") then
			for v5, v6 in p1:GetDescendants() do
				if v6.Name == v4.Parent.Name then
					local v7 = v4:Clone()

					v7.Parent = v6
					v7.Enabled = true
				end
			end
		end
	end
end

local function buildRainbowText(p1, p2) --[[ buildRainbowText | Line: 99 ]]
	local v1 = utf8.len(p1) or 1
	local count = 0
	local t = {}

	for v2, v3 in utf8.codes(p1) do
		count = count + 1

		local v4 = utf8.char(v3)
		local v5 = Color3.fromHSV((p2 * 1.2 + (count - 1) / v1 * 0.6) % 1, 1, 1)

		table.insert(t, string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v5.R * 255), math.floor(v5.G * 255), (math.floor(v5.B * 255))), v4))
	end

	return table.concat(t)
end

function t.NpcText(p1, p2, p3) --[[ NpcText | Line: 118 | Upvalues: v2 (ref), Talk_UI (copy), playTypewriterEffect (copy), setupDisappearScripts (copy) ]]
	if v2 then
		v2()
		v2 = nil
	end

	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 then
		setupDisappearScripts(v1, Talk_UI, p3)
		v1.TextLabel.Text = p2
		playTypewriterEffect(v1.TextLabel, true, p1.Name)

		return v1
	end

	local v22 = Talk_UI:Clone()

	v22.Parent = p1.Head
	v22.TextLabel.Text = p2
	playTypewriterEffect(v22.TextLabel, true, p1.Name)

	if p3 then
		for v3, v4 in v22:GetDescendants() do
			if v4:IsA("LocalScript") or v4:IsA("Script") then
				v4.Enabled = true
			end
		end
	end

	return v22
end
function t.RainbowNpcText(p1, p2, p3, p4, p5) --[[ RainbowNpcText | Line: 153 | Upvalues: v2 (ref), Talk_UI (copy), playTypewriterEffect (copy), setupDisappearScripts (copy), buildRainbowText (copy) ]]
	if v2 then
		v2()
		v2 = nil
	end

	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)
	local v22 = p2 .. "<font color=\"#FFFFFF\">" .. p3 .. "</font>" .. p4
	local v3

	if v1 then
		setupDisappearScripts(v1, Talk_UI, p5)
		v3 = v1
		v1.TextLabel.Text = v22
		playTypewriterEffect(v1.TextLabel, true, p1.Name)
	else
		v3 = Talk_UI:Clone()
		v3.Parent = p1.Head
		v3.TextLabel.Text = v22
		playTypewriterEffect(v3.TextLabel, true, p1.Name)

		if p5 then
			for v4, v5 in v3:GetDescendants() do
				if v5:IsA("LocalScript") or v5:IsA("Script") then
					v5.Enabled = true
				end
			end
		end
	end

	local v6 = true

	local function stop() --[[ stop | Line: 186 | Upvalues: v6 (ref) ]]
		v6 = false
	end

	v2 = stop
	task.spawn(function() --[[ Line: 191 | Upvalues: v6 (ref), v3 (ref), p2 (copy), buildRainbowText (ref), p3 (copy), p4 (copy), v2 (ref), stop (copy) ]]
		local sum = 0

		while v6 do
			sum = sum + task.wait(0.04)

			if not v6 then
				break
			end

			if v3 and v3.Parent then
				v3.TextLabel.Text = p2 .. buildRainbowText(p3, sum) .. p4
			else
				v6 = false

				break
			end
		end

		if v2 ~= stop then
			return
		end

		v2 = nil
	end)

	return stop
end

local function wrapColor(p1, p2) --[[ wrapColor | Line: 216 ]]
	if p2 then
		return string.format("<font color=\"%s\">%s</font>", p2, p1)
	end

	return p1
end

local function spawnTypewriterEffect(p1, p2) --[[ spawnTypewriterEffect | Line: 228 | Upvalues: SoundService (copy), stripRichTextTags (copy) ]]
	p1.MaxVisibleGraphemes = 0

	local v1 = p2 and SoundService.NPC_SFX:FindFirstChild(p2) or SoundService.NPC_SFX.NPC_Text

	task.spawn(function() --[[ Line: 231 | Upvalues: p1 (copy), stripRichTextTags (ref), v1 (copy) ]]
		local count2 = 0

		while p1 and p1.Parent do
			if (utf8.len(stripRichTextTags(p1.Text)) or 0) <= count2 then
				p1.MaxVisibleGraphemes = -1

				return
			end

			count2 = count2 + 1
			p1.MaxVisibleGraphemes = count2

			if v1 and (v1.TimePosition > 0.07 or not v1.Playing) then
				v1.TimePosition = 0
				v1.Playing = true
				v1.PlaybackSpeed = 1 + math.random(-5, 5) / 100
			end

			task.wait()
		end
	end)
end

function t.NpcCountUp(p1, p2) --[[ NpcCountUp | Line: 267 | Upvalues: v2 (ref), Talk_UI (copy), setupDisappearScripts (copy), SoundService (copy), stripRichTextTags (copy), buildRainbowText (copy) ]]
	if v2 then
		v2()
		v2 = nil
	end

	local TextBefore = p2.TextBefore
	local TextAfter = p2.TextAfter
	local FinalAmount = p2.FinalAmount
	local Format = p2.Format
	local Color = p2.Color
	local v1 = if p2.Rainbow == true then true else false
	local v22 = p2.Duration or 0.7
	local v3 = p2.ShouldDisappear or false
	local v4 = Format(0)
	local v5 = if v1 then TextBefore .. "<font color=\"#FFFFFF\">" .. v4 .. "</font>" .. TextAfter else TextBefore .. (if Color then string.format("<font color=\"%s\">%s</font>", Color, v4) else v4) .. TextAfter
	local v7 = p1.Head:FindFirstChild(Talk_UI.Name)
	local v8

	if v7 then
		setupDisappearScripts(v7, Talk_UI, v3)
		v8 = v7
		v7.TextLabel.Text = v5
	else
		v8 = Talk_UI:Clone()
		v8.Parent = p1.Head
		v8.TextLabel.Text = v5

		if v3 then
			for v9, v10 in v8:GetDescendants() do
				if v10:IsA("LocalScript") or v10:IsA("Script") then
					v10.Enabled = true
				end
			end
		end
	end

	local TextLabel = v8.TextLabel
	local v11 = p1.Name

	TextLabel.MaxVisibleGraphemes = 0

	local v12 = v11 and SoundService.NPC_SFX:FindFirstChild(v11) or SoundService.NPC_SFX.NPC_Text

	task.spawn(function() --[[ Line: 231 | Upvalues: TextLabel (copy), stripRichTextTags (ref), v12 (copy) ]]
		local count2 = 0

		while TextLabel and TextLabel.Parent do
			if (utf8.len(stripRichTextTags(TextLabel.Text)) or 0) <= count2 then
				TextLabel.MaxVisibleGraphemes = -1

				return
			end

			count2 = count2 + 1
			TextLabel.MaxVisibleGraphemes = count2

			if v12 and (v12.TimePosition > 0.07 or not v12.Playing) then
				v12.TimePosition = 0
				v12.Playing = true
				v12.PlaybackSpeed = 1 + math.random(-5, 5) / 100
			end

			task.wait()
		end
	end)

	if v1 then
		local v13 = v4
		local v14 = true

		local function stop() --[[ stop | Line: 334 | Upvalues: v14 (ref) ]]
			v14 = false
		end

		v2 = stop

		local sum = 0
		local sum2 = 0

		while sum2 < v22 do
			if v14 and (v8 and v8.Parent) then
				v13 = Format((math.round((math.lerp(0, FinalAmount, (math.clamp(sum2 / v22, 0, 1)))))))
				v8.TextLabel.Text = TextBefore .. buildRainbowText(v13, sum) .. TextAfter

				local v17 = task.wait()

				sum = sum + v17
				sum2 = sum2 + v17
			else
				v14 = false

				break
			end
		end

		if v14 then
			v13 = Format(FinalAmount)
		end

		task.spawn(function() --[[ Line: 359 | Upvalues: v14 (ref), sum (ref), v8 (ref), TextBefore (copy), buildRainbowText (ref), v13 (ref), TextAfter (copy), v2 (ref), stop (copy) ]]
			while v14 do
				sum = sum + task.wait(0.04)

				if not v14 then
					break
				end

				if v8 and v8.Parent then
					v8.TextLabel.Text = TextBefore .. buildRainbowText(v13, sum) .. TextAfter
				else
					v14 = false

					break
				end
			end

			if v2 ~= stop then
				return
			end

			v2 = nil
		end)
	else
		local sum = 0

		while sum < v22 do
			local v18

			if not (v8 and v8.Parent) then
				return
			end

			local v222 = Format((math.round((math.lerp(0, FinalAmount, (math.clamp(sum / v22, 0, 1)))))))

			v18 = if Color then string.format("<font color=\"%s\">%s</font>", Color, v222) else v222
			v8.TextLabel.Text = TextBefore .. v18 .. TextAfter
			sum = sum + task.wait()
		end

		if v8 and v8.Parent then
			local v25 = Format(FinalAmount)

			v8.TextLabel.Text = TextBefore .. (if Color then string.format("<font color=\"%s\">%s</font>", Color, v25) else v25) .. TextAfter
		end
	end
end
t.BuildRainbowText = buildRainbowText
function t.RainbowPlayerResponse(p1, p2, p3, p4, p5) --[[ RainbowPlayerResponse | Line: 380 | Upvalues: v3 (ref), Talk_UI (copy), Response_UI (copy), playTypewriterEffect (copy), setupDisappearScripts (copy), buildRainbowText (copy) ]]
	if v3 then
		v3()
		v3 = nil
	end

	local Head = p1:FindFirstChild("Head")

	if not Head then
		return nil
	end

	local v1 = Head:FindFirstChild(Talk_UI.Name)
	local v2 = p2 .. "<font color=\"#FFFFFF\">" .. p3 .. "</font>" .. p4
	local v32

	if v1 then
		setupDisappearScripts(v1, Response_UI, p5)
		v32 = v1
		v1.TextLabel.Text = v2
		playTypewriterEffect(v1.TextLabel, false)
	else
		v32 = Response_UI:Clone()
		v32.Parent = Head
		v32.TextLabel.Text = v2
		playTypewriterEffect(v32.TextLabel, false)

		if p5 then
			for v4, v5 in v32:GetDescendants() do
				if v5:IsA("LocalScript") or v5:IsA("Script") then
					v5.Enabled = true
				end
			end
		end
	end

	local v6 = true

	local function stop() --[[ stop | Line: 415 | Upvalues: v6 (ref) ]]
		v6 = false
	end

	v3 = stop
	task.spawn(function() --[[ Line: 420 | Upvalues: v6 (ref), v32 (ref), p2 (copy), buildRainbowText (ref), p3 (copy), p4 (copy), v3 (ref), stop (copy) ]]
		local sum = 0

		while v6 do
			sum = sum + task.wait(0.04)

			if not v6 then
				break
			end

			if v32 and v32.Parent then
				v32.TextLabel.Text = p2 .. buildRainbowText(p3, sum) .. p4
			else
				v6 = false

				break
			end
		end

		if v3 ~= stop then
			return
		end

		v3 = nil
	end)

	return stop
end
function t.ShowChoices(p1, p2) --[[ ShowChoices | Line: 439 | Upvalues: Option_UI (copy), TweenService (copy), Debris (copy) ]]
	local t = {}
	local Billboard_UI = p1.PlayerGui:FindFirstChild("Billboard_UI")

	if not Billboard_UI then
		return t
	end

	for i, v in ipairs(p2) do
		local v1 = Option_UI:Clone()

		v1.Parent = Billboard_UI.Objects
		v1.Frame.Frame.Text_Element.Text = "[\"" .. v .. "\"]"
		v1.Frame.Frame.TextLabel.Text = "#" .. tostring(i)

		local UIPadding = v1.Frame.Frame.Text_Element.UIPadding
		local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		UIPadding.PaddingLeft = UDim.new(string.len(v) * 0.001 + 0.04, 0)

		local v3 = TweenService:Create(UIPadding, v2, {
			PaddingLeft = UDim.new(0, 0)
		})

		v3:Play()
		Debris:AddItem(v3, v2.Time)
		table.insert(t, v1)
		v1.Frame.Frame.Text_Element:SetAttribute("Text", v)
		task.wait(0.075)
	end

	return t
end
function t.TakeAwayResponses(p1, p2) --[[ TakeAwayResponses | Line: 470 | Upvalues: TweenService (copy), v1 (copy), Debris (copy) ]]
	for v12, v2 in p1.Head:GetChildren() do
		if v2:IsA("BillboardGui") and (v2.Name == "Response_UI" or v2.Name == "Talk_UI") then
			for v3, v4 in v2:GetChildren() do
				if v4:IsA("TextLabel") then
					TweenService:Create(v4, v1, {
						TextTransparency = 1
					}):Play()

					continue
				end

				if v4:IsA("ImageLabel") then
					TweenService:Create(v4, v1, {
						ImageTransparency = 1
					}):Play()
				end
			end

			Debris:AddItem(v2, v1.Time)
		end
	end
end
function t.ConnectChoiceKeyboard(p1, p2) --[[ ConnectChoiceKeyboard | Line: 493 ]]
	return function() --[[ Line: 497 ]] end
end
function t.RemovePlayerSideFrame(p1) --[[ RemovePlayerSideFrame | Line: 500 ]]
	local Billboard_UI = p1.PlayerGui:FindFirstChild("Billboard_UI")

	if not Billboard_UI then
		return
	end

	for v1, v2 in Billboard_UI.Objects:GetChildren() do
		if v2.Name ~= "UIListLayout" then
			v2:Destroy()
		end
	end
end
function t.ShowResponse(p1, p2, p3) --[[ ShowResponse | Line: 512 | Upvalues: Talk_UI (copy), playTypewriterEffect (copy), setupDisappearScripts (copy) ]]
	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 then
		setupDisappearScripts(v1, Talk_UI, p3)
		v1.TextLabel.Text = p2
		playTypewriterEffect(v1.TextLabel, true)

		return v1
	end

	local v2 = Talk_UI:Clone()

	v2.Parent = p1.Head
	v2.TextLabel.Text = p2
	playTypewriterEffect(v2.TextLabel, true)

	if p3 then
		for v3, v4 in v2:GetDescendants() do
			if v4:IsA("LocalScript") or v4:IsA("Script") then
				v4.Enabled = true
			end
		end
	end

	return v2
end
function t.PlayerResponse(p1, p2, p3) --[[ PlayerResponse | Line: 538 | Upvalues: v3 (ref), Talk_UI (copy), Response_UI (copy), playTypewriterEffect (copy), setupDisappearScripts (copy) ]]
	if not p2 then
		return nil
	end

	if v3 then
		v3()
		v3 = nil
	end

	local v1 = p1.Head:FindFirstChild(Talk_UI.Name)

	if v1 then
		setupDisappearScripts(v1, Response_UI, p3)
		v1.TextLabel.Text = p2
		playTypewriterEffect(v1.TextLabel, false)

		return v1
	end

	local v2 = Response_UI:Clone()

	v2.Parent = p1.Head
	v2.TextLabel.Text = p2
	playTypewriterEffect(v2.TextLabel, false)

	if p3 then
		for v32, v4 in v2:GetDescendants() do
			if v4:IsA("LocalScript") or v4:IsA("Script") then
				v4.Enabled = true
			end
		end
	end

	return v2
end

return t