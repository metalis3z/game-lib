script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent:Destroy()
end)

wait()
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

local Frame1

function Update()
	for i, v in pairs(script.Parent.Parent.Frame:GetChildren()) do
		if v.ClassName == "ScrollingFrame" then
			Frame1 = v
			Frame1:ClearAllChildren()

			local GridLayOut = script.UIGridLayout:Clone()
			GridLayOut.Parent = Frame1

			local Items = 0

			for i,v in pairs(script.Parent.Parent.Parent.Folder.Value:GetChildren()) do
				Items = Items + 1

				local Reference = Instance.new("ObjectValue")
				Reference.Value = v
				Reference.Name = "Reference"

				local Template = script.Template:Clone()
				Template.Parent = Frame1
				Reference.Parent = Template
				Template.Text = v.Name
				Template.Script2.Disabled = false
			end
		end
	end
end

Update()

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

script.Parent.Parent.Parent.Folder.Value.ChildRemoved:Connect(function()
	Update()
end)

script.Parent.Parent.Parent.Folder.Value.Parent.Update.Changed:Connect(function(Bool)
	if Bool == true then
		Update()
	end
end)