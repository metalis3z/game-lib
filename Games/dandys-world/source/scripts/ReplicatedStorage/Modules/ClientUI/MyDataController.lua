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
-- CQMfBHRhc2sEd2FpdA53YWl0Rm9yUmVwbGljYQVzcGF3bg5vblJlcGxpY2FSZWFkeQxnZXRNeVJlcGxpY2EGdHlwZW9mBnN0cmluZwREYXRhAS4Fc3BsaXQFdGFibGUGcmVtb3ZlD2dldERhdGFGcm9tUGF0aARUYWdzBlBsYXllcg1QbGF5ZXJQcm9maWxlBkludm9rZQRnYW1lB1BsYXllcnMKR2V0U2VydmljZRFSZXBsaWNhdGVkU3RvcmFnZQdyZXF1aXJlB01vZHVsZXMIRXh0ZXJuYWwHTWFkd29yaxFSZXBsaWNhQ29udHJvbGxlcgtMb2NhbFBsYXllcglCaW5kYWJsZXMUUmVnaXN0ZXJSZXBsaWNhQ2xhc3MFZGVmZXIABwIBAQAAAAj7AQAAKwEEAKQBAgAABACAnwEBAUgA+v/7AQAAggECAAMDAQMCBAAEAIAADgMBGAAAAQAA/wMADwAAAAAHAwAAAAAJvAMA5QAAAACfAwICpAQDAAAIEIBSBQEAUgYDAJ8EAwGCAAEABAMDAwEDBAQACBCAABUFARgAAAABAAAAAAEWAAAAAAIBAQAAAAL7AQAAggECAAAAGgYBGAAAGwAAAAAHAgEAAAcEAAAFAgQDJvsCAAAOAgcAuywBA1IDAQCkAgEAAAAAQJ8CAgLwAgIAAgAAAIIAAQD7AgAATQICxgMAAABvBQQAvAMB4wUAAACfAwMCHAQDAA0EAgAGAACAggABABwEAwCMBQEAYAULAAQAAACkBAkAACBwgFIFAwCMBgEAnwQDAocCAgRHAgIAAAAAgIIAAQBIAPL/EwUDAIcEAgWCBAIACgMHBAAAAEADCAMJAwoDCwIAAAAAAAAAAAMMAw0EACBwgAAfDgEYAAAAAAAAAAAAAAEAAAEAAAABAAAAAQAAAAEAAAAAAAEAAP4EAAAgAAAAAAMBAgAAAAlNAQATAAAAAE0BAfkBAAAA+wIAAJoBAgACAAAA3gABAIIAAQACAw8DEAAvAAEYAAAAAAAAAAECMAAAAAAEAAMAAAAJ+wAAAG8CAADZAwAAEgIBABICAgC8AAA2AQAAAJ8ABAGCAAEAAgMRAxIBBC4AARgAAAAAAAAAAAUvAAAAAAkAAAECADmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCpAIGAAAAUEBNAwHoBwAAAE0DA+UIAAAATQMDDQkAAABNAwMGCgAAAJ8CAgJNAwAxCwAAAMYEAABNBQECDAAAAE0FBYcNAAAA/wYDAAAAAADZBwAAEgEE/zAHBuUOAAAAwAcPADAHBkcQAAAA2QcCABIBBP8wBwZJEQAAANkHAwASAQT/MAcG9xIAAACkBxUAAFAwgdkIBAASAAUAEgADABIBBP+fBwIBwQQAAIIGAgAWAxMEAAAAQAMUAxUDFgMXBAAAUEADGAMZAxoDGwMcAx0DHgMDBgEDBQMGAw4DAQMfBABQMIEFAAECAwUBAAEYAAAAAAAAAAEAAAAAAAIAAAAAAAAAAAAAAgABAQAAAAIABAAAAAcAAAUAAAAFAAAADwAAAAAAAAoAAQAAAAAGYzRzU14HdVeRRj5OXyvJexMsZCdR8BlS

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Modules.External.Madwork.ReplicaController)

local LocalPlayer = Players.LocalPlayer
local v1 = nil
local RegisterReplicaClass = ReplicatedStorage.Bindables.RegisterReplicaClass
local t = {
	waitForReplica = function(p1) --[[ waitForReplica | Line: 14 | Upvalues: v1 (ref) ]]
		while not v1 do
			task.wait()
		end

		return v1
	end,
	onReplicaReady = function(p1, p2, p3) --[[ onReplicaReady | Line: 21 ]]
		task.spawn(p2, (p1:waitForReplica()))
	end,
	getMyReplica = function(p1) --[[ getMyReplica | Line: 26 | Upvalues: v1 (ref) ]]
		return v1
	end,
	getDataFromPath = function(p1, p2) --[[ getDataFromPath | Line: 31 | Upvalues: v1 (ref) ]]
		if not v1 or typeof(p2) ~= "string" then
			return
		end

		local Data = v1.Data
		local v12 = p2:split(".")

		if #v12 == 0 then
			return
		end

		repeat
			if not (#v12 > 1) then
				return Data[v12[1]]
			end

			Data = Data[table.remove(v12, 1)]
		until Data == nil
	end
}

task.defer(function() --[[ Line: 46 | Upvalues: RegisterReplicaClass (copy), LocalPlayer (copy), v1 (ref) ]]
	RegisterReplicaClass:Invoke("PlayerProfile", function(p1) --[[ Line: 47 | Upvalues: LocalPlayer (ref), v1 (ref) ]]
		if p1.Tags.Player ~= LocalPlayer then
			return
		end

		v1 = p1
	end)
end)

return t