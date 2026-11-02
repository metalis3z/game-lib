local PlayerService = game:GetService('Players');
local ChatService = game:GetService('Chat');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local ServerStorage = game:GetService('ServerStorage');
--------------------------
local RadioService = {Users = {}};
--------------------------
local Utility = require(5753287781);
local TopBar = require(4874365424);
--------------------------
local Configuration = script:FindFirstChild('Configuration') and require(script:FindFirstChild('Configuration')) or {};
local Channels = script:FindFirstChild('Channels') and require(script:FindFirstChild('Channels')) or {};
local Commands = script:FindFirstChild('Commands') and require(script:FindFirstChild('Commands')) or {};
local Tags = script:FindFirstChild('Tags') and require(script:FindFirstChild('Tags')) or {};
--------------------------
local Transmitter = ReplicatedStorage:FindFirstChild('RadioTransmitter');
local Assets = script:FindFirstChild('Assets');
local Radio,Interface,Client = Assets:FindFirstChild('Radio'), Assets:FindFirstChild('Interface'), Assets:FindFirstChild('ClientController');
--------------------------
RadioService.Utility = Utility;
RadioService.Channels = Channels;
RadioService.Commands = Commands;
RadioService.Tags = Tags;
RadioService.Transmitter = Transmitter;
--------------------------
function RadioService:Rig(Player,...)
	local PlayerGui = Player:WaitForChild('PlayerGui');
	
	local Character = Player.Character or Player.CharacterAdded:Wait();
	local Humanoid = Character and Character:WaitForChild('Humanoid');
	local HumanoidRootPart = Character and Character:WaitForChild('HumanoidRootPart');
	local RightHand = Character and Character:WaitForChild('RightHand');
	local LeftHand = Character and Character:WaitForChild('LeftHand');
	
	assert(Character, 'Invalid Character');	
	assert(PlayerGui, 'Invalid PlayerGui Container');
	assert(LeftHand and RightHand, 'Invalid Hands');	
	
	local Radio = Radio;
	local Interface = Interface:Clone();
	local Controller = Client:Clone();
	local Activate, Deactivate, Animation = nil,nil, ReplicatedStorage:FindFirstChild('RadioAnimation');
	local DefaultChannel = unpack({...});
	
	Controller.Parent = Interface;
	Controller.Disabled = false;
	
	Interface.Parent = PlayerGui;
	Interface.Name = 'Radio';
	Interface.Enabled = true;
	
	Activate = function()
		Radio = Radio:Clone();
		
		local Handle = Radio:FindFirstChild('Handle');
		local DecoyHand = Radio:FindFirstChild('DecoyHand');
		local Light = Handle:FindFirstChild('Light');
		
		local HandleWeld = Instance.new('Weld');
		HandleWeld.Part0 = RightHand;
		HandleWeld.Part1 = Handle;
		HandleWeld.C0 = DecoyHand.CFrame:inverse() * CFrame.new(DecoyHand.Position);
		HandleWeld.C1 = Handle.CFrame:inverse() * CFrame.new(DecoyHand.Position);
		HandleWeld.Name = 'HandleWeld';
		HandleWeld.Parent = Handle;
		
		DecoyHand:Destroy();
		Handle.CanCollide = false;
		Handle.Anchored = false;
		
		Radio.Parent = RightHand;
		
		Light.BrickColor = BrickColor.new('Bright green');
		Animation = Humanoid:LoadAnimation(Animation);
		Animation:Play();
		
		self.Users[Player.UserId].Active = true;
	end
	
	Deactivate = function()
		Radio:Destroy();
		Radio = Assets:FindFirstChild('Radio');
		
		Animation:Stop();
		Animation = ReplicatedStorage:FindFirstChild('RadioAnimation');

		self.Users[Player.UserId].Active = false;
	end
	
	Humanoid.Died:Connect(function()
		self.Users[Player.UserId] = nil;
	end)
	
	self.Users[Player.UserId] = {Player = Player, Model = Radio, Active = false, Activate = Activate, Deactivate = Deactivate, Channel = DefaultChannel or nil};
	
	RadioService.Transmitter:FireClient(Player, 'UpdateChannel', DefaultChannel or 'None');
end

function RadioService:RetrieveTag(Player)
	local RadioTag = {Priority = 0};
	local Tags = Tags;

	for _,Tag in pairs(Tags) do
		if Utility.Permissions(Player, Tag.Requirements) then
			if Tag.Priority > RadioTag.Priority then
				RadioTag = Tag;
			end
		end
	end

	return RadioTag ~= {Priority = 0} and RadioTag or nil
end

