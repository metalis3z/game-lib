-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Janitor.test, time of decompilation: Sun May  3 10:10:33 2026 ]]
_G.__IS_UNIT_TESTING__ = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local JestGlobals = require(script.Parent.Parent.Parent.DevPackages.JestGlobals)
local Parent = require(script.Parent.Parent)
local Promise = require(script.Parent.Parent.Promise)
local describe = JestGlobals.describe
local expect = JestGlobals.expect
local it = JestGlobals.it
local v9 = (function() -- line: 17
	local BindableEvent = Instance.new("BindableEvent")
	local u14 = false

	BindableEvent.Event:Once(function() -- line: 20
		-- upvalues: u14 (ref)
		u14 = true
	end)
	BindableEvent:Fire()
	BindableEvent:Destroy()

	return not u14
end)()

local function AwaitCondition(p1: ((...any) -> ...any), n1: number?) -- line: 28
	local v17 = n1 or 10
	local elapsed = os.clock()

	while not p1() do
		if v17 < os.clock() - elapsed then
			return false
		end

		task.wait()
	end

	return true
end

local t1 = {
	ClassName = "BasicClass"
}

t1.__index = t1

function t1.new() -- line: 57
	-- upvalues: t1 (copy)
	return (setmetatable({
		CleanupFunction = nil
	}, t1))
end
function t1.AddCleanupFunction(t2: {[any]: any}, p2: ((...any) -> ...any)?) -- line: 62
	t2.CleanupFunction = p2

	return t2
end
function t1.Destroy(p3) -- line: 66
	local CleanupFunction = p3.CleanupFunction

	if CleanupFunction then
		CleanupFunction()
	end

	table.clear(p3)
	setmetatable(p3, nil)
end

local function NoOperation() -- line: 75
end

describe("Janitor.Is", function() -- line: 77
	-- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy), t1 (copy)
	it("should return true iff the passed value is a Janitor", function() -- line: 78
		-- upvalues: Parent (copy), expect (copy)
		local v23 = Parent.new()

		expect(Parent.Is(v23)).toBe(true)
		v23:Destroy()
	end)
	it("should return false iff the passed value is anything else", function() -- line: 84
		-- upvalues: expect (copy), Parent (copy), NoOperation (copy), t1 (copy)
		expect(Parent.Is(NoOperation)).toBe(false)
		expect(Parent.Is({})).toBe(false)
		expect(Parent.Is(t1.new())).toBe(false)
	end)
