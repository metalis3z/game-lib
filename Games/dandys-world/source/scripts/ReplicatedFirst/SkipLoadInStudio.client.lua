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
-- CQMZB0Rlc3Ryb3kGaXBhaXJzC0dldENoaWxkcmVuBnNjcmlwdAROYW1lDUxvYWRpbmdTY3JlZW4FcGNhbGwTcHVyZ2VMb2FkaW5nU2NyZWVucxpSZW1vdmVEZWZhdWx0TG9hZGluZ1NjcmVlbgJvcwVjbG9jawR0YXNrBHdhaXQEZ2FtZQpSdW5TZXJ2aWNlCkdldFNlcnZpY2UISXNTdHVkaW8HUGxheWVycw9SZXBsaWNhdGVkRmlyc3QLTG9jYWxQbGF5ZXIFcHJpbnRgW1NraXBMb2FkSW5TdHVkaW9dIFN0dWRpbyBkZXRlY3RlZCAtLSBzdXBwcmVzc2luZyBsb2FkaW5nIHNjcmVlbiAoZGV2IHRvb2wsIGluZXJ0IGluIHByb2R1Y3Rpb24pCVBsYXllckd1aQxXYWl0Rm9yQ2hpbGQFc3Bhd24ABQIAAQAAAAX7AAAAvAAAUAAAAACfAAIBggABAAEDAQAmAAEYAAAAAAAmAAAAAAgBAQAAABr7AQAAKwEBAIIAAQCkAQEAAAAAQLwCAGgCAAAAnwICAJ8BAARRAQ0ApAYEAAAAMEDxBQoABgAAAE0GBboFAAAA8AYGAAYAAICkBggAAABwQNkHAAASAAUAnwYCAW4B8v8CAACAggABAAkDAgQAAABAAwMDBAQAADBAAwUDBgMHBAAAcEABACIIARgAAAABAAAAAAAAAQAAAAAAAAABAAAAAP4ABSMAAAAAAgABAAAABfsAAAC8AADkAAAAAJ8AAgGCAAEAAQMJACsAARgAAAAAACsAAAAAAwADAAAAFaQBAwAACBCAnwEBApUAAQCkAQMAAAgQgJ8BAQJgAQwAAAAAAPsBAAArAQEAggABAPsBAQD7AgIAnwECAaQBBgAAFECAbwIHAJ8BAgFIAPD/ggABAAgCAAAAAAAAIEADCgMLBAAIEIADDAMNBAAUQIACmpmZmZmZuT8AMwABGAAAAAABAAAAAAEAAAEAAAEAAAD9BTQAAAAACgAAAQIAN6MAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwK8AQAKBAAAAJ8BAgIrAQEAggABAKQCAQAAAABAbwQFALwCAhYDAAAAnwIDAqQDAQAAAABAbwUGALwDAxYDAAAAnwMDAk0EAjEHAAAApAUJAAAAgEBvBgoAnwUCAcAFCwASAAEApAYNAAAAwEDABw4AEgADAJ8GAgFSBgUAUgcDAJ8GAgFvCA8AjAkFALwGBNMQAAAAnwYEAisGAQCCAAEApAcTAABIEIHACBQAEgABABIABQASAAYAnwcCAYIAAQAVAw4EAAAAQAMPAxADEQMSAxMDFAMVBAAAgEADFgYBAwcEAADAQAYCAxcDGAMMAxkEAEgQgQYDAwECAwEAARgAEAAAAAAABAAAAQEDAAAAAAABAAAAAAABAAIAAAAEAAkAAAAAAQAAAgAAAAABAAQAAAAAAAAIAQAAAAAE3MVaSM6gCqrMcKHoVvf13KzdTTzuATBJ

-- https://lua.expert/
local v1 = game:GetService("RunService"):IsStudio()

if not v1 then
	return
end

local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

print("[SkipLoadInStudio] Studio detected -- suppressing loading screen (dev tool, inert in production)")

local function purgeLoadingScreens(p1) --[[ purgeLoadingScreens | Line: 34 | Upvalues: v1 (copy) ]]
	if not v1 then
		return
	end

	for i, v in ipairs(p1:GetChildren()) do
		if v ~= script and v.Name == "LoadingScreen" then
			pcall(function() --[[ Line: 38 | Upvalues: v (copy) ]]
				v:Destroy()
			end)
		end
	end
end

pcall(function() --[[ Line: 43 | Upvalues: ReplicatedFirst (copy) ]]
	ReplicatedFirst:RemoveDefaultLoadingScreen()
end)
purgeLoadingScreens(ReplicatedFirst)

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)

if PlayerGui then
	task.spawn(function() --[[ Line: 51 | Upvalues: v1 (copy), purgeLoadingScreens (copy), PlayerGui (copy) ]]
		local v12 = os.clock() + 8

		while os.clock() < v12 do
			if not v1 then
				break
			end

			purgeLoadingScreens(PlayerGui)
			task.wait(0.1)
		end
	end)
end