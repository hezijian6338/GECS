package com.thinkgem.jeesite.modules.sign.utils;

import cn.com.jit.assp.css.client.util.Base64;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;

/**
 * Created by bb on 2018-01-05.
 */
public class DealWithPicUtil {

    /**
     * 对图片中的 黑色或白色进行透明化处理
     * @param stream 从pdf文件提取出来的章图的文件流
     * @param color 0:白色 1:黑色
     * @return 结果图 字节数据组 转 Base64
     */
    public static String transferAlpha(InputStream stream, int color) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            /*File iFile = new File(sourcePath);
            if(!iFile.exists()) return byteArrayOutputStream.toByteArray();*/

            ImageIcon imageIcon = new ImageIcon(ImageIO.read(stream));
            BufferedImage bufferedImage = new BufferedImage(
                    imageIcon.getIconWidth(), imageIcon.getIconHeight(),
                    BufferedImage.TYPE_4BYTE_ABGR);
            Graphics2D g2D = (Graphics2D) bufferedImage.getGraphics();
            g2D.drawImage(imageIcon.getImage(), 0, 0,imageIcon.getImageObserver());
            int alpha = 0;
            for (int j1 = bufferedImage.getMinY(); j1 < bufferedImage.getHeight(); j1++) {
                for (int j2 = bufferedImage.getMinX(); j2 < bufferedImage.getWidth(); j2++) {
                    int rgb = bufferedImage.getRGB(j2, j1);

                    if (checkColor(rgb,16,color)) {
                        rgb = ((alpha + 1) << 24) | (rgb & 0x00ffffff);
                    }
                    bufferedImage.setRGB(j2, j1, rgb);
                }
            }

            g2D.drawImage(bufferedImage, 0, 0, imageIcon.getImageObserver());

            /*File targetFile = null;
            if(targetPath == null){
                targetFile = new File(sourcePath+"_"+color+".png");
            }else{
                targetFile = new File(targetPath);
                if(!targetFile.exists()){
                    File dir = new File(targetFile.getParent());
                    if(!dir.exists()) dir.mkdirs();
                }
            }*/

            /*File newFile = new File("c:/new.png");
            ImageIO.write(bufferedImage, "png", newFile);*/

            //返回处理后图像的byte[]
            ImageIO.write(bufferedImage, "png", byteArrayOutputStream);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return Base64.encodeBytes(byteArrayOutputStream.toByteArray());

    }

    /**
     * 检查颜色是否为 白色 或者 黑色阈值范围
     * @param rgb 颜色值
     * @param color 0:白色 1:黑色
     * @return 检查结果
     */
    private static boolean checkColor(int rgb,int offset,int color){
        int R = (rgb & 0xff0000) >> 16;
        int G = (rgb & 0xff00) >> 8;
        int B = (rgb & 0xff);

        if(color == 0){
            return ((255 - R) <= offset) && ((255 - G) <= offset) && ((255 - B) <= offset);
        }else{
            return ((R <= offset) && (G <= offset) && (B <= offset));
        }
    }

    /**
     * 先将图片灰度化再改变颜色值
     * @param stream 从pdf文件提取出来的章图的文件流
     * @throws Exception
     * @return 结果图 字节数据组 转 Base64
     */
    public static String changeGrayColorImage(InputStream stream) {
        //BufferedImage bufferedImage = ImageIO.read(new File("c:/3.png"));
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
        BufferedImage bufferedImage = ImageIO.read(stream);
        BufferedImage grayImage = new BufferedImage(bufferedImage.getWidth(),
                        bufferedImage.getHeight(),
                BufferedImage.TYPE_4BYTE_ABGR);

        for (int i = 0; i < bufferedImage.getWidth(); i++) {
            for (int j = 0; j < bufferedImage.getHeight(); j++) {
                final int color = bufferedImage.getRGB(i, j);
                final int r = (color >> 16) & 0xff;
                final int g = (color >> 8) & 0xff;
                final int b = color & 0xff;
                int gray = (int) (0.3 * r + 0.59 * g + 0.11 * b);
                //System.out.println(i + " : " + j + " " + gray);
                int newPixel = 0;
                if(gray < 30){
                     //newPixel = colorToRGB(255  , 255, 255, 255);
                    newPixel = (0 << 24) | (255 << 16) | (255 << 8) | 255;
                }else{//签名黑色
                    newPixel = (255 << 24) | (255 << 16) | (0 << 8) | 0;
                }
                grayImage.setRGB(i, j, newPixel);
            }
        }
        /*File newFile = new File("c:/new.png");
        ImageIO.write(grayImage, "png", newFile);*/
        //返回处理后图像的byte[]
        ImageIO.write(grayImage, "png", byteArrayOutputStream);

        }catch (Exception e) {
            e.printStackTrace();
        }

        return Base64.encodeBytes(byteArrayOutputStream.toByteArray());
    }


    public static void changeGrayColorImage2(File file) {

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            BufferedImage bufferedImage = ImageIO.read(file);
            BufferedImage grayImage = new BufferedImage(bufferedImage.getWidth(),
                    bufferedImage.getHeight(),
                    BufferedImage.TYPE_4BYTE_ABGR);

            for (int i = 0; i < bufferedImage.getWidth(); i++) {
                for (int j = 0; j < bufferedImage.getHeight(); j++) {
                    final int color = bufferedImage.getRGB(i, j);
                    final int r = (color >> 16) & 0xff;
                    final int g = (color >> 8) & 0xff;
                    final int b = color & 0xff;
                    int gray = (int) (0.3 * r + 0.59 * g + 0.11 * b);
                    //System.out.println(i + " : " + j + " " + gray);
                    int newPixel = 0;
                    if (gray < 30){
                        newPixel = (255 << 24) | (255 << 16) | (0 << 8) | 0;
                    }
                    grayImage.setRGB(i, j, newPixel);
                }
            }
        File newFile = new File("c:/caiji2.png");
        ImageIO.write(grayImage, "png", newFile);

        }catch (Exception e) {
            e.printStackTrace();
        }

    }

     public static void main(String[] args) throws Exception {
        /* String tmpPath = "c:/4412020063358.BMP";
         File file = new File(tmpPath);
         String tmpPath2 = "c:/caiji2.png";
         File file2 = new File(tmpPath2);
         long date1 = System.currentTimeMillis();

         changeGrayColorImage2(file);
         // 压缩处理
         Thumbnails.of(tmpPath2).scale(0.11083449).outputQuality(1f).toFile(tmpPath2);
         long date2 = System.currentTimeMillis();
         System.out.println("处理所耗时："+ String.valueOf(date2-date1));*/
    }

}


