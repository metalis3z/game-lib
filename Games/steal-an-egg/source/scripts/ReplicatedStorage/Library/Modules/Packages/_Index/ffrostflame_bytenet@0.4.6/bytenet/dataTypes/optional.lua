-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writebool = bufferWriter.writebool

return function(p1) --[[ Line: 6 | Upvalues: writebool (copy) ]]
	local read = p1.read
	local write = p1.write

	return {
		read = function(p1, p2) --[[ read | Line: 16 | Upvalues: read (copy) ]]
			if buffer.readu8(p1, p2) == 0 then
				return nil, 1
			end

			local v1, v2 = read(p1, p2 + 1)

			return v1, v2 + 1
		end,
		write = function(p1) --[[ write | Line: 27 | Upvalues: writebool (ref), write (copy) ]]
			local v1 = p1 ~= nil

			writebool(v1)

			if not v1 then
				return
			end

			write(p1)
		end
	}
end