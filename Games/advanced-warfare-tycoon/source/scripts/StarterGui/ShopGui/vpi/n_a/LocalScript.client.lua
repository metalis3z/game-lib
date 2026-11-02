local id = 0
local nam = "Admin"
local cost = 7777
local desc = "Become an admin, message me when you buy for instructions."
local p = script.Parent.Parent


function click()
	p.Cost1.Text = "Cost: "..cost
	p.Item.Text = "Item: "..nam
	p.Description1.Text = "Description: "..desc
	p.ID.Value = id
end

script.Parent.MouseButton1Down:connect(click)