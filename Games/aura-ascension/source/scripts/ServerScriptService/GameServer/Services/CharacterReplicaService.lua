local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local Ranked = require(ReplicatedStorage:WaitForChild("Ranked"))
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))
local PoseConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PoseConfig"))

local assetsFolder = ReplicatedStorage:WaitForChild("Assets")
local rankTextsFolder = assetsFolder:WaitForChild("RankTexts")
local posePropsFolder = assetsFolder:WaitForChild("PoseProps")

local CharacterReplicaService = {}
CharacterReplicaService.__index = CharacterReplicaService

function CharacterReplicaService.new()
	return setmetatable({
		Connections = {},
		CharactersFolder = nil,
		TemplateCharacter = nil,
		AppliedPoseProps = setmetatable({}, { __mode = "k" }),
	}, CharacterReplicaService)
end

function CharacterReplicaService:Init(registry)
	self.Registry = registry
end

function CharacterReplicaService:Start()
	local folderName = GameConfig.LegacyCompatibility.CharacterFolderName
	self.CharactersFolder = workspace:FindFirstChild(folderName)
	if not self.CharactersFolder then
		self.CharactersFolder = Instance.new("Folder")
		self.CharactersFolder.Name = folderName
		self.CharactersFolder.Parent = workspace
	end

	local decompiledFolder = ServerStorage:FindFirstChild("Decompiled")
	self.TemplateCharacter = decompiledFolder and decompiledFolder:FindFirstChild("LocalPlayer Character")

	for _, player in ipairs(Players:GetPlayers()) do
		self:_bindPlayer(player)
	end

	Players.PlayerAdded:Connect(function(player)
		self:_bindPlayer(player)
	end)
	Players.PlayerRemoving:Connect(function(player)
		self:_unbindPlayer(player)
	end)
end

function CharacterReplicaService:_bindPlayer(player)
	self:_unbindPlayer(player)
	local bucket = {}
	bucket.CharacterAdded = player.CharacterAdded:Connect(function(character)
		self:_onCharacterAdded(player, character)
	end)
	self.Connections[player] = bucket
	if player.Character then
		task.defer(function()
			self:_onCharacterAdded(player, player.Character)
		end)
	end
end

function CharacterReplicaService:_unbindPlayer(player)
	local bucket = self.Connections[player]
	if bucket then
		for _, connection in pairs(bucket) do
			if connection then
				connection:Disconnect()
			end
		end
		self.Connections[player] = nil
	end
	if player.Character then
		self:_clearPoseProps(player.Character)
	end
end

function CharacterReplicaService:_cloneIfMissing(parent, childName, templateParent)
	local existing = parent:FindFirstChild(childName)
	if existing then
		return existing
	end
	local templateChild = templateParent and templateParent:FindFirstChild(childName)
	if not templateChild then
		return nil
	end
	local clone = templateChild:Clone()
	clone.Parent = parent
	return clone
end

function CharacterReplicaService:_ensureCharacterPresentation(character)
	local template = self.TemplateCharacter
	if template then
		self:_cloneIfMissing(character, "Highlight", template)
		self:_cloneIfMissing(character, "ActiveAura", template)
	end

	local head = character:FindFirstChild("Head")
	local templateHead = template and template:FindFirstChild("Head")
	if head and templateHead then
		self:_cloneIfMissing(head, "OverheadDisplay", templateHead)
		self:_cloneIfMissing(head, "RebirthAttachment", templateHead)
	end

	local highlight = character:FindFirstChild("Highlight")
	if highlight and highlight:IsA("Highlight") then
		highlight.Enabled = true
		highlight.FillTransparency = math.clamp(highlight.FillTransparency, 0, 1)
	end
end

function CharacterReplicaService:_clearPoseProps(character)
	self.AppliedPoseProps[character] = nil
	local activeFolder = character:FindFirstChild("ActivePoseProps")
	if activeFolder then
		activeFolder:Destroy()
	end
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:GetAttribute("PoseProp") == true then
			descendant:Destroy()
		end
	end
end

function CharacterReplicaService:_resolveAttachPart(character, propId, propFolder)
	local candidates = {}
	local attachPartName = propFolder and propFolder:GetAttribute("AttachPartName")
	if type(attachPartName) == "string" and attachPartName ~= "" then
		table.insert(candidates, attachPartName)
	elseif propId == "SilverSurfer" then
		table.insert(candidates, "Torso")
		table.insert(candidates, "UpperTorso")
		table.insert(candidates, "HumanoidRootPart")
	else
		table.insert(candidates, "Torso")
	end
	for _, partName in ipairs(candidates) do
		local attachPart = character:FindFirstChild(partName, true)
		if attachPart and attachPart:IsA("BasePart") then
			return attachPart
		end
	end
	return nil
end

