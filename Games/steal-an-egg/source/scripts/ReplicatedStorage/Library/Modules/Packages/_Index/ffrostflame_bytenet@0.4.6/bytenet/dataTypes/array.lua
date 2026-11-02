-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writeu16 = bufferWriter.writeu16

return function(p1) --[[ Line: 10 | Upvalues: writeu16 (copy) ]]
	local write = p1.write
	local read = p1.read

	return {
		read = function(p1, p2) --[[ read | Line: 15 | Upvalues: read (copy) ]]
			local v1 = buffer.readu16(p1, p2)
			local v2 = table.create(v1)
			local sum = p2 + 2

			for i = 1, v1 do
				local v3, v4 = read(p1, sum)

				v2[i] = v3
				sum = sum + v4
			end

			return v2, sum - p2
		end,
		write = function(p1) --[[ write | Line: 30 | Upvalues: writeu16 (ref), write (copy) ]]
			local v1 = #p1

			writeu16(v1)

			for i = 1, v1 do
				write(p1[i])
			end
		end
	}
end