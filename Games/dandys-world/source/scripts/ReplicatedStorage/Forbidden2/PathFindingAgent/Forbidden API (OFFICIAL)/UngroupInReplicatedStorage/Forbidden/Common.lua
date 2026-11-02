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
-- CQMLB3JlcXVpcmUGc2NyaXB0B1N0b3JhZ2UIVHlwZUhlbHAZR2V0Rm9yYmlkZGVuU3RvcmFnZUZvbGRlciRHZXRGb3JiaWRkZW5UZW1wb3JhcnlXb3Jrc3BhY2VGb2xkZXIZR2V0Rm9yYmlkZGVuV1NQYXJ0c0ZvbGRlcgtHZXRCYXNlUGFydBpHZXREaXN0YW5jZUZyb21OUENUb1RhcmdldBZUcmlnZ2VyQ2xlYW51cFR5cGVIZWxwDlRyaWdnZXJDbGVhbnVwAAEEAAABAgApowAAAKQAAQAAAABApAEDAAAAIEBNAQGKBAAAAJ8AAgKkAQEAAAAAQKQCAwAAACBATQIC6AUAAACfAQIC4gIMAE0DAPcGAAAAMAMC9wYAAABNAwAOBwAAADADAg4HAAAATQMAAggAAAAwAwICCAAAAE0DAU4JAAAAMAMCTgkAAABNAwGTCgAAADADApMKAAAATQMBfw0AAAAwAwK7CwAAAIICAgAOAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgDCQMKBQYGBwgJCgsDCwABAAEYAAAAAAAAAAABAAAAAAAAAgEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAABAAAAAAAMjzkMRjPsTj5XaQ8cay1RfJcueD5LUw0=

-- https://lua.expert/
local Storage = require(script.Storage)
local TypeHelp = require(script.TypeHelp)

return {
	GetForbiddenStorageFolder = Storage.GetForbiddenStorageFolder,
	GetForbiddenTemporaryWorkspaceFolder = Storage.GetForbiddenTemporaryWorkspaceFolder,
	GetForbiddenWSPartsFolder = Storage.GetForbiddenWSPartsFolder,
	GetBasePart = TypeHelp.GetBasePart,
	GetDistanceFromNPCToTarget = TypeHelp.GetDistanceFromNPCToTarget,
	TriggerCleanupTypeHelp = TypeHelp.TriggerCleanup
}