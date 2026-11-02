local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local v1 = nil
local t = {}
local t2 = {}

function t.loadTranslator() --[[ loadTranslator | Line: 11 | Upvalues: v1 (ref), LocalizationService (copy), Players (copy) ]]
	pcall(function() --[[ Line: 12 | Upvalues: v1 (ref), LocalizationService (ref), Players (ref) ]]
		v1 = LocalizationService:GetTranslatorForPlayerAsync(Players.LocalPlayer)
	end)

	if v1 then
		return
	end

	pcall(function() --[[ Line: 17 | Upvalues: v1 (ref), LocalizationService (ref) ]]
		v1 = LocalizationService:GetTranslatorForLocaleAsync("en")
	end)
end
function t2.RemoveRichTextTags(p1) --[[ RemoveRichTextTags | Line: 26 ]]
	local v1 = p1
	local v2

	while true do
		v2 = v1:gsub("<[^<>]+>", "")

		if v2 == v1 then
			break
		end

		v1 = v2
	end

	return v2
end
function t2.Translate(p1, p2) --[[ Translate | Line: 35 | Upvalues: v1 (ref), t2 (copy) ]]
	local v12 = if p1 then p1 else game

	if not v1 then
		return p2
	end

	if v1.LocaleId ~= "en" and v1.LocaleId ~= "en-us" then
		p2 = t2.RemoveRichTextTags(p2)
	end

	return v1:Translate(v12, p2)
end
function t.typeWrite(p1, p2, p3, p4) --[[ typeWrite | Line: 49 | Upvalues: v1 (ref), t2 (copy) ]]
	p2.Visible = true
	p2.AutoLocalize = false

	local v12 = if v1 then t2.Translate(p2, p1) else p1

	v12:gsub("<br%s*/>", "\n")
	v12:gsub("<[^<>]->", "")
	p2.Text = v12

	local count = 0
	local v3 = false
	local count2 = 0

	for v4, v5 in utf8.graphemes(v12) do
		count = count + 1

		local v6 = string.sub(v12, count, count)

		if v6 == "<" then
			v3 = true
		elseif v6 == ">" then
			v3 = false
		end

		if not v3 and v6 ~= ">" then
			count2 = count2 + 1
			p2.MaxVisibleGraphemes = count2

			if p4 then
				if not p4:FindFirstChild("pitch") then
					local pitch = Instance.new("PitchShiftSoundEffect")

					pitch.Name = "pitch"
					pitch.Parent = p4
				end

				p4.pitch.Octave = 1.1 - count % 3 * 0.1
				p4:Play()
			end

			if v6 == "," then
				task.wait(0.35)
			elseif v6 == "." or (v6 == "!" or v6 == "?") then
				task.wait(0.6)
			end

			task.wait(p3 or 0.05)
		end
	end
end

local t3 = {}
local v2 = false

function t2.Typewriter(p1, p2, p3, p4, p5) --[[ Typewriter | Line: 114 | Upvalues: t3 (copy), v2 (ref), t (copy) ]]
	table.insert(t3, {
		text = p1,
		guiObject = p2,
		delayBetweenChars = p3,
		sound = p4,
		font = p5
	})

	if v2 then
		return
	end

	v2 = true

	while #t3 > 0 do
		local v22 = table.remove(t3, 1)

		if not v22.guiObject then
			continue
		end

		v22.guiObject:SetAttribute("defaultFont", v22.guiObject:GetAttribute("defaultFont") or v22.guiObject.Font)
		v22.guiObject.Font = v22.font or v22.guiObject:GetAttribute("defaultFont")
		v22.guiObject.Text = ""
		t.typeWrite(v22.text, v22.guiObject, v22.delayBetweenChars, v22.sound)
	end

	v2 = false
end
function t2.TypewriterAsync(p1, p2, p3, p4) --[[ TypewriterAsync | Line: 131 | Upvalues: t2 (copy) ]]
	task.spawn(function() --[[ Line: 132 | Upvalues: t2 (ref), p1 (copy), p2 (copy), p3 (copy), p4 (copy) ]]
		t2.Typewriter(p1, p2, p3, p4)
	end)
end
function t2.LoadTranslator() --[[ LoadTranslator | Line: 137 | Upvalues: t (copy) ]]
	t.loadTranslator()
end

return t2