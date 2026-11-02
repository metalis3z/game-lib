local id = 204142290
local nam = "Cash Upgrade"
local cost = 45
local desc = "Get a +4,000 cash boost every game. Stacks with other passes."
local p = script.Parent.Parent


function click()
	p.Cost1.Text = "Cost: "..cost
	p.Item.Text = "Item: "..nam
	p.Description1.Text = "Description: "..desc
	p.ID.Value = id
end

script.Parent.MouseButton1Down:connect(click)