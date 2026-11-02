-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)
local readRefs = require(script.Parent.Parent.process.readRefs)

require(script.Parent.Parent.types)

local writeReference = bufferWriter.writeReference
local alloc = bufferWriter.alloc

return function() --[[ Line: 8 | Upvalues: alloc (copy), writeReference (copy), readRefs (copy) ]]
	return {
		write = function(p1) --[[ write | Line: 10 | Upvalues: alloc (ref), writeReference (ref) ]]
			alloc(1)
			writeReference(p1)
		end,
		read = function(p1, p2) --[[ read | Line: 15 | Upvalues: readRefs (ref) ]]
			local v1 = readRefs.get()

			if not v1 then
				return nil, 1
			end

			local v2 = v1[buffer.readu8(p1, p2)]

			if typeof(v2) == "Instance" then
				return v2, 1
			end

			return nil, 1
		end
	}
end