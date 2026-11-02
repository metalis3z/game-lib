-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local RunService = game:GetService("RunService")
local v1 = RunService:IsRunning() and time or os.clock

function t.HeartbeatLoopFor(p1, p2, p3) --[[ Line: 6 | Upvalues: v1 (copy), RunService (copy) ]]
	local v12 = nil
	local v2 = v1()
	local v3 = false

	v12 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 10 | Upvalues: v1 (ref), v2 (copy), p1 (copy), p2 (copy), v3 (ref), p3 (copy), v12 (ref) ]]
		local v13 = v1() - v2

		if v13 < p1 then
			p2(v13, p12, v13 / p1)

			return
		end

		if v3 == true or p3 == nil then
			if v12 ~= nil then
				v12:Disconnect()
				v12 = nil
			end
		else
			v3 = true
			p3()

			if v12 == nil then
				return
			end

			v12:Disconnect()
			v12 = nil
		end
	end)

	return v12
end
function t.AwaitHeartbeatLoopFor(p1, p2, p3) --[[ Line: 35 | Upvalues: v1 (copy), RunService (copy) ]]
	local v12 = nil
	local v2 = v1()
	local v3 = Instance.new("BindableEvent")
	local v4 = false

	v12 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 40 | Upvalues: v1 (ref), v2 (copy), p1 (copy), p2 (copy), v4 (ref), p3 (copy), v3 (copy), v12 (ref) ]]
		local v13 = v1() - v2

		if v13 < p1 then
			p2(v13, p12, v13 / p1)

			return
		end

		if v4 == true or p3 == nil then
			if v3 ~= nil then
				v3:Fire()
			end

			if v12 ~= nil then
				v12:Disconnect()
				v12 = nil
			end
		else
			v4 = true
			p3()

			if v3 ~= nil then
				v3:Fire()
			end

			if v12 == nil then
				return
			end

			v12:Disconnect()
			v12 = nil
		end
	end)
	v3.Event:Wait()
	v3:Destroy()
end

return t