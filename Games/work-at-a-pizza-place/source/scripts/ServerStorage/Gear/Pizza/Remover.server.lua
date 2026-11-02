local Tool = script.Parent;





function onActivated()
	script.Parent:Destroy()

end



script.Parent.Activated:connect(onActivated)
