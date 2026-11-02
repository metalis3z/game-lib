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
-- CQMMCEluc3RhbmNlA25ldwZGb2xkZXIYRm9yYmlkZGVuVGVtcG9yYXJ5Rm9sZGVyBE5hbWUJd29ya3NwYWNlBlBhcmVudAxDb21tb24tUGFydHMkR2V0Rm9yYmlkZGVuVGVtcG9yYXJ5V29ya3NwYWNlRm9sZGVyFkZvcmJpZGRlblN0b3JhZ2VGb2xkZXIZR2V0Rm9yYmlkZGVuV1NQYXJ0c0ZvbGRlchlHZXRGb3JiaWRkZW5TdG9yYWdlRm9sZGVyAAQCAAEAAAAV+wAAAEcAAwAAAAAA+wAAAIIAAgCkAAIAAAQAgG8BAwCfAAIC3gAAAPsAAABvAQQAMAEAugUAAAD7AAAApAEHAAAAYEAwAQAkCAAAAPsAAACCAAIACQMBAwIEAAQAgAMDAwQDBQMGBAAAYEADBwAOAAEYAAAAAAACAAAAAAEAAAABAAAAAAIAEAAAAAACAAEAAAAPpAACAAAEAIBvAQMAnwACAm8BBAAwAQC6BQAAAPsBAABNAQEOBgAAAJ8BAQIwAQAkBwAAAMYBAACCAQIACAMBAwIEAAQAgAMDAwgDBQMJAwcAGgABGAAAAAABAAABAAAAAAACAB4AAAAAAgABAAAAFfsAAABHAAMAAAAAAPsAAACCAAIApAACAAAEAIBvAQMAnwACAt4AAAD7AAAAbwEEADABALoFAAAA+wAAAKQBBwAAAGBAMAEAJAgAAAD7AAAAggACAAkDAQMCBAAEAIADAwMKAwUDBgQAAGBAAwcAJgABGAAAAAAAAgAAAAABAAAAAQAAAAACACcAAAAABAAAAQIAE6MAAAD/AAMAAAAAAMYBAADZAgAAEgEB/zACAA4AAAAAwAIBABIAAAAwAgACAgAAAMYCAADZAwIAEgEC/zADAPcDAAAAwQEAAIIAAgAEAwkGAQMLAwwDAAECAQABGAAKAAIBAAAADAAAAAsBAAAACgABAAAAAAOt2f5z+zOhzZDruikXEIQp3cHpB58dlHI=

-- https://lua.expert/
local t = {}
local v1 = nil

function t.GetForbiddenTemporaryWorkspaceFolder() --[[ Line: 14 | Upvalues: v1 (ref) ]]
	if v1 == nil then
		v1 = Instance.new("Folder")
		v1.Name = "ForbiddenTemporaryFolder"
		v1.Parent = workspace
	end

	return v1
end
function t.GetForbiddenWSPartsFolder() --[[ Line: 26 | Upvalues: t (copy) ]]
	local v1 = Instance.new("Folder")

	v1.Name = "Common-Parts"
	v1.Parent = t.GetForbiddenTemporaryWorkspaceFolder()

	return nil
end

local v2 = nil

function t.GetForbiddenStorageFolder() --[[ Line: 38 | Upvalues: v2 (ref) ]]
	if v2 == nil then
		v2 = Instance.new("Folder")
		v2.Name = "ForbiddenStorageFolder"
		v2.Parent = workspace
	end

	return v2
end

return t