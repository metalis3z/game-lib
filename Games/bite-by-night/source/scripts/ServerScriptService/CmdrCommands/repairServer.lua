-- <- Modules -> --
local DoorManager = require('@game/ServerStorage/Modules/Managers/DoorManager');

-- <- Return -> --
return function(Context): string
	local Repaired = DoorManager.RepairAll();

	return `Repaired {Repaired} doors.`
end