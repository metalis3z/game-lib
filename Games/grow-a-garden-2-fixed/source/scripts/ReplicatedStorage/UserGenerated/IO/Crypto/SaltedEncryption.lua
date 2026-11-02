--credit to leon games studio
local AES = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES)
local Base64 = require(game.ReplicatedStorage.UserGenerated.IO.Base64)
local HMAC = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC)
local ISAAC = require(game.ReplicatedStorage.UserGenerated.Randoms.ISAAC)
local SHA256 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256)

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local v1 = ISAAC.Unique()

local function GetRandomBytes(p1) --[[ GetRandomBytes | Line: 44 | Upvalues: v1 (copy) ]]
	local v12 = buffer.create(p1)

	for i = 0, p1 - 1 do
		buffer.writeu8(v12, i, (v1:NextInteger(0, 255)))
	end

	return v12
end

local function PBKDF2(p1, p2, p3, p4, p5) --[[ PBKDF2 | Line: 62 | Upvalues: HMAC (copy) ]]
	local v1 = HMAC.Derive(p5, p1)
	local OutputSize = p5.OutputSize
	local v2 = math.ceil(p3 / OutputSize)
	local v3 = buffer.create(p3)
	local sum = 0

	for i = 1, v2 do
		local v4 = buffer.create(buffer.len(p2) + 4)

		buffer.copy(v4, 0, p2)

		local v5 = buffer.len(p2)

		buffer.writeu32(v4, v5, (bit32.byteswap(i)))

		local v7 = v1.DigestBuffer(v4)
		local v8 = buffer.create(buffer.len(v7))

		buffer.copy(v8, 0, v7)

		for j = 2, p4 do
			local v9 = v1.DigestBuffer(v7)

			v7 = v9

			for k = 0, buffer.len(v9) - 1 do
				buffer.writeu8(v8, k, (bit32.bxor(buffer.readu8(v8, k), (buffer.readu8(v9, k)))))
			end
		end

		local v13 = math.min(OutputSize, p3 - sum)

		buffer.copy(v3, sum, v8, 0, v13)
		sum = sum + v13
	end

	return v3
end

local function ApplyPKCS7Padding(p1) --[[ ApplyPKCS7Padding | Line: 115 ]]
	local v1 = buffer.len(p1)
	local v2 = 16 - v1 % 16
	local v3 = v1 + v2
	local v4 = buffer.create(v3)

	buffer.copy(v4, 0, p1)

	for i = v1, v3 - 1 do
		buffer.writeu8(v4, i, v2)
	end

	return v4
end

local function RemovePKCS7Padding(p1) --[[ RemovePKCS7Padding | Line: 137 ]]
	local v1 = buffer.len(p1)

	if v1 == 0 then
		error("Invalid padding: empty input")
	end

	local v2 = buffer.readu8(p1, v1 - 1)

	if v2 < 1 or v2 > 16 then
		error("Invalid padding length: " .. v2)
	end

	for i = v1 - v2, v1 - 1 do
		if buffer.readu8(p1, i) ~= v2 then
			error("Invalid padding")
		end
	end

	local v3 = v1 - v2
	local v4 = buffer.create(v3)

	buffer.copy(v4, 0, p1, 0, v3)

	return v4
end

local function Encrypt(p1, p2, p3) --[[ Encrypt | Line: 172 | Upvalues: SHA256 (copy), GetRandomBytes (copy), PBKDF2 (copy), ApplyPKCS7Padding (copy), AES (copy), Base64 (copy) ]]
	local v2 = buffer.fromstring(p1)
	local v3 = GetRandomBytes(8)
	local v4 = PBKDF2(p2, v3, 48, 10000, if p3 then p3 else SHA256)
	local v5 = buffer.create(32)

	buffer.copy(v5, 0, v4, 0, 32)

	local v6 = buffer.create(16)

	buffer.copy(v6, 0, v4, 32, 16)

	local v7 = ApplyPKCS7Padding(v2)
	local v8 = AES.new(buffer.tostring(v5), AES.modes.CBC, AES.pads.None):Encrypt(v7, nil, v6)
	local v10 = buffer.create(16 + buffer.len(v8))

	buffer.writestring(v10, 0, "Salted__")
	buffer.copy(v10, 8, v3)
	buffer.copy(v10, 16, v8)

	return buffer.tostring(Base64.EncodeBuffer(v10))
end

local function Decrypt(p1, p2, p3) --[[ Decrypt | Line: 226 | Upvalues: SHA256 (copy), Base64 (copy), PBKDF2 (copy), AES (copy), RemovePKCS7Padding (copy) ]]
	local v1 = if p3 then p3 else SHA256
	local v2 = Base64.DecodeBuffer(buffer.fromstring(p1))

	if buffer.len(v2) < 16 then
		error("Invalid data: too short")
	end

	local v3 = buffer.create(8)

	buffer.copy(v3, 0, v2, 0, 8)

	if buffer.tostring(v3) == "Salted__" then
		local v4, v5, v6, v7, v8, v9, v10

		v4 = buffer.create(8)
		buffer.copy(v4, 0, v2, 8, 8)
		v5 = buffer.len(v2) - 16
		v6 = buffer.create(v5)
		buffer.copy(v6, 0, v2, 16, v5)
		v7 = PBKDF2(p2, v4, 48, 10000, v1)
		v8 = buffer.create(32)
		buffer.copy(v8, 0, v7, 0, 32)
		v9 = buffer.create(16)
		buffer.copy(v9, 0, v7, 32, 16)
		v10 = RemovePKCS7Padding((AES.new(buffer.tostring(v8), AES.modes.CBC, AES.pads.None):Decrypt(v6, nil, v9)))

		return buffer.tostring(v10)
	end

	error("Invalid data: Missing \'Salted__\' header")
end

local t = {
	Encrypt = Encrypt,
	Decrypt = Decrypt,
	EncryptString = function(p1, p2, p3) --[[ EncryptString | Line: 287 | Upvalues: Encrypt (copy) ]]
		return Encrypt(p1, buffer.fromstring(p2), p3)
	end,
	DecryptString = function(p1, p2, p3) --[[ DecryptString | Line: 300 | Upvalues: Decrypt (copy) ]]
		return Decrypt(p1, buffer.fromstring(p2), p3)
	end,
	PBKDF2 = PBKDF2,
	GetRandomBytes = GetRandomBytes
}

table.freeze(t)

return t