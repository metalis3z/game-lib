-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local t = {}

return function(p1, p2, p3) --[[ Line: 5 | Upvalues: t (copy), TweenService (copy) ]]
	local v1 = t[p1]

	if v1 then
		v1:Cancel()
		v1:Destroy()
		task.cancel(v1.Thread)
		t[p1] = nil
		print("Cancel last Loop!", p1)
	end

	local v2 = Instance.new("NumberValue")

	v2.Value = p1:GetScale()

	local CFrameValue = Instance.new("CFrameValue")

	CFrameValue.Value = p1:GetPivot()

	local v3 = TweenService:Create(v2, p2, {
		Value = p3.Scale
	})
	local v4 = TweenService:Create(CFrameValue, p2, {
		Value = p3.CFrame
	})
	local v5 = nil

	v5 = {
		Instance = p1,
		Play = function() --[[ Play | Line: 26 | Upvalues: v3 (copy), v4 (copy), v5 (ref), p3 (copy), p1 (copy), v2 (copy), CFrameValue (copy) ]]
			v3:Play()
			v4:Play()
			task.spawn(function() --[[ Line: 29 | Upvalues: v5 (ref), v3 (ref), p3 (ref), p1 (ref), v2 (ref), CFrameValue (ref) ]]
				while true do
					task.wait(0.01)
					v5.PlaybackState = v3.PlaybackState

					if v3.PlaybackState ~= Enum.PlaybackState.Playing then
						break
					end

					if p3.Scale then
						p1:ScaleTo((math.clamp(v2.Value, 1e-9, (1 / 0))))
					end

					if not p3.CFrame then
						continue
					end

					p1:PivotTo(CFrameValue.Value)
				end
			end)
		end,
		Pause = function() --[[ Pause | Line: 46 | Upvalues: v3 (copy), v4 (copy) ]]
			v3:Pause()
			v4:Pause()
		end,
		Destroy = function() --[[ Destroy | Line: 50 | Upvalues: v3 (copy), v4 (copy) ]]
			v3:Destroy()
			v4:Destroy()
		end,
		Cancel = function() --[[ Cancel | Line: 54 | Upvalues: v3 (copy), v4 (copy) ]]
			v3:Cancel()
			v4:Cancel()
		end,
		PlaybackState = Enum.PlaybackState.Begin,
		TweenInfo = p2,
		Completed = v3.Completed,
		Thread = task.delay(180, function() --[[ Line: 61 | Upvalues: t (ref), p1 (copy) ]]
			t[p1] = nil
		end)
	}
	t[p1] = v5

	return v5
end