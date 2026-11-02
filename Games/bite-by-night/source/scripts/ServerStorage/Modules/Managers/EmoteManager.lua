--[[
    Written by: Nextix (ne_tix)
    Date: 4/01/2026
    
    Information:
    They actually handle the Clicking on the server by the way, that's 1:1 to the game.
    I do not know how dumb BBN developers are / unadvanced they are but that's dumb.
]]

local EmoteManager = {
	Players = {}
}
EmoteManager.__index = EmoteManager

-- <- Types -> --
export type self = {
	Player: Player,
	PlayerGui: PlayerGui,
	EmoteWheel: CanvasGroup,
	Wheel1: CanvasGroup,
	Wheel2: CanvasGroup,
	Connections: {RBXScriptConnection},
	SetupConnections: (self) -> (),
	RemoveConnections: (self) -> ()
}

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local PlayerData = require('@game/ServerStorage/Modules/General/PlayerData');
local ServerUtil = require('@game/ServerStorage/Modules/ServerUtil');

-- <- Public Variables -> --
local Emotes = ReplicatedStorage.Modules.Emotes

-- <- Private Functions -> --
local function HandleEmotePlaying(Player: Player, ButtonName: string): ()
	local Data = PlayerData.GetPlayerData(Player);
	if not Data then
		return
	end
	
	local ButtonIndex = string.gsub(ButtonName, 'Button', '');
	if not ButtonIndex then
		return
	else 
        ButtonIndex = tonumber(ButtonIndex);		
	end
	
	local PlayerCharacter = Player.Character
	if not PlayerCharacter then
		return
	end
	
	local CharacterAttributes = PlayerCharacter:GetAttributes();
	if not CharacterAttributes then
		return
	end
	
	if not CharacterAttributes.Character then
		return
	end
	
	local CharacterSelected = string.find(CharacterAttributes.Character, 'Survivor') and 'Survivor' or CharacterAttributes.Character
	if not CharacterSelected then
		return
	end
	
	local CharacterEmotes = Data.Data.Emotes[CharacterSelected]
	if not CharacterEmotes then
		return
	end
	
	local EmoteToPlay = Data.Data.Emotes[CharacterSelected][ButtonIndex]
	if not EmoteToPlay then
		return
	end
	
	local EmoteModule = Emotes:FindFirstChild(EmoteToPlay);
	if not EmoteModule then
		return
	end
	
	local RequiredModule = ServerUtil.SafeRequire(EmoteModule);
	if not (RequiredModule or RequiredModule.new) then
		return
	end
	
	local NewEmotePlay = RequiredModule.new({PlayerCharacter});
	NewEmotePlay:CheckFunc();
	NewEmotePlay:EmoteFunc();
end

-- <- Public Functions -> --
function EmoteManager:SetupConnections(): ()
	if not self.Player then
		return
	end
	
	warn('Hi !')
	
	for _, Button in self.Wheel1['4Emotes']:GetChildren() do 
		if not Button:IsA('TextButton') then
			continue
		end
				
		self.Connections[#self.Connections + 1] = Button.MouseButton1Click:Connect(function(...): ()
			HandleEmotePlaying(self.Player, Button.Name);
		end)
	end
	
	for _, Button in self.Wheel2['4Emotes']:GetChildren() do 
		if not Button:IsA('TextButton') then
			continue
		end

		self.Connections[#self.Connections + 1] = Button.MouseButton1Click:Connect(function(...): ()
			HandleEmotePlaying(self.Player, Button.Name);
		end)
	end
end

function EmoteManager:RemoveConnections(): ()
	if not self.Player then
		return
	end

	for _, Connection in self.Connections do 
		if not Connection or typeof(Connection) ~= 'RBXScriptConnection' then
			continue
		end
		
		Connection:Disconnect();
	end
end

function EmoteManager.new(Player: Player): self?
	if EmoteManager.Players[Player] then
		return EmoteManager.Players[Player]
	end
	
	local PlayerGui = Player.PlayerGui
	if not PlayerGui then
		return
	end
	
	local self = setmetatable({}, EmoteManager);
	self.Player = Player
	self.PlayerGui = PlayerGui
	self.EmoteWheel = PlayerGui.UI.EmoteWheel
	self.Wheel1 = self.EmoteWheel.Wheel1
	self.Wheel2 = self.EmoteWheel.Wheel2
	self.Connections = {}	
	
	EmoteManager.Players[Player] = self
	
	warn(self)
		
	return self
end

-- <- Return -> --
return EmoteManager