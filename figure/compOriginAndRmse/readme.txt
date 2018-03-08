uv and recalculated uv.jpg
说明由风速风向推导u，v的结果不如直接插值u，v好
--------------------------------------------------
lat and lon region.jpg
纵向取区域和横向取区域，rmse差距比较大
--------------------------------------------------

比较单核与多核的rmse

single and mpng all.jpg:说明单核可以比多核方法好百分之多少，但是并不是在纵向区域与横向区域都好，而且在u，v上的表现不一致

single and mpng only.jpg： 单核与多核法的rmse值比较


difference.jpg  ： u-u0，v-v0图

---------------------------------------------------

比较用pca得到的特征修正和不修正的rmse

pca and non-pca all.jpg： 百分比图
pca and non-pca.jpg : rmse 对比图
pca and nonpca diff.jpg： 差值图

---------------------------------------------------
比较最终采用的方法和spline
new method and spline all.jpg：百分比图
new method and spline.jpg ： 两者的rmse
new method and spline difference.jpg  ： 两者的u-u0，v-v0图
