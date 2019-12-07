library("imager")

path = "GitHub/webpage/docs/article/a17/"
fList = list.files(path)
file = strsplit(fList, ".", fixed=TRUE)

m = 1
while(m <= length(fList)){
file.full = file[[m]]
file.name = file.full[1]
file.ext = file.full[2]

img = load.image( paste(path, file.name, ".", file.ext, sep="") )
img_r = imresize(img, .2)
output.name = paste(path, "r", file.name, ".jpg", sep="")
imager::save.image(img_r, output.name)
m = m + 1
}

# "src='./a*/" -> "src='./a*/r"