-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 96 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local t2 = {}

	setmetatable(t2, t)
	t2._trove = Trove.new()
	t2._shown = t2._trove:Construct(Signal)
	t2._shownTrove = Trove.new()
	t2._trove:Add(t2._shownTrove)
	t2.Instance = p1:FindFirstChild(p2)

	local function OnInstanceSet() --[[ OnInstanceSet | Line: 107 | Upvalues: t2 (copy) ]]
		local v1 = t2.Instance

		if typeof(v1) ~= "Instance" then
			return
		end

		t2._shown:Fire(v1, t2._shownTrove)
		t2._shownTrove:Connect(v1:GetPropertyChangedSignal("Parent"), function() --[[ Line: 111 | Upvalues: v1 (copy), t2 (ref) ]]
			if v1.Parent then
				return
			end

			t2._shownTrove:Clean()
		end)
		t2._shownTrove:Add(function() --[[ Line: 116 | Upvalues: t2 (ref), v1 (copy) ]]
			if t2.Instance ~= v1 then
				return
			end

			t2.Instance = nil
		end)
	end

	local function OnChildAdded(p1) --[[ OnChildAdded | Line: 124 | Upvalues: p2 (copy), t2 (copy), OnInstanceSet (copy) ]]
		if p1.Name ~= p2 or t2.Instance then
			return
		end

		t2.Instance = p1
		OnInstanceSet()
	end

	t2._trove:Connect(p1.ChildAdded, OnChildAdded)

	if not t2.Instance then
		return t2
	end

	OnInstanceSet()

	return t2
end
function t.primary(p1) --[[ primary | Line: 146 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local t2 = {}

	setmetatable(t2, t)
	t2._trove = Trove.new()
	t2._shown = t2._trove:Construct(Signal)
	t2._shownTrove = Trove.new()
	t2._trove:Add(t2._shownTrove)
	t2.Instance = p1.PrimaryPart

	local function OnPrimaryPartChanged() --[[ OnPrimaryPartChanged | Line: 157 | Upvalues: p1 (copy), t2 (copy) ]]
		local PrimaryPart = p1.PrimaryPart

		t2._shownTrove:Clean()
		t2.Instance = PrimaryPart

		if not PrimaryPart then
			return
		end

		t2._shown:Fire(PrimaryPart, t2._shownTrove)
	end

	t2._trove:Connect(p1:GetPropertyChangedSignal("PrimaryPart"), OnPrimaryPartChanged)

	if t2.Instance then
		local PrimaryPart = p1.PrimaryPart

		t2._shownTrove:Clean()
		t2.Instance = PrimaryPart

		if PrimaryPart then
			t2._shown:Fire(PrimaryPart, t2._shownTrove)
		end
	end

	return t2
end
function t.Observe(p1, p2) --[[ Observe | Line: 184 ]]
	if p1.Instance then
		task.spawn(p2, p1.Instance, p1._shownTrove)
	end

	return p1._shown:Connect(p2)
end
function t.Destroy(p1) --[[ Destroy | Line: 196 ]]
	p1._trove:Destroy()
end

return t