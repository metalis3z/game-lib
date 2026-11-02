--credit to leon games studio
require(game.ReplicatedStorage.ClientModules.Chalk)

local t = {
	Rules = {
		YourShopRestock = {
			Key = "YourShopRestock",
			Pattern = "^Your ([%w ]+ Shop) stock has restocked!$",
			Suffix = "stock has restocked!",
			PluralSuffix = "stocks have restocked!"
		}
	}
}

local function StripRich(p1) --[[ StripRich | Line: 36 ]]
	return p1:gsub("<.->", "")
end

local function ExtractFullFontColor(p1) --[[ ExtractFullFontColor | Line: 40 ]]
	local v1 = p1:match("^%s*<font[^>]-color=\"([^\"]+)\"[^>]*>.*</font>%s*$")

	if not v1 then
		v1 = p1:match("^%s*<font[^>]-color=([^%s>]+)[^>]*>.*</font>%s*$")
	end

	return v1
end

local function CaptureColoredVariantBeforeSuffix(p1, p2) --[[ CaptureColoredVariantBeforeSuffix | Line: 48 ]]
	return p1:match("^.*(<font.-</font>)%s+.*$")
end

function t.GetCondenseKey(p1, p2) --[[ GetCondenseKey | Line: 52 ]]
	local v1 = p2:gsub("<.->", "")

	for k, v in pairs(p1.Rules) do
		local v2
		local v3 = v1:match(v.Pattern)

		if v3 then
			local Suffix = v.Suffix
			local v4 = p2:match("^.*(<font.-</font>)%s+.*$")
			local v5 = v4 or p2
			local v6 = v5:match("^%s*<font[^>]-color=\"([^\"]+)\"[^>]*>.*</font>%s*$")

			if not v6 then
				v6 = v5:match("^%s*<font[^>]-color=([^%s>]+)[^>]*>.*</font>%s*$")
			end

			if v4 then
				v2 = v6
			else
				local v8 = p2:match("^%s*<font[^>]-color=\"([^\"]+)\"[^>]*>.*</font>%s*$")

				if not v8 then
					v8 = p2:match("^%s*<font[^>]-color=([^%s>]+)[^>]*>.*</font>%s*$")
				end

				if v8 then
					v4, v2 = ("<font color=\"%*\">%*</font>"):format(v8, v3), v6
				else
					v4 = v3
					v2 = v6
				end
			end

			return {
				Rule = v,
				Variant = {
					Plain = v3,
					Rich = v4,
					Color = v2
				}
			}
		end
	end

	return nil
end
function t.BuildCondensedText(p1, p2, p3, p4) --[[ BuildCondensedText | Line: 86 ]]
	table.sort(p2, function(p1, p2) --[[ Line: 87 ]]
		return p1.Plain < p2.Plain
	end)

	local v1 = true
	local v2

	if #p2 > 0 then
		v2 = p2[1].Color

		for i = 2, #p2 do
			if p2[i].Color ~= v2 then
				v1 = false

				break
			end
		end
	else
		v1 = false
		v2 = nil
	end

	local v3

	if #p2 == 1 then
		v3 = p2[1].Rich .. " " .. p3
	elseif #p2 == 2 then
		v3 = p2[1].Rich .. " and " .. p2[2].Rich .. " " .. p4
	else
		local t = {}

		for j = 1, #p2 - 1 do
			table.insert(t, p2[j].Rich)
		end

		v3 = table.concat(t, ", ") .. " and " .. p2[#p2].Rich .. " " .. p4
	end

	if v1 and v2 then
		v3 = ("<font color=\"%*\">%*</font>"):format(v2, v3)
	end

	return v3
end

return t