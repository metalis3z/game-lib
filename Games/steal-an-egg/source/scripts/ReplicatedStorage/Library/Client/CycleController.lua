-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local v1 = nil
local v2 = nil
local t = {
	IsNight = function() --[[ IsNight | Line: 15 ]]
		return workspace:GetServerTimeNow() % 1800 >= 900
	end,
	IsDay = function() --[[ IsDay | Line: 19 ]]
		return workspace:GetServerTimeNow() % 1800 < 900
	end,
	Update = function() --[[ Update | Line: 23 | Upvalues: v1 (ref), Lighting (copy), v2 (ref), TweenService (copy) ]]
		v1 = os.clock()

		local v12 = if workspace:GetAttribute("BloodmoonEvent") then 20 else nil

		if workspace:GetAttribute("TrickOrTreatEvent") or workspace:GetAttribute("GraveyardEvent") then
			v12 = 5
		end

		if workspace:GetAttribute("MagmaWeather") or workspace:GetAttribute("Starfall") then
			v12 = 0
		end

		local v22 = not v12

		if not v12 then
			v12 = 14.5
		end

		if math.abs(v12 - Lighting.ClockTime) > 1 and v22 ~= v2 then
			TweenService:Create(Lighting, TweenInfo.new(5), {
				ClockTime = v12
			}):Play()
		else
			Lighting.ClockTime = v12
		end

		v2 = v22
	end,
	Start = function() --[[ Start | Line: 72 ]] end
}

t.Start()

return t