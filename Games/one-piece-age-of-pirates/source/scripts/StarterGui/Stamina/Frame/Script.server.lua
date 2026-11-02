repeat wait() until script.Parent.Parent.Parent.Parent.Character ~= nil
wait(1)

while true do

script.Parent.Frame.Size = UDim2.new((script.Parent.Value.Value / 100), 0, 1, 0)
wait()

end