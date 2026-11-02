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
-- CQMMBEVudW0XUHJvZHVjdFB1cmNoYXNlRGVjaXNpb24PTm90UHJvY2Vzc2VkWWV0CVByb2R1Y3RJZAZzY3JpcHQETmFtZQdyZXF1aXJlBkNvbmZpZwxXYWl0Rm9yQ2hpbGQHVHJpZ2dlcgxHZXRQcm9kdWN0SWQOR2V0UHJvZHVjdE5hbWUABAIBAAAABgMAAAUBBAOkAQMAAgQAwIIBAgAEAwEDAgMDBAIEAMAADwABGAAAABAAAAAAAQABAAAABPsAAABNAAALAAAAAIIAAgABAwQAEwABGAAAAAAUAAAAAAEAAAAAAAWkAAEAAAAAQE0AALoCAAAAggACAAMDBQQAAABAAwYAFwABGAAAAAAAGAAAAAAFAAABAgAXowAAAP8AAwAAAAAApAEBAAAAAECkAgMAAAAgQG8EBAC8AgLTBQAAAJ8CAwCfAQACwAIGADACAPQHAAAAwAIIABIAAQAwAgDfCQAAAMACCgAwAgBlCwAAAIIAAgAMAwcEAAAAQAMFBAAAIEADCAMJBgADCgYBAwsGAgMMAwABAgEAARgAAAACAAAAAAAAAAAMAAAEAAAABAAABQEAAAAAAzRmO1GKZoNagMWsQ8k5jddEfiwlBqJRUA==

-- https://lua.expert/
local t = {}
local Config = require(script:WaitForChild("Config"))

function t.Trigger(p1) --[[ Line: 15 ]]
	return Enum.ProductPurchaseDecision.NotProcessedYet
end
function t.GetProductId() --[[ Line: 19 | Upvalues: Config (copy) ]]
	return Config.ProductId
end
function t.GetProductName() --[[ Line: 23 ]]
	return script.Name
end

return t