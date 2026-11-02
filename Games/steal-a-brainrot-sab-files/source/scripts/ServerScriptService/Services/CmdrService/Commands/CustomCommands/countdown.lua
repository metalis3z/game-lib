return {
	Name = "countdown";
	Aliases = {"timer"};
	Description = "Makes a server-countdown announcement.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "string";
			Name = "text";
			Description = "The timer text.";
		},
		{
			Type = "number";
			Name = "duration";
			Description = "The duration in seconds, or a Unix timestamp if IsUnixTimestamp is true.";
		},
		{
			Type = "string";
			Name = "color";
			Description = "The color.";
		},
		{
			Type = "boolean";
			Name = "IsGlobal";
			Description = "If the poll is global.";
			Optional = true;
		},
		{
			Type = "boolean";
			Name = "IsUnixTimestamp";
			Description = "If true, duration is treated as a Unix timestamp instead of seconds. Defaults to false.";
			Optional = true;
		}
	};
}