# ExportHexstringToImage
Generate a Image filled with given colors, and a hexstring on each section of colors.

<img src="https://github.com/luiyezheng/ExportHexstringToImage/blob/master/hexstring.png" class="smaller-image">

##Usage

Swift
```
let colors = ["#B9E937", "#93E4C1", "#3BAEA0", "#118A7E", "#1F6F78"]
let font = UIFont(name: "Helvetica Bold", size: 12)
        
let colorImage = getImageWithColor(CGSize(width: 200, height: 300), colors: colors, textFont: font!, textColor: UIColor.whiteColor())
```

<style>
  .smaller-image {
    width: 100px;
  }
</style>
