-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t = {}
local t2 = {}

local function StopTimer(p1, p2) --[[ StopTimer | Line: 42 | Upvalues: Constants (copy), t (copy), v1 (copy) ]]
	if not Constants.IS_CLIENT then
		return
	end

	local v12 = t[p1] or os.clock()

	if p2 then
		local v2 = v1:AtTrace()

		v2:Log((("%*: [Time Elapsed: %* ms]"):format(p2, (math.round((os.clock() - v12) * 1000)))))
	end

	t[p1] = nil
end

local function GetTotalSize(p1) --[[ GetTotalSize | Line: 52 ]]
	local v1 = 0

	local function v2(p13) --[[ countChildren | Line: 54 | Upvalues: v1 (ref), v2 (copy) ]]
		for k2, v in pairs(p13:GetChildren()) do
			if v.ClassName ~= "PackageLink" and v.ClassName ~= "Status" then
				v1 = v1 + 1
				v2(v)
			end
		end
	end

	v2(p1)

	return v1
end

function t2.GetTotalSize(p1) --[[ GetTotalSize | Line: 67 ]]
	local v1 = 0

	local function v2(p13) --[[ countChildren | Line: 54 | Upvalues: v1 (ref), v2 (copy) ]]
		for k2, v in pairs(p13:GetChildren()) do
			if v.ClassName ~= "PackageLink" and v.ClassName ~= "Status" then
				v1 = v1 + 1
				v2(v)
			end
		end
	end

	v2(p1)

	return v1
end

local function FailStream(p1, p2) --[[ FailStream | Line: 71 | Upvalues: v1 (copy) ]]
	p1.Error = p2
	p1.Failed = true
	p1.Complete = true
	v1:AtWarning():Log((("StreamDirectory failed: %*"):format(p2)))
end

local function AssertStreamAlive(p1) --[[ AssertStreamAlive | Line: 78 ]]
	assert(not p1.Failed, p1.Error or "StreamDirectory failed")
end

function t2.SaveTags(p1) --[[ SaveTags | Line: 86 | Upvalues: CollectionService (copy), HttpService (copy) ]]
	local v1 = CollectionService:GetTags(p1)

	p1:SetAttribute("_streamingTags", HttpService:JSONEncode(v1))

	for i, v in ipairs(v1) do
		CollectionService:RemoveTag(p1, v)
	end
