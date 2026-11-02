--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)

local function DestroyThing(p1) --[[ DestroyThing | Line: 60 ]]
	if typeof(p1) == "RBXScriptConnection" then
		task.spawn(p1.Disconnect, p1)

		return
	end

	if typeof(p1) == "Instance" then
		if p1:IsA("AnimationTrack") and p1.IsPlaying then
			task.spawn(function() --[[ Line: 66 | Upvalues: p1 (copy) ]]
				p1:Stop(0.05)
				task.delay(0.11666666666666667, function() --[[ Line: 68 | Upvalues: p1 (ref) ]]
					p1:Destroy()
				end)
			end)

			return
		end

		task.spawn(p1.Destroy, p1)
	else
		if type(p1) == "thread" then
			pcall(task.cancel, p1)

			return
		end

		if type(p1) == "function" then
			task.spawn(p1)

			return
		end

		if type(p1) ~= "table" then
			return
		end

		task.spawn(function(p1) --[[ Line: 80 ]]
			if p1.Destroy then
				p1:Destroy()

				return
			end

			if not p1.Disconnect then
				return
			end

			p1:Disconnect()
		end, p1)
	end
end

local function Destroy(p1) --[[ Destroy | Line: 90 | Upvalues: DestroyThing (copy) ]]
	if p1.Destroyed then
		return false
	end

	p1.Destroyed = true

	for i, v in ipairs(p1.Things) do
		DestroyThing(v)
	end

	p1.Destroying:Fire()

	return true
end

local function IsDestroyed(p1) --[[ IsDestroyed | Line: 102 ]]
	return p1.Destroyed
end

local function Add(p1, p2) --[[ Add | Line: 106 | Upvalues: DestroyThing (copy) ]]
	if p2 ~= nil then
		if typeof(p2) ~= "RBXScriptConnection" and (typeof(p2) ~= "Instance" and (type(p2) ~= "thread" and type(p2) ~= "function")) then
			if type(p2) == "table" then
				if type(p2.Destroy) ~= "function" and type(p2.Disconnect) ~= "function" then
					error("Unknown thing: table (missing Destroy/Disconnect)")
				end
			else
				error((("Unknown thing: %*"):format((typeof(p2)))))
			end
		end

		if not p1.Destroyed then
			table.insert(p1.Things, p2)

			return p2
		end

		DestroyThing(p2)
	end

	return p2
end

local t = {
	Destroy = Destroy,
	IsDestroyed = IsDestroyed,
	Add = Add
}
local v1 = table.freeze({
	__index = t,
	__call = Add
})

table.freeze(t)

return table.freeze({
	new = function() --[[ new | Line: 147 | Upvalues: Bindable (copy), v1 (copy) ]]
		return setmetatable({
			Destroyed = false,
			Destroying = Bindable.new(),
			Things = {}
		}, v1)
	end
})