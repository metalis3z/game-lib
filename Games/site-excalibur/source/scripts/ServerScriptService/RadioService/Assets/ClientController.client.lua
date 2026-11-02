local PlayerService = game:GetService('Players');
local ChatService = game:GetService('Chat');
local TextService = game:GetService('TextService');
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local TweenService = game:GetService('TweenService');
local ContextActionService = game:GetService('ContextActionService');
--------------------------
local Transmitter = ReplicatedStorage:FindFirstChild('RadioTransmitter');
local TopBar = ReplicatedStorage:WaitForChild('HDAdmin'):WaitForChild('Topbar+');
local IconController = require(TopBar:WaitForChild('IconController'));
--------------------------
local Player = PlayerService.LocalPlayer;
local PlayerGui = Player and Player:WaitForChild('PlayerGui');
local Character = Player and Player.Character or Player.CharacterAdded:Wait();
local Humanoid = Character and Character:WaitForChild('Humanoid');
--------------------------
local Container = script.Parent:FindFirstChild('Container');
local Header = Container and Container:FindFirstChild('Header');
local Body = Container and Container:FindFirstChild('Body');
--------------------------
local MessageTemplate = script:FindFirstChild('MessageTemplate');
--------------------------
local RadioActive = false;
--------------------------
Body.ChildAdded:Connect(function(Message)
	Body.CanvasSize = UDim2.new(0,Body:FindFirstChild('List').AbsoluteContentSize.X, 0,Body:FindFirstChild('List').AbsoluteContentSize.Y + 80);
	TweenService:Create(Body, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0,Body.CanvasSize.Y.Offset - 80)}):Play();
end)
--------------------------
local ChannelIcon,ActivatorIcon

pcall(function()
	ActivatorIcon = IconController:getIcon('ActivatorIcon') or IconController:createIcon('ActivatorIcon', 5876891490, 1);
	ActivatorIcon:disableStateOverlay(true);
	ActivatorIcon:setLabel('T');
		
	ChannelIcon = IconController:getIcon('ChannelIndicator') or IconController:createIcon('ChannelIndicator',5876892468,2);
	ChannelIcon:disableStateOverlay(true);
	ChannelIcon:setLabel('None');
end)
--------------------------
local EventConnector = Transmitter.OnClientEvent:Connect(function(Action, ...)
	if Action == 'RenderMessage' then
		local Message = unpack({...});
		
		local Title = Message.Title;
		local Content = Message.Message;
		local Color = Message.Color;
		local Channel = Message.Channel;

		local MessageContainer = MessageTemplate:Clone();
		local TitleSize = TextService:GetTextSize(Content, 16, 19, MessageContainer:FindFirstChild('Title').AbsoluteSize);
		local ContentSize = TextService:GetTextSize(Content, 14, 17, Vector2.new(574, 80));
		local ContainerSize = ContentSize + Vector2.new(15,15);

		MessageContainer.BackgroundColor3 = Color;
		MessageContainer:FindFirstChild('Title').Text = Title;
		MessageContainer:FindFirstChild('Message').Text = Content;

		MessageContainer.BackgroundTransparency = 1;
		MessageContainer:FindFirstChild('Title').TextTransparency = 1;
		MessageContainer:FindFirstChild('Message').TextTransparency = 1;

		MessageContainer.Size = UDim2.new(1, 0, 0, ContentSize.Y + TitleSize.Y + 15);
		MessageContainer:FindFirstChild('Title').Size = UDim2.new(1,0,0,TitleSize.Y);
		MessageContainer:FindFirstChild('Message').Size = UDim2.new(1,0,0,ContentSize.Y);
		MessageContainer.Parent = Body;

		coroutine.wrap(function() TweenService:Create(MessageContainer, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 0.65}):Play() end)()
		coroutine.wrap(function() TweenService:Create(MessageContainer:FindFirstChild('Title'), TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {TextTransparency = 0}):Play() end)()
		coroutine.wrap(function() TweenService:Create(MessageContainer:FindFirstChild('Message'), TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {TextTransparency = 0}):Play() end)()
	elseif Action == 'UpdateChannel' then
		local Channel = unpack({...});
		ChannelIcon:setLabel(Channel);
	end
end)
--------------------------
local ActionBind = ContextActionService:BindAction('RadioActivator', function(Action, State, Input)
	if Action == 'RadioActivator' and State == Enum.UserInputState.Begin and Input.KeyCode == Enum.KeyCode.T then
		if RadioActive then
			ActivatorIcon:setImage(5876891490);
			ActivatorIcon:deselect();
			RadioActive = false;
		else
			ActivatorIcon:setImage(5876896535);
			ActivatorIcon:select();
			RadioActive = true;
		end
		
		Transmitter:FireServer(RadioActive)
	end
end, false, Enum.KeyCode.T)
--------------------------
if Humanoid then
	Humanoid.Died:Connect(function()
		ContextActionService:UnbindAction('RadioActivator');
		EventConnector:Disconnect();
	end)
else
	warn('Issue resolving Humanoid!')

	ContextActionService:UnbindAction('RadioActivator');
	EventConnector:Disconnect();
	script.Parent:Destroy();
end