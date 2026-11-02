-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t1 = {
	"rainbow",
	"og",
	"yellowred",
	"zebra",
	"greenred",
	"slowgreenred",
	"phantom"
}

local function transformRichText(s1: string)
	local t2 = {}

	for _, v11 in t1 do
		local v12 = `<{ v11 }>(.-)</{ v11 }>`
		local result, count = string.gsub(s1, v12, "<stroke transparency=\"0\"><font transparency=\"0\">%1</font></stroke>")

		if count > 0 then
			s1 = string.gsub(s1, v12, "<stroke transparency=\"1\"><font transparency=\"1\">%1</font></stroke>")
			table.insert(t2, {
				tag = v11,
				text = result
			})
		end
	end

	return s1, t2
end

local t3 = {}
local t4 = {}

function t3.apply(p1, s2: string, t5: {[any]: any}?)
	t3.cleanup(p1)

	local v18 = Trove.new()

	t4[p1] = v18
	v18:Add(function()
		t4[p1] = nil
	end)
	p1.RichText = true

	local v19, v20 = transformRichText(s2)

	p1.Text = v19

	for _, v22 in v20 do
		local clone = v18:Clone(p1)

		clone:ClearAllChildren()
		clone.Text = `<stroke transparency="1"><font transparency="1">{ v22.text }</font></stroke>`
		clone.Size = UDim2.fromScale(1, 1)
		clone.Position = UDim2.fromScale(0.5, 0.5)
		clone.AnchorPoint = Vector2.new(0.5, 0.5)
		clone.Parent = p1

		if v22.tag == "rainbow" then
			v18:Add(Gradients.apply(clone, "Rainbow"))
		elseif v22.tag == "zebra" then
			v18:Add(Gradients.apply(clone, "Zebra"))
		elseif v22.tag == "og" then
			v18:Add(Gradients.apply(clone, "OG"))
		elseif v22.tag == "yellowred" then
			v18:Add(Gradients.apply(clone, "YellowRed"))
		elseif v22.tag == "greenred" then
			v18:Add(Gradients.apply(clone, "GreenRed"))
		elseif v22.tag == "slowgreenred" then
			v18:Add(Gradients.apply(clone, "SlowGreenRed"))
		elseif v22.tag == "phantom" then
			v18:Add(Gradients.apply(clone, "Phantom"))
		end
	end

	if t5 and t5.attachToInstance then
		v18:AttachToInstance(p1)
	end

	return v18
end
function t3.cleanup(p2)
	if t4[p2] then
		t4[p2]:Destroy()
	end
end

return t3
