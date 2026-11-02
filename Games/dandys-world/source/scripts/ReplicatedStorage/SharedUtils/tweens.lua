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
-- CQMPBkNyZWF0ZQRQbGF5CXBsYXlUd2VlbghSb3RhdGlvbgR0YXNrBHdhaXQEVGltZQdEZXN0cm95DHJvdGF0aW9uTG9vcAZQYXJlbnQFc3Bhd24OaW5maW5pdGVSb3RhdGUEZ2FtZQxUd2VlblNlcnZpY2UKR2V0U2VydmljZQAFCQQBAAAAC/sEAABSBgEAUgcCAFIIAwC8BASWAAAAAJ8EBQK8BQTuAQAAAJ8FAgGCBAIAAgMBAwIACQMBGAAAAAAAAAABAAACDAAAAAAFAAQAAAAb+wAAAIwBTP8wAQA4AAAAAPsAAgD7AgAA+wMDAOIEAgC8AACWAwAAAJ8ABQLeAAEA+wABALwAAO4EAAAAnwACAaQABwAAGFCA+wEDAE0BAUoIAAAAnwACAfsAAQC8AABQCQAAAJ8AAgGCAAEACgMEAgAAAAAAgGZACAEAAQAAAAMBAwIDBQMGBAAYUIADBwMIABgJARgAAAAAAQAAAAAAAAABAAAAAQAAAAAAAQAAAAEZAAAAAAMAAwAAABDGAAAA2QEAABICAAASAQD/EgIBABICAgD7AgAATQICJAAAAABHAgQAAAAAAFICAQCfAgEBSAD4/8EAAACCAAEAAQMKAQEUAAEYAAIAAAAACAAAAAABAP8EABYAAAAABQMBAAAACKQDAgAABACA2QQAABIAAQASAgAAEgACAJ8DAgGCAAEAAwMFAwsEAAQAgAECEgwBGAAAAAAAAAASFAAAAAADAAABAgASowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BAgAAAAAAwAIEABIAAAAwAgFABQAAAMACBgASAAAAMAIBUgcAAACCAQIACAMNBAAAAEADDgMPBgADAwYDAwwCAAMBAAEYAAQAAAAAAAIAAgAAAAkAAAAXAQAAAAAEJxtwyaG6E1MprTc2mixsqVcDZ70V3xrI

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

return {
	playTween = function(p1, p2, p3, p4) --[[ playTween | Line: 9 | Upvalues: TweenService (copy) ]]
		local v1 = TweenService:Create(p2, p3, p4)

		v1:Play()

		return v1
	end,
	infiniteRotate = function(p1, p2, p3) --[[ infiniteRotate | Line: 18 | Upvalues: TweenService (copy) ]]
		task.spawn(function() --[[ Line: 20 | Upvalues: p2 (copy), TweenService (ref), p3 (copy) ]]
			local v1 = nil

			local function rotationLoop() --[[ rotationLoop | Line: 24 | Upvalues: p2 (ref), v1 (ref), TweenService (ref), p3 (ref) ]]
				p2.Rotation = -180
				v1 = TweenService:Create(p2, p3, {
					Rotation = 180
				})
				v1:Play()
				task.wait(p3.Time)
				v1:Destroy()
			end

			while p2.Parent ~= nil do
				rotationLoop()
			end
		end)
	end
}