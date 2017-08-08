# LWidget
##UIImageView+LJImageView.h
>由于发现使用sdwebimage时，因为图片太多太大，会引起内存升高，继而使用afn中的图片加载extension,又发现了新问题：在tableview或collectionview中图片会闪烁(由于cell重用，之前的cell上的图片还没加载完，这个cell就被用作新的图片加载了)

>我坚信：使用SDWebimage一定会有很好的方法来解决内存问题，AFN也有很好的方法解决闪烁问题，可是我只是想简单的加载个图片，so这个类产生了。

如果大家也遇到跟我一样的问题，欢迎一起讨论，谢谢

##使用方法：

    target 'you project' do
    pod 'LWidget'
    end
然后再需要使用的类中加入：

    #import <UIImageView+LJImageView.h>
加载图片时

    [imgView ljSetImageWithUrlStr:urlstr];

