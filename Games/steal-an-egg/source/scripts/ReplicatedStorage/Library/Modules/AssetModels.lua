-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local AssetModels = ReplicatedStorage.AssetModels
local t = {}
local t2 = {
	_getResolvedAssetModelsFolder = function() --[[ _getResolvedAssetModelsFolder | Line: 38 | Upvalues: AssetModels (copy) ]]
		return AssetModels
	end,
	_assertAssetModel = function(p1, p2) --[[ _assertAssetModel | Line: 43 ]]
		local v2 = assert(p1, (("Asset model \"%*\" was not found"):format(p2)))
		local v3 = v2:IsA("Model")

		assert(v3, (("Asset model \"%*\" is not a Model"):format(p2)))

		return v2
	end
}

function t2._getAvailableAssetModelTemplate(p1) --[[ _getAvailableAssetModelTemplate | Line: 50 | Upvalues: t2 (copy) ]]
	local v1 = t2._getResolvedAssetModelsFolder():FindFirstChild(p1)

	if v1 then
		return t2._assertAssetModel(v1, p1)
	end

	return nil
end
function t2._waitForAssetModelTemplate(p1, p2) --[[ _waitForAssetModelTemplate | Line: 59 | Upvalues: t2 (copy) ]]
	return t2._assertAssetModel(t2._getResolvedAssetModelsFolder():WaitForChild(p1, p2 or 30), p1)
end
function t2._validateAssetModel(p1, p2) --[[ _validateAssetModel | Line: 66 ]]
	assert(p2.PrimaryPart, (("Asset model for %* does not have a PrimaryPart"):format(p1)))

	local CENTER = p2:FindFirstChild("CENTER")

	assert(CENTER, (("Asset model for %* does not have a CENTER part"):format(p1)))
	assert(p2.ModelStreamingMode == Enum.ModelStreamingMode.Atomic, (("Asset model for %* must have Atomic ModelStreamingMode"):format(p1)))
end
function t2._buildVisibleBoundsData(p1) --[[ _buildVisibleBoundsData | Line: 75 | Upvalues: Asserts (copy), t2 (copy), BBFromModelVisibleOnly (copy) ]]
	Asserts.string(p1)

	local v3 = assert(t2.GetModelTemplate(p1), (("Asset model \"%*\" was not found"):format(p1)))
	local v4 = v3.PrimaryPart or v3:FindFirstChild("HumanoidRootPart")

	assert(if v4 == nil then false else v4:IsA("BasePart"), (("Asset model \"%*\" is missing a root part"):format(p1)))

	local v7, v8 = BBFromModelVisibleOnly(v3)
	local v11 = v4.CFrame.Rotation + (v7.Position - Vector3.new(0, v8.Y * 0.5, 0))
	local v12 = v3:GetScale()

	assert(v12 > 0, (("Asset model \"%*\" has invalid template scale"):format(p1)))

	return {
		RelativeCFrame = v11:ToObjectSpace(v7),
		Size = v8,
		TemplateScale = v12
	}
end
function t2.GetAssetModelsFolder() --[[ GetAssetModelsFolder | Line: 100 | Upvalues: t2 (copy) ]]
	return t2._getResolvedAssetModelsFolder()
end
function t2.GetModelTemplate(p1) --[[ GetModelTemplate | Line: 104 | Upvalues: Asserts (copy), Constants (copy), t2 (copy) ]]
	Asserts.string(p1)

	if Constants.IS_CLIENT then
		return t2._waitForAssetModelTemplate(p1)
	end

	return t2._getAvailableAssetModelTemplate(p1)
end
function t2.GetAssetModelIfReplicated(p1) --[[ GetAssetModelIfReplicated | Line: 114 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.string(p1)

	local v1 = t2._getAvailableAssetModelTemplate(p1)

	if v1 then
		return v1
	end

	return nil
end
function t2.WaitForAssetModel(p1, p2) --[[ WaitForAssetModel | Line: 125 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.string(p1)
	Asserts.optional.number(p2)

	return t2._waitForAssetModelTemplate(p1, p2)
end
function t2.GetVisibleBoundsData(p1) --[[ GetVisibleBoundsData | Line: 132 | Upvalues: Asserts (copy), t (copy), t2 (copy) ]]
	Asserts.string(p1)

	local v1 = t[p1]

	if v1 == nil then
		local v2 = t2._buildVisibleBoundsData(p1)

		t[p1] = v2

		return v2
	end

	return v1
end
function t2.HydrateAssetConfigModelScale(p1) --[[ HydrateAssetConfigModelScale | Line: 145 | Upvalues: Asserts (copy), Assets (copy), t2 (copy) ]]
	Asserts.string(p1)

	local v1 = Assets.Directory[p1]

	if not v1 then
		return
	end

	local v2 = t2.GetAssetModelIfReplicated(p1)

	if not v2 then
		return
	end

	v1.BaseModelScale = v2:GetScale()
end
function t2.HydrateAvailableAssetConfigModelScales() --[[ HydrateAvailableAssetConfigModelScales | Line: 159 | Upvalues: Assets (copy), t2 (copy) ]]
	for k in pairs(Assets.Directory) do
		t2.HydrateAssetConfigModelScale(k)
	end
end

if Constants.IS_SERVER then
	local function disablePartQueriesClocked(p1) --[[ disablePartQueriesClocked | Line: 170 | Upvalues: RunService (copy) ]]
		task.spawn(function() --[[ Line: 171 | Upvalues: p1 (copy), RunService (ref) ]]
			local t2 = { p1 }
			local v12 = os.clock() + 0.002
			local count2 = 1
			local count22 = 0

			while count2 <= #t2 do
				local v2 = t2[count2]

				t2[count2] = nil
				count2 = count2 + 1

				if v2:IsA("BasePart") then
					v2.CanQuery = false
					v2.CanTouch = false
				end

				local v3 = v2:GetChildren()

				for i = 1, #v3 do
					t2[#t2 + 1] = v3[i]
				end

				count22 = count22 + 1

				if count22 >= 64 then
					count22 = 0

					if v12 <= os.clock() then
						RunService.Heartbeat:Wait()
						v12 = os.clock() + 0.002
					else
						continue
					end
				end
			end
		end)
	end

	local v1 = t2._getResolvedAssetModelsFolder()

	task.spawn(function() --[[ Line: 171 | Upvalues: v1 (copy), RunService (copy) ]]
		local t2 = { v1 }
		local v12 = os.clock() + 0.002
		local count2 = 1
		local count22 = 0

		while count2 <= #t2 do
			local v2 = t2[count2]

			t2[count2] = nil
			count2 = count2 + 1

			if v2:IsA("BasePart") then
				v2.CanQuery = false
				v2.CanTouch = false
			end

			local v3 = v2:GetChildren()

			for i = 1, #v3 do
				t2[#t2 + 1] = v3[i]
			end

			count22 = count22 + 1

			if count22 >= 64 then
				count22 = 0

				if v12 <= os.clock() then
					RunService.Heartbeat:Wait()
					v12 = os.clock() + 0.002
				else
					continue
				end
			end
		end
	end)
	t2.HydrateAvailableAssetConfigModelScales()
end

return t2