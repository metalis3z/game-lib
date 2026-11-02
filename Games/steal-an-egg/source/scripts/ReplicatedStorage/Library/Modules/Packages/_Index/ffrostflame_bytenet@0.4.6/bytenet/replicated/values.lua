-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local replicatedValue = require(script.Parent.replicatedValue)
local v1 = if RunService:IsServer() then "server" else "client"
local v2 = nil
local t = {}

return {
	start = function() --[[ start | Line: 14 | Upvalues: v1 (copy), ReplicatedStorage (copy), v2 (ref) ]]
		if v1 == "server" then
			local BytenetStorage = Instance.new("Folder")

			BytenetStorage.Name = "BytenetStorage"
			BytenetStorage.Parent = ReplicatedStorage
			v2 = BytenetStorage

			return
		end

		if v1 ~= "client" then
			return
		end

		v2 = ReplicatedStorage:WaitForChild("BytenetStorage")
	end,
	access = function(p1) --[[ access | Line: 26 | Upvalues: t (copy), v1 (copy), v2 (ref), replicatedValue (copy) ]]
		if t[p1] then
			return t[p1]
		end

		if v1 == "client" then
			local v12 = v2:FindFirstChild(p1)

			if v12 and v12:IsA("StringValue") then
				local v22 = replicatedValue(v12)

				t[p1] = v22

				return v22
			end
		elseif v1 == "server" then
			local v3 = Instance.new("StringValue")

			v3.Name = p1
			v3.Parent = v2

			local v4 = replicatedValue(v3)

			t[p1] = v4

			return v4
		end

		return t[p1]
	end
}