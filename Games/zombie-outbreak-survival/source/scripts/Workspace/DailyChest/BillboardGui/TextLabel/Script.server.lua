--text color change script by dizzywig2000
wait()
while true do 
i = 0
for n=1,0,-0.05 do 
i = i + 0.05
script.Parent.TextColor3 = Color3.new(i, 0, n)
wait() 
end  
i = 0
for n=1,0,-0.05 do 
i = i + 0.05
script.Parent.TextColor3 = Color3.new(n, i, 0)
wait()
end   
i = 0
for n=1,0,-0.05 do 
i = i + 0.05
script.Parent.TextColor3 = Color3.new(0, n, i)
wait() 
end 
end 