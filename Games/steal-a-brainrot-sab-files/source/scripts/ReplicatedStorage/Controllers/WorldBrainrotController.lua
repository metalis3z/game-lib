local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Packages.Gradients)
local FastOverheadController = require(ReplicatedStorage.Controllers.FastOverheadController)
local AnimalOverheadController = require(ReplicatedStorage.Controllers.AnimalOverheadController)
local Animals = require(ReplicatedStorage.Shared.Animals)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
require(ReplicatedStorage.Datas.Mutations)
require(ReplicatedStorage.Datas.Traits)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

local GrabRemote = Net:RemoteEvent("WorldBrainrotService/Grab")
local DropRemote = Net:RemoteEvent("WorldBrainrotService/Drop")

local LocalPlayer = Players.LocalPlayer

local poolsRoot   = nil
local dropButton  = nil
local activePools = {}

local overheadRegistry = {}
local _overheadAccum   = 0

RunService.Heartbeat:Connect(function(dt)
	_overheadAccum = _overheadAccum + dt
	if _overheadAccum < 1 then return end
	_overheadAccum = _overheadAccum - 1
	for _, fn in pairs(overheadRegistry) do
		fn()
	end
end)

local function getPoolsRoot()
	if poolsRoot and poolsRoot.Parent then return poolsRoot end
	poolsRoot = workspace:FindFirstChild("WBPools")
	return poolsRoot
end

local function getDropButton()
	if dropButton and dropButton.Parent then return dropButton end
	local tf = LocalPlayer.PlayerGui:FindFirstChild("ToolsFrames")
	if tf then dropButton = tf:FindFirstChild("Drop") end
	return dropButton
end

local function toSafeName(id)
	return id:gsub("[/\\%s]", "_")
end

local function decodeTraits(str)
	if not str or str == "" then return nil end
	local ok, val = pcall(HttpService.JSONDecode, HttpService, str)
	return ok and val or nil
end

local function anyLocalGrab()
	local root = getPoolsRoot()
	if not root then return nil end
	for _, entry in ipairs(activePools) do
		if entry.params.ShowDropButton then
			local folder = root:FindFirstChild(toSafeName(entry.poolId))
			if folder then
				for _, part in ipairs(folder:GetChildren()) do
					if part:IsA("Part") and part:GetAttribute("BG") == LocalPlayer.UserId then
						local name = part:GetAttribute("BName")
						if name ~= "Gold Egg" then
							return entry.params.PoolId
						end
					end
				end
			end
		end
	end
	return nil
end

task.defer(function()
	local tf = LocalPlayer.PlayerGui:WaitForChild("ToolsFrames", 20)
	if not tf then return end
	dropButton = tf:FindFirstChild("Drop")
	if not dropButton then return end
	dropButton.Activate.Activated:Connect(function()
		local poolId = anyLocalGrab()
		if poolId then DropRemote:FireServer(poolId) end
	end)
end)

local WorldBrainrotController = {}

function WorldBrainrotController.get(a, b)
	local poolId = b or a
	local safeName = toSafeName(poolId)
	local compat = {}
	function compat:TryIndex(path)
		local root = getPoolsRoot()
		if not root then return nil end
		local folder = root:FindFirstChild(safeName)
		if not folder then return nil end
		if path[1] == "brainrots" then
			if path[2] then
				local part = folder:FindFirstChild(path[2])
				if not part then return nil end
				return {
					brainrot = part:GetAttribute("BName"),
					cframe = part:GetAttribute("BCF"),
					grabbed = part:GetAttribute("BG"),
					mutation = part:GetAttribute("BMut"),
					traits = decodeTraits(part:GetAttribute("BTr")),
					despawnTimer = part:GetAttribute("BDT"),
					timer = part:GetAttribute("BTim"),
					caged = part:GetAttribute("BCaged"),
					requiresLineOfSight = part:GetAttribute("BRLOS"),
				}
			else
				local result = {}
				for _, p in ipairs(folder:GetChildren()) do
					if p:IsA("Part") then result[p.Name] = true end
				end
				return result
			end
		end
		return nil
	end
	return compat
end

