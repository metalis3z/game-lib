--credit to quartz games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {}
local t2 = {
	Common = Color3.fromRGB(170, 170, 170),
	Uncommon = Color3.fromRGB(40, 200, 40),
	Rare = Color3.fromRGB(60, 130, 240),
	Epic = Color3.fromRGB(170, 80, 230),
	Legendary = Color3.fromRGB(245, 200, 60),
	Mythic = Color3.fromRGB(220, 50, 50)
}
local t3 = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 165, 0),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 200, 0),
	Color3.fromRGB(0, 100, 255),
	Color3.fromRGB(180, 0, 220)
}

local function v7(p1, p2, p3) --[[ v7 | Line: 21 ]]
	return Color3.new(p1.R + (p2.R - p1.R) * p3, p1.G + (p2.G - p1.G) * p3, p1.B + (p2.B - p1.B) * p3)
end

local function v15(p1) --[[ v15 | Line: 24 | Upvalues: t3 (copy), v7 (copy) ]]
	local v1 = #t3
	local v2 = p1 % 1 * v1
	local v3 = math.floor(v2)

	return v7(t3[v3 + 1], t3[(v3 + 1) % v1 + 1], v2 - v3)
end

local function v18(p1) --[[ v18 | Line: 34 | Upvalues: v7 (copy) ]]
	return v7(Color3.new(255/255, 255/255, 255/255), Color3.new(0/255, 0/255, 0/255), if p1 < 0.5 then p1 * 2 else (1 - p1) * 2)
end

local function v23(p1, p2) --[[ v23 | Line: 39 ]]
	for v1, v2 in p1 do
		if v2 and v2.Parent then
			pcall(function() --[[ Line: 42 | Upvalues: v2 (copy), p2 (copy) ]]
				v2.TextColor3 = p2
			end)
			pcall(function() --[[ Line: 46 | Upvalues: v2 (copy), p2 (copy) ]]
				v2.TextStrokeColor3 = p2
			end)
			pcall(function() --[[ Line: 50 | Upvalues: v2 (copy), p2 (copy) ]]
				v2.ImageColor3 = p2
			end)
		end
	end
end

function t.GetStaticColor(p1) --[[ Line: 57 | Upvalues: t2 (copy), v15 (copy), v18 (copy) ]]
	if t2[p1] then
		return t2[p1]
	end

	if p1 == "Super" then
		return v15(0)
	end

	if p1 == "Secret" then
		return v18(0)
	end

	return Color3.new(255/255, 255/255, 255/255)
end

local function _(p1) --[[ _ | Line: 69 ]]
	return string.format("#%02X%02X%02X", math.floor(p1.R * 255 + 0.5), math.floor(p1.G * 255 + 0.5), (math.floor(p1.B * 255 + 0.5)))
end

function t.RichText(p1, p2) --[[ Line: 72 | Upvalues: t3 (copy), t (copy) ]]
	if type(p1) == "string" and p1 ~= "" then
		if p2 == "Super" then
			local v1 = math.max(1, #p1 - 1)
			local t2 = {}

			for i = 1, #p1 do
				local v2 = #t3
				local v3 = (i - 1) / v1 % 1 * v2
				local v4 = math.floor(v3)
				local v5 = v3 - v4
				local v6 = t3[v4 + 1]
				local v7 = t3[(v4 + 1) % v2 + 1]
				local v8 = Color3.new(v6.R + (v7.R - v6.R) * v5, v6.G + (v7.G - v6.G) * v5, v6.B + (v7.B - v6.B) * v5)

				table.insert(t2, string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v8.R * 255 + 0.5), math.floor(v8.G * 255 + 0.5), (math.floor(v8.B * 255 + 0.5))), (string.sub(p1, i, i))))
			end

			return table.concat(t2)
		end

		if p2 ~= "Secret" then
			local format = string.format
			local v16 = t.GetStaticColor(p2)

			return format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v16.R * 255 + 0.5), math.floor(v16.G * 255 + 0.5), (math.floor(v16.B * 255 + 0.5))), p1)
		end

		local v22 = Color3.fromRGB(240, 240, 240)
		local v23 = Color3.fromRGB(40, 40, 40)
		local t2 = {}

		for j = 1, #p1 do
			local v24 = if j % 2 == 1 then v22 else v23

			table.insert(t2, string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v24.R * 255 + 0.5), math.floor(v24.G * 255 + 0.5), (math.floor(v24.B * 255 + 0.5))), (string.sub(p1, j, j))))
		end

		return table.concat(t2)
	end

	return p1
end
function t.ApplyToLabels(p1, p2) --[[ Line: 109 | Upvalues: RunService (copy), v23 (copy), v15 (copy), v18 (copy), t (copy) ]]
	if #p1 == 0 then
		return function() --[[ Line: 112 ]] end
	end

	if p2 == "Super" then
		local v1 = os.clock()
		local v2 = RunService.Heartbeat:Connect(function() --[[ Line: 117 | Upvalues: v1 (copy), v23 (ref), p1 (copy), v15 (ref) ]]
			v23(p1, v15((os.clock() - v1) % 3 / 3))
		end)

		return function() --[[ Line: 122 | Upvalues: v2 (copy) ]]
			if not v2 then
				return
			end

			v2:Disconnect()
		end
	end

	if p2 == "Secret" then
		local v3 = os.clock()
		local v4 = RunService.Heartbeat:Connect(function() --[[ Line: 130 | Upvalues: v3 (copy), v23 (ref), p1 (copy), v18 (ref) ]]
			v23(p1, v18((os.clock() - v3) % 1.5 / 1.5))
		end)

		return function() --[[ Line: 135 | Upvalues: v4 (copy) ]]
			if not v4 then
				return
			end

			v4:Disconnect()
		end
	end

	v23(p1, t.GetStaticColor(p2))

	return function() --[[ Line: 143 ]] end
end

return t