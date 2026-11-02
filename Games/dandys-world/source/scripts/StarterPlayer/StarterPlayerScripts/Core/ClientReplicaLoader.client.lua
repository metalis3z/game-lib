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
-- CQMVFVJlcGxpY2FPZkNsYXNzQ3JlYXRlZAV0YWJsZQZpbnNlcnQEdGFzawR3YWl0C1JlcXVlc3REYXRhBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlB01vZHVsZXMIRXh0ZXJuYWwHTWFkd29yaxFSZXBsaWNhQ29udHJvbGxlcghDbGllbnRVSRBNeURhdGFDb250cm9sbGVyCUJpbmRhYmxlcxRSZWdpc3RlclJlcGxpY2FDbGFzcw1QbGF5ZXJQcm9maWxlCE9uSW52b2tlBWRlZmVyAAMFAgIAAAAO+wIAAE0CAhwAAAAAUgMAAFIEAQCfAgMB+wMBAJ40AwQAAAAAUgQAAKQCAwAACBCAnwIDAYIAAQAEAwEDAgMDBAAIEIAADQABGAAAAAAAAAEAAAAAAAABDgAAAAADAAMAAAAP+wEAABwAAQD7AgEAHAECAGAABQABAAAApAACAAAEAICfAAEBSAD2//sAAgBNAACmAwAAAJ8AAQGCAAEABAMEAwUEAAQAgAMGABIAARgAAAAAAAABAAD/AwAAAAETAAAAAAgAAAECADOjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgDoBgAAAE0CAuUHAAAATQICDQgAAABNAgIGCQAAAJ8BAgKkAgUAAABAQE0DAOgGAAAATQMDhgoAAABNAwPVCwAAAJ8CAgJNAwACDAAAAE0DA4cNAAAA/wQAAAEAAABvBQ4AxQQFAgEAAAD/BQAAAAAAAMAGDwASAAEAEgAFADAGA/wQAAAApAYTAABIEIHABxQAEgAFABIABAASAAEAnwYCAYIAAQAVAwcEAAAAQAMIAwkDCgQAAEBAAwsDDAMNAw4DDwMQAxEDEgMTBgADFAMEAxUEAEgQgQYBAgABAQABGAAAAAAAAAACAAAAAAAAAAAAAAEAAAAAAAAAAAIAAAACAAEAAAIAAgAAAAAFAAAAAAAABQEAAAAAAgrjFpU47YEOaHktiiQDhal6+wHhOCd8lA==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicaController = require(ReplicatedStorage.Modules.External.Madwork.ReplicaController)

require(ReplicatedStorage.Modules.ClientUI.MyDataController)

local t = { "PlayerProfile" }
local t2 = {}

function ReplicatedStorage.Bindables.RegisterReplicaClass.OnInvoke(p1, p2) --[[ Line: 13 | Upvalues: ReplicaController (copy), t2 (copy) ]]
	ReplicaController.ReplicaOfClassCreated(p1, p2)
	table.insert(t2, p1)
end
task.defer(function() --[[ Line: 18 | Upvalues: t2 (copy), t (copy), ReplicaController (copy) ]]
	while #t2 < #t do
		task.wait()
	end

	ReplicaController.RequestData()
end)