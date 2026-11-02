

local l_Parent_0 = script.Parent;
l_Parent_0.Equipped:Connect(function()
    workspace.Gravity = 29.429999999999996;
end);
l_Parent_0.Unequipped:Connect(function()
    workspace.Gravity = 196.2;
end);