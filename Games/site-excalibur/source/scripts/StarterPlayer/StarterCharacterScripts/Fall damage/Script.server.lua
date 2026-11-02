minimumvelocity = 25 -- You can change this, it makes a variable considering the minimum velocity to damage. [it's recommended to be around 20 or it hurts you if you jump]
script.Parent.Touched:connect(function() -- When the parent of the part collides (1)
if script.Parent.Velocity.Y < minimumvelocity and string.sub(script.Parent.Velocity.Y,1,1) == "-" then -- If the parent of the part's down velocity is higher than the variable we talked about before's amount (2)
script.Parent.Parent.Humanoid.Health = script.Parent.Parent.Humanoid.Health - string.sub(script.Parent.Velocity.Y,2,string.len(script.Parent.Velocity.Y)) --around up-down velocity of the parent of the part without the minus if it's down is removed from the humanoid's health
end -- Ends the function (2)
end) -- Ends the function (1) [The dash is needed because we ran a function directly to the event, not just made it and linked the event to it.]
--AAAAAnd done.