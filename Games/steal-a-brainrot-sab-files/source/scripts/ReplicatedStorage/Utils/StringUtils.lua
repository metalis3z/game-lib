
return {
	ReadPath = function(_: {[any]: any}, p1, s1: string)
		if not s1 then
			return p1
		end

		local parts = string.split(s1, ".")

		for i = 1, #parts do
			if p1 == nil then
				return nil
			end

			p1 = p1:FindFirstChild(parts[i])
		end

		return p1
	end,
	hashStringEvenDistribution = function(s2: string, n1: number)
		local n2 = 0

		for i = 1, #s2 do
			local byte = string.byte(s2, i)

			n2 = (n2 * 31 + byte) % 4294967296
		end

		return n2 % n1 + 1
	end,
	ParseColor = function(s3: string)
		if type(s3) ~= "string" then
			return nil
		end

		local match = string.match(s3, "^%s*(.-)%s*$")
		local match2 = string.match(match, "^#?(%x+)$")

		if match2 then
			return Color3.fromHex(match2):ToHex()
		end

		local v14, v15, v16 = string.match(match, "^(%d+)%s*,%s*(%d+)%s*,%s*(%d+)$")

		if v14 then
			local num = tonumber(v14)
			local num2 = tonumber(v15)
			local num3 = tonumber(v16)

			if num <= 255 and num2 <= 255 and num3 <= 255 then
				return Color3.fromRGB(num, num2, num3):ToHex()
			end
		end

		return nil
	end
}
