while true do
wait()
if script.Parent.Parent.Material ~= Enum.Material.Neon then

script.Parent.Enabled = false

elseif script.Parent.Parent.Material == Enum.Material.Neon then

script.Parent.Enabled = true

end
end
