



local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Conch__2 = require(l__ReplicatedStorage__1.Packages.Conch);
local l__LiveSoccerTeams__3 = require(l__ReplicatedStorage__1.Shared.ConchTypes.LiveSoccerTeams);
return l__Conch__2.register_type("Live Soccer Team", l__Conch__2.args.enum_new(l__LiveSoccerTeams__3));