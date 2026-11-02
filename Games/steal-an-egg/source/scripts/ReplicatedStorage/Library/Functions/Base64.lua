-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Encode = function(p1) --[[ Encode | Line: 5 ]]
		return (p1:gsub(".", function(p1) --[[ Line: 7 ]]
			local v1 = string.byte(p1)
			local v2 = ""

			for i = 8, 1, -1 do
				v2 = v2 .. (if v1 % 2 ^ i - v1 % 2 ^ (i - 1) > 0 then "1" else "0")
			end

			return v2
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(p1) --[[ Line: 14 ]]
			if #p1 < 6 then
				return ""
			end

			local sum = 0

			for i = 1, 6 do
				if p1:sub(i, i) == "1" then
					sum = sum + 2 ^ (6 - i)
				end
			end

			return ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(sum + 1, sum + 1)
		end) .. ({ "", "==", "=" })[#p1 % 3 + 1]
	end,
	Decode = function(p1) --[[ Decode | Line: 29 ]]
		return p1:gsub("[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", ""):gsub(".", function(p1) --[[ Line: 33 ]]
			if p1 == "=" then
				return ""
			end

			local v1 = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(p1) - 1
			local v2 = ""

			for i = 6, 1, -1 do
				v2 = v2 .. (if v1 % 2 ^ i - v1 % 2 ^ (i - 1) > 0 then "1" else "0")
			end

			return v2
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(p1) --[[ Line: 44 ]]
			if #p1 ~= 8 then
				return ""
			end

			local sum = 0

			for i = 1, 8 do
				if p1:sub(i, i) == "1" then
					sum = sum + 2 ^ (8 - i)
				end
			end

			return string.char(sum)
		end)
	end
}