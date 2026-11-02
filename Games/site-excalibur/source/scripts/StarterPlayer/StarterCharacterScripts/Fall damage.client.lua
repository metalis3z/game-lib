player = game.Players.LocalPlayer -- Makes a shorter way to the player
character = script.Parent -- Makes a shorter way to the player model
humanoid = character.Humanoid -- Makes a shorter way to the player model's humanoid
cgc = character:GetChildren() -- Gets the children of the player model
for i=1, #cgc do -- For 1[i], number of children in the character do (1)
script.Script:Clone().Parent = cgc[i] -- Clones the script in the script to the [i]th thing in the player model
end -- Ends the function (1)
-- Ready to use! The rest will be in the script inside the script.