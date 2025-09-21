name = "Warbucks"
author = "K"
version = "1.0.2"
description = "version: "..version
api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
all_clients_require_mod = true

priority = 0

configuration_options = 
{
	{
		name = "lan",
		label = "Language/语言设置",
		options =	
		{
			{description = "English", data = "en"},
			{description = "中文", data = "cn"},
		},
		default = "en",
	},
}