end)
describe("Janitor.new", function() -- line: 91
	-- upvalues: it (copy), Parent (copy), expect (copy)
	it("should create a new Janitor", function() -- line: 92
		-- upvalues: Parent (copy), expect (copy)
		local v24 = Parent.new()

		expect(v24).toBeDefined()
		expect(Parent.Is(v24)).toBe(true)
		v24:Destroy()
	end)
end)
describe("Janitor.Add", function() -- line: 100
	-- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy), ReplicatedStorage (copy), t1 (copy), v9 (copy)
	it("should add things", function() -- line: 101
		-- upvalues: Parent (copy), expect (copy), NoOperation (copy)
		local v25 = Parent.new()

		expect(function() -- line: 103
			-- upvalues: v25 (copy), NoOperation (copy)
			v25:Add(NoOperation, true)
		end).never.toThrow()
		v25:Destroy()
	end)
	it("should add things with the given index", function() -- line: 110
		-- upvalues: Parent (copy), expect (copy), NoOperation (copy)
		local v26 = Parent.new()

		expect(function() -- line: 112
			-- upvalues: v26 (copy), NoOperation (copy)
			v26:Add(NoOperation, true, "Function")
		end).never.toThrow()
		expect(v26:Get("Function")).toEqual(expect.any("function"))
		v26:Destroy()
	end)
	it("should overwrite indexes", function() -- line: 120
		-- upvalues: Parent (copy), NoOperation (copy), expect (copy)
		local v27 = Parent.new()
		local u28 = false

		v27:Add(function() -- line: 123
			-- upvalues: u28 (ref)
			u28 = true
		end, true, "Function")
		v27:Add(NoOperation, true, "Function")
		expect(u28).toBe(true)
		v27:Destroy()
	end)
	it("should return the passed object", function() -- line: 133
		-- upvalues: Parent (copy), expect (copy)
		local v29 = Parent.new()
		local v30 = v29:Add(Instance.new("Part"), "Destroy")

		expect(v30).toBeDefined()
		expect(v30).toEqual(expect.any("Instance"))
		expect(v30.ClassName).toBe("Part")
		v29:Destroy()
	end)
	it("should clean up instances, objects, functions, connections, and threads", function() -- line: 143
		-- upvalues: Parent (copy), ReplicatedStorage (copy), NoOperation (copy), t1 (copy), expect (copy)
		local u31 = false
		local u32 = false
		local u33 = false
		local u34 = false
		local v35 = Parent.new()
		local v36 = v35:Add(Instance.new("Part"), "Destroy")

		v36.Parent = ReplicatedStorage

		local v37 = v35:Add(v36.ChildRemoved:Connect(NoOperation), "Disconnect")

		v35:Add(function() -- line: 155
			-- upvalues: u31 (ref)
			u31 = true
		end, true)
		v35:Add(Parent.new(), "Destroy"):Add(function() -- line: 159
			-- upvalues: u32 (ref)
			u32 = true
		end, true)
		v35:Add(t1.new(), "Destroy"):AddCleanupFunction(function() -- line: 163
			-- upvalues: u33 (ref)
			u33 = true
		end)
		v35:Add(task.delay(1, function() -- line: 167
			-- upvalues: u34 (ref)
			u34 = true
		end), true)
		v35:Destroy()
		expect(v36.Parent).toBeUndefined()
		expect(v37.Connected).toBe(false)
		expect(u31).toBe(true)
		expect(u32).toBe(true)
		expect(u33).toBe(true)
		expect(u34).toBe(false)
	end)
	it("should clean up everything correctly", function() -- line: 180
		-- upvalues: Parent (copy), expect (copy)
		local v38 = Parent.new()
		local n2 = 0

		for i = 1, 5000 do
			v38:Add(function() -- line: 186
				-- upvalues: n2 (ref)
				n2 += 1
			end, true, i)
		end

		for i = 5000, 1, -1 do
			v38:Remove(i)
		end

		v38:Destroy()
		expect(n2).toBe(5000)
	end)
	it("should infer types if not given", function() -- line: 199
		-- upvalues: Parent (copy), ReplicatedStorage (copy), NoOperation (copy), v9 (copy), expect (copy)
		local v42 = Parent.new()
		local v43 = v42:Add(ReplicatedStorage.AncestryChanged:Connect(NoOperation))

		v42:Destroy()

		if v9 then
			task.wait()
		end

		expect(v43.Connected).toBe(false)
	end)