function CharacterReplicaService:_attachStoredProp(character, propId)
	if not character or not character.Parent then
		return false
	end
	local propFolder = posePropsFolder:FindFirstChild(propId)
	if not propFolder then
		return false
	end
	local attachPart = self:_resolveAttachPart(character, propId, propFolder)
	if not attachPart then
		return false
	end
	local cube = propFolder:FindFirstChild("Cube", true)
	local motor = propFolder:FindFirstChildWhichIsA("Motor6D", true)
	if not cube or not cube:IsA("BasePart") or not motor then
		return false
	end

	self:_clearPoseProps(character)

	local folder = Instance.new("Folder")
	folder.Name = "ActivePoseProps"
	folder.Parent = character

	local cubeClone = cube:Clone()
	cubeClone.Name = cube.Name
	cubeClone.Parent = folder
	cubeClone.Anchored = false
	cubeClone.CanCollide = false
	cubeClone.CanTouch = false
	cubeClone.CanQuery = false
	cubeClone.Massless = true
	cubeClone:SetAttribute("PoseProp", true)

	local motorClone = motor:Clone()
	motorClone.Part0 = attachPart
	motorClone.Part1 = cubeClone
	motorClone.Parent = attachPart
	motorClone:SetAttribute("PoseProp", true)

	self.AppliedPoseProps[character] = propId
	return true
end

function CharacterReplicaService:_syncPoseProp(player, character)
	if not player or not character or not character.Parent then
		return
	end
	local poseId = player:GetAttribute("EquippedPose") or ""
	if poseId == "" then
		self:_clearPoseProps(character)
		return
	end
	local pose = PoseConfig.GetPose(poseId)
	local prop = pose and pose.Prop
	if type(prop) ~= "table" or prop.Type ~= "StoredProp" or type(prop.PropId) ~= "string" or prop.PropId == "" then
		self:_clearPoseProps(character)
		return
	end
	if self.AppliedPoseProps[character] == prop.PropId then
		return
	end
	if not self:_attachStoredProp(character, prop.PropId) then
		self:_clearPoseProps(character)
	end
end

function CharacterReplicaService:_moveCharacterToFolder(_, character)
	if not self.CharactersFolder or not character or not character:IsDescendantOf(workspace) then
		return
	end
	if character.Parent ~= self.CharactersFolder then
		character.Parent = self.CharactersFolder
	end
end

function CharacterReplicaService:_onCharacterAdded(player, character)
	if not character or not character:IsA("Model") then
		return
	end
	task.defer(function()
		self:_moveCharacterToFolder(player, character)
		self:_ensureCharacterPresentation(character)
		self:_syncPoseProp(player, character)
		self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	end)
end

function CharacterReplicaService:_applyRankTemplate(rankLabel, templateName, displayText)
	if not rankLabel or not rankLabel:IsA("TextLabel") then
		return
	end
	local template = rankTextsFolder:FindFirstChild(templateName) or rankTextsFolder:FindFirstChild(displayText)
	if template and template:IsA("TextLabel") then
		pcall(function()
			Ranked.MimicTextLabel(rankLabel, template, true)
		end)
	end
	rankLabel.Text = displayText
end

function CharacterReplicaService:SyncPlayer(player)
	local character = player.Character
	if not character or not character.Parent then
		return
	end

	self:_moveCharacterToFolder(player, character)
	self:_ensureCharacterPresentation(character)
	self:_syncPoseProp(player, character)

	local head = character:FindFirstChild("Head")
	local gui = head and head:FindFirstChild("OverheadDisplay")
	if not gui or not gui:IsA("BillboardGui") then
		return
	end

	gui.AlwaysOnTop = true
	gui.Enabled = true

	local frame = gui:FindFirstChild("Frame")
	if not frame then
		return
	end

	local aura = tonumber(player:GetAttribute("Aura")) or 0
	local rebirths = tonumber(player:GetAttribute("Rebirths")) or 0
	local _, currentRank = Ranked.GetRankByAura(aura)
	local displayText = player:GetAttribute("DisplayRankText") or (currentRank and currentRank.Name or "Noob")
	local templateName = player:GetAttribute("DisplayRankTemplateName") or displayText

	local playerNameLabel = frame:FindFirstChild("PlayerName")
	if playerNameLabel and playerNameLabel:IsA("TextLabel") then
		playerNameLabel.Text = player.DisplayName
	end

	local rankLabel = frame:FindFirstChild("Rank")
	if rankLabel and rankLabel:IsA("TextLabel") then
		self:_applyRankTemplate(rankLabel, templateName, displayText)
	end

	local auraFrame = frame:FindFirstChild("Aura")
	local auraCountLabel = auraFrame and auraFrame:FindFirstChild("Count")
	if auraCountLabel and auraCountLabel:IsA("TextLabel") then
		auraCountLabel.Text = MathUtility.FormatNumber(aura)
	end

	local rebirthFrame = frame:FindFirstChild("Rebirth")
	local rebirthCountLabel = rebirthFrame and rebirthFrame:FindFirstChild("Count")
	if rebirthCountLabel and rebirthCountLabel:IsA("TextLabel") then
		rebirthCountLabel.Text = MathUtility.FormatNumber(rebirths)
	end

	pcall(function()
		Ranked.UpdateOverheadGui(player, gui, aura)
	end)
	if rankLabel and rankLabel:IsA("TextLabel") then
		rankLabel.Text = displayText
	end
end

return CharacterReplicaService