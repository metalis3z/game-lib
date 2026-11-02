-- <- Private Variables -> --
local Gui = script.Parent
local Main = Gui:FindFirstChild('Main');
local Event = Main and Main:FindFirstChild('Event')

-- <- Private Functions -> --
local function IsOwner(Player: Player)
	local OwnerUserId = Gui:GetAttribute('OwnerUserId')
	return typeof(OwnerUserId) == 'number' and Player.UserId == OwnerUserId
end

local function UpdateHP(Player: Player, HP: number)
	if not IsOwner(Player) or typeof(HP) ~= 'number' then
		return
	end

	Gui:SetAttribute('HP', math.clamp(HP, 0, 100));
end

-- <- Initialize -> --
if Event and Event:IsA('RemoteEvent') then
	Event.OnServerEvent:Connect(UpdateHP);
end