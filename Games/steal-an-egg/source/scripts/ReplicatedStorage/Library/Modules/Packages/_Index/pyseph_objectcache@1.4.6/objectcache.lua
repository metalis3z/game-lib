-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Mutex = require(ReplicatedStorage.Library.Modules.Mutex)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local InvisibleRenderSpace = workspace:WaitForChild("__OBJECTS"):WaitForChild("InvisibleRenderSpace")
local v2 = InvisibleRenderSpace.Size * 0.5
local v3 = InvisibleRenderSpace.Position - v2
local v4 = InvisibleRenderSpace.Position + v2
local v5 = if Constants.IS_MOBILE then 0.006 else 0.004
local v6 = table.create(10000)
local v7 = table.create(10000)
local v8 = if Constants.IS_CLIENT then {} else nil
local v9 = false

local function UpdateMovement() --[[ UpdateMovement | Line: 27 | Upvalues: v6 (copy), v7 (copy), v9 (ref) ]]
	while true do
		workspace:BulkMoveTo(v6, v7, Enum.BulkMoveMode.FireCFrameChanged)
		table.clear(v6)
		table.clear(v7)
		v9 = false
		coroutine.yield()
	end
end

local v10 = coroutine.create(UpdateMovement)
local t = {}

t.__index = t

local function randFloat(p1, p2) --[[ randFloat | Line: 60 ]]
	return math.random() * (p2 - p1) + p1
end

local function hiddenCFrame() --[[ hiddenCFrame | Line: 64 | Upvalues: v3 (ref), v4 (ref) ]]
	local v1 = CFrame.new
	local X = v3.X
	local v2 = math.random() * (v4.X - X) + X
	local Y = v3.Y
	local v32 = math.random() * (v4.Y - Y) + Y
	local Z = v3.Z

	return v1(v2, v32, math.random() * (v4.Z - Z) + Z)
end

function t._GetNew(p1, p2, p3) --[[ _GetNew | Line: 72 | Upvalues: v3 (ref), v4 (ref), v5 (copy) ]]
	if p3 then
		warn((("ObjectCache: Cache retrieval exceeded preallocated amount! expanding by %*..."):format(p2)))
	end

	local _FreeObjects = p1._FreeObjects
	local v1 = #p1._FreeObjects
	local CacheHolder = p1.CacheHolder
	local _IsTemplateModel = p1._IsTemplateModel
	local _Template = p1._Template
	local v2 = table.create(p2)
	local v32 = table.create(p2)
	local v42 = os.clock()

	for i = v1 + 1, v1 + p2 do
		local v52 = _Template:Clone()
		local v6 = if _IsTemplateModel then v52.PrimaryPart else v52

		_FreeObjects[i] = v6
		p1._DesiredAnchored[v6] = v6.Anchored
		v6.Anchored = true
		v52.Parent = CacheHolder

		local v7 = i - v1

		v2[v7] = v6

		local v8 = CFrame.new
		local X = v3.X
		local v9 = math.random() * (v4.X - X) + X
		local Y = v3.Y
		local v10 = math.random() * (v4.Y - Y) + Y
		local Z = v3.Z

		v32[v7] = v8(v9, v10, math.random() * (v4.Z - Z) + Z)

		if v5 <= os.clock() - v42 then
			task.wait()
			v42 = os.clock()
		end
	end

	workspace:BulkMoveTo(v2, v32, Enum.BulkMoveMode.FireCFrameChanged)

	return table.remove(_FreeObjects)
end
function t.GetPart(p1, p2) --[[ GetPart | Line: 116 | Upvalues: v1 (copy), v6 (copy), v7 (copy), v9 (ref), v10 (copy) ]]
	local v12 = table.remove(p1._FreeObjects)

	if not v12 then
		p1._ExpandMutex:run(function() --[[ Line: 119 | Upvalues: v1 (ref), p1 (copy), v12 (ref) ]]
			v1:AtTrace():Log("free objects at creation:", p1._FreeObjects, "SELF", p1)
			v12 = p1:_GetNew(p1._ExpandAmount, true)
			v1:AtTrace():Log("part found after expanding cache:", v12, "self:", p1)
		end)
	end

	assert(v12, "ObjectCache: failed to allocate part")
	p1._Objects[v12] = nil

	if p2 then
		table.insert(v6, v12)
		table.insert(v7, p2)

		if not v9 then
			v9 = true
			task.defer(v10)
		end
	end

	local v4 = p1._DesiredAnchored[v12]

	if v4 ~= nil then
		p1._DesiredAnchored[v12] = nil
		task.defer(function() --[[ Line: 146 | Upvalues: v12 (ref), v4 (copy) ]]
			v12.Anchored = v4
		end)
	end

	return v12
end
function t.ReturnPart(p1, p2) --[[ ReturnPart | Line: 154 | Upvalues: v6 (copy), v7 (copy), hiddenCFrame (copy), v9 (ref), v10 (copy) ]]
	if p1._Objects[p2] then
		return
	end

	p1._Objects[p2] = true
	p1._DesiredAnchored[p2] = p2.Anchored
	p2.Anchored = true
	table.insert(p1._FreeObjects, p2)
	table.insert(v6, p2)
	table.insert(v7, hiddenCFrame())

	if v9 then
		return
	end

	v9 = true
	task.defer(v10)
end
function t.Update(p1) --[[ Update | Line: 174 | Upvalues: v10 (copy) ]]
	task.spawn(v10)
