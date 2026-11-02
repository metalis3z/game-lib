local Tool = script.Parent


function unequip()
	wait()
	Tool.Handle:Destroy()
	Tool:Destroy()
end

Tool.Unequipped:connect(unequip)

