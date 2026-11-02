--credit to prince games studio
local t = {}
local t2 = {}

local function getCrateImageOverride(p1) --[[ getCrateImageOverride | Line: 35 ]]
	local GuildCrateImages = script:FindFirstChild("GuildCrateImages")

	if not GuildCrateImages then
		return nil
	end

	local v1 = GuildCrateImages:FindFirstChild(p1)

	if v1 and (v1:IsA("StringValue") and v1.Value ~= "") then
		return v1.Value
	end

	return nil
end

function t.GetData(p1) --[[ GetData | Line: 45 | Upvalues: t2 (copy) ]]
	if t2[p1] then
		return t2[p1]
	end

	local v1 = script:FindFirstChild(p1)

	if not (v1 and v1:IsA("ModuleScript")) then
		return nil
	end

	local ok, result = pcall(function() --[[ Line: 55 | Upvalues: v1 (copy) ]]
		return require(v1)
	end)

	if ok and type(result) == "table" then
		local GuildCrateImages = script:FindFirstChild("GuildCrateImages")
		local v2

		if GuildCrateImages then
			local v3 = GuildCrateImages:FindFirstChild(p1)

			v2 = if v3 and (v3:IsA("StringValue") and v3.Value ~= "") then v3.Value else nil
		else
			v2 = nil
		end

		if v2 then
			result.IMG = v2
		elseif not result.IMG or result.IMG == "" then
			result.IMG = "rbxassetid://102182642774885"
		end

		t2[p1] = result

		return result
	end

	warn((("[GuildCrateData] Crate module require failed (%*): %*"):format(p1, if ok then "not a table" else result)))

	return nil
end
function t.GetRandomItem(p1) --[[ GetRandomItem | Line: 77 | Upvalues: t (copy) ]]
	local v1 = t.GetData(p1)

	if not v1 or (not v1.Items or #v1.Items == 0) then
		return nil
	end

	local sum = 0

	for v2, v3 in v1.Items do
		sum = sum + v3.Chance
	end

	local v4 = math.random() * sum
	local sum2 = 0

	for v5, v6 in v1.Items do
		sum2 = sum2 + v6.Chance

		if v4 <= sum2 then
			return v6
		end
	end

	return v1.Items[#v1.Items]
end
function t.GetAllCrates() --[[ GetAllCrates | Line: 101 | Upvalues: t (copy) ]]
	local t2 = {}

	for v1, v2 in script:GetChildren() do
		if v2:IsA("ModuleScript") then
			local v3 = t.GetData(v2.Name)

			if v3 then
				table.insert(t2, v3)
			end
		end
	end

	return t2
end
function t.IsGuildCrate(p1) --[[ IsGuildCrate | Line: 114 | Upvalues: t (copy) ]]
	return t.GetData(p1) ~= nil
end

return t