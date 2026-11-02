return {
	Name = "removebrainrot";
	Aliases = {"clearbrainrot", "deletebrainrot"};
	Description = "Removes a brainrot from the specified player's podium without giving money.";
	Group = "CustomAdmin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player whose brainrot will be removed.";
		},
		{
			Type = "integer";
			Name = "podiumIndex";
			Description = "The index of the podium to remove from.";
		}
	};
}
