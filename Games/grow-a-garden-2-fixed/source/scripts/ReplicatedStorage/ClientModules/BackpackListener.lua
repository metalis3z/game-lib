--credit to prince games studio
local Players = game:GetService("Players")
local t = {}

local function disconnectBinding(p1) --[[ disconnectBinding | Line: 43 ]]
	if p1.Connection then
		p1.Connection:Disconnect()
		p1.Connection = nil
	end

	if not p1.BackpackChangedConn then
		return
	end

	p1.BackpackChangedConn:Disconnect()
	p1.BackpackChangedConn = nil
end

local function attach(p1, p2, p3) --[[ attach | Line: 54 ]]
	if p3.Connection then
		p3.Connection:Disconnect()
		p3.Connection = nil
	end

	local Backpack = p1:FindFirstChildOfClass("Backpack")

	if Backpack then
		p3.Connection = Backpack.ChildAdded:Connect(p2)
	end
end

local function bindBackpackChange(p1, p2, p3) --[[ bindBackpackChange | Line: 66 ]]
	p3.BackpackChangedConn = p1.ChildAdded:Connect(function(p13) --[[ Line: 69 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if not p13:IsA("Backpack") then
			return
		end

		local v3 = p3

		if v3.Connection then
			v3.Connection:Disconnect()
			v3.Connection = nil
		end

		local Backpack = p1:FindFirstChildOfClass("Backpack")

		if not Backpack then
			return
		end

		v3.Connection = Backpack.ChildAdded:Connect(p2)
	end)
end

local t2 = {
	bind = function(p1, p2) --[[ bind | Line: 78 | Upvalues: t (copy) ]]
		if not (p1 and p2) then
			return
		end

		local v1 = t[p1]

		if not v1 then
			v1 = {}
			t[p1] = v1
		end

		if v1[p2] then
			return
		end

		local t2 = {
			Connection = nil,
			BackpackChangedConn = nil
		}

		v1[p2] = t2

		if t2.Connection then
			t2.Connection:Disconnect()
			t2.Connection = nil
		end

		local Backpack = p1:FindFirstChildOfClass("Backpack")

		if Backpack then
			t2.Connection = Backpack.ChildAdded:Connect(p2)
		end

		t2.BackpackChangedConn = p1.ChildAdded:Connect(function(p13) --[[ Line: 69 | Upvalues: p1 (copy), p2 (copy), t2 (copy) ]]
			if not p13:IsA("Backpack") then
				return
			end

			local v3 = t2

			if v3.Connection then
				v3.Connection:Disconnect()
				v3.Connection = nil
			end

			local Backpack = p1:FindFirstChildOfClass("Backpack")

			if not Backpack then
				return
			end

			v3.Connection = Backpack.ChildAdded:Connect(p2)
		end)
	end,
	unbind = function(p1, p2) --[[ unbind | Line: 98 | Upvalues: t (copy) ]]
		local v1 = t[p1]

		if not v1 then
			return
		end

		local v2 = v1[p2]

		if not v2 then
			return
		end

		if v2.Connection then
			v2.Connection:Disconnect()
			v2.Connection = nil
		end

		if v2.BackpackChangedConn then
			v2.BackpackChangedConn:Disconnect()
			v2.BackpackChangedConn = nil
		end

		v1[p2] = nil

		if next(v1) ~= nil then
			return
		end

		t[p1] = nil
	end
}

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 110 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		if v3.Connection then
			v3.Connection:Disconnect()
			v3.Connection = nil
		end

		if v3.BackpackChangedConn then
			v3.BackpackChangedConn:Disconnect()
			v3.BackpackChangedConn = nil
		end
	end

	t[p1] = nil
end)

return t2