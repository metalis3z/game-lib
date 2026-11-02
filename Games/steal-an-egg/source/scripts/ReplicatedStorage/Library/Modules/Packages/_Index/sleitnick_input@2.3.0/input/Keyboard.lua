-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local t = {}

t.__index = t
function t.new() --[[ new | Line: 55 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2.KeyDown = v2._trove:Construct(Signal)
	v2.KeyUp = v2._trove:Construct(Signal)
	v2:_setup()

	return v2
end
function t.IsKeyDown(p1, p2) --[[ IsKeyDown | Line: 72 | Upvalues: UserInputService (copy) ]]
	return UserInputService:IsKeyDown(p2)
end
function t.AreKeysDown(p1, p2, p3) --[[ AreKeysDown | Line: 84 ]]
	return p1:IsKeyDown(p2) and p1:IsKeyDown(p3)
end
function t.AreEitherKeysDown(p1, p2, p3) --[[ AreEitherKeysDown | Line: 99 ]]
	return p1:IsKeyDown(p2) or p1:IsKeyDown(p3)
end
function t._setup(p1) --[[ _setup | Line: 103 | Upvalues: UserInputService (copy) ]]
	p1._trove:Connect(UserInputService.InputBegan, function(p12, p2) --[[ Line: 104 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		if p12.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		p1.KeyDown:Fire(p12.KeyCode)
	end)
	p1._trove:Connect(UserInputService.InputEnded, function(p12, p2) --[[ Line: 113 | Upvalues: p1 (copy) ]]
		if p2 then
			return
		end

		if p12.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		p1.KeyUp:Fire(p12.KeyCode)
	end)
end
function t.Destroy(p1) --[[ Destroy | Line: 126 ]]
	p1._trove:Destroy()
end

return t