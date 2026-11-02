
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Models = ReplicatedStorage:WaitForChild("Models")
local Animals = Models:WaitForChild("Animals")
local TraitsPerAnimal = Models:WaitForChild("TraitsPerAnimal")
local SpawnEffectsController = ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("SpawnEffectsController")
local t1 = {}

local function getSharedModel(s1: string)
	return Animals:FindFirstChild(s1)
end

local function getSharedTrait(s2: string, s3: string)
	local s2_2 = TraitsPerAnimal:FindFirstChild(s2)
	return s2_2 and s2_2:FindFirstChild(s3)
end

local function getSharedEffect(s4: string)
	return SpawnEffectsController:FindFirstChild(s4)
end

if RunService:IsServer() then
	local ServerStorage = game:GetService("ServerStorage")
	local __AssetLibrary = nil

	local function getLibraryFolder()
		if not __AssetLibrary then
			__AssetLibrary = ServerStorage:FindFirstChild("__AssetLibrary")
		end
		return __AssetLibrary
	end

	local function getLibraryTrait(animalName: string, traitName: string)
		local lib = getLibraryFolder()
		local tFolder = lib and lib:FindFirstChild("t")
		local animalFolder = tFolder and tFolder:FindFirstChild(animalName)
		return animalFolder and animalFolder:FindFirstChild(traitName)
	end

	function t1.getModel(s5: string)
		if not __AssetLibrary then
			__AssetLibrary = ServerStorage:FindFirstChild("__AssetLibrary")
		end
		local v23 = __AssetLibrary
		local v24 = v23 and v23:FindFirstChild("m")
		return v24 and v24:FindFirstChild(s5) or Animals:FindFirstChild(s5)
	end

	function t1.getTrait(s6: string, s7: string)
		if not __AssetLibrary then
			__AssetLibrary = ServerStorage:FindFirstChild("__AssetLibrary")
		end
		local v27 = __AssetLibrary
		local v28 = v27 and v27:FindFirstChild("t")
		local v30 = v28 and v28:FindFirstChild(s7)

		if not v30 then
			local s6_2 = TraitsPerAnimal:FindFirstChild(s6)
			v30 = s6_2 and s6_2:FindFirstChild(s7)
		end

		return v30
	end

	function t1.getEffect(s8: string)
		if not __AssetLibrary then
			__AssetLibrary = ServerStorage:FindFirstChild("__AssetLibrary")
		end
		local v33 = __AssetLibrary
		local v34 = v33 and v33:FindFirstChild("e")
		return v34 and v34:FindFirstChild(s8) or SpawnEffectsController:FindFirstChild(s8)
	end

	function t1.getEventAsset(s9: string, s10: string)
		if not __AssetLibrary then
			__AssetLibrary = ServerStorage:FindFirstChild("__AssetLibrary")
		end
		local v37 = __AssetLibrary
		local v38 = v37 and v37:FindFirstChild("v")
		local v39 = v38 and v38:FindFirstChild(s9)
		return v39 and v39:FindFirstChild(s10)
	end

	function t1.getSize(s11: string)
		local v41 = t1.getModel(s11)
		return v41 and v41:GetExtentsSize()
	end

	function t1.preload(_: {[any]: any})
	end

	return t1
end

local AssetStreamController = require(ReplicatedStorage.Controllers.AssetStreamController)
local BrainrotSizes = nil

local function getSizesFolder()
	if not BrainrotSizes then
		BrainrotSizes = ReplicatedStorage:FindFirstChild("BrainrotSizes")
	end
	return BrainrotSizes
end

function t1.getModel(s12: string)
	local s12_2 = Animals:FindFirstChild(s12)
	if s12_2 then
		return s12_2
	end
	return AssetStreamController.waitForAsset("m", s12)
end

function t1.getTrait(s13: string, s14: string)
	local s13_2 = TraitsPerAnimal:FindFirstChild(s13)
	local v48 = s13_2 and s13_2:FindFirstChild(s14)
	if v48 then
		return v48
	end
	return AssetStreamController.waitForAsset("t", s13 .. "\001" .. s14)
end

function t1.getEffect(s15: string)
	local s15_2 = SpawnEffectsController:FindFirstChild(s15)
	if s15_2 then
		return s15_2
	end
	return AssetStreamController.waitForAsset("e", s15)
end

function t1.getEventAsset(s16: string, s17: string)
	return AssetStreamController.waitForAsset("v", s16 .. "\001" .. s17)
end

function t1.getSize(s18: string)
	local s18_2 = Animals:FindFirstChild(s18)
	if s18_2 then
		return s18_2:GetExtentsSize()
	end

	if not BrainrotSizes then
		BrainrotSizes = ReplicatedStorage:FindFirstChild("BrainrotSizes")
	end

	local v55 = BrainrotSizes
	local v56 = v55 and v55:FindFirstChild(s18)
	if v56 and v56:IsA("Vector3Value") then
		return v56.Value
	end

	return nil
end

function t1.preload(t3: {[any]: any})
	local t4 = {}
	for _, v60 in t3 do
		if not Animals:FindFirstChild(v60) then
			table.insert(t4, v60)
		end
	end
	if #t4 > 0 then
		AssetStreamController.requestAssets("m", t4)
	end
end

return t1