end)
describe("Janitor.AddPromise", function() -- line: 211
	-- upvalues: Promise (copy), it (copy), Parent (copy), expect (copy), t1 (copy)
	if not Promise then
		return
	end

	it("should add a Promise", function() -- line: 216
		-- upvalues: Parent (copy), Promise (copy), expect (copy)
		local v44 = Parent.new()
		local v45 = v44:AddPromise(Promise.delay(60))

		expect(Promise.is(v45)).toBe(true)
		v44:Destroy()
	end)
	it("should cancel the Promise when destroyed", function() -- line: 224
		-- upvalues: Parent (copy), Promise (copy), expect (copy)
		local v46 = Parent.new()
		local u47 = false

		v46:AddPromise(Promise.new(function(p4, _, p6) -- line: 228
			-- upvalues: u47 (ref), Promise (copy)
			if p6(function() -- line: 229
				-- upvalues: u47 (ref)
				u47 = true
			end) then
				return
			end

			return Promise.delay(60):andThen(p4)
		end))
		v46:Destroy()
		expect(u47).toBe(true)
	end)
	it("should not remove any values from the return", function() -- line: 242
		-- upvalues: Parent (copy), Promise (copy), expect (copy)
		local v48 = Parent.new()
		local _, v50 = v48:AddPromise(Promise.new(function(p7) -- line: 245
			p7(true)
		end)):await()

		expect(v50).toBe(true)
		v48:Destroy()
	end)
	it("should throw if the passed value isn't a Promise", function() -- line: 254
		-- upvalues: Parent (copy), expect (copy), t1 (copy)
		local v51 = Parent.new()

		expect(function() -- line: 256
			-- upvalues: v51 (copy), t1 (copy)
			v51:AddPromise((t1.new()))
		end).toThrow()
		v51:Destroy()
	end)
end)
describe("Janitor.Remove", function() -- line: 264
	-- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy), AwaitCondition (copy), t1 (copy)
	it("should always return the Janitor", function() -- line: 265
		-- upvalues: Parent (copy), NoOperation (copy), expect (copy)
		local v52 = Parent.new()

		v52:Add(NoOperation, true, "Function")
		expect(v52:Remove("Function")).toBe(v52)
		expect(v52:Remove("Function")).toBe(v52)
		v52:Destroy()
	end)
	it("should always remove the value", function() -- line: 274
		-- upvalues: Parent (copy), expect (copy), AwaitCondition (copy)
		local v53 = Parent.new()
		local u54 = false

		v53:Add(function() -- line: 278
			-- upvalues: u54 (ref)
			u54 = true
		end, true, "Function")
		v53:Remove("Function")
		expect(AwaitCondition(function() -- line: 284
			-- upvalues: u54 (ref)
			return u54
		end, 1)).toBe(true)
		v53:Destroy()
	end)
	it("should properly remove values that are already destroyed", function() -- line: 290
		-- upvalues: Parent (copy), expect (copy)
		local v55 = Parent.new()
		local n3 = 0
		local v57 = Parent.new()

		v57:Add(function() -- line: 296
			-- upvalues: n3 (ref)
			n3 += 1
		end, true)
		v55:Add(v57, "Destroy")
		v57:Destroy()
		expect(function() -- line: 302
			-- upvalues: v55 (copy)
			v55:Destroy()
		end).never.toThrow()
		expect(n3).toBe(1)
	end)
	it("should clean up everything efficiently", function() -- line: 309
		-- upvalues: Parent (copy), NoOperation (copy), t1 (copy)
		local v58 = Parent.new()
		local n4 = 0

		for _ = 1, 1000000 do
			n4 += 1
			v58:Add(NoOperation, true, n4)
		end

		for _ = 1, 200000 do
			n4 += 1
			v58:Add(task.delay(5, NoOperation), true, n4)
		end

		for _ = 1, 1000000 do
			n4 += 1
			v58:Add(t1.new(), "Destroy", n4)
		end

		for _ = 1, 100000 do
			n4 += 1
			v58:Add(Instance.new("Part"), "Destroy", n4)
		end

		for i = 1, n4 do
			v58:Remove(i)
		end

		v58:Destroy()
	end)
