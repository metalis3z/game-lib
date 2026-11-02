-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.TreadmillMediaIdentity.Types.Interface)
require(ReplicatedStorage.Library.Client.TreadmillVideoController.Types.Interface)

local t = {}

local function extractAssetId(p1) --[[ extractAssetId | Line: 22 ]]
	local v1 = string.match(p1, "%d+")

	assert(if v1 == nil then false elseif v1 == "" then false else true, (("Invalid treadmill media asset id \"%*\""):format(p1)))

	return v1
end

function t.GetMediaKey(p1) --[[ GetMediaKey | Line: 32 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)

	if p1.Kind == "Video" then
		local Video = p1.Video
		local v2 = string.match(Video, "%d+")

		assert(if v2 == nil then false elseif v2 == "" then false else true, (("Invalid treadmill media asset id \"%*\""):format(Video)))

		return ("Video:%*"):format(v2)
	end

	local Image = p1.Image
	local v6 = string.match(Image, "%d+")

	assert(if v6 == nil then false elseif v6 == "" then false else true, (("Invalid treadmill media asset id \"%*\""):format(Image)))

	return ("Image:%*"):format(v6)
end
function t.BuildMediaKeys(p1) --[[ BuildMediaKeys | Line: 42 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.table(p1)

	local t2 = {}
	local t3 = {}

	for i, v in ipairs(p1) do
		local v1 = t.GetMediaKey(v)

		if not t2[v1] then
			t2[v1] = true
			table.insert(t3, v1)
		end
	end

	return t3, t2
end
function t.GetMediaKeyShardIndex(p1, p2) --[[ GetMediaKeyShardIndex | Line: 63 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)
	Asserts.positiveInteger(p2)

	local v1 = 0

	for i = 1, #p1 do
		v1 = (v1 * 33 + string.byte(p1, i)) % p2
	end

	return v1
end

return t