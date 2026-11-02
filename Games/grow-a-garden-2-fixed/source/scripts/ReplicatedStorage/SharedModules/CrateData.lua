--credit to prince games studio
local t = {}
local t2 = {}
local v1 = nil

local function getGuildCrateData() --[[ getGuildCrateData | Line: 8 | Upvalues: v1 (ref) ]]
	if v1 == nil then
		local v12 = script.Parent
		local v2 = if v12 then v12:FindFirstChild("GuildCrateData") else v12

		if v2 and v2:IsA("ModuleScript") then
			local ok, result = pcall(require, v2)

			if ok then
				v1 = result
			else
				warn((("[CrateData] GuildCrateData require failed; guild crate lookups disabled: %*"):format(result)))
				v1 = false
			end
		else
			v1 = false
		end
	end

	if v1 == false then
		return nil
	end

	return v1
end

local function getCrateImageOverride(p1) --[[ getCrateImageOverride | Line: 30 ]]
	local v1 = script.Parent

	if not v1 then
		return nil
	end

	local CrateImages = v1:FindFirstChild("CrateImages")

	if not CrateImages then
		return nil
	end

	local v2 = CrateImages:FindFirstChild(p1)

	if v2 and (v2:IsA("StringValue") and v2.Value ~= "") then
		return v2.Value
	end

	return nil
end

function t.GetData(p1) --[[ GetData | Line: 42 | Upvalues: t2 (copy), getGuildCrateData (copy) ]]
	if t2[p1] then
		return t2[p1]
	end

	local v1 = script:FindFirstChild(p1)

	if v1 then
		local ok, result = pcall(function() --[[ Line: 63 | Upvalues: v1 (copy) ]]
			return require(v1)
		end)

		if not ok then
			warn((("[CrateData] Crate module require failed (%*): %*"):format(p1, result)))

			return nil
		end

		local v2 = script.Parent
		local v3

		if v2 then
			local CrateImages = v2:FindFirstChild("CrateImages")

			if CrateImages then
				local v4 = CrateImages:FindFirstChild(p1)

				v3 = if v4 and (v4:IsA("StringValue") and v4.Value ~= "") then v4.Value else nil
			else
				v3 = nil
			end
		else
			v3 = nil
		end

		if v3 then
			result.IMG = v3
		end

		t2[p1] = result

		return result
	end

	local v5 = getGuildCrateData()

	if not v5 then
		return nil
	end

	local v6 = v5.GetData(p1)

	if v6 then
		return v6
	end

	return nil
end
function t.IsGuildCrate(p1) --[[ IsGuildCrate | Line: 83 | Upvalues: getGuildCrateData (copy) ]]
	local v1 = getGuildCrateData()

	if not v1 then
		return false
	end

	return v1.GetData(p1) ~= nil
end
function t.GetRandomItem(p1) --[[ GetRandomItem | Line: 89 | Upvalues: t (copy) ]]
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
function t.GetAllCrates() --[[ GetAllCrates | Line: 113 | Upvalues: t (copy), getGuildCrateData (copy) ]]
	local t2 = {}

	for v1, v2 in script:GetChildren() do
		if v2:IsA("ModuleScript") then
			local v3 = t.GetData(v2.Name)

			if v3 then
				table.insert(t2, v3)
			end
		end
	end

	local v4 = getGuildCrateData()

	if v4 then
		for v5, v6 in v4.GetAllCrates() do
			table.insert(t2, v6)
		end
	end

	return t2
end

return t