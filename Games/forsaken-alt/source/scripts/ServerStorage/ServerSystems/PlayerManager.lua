-- <- Init -> --
local Module = {}
Module.__index = Module

-- <- Services -> --
local Client = game:GetService('ReplicatedStorage');
local Debris = game:GetService('Debris');

-- <- Private Variables -> --
local Assets = Client:FindFirstChild('Assets');
local Emotes = Assets:FindFirstChild('Emotes');
local Items = Assets:FindFirstChild('Items');

-- <- Modules -> --
local Initializer = require(Client.Initializer);
local Network = Initializer.Modules.Network;

-- <- Functions -> --
function Module:StopSound(Player: Player, Animation: string)
	local Character = Player.Character 
	if not Character then 
		return
	end
	--
	local Humanoid = Character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then 
		return
	end
	--
	if not Emotes:FindFirstChild(Animation) then		
		return
	end
	--
	local Required = require(Emotes:FindFirstChild(Animation))
	if not Required.Destroyed then
		return
	end
	--
	Required.Destroyed({Character = Character})
end

function Module:StopAnims(Player: Player)
	local Character = Player.Character 
	if not Character then 
		return
	end
	--
	local Humanoid = Character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then 
		return
			
	end
	--
	for Index, Value in Humanoid:FindFirstChildOfClass('Animator'):GetPlayingAnimationTracks() do 
		if Emotes:FindFirstChild(Value.Name) then
			Value:Stop()
			--
			Module:StopSound(Player, Value.Name)
		end
	end
	--
	for Index, Value in Character:FindFirstChild('HumanoidRootPart'):GetChildren() do 
		if Emotes:FindFirstChild(Value.Name) then
			Value:Destroy()
		end
	end
	--
end

function Module:PlayerAnim(Player: Player, AnimationName: string)
	if not AnimationName then
		return
	end
	--
	local FoundAnimation = Emotes:FindFirstChild(AnimationName)
	if not FoundAnimation then
		return
	end
	--
	local RequiredEmote = require(FoundAnimation);
	if not RequiredEmote then
		return
	end
	--
	local Character = Player.Character 
	if not Character then 
		return
	end
	--
	local Humanoid = Character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then 
		return
	end
	--
	Module:StopAnims(Player)
	--
	local SFX = RequiredEmote.SFX
	local CreatedFunction = RequiredEmote.Created
	local SFXPro = RequiredEmote.SFXProperties
	local CreatedAudio = Instance.new('Sound')
	--
	if SFXPro then 
		for Index, Value in SFXPro do 
			CreatedAudio[Index] = Value
		end
	end
	--
	CreatedAudio.Name = AnimationName
	CreatedAudio.SoundId = (SFX) or ''
	CreatedAudio.Parent = Character:FindFirstChild('HumanoidRootPart')
	--
	local NewAnimation = Instance.new('Animation')
	NewAnimation.Name = AnimationName
	NewAnimation.AnimationId = typeof(RequiredEmote.AssetID) == 'table' and RequiredEmote.AssetID[math.random(1, #RequiredEmote.AssetID)] or RequiredEmote.AssetID
	local LoadedTrack = Humanoid:FindFirstChildOfClass('Animator'):LoadAnimation(NewAnimation)
	--
	if CreatedFunction then
		CreatedFunction({Character = Character})
	end
	--
	CreatedAudio:Play()
	LoadedTrack:Play()
	--
	Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if Humanoid.MoveDirection.Magnitude > 0 then
			Module:StopAnims(Player)
		end
	end)
	--
	if not CreatedAudio.Looped then 
		Debris:AddItem(CreatedAudio, CreatedAudio.TimeLength)
	end
end

function Module:EquipTool(Player: Player, Tool: Tool)
	local ToolName = Tool.Name
	--
	local FoundFolder: Folder = Items:FindFirstChild(ToolName);
	if not FoundFolder then
		return
	end
	--
	local Character = Player.Character
	if not Character then
		return
	end
	--
	local ItemTool = Player.Backpack:FindFirstChild(ToolName);
	if not ItemTool then
		return
	end
	--
	Tool.Parent = Character
end

function Module:UnEquipTool(Player: Player, Tool: Tool)
	local ToolName = Tool.Name
	--
	local FoundFolder: Folder = Items:FindFirstChild(ToolName);
	if not FoundFolder then
		return
	end
	--
	local Character = Player.Character
	if not Character then
		return
	end
	--
	local ItemTool = Character:FindFirstChild(ToolName);
	if not ItemTool then
		return
	end
	--
	Tool.Parent = Player.Backpack
end

function Module:UpdateSetting(Player: Player, Setting: string, NewValue)
	local PlayerData = Player:FindFirstChild('PlayerData');
	if not PlayerData then 
		return
	end
	--
	if not Setting then 
		return
	end
	--
	Setting.Value = NewValue
end

-- <- Network -> --
function Module.Start()
	Network:SetConnection('PlayEmote', 'REMOTE_EVENT', function(Player: Player, ...)
		local Animation, AnimationName = ...
		--
		Module:PlayerAnim(Player, AnimationName)
	end)
	--
	Network:SetConnection('StopEmote', 'REMOTE_EVENT', function(Player: Player, ...)
		Module:StopAnims(Player)
	end)
	-- Backpack
	Network:SetConnection('UpdateItemParent', 'REMOTE_EVENT', function(Player: Player, Item: Tool)
		if Player.Backpack:FindFirstChild(Item.Name) then
			Module:EquipTool(Player, Item)
		else 
			Module:UnEquipTool(Player, Item)
		end
	end)
	-- Settings
	Network:SetConnection('UpdateSettings', 'REMOTE_EVENT', function(Player: Player, Setting: string, NewValue)
		Module:UpdateSetting(Player, Setting, NewValue)
	end)
end

-- <- Return -> --
return Module