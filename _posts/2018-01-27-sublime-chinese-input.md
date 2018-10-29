---
layout: post
title:  "Ubuntu系统下 sublime text 的中文输入"
date:   2018-01-27 09：01：10 +0800
categories: CS Tools Linux
---



能输入中文：先安装并配置好 `fcitx` 环境，然后使用 [github sublime-text-imfix](https://github.com/lyfeyaj/sublime-text-imfix)

中英文对齐：在 `preference` -> `setting` 的 `user` 里输入以下设置

```json
{
	"bold_folder_labels": true,
	"color_scheme": "Packages/User/SublimeLinter/Monokai Extended (SL).tmTheme",
	"font_face": "FZLTH",
	"font_size": 19,
	"highlight_line": true,
	"highlight_modified_tabs": true,
	"ignored_packages":
	[
		"Vintage"
	],
	"line_padding_bottom": 1,
	"line_padding_top": 1,
	"mdpopups.sublime_user_lang_map": null,
	"mdpopups.use_sublime_highlighter": null,
	"theme": "Default.sublime-theme",
	"update_check": false,
	"word_wrap": true
}
```

中文输入光标不跟随：

这个问题只有在使用 sublime text 使用 `academicmarkdown` 环境下编辑 markdown 文件时出现，其他环境如 latex 和无指定环境下都没有这个问题。因此，在编写 markdown 文件时，在 sublime text 的最右下角指定环境为 latex 或者 `markdown` 即可解决此问题。
