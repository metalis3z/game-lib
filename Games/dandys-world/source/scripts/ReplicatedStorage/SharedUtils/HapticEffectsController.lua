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
-- CQNAFVNldHRpbmdzLkhhcHRpY1NsaWRlcg9nZXREYXRhRnJvbVBhdGgFcGFpcnMMTmVlZHNSZWZyZXNoBnVwZGF0ZQREYXRhDkxpc3RlblRvQ2hhbmdlEmdldFN0cmVuZ3RoU2V0dGluZwh0b251bWJlcgRtYXRoBWNsYW1wD0dsb2JhbEludGVuc2l0eRJTZXRHbG9iYWxJbnRlbnNpdHkGaXBhaXJzDUZsb2F0Q3VydmVLZXkDbmV3BEVudW0US2V5SW50ZXJwb2xhdGlvbk1vZGUGTGluZWFyBXRhYmxlBmluc2VydAx0b0Zsb2F0Q3VydmUNQ2xvbmVXYXZlZm9ybQRkYXRhBXByaW50KENvdWxkIG5vdCBmaW5kIGhhcHRpYyBlZmZlY3QgZm9yIHN0eWxlOiAGRWZmZWN0CEluc3RhbmNlDEhhcHRpY0VmZmVjdBBIYXB0aWNFZmZlY3RUeXBlBkN1c3RvbQRUeXBlBkxvb3BlZAROYW1lCXdvcmtzcGFjZQZQYXJlbnQEU3RvcA9TZXRXYXZlZm9ybUtleXMGQ3JlYXRlB0VuYWJsZWQEUGxheQ5QcmVmZXJyZWRJbnB1dAVUb3VjaAdHYW1lcGFkFHVwZGF0ZVByZWZlcnJlZElucHV0BGdhbWUKUnVuU2VydmljZQpHZXRTZXJ2aWNlCElzQ2xpZW50EVJlcGxpY2F0ZWRTdG9yYWdlEFVzZXJJbnB1dFNlcnZpY2UHcmVxdWlyZQpTaGFyZWREYXRhDUhhcHRpY0VmZmVjdHMHTW9kdWxlcxBNeURhdGFDb250cm9sbGVyDkZpbmRGaXJzdENoaWxkCENsaWVudFVJDFdhaXRGb3JDaGlsZA5vblJlcGxpY2FSZWFkeRhHZXRQcm9wZXJ0eUNoYW5nZWRTaWduYWwHQ29ubmVjdAR0YXNrBXNwYXduAAoGAAMAAAAT+wIBAG8EAgC8AgL3AwAAAJ8CAwKQAQIBPgABAN4AAACkAAUAAABAQPsBAgCfAAIEFwADAKkFAQAwBQTZBgAAAG4A/P8CAAAAggABAAcCAAAAAAAAWUACAAAAAAAAAAADAQMCAwMEAABAQAMEABoFARgAAAAAAAAAAAEAAAAAAQAA/wADGwAAAAAIAQMAAAAhDgADAE0BAMYAAAAAKwEBAIIAAQDZAQAAEgIAABICAQASAgIAbwQBAFIFAQC8AgBnAgAAAJ8CBAH7BAEAbwYBALwEBPcFAAAAnwQDApADBAQ+AgMD3gIAAKQCBwAAAGBA+wMCAJ8CAgQXAgMAqQcBADAHBtkIAAAAbgL8/wIAAACCAAEACQMGAwEDBwIAAAAAAABZQAIAAAAAAAAAAAMCAwMEAABgQAMEAQAYAAEYAAAAAAABAAAABgAAAAD7AAAAAAAAAAEAAAAAAQAA/wAGGQAAAAABAAEAAAAC+wAAAIIAAgAAACUIARgAACYAAAAACAIBAAAHBAAABQIEAhm7PgEDUgUBAKQEAgAAABBAnwQCApADBACMBAAAjAXIAEwuAAKkAgUAABAwgJ8CBAIwAgDkBgAAAKQCCAAAAHBA+wMAAJ8CAgQXAgMAqQcBADAHBtkJAAAAbgL8/wIAAACCAAEACgIAAAAAAAAAAAMJBAAAEEADCgMLBAAQMIADDAMDBAAAcEADBAApDQEYAAAAAAAAAAAAAAAAAAABAAAAAAEAAP8AAyoAAAAAFAICAAAAJ/8CAAAAAAAA+wQAAE0EBOQBAAAAPgMEAFIEAQArBAEA+wQBAAkFAwSkBgMAAAAgQFIHAACfBgIEUQYVABMLCgATDAoBCQ4MBYwPAACMEAEATC4AAqQNBgAAFECAnw0EAlIPAgCkEAkAACBwgFIRCwBSEg0ApBMNAAwsoMCfEAQATDQAAqQOEAAAPOCAnw4AAW4G6v8CAACAggICABECAAAAAAAAWUADDAMOBAAAIEADCgMLBAAUQIADDwMQBAAgcIADEQMSAxMEDCygwAMUAxUEADzggAAwFgEYCwADAAAAAQDxEAIAAAAAAQEDAAAAAAAABAAAAAAAAAAAAAAA9wAMJgAAAAAGAwEAAAgFAAAFAwQEggX7AwAAUgQBAFIFAgCfAwMCggMCAAAARxcBGAAAAAAASAAAAAALAwEAAAgFAAAFAwQDgjr7BAAAhwMEAQ4DAwBNBAMmAAAAACsEBwCkBAIAAAAQQG8GAwBSBwEAcwUGB58EAgGCAAEATQQDswQAAAArBBcApAUHAAAYUIBvBggAnwUCAlIEBQCkBQwACyiQwDAFBBENAAAAqQUAADAFBLUOAAAAMAEEug8AAACkBREAAAAAQTAFBCQSAAAAqQUBADAFA9kTAAAAMAQDswQAAABNBQPZEwAAAA4FDwC8BQT6FAAAAJ8FAgGpBQAAMAUD2RMAAABNCQMmAAAAAFIKAgC8BwCHFQAAAJ8HBAC8BQTwFgAAAJ8FAAGCBAIAFwMYAxkEAAAQQAMaAxsDHAMQBAAYUIADHQMRAx4DHwQLKJDAAyADIQMiAyMEAAAAQQMkAwQDJQMXAyYASycBGAAAAQAAAAEAAAAAAAEDAAIBAAAAAAEAAAABAAABAAEAAAABAAABAAMAAAIAAAEAAAEAAAAAAAAAAANMAAAAAAgDAgAACAUAAAUDBAOCGfsDAABNAwPwAAAAACsDAQCCAAEAUgMCACsDAQD7AwEAjAQAAH0DAgAEAAAAggABAFIGAQBSBwIAvAQAlgEAAACfBAQCDgQGALwFBPoCAAAAnwUCAbwFBO4DAAAAnwUCAYIEAgAEAygDJwMlAykAaCkBGEMAAAAAAgC7RgAAAAIAAAAAAgMAAAEAAAMmAAAAAAMAAgAAACD7AAAATQAA8AAAAACkAQMAAgAQwJoABwABAAAA+wABAIwCUAC8AABzBAAAAJ8AAwGCAAEA+wAAAE0AAPAAAAAApAEGAAUAEMCaAAcAAQAAAPsAAQCMAmQAvAAAcwQAAACfAAMBggABAPsAAQCMAgAAvAAAcwQAAACfAAMBggABAAcDKgMRAysEAgAQwAMNAywEBQAQwAB8LQEYAAAAAAAAAAEAAAAAAAEAAAAAAAABAAAAAAAEAAAAAAJ9AAAAAAwAAAECAGOjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCvAEABAQAAACfAQICKwEDAP8BAAAAAAAAggECAKQBAQAAAABAbwMFALwBARYDAAAAnwEDAqQCAQAAAABAbwQGALwCAhYDAAAAnwIDAqQDCAAAAHBATQQBZAkAAABNBAQmCgAAAJ8DAgLiBA8AjAUAAE0GAegQAAAApAcIAAAAcEBvChEAvAgGAxIAAACfCAMCKwgIAG8KEwC8CAYDEgAAAJ8IAwJvChEAvAgI0xQAAACfCAMCnwcCAtkKAAASAQX/EgAHABIAAwC8CAdHFQAAAJ8IAwHZBgEAEgEF/8AHFgASAAMAMAcEcxcAAADZBwMAEgAEABIBBf/ACBgAEgAHADAIBIcZAAAAwAgaABIAAwAwCASWGwAAANkIBgASAAQAEgEF/zAIBO4cAAAAwAgdABIAAgASAAQAbwseALwJApQfAAAAnwkDAlILCAC8CQnHIAAAAJ8JAwGkCSMAAIgQglIKCACfCQIBwQUAAIIEAgAkAy4EAAAAQAMvAzADMQMyAzMDNAQAAHBAAzUDNgMoAQEDDAIAAAAAAABJQAgCCwwAAAANDgAAAAM3AzgDOQM6AzsDPAYDAw0GBQMXBgYDJwMpBggDKgM9Az4DPwNABACIEIIIAQIDBAUGBwgBAAEYAAAAAAAAAAEAAAABAAADAAAAAAABAAAAAAACAAAAAAAAAgUFAAEAAAAAAAABAAAAAAAAAP8CAAAAAAAADQAEAAAABwAAFwAAAAQAAAAdAAAAABQAAAwAAAAAAAAAAQAAAAIAAQAAAAAJA8ljBAUkTSym6b79XzscinPRdHAxDQkF