end
function t.ExpandCache(p1, p2) --[[ ExpandCache | Line: 178 ]]
	local v1 = if typeof(p2) == "number" then if p2 >= 0 then true else false else true

	assert(v1, (("Invalid argument #1 to \'ObjectCache:ExpandCache\' (positive number expected, got %*)"):format((typeof(p2)))))
	p1._ExpandMutex:run(function() --[[ Line: 184 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:_GetNew(p2, false)
	end)

	return p1
end
function t.SetExpandAmount(p1, p2) --[[ SetExpandAmount | Line: 190 ]]
	local v1 = if typeof(p2) == "number" then if p2 > 0 then true else false else true

	assert(v1, (("Invalid argument #1 to \'ObjectCache:SetExpandAmount\' (positive number expected, got %*)"):format((typeof(p2)))))
	p1._ExpandAmount = p2

	return p1
end
function t.IsInUse(p1, p2) --[[ IsInUse | Line: 200 ]]
	return p1._Objects[p2] == nil
end

local function CollectFlush(p1, p2, p3) --[[ CollectFlush | Line: 204 | Upvalues: v6 (copy), v7 (copy) ]]
	debug.profilebegin("ObjectCache :: CollectFlush")

	for i, v in ipairs(p1._FreeObjects) do
		table.insert(v6, v)

		local v3 = CFrame.new
		local X = p2.X
		local v4 = math.random() * (p3.X - X) + X
		local Y = p2.Y
		local v5 = math.random() * (p3.Y - Y) + Y
		local Z = p2.Z

		table.insert(v7, v3(v4, v5, math.random() * (p3.Z - Z) + Z))
	end

	debug.profileend()
end

function t.FlushToBounds(p1, p2, p3) --[[ FlushToBounds | Line: 218 | Upvalues: CollectFlush (copy), v9 (ref), v10 (copy) ]]
	CollectFlush(p1, p2, p3)

	if v9 then
		return
	end

	v9 = true
	task.defer(v10)
end
function t.Destroy(p1) --[[ Destroy | Line: 227 | Upvalues: v8 (copy) ]]
	debug.profilebegin("ObjectCache :: Destroy")

	if v8 then
		v8[p1] = nil
	end

	p1.CacheHolder:Destroy()
	debug.profileend()
end

local function GetCacheContainer() --[[ GetCacheContainer | Line: 238 ]]
	local ObjectCache = Instance.new("Folder")

	ObjectCache.Name = "ObjectCache"

	return ObjectCache
end

return {
	new = function(p1, p2, p3) --[[ new | Line: 246 | Upvalues: Mutex (copy), t (copy), v3 (ref), v4 (ref), v5 (copy), v8 (copy) ]]
		local v1 = typeof(p1)

		assert(if v1 == "Instance" then true else false, (("Invalid argument #1 to \'ObjectCache.new\' (BasePart expected, got %*)"):format(v1)))
		assert(p1:IsA("BasePart") or p1:IsA("Model"), (("Invalid argument #1 to \'ObjectCache.new\' (BasePart or Model expected, got %*)"):format(p1.ClassName)))
		assert(p1.Archivable, "ObjectCache: Cannot use template object provided, as it has Archivable set to false.")

		if p1:IsA("Model") then
			assert(p1.PrimaryPart ~= nil, "Invalid Template provided to \'ObjectCache.new\': Model has no PrimaryPart set!")
		end

		local v6 = typeof(p2)

		assert(if p2 == nil then true elseif v6 == "number" then true else false, (("Invalid argument #2 to \'ObjectCache.new\' (number expected, got %*)"):format(v6)))
		assert(if p2 == nil then true elseif p2 >= 0 then true else false, (("Invalid argument #2 to \'ObjectCache.new\' (positive number expected, got %*)"):format(p2)))

		local v11 = typeof(p3)

		assert(if p3 == nil then true elseif v11 == "Instance" then true else false, (("Invalid argument #3 to \'ObjectCache.new\' (Instance expected, got %*)"):format(v11)))

		local v14 = p2 or 1
		local ObjectCache = Instance.new("Folder")

		ObjectCache.Name = "ObjectCache"

		local v15 = table.create(v14)
		local t2 = {}
		local v16 = p1:IsA("Model")
		local v18 = setmetatable({
			CacheHolder = ObjectCache,
			_ExpandAmount = p2 or 1,
			_Template = p1,
			_FreeObjects = v15,
			_Objects = {},
			_IsTemplateModel = v16,
			_PreallocatedAmount = v14,
			_DesiredAnchored = t2,
			_ExpandMutex = Mutex.new()
		}, t)

		if p3 then
			ObjectCache.Parent = p3
		else
			ObjectCache.Parent = workspace
		end

		local v19 = ObjectCache
		local v20 = os.clock()

		for i = 1, v14 do
			local v21 = p1:Clone()
			local v22 = if v16 then v21.PrimaryPart else v21

			v15[i] = v22
			t2[v22] = v22.Anchored
			v22.Anchored = true
			v21.Parent = v19

			local v23 = CFrame.new
			local X = v3.X
			local v24 = math.random() * (v4.X - X) + X
			local Y = v3.Y
			local v25 = math.random() * (v4.Y - Y) + Y
			local Z = v3.Z

			v22.CFrame = v23(v24, v25, math.random() * (v4.Z - Z) + Z)

			if v5 <= os.clock() - v20 then
				task.wait()
				v20 = os.clock()
			end
		end

		if v8 then
			v8[v18] = true
		end

		return v18
	end,
	SetInvisibleBounds = function(p1, p2) --[[ SetInvisibleBounds | Line: 338 | Upvalues: v3 (ref), v4 (ref) ]]
		v3 = p1
		v4 = p2
	end,
	is = function(p1) --[[ is | Line: 343 | Upvalues: t (copy) ]]
		if typeof(p1) ~= "table" then
			return false
		end

		return getmetatable(p1) == t
	end,
	GetRandomHiddenCFrame = hiddenCFrame
}