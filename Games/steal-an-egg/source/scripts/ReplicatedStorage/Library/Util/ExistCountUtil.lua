-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LibDeflate = require(ReplicatedStorage.Library.Functions.LibDeflate)
local Buffer = require(ReplicatedStorage.Library.Modules.Buffer)
local CRC32C = require(ReplicatedStorage.Library.Functions.CRC32C)
local Hash = require(ReplicatedStorage.Library.Functions.Hash)
local Digest = require(ReplicatedStorage.Library.Functions.MurmurHash3).Digest
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

return {
	encodeFromHash = function(p1) --[[ encodeFromHash | Line: 18 | Upvalues: Buffer (copy), LibDeflate (copy), Hash (copy), CRC32C (copy) ]]
		local list = {}
		local sum = 4

		for k in pairs(p1) do
			table.insert(list, k)
			sum = sum + 12
		end

		table.sort(list)

		local v1 = Buffer.allocate(sum)

		v1:writeu32(#list)

		local v2 = 0

		for i, v in ipairs(list) do
			v1:writeu32(v - v2)
			v2 = v
		end

		for i, v in ipairs(list) do
			v1:writei64(p1[v])
		end

		v1:flip()

		return Hash.bin_to_base64((LibDeflate:CompressDeflate((tostring(v1))))), CRC32C((tostring(v1)))
	end,
	hashKey = function(p1, p2) --[[ hashKey | Line: 45 | Upvalues: Digest (copy) ]]
		return Digest(p1 .. p2)
	end,
	decode = function(p1) --[[ decode | Line: 49 | Upvalues: Hash (copy), v1 (copy), LibDeflate (copy), Buffer (copy) ]]
		if typeof(p1) ~= "string" then
			return {}
		end

		local ok, result = pcall(Hash.base64_to_bin, p1)

		if not ok then
			v1:AtWarning():Log(("Failed to decode base64 data for exist counts: %*"):format(result), p1)

			return {}
		end

		local v12 = LibDeflate:DecompressDeflate(result)

		if not v12 then
			return {}
		end

		local v2 = Buffer.from(v12)
		local v3 = v2:readu32()
		local v4 = table.create(v3, 0)
		local sum = 0

		for i = 1, v3 do
			sum = sum + v2:readu32()
			v4[i] = sum
		end

		local t = {}

		for j = 1, v3 do
			t[v4[j]] = v2:readi64()
		end

		return t
	end
}