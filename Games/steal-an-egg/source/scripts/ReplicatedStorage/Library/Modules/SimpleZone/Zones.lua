-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local _ = script.Parent
local t = {
	TotalZoneVolume = 0,
	ActiveZones = {}
}

function t.registerZone(p1, p2) --[[ registerZone | Line: 15 | Upvalues: t (copy) ]]
	t.ActiveZones[p1] = p2
end
function t.deregisterZone(p1) --[[ deregisterZone | Line: 19 | Upvalues: t (copy) ]]
	t.ActiveZones[p1] = nil
end
RunService.PostSimulation:Connect(function(p1) --[[ Line: 23 | Upvalues: t (copy) ]]
	for v3, v4 in t.ActiveZones do
		local v1, v2
		local QueryOptions = v4.QueryOptions
		local v5, v6, v7

		if QueryOptions.ThrottlingEnabled then
			local v8 = os.clock()

			if not (v8 - v3._lastUpdate < QueryOptions.UpdateInterval) then
				v3._lastUpdate = v8
				v1 = if QueryOptions.FireMode == "OnEnter" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false
				v2 = if QueryOptions.FireMode == "OnExit" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false

				if QueryOptions.InSeperateQuerySpace then
					v5 = v3._worldModel
					v6 = v3._querySpace.dynamic
					v7 = table.create(#v6.replicas)

					for v9, v10 in v6.index do
						v7[v9] = v10.CFrame
					end

					v5:BulkMoveTo(v6.replicas, v7, Enum.BulkMoveMode.FireCFrameChanged)
				end

				v3:Update(v4.QueryParams, v1, v2)
			end
		else
			v1 = if QueryOptions.FireMode == "OnEnter" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false
			v2 = if QueryOptions.FireMode == "OnExit" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false

			if QueryOptions.InSeperateQuerySpace then
				v5 = v3._worldModel
				v6 = v3._querySpace.dynamic
				v7 = table.create(#v6.replicas)

				for v9, v10 in v6.index do
					v7[v9] = v10.CFrame
				end

				v5:BulkMoveTo(v6.replicas, v7, Enum.BulkMoveMode.FireCFrameChanged)
			end

			v3:Update(v4.QueryParams, v1, v2)
		end
	end
end)

return t