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
-- CQM9CURhdGFTdG9yZQ5HZXRTb3J0ZWRBc3luYwVwY2FsbAVwcmludCdGYWlsZWQgdG8gcHVsbCBmcm9tIG9yZGVyZWQgZGF0YXN0b3JlOiAIdG9zdHJpbmcFX3B1bGwOR2V0Q3VycmVudFBhZ2UDa2V5CHRvbnVtYmVyBXZhbHVlBkZvbGRlcgZzdHJpbmcGZm9ybWF0BSVkLCVkDFNldEF0dHJpYnV0ZQMtLC0KX3JlcGxpY2F0ZQlEZXN0cm95ZWQEdGFzawR3YWl0BV9pbml0CFNldEFzeW5jBHdhcm45RmFpbGVkIHRvIHVwZGF0ZSBPcmRlcmVkRGF0YVN0b3JlIGZvciAlcyAoYXR0ZW1wdCAlZCk6ICVzA1NldAdEZXN0cm95E0dldE9yZGVyZWREYXRhU3RvcmUGdHlwZW9mKkdsb2JhbCBsZWFkZXJib2FyZCBtdXN0IHJlY2VpdmUgc3RyaW5nIGtleQZhc3NlcnQMc2V0bWV0YXRhYmxlIUZhaWxlZCB0byBsb2FkIGdsb2JhbCBkYXRhc3RvcmU6IAhJbnN0YW5jZQNuZXcETmFtZQZzY3JpcHQGUGFyZW50BXNwYXduDUdldEF0dHJpYnV0ZXMFcGFpcnMBLAVzcGxpdAV0YWJsZQZ1bnBhY2sFVmFsdWUYZmV0Y2hQbGF5ZXJOYW1lRnJvbUNhY2hlAy0tLQEtBFB1bGwxQ2xpZW50IEdsb2JhbCBsZWFkZXJib2FyZCBtdXN0IHJlY2VpdmUgc3RyaW5nIGtleQxXYWl0Rm9yQ2hpbGQhQ291bGQgbm90IGZpbmQgY2xpZW50IGZvbGRlciBmb3IgBGdhbWUQRGF0YVN0b3JlU2VydmljZQpHZXRTZXJ2aWNlClJ1blNlcnZpY2UHX19pbmRleAhJc1NlcnZlcgdyZXF1aXJlC1BsYXllckNhY2hlAA4EAAIAAAAO+wAAAE0AAFIAAAAADgAJAPsAAABNAABSAAAAAKkCAACMAwoAvAAAkQEAAACfAAQC3gABAIIAAQACAwEDAgANAAEYAAAAAAEAAAAAAAAAAAIOAAAAAAkBAAAAABXGAQAApAIBAAAAAEDZAwAAEgAAABIBAf+fAgIDDgIBACsBCgCkBAMAAAAgQG8GBAC7PwMDUggDAKQHBgAAAFBAnwcCAnMFBgefBAIBwQEAAIIB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

-- https://lua.expert/
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local t = {}

t.__index = t

if RunService:IsServer() then
	function t._pull(p1) --[[ _pull | Line: 11 ]]
		local v1 = nil
		local ok, result = pcall(function() --[[ Line: 13 | Upvalues: p1 (copy), v1 (ref) ]]
			if not p1.DataStore then
				return
			end

			v1 = p1.DataStore:GetSortedAsync(false, 10)
		end)

		if not (ok and v1) then
			print("Failed to pull from ordered datastore: " .. tostring(result))
		end

		return v1
	end
	function t._replicate(p1, p2) --[[ _replicate | Line: 24 ]]
		local v1 = p2:GetCurrentPage()

		for i = 1, 10 do
			local v2 = v1[i]

			if v2 then
				local v3 = tonumber(v2.key)

				p1.Folder:SetAttribute(tostring(i), string.format("%d,%d", v3, v2.value or 0))

				continue
			end

			p1.Folder:SetAttribute(tostring(i), "-,-")
		end
	end
	function t._init(p1) --[[ _init | Line: 39 ]]
		while not p1.Destroyed do
			task.wait(10)

			if p1.Destroyed then
				break
			end

			local v1 = p1:_pull()

			if v1 then
				p1:_replicate(v1)
			end

			task.wait(50)
		end
	end
	function t.Set(p1, p2, p3) --[[ Set | Line: 51 ]]
		local v1 = nil

		for i = 1, 3 do
			local ok, result = pcall(function() --[[ Line: 55 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
				p1.DataStore:SetAsync(p2, p3)
			end)

			if ok then
				return true
			end

			warn(("Failed to update OrderedDataStore for %s (attempt %d): %s"):format(p2, i, result))
			task.wait(1)
			v1 = ok
		end

		return v1
	end
	function t.Destroy(p1) --[[ Destroy | Line: 71 ]]
		p1.Destroyed = true
	end
	function t.new(p1) --[[ new | Line: 75 | Upvalues: t (copy), DataStoreService (copy) ]]
		assert(if p1 then if typeof(p1) == "string" then true else false else p1, "Global leaderboard must receive string key")

		local v3 = setmetatable({}, t)
		local ok, result = pcall(function() --[[ Line: 79 | Upvalues: DataStoreService (ref), p1 (copy) ]]
			return DataStoreService:GetOrderedDataStore(p1)
		end)

		if ok then
			v3.DataStore = result
			v3.Folder = Instance.new("Folder")
			v3.Folder.Name = p1
			v3.Folder.Parent = script
			v3.Destroyed = false
			task.spawn(v3._init, v3)

			return v3
		end

		print("Failed to load global datastore: " .. tostring(result))
	end
else
	local PlayerCache = require(script.Parent:WaitForChild("PlayerCache"))

	function t.Pull(p1) --[[ Pull | Line: 103 | Upvalues: PlayerCache (copy) ]]
		local t = {}

		for k, v in pairs((p1.Folder:GetAttributes())) do
			local v2 = tonumber(k)
			local v3, v4 = table.unpack(v:split(","))

			if tonumber(v3) and tonumber(v4) then
				t[v2] = {
					Name = PlayerCache.fetchPlayerNameFromCache((tonumber(v3))),
					Value = tonumber(v4)
				}

				continue
			end

			t[v2] = {
				Name = "---",
				Value = "-"
			}
		end

		return t
	end
	function t._init(p1) --[[ _init | Line: 125 ]] end
	function t.Destroy(p1) --[[ Destroy | Line: 129 ]]
		p1.Destroyed = true
	end
	function t.new(p1) --[[ new | Line: 133 | Upvalues: t (copy) ]]
		assert(if p1 then if typeof(p1) == "string" then true else false else p1, "Client Global leaderboard must receive string key")

		local v2 = script:WaitForChild(p1, 99)

		if v2 then
			local v4 = setmetatable({}, t)

			v4.Folder = v2
			v4.Destroyed = false
			task.spawn(v4._init, v4)

			return v4
		end

		print("Could not find client folder for " .. tostring(p1))
	end
end

return t