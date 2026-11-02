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
-- CQMQCVByb2R1Y3RJZAZzY3JpcHQETmFtZQhQbGF5ZXJJZBFHZXRQbGF5ZXJCeVVzZXJJZAVwcmludA1UcmlnZ2VyZWQgYnkgBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlB3JlcXVpcmUGQ29uZmlnDFdhaXRGb3JDaGlsZAxHZXRQcm9kdWN0SWQOR2V0UHJvZHVjdE5hbWUHVHJpZ2dlcgAEAQABAAAABPsAAABNAAALAAAAAIIAAgABAwEAEgABGAAAAAASAAAAAAEAAAAAAAWkAAEAAAAAQE0AALoCAAAAggACAAMDAgQAAABAAwMAEwABGAAAAAAAEwAAAAAGAQEAAAYDAAAFAQQO+wEAAE0DAGAAAAAAvAEBYQEAAACfAQMCpAIDAAAAIEBvBAQATQUBugUAAABzAwQFnwICAYIAAQAGAwQDBQMGBAAAIEADBwMDABUAARgAAAAAAAABAAAAAAAAAhcAAAAABgAAAQIAHqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQMAAAAAAKQCBQAAAEBApAMHAAAAYEBvBQgAvAMD0wkAAACfAwMAnwIAAsADCgASAAIAMAMB3wsAAADAAwwAMAMBZQ0AAADAAw4AEgAAADADAfQPAAAAggECABADCAQAAABAAwkDCgMLBAAAQEADAgQAAGBAAwwDDQYAAw4GAQMPBgIDEAMAAQIBAAEYAAEAAAAAAAMAAQAAAAAAAAAADAAAAAEAAAIAAAAIAQAAAAADsvoFUew2xP4BtZVA+FcGYMLiEiWAPm9Q

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local Config = require(script:WaitForChild("Config"))

function t.GetProductId() --[[ Line: 18 | Upvalues: Config (copy) ]]
	return Config.ProductId
end
function t.GetProductName() --[[ Line: 19 ]]
	return script.Name
end
function t.Trigger(p1) --[[ Line: 21 | Upvalues: Players (copy) ]]
	print("Triggered by " .. Players:GetPlayerByUserId(p1.PlayerId).Name)
end

return t