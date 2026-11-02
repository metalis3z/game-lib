script.Parent.Touched:connect(function(hit)
 if hit.Parent:FindFirstChild('NPC') then
script.Parent.Sound.Playing=true
end
end)