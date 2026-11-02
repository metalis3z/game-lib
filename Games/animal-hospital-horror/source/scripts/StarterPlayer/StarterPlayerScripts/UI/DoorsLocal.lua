local Lib = require(game.ReplicatedStorage.Lib)
local t = {}

local function SetUpDoor(p1) --[[ SetUpDoor | Line: 4 | Upvalues: t (copy) ]]
	local close = p1:WaitForChild("close", 5)

	if not close then
		return
	end

	close:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 8 | Upvalues: p1 (copy), t (ref) ]]
		if not p1.close.CanCollide or t[p1] then
			return
		end

		t[p1] = true

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") and string.match(v.Name, "close") then
				v.CanCollide = false
			end
		end

		task.wait(0.2)

		for i, v in ipairs(p1:GetDescendants()) do
			if v:IsA("BasePart") and string.match(v.Name, "close") then
				v.CanCollide = v.Transparency ~= 1
			end
		end

		task.wait(0.025)
		t[p1] = nil
	end)

	if p1:FindFirstChild("open") then
		p1.open:GetPropertyChangedSignal("CanCollide"):Connect(function() --[[ Line: 32 | Upvalues: p1 (copy), t (ref) ]]
			if not p1.open.CanCollide or t[p1] then
				return
			end

			t[p1] = true

			for i, v in ipairs(p1:GetDescendants()) do
				if v:IsA("BasePart") and string.match(v.Name, "open") then
					v.CanCollide = false
				end
			end

			task.wait(0.2)

			for i, v in ipairs(p1:GetDescendants()) do
				if v:IsA("BasePart") and string.match(v.Name, "open") then
					v.CanCollide = v.Transparency ~= 1
				end
			end

			task.wait(0.025)
			t[p1] = nil
		end)
	end
end

Lib.CS:GetInstanceAddedSignal("Door"):Connect(function(p1) --[[ Line: 56 | Upvalues: SetUpDoor (copy) ]]
	task.wait(3)
	SetUpDoor(p1)
end)

for i, v in ipairs(Lib.CS:GetTagged("Door")) do
	task.spawn(function() --[[ Line: 62 | Upvalues: SetUpDoor (copy), v (copy) ]]
		task.wait(3)
		SetUpDoor(v)
	end)
end

return {}