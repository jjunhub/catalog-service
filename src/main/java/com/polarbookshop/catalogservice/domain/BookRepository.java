package com.polarbookshop.catalogservice.domain;

import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

public interface BookRepository extends CrudRepository<Book, Long> {
//    Iterable<Book> findAll(); CrudRepo에 이미 있음
//    Book save(Book book); CrudRepo에 이미 있음
    Optional<Book> findByIsbn(String isbn);
    boolean existsByIsbn(String isbn);

    @Modifying // 데이터베이스 상태를 수정할 연산임을 나타냄.
    @Transactional
    @Query("delete from Book where isbn =:isbn")
    void deleteByIsbn(String isbn);
}
