

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Utils = require(script.Parent.Utils)
local v4 = RunService:IsServer()
local v5 = RunService:IsClient()
local Folder = nil

if not Utils.ShouldMock then
	if v4 then
		Folder = script.Parent.Parent:FindFirstChild("Remotes")
		if not Folder then
			Folder = Instance.new("Folder")
			Folder.Name = "Remotes"
			Folder.Parent = script.Parent.Parent
		end
	else
		Folder = assert(script.Parent.Parent:WaitForChild("Remotes", 60), "Did you forget to require the Replion module on the server?")
	end
end

local function get(s1: string)
	local v9 = if not RunService:IsClient() then Folder:FindFirstChild(s1) else Folder:WaitForChild(s1, 60)

	if v9 then
		return v9
	end

	if v5 then
		error("Did you forget to require the Replion module on the server?")
	end

	local RemoteEvent = Instance.new("RemoteEvent")

	RemoteEvent.Name = s1
	RemoteEvent.Parent = Folder

	return RemoteEvent
end

return (table.freeze({
	get = get,
	create = function(t1: {[any]: any})
		for _, v13 in t1 do
			get(v13)
		end
	end,
	sendTo = function(p1, s2: string, ...)
		if Utils.ShouldMock then
			return
		end

		local v16 = get(s2)

		if p1 == "All" then
			v16:FireAllClients(...)

			return
		end

		if type(p1) == "table" then
			for _, v18 in p1 do
				if v18:IsDescendantOf(Players) then
					v16:FireClient(v18, ...)
				end
			end

			return
		end

		if typeof(p1) == "Instance" and p1:IsA("Player") then
			v16:FireClient(p1, ...)

			return
		end

		error("Invalid replicateTo!")
	end
}))
