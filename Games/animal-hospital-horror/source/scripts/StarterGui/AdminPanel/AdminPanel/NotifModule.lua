
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagesService = require(ReplicatedStorage.Modules.ServicesLoader.MessagesService)
local Notif = script.Parent:FindFirstChild("Notif")
local v1

if not Notif then
	v1 = {}

	return function(p13, p23) --[[ Line: 36 | Upvalues: v1 (copy), MessagesService (copy) ]]
		if type(p13) ~= "string" or p13 == "" then
			return
		end

		local v12 = os.clock()
		local v2 = v1[p13]

		if v2 and v12 - v2 < 0.15 then
			return
		end

		v1[p13] = v12
		MessagesService:PlayMessage(p13, if p23 == false then "Error" else "Success")
	end
end

Notif:Destroy()
v1 = {}

return function(p13, p23) --[[ Line: 36 | Upvalues: v1 (copy), MessagesService (copy) ]]
	if type(p13) ~= "string" or p13 == "" then
		return
	end

	local v12 = os.clock()
	local v2 = v1[p13]

	if v2 and v12 - v2 < 0.15 then
		return
	end

	v1[p13] = v12
	MessagesService:PlayMessage(p13, if p23 == false then "Error" else "Success")
end