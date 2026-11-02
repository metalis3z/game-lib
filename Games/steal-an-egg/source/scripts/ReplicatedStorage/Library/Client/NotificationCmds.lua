-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local NotificationInstance = require(script.NotificationInstance)
local Network = require(game.ReplicatedStorage.Library.Client.Network)
local Types = require(game.ReplicatedStorage.Library.Items.Types)
local v1 = setmetatable({
	Message = require(script.Message),
	Item = require(script.Item)
}, {
	__index = NotificationInstance
})

for k, v in pairs(v1) do
	if not v.Top then
		function v.Top() --[[ Top | Line: 20 ]]
			error("Unimplemented")
		end
	end

	if not v.Bottom then
		function v.Bottom() --[[ Bottom | Line: 25 ]]
			error("Unimplemented")
		end
	end
end

local function processNotificationData(p1) --[[ processNotificationData | Line: 30 | Upvalues: Types (copy) ]]
	if p1 and (p1.Data and p1.Path) then
		local function v1(p1, p2) --[[ processData | Line: 35 | Upvalues: Types (ref), v1 (copy) ]]
			local t2 = {}

			for k2, v in pairs(p1) do
				if type(v) == "table" and (p2 and p2[k2] == true) then
					t2[k2] = Types.From(v.class, v.data)

					continue
				end

				if type(v) == "table" then
					t2[k2] = v1(v, if p2 then p2[k2] else p2)

					continue
				end

				t2[k2] = v
			end

			return t2
		end

		return v1(p1.Data, p1.Path)
	end

	return p1
end

Network.Fired(Network.NET_MAP.Notifications.SHOW):Connect(function(p1, p2, p3, p4) --[[ Line: 53 | Upvalues: v1 (copy), Types (copy) ]]
	assert(v1[p1], "NotificationModule does not contain notification type: " .. tostring(p1))

	if p2 == "Top" then
		local Top = v1[p1].Top
		local v3, v4

		if p3 and (p3.Data and p3.Path) then
			local function v5(p1, p2) --[[ processData | Line: 35 | Upvalues: Types (ref), v5 (copy) ]]
				local t2 = {}

				for k2, v in pairs(p1) do
					if type(v) == "table" and (p2 and p2[k2] == true) then
						t2[k2] = Types.From(v.class, v.data)

						continue
					end

					if type(v) == "table" then
						t2[k2] = v5(v, if p2 then p2[k2] else p2)

						continue
					end

					t2[k2] = v
				end

				return t2
			end

			v3, v4 = Top, v5(p3.Data, p3.Path)
		else
			v3 = Top
			v4 = p3
		end

		v3(v4, p4)
	else
		if p2 ~= "Bottom" then
			return
		end

		local Bottom = v1[p1].Bottom
		local v7, v8

		if p3 and (p3.Data and p3.Path) then
			local function v9(p1, p2) --[[ processData | Line: 35 | Upvalues: Types (ref), v9 (copy) ]]
				local t2 = {}

				for k2, v in pairs(p1) do
					if type(v) == "table" and (p2 and p2[k2] == true) then
						t2[k2] = Types.From(v.class, v.data)

						continue
					end

					if type(v) == "table" then
						t2[k2] = v9(v, if p2 then p2[k2] else p2)

						continue
					end

					t2[k2] = v
				end

				return t2
			end

			v7, v8 = Bottom, v9(p3.Data, p3.Path)
		else
			v7 = Bottom
			v8 = p3
		end

		v7(v8, p4)
	end
end)
function v1.IsTopShowing() --[[ IsTopShowing | Line: 68 | Upvalues: NotificationInstance (copy) ]]
	return NotificationInstance.HasCurrentTopNotification()
end

return v1