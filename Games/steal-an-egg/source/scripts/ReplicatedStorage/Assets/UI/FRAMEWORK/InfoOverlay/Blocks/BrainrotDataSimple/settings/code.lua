-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Boosts = require(ReplicatedStorage.Directory.Boosts)
local Gears = require(ReplicatedStorage.Directory.Gears)

local function applyGearDisplay(p1, p2, p3, p4) --[[ applyGearDisplay | Line: 14 | Upvalues: Gears (copy) ]]
	local v1 = Gears.Directory[p3]

	if v1 then
		p2.Text = "Gives you"
		p2.TextColor3 = p4
		p2.Size = UDim2.fromScale(0.5, 1)

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

return function(p1, p2, p3) --[[ Line: 40 | Upvalues: Boosts (copy), applyGearDisplay (copy) ]]
	if typeof(p3) ~= "table" then
		return
	end

	local Type = p3.Type

	if typeof(Type) ~= "string" or Type == "" then
		return
	end

	local v1 = Boosts.Directory[Type]

	if not v1 then
		return
	end

	local boost = p1:FindFirstChild("boost")

	if not (boost and boost:IsA("TextLabel")) then
		return
	end

	local icon = p1:FindFirstChild("icon")

	if icon and not icon:IsA("ImageLabel") then
		icon = nil
	end

	local v2 = p3.Value

	if typeof(v2) == "number" then
		local v3 = math.round(v2 * 100)

		boost.Text = string.format("%s%d%% %s", if v3 >= 0 then "+" else "", v3, v1.Abbreviation)
		boost.TextColor3 = v1.Color

		if icon then
			icon.Visible = false
		end

		p1.Visible = true
	elseif typeof(v2) == "string" then
		applyGearDisplay(icon, boost, v2, v1.Color)
		p1.Visible = true
	end
end