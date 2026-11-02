-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Audio = require(Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)

function CreateInteractSound(p1, p2, p3, p4, p5) --[[ CreateInteractSound | Line: 7 | Upvalues: Asserts (copy), Audio (copy) ]]
	Asserts.GuiButton(p1)
	Asserts.string(p2)
	Asserts.string(p3)
	Asserts.optional.number(p4)
	Asserts.optional.boolean(p5)

	local v1 = string.lower(p2)
	local v2 = false
	local t = {}
	local v3 = p4 or 0.15
	local v4 = if p5 == nil then false else p5 or false

	local function playSound() --[[ playSound | Line: 29 | Upvalues: v4 (copy), Audio (ref), p3 (copy), v3 (copy) ]]
		Audio.Play(p3, script, if v4 then math.random(95, 105) / 100 or 1 else 1, v3)
	end

	local function playLoudSound() --[[ playLoudSound | Line: 34 | Upvalues: v4 (copy), Audio (ref), p3 (copy), v3 (copy) ]]
		Audio.Play(p3, script, if v4 then math.random(95, 105) / 100 or 1 else 1, v3 * 2)
	end

	if v1 == "mousedown" then
		t[#t + 1] = p1.InputBegan:Connect(function(p1) --[[ Line: 40 | Upvalues: v4 (copy), Audio (ref), p3 (copy), v3 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Touch or p1.UserInputState ~= Enum.UserInputState.Begin) and p1.KeyCode ~= Enum.KeyCode.ButtonA then
				return
			end

			Audio.Play(p3, script, if v4 then math.random(95, 105) / 100 or 1 else 1, v3 * 2)
		end)
	elseif v1 == "mouseup" then
		t[#t + 1] = p1.InputEnded:Connect(function(p1) --[[ Line: 50 | Upvalues: v4 (copy), Audio (ref), p3 (copy), v3 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Touch or p1.UserInputState ~= Enum.UserInputState.End) and p1.KeyCode ~= Enum.KeyCode.ButtonA then
				return
			end

			Audio.Play(p3, script, if v4 then math.random(95, 105) / 100 or 1 else 1, v3 * 2)
		end)
	elseif v1 == "mouseenter" then
		t[#t + 1] = p1.MouseEnter:Connect(playSound)
	elseif v1 == "mouseleave" then
		t[#t + 1] = p1.MouseLeave:Connect(playSound)
	elseif v1 == "mouseclick" then
		t[#t + 1] = p1.Activated:Connect(playSound)
	end

	return function() --[[ Line: 67 | Upvalues: v2 (ref), t (copy) ]]
		if v2 then
			return
		end

		v2 = false

		for i, v in ipairs(t) do
			v:Disconnect()
		end
	end
end

return CreateInteractSound