end
function t2.SaveTagsDeep(p1) --[[ SaveTagsDeep | Line: 95 | Upvalues: t2 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		t2.SaveTags(v)
		t2.SaveTagsDeep(v)
	end
end
function t2.LoadTags(p1) --[[ LoadTags | Line: 102 | Upvalues: HttpService (copy), CollectionService (copy) ]]
	local count = 0
	local ok, result = pcall(function() --[[ Line: 104 | Upvalues: HttpService (ref), p1 (copy) ]]
		return HttpService:JSONDecode(p1:GetAttribute("_streamingTags") or "[]")
	end)

	if ok then
		for i, v in ipairs(result) do
			count = count + 1
			CollectionService:AddTag(p1, v)

			if count % 25 == 0 then
				task.wait()
			end
		end
	end

	p1:SetAttribute("_streamingTags", nil)

	return count
end
function t2.StreamDirectory(p1, p2) --[[ StreamDirectory | Line: 124 | Upvalues: Constants (copy), v1 (copy), t (copy), wcall (copy), StopTimer (copy), t2 (copy) ]]
	if p2:IsA("ScreenGui") and p2.ResetOnSpawn then
		p2.ResetOnSpawn = false

		local v12 = ("ResetOnSpawn is set to true for %* (a screen gui). This can cause issues with streaming, causing the root to be destroyed, never let this to true!"):format(p2.Name)

		if Constants.IS_STUDIO then
			error(v12)
		end

		v1:AtWarning():Log(v12)
	end

	local v2

	if not Constants.IS_CLIENT then
		v2 = {
			Percent = 0,
			Complete = false,
			Failed = false,
			Error = nil
		}
		task.spawn(function() --[[ Line: 149 | Upvalues: wcall (ref), Constants (ref), t (ref), v1 (ref), p1 (copy), v2 (copy), p2 (copy), StopTimer (ref), t2 (ref) ]]
			local v12, v22 = wcall(function() --[[ Line: 150 | Upvalues: Constants (ref), t (ref), v1 (ref), p1 (ref), v2 (ref), p2 (ref), StopTimer (ref), t2 (ref) ]]
				if Constants.IS_CLIENT then
					t.build = os.clock()
					v1:AtTrace():Log("Building Hierarchy Data..")
				end

				local t3 = { p1 }
				local list2 = {}

				while #t3 > 0 do
					local v12 = v2

					assert(not v12.Failed, v12.Error or "StreamDirectory failed")

					local v4 = table.remove(t3)

					if not v4 then
						break
					end

					local v5 = if v4 == p1 then p2 else v4

					for k2, v in pairs(v4:GetChildren()) do
						if v.ClassName ~= "PackageLink" and v.ClassName ~= "Status" then
							local t4 = {
								Instance = v,
								Parent = v5
							}

							t4.PrimaryPart = if v:IsA("Model") then v.PrimaryPart else nil
							t4.Adornee = if v:IsA("BillboardGui") then v.Adornee else nil
							table.insert(list2, t4)
							table.insert(t3, v)
						end
					end

					if #list2 % Constants.STREAMING.STREAM_DIR_STACKING_WEIGHT_BUFFER == 0 then
						task.wait()
					end
				end

				StopTimer("build", "Hierarchy Data Successfully Built!")

				local v8 = #list2

				v2.TotalSize = v8

				if Constants.IS_CLIENT then
					t.instances = os.clock()
					v1:AtTrace():Log((("Streaming Instances.. (Instances: %*)"):format(v8)))
				end

				if v8 == 0 then
					v2.Percent = 1
				end

				for i2, v in ipairs(list2) do
					local v9 = v2

					assert(not v9.Failed, v9.Error or "StreamDirectory failed")
					v.Instance.Parent = v.Parent
					v2.Percent = math.clamp(i2 / v8, 0, 1)

					if i2 % Constants.STREAMING.STREAM_DIR_REPLICATION_WEIGHT_BUFFER == 0 then
						task.wait()
					end
				end

				StopTimer("instances", "Instances Successfully Streamed!")

				if Constants.IS_CLIENT then
					t.references = os.clock()
					v1:AtTrace():Log("Rebuilding Instance References..")
				end

				for i2, v in ipairs(list2) do
					local v12 = v2

					assert(not v12.Failed, v12.Error or "StreamDirectory failed")

					if v.Instance:IsA("Model") then
						v.Instance.PrimaryPart = v.PrimaryPart

						continue
					end

					if v.Instance:IsA("BillboardGui") and v.Adornee ~= nil then
						v.Instance.Adornee = v.Adornee
					end
				end

				StopTimer("references", "Instance References Set!")

				if Constants.IS_CLIENT then
					for i2, v in ipairs(list2) do
						local v15 = v2

						assert(not v15.Failed, v15.Error or "StreamDirectory failed")
						t2.LoadTags(v.Instance)
					end
				end

				StopTimer("tags", "Tags Successfully Added!")
				StopTimer("stream", "Streaming Complete!")
				v2.Complete = true
			end)

			if v12 then
				return
			end

			local v3 = v2
			local v4 = tostring(v22)

			v3.Error = v4
			v3.Failed = true
			v3.Complete = true
			v1:AtWarning():Log((("StreamDirectory failed: %*"):format(v4)))
		end)

		return v2
	end

	t.stream = os.clock()
	v1:AtTrace():Log("Streaming Started..")
	v2 = {
		Percent = 0,
		Complete = false,
		Failed = false,
		Error = nil
	}
	task.spawn(function() --[[ Line: 149 | Upvalues: wcall (ref), Constants (ref), t (ref), v1 (ref), p1 (copy), v2 (copy), p2 (copy), StopTimer (ref), t2 (ref) ]]
		local v12, v22 = wcall(function() --[[ Line: 150 | Upvalues: Constants (ref), t (ref), v1 (ref), p1 (ref), v2 (ref), p2 (ref), StopTimer (ref), t2 (ref) ]]
			if Constants.IS_CLIENT then
				t.build = os.clock()
				v1:AtTrace():Log("Building Hierarchy Data..")
			end

			local t3 = { p1 }
			local list2 = {}

			while #t3 > 0 do
				local v12 = v2

				assert(not v12.Failed, v12.Error or "StreamDirectory failed")

				local v4 = table.remove(t3)

				if not v4 then
					break
				end

				local v5 = if v4 == p1 then p2 else v4

				for k2, v in pairs(v4:GetChildren()) do
					if v.ClassName ~= "PackageLink" and v.ClassName ~= "Status" then
						local t4 = {
							Instance = v,
							Parent = v5
						}

						t4.PrimaryPart = if v:IsA("Model") then v.PrimaryPart else nil
						t4.Adornee = if v:IsA("BillboardGui") then v.Adornee else nil
						table.insert(list2, t4)
						table.insert(t3, v)
					end
				end

				if #list2 % Constants.STREAMING.STREAM_DIR_STACKING_WEIGHT_BUFFER == 0 then
					task.wait()
				end
			end

			StopTimer("build", "Hierarchy Data Successfully Built!")

			local v8 = #list2

			v2.TotalSize = v8

			if Constants.IS_CLIENT then
				t.instances = os.clock()
				v1:AtTrace():Log((("Streaming Instances.. (Instances: %*)"):format(v8)))
			end

			if v8 == 0 then
				v2.Percent = 1
			end

			for i2, v in ipairs(list2) do
				local v9 = v2

				assert(not v9.Failed, v9.Error or "StreamDirectory failed")
				v.Instance.Parent = v.Parent
				v2.Percent = math.clamp(i2 / v8, 0, 1)

				if i2 % Constants.STREAMING.STREAM_DIR_REPLICATION_WEIGHT_BUFFER == 0 then
					task.wait()
				end
			end

			StopTimer("instances", "Instances Successfully Streamed!")

			if Constants.IS_CLIENT then
				t.references = os.clock()
				v1:AtTrace():Log("Rebuilding Instance References..")
			end

			for i2, v in ipairs(list2) do
				local v12 = v2

				assert(not v12.Failed, v12.Error or "StreamDirectory failed")

				if v.Instance:IsA("Model") then
					v.Instance.PrimaryPart = v.PrimaryPart

					continue
				end

				if v.Instance:IsA("BillboardGui") and v.Adornee ~= nil then
					v.Instance.Adornee = v.Adornee
				end
			end

			StopTimer("references", "Instance References Set!")

			if Constants.IS_CLIENT then
				for i2, v in ipairs(list2) do
					local v15 = v2

					assert(not v15.Failed, v15.Error or "StreamDirectory failed")
					t2.LoadTags(v.Instance)
				end
			end

			StopTimer("tags", "Tags Successfully Added!")
			StopTimer("stream", "Streaming Complete!")
			v2.Complete = true
		end)

		if v12 then
			return
		end

		local v3 = v2
		local v4 = tostring(v22)

		v3.Error = v4
		v3.Failed = true
		v3.Complete = true
		v1:AtWarning():Log((("StreamDirectory failed: %*"):format(v4)))
	end)

	return v2
end

return t2