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
-- CQMGBnR5cGVvZgxnZXRtZXRhdGFibGUEdHlwZQV0YWJsZQVjbG9uZQttZXJnZVRhYmxlcwACCwIAAAAALVICAQDGAwAAxgQAAGQCJgCHCAAFuywIAqQHAQAAAABAnwcCArssBgNSCQYApAgBAAAAAECfCAICmgcNAAgAAACHBwAFuzwAA1IKAACkCQMAAAAgQJ8JAgIrCQIA/wkAAAAAAACHCAkFmgcPAAgAAAC7KAYDUggGAKQHBQAAAEBAnwcCAvAHBwAGAACApAcIAAAcYIBSCAYAnwcCAmoHAAVlAAEAagYABW4C2f8CAAAAggACAAkDAQQAAABAAwIEAAAgQAMDBAAAQEADBAMFBAAcYIAABAYBGAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAFAAAAAAAAAQAAAAAAAvYADgUAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAADEgEAAAAAAQrmmdzcAhGBflPtIoAMVNN6/o6oOCLz3Q==

-- https://lua.expert/
return function(p1, p2) --[[ mergeTables | Line: 4 ]]
	for v1, v2 in p2 do
		if typeof(p1[v1]) == typeof(v2) then
			if p1[v1] == (getmetatable(p1) or {})[v1] then
				if type(v2) == "table" then
					p1[v1] = table.clone(v2)

					continue
				end

				p1[v1] = v2
			end
		else
			if type(v2) == "table" then
				p1[v1] = table.clone(v2)

				continue
			end

			p1[v1] = v2
		end
	end

	return p1
end