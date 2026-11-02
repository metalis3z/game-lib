--[[

First table consists of the different variations of the command.

Second table consists of the command description and an example of how to use it.

Third index is the POWER a player needs to be to use the command.
0 - Game Creator
1 - Owner
2 - Administrator
3 - Moderator
4 - VIP
5 - Normal player

Fourth table consists of the argument types that will be returned in the args table.
'player'	- Grabs a player from the command
'number'	- Grabs a number from the command
'boolean'	- Grabs if the player says the word 'true' or 'false' from the command
'string'	- Grabs the full string from the rest of the command
'string\a'	- Grabs the next word from the command
'time'		- Grabs the time value ex: 100s/m/h/d from the command
'color'		- Grabs a color from the command

Fifth index consists of the function that will run, executing the command.

 _-EXAMPLE COMMAND-_
|___________________|

{
{'tp','teleport','tele'},{'Teleports a player to a player.','tp kohl me'},3,{'player','player'},
function(pl,args)
for i,plr in pairs(args[1]) do if not (plr and plr.Character and plr.Character:findFirstChild('Torso')) or not (args[2][1] and args[2][1].Character) then return end
plr.Character.Torso.CFrame = CFrame.new(args[2][1].Character.Torso.Position+Vector3.new(math.random(-50,50),0,math.random(-50,50))/10)
end
end
};

]]
local Commands = {



}

return Commands