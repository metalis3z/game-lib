
local PolicyService = game:GetService("PolicyService")
local Players = game:GetService("Players")
local t1 = {}
local t2 = {}
local t3 = {}

function t1.getPolicy(p1)
	while t2[p1] do
		task.wait()
	end

	local v7 = t3[p1]

	if v7 then
		return v7
	end

	t2[p1] = true

	local ok, result = xpcall(function()
		return PolicyService:GetPolicyInfoForPlayerAsync(p1)
	end, warn)
	local v10 = p1:IsDescendantOf(Players)

	if ok and v10 then
		t3[p1] = result
	end

	t2[p1] = nil

	if not v10 then
		return nil
	end

	return result
end

Players.PlayerRemoving:Connect(function(player)
	t3[player] = nil
end)

return t1
