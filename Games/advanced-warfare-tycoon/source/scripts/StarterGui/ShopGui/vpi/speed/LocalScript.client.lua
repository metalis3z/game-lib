local id = 204143218
local nam = "Ultra VIP"
local cost = 1300
local desc = "Get a +10,000 cash boost every game and entry to the Ultra VIP roomo with OP perks."
local p = script.Parent.Parent


function click()
	p.Cost1.Text = "Cost: "..cost
	p.Item.Text = "Item: "..nam
	p.Description1.Text = "Description: "..desc
	p.ID.Value = id
end

script.Parent.MouseButton1Down:connect(click)