--credit to prince games studio
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local function Derive(p1, p2) --[[ Derive | Line: 46 ]]
	local BlockSize = p1.BlockSize
	local v1 = if BlockSize < buffer.len(p2) then p1.DigestBuffer(p2) else p2
	local v3 = buffer.create(BlockSize)

	buffer.copy(v3, 0, v1)

	local v4 = buffer.create(BlockSize)
	local v5 = buffer.create(BlockSize)

	for i = 0, BlockSize - 1 do
		local v6 = buffer.readu8(v3, i)

		buffer.writeu8(v4, i, (bit32.bxor(v6, 92)))
		buffer.writeu8(v5, i, (bit32.bxor(v6, 54)))
	end

	local function ComputeHmac(p12) --[[ ComputeHmac | Line: 72 | Upvalues: BlockSize (copy), v5 (copy), p1 (copy), v4 (copy) ]]
		local v1 = buffer.create(BlockSize + buffer.len(p12))

		buffer.copy(v1, 0, v5)
		buffer.copy(v1, BlockSize, p12)

		local v2 = p1.DigestBuffer(v1)
		local v3 = buffer.create(BlockSize + buffer.len(v2))

		buffer.copy(v3, 0, v4)
		buffer.copy(v3, BlockSize, v2)

		return p1.DigestBuffer(v3)
	end

	return {
		Name = "HMAC-" .. p1.Name,
		BlockSize = p1.BlockSize,
		OutputSize = p1.OutputSize,
		Digest = function(p1) --[[ Digest | Line: 92 | Upvalues: ComputeHmac (copy) ]]
			return buffer.tostring(ComputeHmac(buffer.fromstring(p1)))
		end,
		DigestBuffer = ComputeHmac,
		DigestToBuffer = function(p1) --[[ DigestToBuffer | Line: 96 | Upvalues: ComputeHmac (copy) ]]
			return ComputeHmac(buffer.fromstring(p1))
		end
	}
end

return {
	Derive = Derive,
	DeriveString = function(p1, p2) --[[ DeriveString | Line: 111 | Upvalues: Derive (copy) ]]
		return Derive(p1, buffer.fromstring(p2))
	end
}