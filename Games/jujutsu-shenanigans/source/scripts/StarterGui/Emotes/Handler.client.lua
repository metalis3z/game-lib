-- SERVICES --

local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local PlayerService = game:GetService('Players')
local MarketService = game.MarketplaceService


-- REMOTES --

local Remotes = RS.Remotes

local Comunicator: RemoteEvent = Remotes.Comunicator.Set
local Getter = Remotes.Comunicator.Get

local EmotesGet = Remotes.Emotes.Get
local EmotesSet = Remotes.Emotes.Set


-- PLAYER --

local Player = PlayerService.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()


-- EMOTES --

local EmotesFolder = RS.Assets.Emotes
local EmoteIds = {}


-- PASSES --

repeat task.wait() until shared.Passes

local MoreEmoteSlotsPass = shared.Passes["More Emote Slots"]
local SecondEmotePagePass = shared.Passes["Second Emote Page"]



-- GUI --

local GUI = script.Parent
local EmoteWheel = GUI.ImageLabel
local ScrollFrame = script.ScrollingFrame
local CurrentPage = 1
local PagesSlots = {
	[1] = {
		[1] = EmoteWheel.Emotes['1'];
		[2] = EmoteWheel.Emotes['2'];
		[3] = EmoteWheel.Emotes['3'];
		[4] = EmoteWheel.Emotes['4'];
		[5] = EmoteWheel.Emotes['5'];
		[6] = EmoteWheel.Emotes['6'];
		[7] = EmoteWheel.Emotes['7'];
		[8] = EmoteWheel.Emotes['8'];
	}; 
	
	[2] = {
		[1] = EmoteWheel.Emotes2['1'];
		[2] = EmoteWheel.Emotes2['2'];
		[3] = EmoteWheel.Emotes2['3'];
		[4] = EmoteWheel.Emotes2['4'];
		[5] = EmoteWheel.Emotes2['5'];
		[6] = EmoteWheel.Emotes2['6'];
		[7] = EmoteWheel.Emotes2['7'];
		[8] = EmoteWheel.Emotes2['8'];
	}
}


-- FUNCTIONS --

local function PlayAnim(Animator: Animator, Animation)
	for _,track in Animator:GetPlayingAnimationTracks() do
		track:Stop()
	end
	
	local Track = Animator:LoadAnimation(Animation)
	
	Track.Looped = true
	Track:Play()
end

local function CloseScrolls()
	for _, Slot in PagesSlots[CurrentPage] do
		local SF = Slot:FindFirstChild('ScrollingFrame')

		if SF then
			SF:Destroy()
		end
	end
end

local function TriggerVisibleSlots(value: boolean, excludeSlot: string)
	for i, Slot in PagesSlots[CurrentPage] do
		if value == true and i == 5 then 
			if MarketService:UserOwnsGamePassAsync(Player.UserId, MoreEmoteSlotsPass) == false then
				return
			end
		end

		if Slot.Name ~= excludeSlot then
			Slot.Visible = value
		end
	end
end

local function ChangeSlotEmote(Slot: Frame, EmoteName: string, Page: string)
	if not EmoteIds[EmoteName] then EmoteName = 'Crush' end
	
	local couldSetEmote = Getter:InvokeServer('SetEmote', { Slot = Slot.Name, EmoteName = EmoteName, Page = Page; })
	if couldSetEmote == true then
		local EmoteAnim = EmotesFolder:FindFirstChild(EmoteName)
		if not EmoteIds[EmoteName] or not EmoteAnim then return end
		
		
		local Desc = EmoteAnim:GetAttribute('Description')
		if Desc then
			Slot.EmoteProperty.Text = Desc
			Slot.EmoteProperty.Visible = true
		else
			Slot.EmoteProperty.Visible = false
		end
		
		Slot.EmoteName.Text = EmoteName
		Slot.ViewportFrame.WorldModel.Preview.Animation.AnimationId = EmoteIds[EmoteName]
		PlayAnim(Slot.ViewportFrame.WorldModel.Preview.Humanoid.Animator, Slot.ViewportFrame.WorldModel.Preview.Animation)
	end
end

local function SetupScroll(Scroll: Frame, Slot: Frame)
	local cs = {}
	local txtBox: TextBox = Scroll.Parent.TextBox
	cs['boxc'] = txtBox:GetPropertyChangedSignal('Text'):Connect(function()
		for _, Button: TextButton in Scroll:GetChildren() do
			if Button:IsA('TextButton') then
				if not string.find(Button.Name:lower(), txtBox.Text:lower()) then
					Button.Visible = false
				else
					Button.Visible = true
				end
			end
		end
	end)
	cs['dest'] = script.Parent.Destroying:Connect(function()
		cs['boxc']:Disconnect()
		cs['dest']:Disconnect()
	end)
	
	
	for _, Button: TextButton in Scroll:GetChildren() do
		if Button:IsA('TextButton') then
			Button.Activated:Connect(function()
				ChangeSlotEmote(Slot, Button.Name, Scroll.Parent.Parent.Parent.Name)
				TriggerVisibleSlots(true)
				CloseScrolls()
			end)
		end
	end
end

