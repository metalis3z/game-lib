-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")

function t.CustomForLoop(p1, p2) --[[ CustomForLoop | Line: 4 | Upvalues: TweenService (copy) ]]
	if not (p1.CurrentWaitTime >= p1.WaitTime) then
		return
	end

	p1.CurrentWaitTime = p1.CurrentWaitTime - p1.WaitTime

	if not p1.Function then
		return
	end

	local v3 = tonumber(string.format("%.3f", math.floor(p1.CurrentTime * p1.End / p1.Step) * p1.Step))

	task.spawn(function() --[[ Line: 11 | Upvalues: p1 (copy), TweenService (ref), v3 (copy) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime, v3) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end
function t.CustomForceForLoop(p1, p2) --[[ CustomForceForLoop | Line: 26 | Upvalues: TweenService (copy) ]]
	if not (p1.CurrentWaitTime >= p1.WaitTime) then
		return
	end

	p1.CurrentWaitTime = p1.CurrentWaitTime - p1.WaitTime

	local v3 = tonumber(string.format("%.3f", math.floor(p1.CurrentTime * p1.End / p1.Step) * p1.Step))
	local v4

	if p1.Step < v3 then
		v4 = v3

		for i = p1.Start, v3, p1.Step do
			local v5 = tonumber(string.format("%.3f", i))

			if v5 ~= v3 and (p1.Step <= i and (v5 > 0 and not p1.StepData[v5])) then
				p1.StepData[v5] = true

				local v6 = i / p1.End

				if p1.Function then
					task.spawn(function() --[[ Line: 43 | Upvalues: v6 (copy), p1 (copy), TweenService (ref), v5 (copy) ]]
						local v1 = v6

						if p1.Tween then
							v1 = TweenService:GetValue(v1, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
						end

						if not p1.Function or (not p1.Function(v1, v5) or p1.Finished) then
							return
						end

						p1:Destroy()
					end)
				end
			end
		end
	else
		v4 = v3
	end

	if p1.StepData then
		if p1.StepData[v4] then
			return
		end

		p1.StepData[v4] = true
	end

	local v7 = v4

	if not p1.Function then
		return
	end

	task.spawn(function() --[[ Line: 72 | Upvalues: p1 (copy), TweenService (ref), v7 (copy) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime, v7) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end
function t.ForLoop(p1) --[[ ForLoop | Line: 91 | Upvalues: TweenService (copy) ]]
	if not (p1.CurrentWaitTime >= p1.WaitTime) then
		return
	end

	p1.CurrentWaitTime = p1.CurrentWaitTime - p1.WaitTime

	if not p1.Function then
		return
	end

	task.spawn(function() --[[ Line: 95 | Upvalues: p1 (copy), TweenService (ref) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end
function t.ForceForLoop(p1, p2) --[[ ForceForLoop | Line: 110 | Upvalues: TweenService (copy) ]]
	if not (p1.CurrentWaitTime >= p1.WaitTime) then
		return
	end

	p1.CurrentWaitTime = p1.CurrentWaitTime - p1.WaitTime

	local v2 = math.floor(p1.CurrentTime * p1.Step)

	if v2 - 1 > 0 and p1.StepData then
		for i = 1, v2 - 1 do
			if not p1.StepData[i] then
				p1.StepData[i] = true

				local v3 = i / p1.Step + p2 / p1.Step

				if p1.Function then
					task.spawn(function() --[[ Line: 120 | Upvalues: v3 (copy), p1 (copy), TweenService (ref) ]]
						local v1 = v3

						if p1.Tween then
							v1 = TweenService:GetValue(v1, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
						end

						if not p1.Function or (not p1.Function(v1) or p1.Finished) then
							return
						end

						p1:Destroy()
					end)
				end
			end
		end
	end

	if p1.StepData then
		p1.StepData[v2] = true
	end

	if not p1.Function then
		return
	end

	task.spawn(function() --[[ Line: 144 | Upvalues: p1 (copy), TweenService (ref) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end
function t.Heartbeat(p1, p2) --[[ Heartbeat | Line: 159 | Upvalues: TweenService (copy) ]]
	if not p1.Function then
		return
	end

	task.spawn(function() --[[ Line: 161 | Upvalues: p1 (copy), TweenService (ref), p2 (copy) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime, p2) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end
function t.HeartbeatWait(p1, p2) --[[ HeartbeatWait | Line: 175 | Upvalues: TweenService (copy) ]]
	if not (p1.CurrentWaitTime >= p1.WaitTime) then
		return
	end

	p1.CurrentWaitTime = p1.CurrentWaitTime - p1.WaitTime

	if not p1.Function then
		return
	end

	task.spawn(function() --[[ Line: 179 | Upvalues: p1 (copy), TweenService (ref), p2 (copy) ]]
		local CurrentTime = p1.CurrentTime

		if p1.Tween then
			CurrentTime = TweenService:GetValue(CurrentTime, p1.Tween.EasingStyle or Enum.EasingStyle.Linear, p1.Tween.EasingDirection or Enum.EasingDirection.Out)
		end

		if not p1.Function or (not p1.Function(CurrentTime, p2) or p1.Finished) then
			return
		end

		p1:Destroy()
	end)
end

return t