function RadioService:MeetsRequirements(Player)
	local Default;
	
	for Name, Channel in pairs(Channels) do
		local Requirements = Channel.Requirements;
		local Result = Utility.Permissions(Player,Requirements);
		
		if Result and Channel.Default then return self:Rig(Player, Name) end
		if Channel.Default then Default = true end
	end
	
	if not Default then error('You must mark a channel as the default channel.') end
end

function RadioService:Transmit(Message, ...)
	local Arguements = {...};
	local Users = Arguements[1] or self.Users;
	
	for _,UserData in pairs(Users) do
		coroutine.wrap(function()
			if UserData.Channel == Message.Channel then
				Transmitter:FireClient(UserData.Player,'RenderMessage', Message)
			end
		end)()
	end
	
	return 'Message Transmitted'
end

function RadioService:Broadcast(Message)
	for Name,_ in pairs(Channels) do
		local Message = {
			Title = 'BROADCAST';
			Message = Message;
			Color = Color3.fromRGB(218, 31, 31);
			Channel = Name;
		};
		
		self:Transmit(Message)
	end
end

function RadioService:GetPlayerFromPartial(Name)
	for _,Player in pairs(PlayerService:GetPlayers()) do
		if string.lower(string.sub(Player.Name, 1, string.len(Name or ''))) == string.lower(Name or '') then
			return Player
		end
	end
end

function RadioService:SplitArguements(Message)
	local Arguements = {};
	local Content = Message;
	
	for Arguement in string.gmatch(Content, '[^%s]+') do table.insert(Arguements,Arguement) end
	
	return unpack(Arguements)
end

function RadioService:ParseMessage(Player, Message)
	local Radio = self.Users[Player.UserId];
	local Channel = Radio and Radio.Channel;
	local Active = Radio and Radio.Active;
	local Model = Radio and Radio.Model;
	local Muted = Radio and Radio.Muted;
	
	if not Radio or not Active or not Model then return false end
	
	local Title = string.upper(Player.Name);
	local Color = Color3.fromRGB(21, 21, 21);
	local Command = string.match(Message, '[^%s]+');
	local Tag = self:RetrieveTag(Player);
	local Result = Commands[string.lower(Command)];
	
	if Tag then
		Title = Tag and Tag.Adjustments and Tag.Adjustments.Name or Title;
		Message = Tag and Tag.Adjustments and Tag.Adjustments.Message or Message;
		Color = Tag and Tag.Adjustments and Tag.Adjustments.Color or Color;
	end
	
	if Result then
		if Utility.Permissions(Player, Result.Requirements) then
			Message = string.gsub(Message, Command, '');
			Message = string.sub(Message, 2, string.len(Message));
			
			return Result.Invoke(RadioService, Player, Message)
		else
			Title = 'Network'
			Message = 'You cannot access that command...';
			Color = Color3.fromRGB(195, 0, 0);
			
			return RadioService:Transmit({Message = Message, Title = Title, Color = Color, Channel = Channel},{{Player = Player}})
		end
	end
		
	if Channel and not Muted then return RadioService:Transmit({Message = ChatService:FilterStringForBroadcast(Message, Player) or 'There was an issue filtering this message, contact a developer.', Title = Title, Color = Color, Channel = Channel}) elseif not Channel then
		RadioService:Transmit({Message = 'You must specify a channel prior to using the radio. Use the /channels command to view accessible channels.', Title = 'SYSTEM', Color = Color3.fromRGB(21, 21, 21), Channel = nil},{{Player = Player, Channel = nil}})
	elseif Muted then
		local Authorizer = Radio and Muted.Authorizer;
		local Reason = Radio and Muted.Reason;
		
		RadioService:Transmit({Message = 'You have been muted by ' .. Authorizer.Name .. ' for the following reason: ' .. Reason, Title = 'SYSTEM', Color = Color3.fromRGB(21, 21, 21), Channel = nil},{{Player = Player, Channel = nil}})
	end
end
--------------------------
Transmitter.OnServerEvent:Connect(function(Player,Status)
	if RadioService.Users[Player.UserId] then
		RadioService.Users[Player.UserId].Active = Status
		
		if Status then RadioService.Users[Player.UserId].Activate() else
			RadioService.Users[Player.UserId].Deactivate()
		end
	end
end)
--------------------------
for _,Player in pairs(PlayerService:GetPlayers()) do
	Player.Chatted:Connect(function(Message) return RadioService:ParseMessage(Player, Message) end)
	Player.CharacterAdded:Connect(function(Character) wait(1.5) return RadioService:MeetsRequirements(Player) end)
end

PlayerService.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(Message) return RadioService:ParseMessage(Player, Message) end)
	Player.CharacterAdded:Connect(function(Character) wait(1.5) return RadioService:MeetsRequirements(Player) end)
end)
--------------------------
shared.BroadcastOnRadio = nil;
shared.BroadcastOnRadio = function(Message)
	return RadioService:Broadcast(Message)
end