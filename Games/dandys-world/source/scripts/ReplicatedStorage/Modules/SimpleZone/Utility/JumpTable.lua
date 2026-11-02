--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMBAV8AAwQBAQEAAA2jAQAA+wIAAIcBAgArAQMA+wIAAE0BAn4AAAAAKwEBAIIAAQBSAgEA3QMAAJ8CAACCAgAAAQMBAAIAARgAAQAAAAAAAQACAAAAAgAAAAACAQAAAAYDAAAFAQQD2QEAABIAAACCAQIAAAEAAQABGAAAAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAQEBAQABGAAAAAEAAAAAAg==

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	return function(p12, ...) --[[ Line: 2 | Upvalues: p1 (copy) ]]
		local v1 = p1[p12] or p1._

		if v1 then
			return v1(...)
		end
	end
end