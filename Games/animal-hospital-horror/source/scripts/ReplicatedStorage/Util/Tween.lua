local t = {}
local TweenService = game:GetService("TweenService")
local Signal = require(script.Parent.Signal)
local Maid = require(script.Parent.Maid)
local t2 = {}
local t3 = {}

t3.__index = t3
function t3.new(p1, p2, ...) --[[ new | Line: 10 | Upvalues: TweenService (copy), Maid (copy), Signal (copy), t3 (copy), t2 (copy) ]]
	if type(p2) == "table" then
		p2 = TweenInfo.new(unpack(p2))
	end

	local t = {
		t = TweenService:Create(p1, p2, ...),
		maid = Maid.new(),
		Finished = Signal.new()
	}

	t.times = 2 * (if p2.Reverses then 1 else 0)
	setmetatable(t, t3)
	t.maid:GiveTask(t)
	t.maid:GiveTask((t.t.Completed:Connect(function() --[[ Line: 23 | Upvalues: t (copy) ]]
		if t.times > 1 then
			t.times = t.times - 1
		else
			t.Finished:Fire()
			t.maid:DoCleaning()
		end
	end)))
	t2[t] = true

	return t
end
function t3.Destroy(p1) --[[ Destroy | Line: 36 | Upvalues: t2 (copy) ]]
	p1.maid:GiveTask(p1.t)
	p1.maid:GiveTask(p1.Finished)
	t2[p1] = nil
end
function t3.Play(p1) --[[ Play | Line: 42 ]]
	p1.t:Play()
end
function t.Create(...) --[[ Create | Line: 46 | Upvalues: t3 (copy) ]]
	return t3.new(...)
end
t.new = t.Create

return t