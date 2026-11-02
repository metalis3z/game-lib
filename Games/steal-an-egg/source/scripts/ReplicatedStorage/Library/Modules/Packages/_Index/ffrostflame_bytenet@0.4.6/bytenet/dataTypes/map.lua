-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writeu16 = bufferWriter.writeu16

return function(p1, p2) --[[ Line: 7 | Upvalues: writeu16 (copy) ]]
	local write = p1.write
	local write2 = p2.write

	return {
		read = function(p12, p22) --[[ read | Line: 16 | Upvalues: p1 (copy), p2 (copy) ]]
			local v1 = p22 + 2
			local t = {}

			for i = 1, buffer.readu16(p12, p22) do
				local v2, v3 = p1.read(p12, v1)
				local v4 = v1 + v3
				local v5, v6 = p2.read(p12, v4)

				t[v2] = v5
				v1 = v4 + v6
			end

			return t, v1 - p22
		end,
		write = function(p1) --[[ write | Line: 38 | Upvalues: writeu16 (ref), write (copy), write2 (copy) ]]
			local count = 0

			for v1 in p1 do
				count = count + 1
			end

			writeu16(count)

			for v2, v3 in p1 do
				write(v2)
				write2(v3)
			end
		end
	}
end