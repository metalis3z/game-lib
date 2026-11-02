local Parent = script.Parent;
Parent.Equipped:Connect(function()
    workspace.Gravity = 29.429999999999996;
end);

Parent.Unequipped:Connect(function()
    workspace.Gravity = 196.2;
end)