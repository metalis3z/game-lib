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
-- CQMEAAdfTWlycm9yAl9TB2ZvclNsb3QAAgQBAAAAAAwNAAMAAAAAgG8BAQCCAQIADQADAAIAAIBvAQMAggECAG8CBABSAwAAcwECA4IBAgAFAgAAAAAAAPA/AwECAAAAAAAAAEADAgMDABYEARgAAAAAAQAAAAEAAAAXAAAAAAIAAAECAAejAAAA/wABAAAAAADAAQAAMAEAhwEAAACCAAIAAgYAAwQBAAEAARgAEwACAAAGAQAAAAAB

-- https://lua.expert/
return {
	forSlot = function(p1) --[[ forSlot | Line: 22 ]]
		if p1 == 1 then
			return ""
		end

		if p1 == 2 then
			return "_Mirror"
		end

		return "_S" .. p1
	end
}