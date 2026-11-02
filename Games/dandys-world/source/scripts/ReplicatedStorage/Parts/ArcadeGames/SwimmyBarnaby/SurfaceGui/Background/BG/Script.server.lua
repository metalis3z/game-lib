--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMbB1Zpc2libGUFRnJhbWUCVGkIUG9zaXRpb24FVURpbTIJZnJvbVNjYWxlAVgGT2Zmc2V0BkNyZWF0ZQRQbGF5BnVwZGF0ZQRnYW1lDFR3ZWVuU2VydmljZQpHZXRTZXJ2aWNlBnNjcmlwdAZQYXJlbnQJVHdlZW5JbmZvA25ldwRFbnVtC0Vhc2luZ1N0eWxlBkxpbmVhcgVMYXllcg9FYXNpbmdEaXJlY3Rpb24DT3V0BVNjYWxlGEdldFByb3BlcnR5Q2hhbmdlZFNpZ25hbAdDb25uZWN0AAMNAAQAAAA++wAAAE0AAIAAAAAADgAfAIwCAgCMAAQAjAEBAKgANQD7BAEAhwMEAvsEAgBNBgOdAQAAAE0HA3UCAAAA4ggEAKQJBwAAGFCATQsDeQgAAABNDANwCQAAACYKCwxvCwoAnwkDAjAJCDsDAAAAvAQElgsAAACfBAUCvAQE7gwAAACfBAIBiwDm/4IAAQCMAgIAjAAEAIwBAQCoABYA+wQBAIcDBAL7BAIATQYDnQEAAAD7BwMA4ggEAKQJBwAAGFCATQoDeQgAAABvCwoAnwkDAjAJCDsDAAAAvAQElgsAAACfBAUCvAQE7gwAAACfBAIBiwDq/4IAAQANAwEDAgMDAwQFAQMDBQMGBAAYUIADBwMIAgAAAAAAAOA/AwkDCgAZCwEYAAAAAAEAAAABAAEAAAAAAAEAAAAAAAAAAAAA/wAAAgAA/AAHAAAAAQABAAAAAAEAAAAAAAAA/wAAAgAA/AcaAAAAAAEAAQAAAAP7AAAAnwABAYIAAQAAACsAARgAAAEsAAAAAA8AAAEAAFejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEAAAQAAACkAgUAAABAQE0CAiQGAAAApAMJAAAgcIBvBAoApAUOAA0wsMCfAwMCjAYBAIwEBACMBQEAqAQvAA0GCQAPAACAbwkQAFIKBgBzCAkKhwcCCKkIAAAwCAeAEQAAAGUAJACkBwkAACBwgD4IBhKkCQ4ADTCwwKQKFQAUTLDAjAv//58HBQJvChAAUgsGAHMJCguHCAIJTQgIOxYAAABNCAh5FwAAAE0ICIQYAAAA9QsaBj4KCxJbCQoZ4goeAG8NEABSDgYAcwwNDocLAgwwCwqdGwAAADAICnkXAAAAMAkKcBwAAAAwBwp1HQAAAGoKAQaLBNH/wAQfABIAAgASAAEAEgAAABIAAwBvBxEAvAUClCAAAACfBQMCwAchABIABAC8BQXHIgAAAJ8FAwFSBQQAnwUBAYIAAQAjAwwEAAAAQAMNAw4DDwQAAEBAAxADEQMSBAAgcIACmpmZmZmZuT8DEwMUAxUEDTCwwAIAAAAAAADwPwMWAwECAAAAAAAAEEADFwMYBBRMsMADBAMHAxkCmpmZmZmZ2T8CAAAAAAAAFEADAgMIAwMFBBsXHB0GAAMaBgEDGwIAAQEAARgAAQAAAAAAAgACAAAAAQAAAAAAAgAAAAEAAQAAAAAAAAECAAAAAAAAAAABAAAAAAAAAAAAAQAAAQEAAAAAAAEAAQABAPz4EAAAAAASAAAAAAAAAAADAAEBAAAAAALmih1bhvArWQafbSZ01YvrlpIKL9ROd1o=

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local v2 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
local t = {}

for i = 1, 4 do
	if i == 1 then
		v1["Layer" .. i].Visible = false

		continue
	end

	local v3 = TweenInfo.new(i / 4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1)

	t[i] = {
		Frame = v1["Layer" .. i],
		X = v1["Layer" .. i].Position.X.Scale,
		Offset = (5 - i) / 4 * 0.4,
		Ti = v3
	}
end

local function update() --[[ update | Line: 25 | Upvalues: v1 (copy), t (copy), TweenService (copy), v2 (copy) ]]
	if v1.Visible then
		for i = 2, 4 do
			local v12 = t[i]

			TweenService:Create(v12.Frame, v12.Ti, {
				Position = UDim2.fromScale(v12.X - v12.Offset, 0.5)
			}):Play()
		end
	else
		for j = 2, 4 do
			local v22 = t[j]

			TweenService:Create(v22.Frame, v2, {
				Position = UDim2.fromScale(v22.X, 0.5)
			}):Play()
		end
	end
end

v1:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 43 | Upvalues: update (copy) ]]
	update()
end)
update()