local function SetupPlayBtn(Button: TextButton)
	local DoEmote = true
	local Emoted = false
	
	Button.MouseButton1Down:Connect(function()
		task.delay(.5, function()
			if Emoted or Button.Parent:FindFirstChild('ScrollingFrame') then Emoted = false return end
			
			DoEmote = false
			
			CloseScrolls()
			TriggerVisibleSlots(false, Button.Parent.Name)
			
			
			local Scroll = ScrollFrame:Clone()
			Scroll.Parent = Button.Parent
			SetupScroll(Scroll.ScrollingFrame, Button.Parent)
		end)
	end)
	
	Button.MouseButton1Up:Connect(function()
		if DoEmote then
			Emoted = true		
			
			CloseScrolls()
			EmoteWheel.Visible = false
			
			if Button.Parent.Parent.Name == 'Emotes2' then 
				if MarketService:UserOwnsGamePassAsync(Player.UserId, MoreEmoteSlotsPass) == false then
					return
				end	
			end
			
			Comunicator:FireServer('PlayEmote', Button.Parent.EmoteName.Text)
		else
			DoEmote = true
		end
	end)
end


-- RUNTIME --

local owdEms = Getter:InvokeServer('GetOwnedEmotes')
if owdEms then
	for _, EmoteName in owdEms do
		local EmoteAnim = EmotesFolder:FindFirstChild(EmoteName)
		if not EmoteAnim then continue end

		EmoteIds[EmoteAnim.Name] = EmoteAnim.AnimationId
	end
end

for EmoteName, _ in EmoteIds do
	local TemplateClone = script.Template:Clone()
	TemplateClone.Name = EmoteName
	TemplateClone.Text = EmoteName
	TemplateClone.Parent = ScrollFrame.ScrollingFrame
end

if #owdEms >= #EmotesFolder:GetChildren() then 
	EmoteWheel.Bulk.Visible = false
	EmoteWheel.Spin.Text = '<font color="rgb(255, 255, 255)">YOU OWN ALL EMOTES</font>\n<font size="16">THANKS FOR SUPPORTING US!</font>'
end

EmoteWheel:GetPropertyChangedSignal('Visible'):Connect(function()
	if EmoteWheel.Visible == true then
		CloseScrolls()
		TriggerVisibleSlots(true)
	end
	
	if shared.triggerEmoteIcon then
		shared.triggerEmoteIcon(EmoteWheel.Visible)
	end
end)


if MarketService:UserOwnsGamePassAsync(Player.UserId, MoreEmoteSlotsPass) == true then
	if MarketService:UserOwnsGamePassAsync(Player.UserId, SecondEmotePagePass) == true then
		EmoteWheel.Switch.Visible = true
	else
		EmoteWheel.GamepassTwo.Visible = true
	end
	
	for i,v in EmoteWheel.Emotes:GetChildren() do
		v.Visible = true
	end
else
	EmoteWheel.Gamepass.Visible = true
end


local Emotes, Emotes2 = EmotesGet:InvokeServer()
for _, Slot in PagesSlots[1] do
	SetupPlayBtn(Slot.Button)
	
	ChangeSlotEmote(Slot, Emotes[Slot.Name], 'Emotes')
end
for _, Slot in PagesSlots[2] do
	SetupPlayBtn(Slot.Button)

	ChangeSlotEmote(Slot, Emotes2[Slot.Name], 'Emotes2')
end


EmoteWheel.Switch.Activated:Connect(function()
	if MarketService:UserOwnsGamePassAsync(Player.UserId, SecondEmotePagePass) == false then return end
	
	if CurrentPage == 1 then
		CurrentPage = 2
		
		for _,v in PagesSlots[1] do
			v.Visible = false
		end
		
		for _,v in PagesSlots[2] do
			v.Visible = true
		end
	else
		CurrentPage = 1
		
		for _,v in PagesSlots[1] do
			v.Visible = true
		end

		for _,v in PagesSlots[2] do
			v.Visible = false
		end
	end	
end)


EmoteWheel.Gamepass.Activated:Connect(function()
	MarketService:PromptGamePassPurchase(Player, shared.Passes["More Emote Slots"])
end)

EmoteWheel.GamepassTwo.Activated:Connect(function()
	MarketService:PromptGamePassPurchase(Player, shared.Passes["Second Emote Page"])
end)

EmoteWheel.Spin.Activated:Connect(function()
	if Getter:InvokeServer('SpinEmote') == true then
		EmoteWheel.Spin.Text = 'NEW EMOTE: <font color="rgb(255, 85, 85)">50 KILLS</font>\n<font size="16">HOLD EMOTE DOWN TO CHANGE</font>'
	end
end)

EmoteWheel.Bulk.Emotesx1.Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.Products['Random Emote'])
end)

EmoteWheel.Bulk.Emotesx5.Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.Products['Random Emote x5'])
end)

EmoteWheel.Bulk.Emotesx10.Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.Products['Random Emote x10'])
end)

EmotesSet.OnClientEvent:Connect(function(Action: string, Params: { any })
	if Action == 'UpdateOwnedEmotes' then
		for _, EmoteName in Params.OwnedEmotes do
			if EmoteIds[EmoteName] then continue end
			
			local EmoteAnim = EmotesFolder:FindFirstChild(EmoteName)
			print(EmoteAnim)
			if not EmoteAnim then continue end
			EmoteIds[EmoteAnim.Name] = EmoteAnim.AnimationId
		end

		for EmoteName, _ in EmoteIds do
			if ScrollFrame.ScrollingFrame:FindFirstChild(EmoteName) then continue end
			
			local TemplateClone = script.Template:Clone()
			TemplateClone.Name = EmoteName
			TemplateClone.Text = EmoteName
			TemplateClone.Parent = ScrollFrame.ScrollingFrame
		end
		
		if #Params.OwnedEmotes >= #EmotesFolder:GetChildren() then 
			EmoteWheel.Bulk.Visible = false
			EmoteWheel.Spin.Text = '<font color="rgb(255, 255, 255)">YOU OWN ALL EMOTES</font>\n<font size="16">THANKS FOR SUPPORTING US!</font>'
		end
	end
end)