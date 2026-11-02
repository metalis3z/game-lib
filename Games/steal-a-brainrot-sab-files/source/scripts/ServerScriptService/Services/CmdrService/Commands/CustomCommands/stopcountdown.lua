
return {
	Name        = "stopalltimers";
	Aliases     = { "stoptimer", "killtimer", "cleartimer" };
	Description = "Forcefully stops all active countdown timers, including global and whitelisted ones.";
	Group       = "CustomAdmin";
	Args        = {
		{
			Type        = "boolean";
			Name        = "confirm";
			Description = 'Pass "true" to confirm you want to stop all timers.';
			Optional    = true;
		};
	};
}