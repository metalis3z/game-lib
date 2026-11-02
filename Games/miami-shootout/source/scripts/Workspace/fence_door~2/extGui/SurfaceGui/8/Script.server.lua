button = script.Parent
Input = script.Parent.Parent.SCREEN
val = script.Parent.Name

function Click()
Input.Text = Input.Text.."8"
script.Parent.Parent.Sound:play()
print(val) 
end

button.MouseButton1Click:connect(Click)
