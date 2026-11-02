local Tool = script.Parent

WeldName = "RightMotor6DGrip"---Change the name here if you'd like to

function Tool_Equipped(M)
    --print("Equipped")
    plr_char = script.Parent.Parent
    Right_Arm = plr_char:FindFirstChild("RightHand")
    Right_GripW = Right_Arm:WaitForChild("RightGrip",2)
    Right_Weld = Instance.new("Motor6D")
    Right_Weld.Part0 = Right_GripW.Part0
    Right_Weld.Part1 = Right_GripW.Part1
    Right_Weld.C0 = Right_GripW.C0
    Right_Weld.C1 = Right_GripW.C1
    Right_Weld.Parent = Right_Arm
    Right_Weld.Name = WeldName
    Right_GripW:Destroy()
end

function Tool_Unequip()
    Right_Weld:Destroy()
    print("Unequipped")
end



Tool.Equipped:connect(Tool_Equipped)

Tool.Unequipped:connect(Tool_Unequip)