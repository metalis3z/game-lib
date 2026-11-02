-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Promise = require(script.Parent.Promise)
local Signal = require(script.Parent.Signal)
local Symbol = require(script.Parent.Symbol)
local Trove = require(script.Parent.Trove)
local v1 = RunService:IsServer()
local t = { workspace, game:GetService("Players") }
local v2 = Symbol("Ancestors")
local v3 = Symbol("InstancesToComponents")
local v4 = Symbol("LockConstruct")
local v5 = Symbol("Components")
local v6 = Symbol("Trove")
local v7 = Symbol("Extensions")
local v8 = Symbol("ActiveExtensions")
local v9 = Symbol("Starting")
local v10 = Symbol("Started")
local v11 = 0

local function NextRenderName() --[[ NextRenderName | Line: 193 | Upvalues: v11 (ref) ]]
	v11 = v11 + 1

	return "ComponentRender" .. tostring(v11)
end

local function InvokeExtensionFn(p1, p2) --[[ InvokeExtensionFn | Line: 198 | Upvalues: v8 (copy) ]]
	for i, v in ipairs(p1[v8]) do
		local v1 = v[p2]

		if type(v1) == "function" then
			v1(p1)
		end
	end
end

local function ShouldConstruct(p1) --[[ ShouldConstruct | Line: 207 | Upvalues: v8 (copy) ]]
	for i, v in ipairs(p1[v8]) do
		local ShouldConstruct = v.ShouldConstruct

		if type(ShouldConstruct) == "function" and not ShouldConstruct(p1) then
			return false
		end
	end

	return true
end

