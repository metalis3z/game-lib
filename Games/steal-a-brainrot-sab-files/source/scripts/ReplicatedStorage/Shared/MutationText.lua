

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Index = require(Datas.Index)
local Mutations = require(Datas.Mutations)
local MutationStyle = require(ReplicatedStorage.Shared.MutationStyle)
local t1 = {
	Phantom = {
		Gradient = "Phantom",
		Bold = true
	}
}
local color3 = Color3.fromRGB(255, 255, 255)
local t2 = {}

local function hexOf(color3_2: Color3)
	return `#{ color3_2:ToHex() }`
end
local function lookup(s1: string)
	local v21 = Mutations[s1]
	local v22 = Index[s1]

	if not v21 and not v22 then
		return nil
	end

	return {
		DisplayText = ((if not v21 then v22 and v22.DisplayText else v21.DisplayText)) or s1,
		DisplayWithRichText = if not v21 then v22 and v22.DisplayWithRichText else v21.DisplayWithRichText,
		UseRichText = if not v21 then v22 and v22.UseRichText else v21.UseRichText,
		UseRichTextInSettings = v22 and v22.UseRichTextInSettings
	}
end
local function buildMarkup(t3: {[any]: any}, s2: string, b1: boolean)
	if t3.RichText then
		return t3.RichText
	end

	if b1 and t3.Color then
		s2 = `<font color="{ `#{ t3.Color:ToHex() }` }">{ s2 }</font>`
	end

	if t3.Bold then
		s2 = `<b>{ s2 }</b>`
	end

	if t3.Italic then
		s2 = `<i>{ s2 }</i>`
	end

	if t3.Stroke then
		local Stroke = t3.Stroke
		local s3 = ""

		if Stroke.Color then
			s3 ..= (" color=\"%*\""):format(`#{ Stroke.Color:ToHex() }`)
		end

		if Stroke.Thickness then
			s3 ..= (" thickness=\"%*\""):format(Stroke.Thickness)
		end

		if Stroke.Transparency then
			s3 ..= (" transparency=\"%*\""):format(Stroke.Transparency)
		end

		s2 = `<stroke{ s3 }>{ s2 }</stroke>`
	end

	return s2
end
local function hasInlineMarkup(t4: {[any]: any})
	return t4.RichText ~= nil or (t4.Color ~= nil or (t4.Bold == true or (t4.Italic == true or t4.Stroke ~= nil)))
end
local function clearLabel(p1)
	local v30 = t2[p1]

	if v30 then
		v30:Destroy()
	end
end
local function trackLabelEffect(p2, p3: ((...any) -> ...any))
	local v33 = Trove.new()

	t2[p2] = v33
	v33:Add(p3)
	v33:Add(function()
		if t2[p2] == v33 then
			t2[p2] = nil
		end
	end)
	v33:Add(p2.Destroying:Connect(function()
		local v51 = t2[p2]

		if v51 then
			v51:Destroy()
		end
	end))

	return function()
		local v52 = t2[p2]

		if v52 then
			v52:Destroy()
		end
	end
end

local t5 = {
	Effects = t1
}

local function Resolve(s4: string, s5: string?)
	local v36 = s5 or "Rich"
	local v37 = lookup(s4)

	if not v37 then
		return s4, false
	end

	local v38 = t1[s4]

	if v38 and (v38.RichText ~= nil or (v38.Color ~= nil or (v38.Bold == true or (v38.Italic == true or v38.Stroke ~= nil)))) then
		return buildMarkup(v38, v37.DisplayText, true), true
	end

	local v39 = v37.DisplayWithRichText or v37.DisplayText

	if v36 == "Rich" then
		return v39, true
	end

	if v36 == "Settings" then
		if v37.UseRichTextInSettings then
			return v39, true
		end

		return v37.DisplayText, false
	end

	if v37.UseRichText then
		return v39, true
	end

	return v37.DisplayText, false
end

t5.Resolve = Resolve

function t5.ApplyToLabel(p4, s6: string, s7: string?)
	local v43 = s7 or "Auto"
	local v44 = t2[p4]

	if v44 then
		v44:Destroy()
	end

	local v45 = lookup(s6)
	local v46 = t1[s6]

	if v46 and v45 and (v46.Gradient or (v46.RichText ~= nil or (v46.Color ~= nil or (v46.Bold == true or (v46.Italic == true or v46.Stroke ~= nil))))) then
		if v46.Gradient then
			local v47 = buildMarkup(v46, v45.DisplayText, false)

			p4.Text = v47
			p4.RichText = v47 ~= v45.DisplayText
			p4.TextColor3 = color3

			return (trackLabelEffect(p4, Gradients.apply(p4, v46.Gradient)))
		end

		p4.Text = buildMarkup(v46, v45.DisplayText, true)
		p4.RichText = true

		return nil
	end

	local v48, v49 = Resolve(s6, v43)

	p4.Text = v48
	p4.RichText = v49

	if v43 == "Auto" then
		local v50 = MutationStyle.ApplyToLabel(p4, s6)

		if v50 then
			return (trackLabelEffect(p4, v50))
		end
	end

	return nil
end

t5.ClearLabel = clearLabel

return table.freeze(t5)
