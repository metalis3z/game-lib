-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GenerateUID = require(ReplicatedStorage.Library.Functions.GenerateUID)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local StreamDirectory = require(ReplicatedStorage.Library.Modules.StreamDirectory)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Log.new({
	EnableStringRead = true
})
local t = {}

local function getElapsedMilliseconds(p1) --[[ getElapsedMilliseconds | Line: 55 ]]
	return math.floor((os.clock() - p1) * 1000)
end

function t._assertModel(p1, p2, p3) --[[ _assertModel | Line: 59 ]]
	local v2 = assert(p1, (("%* model \"%*\" was not found"):format(p3, p2)))
	local v3 = v2:IsA("Model")

	assert(v3, (("%* model \"%*\" is not a Model"):format(p3, p2)))

	return v2
end
function t._waitForDownloadContainer(p1, p2, p3) --[[ _waitForDownloadContainer | Line: 66 | Upvalues: Players (copy), v1 (copy) ]]
	local v12 = os.clock()
	local v2 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild(p1.DownloadGUID, p2)

	assert(if v2 == nil then false else true, (("%* download \"%*\" was not replicated"):format(p3, p1.DownloadGUID)))
	assert(v2:IsA("ScreenGui"), (("%* download \"%*\" is not a ScreenGui"):format(p3, p1.DownloadGUID)))

	local v7 = v1:AtInfo()
	local v8 = ("%* download \"%*\" container replicated"):format(p3, p1.DownloadGUID)
	local t = {}

	t.ElapsedMs = math.floor((os.clock() - v12) * 1000)
	t.ExpectedDownloadSize = p1.DownloadSize
	v7:Log(v8, t)

	local v10 = os.clock()

	while #v2:GetDescendants() < p1.DownloadSize do
		local v11 = if os.clock() - v10 <= p2 then true else false

		assert(v11, (("Timed out waiting for %* download \"%*\""):format(p3, p1.DownloadGUID)))
		task.wait()
	end

	local v13 = v1:AtInfo()
	local v14 = ("%* download \"%*\" descendants replicated"):format(p3, p1.DownloadGUID)
	local t2 = {}

	t2.ElapsedMs = math.floor((os.clock() - v10) * 1000)
	t2.TotalElapsedMs = math.floor((os.clock() - v12) * 1000)
	t2.DownloadSize = p1.DownloadSize
	v13:Log(v14, t2)

	return v2