-- https://lua.expert/
if not game:GetService("RunService"):IsClient() then
	return {}
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local HapticEffects = require(ReplicatedStorage.SharedData.HapticEffects)
local t = {
	Enabled = true,
	GlobalIntensity = 50
}
local v1 = 0
local Modules = ReplicatedStorage.Modules
local v4 = require(Modules:FindFirstChild("MyDataController") or Modules:FindFirstChild("ClientUI"):WaitForChild("MyDataController"))

v4:onReplicaReady(function(p1) --[[ Line: 24 | Upvalues: v1 (ref), v4 (copy), HapticEffects (copy) ]]
	if not (p1 and p1.Data) then
		return
	end

	p1:ListenToChange("Settings.HapticSlider", function() --[[ update | Line: 26 | Upvalues: v1 (ref), v4 (ref), HapticEffects (ref) ]]
		v1 = (v4:getDataFromPath("Settings.HapticSlider") or 0) / 100

		for k, v in pairs(HapticEffects) do
			v.NeedsRefresh = true
		end
	end)
	v1 = (v4:getDataFromPath("Settings.HapticSlider") or 0) / 100

	for k, v in pairs(HapticEffects) do
		v.NeedsRefresh = true
	end
end)

local function getStrengthSetting() --[[ getStrengthSetting | Line: 37 | Upvalues: v1 (ref) ]]
	return v1
