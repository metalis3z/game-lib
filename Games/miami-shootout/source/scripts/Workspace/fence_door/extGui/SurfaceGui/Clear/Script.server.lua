--!

button = script.Parent
Input = script.Parent.Parent.SCREEN
function Clear()
print("Cleared")
Input.Text = "Cleared"
script.Parent.Parent.Sound4:play()
wait(0.5)
Input.Text = ""
end

button.MouseButton1Click:connect(Clear)