end)
describe("Janitor.RemoveList", function() -- line: 343
	-- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy)
	it("should always return the Janitor", function() -- line: 344
		-- upvalues: Parent (copy), NoOperation (copy), expect (copy)
		local v65 = Parent.new()

		v65:Add(NoOperation, true, "Function")
		expect(v65:RemoveList("Function")).toBe(v65)
		expect(v65:RemoveList("Function")).toBe(v65)
		v65:Destroy()
	end)
	it("should always remove the value", function() -- line: 353
		-- upvalues: Parent (copy), expect (copy)
		local v66 = Parent.new()
		local u67 = false

		v66:Add(function() -- line: 357
			-- upvalues: u67 (ref)
			u67 = true
		end, true, "Function")
		v66:RemoveList("Function")
		expect(u67).toBe(true)
		v66:Destroy()
	end)
	it("should properly remove multiple values", function() -- line: 367
		-- upvalues: Parent (copy), expect (copy)
		local v68 = Parent.new()
		local u69 = false
		local u70 = false
		local u71 = false

		v68:Add(function() -- line: 373
			-- upvalues: u69 (ref)
			u69 = true
		end, true, 1)
		v68:Add(function() -- line: 377
			-- upvalues: u70 (ref)
			u70 = true
		end, true, 2)
		v68:Add(function() -- line: 381
			-- upvalues: u71 (ref)
			u71 = true
		end, true, 3)
		v68:RemoveList(1, 2, 3)
		expect(u69).toBe(true)
		expect(u70).toBe(true)
		expect(u71).toBe(true)
	end)
end)
describe("Janitor.Get", function() -- line: 392
	-- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy)
	it("should return the value iff it exists", function() -- line: 393
		-- upvalues: Parent (copy), NoOperation (copy), expect (copy)
		local v72 = Parent.new()

		v72:Add(NoOperation, true, "Function")
		expect(v72:Get("Function")).toBe(NoOperation)
		v72:Destroy()
	end)
	it("should return void iff the value doesn't exist", function() -- line: 400
		-- upvalues: Parent (copy), expect (copy)
		local v73 = Parent.new()

		expect(v73:Get("Function")).toBeUndefined()
		v73:Destroy()
	end)
end)
describe("Janitor.Cleanup", function() -- line: 407
	-- upvalues: it (copy), Parent (copy), expect (copy), AwaitCondition (copy)
	it("should cleanup everything", function() -- line: 408
		-- upvalues: Parent (copy), expect (copy)
		local v74 = Parent.new()
		local n5 = 0

		for _ = 1, 500 do
			v74:Add(function() -- line: 414
				-- upvalues: n5 (ref)
				n5 += 1
			end, true)
		end

		v74:Cleanup()
		expect(n5).toBe(500)

		for _ = 1, 500 do
			v74:Add(function() -- line: 423
				-- upvalues: n5 (ref)
				n5 += 1
			end, true)
		end

		v74:Cleanup()
		expect(n5).toBe(1000)
	end)
	it("should be unique", function() -- line: 432
		-- upvalues: Parent (copy), expect (copy), AwaitCondition (copy)
		local v78 = Parent.new()
		local v79 = Parent.new()
		local n6 = 0

		expect(v78.CurrentlyCleaning).toBe(false)
		expect(v79.CurrentlyCleaning).toBe(false)

		local u81 = false

		for i = 1, 500 do
			if i == 500 then
				v78:Add(function() -- line: 445
					-- upvalues: n6 (ref), u81 (ref)
					n6 += 1
					task.wait(1)
					u81 = true
				end, true)
			else
				v78:Add(function() -- line: 451
					-- upvalues: n6 (ref)
					n6 += 1
				end, true)
			end
		end

		task.spawn(function() -- line: 457
			-- upvalues: v78 (copy)
			v78:Cleanup()
		end)
		task.wait()
		expect(v78.CurrentlyCleaning).toBe(true)
		expect(v79.CurrentlyCleaning).toBe(false)
		expect(AwaitCondition(function() -- line: 465
			-- upvalues: u81 (ref)
			return u81
		end, 5)).toBe(true)
		expect(n6).toBe(500)
	end)
end)
describe("Janitor.Destroy", function() -- line: 472
	-- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy)
	it("should cleanup everything", function() -- line: 473
		-- upvalues: Parent (copy), expect (copy)
		local v83 = Parent.new()
		local n7 = 0

		for _ = 1, 500 do
			v83:Add(function() -- line: 479
				-- upvalues: n7 (ref)
				n7 += 1
			end, true)
		end

		v83:Destroy()
		expect(n7).toBe(500)
	end)
	it("should render the Janitor unusable", function() -- line: 488
		-- upvalues: Parent (copy), expect (copy), NoOperation (copy)
		local v86 = Parent.new()

		v86:Destroy()
		expect(function() -- line: 491
			-- upvalues: v86 (copy), NoOperation (copy)
			v86:Add(NoOperation, true)
		end).toBeTruthy()
	end)