function WorldBrainrotController.RenderPool(_, params)
	local mainTrove = Trove.new()
	local poolId = params.PoolId
	local renderedBrainrots = params.RenderedBrainrots or {}
	local showTimer = params.ShowTimer
	local grabHoldDuration = params.GrabHoldDuration or 2
	local grabMaxDistance = params.GrabMaxDistance or 10

	local poolEntry = {params = params, poolId = poolId}
	table.insert(activePools, poolEntry)
	mainTrove:Add(function()
		for i, v in ipairs(activePools) do
			if v == poolEntry then table.remove(activePools, i) break end
		end
	end)

	local function refreshDropButton()
		local btn = getDropButton()
		if btn then btn.Visible = anyLocalGrab() ~= nil end
	end

	local function renderEntry(part)
		if renderedBrainrots[part.Name] then return end

		local entryTrove = Trove.new()
		local innerTrove = entryTrove:Extend()
		renderedBrainrots[part.Name] = {trove = entryTrove, model = nil, prompt = nil}
		entryTrove:Add(function() renderedBrainrots[part.Name] = nil end)

		local function build()
			innerTrove:Destroy()
			local brainrotName = part:GetAttribute("BName")
			if not brainrotName or brainrotName == "" then return end

			local model = Animals:GetAnimatedModel(brainrotName, "Idle")
			if not model then return end

			innerTrove:Add(model)
			renderedBrainrots[part.Name].model = model
			innerTrove:Add(function()
				if renderedBrainrots[part.Name] then
					renderedBrainrots[part.Name].model = nil
					renderedBrainrots[part.Name].prompt = nil
				end
			end)

			local primaryPart = model.PrimaryPart
			if not primaryPart then return end
			local animalData = AnimalsData[brainrotName]
			if not animalData then return end
			local rarityData = Rarities[animalData.Rarity]
			if not rarityData then return end

			local isEgg = animalData.Egg ~= nil
			local isGoldEgg = brainrotName == "Gold Egg"

			primaryPart.Anchored = true
			for _, p in ipairs(model:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
					p.Massless = true
				end
			end

			local mutStr = part:GetAttribute("BMut") or ""
			local traits = decodeTraits(part:GetAttribute("BTr"))
			if mutStr ~= "" then Animals:ApplyMutation(model, brainrotName, mutStr) end
			if traits then Animals:ApplyTraits(model, brainrotName, traits) end

			local customPrice      = part:GetAttribute("BCustomPrice")
			local customRarity     = part:GetAttribute("BCustomRarity")
			local customGeneration = part:GetAttribute("BCustomGeneration")

			local function syncPosition()
				local grabbed = part:GetAttribute("BG")
				if grabbed and grabbed ~= 0 then
					model:PivotTo(CFrame.new(1e6, 1e6, 1e6))
				else
					local cf = part:GetAttribute("BCF")
					if cf then model:PivotTo(cf) end
				end
				refreshDropButton()
			end

			innerTrove:Add(part:GetAttributeChangedSignal("BCF"):Connect(function()
				if (part:GetAttribute("BG") or 0) == 0 then
					local cf = part:GetAttribute("BCF")
					if cf then model:PivotTo(cf) end
				end
			end))
			innerTrove:Add(part:GetAttributeChangedSignal("BG"):Connect(syncPosition))
			innerTrove:Add(task.defer(syncPosition))

			local overheadAttach = model:FindFirstChild("OVERHEAD_ATTACHMENT", true)
			if not overheadAttach then
				overheadAttach = Instance.new("Attachment")
				overheadAttach.CFrame = CFrame.new(0, model:GetExtentsSize().Y * 0.5, 0)
				overheadAttach.Parent = primaryPart
			end

			local gui, cleanGui = FastOverheadController.createFastOverhead({
				adornee = overheadAttach,
				guiTemplate = FastOverheadController.GuiTemplates.AnimalOverhead,
			})
			innerTrove:Add(cleanGui)

			local genLabel    = gui.Generation
			local stolenLabel = gui.Stolen

			if isGoldEgg then
				stolenLabel.Visible = false
			elseif isEgg then
				stolenLabel.Visible = true
				stolenLabel.LayoutOrder = -1
				stolenLabel.Size = UDim2.fromScale(1, 0.25)
			elseif showTimer then
				stolenLabel.Visible = true
				stolenLabel.LayoutOrder = -1
				stolenLabel.Size = UDim2.fromScale(1, 0.25)
			else
				stolenLabel.Visible = false
			end

			AnimalOverheadController:Populate({
				Overhead = gui,
				Index = brainrotName,
				Traits = traits,
				Mutation = mutStr ~= "" and mutStr or nil,
				Trove = innerTrove,
				HidePrice = isGoldEgg or isEgg,
				HideRarity = isGoldEgg,
				CustomRarity = customRarity,
				CustomPrice  = customPrice,
			})

			genLabel.Visible = not isGoldEgg and not isEgg

			local function refreshOverhead()
				if isGoldEgg then
					return
				elseif isEgg then
					local bdt = part:GetAttribute("BDT")
					stolenLabel.Text = (bdt ~= nil and bdt >= 0) and math.floor(bdt) .. "s" or "0s"
				else
					local btim = part:GetAttribute("BTim")
					if btim ~= nil and btim >= 0 then
						genLabel.Text = math.floor(btim) .. "s"
					else
						if customGeneration then
							local gen = AnimalOverheadController:CalculateGenerationWithMultipliers(
								customGeneration,
								traits,
								mutStr ~= "" and mutStr or nil
							)
							genLabel.Text = ("$%s/s"):format(NumberUtils:ToString(gen))
						else
							genLabel.Text = ("$%s/s"):format(NumberUtils:ToString(
								Animals:GetGeneration(brainrotName, mutStr ~= "" and mutStr or nil, traits, nil)
								))
						end
					end
					if showTimer then
						stolenLabel.Text = ("%ds"):format(math.floor(part:GetAttribute("BDT") or 0))
					end
				end
			end

			if not isGoldEgg then
				task.spawn(refreshOverhead)

				overheadRegistry[part] = refreshOverhead
				innerTrove:Add(function()
					overheadRegistry[part] = nil
				end)

				innerTrove:Add(part:GetAttributeChangedSignal("BTim"):Connect(refreshOverhead))
				innerTrove:Add(part:GetAttributeChangedSignal("BDT"):Connect(refreshOverhead))
			end

			gui.Parent = overheadAttach

			local prompt = innerTrove:Add(Instance.new("ProximityPrompt"))
			prompt.ActionText = isGoldEgg and "Collect" or "Grab"
			prompt.ObjectText = brainrotName
			prompt.HoldDuration = grabHoldDuration
			prompt.RequiresLineOfSight = part:GetAttribute("BRLOS") == true
			prompt.MaxActivationDistance = grabMaxDistance
			prompt.Parent = primaryPart

			renderedBrainrots[part.Name].prompt = prompt
			if params.OnRendered then params.OnRendered(part.Name) end

			innerTrove:Add(prompt.Triggered:Connect(function(player)
				if player.Character then
					GrabRemote:FireServer(params.PoolId, part.Name)
				end
			end))
		end

		innerTrove:Add(part:GetAttributeChangedSignal("BMut"):Connect(build))
		innerTrove:Add(part:GetAttributeChangedSignal("BTr"):Connect(build))
		innerTrove:Add(part:GetAttributeChangedSignal("BCustomPrice"):Connect(build))
		innerTrove:Add(part:GetAttributeChangedSignal("BCustomRarity"):Connect(build))
		innerTrove:Add(part:GetAttributeChangedSignal("BCustomGeneration"):Connect(build))
		innerTrove:Add(task.spawn(build))
	end

	local function connectFolder(folder)
		mainTrove:Add(folder.ChildAdded:Connect(function(child)
			if child:IsA("Part") then renderEntry(child) end
			refreshDropButton()
		end))
		mainTrove:Add(folder.ChildRemoved:Connect(function(child)
			local entry = renderedBrainrots[child.Name]
			if entry then entry.trove:Destroy() end
			refreshDropButton()
		end))
		for _, child in ipairs(folder:GetChildren()) do
			if child:IsA("Part") then renderEntry(child) end
		end
		refreshDropButton()
	end

	local safeName = toSafeName(poolId)
	task.spawn(function()
		local root = getPoolsRoot()
		if not root then
			local conn; local done = false
			conn = workspace.ChildAdded:Connect(function(child)
				if child.Name ~= "WBPools" then return end
				if conn then conn:Disconnect() end
				if done then return end
				done = true
				poolsRoot = child
				local f = child:FindFirstChild(safeName)
				if f then connectFolder(f)
				else
					child.ChildAdded:Connect(function(sub)
						if sub.Name == safeName then connectFolder(sub) end
					end)
				end
			end)
			return
		end
		poolsRoot = root
		local folder = root:FindFirstChild(safeName)
		if folder then
			connectFolder(folder)
		else
			root.ChildAdded:Connect(function(f)
				if f.Name == safeName then connectFolder(f) end
			end)
		end
	end)

	mainTrove:Add(function()
		for id in pairs(table.clone(renderedBrainrots)) do
			local entry = renderedBrainrots[id]
			if entry then entry.trove:Destroy() end
		end
	end)

	return mainTrove
end

return table.freeze(WorldBrainrotController)