script.Parent.Parent.Parent.Cash.Changed:connect(function()
	script.Parent.Name="Cash to collect: $"..script.Parent.Parent.Parent.Cash.Value
end)