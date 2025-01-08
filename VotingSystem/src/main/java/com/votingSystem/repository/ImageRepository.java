package com.votingSystem.repository;

import com.votingSystem.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ImageRepository extends JpaRepository<Image, Integer> {

    Optional<Image> getImageByImageId(int id);

    Image save(Image image);

    List<Image> findAll();

    int deleteImageByImageId(int id);

//    int updateImage(Image image);

    boolean existsImageByImageId(int id);
}
