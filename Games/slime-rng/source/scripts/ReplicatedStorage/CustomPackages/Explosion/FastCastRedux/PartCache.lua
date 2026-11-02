-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: PartCache, time of decompilation: Sun May  3 10:09:19 2026 ]]
local Table = require(script.Parent:WaitForChild("Table"))
local t1 = {}

t1.__index = t1
t1.__type = "PartCache"

local cFrame = CFrame.new(0, 1000000000, 0)

function t1.new(p1, n1: number?, p2) -- line: 77
	-- upvalues: t1 (copy), Table (copy), cFrame (copy)
	local v12 = n1 or 5
	local v13 = p2 or workspace

	assert(n1 > 0, "PrecreatedParts can not be negative!")

	if n1 ~= 0 == false then
		warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
	end

	if p1.Archivable == false then
		warn("The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")
	end

	local Archivable = p1.Archivable

	p1.Archivable = true

	local clone = p1:Clone()

	p1.Archivable = Archivable

	local t2 = {
		ExpansionSize = 10,
		Open = {},
		InUse = {},
		CurrentCacheParent = v13,
		Template = clone
	}

	setmetatable(t2, t1)

	for _ = 1, v12 do
		local insert = Table.insert
		local Open = t2.Open
		local CurrentCacheParent = t2.CurrentCacheParent
		local clone2 = clone:Clone()

		clone2.CFrame = cFrame
		clone2.Anchored = true
		clone2.Parent = CurrentCacheParent
		insert(Open, clone2)
	end

	t2.Template.Parent = nil

	return t2
end
function t1.GetPart(p3) -- line: 115
	-- upvalues: t1 (copy), Table (copy), cFrame (copy)
	assert(getmetatable(p3) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPart", "PartCache.new"))

	if #p3.Open == 0 then
		warn("No parts available in the cache! Creating [" .. p3.ExpansionSize .. "] new part instance(s) - this amount can be edited by changing the ExpansionSize property of the PartCache instance... (This cache now contains a grand total of " .. tostring(#p3.Open + #p3.InUse + p3.ExpansionSize) .. " parts.)")

		for _ = 1, p3.ExpansionSize do
			local insert = Table.insert
			local Open = p3.Open
			local Template = p3.Template
			local CurrentCacheParent = p3.CurrentCacheParent
			local clone = Template:Clone()

			clone.CFrame = cFrame
			clone.Anchored = true
			clone.Parent = CurrentCacheParent
			insert(Open, clone)
		end
	end

	local v29 = p3.Open[#p3.Open]

	p3.Open[#p3.Open] = nil
	Table.insert(p3.InUse, v29)

	return v29
end
function t1.ReturnPart(t3: {[any]: any}, p4) -- line: 131
	-- upvalues: t1 (copy), Table (copy), cFrame (copy)
	assert(getmetatable(t3) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("ReturnPart", "PartCache.new"))

	local v32 = Table.indexOf(t3.InUse, p4)

	if v32 ~= nil then
		Table.remove(t3.InUse, v32)
		Table.insert(t3.Open, p4)
		p4.CFrame = cFrame
		p4.Anchored = true

		return
	end

	error("Attempted to return part \"" .. p4.Name .. "\" (" .. p4:GetFullName() .. ") to the cache, but it's not in-use! Did you call this on the wrong part?")
end
function t1.SetCacheParent(t4: {[any]: any}, p5) -- line: 146
	-- upvalues: t1 (copy)
	assert(getmetatable(t4) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetCacheParent", "PartCache.new"))
	assert(p5:IsDescendantOf(workspace) or p5 == workspace, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.")
	t4.CurrentCacheParent = p5

	for i = 1, #t4.Open do
		t4.Open[i].Parent = p5
	end

	for i = 1, #t4.InUse do
		t4.InUse[i].Parent = p5
	end
end
function t1.Expand(t5: {[any]: any}, n2: number) -- line: 160
	-- upvalues: t1 (copy), Table (copy), cFrame (copy)
	assert(getmetatable(t5) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Expand", "PartCache.new"))

	if n2 == nil then
		n2 = t5.ExpansionSize
	end

	for _ = 1, n2 do
		local insert = Table.insert
		local Open = t5.Open
		local Template = t5.Template
		local CurrentCacheParent = t5.CurrentCacheParent
		local clone = Template:Clone()

		clone.CFrame = cFrame
		clone.Anchored = true
		clone.Parent = CurrentCacheParent
		insert(Open, clone)
	end
end
function t1.Dispose(p6) -- line: 172
	-- upvalues: t1 (copy)
	assert(getmetatable(p6) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "PartCache.new"))

	for i = 1, #p6.Open do
		p6.Open[i]:Destroy()
	end

	for i = 1, #p6.InUse do
		p6.InUse[i]:Destroy()
	end

	p6.Template:Destroy()
	p6.Open = {}
	p6.InUse = {}
	p6.CurrentCacheParent = nil
	p6.GetPart = nil
	p6.ReturnPart = nil
	p6.SetCacheParent = nil
	p6.Expand = nil
	p6.Dispose = nil
end

return t1
