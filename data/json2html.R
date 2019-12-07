### convert single json to a html file

#install.packages("RJSONIO")
#library("RJSONIO")
#library("rjson")

file <- "a2" # file name you want
jsonf <- paste(file, "json", sep=".")
htmlf <- paste(file, "html", sep=".")

path.i <- paste("GitHub/webpage/data/data", jsonf, sep="/")

data <- fromJSON(paste(readLines(path.i, encoding="UTF-8"), collapse=""))

################################################


# get contents in json file
title <- data[["title"]]
keyword_n <- data[["keyword"]] 
tag_n <- data[["tag"]]
article <- data[["article"]]
history_n <- data[["history"]]
ctg <- data[["category"]]
library_n <- data[["library"]]

# convert multi words to single word e.g. "a", "b" -> "a, b" 
i <- 1
D <- NULL
while(i <= length(keyword_n)){
	D <- paste(D, "<a class='keyword'>", "　", keyword_n[i], "　", "</a><a>　</a>", sep="")
	i <- i + 1
}
keyword <- D

i <- 1
D <- NULL
while(i <= length(tag_n)){
	D <- paste(D, tag_n[i], sep=" ")
	i <- i + 1
}
tag <- D

i <- 1
D <- NULL
while(i <= length(history_n)){
	D <- paste(D, "<p>", history_n[i], "</p>", sep=" ")
	i <- i + 1
}
history <- D

i <- 1
D <- NULL
while(i <= length(library_n)){
	D <- paste(D, library_n[i], sep=" ")
	i <- i + 1
}
library <- D

# category list
ctg_name <- "その他"
if(ctg == "ctg1"){
ctg_name <- "土木・運輸"
}else if(ctg == "ctg2") {
ctg_name <- "郵便・統計・Web"
}else if(ctg == "ctg3"){
ctg_name <- "生き物・ごはん"
}

# URL for category page
url_ctg <- paste("../", ctg, ".html", sep="")

# make breadcrumbs HTML (pankuzu)
pan1 <- "
<div class='breadcrumbs'>
<ul>
<li><a href='../'>トップ</a></li>
<li><a href='" # before category number ctg* (url_ctg)
pan2 <- "'>" # before category name
pan3 <- "</a></li><li>" # before category article title
pan4 <- "</li></ul></div>"

pankuzu <- paste(pan1, url_ctg, pan2, ctg_name, pan3, title, pan4, sep="")

# make HTML contents
html_head <- "<!doctype html>
<html><head>"

html_head2 <- "<link rel='shortcut icon' href='../favicon.ico'>
<meta charset='UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />
<title>"
# before title
html_title <- "</title>
<link rel='stylesheet' type='text/css' href='../css/common.css'>
</head><body>"
# before pankuzu
html_pan <- "<div class='title'><h2 class='article'>"
# before title
html_key <- "</h2></div> <div class='keyarea'>"  # before keyword
html_art <- "</div> 
<div class='go2attention'><a href='#attention'>注意事項はこちら</a></div>
<div class='article'>" # before article
html_his <- "</div> <div class='page_top'><a href='#top'>▲Page TOP</a></div>
<div id ='attention' class='attention'><p>
注意事項<br>本Webサイトで提供する情報の利用は自己責任でお願いいたします。また、画像や文章の著作権は放棄しておりません（HTMLやRのコードはご自由に利用ください）。
このHPで述べる内容は、私の所属するいかなる組織の見解をも代表するものではありません。<br>このページでは、Google Analyticsを用いたアクセス解析（Cookieの利用等）を行っております。
</p></div><div class='history'><p>" # before history
html_tale <- "</p></div></body></html>" # end

html <- paste(html_head, code, html_head2, title, html_title, pankuzu, html_pan, title, html_key, keyword, html_art, article, html_his, history, html_tale, sep="")


################################################
path.o <- paste("GitHub/webpage/docs/article/", htmlf, sep="")
write.table(html, path.o, fileEncoding="UTF-8", col.name=FALSE, row.names=FALSE, quote=FALSE, sep="\n")


