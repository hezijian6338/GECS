package com.thinkgem.jeesite.common.utils.filetopdf;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;


public class FileToPdf {
    public enum DOC_TYPE {
        DOC,
        DOCX,
        PPT,
        PPTX,
        ODT
    }

    public static void FileConvertPdf(String inpath, String outpath) {
        Converter converter;

        try {
            converter = processArguments(inpath, outpath);
        } catch (Exception e) {
            System.out.println("\n\nInput\\Output file not specified properly.");
            return;
        }


        if (converter == null) {
            System.out.println("Unable to determine type of input file.");
        } else {
            try {
                converter.convert();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }


    public static Converter processArguments(String inPath, String outPath) throws Exception {
        Converter converter = null;
        if (inPath == null) {
            throw new IllegalArgumentException();
        }

        if (outPath == null) {
            outPath = changeExtensionToPDF(inPath);
        }

        String lowerCaseInPath = inPath.toLowerCase();

        InputStream inStream = getInFileStream(inPath);
        OutputStream outStream = getOutFileStream(outPath);
        if (lowerCaseInPath.endsWith("doc")) {
            converter = new DocToPDFConverter(inStream, outStream, true, true);
        } else if (lowerCaseInPath.endsWith("docx")) {
            converter = new DocxToPDFConverter(inStream, outStream, true, true);
        } else if (lowerCaseInPath.endsWith("ppt")) {
            converter = new PptToPDFConverter(inStream, outStream, true, true);
        } else if (lowerCaseInPath.endsWith("pptx")) {
            converter = new PptxToPDFConverter(inStream, outStream, true, true);
        } else if (lowerCaseInPath.endsWith("odt")) {
            converter = new OdtToPDF(inStream, outStream, true, true);
        } else {
            converter = null;
        }

        return converter;

    }

    //From http://stackoverflow.com/questions/941272/how-do-i-trim-a-file-extension-from-a-string-in-java
    public static String changeExtensionToPDF(String originalPath) {
        String filename = originalPath;

        int extensionIndex = filename.lastIndexOf(".");

        String removedExtension;
        if (extensionIndex == -1) {
            removedExtension = filename;
        } else {
            removedExtension = filename.substring(0, extensionIndex);
        }
        String addPDFExtension = removedExtension + ".pdf";

        return addPDFExtension;
    }


    protected static InputStream getInFileStream(String inputFilePath) throws FileNotFoundException {
        File inFile = new File(inputFilePath);
        FileInputStream iStream = new FileInputStream(inFile);
        return iStream;
    }

    protected static OutputStream getOutFileStream(String outputFilePath) throws IOException {
        File outFile = new File(outputFilePath);

        try {
            //Make all directories up to specified
            outFile.getParentFile().mkdirs();
        } catch (NullPointerException e) {
            //Ignore error since it means not parent directories
        }

        outFile.createNewFile();
        FileOutputStream oStream = new FileOutputStream(outFile);
        return oStream;
    }


}
