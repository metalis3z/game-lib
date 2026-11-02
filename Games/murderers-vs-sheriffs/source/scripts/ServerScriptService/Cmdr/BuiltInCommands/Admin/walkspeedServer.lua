return function (context, player:Player, Speed:number)
	player.Character.Humanoid.WalkSpeed = Speed
	return "Set ".. player.DisplayName.. "(@".. player.Name.. ")'s speed to ".. Speed
end