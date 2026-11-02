local msgs = {
	"YOU DIED",
}

script.Parent.AncestryChanged:connect(function()
script.Parent.Text = msgs[math.random(1,#msgs)]
end)