end

function t.SetGlobalIntensity(p1, p2) --[[ SetGlobalIntensity | Line: 41 | Upvalues: HapticEffects (copy) ]]
	p1.GlobalIntensity = math.clamp(tonumber(p2) or 0, 0, 200)

	for k, v in pairs(HapticEffects) do
		v.NeedsRefresh = true
	end
end

local function toFloatCurve(p1, p2) --[[ toFloatCurve | Line: 48 | Upvalues: t (copy), v1 (ref) ]]
	local t2 = {}
	local v3 = t.GlobalIntensity / 100 * (if p2 then p2 else v1)

	for i, v in ipairs(p1) do
		table.insert(t2, FloatCurveKey.new(v[1], math.clamp(v[2] * v3, 0, 1), Enum.KeyInterpolationMode.Linear))
	end

	return t2
end

function t.CloneWaveform(p1, p2, p3) --[[ CloneWaveform | Line: 71 | Upvalues: toFloatCurve (copy) ]]
	return toFloatCurve(p2, p3)
end
function t.Create(p1, p2, p3) --[[ Create | Line: 75 | Upvalues: HapticEffects (copy) ]]
	local v1 = HapticEffects[p2]

	if not (v1 and v1.data) then
		print("Could not find haptic effect for style: " .. p2)

		return
	end

	local Effect = v1.Effect

	if not Effect then
		local HapticEffect = Instance.new("HapticEffect")

		HapticEffect.Type = Enum.HapticEffectType.Custom
		HapticEffect.Looped = false
		HapticEffect.Name = p2
		HapticEffect.Parent = workspace
		v1.NeedsRefresh = true
		v1.Effect = HapticEffect
		Effect = HapticEffect
	end

	if v1.NeedsRefresh then
		Effect:Stop()
		v1.NeedsRefresh = false
		Effect:SetWaveformKeys(p1:CloneWaveform(v1.data, p3))
	end

	return Effect
end
function t.Play(p1, p2, p3) --[[ Play | Line: 104 | Upvalues: t (copy), v1 (ref) ]]
	if not t.Enabled then
		return
	end

	if (if p3 then p3 else v1) <= 0 then
		return
	end

	local v2 = p1:Create(p2, p3)

	if v2 then
		v2:Stop()
		v2:Play()
	end

	return v2
end

local function updatePreferredInput() --[[ updatePreferredInput | Line: 124 | Upvalues: UserInputService (copy), t (copy) ]]
	if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
		t:SetGlobalIntensity(80)

		return
	end

	if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
		t:SetGlobalIntensity(100)
	else
		t:SetGlobalIntensity(0)
	end
end

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updatePreferredInput)
task.spawn(updatePreferredInput)

return t