local function GetActiveExtensions(p1, p2) --[[ GetActiveExtensions | Line: 220 ]]
	local v1 = table.create(#p2)
	local v2 = true

	for i, v in ipairs(p2) do
		local ShouldExtend = v.ShouldExtend

		if if type(ShouldExtend) == "function" then ShouldExtend(p1) and true or false else true then
			table.insert(v1, v)

			continue
		end

		v2 = false
	end

	if v2 then
		return p2
	end

	return v1
end

local t2 = {}

t2.__index = t2
function t2.new(p1) --[[ new | Line: 299 | Upvalues: v2 (copy), t (copy), v3 (copy), v5 (copy), v4 (copy), v6 (copy), Trove (copy), v7 (copy), v10 (copy), Signal (copy), t2 (copy) ]]
	local t3 = {}

	t3.__index = t3
	function t3.__tostring() --[[ Line: 302 | Upvalues: p1 (copy) ]]
		return "Component<" .. p1.Tag .. ">"
	end
	t3[v2] = p1.Ancestors or t
	t3[v3] = {}
	t3[v5] = {}
	t3[v4] = {}
	t3[v6] = Trove.new()
	t3[v7] = p1.Extensions or {}
	t3[v10] = false
	t3.Tag = p1.Tag
	t3.Started = t3[v6]:Construct(Signal)
	t3.Stopped = t3[v6]:Construct(Signal)
	setmetatable(t3, t2)
	t3:_setup()

	return t3
end
function t2._instantiate(p1, p2) --[[ _instantiate | Line: 320 | Upvalues: v8 (copy), GetActiveExtensions (copy), v7 (copy), ShouldConstruct (copy), InvokeExtensionFn (copy) ]]
	local v1 = setmetatable({}, p1)

	v1.Instance = p2
	v1[v8] = GetActiveExtensions(v1, p1[v7])

	if not ShouldConstruct(v1) then
		return nil
	end

	InvokeExtensionFn(v1, "Constructing")

	if type(v1.Construct) == "function" then
		v1:Construct()
	end

	InvokeExtensionFn(v1, "Constructed")

	return v1
end
function t2._setup(p1) --[[ _setup | Line: 335 | Upvalues: v9 (copy), InvokeExtensionFn (copy), RunService (copy), v1 (copy), v11 (ref), v10 (copy), v4 (copy), v3 (copy), v5 (copy), v2 (copy), v6 (copy), CollectionService (copy) ]]
	local t = {}

	local function StartComponent(p12) --[[ StartComponent | Line: 338 | Upvalues: v9 (ref), InvokeExtensionFn (ref), RunService (ref), v1 (ref), v11 (ref), v10 (ref), p1 (copy) ]]
		p12[v9] = coroutine.running()
		InvokeExtensionFn(p12, "Starting")
		p12:Start()

		if p12[v9] == nil then
			return
		end

		InvokeExtensionFn(p12, "Started")

		local v12 = typeof(p12.HeartbeatUpdate) == "function"
		local v2 = if typeof(p12.SteppedUpdate) == "function" then true else false
		local v3 = if typeof(p12.RenderSteppedUpdate) == "function" then true else false

		if v12 then
			p12._heartbeatUpdate = RunService.Heartbeat:Connect(function(p1) --[[ Line: 356 | Upvalues: p12 (copy) ]]
				p12:HeartbeatUpdate(p1)
			end)
		end

		if v2 then
			p12._steppedUpdate = RunService.Stepped:Connect(function(p1, p2) --[[ Line: 362 | Upvalues: p12 (copy) ]]
				p12:SteppedUpdate(p2)
			end)
		end

		if v3 and not v1 and p12.RenderPriority then
			v11 = v11 + 1
			p12._renderName = "ComponentRender" .. tostring(v11)
			RunService:BindToRenderStep(p12._renderName, p12.RenderPriority, function(p1) --[[ Line: 370 | Upvalues: p12 (copy) ]]
				p12:RenderSteppedUpdate(p1)
			end)
		elseif v3 and not v1 then
			p12._renderSteppedUpdate = RunService.RenderStepped:Connect(function(p1) --[[ Line: 374 | Upvalues: p12 (copy) ]]
				p12:RenderSteppedUpdate(p1)
			end)
		end

		p12[v10] = true
		p12[v9] = nil
		p1.Started:Fire(p12)
	end

	local function StopComponent(p12) --[[ StopComponent | Line: 386 | Upvalues: v9 (ref), RunService (ref), InvokeExtensionFn (ref), p1 (copy) ]]
		if p12[v9] then
			local v1 = p12[v9]

			if coroutine.status(v1) == "normal" then
				task.defer(function() --[[ Line: 395 | Upvalues: v1 (copy) ]]
					pcall(function() --[[ Line: 396 | Upvalues: v1 (ref) ]]
						task.cancel(v1)
					end)
				end)
			else
				pcall(function() --[[ Line: 391 | Upvalues: v1 (copy) ]]
					task.cancel(v1)
				end)
			end

			p12[v9] = nil
		end

		if p12._heartbeatUpdate then
			p12._heartbeatUpdate:Disconnect()
		end

		if p12._steppedUpdate then
			p12._steppedUpdate:Disconnect()
		end

		if p12._renderSteppedUpdate then
			p12._renderSteppedUpdate:Disconnect()
		elseif p12._renderName then
			RunService:UnbindFromRenderStep(p12._renderName)
		end

		InvokeExtensionFn(p12, "Stopping")
		p12:Stop()
		InvokeExtensionFn(p12, "Stopped")
		p1.Stopped:Fire(p12)
	end

	local function SafeConstruct(p12, p2) --[[ SafeConstruct | Line: 424 | Upvalues: p1 (copy), v4 (ref) ]]
		if p1[v4][p12] ~= p2 then
			return nil
		end

		local v1 = p1:_instantiate(p12)

		if p1[v4][p12] == p2 then
			return v1
		end

		return nil
	end

	local function TryConstructComponent(p12) --[[ TryConstructComponent | Line: 435 | Upvalues: p1 (copy), v3 (ref), v4 (ref), v5 (ref), StartComponent (copy) ]]
		if not p1[v3][p12] then
			local v1 = (p1[v4][p12] or 0) + 1

			p1[v4][p12] = v1
			task.defer(function() --[[ Line: 442 | Upvalues: p12 (copy), v1 (ref), p1 (ref), v4 (ref), v3 (ref), v5 (ref), StartComponent (ref) ]]
				local v12 = p12
				local v2 = v1
				local v322 = if p1[v4][v12] == v2 then if p1[v4][v12] == v2 then p1:_instantiate(v12) else nil else nil

				if v322 then
					p1[v3][p12] = v322

					local v52 = p1[v5]

					table.insert(v52, v322)
					task.defer(function() --[[ Line: 449 | Upvalues: p1 (ref), v3 (ref), p12 (ref), v322 (copy), StartComponent (ref) ]]
						if p1[v3][p12] ~= v322 then
							return
						end

						StartComponent(v322)
					end)
				end
			end)
		end
	end

	local function TryDeconstructComponent(p12) --[[ TryDeconstructComponent | Line: 457 | Upvalues: p1 (copy), v3 (ref), v4 (ref), v5 (ref), v10 (ref), v9 (ref), StopComponent (copy) ]]
		local v1 = p1[v3][p12]

		if not v1 then
			return
		end

		p1[v3][p12] = nil
		p1[v4][p12] = nil

		local v2 = p1[v5]
		local v32 = table.find(v2, v1)

		if v32 then
			local v42 = #v2

			v2[v32] = v2[v42]
			v2[v42] = nil
		end

		if not (v1[v10] or v1[v9]) then
			return
		end

		task.spawn(StopComponent, v1)
	end

	local function StartWatchingInstance(p12) --[[ StartWatchingInstance | Line: 476 | Upvalues: t (copy), p1 (copy), v2 (ref), v6 (ref), v3 (ref), v4 (ref), v5 (ref), StartComponent (copy), TryDeconstructComponent (copy) ]]
		if t[p12] then
			return
		end

		local function IsInAncestorList() --[[ IsInAncestorList | Line: 480 | Upvalues: p1 (ref), v2 (ref), p12 (copy) ]]
			for i, v in ipairs(p1[v2]) do
				if p12:IsDescendantOf(v) then
					return true
				end
			end

			return false
		end

		t[p12] = p1[v6]:Connect(p12.AncestryChanged, function(p13, p2) --[[ Line: 488 | Upvalues: p1 (ref), v2 (ref), p12 (copy), v3 (ref), v4 (ref), v5 (ref), StartComponent (ref), TryDeconstructComponent (ref) ]]
			if not p2 then
				TryDeconstructComponent(p12)

				return
			end

			local v1 = false

			for i, v in ipairs(p1[v2]) do
				if p12:IsDescendantOf(v) then
					v1 = true

					break
				end
			end

			if not v1 then
				TryDeconstructComponent(p12)

				return
			end

			local v22 = p12

			if not p1[v3][v22] then
				local v32 = (p1[v4][v22] or 0) + 1

				p1[v4][v22] = v32
				task.defer(function() --[[ Line: 442 | Upvalues: v22 (copy), v32 (ref), p1 (ref), v4 (ref), v3 (ref), v5 (ref), StartComponent (ref) ]]
					local v12 = v22
					local v2 = v32
					local v322 = if p1[v4][v12] == v2 then if p1[v4][v12] == v2 then p1:_instantiate(v12) else nil else nil

					if v322 then
						p1[v3][v22] = v322

						local v52 = p1[v5]

						table.insert(v52, v322)
						task.defer(function() --[[ Line: 449 | Upvalues: p1 (ref), v3 (ref), v22 (ref), v322 (copy), StartComponent (ref) ]]
							if p1[v3][p12] ~= v322 then
								return
							end

							StartComponent(v322)
						end)
					end
				end)
			end
		end)

		local v1 = false

		for i, v in ipairs(p1[v2]) do
			if p12:IsDescendantOf(v) then
				v1 = true

				break
			end
		end

		if not v1 then
			return
		end

		if p1[v3][p12] then
			return
		end

		local v22 = (p1[v4][p12] or 0) + 1

		p1[v4][p12] = v22
		task.defer(function() --[[ Line: 442 | Upvalues: p12 (copy), v22 (ref), p1 (ref), v4 (ref), v3 (ref), v5 (ref), StartComponent (ref) ]]
			local v12 = p12
			local v2 = v22
			local v322 = if p1[v4][v12] == v2 then if p1[v4][v12] == v2 then p1:_instantiate(v12) else nil else nil

			if v322 then
				p1[v3][p12] = v322

				local v52 = p1[v5]

				table.insert(v52, v322)
				task.defer(function() --[[ Line: 449 | Upvalues: p1 (ref), v3 (ref), p12 (ref), v322 (copy), StartComponent (ref) ]]
					if p1[v3][p12] ~= v322 then
						return
					end

					StartComponent(v322)
				end)
			end
		end)
	end

	local function InstanceTagged(p1) --[[ InstanceTagged | Line: 501 | Upvalues: StartWatchingInstance (copy) ]]
		StartWatchingInstance(p1)
	end

	local function InstanceUntagged(p12) --[[ InstanceUntagged | Line: 505 | Upvalues: t (copy), p1 (copy), v6 (ref), TryDeconstructComponent (copy) ]]
		local v1 = t[p12]

		if v1 then
			t[p12] = nil
			p1[v6]:Remove(v1)
		end

		TryDeconstructComponent(p12)
	end

	p1[v6]:Connect(CollectionService:GetInstanceAddedSignal(p1.Tag), InstanceTagged)
	p1[v6]:Connect(CollectionService:GetInstanceRemovedSignal(p1.Tag), InstanceUntagged)

	for i, v in ipairs((CollectionService:GetTagged(p1.Tag))) do
		task.defer(InstanceTagged, v)
	end
end
function t2.GetAll(p1) --[[ GetAll | Line: 542 | Upvalues: v5 (copy) ]]
	return p1[v5]
end
function t2.FromInstance(p1, p2) --[[ FromInstance | Line: 559 | Upvalues: v3 (copy) ]]
	return p1[v3][p2]
end
function t2.WaitForInstance(p1, p2, p3) --[[ WaitForInstance | Line: 582 | Upvalues: v10 (copy), Promise (copy) ]]
	local v1 = p1:FromInstance(p2)

	if v1 and v1[v10] then
		return Promise.resolve(v1)
	end

	local v2 = Promise.fromEvent(p1.Started, function(p1) --[[ Line: 587 | Upvalues: p2 (copy), v1 (ref) ]]
		local isInstance = p1.Instance == p2

		if not isInstance then
			return isInstance
		end

		v1 = p1

		return isInstance
	end):andThen(function() --[[ Line: 594 | Upvalues: v1 (ref) ]]
		return v1
	end)

	return v2:timeout(if type(p3) == "number" then p3 else 60)
end
function t2.Construct(p1) --[[ Construct | Line: 614 ]] end
function t2.Start(p1) --[[ Start | Line: 631 ]] end
function t2.Stop(p1) --[[ Stop | Line: 651 ]] end
function t2.GetComponent(p1, p2) --[[ GetComponent | Line: 670 | Upvalues: v3 (copy) ]]
	return p2[v3][p1.Instance]
end
function t2.Destroy(p1) --[[ Destroy | Line: 755 | Upvalues: v6 (copy) ]]
	p1[v6]:Destroy()
end

return t2