G.FUNCS.sort_hand_none = function(e)
	G.hand.config.sort = "none"
	play_sound("paper1")
end

local orig_sort = CardArea.sort
function CardArea:sort(method)
	if (method or self.config.sort) == "none" then
		return
	end
	return orig_sort(self, method)
end

local orig_create_UIBox_buttons = create_UIBox_buttons
function create_UIBox_buttons()
	local t = orig_create_UIBox_buttons()

	local sort_panel = t.nodes and t.nodes[2]
	if sort_panel and sort_panel.nodes then
		local outer_col = sort_panel.nodes[1]
		if outer_col and outer_col.nodes then
			for _, row in ipairs(outer_col.nodes) do
				if row.nodes then
					for _, node in ipairs(row.nodes) do
						if node.config and node.config.button == "sort_hand_value" then
							local text_scale = 0.45
							local none_button = {
								n = G.UIT.C,
								config = {
									align = "cm",
									minh = 0.7,
									minw = 0.9,
									padding = 0.1,
									r = 0.1,
									hover = true,
									colour = G.C.ORANGE,
									button = "sort_hand_none",
									shadow = true,
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("k_none"),
											scale = text_scale * 0.7,
											colour = G.C.UI.TEXT_LIGHT,
										},
									},
								},
							}
							table.insert(row.nodes, 2, none_button)
							return t
						end
					end
				end
			end
		end
	end

	return t
end
