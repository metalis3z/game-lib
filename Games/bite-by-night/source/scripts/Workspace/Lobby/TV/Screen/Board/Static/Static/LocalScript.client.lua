
while true do
    script.Parent.Rotation = 0
    script.Parent.Size = UDim2.new(math.random(1, 10), 0, 1, 0)
    task.wait(0.01)
    script.Parent.Rotation = 180
    task.wait(0.01)
    script.Parent.Size = UDim2.new(math.random(1, 10), 0, 1, 0)
end
