-- // So this shit handles the shop ???? Bro bite by night are y'all dumb ?

-- <- Modules -> --
local ShopManager = require('@game/ServerStorage/Modules/Managers/ShopManager');
local EmoteManager = require('@game/ServerStorage/Modules/Managers/EmoteManager');

-- <- Internal -> --
script.Parent.RemoteEvent.OnServerEvent:Connect(function(Player: Player, Action: string, ...): ()
	local FunctionFound = ShopManager[Action]
	if FunctionFound and typeof(FunctionFound) == 'function' then
		FunctionFound(Player, ...);
	elseif Action == 'EmoteWheel' then
		local PlayerMeta = EmoteManager.Players[Player] or EmoteManager.new(Player);
		if not PlayerMeta then
			return
		end

		local PackedArguments = {...}
		local GroupVisible = PackedArguments[1]
		if typeof(GroupVisible) ~= 'boolean' then
			warn(typeof(GroupVisible));

			return
		end

		if PlayerMeta.EmoteWheel.Visible == GroupVisible then
			return
		end

		PlayerMeta.EmoteWheel.Visible = GroupVisible

		if GroupVisible then
			PlayerMeta:SetupConnections();
		else 
			PlayerMeta:RemoveConnections();
		end
	else
		warn(`Yo fuck you {Player}`);
		warn(Action, ...);
	end
end)