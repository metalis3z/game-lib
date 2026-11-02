local speakEvent = script.Parent.Handle.Mic_Air
local VoiceChatService = game:GetService("VoiceChatService")
local parentObject = script.Parent
local mic = parentObject:FindFirstChild("Mic")
local speakersFolder = parentObject:FindFirstChild("Speakers")
local Debris = game:GetService("Debris")

local players = game:GetService("Players")

--[[local function connect(src: Instance, dst: Instance)
	local wire = Instance.new("Wire", dst)
	wire.SourceInstance = src
	wire.TargetInstance = dst
end

local function onCharacterSpawned(from: Player, character: Model)
	local emitter = Instance.new("AudioEmitter", character)
	emitter.AudioInteractionGroup = "PartySpeakers"
	connect(from.AudioDeviceInput, emitter)
end

local function onPlayerAdded(player: Player)
	local input = Instance.new("AudioDeviceInput", player)
	input.Player =  player
	Debris:AddItem(input, 10)

	if player.Character then
		onCharacterSpawned(player, player.Character)
	end

	player.CharacterAdded:Connect(function(character: Model)
		onCharacterSpawned(player, character)
	end)
end]]

--onPlayerAdded(game.Players.Timofeys677)


local function getCFrameFrom(inst: Instance) : CFrame?
	local parent = inst.Parent
	if not parent then
		return nil
	elseif parent:IsA("Model") then
		return parent.WorldPivot
	elseif parent:IsA("BasePart") then
		return parent.CFrame
	elseif parent:IsA("Attachment") then
		return parent.WorldCFrame
	elseif parent:IsA("Camera") then
		return parent.CFrame
	else
		return nil
	end
end

local function rescale(value: number, oldRange: NumberRange, newRange: NumberRange) : number
	local clamped = math.clamp(value, oldRange.Min, oldRange.Max)
	local normalized = clamped - oldRange.Min / (oldRange.Max - oldRange.Min)
	return normalized * (newRange.Max - newRange.Min) + newRange.Min
end

local assetPlayer = Instance.new("AudioPlayer")
assetPlayer.AssetId = "rbxassetid://142376088"
assetPlayer.Parent = workspace

assetPlayer.Looping = true
assetPlayer:Play()

speakEvent.OnServerEvent:Connect(function()
	local equalizer = mic.AudioEqualizer
	
	local emitterFrame = getCFrameFrom(emitter)
	local listenerFrame = getCFrameFrom(listener)
	if emitterFrame and listenerFrame then
		local towardEmitter = emitterFrame.Position - listenerFrame.Position
		local look = towardEmitter.Unit:Dot(listenerFrame.LookVector) -- ranges from [-1, 1]
		look = rescale(look, NumberRange.new(-1, 1), NumberRange.new(-20, 0))

		local distance = math.max(towardEmitter.Magnitude, 1)
		local rolloff = 1 / distance -- ranges from [0, 1]
		rolloff = rescale(rolloff, NumberRange.new(0, 1), NumberRange.new(-10, 10))

		equalizer.HighGain = look + rolloff
		equalizer.LowGain = rolloff
	end
	task.wait()
end)