end
function t._collectExistingModels(p1, p2, p3) --[[ _collectExistingModels | Line: 99 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs(p2) do
		local v1 = p1:FindFirstChild(v)

		if v1 ~= nil then
			t2[v] = t._assertModel(v1, v, p3)
		end
	end

	return t2
end
function t._resolveStreamedModel(p1, p2, p3, p4) --[[ _resolveStreamedModel | Line: 115 | Upvalues: t (copy) ]]
	local v1 = p4[p2]

	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == p2 then
			local v2 = t._assertModel(v, p2, p3)

			if v1 == nil then
				v1 = v2

				continue
			end

			if v2 ~= v1 then
				v2:Destroy()
			end
		end
	end

	return v1
end
function t.RequestModelDownload(p1) --[[ RequestModelDownload | Line: 142 | Upvalues: Asserts (copy), GenerateUID (copy), Trove (copy), v1 (copy), Network (copy) ]]
	Asserts.table(p1)
	Asserts.string(p1.RequestRemote)
	Asserts.string(p1.ReadyRemote)
	Asserts.string(p1.FailedRemote)

	if p1.RequestedModelNames ~= nil then
		Asserts.array.string(p1.RequestedModelNames)
	end

	Asserts.number(p1.DownloadWaitTimeoutSeconds)
	Asserts.string(p1.ModelLabel)
	Asserts.string(p1.FailureMessage)

	local v12 = GenerateUID()
	local v2 = Trove.new()
	local v3 = nil
	local v4 = nil
	local v5 = os.clock()
	local v6 = v1:AtInfo()
	local v7 = ("%* download request \"%*\" started"):format(p1.ModelLabel, v12)
	local t = {}

	t.RequestedCount = if p1.RequestedModelNames == nil then nil else #p1.RequestedModelNames
	v6:Log(v7, t)
	v2:Connect(Network.Fired(p1.ReadyRemote), function(p12, p2, p3, p4) --[[ Line: 166 | Upvalues: Asserts (ref), v12 (copy), v3 (ref), v1 (ref), p1 (copy), v5 (copy) ]]
		Asserts.string(p12)

		if p12 == v12 then
			Asserts.string(p2)
			Asserts.number(p3)
			Asserts.array.string(p4)
			v3 = {
				DownloadGUID = p2,
				DownloadSize = p3,
				ModelNames = p4
			}

			local v13 = v1:AtInfo()
			local v2 = ("%* download request \"%*\" ready event received"):format(p1.ModelLabel, v12)
			local t = {}

			t.ElapsedMs = math.floor((os.clock() - v5) * 1000)
			t.DownloadGUID = p2
			t.DownloadSize = p3
			t.ModelCount = #p4
			v13:Log(v2, t)
		end
	end)
	v2:Connect(Network.Fired(p1.FailedRemote), function(p12, p2) --[[ Line: 188 | Upvalues: Asserts (ref), v12 (copy), v4 (ref), v1 (ref), p1 (copy), v5 (copy) ]]
		Asserts.string(p12)

		if p12 == v12 then
			Asserts.string(p2)
			v4 = p2

			local v13 = v1:AtWarning()
			local v2 = ("%* download request \"%*\" failed event received"):format(p1.ModelLabel, v12)
			local t = {}

			t.ElapsedMs = math.floor((os.clock() - v5) * 1000)
			t.Error = p2
			v13:Log(v2, t)
		end
	end)

	local ok, result, result2 = pcall(Network.Invoke, p1.RequestRemote, v12, p1.RequestedModelNames)

	if not ok then
		v2:Destroy()
		error(tostring(result), 2)
	end

	if result == false then
		v2:Destroy()

		local v9 = error

		v9(tostring(if result2 then result2 else p1.FailureMessage), 2)
	end

	assert(if result == true then true else false, p1.FailureMessage)

	local v122 = v1:AtInfo()
	local v13 = ("%* download request \"%*\" accepted"):format(p1.ModelLabel, v12)
	local t2 = {}

	t2.ElapsedMs = math.floor((os.clock() - v5) * 1000)
	v122:Log(v13, t2)

	local v15 = os.clock()

	while v3 == nil and v4 == nil do
		if os.clock() - v15 > p1.DownloadWaitTimeoutSeconds then
			v4 = ("Timed out waiting for %* download \"%*\" readiness"):format(p1.ModelLabel, v12)

			break
		end

		task.wait()
	end

	v2:Destroy()

	local v16 = if v3 == nil then false else true
	local v17 = v4 or p1.FailureMessage

	assert(v16, v17)

	local v18 = v1:AtInfo()
	local v19 = ("%* download request \"%*\" ready wait completed"):format(p1.ModelLabel, v12)
	local t3 = {}

	t3.ElapsedMs = math.floor((os.clock() - v15) * 1000)
	t3.TotalElapsedMs = math.floor((os.clock() - v5) * 1000)
	t3.DownloadGUID = v3.DownloadGUID
	t3.DownloadSize = v3.DownloadSize
	t3.ModelCount = #v3.ModelNames
	v18:Log(v19, t3)

	return v3
end
function t.StreamDownloadedModels(p1) --[[ StreamDownloadedModels | Line: 237 | Upvalues: Asserts (copy), t (copy), v1 (copy), StreamDirectory (copy) ]]
	Asserts.table(p1)
	Asserts.table(p1.DownloadInfo)
	Asserts.number(p1.DownloadWaitTimeoutSeconds)
	Asserts.string(p1.ModelLabel)
	Asserts.string(p1.FailureMessage)

	local DownloadInfo = p1.DownloadInfo

	Asserts.string(DownloadInfo.DownloadGUID)
	Asserts.number(DownloadInfo.DownloadSize)
	Asserts.array.string(DownloadInfo.ModelNames)

	local v12 = os.clock()
	local v2 = t._waitForDownloadContainer(DownloadInfo, p1.DownloadWaitTimeoutSeconds, p1.ModelLabel)
	local v3 = os.clock()
	local v4 = v2:Clone()

	v2:Destroy()

	local v5 = v1:AtInfo()
	local v6 = ("%* download \"%*\" cloned locally"):format(p1.ModelLabel, DownloadInfo.DownloadGUID)
	local t2 = {}

	t2.ElapsedMs = math.floor((os.clock() - v3) * 1000)
	t2.TotalElapsedMs = math.floor((os.clock() - v12) * 1000)
	v5:Log(v6, t2)
	task.defer(function() --[[ Line: 263 | Upvalues: p1 (copy), DownloadInfo (copy) ]]
		p1.AcknowledgeDownload(DownloadInfo.DownloadGUID)
	end)

	local v9 = t._collectExistingModels(p1.DestinationFolder, DownloadInfo.ModelNames, p1.ModelLabel)
	local v10 = os.clock()
	local v11 = StreamDirectory.StreamDirectory(v4, p1.DestinationFolder)

	while not v11.Complete do
		assert(not v11.Failed, v11.Error or p1.FailureMessage)
		task.wait()
	end

	assert(not v11.Failed, v11.Error or p1.FailureMessage)

	local v16 = v1:AtInfo()
	local v17 = ("%* final stream \"%*\" completed"):format(p1.ModelLabel, DownloadInfo.DownloadGUID)
	local t3 = {}

	t3.ElapsedMs = math.floor((os.clock() - v10) * 1000)
	t3.TotalElapsedMs = math.floor((os.clock() - v12) * 1000)
	t3.ModelCount = #DownloadInfo.ModelNames
	t3.DownloadSize = DownloadInfo.DownloadSize
	v16:Log(v17, t3)
	v4:Destroy()

	local t4 = {}

	for i, v in ipairs(DownloadInfo.ModelNames) do
		local v20 = t._resolveStreamedModel(p1.DestinationFolder, v, p1.ModelLabel, v9)

		if v20 ~= nil then
			t4[v] = v20
		end
	end

	return t4
end
function t.CreateStreamGate() --[[ CreateStreamGate | Line: 304 | Upvalues: Signal (copy) ]]
	return {
		Active = false,
		Released = Signal.new()
	}
end
function t.RunWithStreamGate(p1, p2) --[[ RunWithStreamGate | Line: 311 ]]
	while p1.Active do
		p1.Released:Wait()
	end

	p1.Active = true

	local ok, result = pcall(p2)

	p1.Active = false
	p1.Released:Fire()

	if not ok then
		error(result, 2)
	end

	return result
end

return t