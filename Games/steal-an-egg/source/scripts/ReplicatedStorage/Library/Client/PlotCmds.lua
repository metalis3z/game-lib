-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Plots = require(ReplicatedStorage.Library.Types.Plots)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Streamable = require(ReplicatedStorage.Library.Modules.Packages.Streamable).Streamable
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Plots2 = Constants.NETWORK_MAP.Plots
local v2 = nil
local t = {}
local v3 = nil
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {
	OnLocalPlotUpdated = Signal.new(),
	OnAnyPlotUpdated = Signal.new(),
	OnPlotsFolderUpdated = Signal.new()
}
local v4 = Streamable.new(Workspace, "Plots")

local function firePlotUpdated(p1) --[[ firePlotUpdated | Line: 58 | Upvalues: t5 (copy), t (copy), v3 (ref) ]]
	t5.OnAnyPlotUpdated:Fire(p1, t[p1])

	if v3 ~= p1 then
		return
	end

	t5.OnLocalPlotUpdated:Fire(p1)
end

local function clearSlotTracker(p1) --[[ clearSlotTracker | Line: 66 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]

	if v1 then
		t3[p1] = nil
		t2[p1] = nil
		v1.trove:Destroy()
	end
end

local function clearAllSlotTrackers() --[[ clearAllSlotTrackers | Line: 77 | Upvalues: t2 (copy), t3 (copy) ]]
	local list = {}

	for k in pairs(t2) do
		table.insert(list, k)
	end

	for i, v in ipairs(list) do
		local v1 = t2[v]

		if v1 then
			t3[v] = nil
			t2[v] = nil
			v1.trove:Destroy()
		end
	end
end

local function observePlotSlot(p1, p2) --[[ observePlotSlot | Line: 88 | Upvalues: t2 (copy), Trove (copy), Streamable (copy), t5 (copy), t (copy), v3 (ref), Asserts (copy), t3 (copy) ]]
	if not t2[p1] then
		local v1 = Trove.new()
		local v2 = Streamable.new(p2, (tostring(p1)))
		local t4 = {
			trove = v1,
			plotStreamable = v2
		}

		t2[p1] = t4
		v1:Add(function() --[[ Line: 102 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
		v1:Add(function() --[[ Line: 105 | Upvalues: t2 (ref), p1 (copy), t4 (copy) ]]
			if t2[p1] ~= t4 then
				return
			end

			t2[p1] = nil
		end)
		v1:Add(v2:Observe(function(p12, p2) --[[ Line: 111 | Upvalues: p1 (copy), t5 (ref), t (ref), v3 (ref), Streamable (ref), Asserts (ref), t3 (ref), t2 (ref), t4 (copy) ]]
			if not (p12:IsA("Folder") or p12:IsA("Model")) then
				return
			end

			local v1 = p1

			t5.OnAnyPlotUpdated:Fire(v1, t[v1])

			local v2, v32, v4, v5, v6

			if v3 == v1 then
				t5.OnLocalPlotUpdated:Fire(v1)
			end

			p2:Add(function() --[[ Line: 118 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				if v3 ~= v1 then
					return
				end

				t5.OnLocalPlotUpdated:Fire(v1)
			end)
			v2 = Streamable.new(p12, "CenterPoint")
			p2:Add(function() --[[ Line: 123 | Upvalues: v2 (copy) ]]
				v2:Destroy()
			end)
			v2:Observe(function(p12, p2) --[[ Line: 126 | Upvalues: Asserts (ref), p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
				Asserts.BasePart(p12)

				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				if v3 == v1 then
					t5.OnLocalPlotUpdated:Fire(v1)
				end

				p2:Add(function() --[[ Line: 130 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 ~= v1 then
						return
					end

					t5.OnLocalPlotUpdated:Fire(v1)
				end)
			end)
			v32 = Streamable.new(p12, "SpawnPoint")
			p2:Add(function() --[[ Line: 136 | Upvalues: v32 (copy) ]]
				v32:Destroy()
			end)
			v32:Observe(function(p12, p2) --[[ Line: 139 | Upvalues: Asserts (ref), t3 (ref), p1 (ref), t5 (ref), t (ref), v3 (ref), t2 (ref), t4 (ref) ]]
				Asserts.BasePart(p12)
				t3[p1] = p12.CFrame + Vector3.new(0, 0, 0)

				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				if v3 ~= v1 then
					p2:Add(function() --[[ Line: 144 | Upvalues: t2 (ref), p1 (ref), t4 (ref), t5 (ref), t (ref), v3 (ref) ]]
						if t2[p1] ~= t4 then
							return
						end

						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
					end)

					return
				end

				t5.OnLocalPlotUpdated:Fire(v1)
				p2:Add(function() --[[ Line: 144 | Upvalues: t2 (ref), p1 (ref), t4 (ref), t5 (ref), t (ref), v3 (ref) ]]
					if t2[p1] ~= t4 then
						return
					end

					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 ~= v1 then
						return
					end

					t5.OnLocalPlotUpdated:Fire(v1)
				end)
			end)
			v4 = Streamable.new(p12, "ToUpdate")
			p2:Add(function() --[[ Line: 152 | Upvalues: v4 (copy) ]]
				v4:Destroy()
			end)
			v4:Observe(function(p12, p2) --[[ Line: 155 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref), Streamable (ref), Asserts (ref) ]]
				if not p12:IsA("Model") then
					return
				end

				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				local v2

				if v3 ~= v1 then
					p2:Add(function() --[[ Line: 161 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
					end)
					v2 = Streamable.new(p12, "PetArea")
					p2:Add(function() --[[ Line: 166 | Upvalues: v2 (copy) ]]
						v2:Destroy()
					end)
					v2:Observe(function(p13, p23) --[[ Line: 170 | Upvalues: Asserts (ref), p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						Asserts.BasePart(p13)

						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 == v1 then
							t5.OnLocalPlotUpdated:Fire(v1)
						end

						p23:Add(function() --[[ Line: 173 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
							local v1 = p1

							t5.OnAnyPlotUpdated:Fire(v1, t[v1])

							if v3 ~= v1 then
								return
							end

							t5.OnLocalPlotUpdated:Fire(v1)
						end)
					end)

					return
				end

				t5.OnLocalPlotUpdated:Fire(v1)
				p2:Add(function() --[[ Line: 161 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 ~= v1 then
						return
					end

					t5.OnLocalPlotUpdated:Fire(v1)
				end)
				v2 = Streamable.new(p12, "PetArea")
				p2:Add(function() --[[ Line: 166 | Upvalues: v2 (copy) ]]
					v2:Destroy()
				end)
				v2:Observe(function(p13, p23) --[[ Line: 170 | Upvalues: Asserts (ref), p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					Asserts.BasePart(p13)

					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 == v1 then
						t5.OnLocalPlotUpdated:Fire(v1)
					end

					p23:Add(function() --[[ Line: 173 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
					end)
				end)
			end)
			v5 = Streamable.new(p12, "PlotSign")
			p2:Add(function() --[[ Line: 180 | Upvalues: v5 (copy) ]]
				v5:Destroy()
			end)
			v5:Observe(function(p12, p2) --[[ Line: 183 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref), Streamable (ref), Asserts (ref) ]]
				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				local v2

				if v3 == v1 then
					t5.OnLocalPlotUpdated:Fire(v1)
				end

				p2:Add(function() --[[ Line: 186 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 ~= v1 then
						return
					end

					t5.OnLocalPlotUpdated:Fire(v1)
				end)
				v2 = Streamable.new(p12, "Attachment")
				p2:Add(function() --[[ Line: 191 | Upvalues: v2 (copy) ]]
					v2:Destroy()
				end)
				v2:Observe(function(p12, p2) --[[ Line: 194 | Upvalues: Asserts (ref), p1 (ref), t5 (ref), t (ref), v3 (ref), Streamable (ref) ]]
					Asserts.Attachment(p12)

					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					local v2

					if v3 == v1 then
						t5.OnLocalPlotUpdated:Fire(v1)
					end

					p2:Add(function() --[[ Line: 198 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
					end)
					v2 = Streamable.new(p12, "YourBase")
					p2:Add(function() --[[ Line: 203 | Upvalues: v2 (copy) ]]
						v2:Destroy()
					end)
					v2:Observe(function(p12, p2) --[[ Line: 206 | Upvalues: Asserts (ref), p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						Asserts.BillboardGui(p12)

						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							p2:Add(function() --[[ Line: 210 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
								local v1 = p1

								t5.OnAnyPlotUpdated:Fire(v1, t[v1])

								if v3 ~= v1 then
									return
								end

								t5.OnLocalPlotUpdated:Fire(v1)
							end)

							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
						p2:Add(function() --[[ Line: 210 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
							local v1 = p1

							t5.OnAnyPlotUpdated:Fire(v1, t[v1])

							if v3 ~= v1 then
								return
							end

							t5.OnLocalPlotUpdated:Fire(v1)
						end)
					end)
				end)
			end)
			v6 = Streamable.new(p12, "BaseUpgrade")
			p2:Add(function() --[[ Line: 218 | Upvalues: v6 (copy) ]]
				v6:Destroy()
			end)
			v6:Observe(function(p12, p2) --[[ Line: 221 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref), Streamable (ref) ]]
				local v1 = p1

				t5.OnAnyPlotUpdated:Fire(v1, t[v1])

				local v2

				if v3 == v1 then
					t5.OnLocalPlotUpdated:Fire(v1)
				end

				p2:Add(function() --[[ Line: 224 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 ~= v1 then
						return
					end

					t5.OnLocalPlotUpdated:Fire(v1)
				end)
				v2 = Streamable.new(p12, "Sign")
				p2:Add(function() --[[ Line: 229 | Upvalues: v2 (copy) ]]
					v2:Destroy()
				end)
				v2:Observe(function(p12, p2) --[[ Line: 232 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
					local v1 = p1

					t5.OnAnyPlotUpdated:Fire(v1, t[v1])

					if v3 == v1 then
						t5.OnLocalPlotUpdated:Fire(v1)
					end

					p2:Add(function() --[[ Line: 235 | Upvalues: p1 (ref), t5 (ref), t (ref), v3 (ref) ]]
						local v1 = p1

						t5.OnAnyPlotUpdated:Fire(v1, t[v1])

						if v3 ~= v1 then
							return
						end

						t5.OnLocalPlotUpdated:Fire(v1)
					end)
				end)
			end)
		end))
	end
end

local function ensurePlotTracker(p1) --[[ ensurePlotTracker | Line: 243 | Upvalues: v2 (ref), observePlotSlot (copy) ]]
	local v1 = v2

	if v1 then
		observePlotSlot(p1, v1)
	end
end

local function getPlotBoundsContainer(p1) --[[ getPlotBoundsContainer | Line: 252 ]]
	return p1
end

function t5.GetState() --[[ GetState | Line: 260 | Upvalues: t (copy) ]]
	return table.clone(t)
end
function t5.GetSlotOwner(p1) --[[ GetSlotOwner | Line: 264 | Upvalues: t (copy) ]]
	return t[p1]
end
function t5.GetMySlot() --[[ GetMySlot | Line: 268 | Upvalues: v3 (ref) ]]
	return v3
end
function t5.GetPlotsFolder() --[[ GetPlotsFolder | Line: 272 | Upvalues: v2 (ref) ]]
	return v2
end
function t5.GetPlotData(p1) --[[ GetPlotData | Line: 276 | Upvalues: Players (copy), Asserts (copy), v3 (ref), t (copy), v2 (ref), t3 (copy) ]]
	local v1 = if p1 then p1 else Players.LocalPlayer

	Asserts.Player(v1)

	local v22 = if v1 == Players.LocalPlayer then v3 else nil

	if not v22 then
		for k, v in pairs(t) do
			if v == v1.UserId then
				v22 = k

				break
			end
		end
	end

	if not v22 then
		return nil
	end

	local v32 = v2

	if not v32 then
		return nil
	end

	local v4 = v32:FindFirstChild((tostring(v22)))

	if not v4 then
		return nil
	end

	local ToUpdate = v4:FindFirstChild("ToUpdate")

	if not (ToUpdate and ToUpdate:IsA("Model")) then
		return nil
	end

	local PetArea = ToUpdate:FindFirstChild("PetArea")

	if not (PetArea and PetArea:IsA("BasePart")) then
		return nil
	end

	local CenterPoint = v4:FindFirstChild("CenterPoint")

	if not (CenterPoint and CenterPoint:IsA("BasePart")) then
		return nil
	end

	local SpawnPoint = v4:FindFirstChild("SpawnPoint")

	if SpawnPoint and SpawnPoint:IsA("BasePart") then
		t3[v22] = SpawnPoint.CFrame + Vector3.new(0, 0, 0)
	end

	return {
		Slot = v22,
		PlotFolder = v4,
		PetArea = PetArea,
		CenterPoint = CenterPoint,
		RespawnPointCFrame = t3[v22]
	}
end
function t5.GetLocalYourBaseBillboard() --[[ GetLocalYourBaseBillboard | Line: 332 | Upvalues: t5 (copy) ]]
	local v1 = t5.GetPlotData()

	if v1 == nil then
		return nil
	end

	local PlotSign = v1.PlotFolder:FindFirstChild("PlotSign")

	if PlotSign == nil then
		return nil
	end

	local Attachment = PlotSign:FindFirstChild("Attachment")

	if not (Attachment and Attachment:IsA("Attachment")) then
		return nil
	end

	local YourBase = Attachment:FindFirstChild("YourBase")

	if YourBase and YourBase:IsA("BillboardGui") then
		return YourBase
	end

	return nil
end
function t5.IsWorldPositionWithinLocalPlotBounds(p1) --[[ IsWorldPositionWithinLocalPlotBounds | Line: 356 | Upvalues: Asserts (copy), t5 (copy) ]]
	Asserts.Vector3(p1)

	local v1 = t5.GetPlotData()

	if not v1 then
		return false
	end

	local v2, v3 = v1.PlotFolder:GetBoundingBox()
	local v4 = v2:PointToObjectSpace(p1)
	local v5 = v3 * 0.5

	return if math.abs(v4.X) <= v5.X then math.abs(v4.Z) <= v5.Z else false
end
function t5.GetRespawnPointCFrame(p1) --[[ GetRespawnPointCFrame | Line: 372 | Upvalues: Players (copy), Asserts (copy), v3 (ref), t (copy), t3 (copy) ]]
	local v1 = if p1 then p1 else Players.LocalPlayer

	Asserts.Player(v1)

	local v2 = if v1 == Players.LocalPlayer then v3 else nil

	if not v2 then
		for k, v in pairs(t) do
			if v == v1.UserId then
				v2 = k

				break
			end
		end
	end

	if v2 then
		return t3[v2]
	end

	return nil
end

local function requestProximityPurchase(p1) --[[ requestProximityPurchase | Line: 393 | Upvalues: PromptPurchase (copy) ]]
	PromptPurchase.Prompt(p1, true)
end

local function update(p1, p2) --[[ update | Line: 397 | Upvalues: v3 (ref), t (copy), t5 (copy), Players (copy) ]]
	local v1 = v3

	t[p1] = p2
	t5.OnAnyPlotUpdated:Fire(p1, p2)

	if p2 == Players.LocalPlayer.UserId then
		v3 = p1
		t5.OnLocalPlotUpdated:Fire(p1)

		return
	end

	if v1 ~= p1 or p2 == Players.LocalPlayer.UserId then
		return
	end

	v3 = nil
	t5.OnLocalPlotUpdated:Fire(p1)
end

local function applyStateUpdate(p1) --[[ applyStateUpdate | Line: 411 | Upvalues: t4 (copy), update (copy) ]]
	local v1 = t4[p1.Slot]

	if v1 ~= nil and p1.Revision <= v1 then
		return
	end

	t4[p1.Slot] = p1.Revision
	update(p1.Slot, p1.UserId)
end

local function handleStateUpdated(p1) --[[ handleStateUpdated | Line: 421 | Upvalues: Plots (copy), v1 (copy), t4 (copy), update (copy) ]]
	local v12, v2 = Plots.SchemaValidation.PlotStateUpdate(p1)

	if not v12 then
		v1:AtError():Log((("Ignored invalid plot state update: %*"):format(v2)))

		return
	end

	local v3 = t4[p1.Slot]

	if v3 ~= nil and p1.Revision <= v3 then
		return
	end

	t4[p1.Slot] = p1.Revision
	update(p1.Slot, p1.UserId)
end

local function applyStateSnapshot(p1) --[[ applyStateSnapshot | Line: 431 | Upvalues: t4 (copy), update (copy), t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1.OwnersBySlot) do
		local v3 = assert(tonumber(k), (("Invalid plot snapshot slot key: %*"):format(k)))

		t2[v3] = true

		local v4 = t4[v3]

		if v4 == nil or v4 < p1.Revision then
			t4[v3] = p1.Revision
			update(v3, v)
		end
	end

	local list = {}

	for k in pairs(t4) do
		table.insert(list, k)
	end

	for i, v in ipairs(list) do
		if t2[v] ~= true and t4[v] < p1.Revision then
			t4[v] = p1.Revision

			if t[v] ~= nil then
				update(v, nil)
			end
		end
	end
end

local function requestStateResync() --[[ requestStateResync | Line: 457 | Upvalues: Network (copy), Plots2 (copy), Plots (copy), applyStateSnapshot (copy) ]]
	local ok, result = pcall(function() --[[ Line: 458 | Upvalues: Network (ref), Plots2 (ref) ]]
		return Network.Invoke(Plots2.REQUEST_STATE)
	end)

	if not ok then
		return false, tostring(result)
	end

	local v1, v2 = Plots.SchemaValidation.PlotStateSnapshot(result)

	if v1 then
		applyStateSnapshot(result)

		return true, nil
	end

	return false, ("Invalid plot state snapshot: %*"):format(v2)
end

local function v5() --[[ requestStateUntilReady | Line: 474 | Upvalues: requestStateResync (copy), v1 (copy), v5 (copy) ]]
	local v12, v2 = requestStateResync()

	if not v12 then
		v1:AtError():Log((("Failed to load plot state; retrying: %*"):format(v2)))
		task.delay(5, v5)
	end
end

Network.Fired(Plots2.STATE_UPDATE_EVENT):Connect(handleStateUpdated)
v4:Observe(function(p1, p2) --[[ Line: 490 | Upvalues: Asserts (copy), v2 (ref), t5 (copy), clearAllSlotTrackers (copy), observePlotSlot (copy), t2 (copy), t3 (copy) ]]
	Asserts.Folder(p1)
	v2 = p1
	t5.OnPlotsFolderUpdated:Fire(p1)
	p2:Add(function() --[[ Line: 495 | Upvalues: v2 (ref), p1 (copy), clearAllSlotTrackers (ref), t5 (ref) ]]
		if v2 ~= p1 then
			clearAllSlotTrackers()
			t5.OnPlotsFolderUpdated:Fire(nil)

			return
		end

		v2 = nil
		clearAllSlotTrackers()
		t5.OnPlotsFolderUpdated:Fire(nil)
	end)

	for i, v in ipairs(p1:GetChildren()) do
		local v22 = tonumber(v.Name)

		if v22 then
			local v3 = v2

			if v3 then
				observePlotSlot(v22, v3)
			end
		end
	end

	p2:Connect(p1.ChildAdded, function(p12) --[[ Line: 511 | Upvalues: v2 (ref), observePlotSlot (ref), t5 (ref), p1 (copy) ]]
		local v22 = tonumber(p12.Name)

		if not v22 then
			t5.OnPlotsFolderUpdated:Fire(p1)

			return
		end

		local v3 = v2

		if not v3 then
			t5.OnPlotsFolderUpdated:Fire(p1)

			return
		end

		observePlotSlot(v22, v3)
		t5.OnPlotsFolderUpdated:Fire(p1)
	end)
	p2:Connect(p1.ChildRemoved, function(p12) --[[ Line: 520 | Upvalues: t2 (ref), t3 (ref), t5 (ref), p1 (copy) ]]
		local v2 = tonumber(p12.Name)

		if v2 then
			local v3 = t2[v2]

			if v3 then
				t3[v2] = nil
				t2[v2] = nil
				v3.trove:Destroy()
			end
		end

		t5.OnPlotsFolderUpdated:Fire(p1)
	end)
end)
task.spawn(v5)
Network.Fired(Plots2.REQUEST_PROXIMITY_PURCHASE):Connect(requestProximityPurchase)

return t5