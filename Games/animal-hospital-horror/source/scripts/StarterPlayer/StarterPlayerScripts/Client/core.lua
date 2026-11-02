local t = {}
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

function t.Call(p1, ...) --[[ Call | Line: 8 | Upvalues: StarterGui (copy), RunService (copy) ]]
	local t = {}

	for i = 1, 8 do
		local t2 = { pcall(StarterGui[p1], StarterGui, ...) }

		if t2[1] then
			t = t2

			break
		end

		RunService.Stepped:Wait()
		t = t2
	end

	return unpack(t)
end

return t