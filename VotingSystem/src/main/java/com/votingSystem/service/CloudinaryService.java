package com.votingSystem.service;

import com.cloudinary.utils.ObjectUtils;
import org.springframework.stereotype.Service;
import com.cloudinary.Cloudinary;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.core.env.Environment;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Map;

/**
 * Service class for handling image uploads to Cloudinary.
 * This class manages the conversion of images from MultipartFile format to temporary files,
 * uploading them to Cloudinary, and returning the public ID of the uploaded image.
 *
 * The service also ensures that temporary files are cleaned up after the upload process.
 *
 * @author Anand Raj
 */
@Service
public class CloudinaryService {

    private final Cloudinary cloudinary;

    /**
     * Constructor for CloudinaryService.
     * Initializes the Cloudinary instance using credentials from the application.properties file.
     *
     * @param env The environment object used to access application properties.
     */
    public CloudinaryService(Environment env) {

        // Printing cloudinary details for debugging
//        System.out.println("Cloudinary Name:" + env.getProperty("cloudinary.cloud_name"));
//        System.out.println("Cloudinary ApiKey:" + env.getProperty("cloudinary.api_key"));
//        System.out.println("Cloudinary ApiSecret:" + env.getProperty("cloudinary.api_secret"));

        // Storing Cloudinary credentials in a map
        Map<String, String> credentials = new HashMap<>();
        credentials.put("cloud_name", env.getProperty("cloudinary.cloud_name"));
        credentials.put("api_key", env.getProperty("cloudinary.api_key"));
        credentials.put("api_secret", env.getProperty("cloudinary.api_secret"));

        // Initializing Cloudinary instance with credentials
        cloudinary = new Cloudinary(credentials);
    }

    /**
     * Uploads an image file to Cloudinary and returns the public ID of the uploaded image.
     *
     * @param image The image file to upload.
     * @return The public ID of the uploaded image in Cloudinary.
     * @throws IOException If there is an error during the upload process or file handling.
     */
    public String uploadImage(MultipartFile image) throws IOException {
        // Convert the MultipartFile to a temporary file
        File tempFile = convertToTempFile(image);

        // Upload the image to Cloudinary
        Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());

        // Get the public ID of the uploaded image from Cloudinary
        String publicId = uploadResult.get("public_id").toString();

        // Delete the local temporary file after the image is uploaded
        if (!Files.deleteIfExists(tempFile.toPath())) {
            throw new IOException("Failed to delete file " + tempFile.getAbsolutePath());
        }

        return publicId;
    }

    /**
     * Converts a MultipartFile into a temporary file stored in a custom directory.
     * This file will be used for uploading to Cloudinary.
     *
     * @param image The MultipartFile representing the uploaded image.
     * @return A File object representing the temporary file.
     * @throws IOException If there is an error during the file conversion process.
     */
    private File convertToTempFile(MultipartFile image) throws IOException {
        // Define a custom directory to store the temporary file
        File tempStoreDirectory = new File("src/main/resources/uploadedImages");

        // Create the directory if it doesn't exist
        if (!tempStoreDirectory.exists()) {
            tempStoreDirectory.mkdirs();
        }

        // Create a temporary file in the custom directory
        File tempFile = File.createTempFile("upload-", image.getOriginalFilename(), tempStoreDirectory);

        // Write the image data to the temporary file
        try (FileOutputStream fos = new FileOutputStream(tempFile)) {
            fos.write(image.getBytes());
        }

        return tempFile;
    }
}
