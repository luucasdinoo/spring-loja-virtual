package com.dino.lojavirtual.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "imagem_produto")
@SequenceGenerator(name = "seq_imagem_produto", sequenceName = "seq_imagem_produto", allocationSize = 1)
public class ImagemProduto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagem_produto")
    private Long id;

    @Column(columnDefinition = "text", length = 2000, name = "imagem_original", nullable = false)
    private String imagem_original;

    @Column(columnDefinition = "text", length = 2000, name = "imagem_miniatura", nullable = false)
    private String imagem_miniatura;

    @ManyToOne(targetEntity = Produto.class)
    @JoinColumn(name = "produto_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.NO_CONSTRAINT, name = "produto_fk"))
    private Produto produto;

    public ImagemProduto() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImagem_original() {
        return imagem_original;
    }

    public void setImagem_original(String imagem_original) {
        this.imagem_original = imagem_original;
    }

    public String getImagem_miniatura() {
        return imagem_miniatura;
    }

    public void setImagem_miniatura(String imagem_miniatura) {
        this.imagem_miniatura = imagem_miniatura;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        ImagemProduto that = (ImagemProduto) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