end)
describe("Janitor.LinkToInstance", function() -- line: 497
	-- upvalues: it (copy), Parent (copy), ReplicatedStorage (copy), expect (copy), Workspace (copy), AwaitCondition (copy), NoOperation (copy)
	it("should link to an Instance", function() -- line: 498
		-- upvalues: Parent (copy), ReplicatedStorage (copy), expect (copy)
		local v87 = Parent.new()
		local v88 = v87:Add(Instance.new("Part"), "Destroy")

		v88.Parent = ReplicatedStorage
		expect(function() -- line: 503
			-- upvalues: v87 (copy), v88 (copy)
			v87:LinkToInstance(v88)
		end).never.toThrow()
		v87:Destroy()
	end)
	it("should cleanup once the Instance is destroyed", function() -- line: 510
		-- upvalues: Parent (copy), Workspace (copy), expect (copy)
		local v89 = Parent.new()
		local u90 = false
		local Part = Instance.new("Part")

		Part.Parent = Workspace
		v89:Add(function() -- line: 517
			-- upvalues: u90 (ref)
			u90 = true
		end, true)
		v89:LinkToInstance(Part)
		Part:Destroy()
		task.wait(0.1)
		expect(u90).toBe(true)
		v89:Destroy()
	end)
	it("should work if the Instance is parented to nil when started", function() -- line: 530
		-- upvalues: Parent (copy), Workspace (copy), expect (copy), AwaitCondition (copy)
		local v92 = Parent.new()
		local u93 = false
		local Part = Instance.new("Part")

		v92:Add(function() -- line: 535
			-- upvalues: u93 (ref)
			u93 = true
		end, true)
		v92:LinkToInstance(Part)
		Part.Parent = Workspace
		Part:Destroy()
		expect(AwaitCondition(function() -- line: 543
			-- upvalues: u93 (ref)
			return u93
		end, 1)).toBe(true)
		v92:Destroy()
	end)
	it("should work if the Instance is parented to nil", function() -- line: 549
		-- upvalues: Parent (copy), expect (copy), AwaitCondition (copy)
		local v95 = Parent.new()
		local u96 = false
		local Part = Instance.new("Part")

		v95:Add(function() -- line: 554
			-- upvalues: u96 (ref)
			u96 = true
		end, true)
		v95:LinkToInstance(Part)
		Part:Destroy()
		expect(AwaitCondition(function() -- line: 561
			-- upvalues: u96 (ref)
			return u96
		end, 1)).toBe(true)
		v95:Destroy()
	end)
	it("shouldn't run if the Instance is removed or parented to nil", function() -- line: 567
		-- upvalues: Parent (copy), ReplicatedStorage (copy), NoOperation (copy), expect (copy)
		local v98 = Parent.new()
		local Part = Instance.new("Part")

		Part.Parent = ReplicatedStorage
		v98:Add(NoOperation, true, "Function")
		v98:LinkToInstance(Part)
		Part.Parent = nil
		expect(v98:Get("Function")).toBe(NoOperation)
		Part.Parent = ReplicatedStorage
		expect(v98:Get("Function")).toBe(NoOperation)
		Part:Destroy()
		task.wait(0.1)
		expect(function() -- line: 582
			-- upvalues: v98 (copy)
			v98:Destroy()
		end).never.toThrow()
	end)
end)

return false
