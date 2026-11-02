

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replion = require(ReplicatedStorage.Packages.Replion)
local Signal = require(ReplicatedStorage.Packages.Signal)

require(script.Parent.Types)

local t1 = {
	_loaded = false,
	_updatedSignal = Signal.new(),
	_loadedSignal = Signal.new(),
	IsLoaded = function(_)
		return (Replion.Client:WaitReplion("FFlags"):Get("Loaded"))
	end,
	OnLoad = function(p2, p3)
		return p2._loadedSignal:Connect(p3)
	end,
	OnUpdate = function(p4, p5)
		return p4._updatedSignal:Connect(p5)
	end,
	OnChange = function(_, p7, p8)
		return Replion.Client:WaitReplion("FFlags"):OnChange({
			"Values",
			p7
		}, p8)
	end,
	Get = function(p9, p10, p11)
		local v16 = Replion.Client:WaitReplion("FFlags")

		if not p9:IsLoaded() then
			p9._loadedSignal:Wait()
		end

		local v17 = v16:Get({
			"Values",
			p10
		})

		if v17 == nil then
			return p11
		end

		return v17
	end,
	GetInstant = function(_, p13, p14)
		local Replion2 = Replion.Client:GetReplion("FFlags")

		if not Replion2 then
			return p14
		end

		local v22 = Replion2:Get({
			"Values",
			p13
		})

		if v22 == nil then
			return p14
		end

		return v22
	end,
	_loadMemoryStore = function(_)
		warn("FFlags:_loadMemoryStore() cannot be used on the client!")

		return false
	end,
	_loadDataStore = function(_)
		warn("FFlags:_loadDataStore() cannot be used on the client!")

		return false
	end,
	Set = function(_)
		warn("FFlags:Set() cannot be used on the client!")

		return false
	end,
	Load = function(_)
		warn("FFlags:Load() cannot be used on the client!")

		return false
	end,
	Start = function(p19)
		local v28 = Replion.Client:WaitReplion("FFlags")

		p19._loaded = v28:Get("Loaded")

		local u29 = nil

		u29 = v28:OnChange("Loaded", function(b1: boolean, b2: boolean)
			if b1 and not b2 then
				p19._loaded = b1
				p19._loadedSignal:Fire(v28.Data)

				if u29.Connected then
					u29:Disconnect()
				end
			end
		end)
		v28:OnChange("LastChange", function(_: number, _: number)
			p19._updatedSignal:Fire(v28.Data)
		end)
	end
}

task.spawn(t1.Start, t1)

return t1
