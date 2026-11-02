-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Boosts = require(ReplicatedStorage.Directory.Boosts)
local Gears = require(ReplicatedStorage.Directory.Gears)

local function clearExistingClones(p1, p2) --[[ clearExistingClones | Line: 32 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v ~= p2 and v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end

local function applyGearDisplay(p1, p2, p3, p4) --[[ applyGearDisplay | Line: 40 | Upvalues: Gears (copy) ]]
	local v1 = Gears.Directory[p3]

	if v1 then
		p2.Text = "Gives you"
		p2.TextColor3 = p4
		p2.TextScaled = true
		p2.Size = UDim2.fromScale(0.7, 1)

		if not p1 then
			return
		end

		local Icon = v1.Icon

		if Icon and Icon ~= "" then
			p1.Main.Image = Icon
			p1.Visible = true

			return
		end
	else
		p2.Text = p3
		p2.TextColor3 = p4

		if not p1 then
			return
		end
	end

	p1.Visible = false
end

local function buildBoostDisplay(p1) --[[ buildBoostDisplay | Line: 67 | Upvalues: Boosts (copy) ]]
	local t = {}

	if not p1 then
		return t
	end

	for k, v in pairs(p1) do
		local v1 = Boosts.Directory[k]

		if v1 then
			if k == "SpecialItem" then
				if typeof(v) == "string" and v ~= "" then
					table.insert(t, {
						type = k,
						value = v,
						abbreviation = v1.Abbreviation,
						color = v1.Color
					})
				end

				continue
			end

			if typeof(v) == "number" then
				table.insert(t, {
					type = k,
					value = v,
					abbreviation = v1.Abbreviation,
					color = v1.Color
				})
			end
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 99 ]]
		if p1.abbreviation == p2.abbreviation then
			return p1.type < p2.type
		end

		return p1.abbreviation < p2.abbreviation
	end)

	return t
end

return function(p1, p2, p3) --[[ Line: 110 | Upvalues: buildBoostDisplay (copy), clearExistingClones (copy), applyGearDisplay (copy) ]]
	if not p3 then
		return
	end

	local Boosts = p1:FindFirstChild("Boosts")

	if not (Boosts and Boosts:IsA("Frame")) then
		return
	end

	local Template = Boosts:FindFirstChild("Template")

	if not (Template and Template:IsA("Frame")) then
		return
	end

	local v1 = buildBoostDisplay(p3.boosts)

	if #v1 == 0 then
		return
	end

	clearExistingClones(Boosts, Template)

	local Icon = p1:FindFirstChild("Icon")

	if Icon and Icon:IsA("ImageLabel") then
		local v2 = p3.icon or p3.config and p3.config.Icon

		if v2 then
			Icon.Image = v2
		end
	end

	local Quantity = p1:FindFirstChild("Quantity", true)

	if Quantity and Quantity:IsA("TextLabel") then
		local v3 = p3.quantity or 0

		if v3 > 1 then
			Quantity.Visible = true
			Quantity.Text = "x" .. tostring(v3)
		else
			Quantity.Visible = false
		end
	end

	for i, v in ipairs(v1) do
		local v4 = Template:Clone()

		v4.Name = v.type .. i
		v4.Visible = true
		v4.LayoutOrder = i

		local boost = v4:FindFirstChild("boost")

		if boost and boost:IsA("TextLabel") then
			local icon = v4:FindFirstChild("icon")

			if icon and not icon:IsA("ImageLabel") then
				icon = nil
			end

			if v.type == "SpecialItem" and typeof(v.value) == "string" then
				applyGearDisplay(icon, boost, v.value, v.color)
			else
				local v5, v6, v7, v8

				v5 = v.value
				v6 = if typeof(v5) == "number" then v.value else 0
				v7 = math.round(v6 * 100)
				v8 = if v7 >= 0 then "+" else ""
				boost.Text = string.format("%s%d%% %s", v8, v7, v.abbreviation)
				boost.TextColor3 = v.color

				if icon then
					icon.Visible = false
				end
			end

			v4.Parent = Boosts

			continue
		end

		v4:Destroy()
	end

	Template.Visible = false
	p1.Visible = true
end