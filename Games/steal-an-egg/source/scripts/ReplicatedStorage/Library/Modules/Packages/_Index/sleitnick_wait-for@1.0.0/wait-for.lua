-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Promise = require(script.Parent.Parent.Parent.Promise)
local t = {
	Error = {
		Unparented = "Unparented",
		ParentChanged = "ParentChanged"
	}
}

local function PromiseWatchAncestry(p1, p2) --[[ PromiseWatchAncestry | Line: 40 | Upvalues: Promise (copy), t (copy) ]]
	return Promise.race({ p2, Promise.fromEvent(p1.AncestryChanged, function(p1, p2) --[[ Line: 43 ]]
			return p2 == nil
		end):andThen(function() --[[ Line: 45 | Upvalues: Promise (ref), t (ref) ]]
			return Promise.reject(t.Error.Unparented)
		end) })
end

function t.Child(p1, p2, p3) --[[ Child | Line: 61 | Upvalues: Promise (copy), PromiseWatchAncestry (copy) ]]
	local v1 = p1:FindFirstChild(p2)

	if v1 then
		return Promise.resolve(v1)
	end

	return PromiseWatchAncestry(p1, Promise.fromEvent(p1.ChildAdded, function(p1) --[[ Line: 68 | Upvalues: p2 (copy) ]]
		return p1.Name == p2
	end):timeout(p3 or 120))
end
function t.ChildWhichIsA(p1, p2, p3) --[[ ChildWhichIsA | Line: 94 | Upvalues: Promise (copy), PromiseWatchAncestry (copy) ]]
	local v1 = p1:FindFirstChildWhichIsA(p2)

	if v1 then
		return Promise.resolve(v1)
	end

	return PromiseWatchAncestry(p1, Promise.fromEvent(p1.ChildAdded, function(p1) --[[ Line: 101 | Upvalues: p2 (copy) ]]
		return p1:IsA(p2)
	end):timeout(p3 or 120))
end
function t.Children(p1, p2, p3) --[[ Children | Line: 125 | Upvalues: t (copy), Promise (copy) ]]
	local v1 = table.create(#p2)

	for i, v in ipairs(p2) do
		v1[i] = t.Child(p1, v, p3)
	end

	return Promise.all(v1):andThen(function(p12) --[[ Line: 130 | Upvalues: p1 (copy), Promise (ref), t (ref) ]]
		for i, v in ipairs(p12) do
			if v.Parent ~= p1 then
				return Promise.reject(t.Error.ParentChanged)
			end
		end

		return p12
	end)
end
function t.Descendant(p1, p2, p3) --[[ Descendant | Line: 153 | Upvalues: Promise (copy), PromiseWatchAncestry (copy) ]]
	local v1 = p1:FindFirstChild(p2, true)

	if v1 then
		return Promise.resolve(v1)
	end

	return PromiseWatchAncestry(p1, Promise.fromEvent(p1.DescendantAdded, function(p1) --[[ Line: 160 | Upvalues: p2 (copy) ]]
		return p1.Name == p2
	end):timeout(p3 or 120))
end
function t.Descendants(p1, p2, p3) --[[ Descendants | Line: 184 | Upvalues: t (copy), Promise (copy) ]]
	local v1 = table.create(#p2)

	for i, v in ipairs(p2) do
		v1[i] = t.Descendant(p1, v, p3)
	end

	return Promise.all(v1):andThen(function(p12) --[[ Line: 189 | Upvalues: p1 (copy), Promise (ref), t (ref) ]]
		for i, v in ipairs(p12) do
			if not v:IsDescendantOf(p1) then
				return Promise.reject(t.Error.ParentChanged)
			end
		end

		return p12
	end)
end
function t.PrimaryPart(p1, p2) --[[ PrimaryPart | Line: 210 | Upvalues: Promise (copy), PromiseWatchAncestry (copy) ]]
	local PrimaryPart = p1.PrimaryPart

	if PrimaryPart then
		return Promise.resolve(PrimaryPart)
	end

	return PromiseWatchAncestry(p1, Promise.fromEvent(p1:GetPropertyChangedSignal("PrimaryPart"), function() --[[ Line: 217 | Upvalues: PrimaryPart (ref), p1 (copy) ]]
		PrimaryPart = p1.PrimaryPart

		return PrimaryPart ~= nil
	end):andThen(function() --[[ Line: 221 | Upvalues: PrimaryPart (ref) ]]
		return PrimaryPart
	end):timeout(p2 or 120))
end
function t.ObjectValue(p1, p2) --[[ ObjectValue | Line: 238 | Upvalues: Promise (copy), PromiseWatchAncestry (copy) ]]
	local v1 = p1.Value

	if v1 then
		return Promise.resolve(v1)
	end

	return PromiseWatchAncestry(p1, Promise.fromEvent(p1.Changed, function(p1) --[[ Line: 245 | Upvalues: v1 (ref) ]]
		v1 = p1

		return p1 ~= nil
	end):andThen(function() --[[ Line: 249 | Upvalues: v1 (ref) ]]
		return v1
	end):timeout(p2 or 120))
end
function t.Custom(p1, p2) --[[ Custom | Line: 268 | Upvalues: Promise (copy), RunService (copy) ]]
	local v1 = p1()

	if v1 == nil then
		return Promise.new(function(p12, p2, p3) --[[ Line: 273 | Upvalues: p1 (copy), RunService (ref) ]]
			local v1 = nil

			local function OnDone() --[[ OnDone | Line: 275 | Upvalues: v1 (ref) ]]
				v1:Disconnect()
			end

			local function Update() --[[ Update | Line: 278 | Upvalues: p1 (ref), v1 (ref), p12 (copy) ]]
				local v12 = p1()

				if v12 == nil then
					return
				end

				v1:Disconnect()
				p12(v12)
			end

			v1 = RunService.Heartbeat:Connect(Update)
			p3(OnDone)
		end):timeout(p2 or 120)
	end

	return Promise.resolve(v1)
end

return t